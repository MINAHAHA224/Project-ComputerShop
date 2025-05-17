package vn.javaweb.ComputerShop.domain.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.validation.annotation.Validated;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Validated
public class LoginDTO {
    @NotBlank(message = "Email không được để trống.")
    @Email(message = "Email không đúng định dạng.")
    @Pattern(
            regexp = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$",
            message = "Email phải có dạng @<subdomain>.<domain>."
    )
    private String email;

    @NotBlank(message = "Mật khẩu không được để trống.")
    @Size(min = 6, max = 20, message = "Mật khẩu phải từ 6 đến 20 ký tự.")
    private String password;
}
