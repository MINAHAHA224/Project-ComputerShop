package vn.javaweb.ComputerShop.service.payment;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import reactor.core.publisher.Mono;
import vn.javaweb.ComputerShop.domain.dto.request.momo.*;
import vn.javaweb.ComputerShop.domain.entity.OrderDetailEntity;
import vn.javaweb.ComputerShop.domain.entity.OrderEntity;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Service
@RequiredArgsConstructor
public class MomoService {
    @Value("${momo.partner-code}")
    private String PARTNER_CODE;

    @Value("${momo.access-key}")
    private String ACCESS_KEY;

    @Value("${momo.secret-key}")
    private String SECRET_KEY;

    @Value("${momo.return-url}")
    private String REDIRECT_URL;

    @Value("${momo.ipn-url}")
    private String IPN_URL;

    @Value("${momo.request-type}")
    private String REQUEST_TYPE; // Ví dụ: "captureWallet" hoặc "payWithMethod"

    // Sửa hàm này, có thể trả về MomoRpDTO hoặc payUrl
    public MomoRpDTO generateMomoPayment(OrderEntity order) { // Hoặc String nếu chỉ trả về payUrl

        String requestId = UUID.randomUUID().toString();
        String orderId = String.valueOf(order.getId()); // ID đơn hàng của bạn
        Long amount = (long) order.getTotalPrice();
        String orderInfo = "Thanh toan don hang LaptopShop " + orderId;
        String extraData = ""; // Để trống nếu không có, hoặc là một JSON string hợp lệ
        // Ví dụ: "{\"customerName\":\"Nguyen Van A\", \"loyaltyCode\":\"123\"}"
        // Quan trọng: Nếu extraData là JSON, nó không được đưa vào rawSignature string.
        // Nếu nó là một chuỗi đơn giản và cần được sign, thì đưa vào. Kiểm tra tài liệu Momo.
        // Hiện tại, với requestType="captureWallet", extraData thường là chuỗi base64 nếu có.
        // Nếu không dùng, để trống "" và KHÔNG đưa vào rawSignature.

        // 1. Chuẩn bị các tham số để tạo signature
        // Chỉ bao gồm các tham số ở cấp độ gốc của JSON request theo tài liệu Momo
        Map<String, String> signatureParams = new TreeMap<>(); // TreeMap tự động sắp xếp key theo alphabet
        signatureParams.put("accessKey", ACCESS_KEY);
        signatureParams.put("amount", String.valueOf(amount));
         signatureParams.put("extraData", extraData); // CHỈ thêm nếu Momo yêu cầu extraData phải được ký. Thường là KHÔNG.
        signatureParams.put("ipnUrl", IPN_URL);
        signatureParams.put("orderId", orderId);
        signatureParams.put("orderInfo", orderInfo);
        signatureParams.put("partnerCode", PARTNER_CODE);
        signatureParams.put("redirectUrl", REDIRECT_URL);
        signatureParams.put("requestId", requestId);
        signatureParams.put("requestType", REQUEST_TYPE);

        // 2. Tạo chuỗi rawSignature từ các tham số đã sắp xếp
        StringBuilder rawSignatureBuilder = new StringBuilder();
        for (Map.Entry<String, String> entry : signatureParams.entrySet()) {
            if (rawSignatureBuilder.length() > 0) {
                rawSignatureBuilder.append("&");
            }
            rawSignatureBuilder.append(entry.getKey()).append("=").append(entry.getValue());
        }
        String rawSignature = rawSignatureBuilder.toString();
        System.out.println("Momo Raw Signature String: " + rawSignature); // Log để debug

        String generatedSignature = "";
        try {
            generatedSignature = signHmacSHA256(rawSignature, SECRET_KEY);
            System.out.println("Momo Generated Signature: " + generatedSignature); // Log để debug
        } catch (Exception e) {
            System.err.println("Lỗi khi tạo Momo signature: " + e.getMessage());
            e.printStackTrace();
            // Xử lý lỗi, có thể throw exception hoặc trả về null
            return null;
        }

        // 3. Chuẩn bị request body (MomoRqDTO)
        // KHÔNG bao gồm items, userInfo, deliveryInfo nếu requestType="captureWallet" phiên bản cũ
        // hoặc nếu chúng không được yêu cầu cho requestType của bạn. Kiểm tra tài liệu!
        // Nếu requestType của bạn yêu cầu (ví dụ, các API mới hơn hoặc payWithMethod), thì thêm vào.
        MomoRqDTO.MomoRqDTOBuilder momoRequestBuilder = MomoRqDTO.builder()
                .partnerCode(PARTNER_CODE)
                .requestId(requestId)
                .amount(amount)
                .orderId(orderId)
                .orderInfo(orderInfo)
                .redirectUrl(REDIRECT_URL)
                .ipnUrl(IPN_URL)
                .requestType(REQUEST_TYPE)
                .extraData(extraData) // Gửi extraData trong body
                .lang("vi")
                .signature(generatedSignature);

        // Ví dụ: Nếu requestType="payWithMethod" hoặc API mới có hỗ trợ, bạn có thể thêm items
//         if ("payWithMethod".equals(REQUEST_TYPE) || "someOtherTypeRequiringItems".equals(REQUEST_TYPE)) {
//             List<ItemsMomoDTO> items = new ArrayList<>();
//             for(OrderDetailEntity orderDetail :  order.getOrderDetails()){
//                 ItemsMomoDTO item = new ItemsMomoDTO();
//                 item.setId(String.valueOf(orderDetail.getProduct().getId())); // Cần ID sản phẩm
//                 item.setName(orderDetail.getProduct().getName());
//                 item.setPrice(orderDetail.getProduct().getPrice().longValue()); // Đơn giá
//                 item.setQuantity((int) orderDetail.getQuantity());
//                 item.setTotalPrice((long)orderDetail.getPrice()); // Thành tiền cho item này
//                 items.add(item);
//             }
//             momoRequestBuilder.items(items);
//         }

        MomoRqDTO momoRequest = momoRequestBuilder.build();

        // 4. Gọi API Momo
        WebClient webClient = WebClient.builder()
                .baseUrl("https://test-payment.momo.vn") // URL môi trường test
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();

        try {
            System.out.println("Sending to Momo: " + momoRequest.toString()); // Log request body
            MomoRpDTO response = webClient.post()
                    .uri("/v2/gateway/api/create")
                    .bodyValue(momoRequest)
                    .retrieve()
                    .onStatus(
                            // SỬA Ở ĐÂY: Sử dụng lambda để kiểm tra statusCode
                            httpStatus -> httpStatus.is4xxClientError() || httpStatus.is5xxServerError(),
                            clientResponse -> // Lambda này sẽ được gọi nếu điều kiện trên là true
                                    clientResponse.bodyToMono(String.class)
                                            .flatMap(errorBody -> {
                                                System.err.println("Momo API Error Response Status: " + clientResponse.statusCode());
                                                System.err.println("Momo API Error Response Body: " + errorBody);
                                                // Tạo WebClientResponseException với các thông tin cần thiết
                                                // Bạn có thể cần điều chỉnh constructor của WebClientResponseException
                                                // tùy thuộc vào phiên bản Spring Webflux của bạn.
                                                // Constructor này thường mong đợi message, statusCode, statusText, headers, responseBodyAsBytes, charset
                                                byte[] responseBodyBytes = errorBody != null ? errorBody.getBytes(StandardCharsets.UTF_8) : null;
                                                return Mono.error(WebClientResponseException.create(
                                                        clientResponse.statusCode().value(), // int statusCode
                                                        clientResponse.statusCode().toString(), // String statusText (hoặc lấy từ HttpStatus)
                                                        clientResponse.headers().asHttpHeaders(), // HttpHeaders
                                                        responseBodyBytes, // byte[] responseBody
                                                        StandardCharsets.UTF_8, // Charset
                                                        clientResponse.request() // HttpRequest (có thể null nếu không có)
                                                ));
                                            })
                    )
                    .bodyToMono(MomoRpDTO.class)
                    .block(); // Đồng bộ hóa

            if (response != null && response.getResultCode() == 0) {
                System.out.println("Momo Pay URL: " + response.getPayUrl());
            } else if (response != null) {
                System.err.println("Momo payment creation failed with result code: " + response.getResultCode() + " - Message: " + response.getMessage());
            }
            return response;

        } catch (WebClientResponseException e) {
            // Lỗi đã được log ở onStatus, ở đây có thể làm thêm nếu cần
            System.err.println("Caught WebClientResponseException in outer catch block. Status: " + e.getStatusCode() + ", Body: " + e.getResponseBodyAsString());
            return null; // Hoặc throw exception
        } catch (Exception e) { // Bắt các lỗi khác không phải WebClientResponseException
            System.err.println("Lỗi không xác định khi gọi Momo API: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

    }

    public String signHmacSHA256(String data, String key) throws Exception {
        Mac hmacSHA256 = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        hmacSHA256.init(secretKey);
        byte[] hash = hmacSHA256.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1)
                hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
