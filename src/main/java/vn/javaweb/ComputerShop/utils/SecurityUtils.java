package vn.javaweb.ComputerShop.utils;

import org.springframework.security.core.context.SecurityContextHolder;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;

public class SecurityUtils {
    public static String getPrincipal() {
        return  ((UserEntity)SecurityContextHolder
                .getContext().getAuthentication().getPrincipal()).getEmail();
    }

}
