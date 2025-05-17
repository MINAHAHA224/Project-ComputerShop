package vn.javaweb.ComputerShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.entity.CartEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;

@Repository
public interface CartRepository extends JpaRepository<CartEntity, Long> {

    CartEntity findByUser(UserEntity user);

    void deleteCartById(long id);

}
