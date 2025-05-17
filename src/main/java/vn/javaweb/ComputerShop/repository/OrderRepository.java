package vn.javaweb.ComputerShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.entity.OrderEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Long> {

    OrderEntity findById(long id);

    List<OrderEntity> findByUser(UserEntity user);
}
