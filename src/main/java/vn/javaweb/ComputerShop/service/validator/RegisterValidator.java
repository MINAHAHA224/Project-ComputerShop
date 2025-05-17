package vn.javaweb.ComputerShop.service.validator;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.util.StringUtils;
import vn.javaweb.ComputerShop.domain.dto.request.RegisterDTO;
import vn.javaweb.ComputerShop.repository.UserRepository;


import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserRepository userRepository;
    private static final String EMAIL_REGEX = "^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,}$";

    @Override
    public boolean isValid(RegisterDTO registerDTO, ConstraintValidatorContext context) {

        if (!StringUtils.hasText(registerDTO.getFirstName())) {
            context.buildConstraintViolationWithTemplate("Họ không được để trống")
                    .addPropertyNode("firstName")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        if (!StringUtils.hasText(registerDTO.getLastName())) {
            context.buildConstraintViolationWithTemplate("Tên không được để trống")
                    .addPropertyNode("lastName")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        if (!StringUtils.hasText(registerDTO.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email không được để trống")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }




        if (!Pattern.matches(EMAIL_REGEX, registerDTO.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email phải có dạng @<subdomain>.<domain>.")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        try {
            if (this.userRepository.existsUserEntityByEmail(registerDTO.getEmail())) {
                context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                        .addPropertyNode("email")
                        .addConstraintViolation()
                        .disableDefaultConstraintViolation();
                return false;
            }
        } catch (Exception e) {
            context.buildConstraintViolationWithTemplate("Có lỗi xảy ra khi kiểm tra email.")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        if (registerDTO.getPassword().length() < 6 || registerDTO.getPassword().length() > 20 ||
                registerDTO.getConfirmPassword().length() < 6 || registerDTO.getConfirmPassword().length() > 20) {
            context.buildConstraintViolationWithTemplate("Mật khẩu và xác nhận mật khẩu phải từ 6 đến 20 ký tự.")
                    .addPropertyNode("password")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Mật khẩu không khớp.")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        return true;
    }
}
