package vn.javaweb.ComputerShop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.javaweb.ComputerShop.domain.entity.OrderEntity;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.repository.OrderRepository;
import vn.javaweb.ComputerShop.repository.ProductRepository;
import vn.javaweb.ComputerShop.repository.UserRepository;

@Controller
public class DashboardController {

    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public DashboardController(UserRepository userRepository, ProductRepository productRepository,
            OrderRepository orderRepository) {
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {

        List<UserEntity> users = this.userRepository.findAll();
        List<ProductEntity> products = this.productRepository.findAll();
        List<OrderEntity> orders = this.orderRepository.findAll();

        int coutIdUser = users.size();
        int coutIdProduct = products.size();
        int coutIdOrder = orders.size();

        model.addAttribute("coutIdUser", coutIdUser);
        model.addAttribute("coutIdProduct", coutIdProduct);
        model.addAttribute("coutIdOrder", coutIdOrder);

        return "admin/dashboard/show";
    }

}
