package vn.javaweb.ComputerShop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.entity.*;
import vn.javaweb.ComputerShop.domain.entity.OrderDetailEntity;
import vn.javaweb.ComputerShop.repository.CartDetailRepository;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.repository.OrderDetailRepository;
import vn.javaweb.ComputerShop.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository,
            CartRepository cartRepository, CartDetailRepository cartDetailRepository) {
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
    }

    public OrderEntity getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public List<OrderEntity> getOrderByUser(UserEntity user) {
        return this.orderRepository.findByUser(user);
    }

    public List<OrderDetailEntity> getOrderDetailByOrder(OrderEntity order) {
        return this.orderDetailRepository.findByOrder(order);
    }

    public void deleteOrder(long id) {

        OrderEntity order = this.getOrderById(id);
        List<OrderDetailEntity> orderDetails = this.getOrderDetailByOrder(order);
        for (OrderDetailEntity orderDetail : orderDetails) {
            this.orderDetailRepository.deleteById(orderDetail.getId());
        }
        this.orderRepository.deleteById(id);
    }

    public void handlePlaceOrder(
            UserEntity user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone) {

        // create order
        OrderEntity order = new OrderEntity();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setStatus("PENDING");
        order = this.orderRepository.save(order);
        double totalPrice = 0;
        // create orderDetail

        // step 1: get cart by user
        CartEntity cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetailEntity> cartDetails = cart.getCartDetails();

            if (cartDetails != null) {
                for (CartDetailEntity cd : cartDetails) {
                    OrderDetailEntity orderDetail = new OrderDetailEntity();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice() * cd.getQuantity());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);
                }

                // step 2: delete cart_detail and cart
                for (CartDetailEntity cd : cartDetails) {
                    totalPrice = totalPrice + cd.getQuantity() * cd.getPrice();
                    this.cartDetailRepository.deleteById(cd.getId());

                }

                this.cartRepository.deleteById(cart.getId());

                // step 3 : update session
                session.setAttribute("sum", 0);
            }

            order.setTotalPrice(totalPrice);
        }

    }
}
