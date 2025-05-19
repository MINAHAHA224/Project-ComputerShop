package vn.javaweb.ComputerShop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vn.javaweb.ComputerShop.domain.dto.request.ResetPasswordDTO;

@Service
@RequiredArgsConstructor
public class ResetPasswordValidator implements ConstraintValidator<ResetPasswordChecked, ResetPasswordDTO> {
    @Override
    public boolean isValid(ResetPasswordDTO resetPasswordDTO, ConstraintValidatorContext context) {
        if (resetPasswordDTO.getPassword().length() < 6 || resetPasswordDTO.getPassword().length() > 20 ||
                resetPasswordDTO.getConfirmPassword().length() < 6 || resetPasswordDTO.getConfirmPassword().length() > 20) {
            context.buildConstraintViolationWithTemplate("Mật khẩu và xác nhận mật khẩu phải từ 6 đến 20 ký tự.")
                    .addPropertyNode("password")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        if (!resetPasswordDTO.getPassword().equals(resetPasswordDTO.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Mật khẩu không khớp.")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        return true;
    }
}
