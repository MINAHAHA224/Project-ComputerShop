package vn.javaweb.ComputerShop.domain.dto.request;

import jakarta.validation.constraints.*;
import lombok.*;
import org.springframework.validation.annotation.Validated;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Validated
public class ProductCreateRqDTO {
    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(max = 100, message = "Tên sản phẩm tối đa 100 ký tự")
    private String name;

    @Positive(message = "Giá phải lớn hơn 0")
    private double price;

    @NotBlank(message = "Mô tả chi tiết không được để trống")
    private String detailDesc;

    @NotBlank(message = "Mô tả ngắn không được để trống")
    @Size(max = 255, message = "Mô tả ngắn tối đa 255 ký tự")
    private String shortDesc;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 1, message = "Số lượng phải ít nhất là 1")
    private Long quantity;

    @NotBlank(message = "Tên nhà máy không được để trống")
    private String factory;

    @NotBlank(message = "Mục tiêu không được để trống")
    private String target;
}
