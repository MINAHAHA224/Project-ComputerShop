package vn.javaweb.ComputerShop.service;

import java.util.ArrayList;
import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;
import vn.javaweb.ComputerShop.domain.dto.request.InfoOrderRqDTO;
import vn.javaweb.ComputerShop.domain.dto.response.OrderDetailRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.OrderRpDTO;
import vn.javaweb.ComputerShop.domain.entity.*;
import vn.javaweb.ComputerShop.domain.entity.OrderDetailEntity;
import vn.javaweb.ComputerShop.repository.*;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final UserRepository userRepository;



    public OrderEntity getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public List<OrderRpDTO> handleGetDataOrderOfUser(HttpSession session) {
        List<OrderRpDTO> listResult = new ArrayList<>();
        String email = (String) session.getAttribute("email");
        UserEntity user = this.userRepository.findUserEntityByEmail(email).get();
       List<OrderEntity>  listOrder = user.getOrders();

       for ( OrderEntity order : listOrder){
           OrderRpDTO result = new OrderRpDTO();
           result.setId(order.getId());
           result.setTotalPrice(order.getTotalPrice());
           result.setStatus(order.getStatus());

           List<OrderDetailRpDTO> listOrderDetailRp = new ArrayList<>();
           for ( OrderDetailEntity orderDetailEntity : order.getOrderDetails()){
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


}
