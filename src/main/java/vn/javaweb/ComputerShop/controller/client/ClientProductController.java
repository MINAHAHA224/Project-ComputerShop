package vn.javaweb.ComputerShop.controller.client;

import java.util.List;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.javaweb.ComputerShop.domain.dto.request.CartDetailsListDTO;
import vn.javaweb.ComputerShop.domain.dto.request.InfoOrderRqDTO;
import vn.javaweb.ComputerShop.domain.dto.request.momo.MomoRpDTO;
import vn.javaweb.ComputerShop.domain.dto.request.momo.MomoRpRedirectDTO;
import vn.javaweb.ComputerShop.domain.dto.response.*;
import vn.javaweb.ComputerShop.domain.entity.OrderEntity;
import vn.javaweb.ComputerShop.service.CartService;
import vn.javaweb.ComputerShop.service.OrderService;
import vn.javaweb.ComputerShop.service.ProductService;

import vn.javaweb.ComputerShop.service.payment.MomoService;

@Controller
@RequiredArgsConstructor
public class ClientProductController {

    private final CartService cartService;
    private final ProductService productService;
    private final OrderService orderService;
    private final MomoService momoService;




    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable Long id) {
        ProductDetailRpDTO productDetail = this.productService.handleGetProductDetail(id);
        model.addAttribute("product", productDetail);
        model.addAttribute("stockQuantity",productDetail.getQuantity());
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable("id") Long productId
            , HttpSession session , Model model ) {
        ResponseBodyDTO responseBodyDTO = this.cartService.handleAddOneProductToCart(session , productId);
        model.addAttribute("messageSuccess" ,responseBodyDTO.getMessage() );
        return "redirect:/home";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpSession  session) {
        CartRpDTO result = this.cartService.handleGetCartDetail(session);
        model.addAttribute("cartDetails", result.getCartDetails());
        model.addAttribute("totalPrice", result.getTotalPrice());

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable("id") Long id, HttpSession session ,Model model) {
        ResponseBodyDTO result = this.cartService.handleDeleteProductInCart(id , session);
        model.addAttribute("messageSuccess" ,result.getMessage() );
        return "client/cart/show";
    }

    @PostMapping("/confirm-checkout")
    public String postConfirmCheckout(Model  model
            ,@ModelAttribute("cartDetailsListDTO") CartDetailsListDTO cartDetailsListDTO , HttpSession session) {
        ResponseBodyDTO response=  this.productService.handleConfirmCheckout(cartDetailsListDTO);
        model.addAttribute("messageSuccess" , response.getMessage());

        CheckoutRpDTO result = this.cartService.handleShowDataAfterCheckout(session);
        model.addAttribute("cartDetails", result.getCartDetails());
        model.addAttribute("totalPrice", result.getTotalPrice());
        model.addAttribute("infoOrderRqDTO" , result.getInfoOrderRqDTO());
        return "client/cart/checkout";
    }



    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpSession session, Model model,
                                   @Valid @ModelAttribute("infoOrderRqDTO")InfoOrderRqDTO infoOrderRqDTO ,
                                   BindingResult bindingResult , RedirectAttributes redirectAttributes) {

        List<FieldError> errors = bindingResult.getFieldErrors();

        if ( bindingResult.hasErrors()){
            for ( FieldError error : errors){
                System.out.println("--ER " + error.getField() +" -- " + error.getDefaultMessage());
            }
            CheckoutRpDTO result = this.cartService.handleShowDataAfterCheckout(session);
            model.addAttribute("cartDetails", result.getCartDetails());
            model.addAttribute("totalPrice", result.getTotalPrice());
            model.addAttribute("infoOrderRqDTO" , infoOrderRqDTO);
            return "client/cart/checkout";
        }


        String methodPayment = infoOrderRqDTO.getPaymentMethod();
        ResponseBodyDTO orderCreationResponse = this.cartService.handleCreateOrder(session, infoOrderRqDTO);

        if (orderCreationResponse.getStatus() != 200 || orderCreationResponse.getData() == null || !(orderCreationResponse.getData() instanceof OrderEntity)) {
            model.addAttribute("messageError", "Không thể tạo đơn hàng. " + orderCreationResponse.getMessage());
            // Lấy lại dữ liệu cho trang checkout nếu cần
            CheckoutRpDTO result = this.cartService.handleShowDataAfterCheckout(session);
            model.addAttribute("cartDetails", result.getCartDetails());
            model.addAttribute("totalPrice", result.getTotalPrice());
            return "client/cart/checkout";
        }

        OrderEntity createdOrder = (OrderEntity) orderCreationResponse.getData();

        if ("MOMO".equalsIgnoreCase(methodPayment)) {
            MomoRpDTO momoResponse = this.momoService.generateMomoPayment(createdOrder);
            if (momoResponse != null && momoResponse.getPayUrl() != null && momoResponse.getResultCode() == 0) {
                // Chuyển hướng người dùng đến payUrl của Momo
                return "redirect:" + momoResponse.getPayUrl();
            } else {
                String errorMessage = "Khởi tạo thanh toán Momo thất bại.";
                if (momoResponse != null) {
                    errorMessage += " Lỗi: " + momoResponse.getMessage() + " (Code: " + momoResponse.getResultCode() + ")";
                }
                // model.addAttribute("messageError", errorMessage);
                // return "client/cart/thanks"; // Hoặc quay lại trang checkout với thông báo lỗi
                redirectAttributes.addFlashAttribute("messageError", errorMessage);
                return "redirect:/checkout"; // Quay lại trang checkout
            }
        } else if ("COD".equalsIgnoreCase(methodPayment)) {
            // Xử lý COD
            model.addAttribute("messageSuccess", "Đặt hàng COD thành công!");
            // Gửi email hóa đơn nếu cần
            // mailerComponent.sendInvoiceEmail(createdOrder);
            session.setAttribute("latestOrderId", createdOrder.getId()); // Cho trang thanks
            return "redirect:/order/thanks"; // Chuyển đến trang cảm ơn
        } else {
            // Các phương thức thanh toán khác
            model.addAttribute("messageError", "Phương thức thanh toán không được hỗ trợ.");
            return "client/cart/checkout";
        }



    }



    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model , HttpSession session) {

        List<OrderRpDTO> orders = this.orderService.handleGetDataOrderOfUser(session);

        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") Long id,
            @RequestParam("quantity") Long quantity,
            HttpSession session , Model model) {

      ResponseBodyDTO response =  this.cartService.handleAddProductDetailToCart( id, session, quantity);
        model.addAttribute("messageSuccess" , response.getMessage());
        return "client/cart/show";
    }


    @GetMapping(value = "/thankyou")
    public String getThanksPage (MomoRpDTO momoRpDTO ,
                                 Model model , RedirectAttributes redirectAttributes){
        ResponseBodyDTO response = this.orderService.handleCompleteOrderPaymentOnline (momoRpDTO);

        if ( response.getStatus() == 200){
            model.addAttribute("messageSuccess" , response.getMessage());
            return "client/cart/thanks";
        }else {
            redirectAttributes.addFlashAttribute("messageError" , response.getMessage());
            return "redirect:/cart";
        }

    }

}
