package vn.javaweb.ComputerShop.service.validator;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

@Constraint(validatedBy = ResetPasswordValidator.class)
@Target({ ElementType.TYPE }) // Adjusted to apply to the class level
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ResetPasswordChecked {
    String message() default "Vui lòng điền đầy đủ thông tin";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
