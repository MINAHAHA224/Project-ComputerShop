package vn.javaweb.ComputerShop.component;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mock.web.MockHttpServletRequest; // Quan trọng
import org.springframework.mock.web.MockHttpServletResponse; // Quan trọng
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder; // Quan trọng
import org.springframework.web.context.request.ServletRequestAttributes; // Quan trọng
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Component
@RequiredArgsConstructor
@Slf4j
public class MailerComponent {
    private final JavaMailSender mailSender;
    private final ViewResolver viewResolver; // Đảm bảo ViewResolver này được cấu hình đúng

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final SecureRandom RANDOM = new SecureRandom();

    @Value("${spring.mail.from}")
    private String emailFrom;

    public boolean sendConfirmLink(String emailTo , String OTP) {
        log.info("Sending confirming link to user, email={}", emailTo);

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper;

        try {
            helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED, StandardCharsets.UTF_8.name());

            // Gán dữ liệu vào model
            Map<String, Object> model = new HashMap<>();

            model.put("OTP", OTP); // Key này phải khớp với ${OTP} trong JSP

            // --- Phần render JSP thành String ---
            String htmlContent;
            try {
                // Cố gắng lấy request hiện tại nếu có, hoặc tạo mock request
                HttpServletRequest request = getCurrentRequest();
                if (request == null) {
                    request = new MockHttpServletRequest();
                    // Bạn có thể cần set một số attribute mặc định cho request ở đây nếu JSP của bạn cần
                    // request.setAttribute("someAttribute", "someValue");
                }

                MockHttpServletResponse mockResponse = new MockHttpServletResponse();

                View view = viewResolver.resolveViewName("client/auth/confirmEmail", Locale.getDefault());
                if (view == null) {
                    log.error("Không thể resolve view: client/auth/confirmEmail");
                    return false;
                }

                view.render(model, request, mockResponse); // Truyền request và mockResponse
                htmlContent = mockResponse.getContentAsString();

                if (htmlContent == null || htmlContent.isEmpty()) {
                    log.warn("Rendered HTML content is empty for view: client/auth/confirmEmail. Check JSP and model.");
                    // Bạn có thể muốn trả về false hoặc ném một ngoại lệ ở đây
                }

            } catch (IOException | ServletException e) { // Bắt thêm ServletException
                log.error("Lỗi IO hoặc Servlet khi render JSP: ", e);
                return false;
            } catch (Exception e) { // Bắt các lỗi khác từ view.render
                log.error("Lỗi không xác định khi render JSP: ", e);
                return false;
            }
            // --- Kết thúc phần render JSP ---


            // Cấu hình email
            helper.setFrom(emailFrom, "3tTechShop"); // Tên người gửi tùy chỉnh
            helper.setTo(emailTo);
            helper.setSubject("OTP Xác Nhận Email Đặt Lại Mật Khẩu"); // Tiêu đề rõ ràng hơn
            helper.setText(htmlContent, true); // true để gửi dạng HTML

            mailSender.send(message);
            log.info("Confirming link has sent to user, email={}", emailTo);
            return true;

        } catch (MessagingException | UnsupportedEncodingException e) {
            log.error("Lỗi khi chuẩn bị email: {}", e.getMessage(), e);
            return false;
        } catch (Exception ex) { // Bắt lỗi từ mailSender.send()
            log.error("Error sending mail: {}", ex.getMessage(), ex);
            return false;
        }
    }

    // Helper method để lấy HttpServletRequest hiện tại (nếu có)
    private HttpServletRequest getCurrentRequest() {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attrs != null) {
            return attrs.getRequest();
        }
        return null;
    }

    public  String generateOTP(int length) {
        StringBuilder otp = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            otp.append(CHARACTERS.charAt(RANDOM.nextInt(CHARACTERS.length())));
        }
        return otp.toString();
    }
}