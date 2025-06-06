package vn.javaweb.ComputerShop.service;

import java.util.ArrayList;
import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;
import vn.javaweb.ComputerShop.component.MailerComponent;
import vn.javaweb.ComputerShop.domain.dto.request.OrderUpdateRqDTO;
import vn.javaweb.ComputerShop.domain.dto.request.momo.MomoRpDTO;
import vn.javaweb.ComputerShop.domain.dto.request.momo.MomoRpRedirectDTO;
import vn.javaweb.ComputerShop.domain.dto.response.OrderDetailRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.OrderRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
import vn.javaweb.ComputerShop.domain.entity.*;
import vn.javaweb.ComputerShop.domain.entity.OrderDetailEntity;
import vn.javaweb.ComputerShop.domain.enums.CartStatus;
import vn.javaweb.ComputerShop.domain.enums.PaymentStatus;
import vn.javaweb.ComputerShop.repository.*;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final CartRepository cartRepository;
    private final MailerComponent mailerComponent;


    public List<OrderRpDTO> handleGetDataOrderOfUser(HttpSession session) {
        List<OrderRpDTO> listResult = new ArrayList<>();
        String email = (String) session.getAttribute("email");
        UserEntity user = this.userRepository.findUserEntityByEmail(email).get();
        List<OrderEntity> listOrder = user.getOrders();

        for (OrderEntity order : listOrder) {
            OrderRpDTO result = new OrderRpDTO();
            result.setId(order.getId());
            result.setTotalPrice(order.getTotalPrice());
            result.setStatus(order.getStatus());
            result.setTime(order.getTime());
            List<OrderDetailRpDTO> listOrderDetailRp = new ArrayList<>();
            for (OrderDetailEntity orderDetailEntity : order.getOrderDetails()) {
                OrderDetailRpDTO orderDetailRpDTO = new OrderDetailRpDTO();
                orderDetailRpDTO.setProductId(orderDetailEntity.getProduct().getId());
                orderDetailRpDTO.setProductName(orderDetailEntity.getProduct().getName());
                orderDetailRpDTO.setProductImage(orderDetailEntity.getProduct().getImage());
                orderDetailRpDTO.setProductQuantity(orderDetailEntity.getQuantity());
                orderDetailRpDTO.setPrice(orderDetailEntity.getPrice());
                listOrderDetailRp.add(orderDetailRpDTO);
            }
            result.setOrderDetails(listOrderDetailRp);
            listResult.add(result);
        }

        return listResult;
    }

    public List<OrderRpDTO> handleGetOrderAd() {
        List<OrderRpDTO> listResult = new ArrayList<>();
        List<OrderEntity> listEntity = this.orderRepository.findAll();
        for (OrderEntity entity : listEntity) {
            OrderRpDTO result = new OrderRpDTO();
            result.setId(entity.getId());
            result.setNameUser(entity.getReceiverName());
            result.setTotalPrice(entity.getTotalPrice());
            result.setStatus(entity.getStatus());
            result.setTime(entity.getTime());
            result.setTypePayment(entity.getTypePayment());
            result.setStatusPayment(entity.getStatusPayment());


            listResult.add(result);
        }
        return listResult;
    }

    public OrderRpDTO handeGetOrderDetailAd(Long id) {
        OrderRpDTO order = new OrderRpDTO();
        List<OrderDetailRpDTO> listResult = new ArrayList<>();
        OrderEntity orderEntity = this.orderRepository.findOrderEntityById(id);
        List<OrderDetailEntity> listEntity = orderEntity.getOrderDetails();

        for (OrderDetailEntity entity : listEntity) {
            OrderDetailRpDTO result = new OrderDetailRpDTO();
            result.setProductId(entity.getId());
            result.setProductName(entity.getProduct().getName());
            result.setProductImage(entity.getProduct().getImage());
            result.setPrice(entity.getPrice());
            result.setProductQuantity(entity.getQuantity());
            listResult.add(result);
        }
        order.setId(orderEntity.getId());
        order.setTime(orderEntity.getTime());
        order.setTotalPrice(orderEntity.getTotalPrice());
        order.setStatus(orderEntity.getStatus());
        order.setStatusPayment(orderEntity.getStatusPayment());
        order.setNameUser(orderEntity.getUser().getFullName());
        order.setEmailUser(orderEntity.getUser().getEmail());
        order.setReceiverName(orderEntity.getReceiverName());
        order.setReceiverPhone(orderEntity.getReceiverPhone());
        order.setReceiverAddress(orderEntity.getReceiverAddress());

        order.setOrderDetails(listResult);
        return order;
    }

    public OrderUpdateRqDTO handleGetOrderRqAd(Long id) {
        OrderEntity order = this.orderRepository.findOrderEntityById(id);
        OrderUpdateRqDTO result = new OrderUpdateRqDTO();
        result.setId(order.getId());
        result.setStatus(order.getStatus());
        result.setTotalPrice(order.getTotalPrice());
        result.setTypePayment(order.getTypePayment());
        result.setStatusPayment(order.getStatusPayment());
        result.setReceiverPhone(order.getReceiverPhone());
        result.setReceiverName(order.getReceiverName());
        result.setReceiverAddress(order.getReceiverAddress());

        return result;
    }

    @Transactional
    public ResponseBodyDTO handleUpdateOrderRqAd(OrderUpdateRqDTO orderUpdateRqDTO) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        OrderEntity order = this.orderRepository.findOrderEntityById(orderUpdateRqDTO.getId());
        order.setStatus(orderUpdateRqDTO.getStatus());
        order.setReceiverName(orderUpdateRqDTO.getReceiverName());
        order.setReceiverPhone(orderUpdateRqDTO.getReceiverPhone());
        order.setReceiverAddress(orderUpdateRqDTO.getReceiverAddress());
        order.setStatusPayment(orderUpdateRqDTO.getStatusPayment());
        this.orderRepository.save(order);

        response.setStatus(200);
        response.setMessage("Admin : Cập nhật trạng đơn đặt hàng thành công");
        return response;
    }

    @Transactional
    public ResponseBodyDTO handleDeleteOrder(Long id) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        this.orderRepository.deleteOrderEntityById(id);
        response.setStatus(200);
        response.setMessage("Admin : Xóa đơn hàng thành công");
        return response;
    }


    @Transactional
    public ResponseBodyDTO handleCompleteOrderPaymentOnline(MomoRpDTO momoRpDTO) {
        ResponseBodyDTO response = new ResponseBodyDTO();

        String prefixOrderId = momoRpDTO.getOrderId().substring(0, 2);
        Long orderId = Long.valueOf(prefixOrderId);
        OrderEntity orderEntity = this.orderRepository.findOrderEntityById(orderId);
        if (momoRpDTO.getResultCode() != 1006) {

            UserEntity user = orderEntity.getUser();
            CartEntity cart = this.cartRepository.findCartEntityByUserAndStatus(user, CartStatus.ACTIVE.toString()).get();
            cart.setStatus(CartStatus.ORDERED.toString());
            this.cartRepository.save(cart);
            orderEntity.setStatusPayment(PaymentStatus.PAID.toString());
            this.orderRepository.save(orderEntity);

            response.setStatus(200);
            response.setMessage(momoRpDTO.getMessage());

            // send mail invoice
            mailerComponent.sendInvoiceEmail(orderEntity);
        } else {
            this.orderRepository.deleteOrderEntityById(orderEntity.getId());
            response.setStatus(500);
            response.setMessage(momoRpDTO.getMessage());

        }


        return response;
    }


}
