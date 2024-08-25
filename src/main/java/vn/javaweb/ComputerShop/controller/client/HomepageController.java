package vn.javaweb.ComputerShop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.Cart;
import vn.javaweb.ComputerShop.domain.Product;
import vn.javaweb.ComputerShop.domain.User;
import vn.javaweb.ComputerShop.domain.dto.ProductCriteriaDTO;
import vn.javaweb.ComputerShop.service.ProductService;
import vn.javaweb.ComputerShop.service.UserService;

@Controller
public class HomepageController {
    private final ProductService productService;
    private final UserService userService;

    public HomepageController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/")
    public String getHomepage(Model model, HttpServletRequest request) {
        Pageable pageable = PageRequest.of(0, 10);

        Page<Product> pageProducts = this.productService.getAllProduct(pageable);

        List<Product> allProduct = pageProducts.getContent();
        model.addAttribute("products", allProduct);

        HttpSession session = request.getSession(false);

        User user = this.userService.getUserByEmail((String) session.getAttribute("email"));
        Cart cart = this.productService.getCartByUser(user);
        if (cart == null) {
            Cart newCart = new Cart();
            int sum = 0;
            newCart.setSum(sum);

            session.setAttribute("sum", newCart.getSum());

        } else {
            Cart newCart = new Cart();
            session.setAttribute("sum", newCart.getSum());
        }
        return "client/Homepage/show";
    }

    @GetMapping("/accessDeny")
    public String getAccessdenyPage() {

        return "client/auth/deny";
    }

    @GetMapping("/products")
    public String getProductsPage(Model model, ProductCriteriaDTO productCriteriaDTO, HttpServletRequest request) {
        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            } else {
                page = 1;
            }
        } catch (Exception e) {
            page = 1;
        }
        Pageable pageable = PageRequest.of(page - 1, 6);
        Page<Product> prs = this.productService.fetchProductsWithSpec(pageable, productCriteriaDTO);

        List<Product> products = prs.getContent().size() > 0 ? prs.getContent()
                : new ArrayList<Product>();

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + page, "");
        }
        model.addAttribute("queryString", qs);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

        return "client/product/show";
    }

}
