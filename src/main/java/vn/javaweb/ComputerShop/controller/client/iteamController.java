package vn.javaweb.ComputerShop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.Cart;
import vn.javaweb.ComputerShop.domain.CartDetail;
import vn.javaweb.ComputerShop.domain.Order;
import vn.javaweb.ComputerShop.domain.Product;
import vn.javaweb.ComputerShop.domain.User;
import vn.javaweb.ComputerShop.repository.CartDetailRepository;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.service.OrderService;
import vn.javaweb.ComputerShop.service.ProductService;
import vn.javaweb.ComputerShop.service.UserService;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class iteamController {

    private final ProductService productService;
    private final UserService userService;
    private final OrderService orderService;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;

    public iteamController(ProductService productService, UserService userService, OrderService orderService,
            CartRepository cartRepository, CartDetailRepository cartDetailRepository) {
        this.productService = productService;
        this.userService = userService;
        this.orderService = orderService;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id, HttpServletRequest request) {
        Product oneProduct = this.productService.getOnlyOneProduct(id);
        model.addAttribute("product", oneProduct);
        model.addAttribute("id", id);

        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        long productId = id;
        String email = (String) session.getAttribute("email");

        this.productService.handleAddProductToCart(email, productId, session, 1);

        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.getCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartDetailId = id;
        this.productService.handleRemoveCartDetail(cartDetailId, session);
        return "redirect:/cart";
    }

    @PostMapping("/confirm-checkout")
    public String postConfirmCheckout(@ModelAttribute("cart") Cart cart) {

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        this.productService.handleConfirmCheckout(cartDetails);

        return "redirect:/checkout";
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User currentUser = this.userService.getUserByEmail((String) session.getAttribute("email"));
        Cart cart = this.productService.getCartByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice = totalPrice + cd.getQuantity() * cd.getPrice();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {
        HttpSession session = request.getSession(false);

        User user = this.userService.getUserByEmail((String) session.getAttribute("email"));
        if (user != null) {
            this.orderService.handlePlaceOrder(user, session, receiverName, receiverAddress, receiverPhone);
        }

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage() {

        return "client/cart/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = this.userService.getUserByEmail((String) session.getAttribute("email"));

        List<Order> orders = this.orderService.getOrderByUser(user);

        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/product/" + id;
    }

}
