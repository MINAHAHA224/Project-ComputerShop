package vn.javaweb.ComputerShop.domain.dto.request;

import jakarta.validation.constraints.*;
import lombok.*;
import org.springframework.validation.annotation.Validated;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Validated
public class ProductUpdateRqDTO {
    private Long id ;

    private String image;
    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(max = 100, message = "Tên sản phẩm tối đa 100 ký tự")
    private String name;

    @NotBlank(message = "Tên nhà máy không được để trống")
    @Size(max = 100, message = "Tên nhà máy tối đa 100 ký tự")
    private String factory;

    @NotNull(message = "Giá không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá phải lớn hơn 0")
    private Double price;

    @NotBlank(message = "Mô tả chi tiết không được để trống")
    private String detailDesc;

    @NotBlank(message = "Mô tả ngắn không được để trống")
    @Size(max = 255, message = "Mô tả ngắn tối đa 255 ký tự")
    private String shortDesc;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 1, message = "Số lượng phải lớn hơn 0")
    private Long quantity;

    @NotBlank(message = "Mục tiêu không được để trống")
    private String target;

    @NotNull(message = "Số lượng đã bán không được để trống")
    @Min(value = 0, message = "Số lượng đã bán phải lớn hơn hoặc bằng 0")
    private Long sold;

}
