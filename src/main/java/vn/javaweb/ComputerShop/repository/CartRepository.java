package vn.javaweb.ComputerShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.Cart;
import vn.javaweb.ComputerShop.domain.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

    Cart findByUser(User user);

    void deleteCartById(long id);

}
