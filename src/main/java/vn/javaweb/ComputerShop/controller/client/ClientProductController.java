package vn.javaweb.ComputerShop.controller.client;

import java.util.List;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.dto.request.CartDetailsListDTO;
import vn.javaweb.ComputerShop.domain.dto.request.InfoOrderRqDTO;
import vn.javaweb.ComputerShop.domain.dto.response.*;
import vn.javaweb.ComputerShop.service.CartService;
import vn.javaweb.ComputerShop.service.OrderService;
import vn.javaweb.ComputerShop.service.ProductService;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class ClientProductController {

    private final CartService cartService;
    private final ProductService productService;
    private final OrderService orderService;

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable Long id) {
        ProductDetailRpDTO productDetail = this.productService.handleGetProductDetail(id);
        model.addAttribute("product", productDetail);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable("id") Long productId, HttpSession session, Model model) {
        ResponseBodyDTO responseBodyDTO = this.cartService.handleAddOneProductToCart(session, productId);
        model.addAttribute("messageSuccess", responseBodyDTO.getMessage());
        return "redirect:/home";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpSession session) {
        CartRpDTO result = this.cartService.handleGetCartDetail(session);
        model.addAttribute("cartDetails", result.getCartDetails());
        model.addAttribute("totalPrice", result.getTotalPrice());
        model.addAttribute("cartDetailsListDTO", new CartDetailsListDTO());
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable("id") Long id, HttpSession session, Model model) {
        ResponseBodyDTO result = this.cartService.handleDeleteProductInCart(id, session);
        model.addAttribute("messageSuccess", result.getMessage());
        return "client/cart/show";
    }

    @PostMapping("/confirm-checkout")
    public String postConfirmCheckout(Model model,
            @ModelAttribute("cartDetailsListDTO") CartDetailsListDTO cartDetailsListDTO, HttpSession session) {
        ResponseBodyDTO response = this.productService.handleConfirmCheckout(cartDetailsListDTO);
        model.addAttribute("messageSuccess", response.getMessage());

        CheckoutRpDTO result = this.cartService.handleShowDataAfterCheckout(session);
        model.addAttribute("cartDetails", result.getCartDetails());
        model.addAttribute("totalPrice", result.getTotalPrice());
        model.addAttribute("infoOrderRqDTO", result.getInfoOrderRqDTO());
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpSession session, Model model,
            @Valid @ModelAttribute("infoOrderRqDTO") InfoOrderRqDTO infoOrderRqDTO, BindingResult bindingResult) {

        List<FieldError> errors = bindingResult.getFieldErrors();

        if (bindingResult.hasErrors()) {
            for (FieldError error : errors) {
                System.out.println("--ER " + error.getField() + " -- " + error.getDefaultMessage());
            }
            CheckoutRpDTO result = this.cartService.handleShowDataAfterCheckout(session);
            model.addAttribute("cartDetails", result.getCartDetails());
            model.addAttribute("totalPrice", result.getTotalPrice());
            model.addAttribute("infoOrderRqDTO", infoOrderRqDTO);
            return "client/cart/checkout";
        }
        ResponseBodyDTO response = this.cartService.handleCreateOrder(session, infoOrderRqDTO);

        return "client/cart/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpSession session) {

        List<OrderRpDTO> orders = this.orderService.handleGetDataOrderOfUser(session);

        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") Long id,
            @RequestParam("quantity") Long quantity,
            HttpSession session, Model model) {

        ResponseBodyDTO response = this.cartService.handleAddProductDetailToCart(id, session, quantity);
        model.addAttribute("messageSuccess", response.getMessage());
        return "client/cart/show";
    }

}
