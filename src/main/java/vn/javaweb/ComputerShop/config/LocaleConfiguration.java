package vn.javaweb.ComputerShop.config;


import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;
import org.springframework.web.servlet.LocaleResolver; // Quan trọng: import interface
import org.springframework.web.servlet.i18n.SessionLocaleResolver; // Import

import java.util.Locale;

@Slf4j
@Configuration
public class LocaleConfiguration {

    @Bean
    public LocaleResolver localeResolver() { // Kiểu trả về là LocaleResolver
        log.info(">>>>>>>>>> Creating SessionLocaleResolver bean in LocaleConfiguration! <<<<<<<<<<");
        SessionLocaleResolver slr = new SessionLocaleResolver();
        slr.setDefaultLocale(new Locale("vi", "VN")); // Hoặc Locale.US, new Locale("en", "US")
        // Nếu muốn, bạn có thể đặt tên cho session attribute:
         slr.setLocaleAttributeName("session_locale");
        return slr;
    }


}
