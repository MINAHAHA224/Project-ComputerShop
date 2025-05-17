package vn.javaweb.ComputerShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.entity.CartDetailEntity;
import vn.javaweb.ComputerShop.domain.entity.CartEntity;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;

import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetailEntity, Long> {

    boolean existsByCartAndProduct(CartEntity cart, ProductEntity product);

    CartDetailEntity findByCartAndProduct(CartEntity cart, ProductEntity product);

    List<CartDetailEntity> findByCart(CartEntity cart);

    CartDetailEntity findByProductId(long id);

    void deleteCDetailById(long id);

    boolean existsByProduct(ProductEntity product);

}