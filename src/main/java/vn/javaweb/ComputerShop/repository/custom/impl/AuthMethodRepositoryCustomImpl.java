package vn.javaweb.ComputerShop.repository.custom.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import vn.javaweb.ComputerShop.domain.entity.AuthMethodEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.repository.custom.AuthMethodRepositoryCustom;

import java.time.LocalDateTime;

@Repository
public class AuthMethodRepositoryCustomImpl  implements AuthMethodRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public AuthMethodEntity findAuthMethodToVerifyOtp(UserEntity user, String OTP, LocalDateTime date) {
        Long idUser = user.getId();
        String sql = "";


        return null;
    }
}
