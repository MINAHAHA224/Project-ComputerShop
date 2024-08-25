package vn.javaweb.ComputerShop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.Cart;
import vn.javaweb.ComputerShop.domain.CartDetail;
import vn.javaweb.ComputerShop.domain.Order;
import vn.javaweb.ComputerShop.domain.OrderDetail;
import vn.javaweb.ComputerShop.domain.User;
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

    public Order getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public List<Order> getOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    public List<OrderDetail> getOrderDetailByOrder(Order order) {
        return this.orderDetailRepository.findByOrder(order);
    }

    public void deleteOrder(long id) {

        Order order = this.getOrderById(id);
        List<OrderDetail> orderDetails = this.getOrderDetailByOrder(order);
        for (OrderDetail orderDetail : orderDetails) {
            this.orderDetailRepository.deleteById(orderDetail.getId());
        }
        this.orderRepository.deleteById(id);
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone) {

        // create order
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setStatus("PENDING");
        order = this.orderRepository.save(order);
        double totalPrice = 0;
        // create orderDetail

        // step 1: get cart by user
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();

            if (cartDetails != null) {
                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice() * cd.getQuantity());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);
                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
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
