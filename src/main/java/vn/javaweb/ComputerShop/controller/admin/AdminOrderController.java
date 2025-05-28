package vn.javaweb.ComputerShop.controller.admin;

import java.util.ArrayList;
import java.util.List;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.javaweb.ComputerShop.domain.dto.request.OrderUpdateRqDTO;
import vn.javaweb.ComputerShop.domain.dto.response.OrderDetailRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.OrderRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
import vn.javaweb.ComputerShop.domain.entity.OrderEntity;
import vn.javaweb.ComputerShop.repository.OrderDetailRepository;
import vn.javaweb.ComputerShop.repository.OrderRepository;
import vn.javaweb.ComputerShop.service.OrderService;

@Controller
@RequiredArgsConstructor
public class AdminOrderController {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderService orderService;



    @GetMapping("/admin/order")
    public String getOrder(Model model) {
        List<OrderRpDTO> orders = this.orderService.handleGetOrderAd();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetail(Model model, @PathVariable long id) {
            List<OrderDetailRpDTO> orderDetails = this.orderService.handeGetOrderDetailAd(id);
            model.addAttribute("orderDetails", orderDetails);
            return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        OrderUpdateRqDTO orders = this.orderService.handleGetOrderRqAd(id);
        model.addAttribute("orders", orders);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String postUpdateOrderPage(Model model
            , @Valid  @ModelAttribute("orders") OrderUpdateRqDTO orderView
            , BindingResult bindingResult , RedirectAttributes redirectAttributes) {
        // TODO: process POST request


        if ( bindingResult.hasErrors()){
            model.addAttribute("orders", orderView);
            return "admin/order/update";
        }

        ResponseBodyDTO response = this.orderService.handleUpdateOrderRqAd(orderView);
        if ( response.getStatus() != 200 ){
            model.addAttribute("orders", orderView);
            model.addAttribute("messageError" ,response.getMessage() );
            return "admin/order/update";
        }else {
            redirectAttributes.addFlashAttribute("messageSuccess" ,response.getMessage() );
            return "redirect:/admin/order";
        }


    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id , RedirectAttributes redirectAttributes) {
        ResponseBodyDTO handleDelete = this.orderService.handleDeleteOrder(id);
        if (handleDelete.getStatus() != 200 ){
            redirectAttributes.addFlashAttribute("messageError" ,handleDelete.getMessage() );

        }else {
            redirectAttributes.addFlashAttribute("messageSuccess" ,handleDelete.getMessage() );
        }
        return "redirect:/admin/order";

    }

}
