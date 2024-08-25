package vn.javaweb.ComputerShop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.User;

@Repository

public interface UserRepository extends JpaRepository<User, Long> {

    User save(User hoidanit);

    List<User> findByEmail(String email);

    List<User> findFirstByEmail(String email);

    User findUserByEmail(String email);

    List<User> findFirstById(long id);

    User findById(long id);

    User findAllById(long id);

    void deleteById(long id);

    List<User> findByEmailAndAddress(String email, String address);

    boolean existsByEmail(String email);

}
