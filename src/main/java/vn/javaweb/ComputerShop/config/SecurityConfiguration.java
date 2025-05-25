package vn.javaweb.ComputerShop.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;
import vn.javaweb.ComputerShop.repository.UserRepository;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
@RequiredArgsConstructor
public class SecurityConfiguration {
    private final UserRepository userRepository;



    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return email -> userRepository.findUserEntityByEmail(email)
                .orElseThrow(() ->
                        new UsernameNotFoundException(
                                "Cannot find user with email = " + email));

    }
    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }


    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration config
    ) throws Exception {
        return config.getAuthenticationManager();
    }


    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD,
                                DispatcherType.INCLUDE)
                        .permitAll()
                        .requestMatchers("/home", "/login", "/register", "/client/**", "/css/**", "/js/**",
                                "/images/**")
                        .permitAll()

                        .requestMatchers("/admin" , "/admin/**").hasRole("ADMIN")

                        .anyRequest().permitAll())
                // khi logout thì xóa luôn cookie
                .sessionManagement((sessionManagement) -> sessionManagement
                        .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                        .invalidSessionUrl("/logout?expired")
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false))
                .logout(logout -> logout.deleteCookies("JSESSIONID").invalidateHttpSession(true));

                // cơ chế remember me
//                .rememberMe(rememberme -> rememberme.rememberMeServices(rememberMeServices()));

//                .formLogin(formLogin -> formLogin
//                        .loginPage("/login")
//                        .failureUrl("/login?error")
//                        // cái này dùng để chuyển trang khi đăng nhập thành công
//                        // tức là đoạn này đã đăng nhập thành công rồi tức là đã có ROLE rồi
//                        // ROLE_USER hay Admin thôi
//                        .successHandler(customSuccessHandler())
//                        .permitAll())
//                // nếu mà Role_User mà vào trang admin thì nó đẩy ra trang này /accessDeny
//                .exceptionHandling(ex -> ex.accessDeniedPage("/accessDeny"));
        return http.build();
    }

}
