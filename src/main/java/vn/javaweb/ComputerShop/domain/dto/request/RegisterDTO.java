package vn.javaweb.ComputerShop.domain.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import vn.javaweb.ComputerShop.service.validator.RegisterChecked;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@RegisterChecked
public class RegisterDTO {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String confirmPassword;
}
