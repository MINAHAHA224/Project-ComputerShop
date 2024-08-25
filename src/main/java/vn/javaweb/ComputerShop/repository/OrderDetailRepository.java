package vn.javaweb.ComputerShop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.Order;
import vn.javaweb.ComputerShop.domain.OrderDetail;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    List<OrderDetail> findByOrder(Order order);

    void deleteByOrder(Order order);
}
