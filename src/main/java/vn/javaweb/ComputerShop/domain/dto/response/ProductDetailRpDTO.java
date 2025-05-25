package vn.javaweb.ComputerShop.domain.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProductDetailRpDTO {
    private Long id ;
    private String image;
    private String name;
    private String factory;
    private Double price;
    private String detailDesc;
    private String shortDesc;
}
