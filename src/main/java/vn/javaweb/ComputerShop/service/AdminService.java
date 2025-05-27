package vn.javaweb.ComputerShop.service;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vn.javaweb.ComputerShop.domain.dto.response.CountElementDTO;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.repository.OrderRepository;
import vn.javaweb.ComputerShop.repository.ProductRepository;
import vn.javaweb.ComputerShop.repository.UserRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public CountElementDTO handleCountElement ( ){
        CountElementDTO result = new CountElementDTO();
        long countUser = this.userRepository.count();
        long countProduct = this.productRepository.count();
        long countOrder = this.orderRepository.count();

        result.setCountElementUser(countUser);
        result.setCountElementProduct(countProduct);
        result.setCountElementOrder(countOrder);
        return result;

    }
}
