package vn.javaweb.ComputerShop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.javaweb.ComputerShop.domain.Order;
import vn.javaweb.ComputerShop.domain.OrderDetail;
import vn.javaweb.ComputerShop.repository.OrderDetailRepository;
import vn.javaweb.ComputerShop.repository.OrderRepository;
import vn.javaweb.ComputerShop.service.OrderService;

@Controller
public class OrderController {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderService orderService;

    public OrderController(OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository, OrderService orderService) {

        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrder(Model model) {
        List<Order> orders = this.orderRepository.findAll();

        model.addAttribute("orders", orders);

        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetail(Model model, @PathVariable long id) {

        Order order = this.orderService.getOrderById(id);
        if (order != null) {
            List<OrderDetail> orderDetails = this.orderService.getOrderDetailByOrder(order);

            model.addAttribute("orderDetails", orderDetails);
        }

        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Order orders = this.orderService.getOrderById(id);
        if (orders != null) {
            model.addAttribute("orders", orders);
        }

        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String postUpdateOrderPage(@ModelAttribute("orders") Order orderView) {
        // TODO: process POST request
        Order order = this.orderService.getOrderById(orderView.getId());
        order.setStatus(orderView.getStatus());
        this.orderRepository.save(order);

        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        Order orders = this.orderService.getOrderById(id);
        if (orders != null) {
            model.addAttribute("orders", orders);
        }
        model.addAttribute("id", id);

        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteOrderPage(@ModelAttribute("orders") Order orderView) {

        this.orderService.deleteOrder(orderView.getId());
        return "redirect:/admin/order";
    }

}
