package vn.javaweb.ComputerShop.service;

import java.util.Collections;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
@RequiredArgsConstructor

public class CustomUserDetailsService implements UserDetailsService {
    private final UserService userService;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity user = this.userService.getUserByEmail(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found");

        }
        return new User(
                user.getEmail(),
                user.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName())));

    }

}
