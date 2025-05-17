package vn.javaweb.ComputerShop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.entity.UserEntity;

@Repository

public interface UserRepository extends JpaRepository<UserEntity, Long> {

    UserEntity save(UserEntity hoidanit);

    List<UserEntity> findByEmail(String email);

    List<UserEntity> findFirstByEmail(String email);

   Optional<UserEntity>  findUserEntityByEmail(String email);
   boolean existsUserEntityByEmail ( String email);

    List<UserEntity> findFirstById(long id);

    UserEntity findById(long id);

    UserEntity findAllById(long id);

    void deleteById(long id);

    List<UserEntity> findByEmailAndAddress(String email, String address);

    boolean existsByEmail(String email);

}
