package vn.javaweb.ComputerShop.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.javaweb.ComputerShop.domain.entity.AuthMethodEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.repository.custom.AuthMethodRepositoryCustom;

import java.util.Optional;

@Repository
public interface AuthMethodRepository  extends JpaRepository<AuthMethodEntity , Long>  , AuthMethodRepositoryCustom {

    AuthMethodEntity findAuthMethodEntityByUser (UserEntity user);

    boolean existsAuthMethodEntityByUser (UserEntity user);
}
