package vn.javaweb.ComputerShop.service.validator;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.javaweb.ComputerShop.domain.dto.RegisterDTO;
import vn.javaweb.ComputerShop.service.UserService;

@Service

public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if password fields match
        if (!user.getPassWord().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Passwords nhập lại không khớp")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        } else if (user.getConfirmPassword() == "") {
            context.buildConstraintViolationWithTemplate("confirmPassword không được để trống")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        // Additional validations can be added here
        // check email exist
        if (this.userService.checkEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        } else if (user.getEmail() == "") {
            context.buildConstraintViolationWithTemplate("Email không được để trống")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;

        }
        // check value null firstname , email , password
        if (user.getFirstName() == "") {
            context.buildConstraintViolationWithTemplate("firstName không được để trống")
                    .addPropertyNode("firstName")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (user.getPassWord() == "") {
            context.buildConstraintViolationWithTemplate("Password không được để trống")
                    .addPropertyNode("passWord")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }
        return valid;
    }
}
