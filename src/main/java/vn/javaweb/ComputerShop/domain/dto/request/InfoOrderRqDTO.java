package vn.javaweb.ComputerShop.domain.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.springframework.validation.annotation.Validated;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Validated
public class InfoOrderRqDTO {
    @NotBlank(message = "Tên người nhận không được để trống")
    @Size(max = 100, message = "Tên người nhận không được vượt quá 100 ký tự")
    private String receiverName;

    @NotBlank(message = "Địa chỉ người nhận không được để trống")
    @Size(max = 255, message = "Địa chỉ người nhận không được vượt quá 255 ký tự")
    private String receiverAddress;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^(0\\d{9}|\\+84\\d{9,10})$", message = "Số điện thoại không hợp lệ")
    private String receiverPhone;

    private Double totalPriceToSaveOrder ;

}
