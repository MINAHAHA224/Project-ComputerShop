package vn.javaweb.ComputerShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.Cart;
import vn.javaweb.ComputerShop.domain.CartDetail;
import vn.javaweb.ComputerShop.domain.Product;

import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {

    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findByCartAndProduct(Cart cart, Product product);

    List<CartDetail> findByCart(Cart cart);

    CartDetail findByProductId(long id);

    void deleteCDetailById(long id);

    boolean existsByProduct(Product product);

}