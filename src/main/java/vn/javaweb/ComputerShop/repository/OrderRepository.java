package vn.javaweb.ComputerShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.Order;
import vn.javaweb.ComputerShop.domain.User;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    Order findById(long id);

    List<Order> findByUser(User user);
}
