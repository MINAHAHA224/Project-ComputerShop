package vn.javaweb.ComputerShop.domain.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserDetailDTO {
    private Long id;
    private String email;
    private String fullName;
    private String address;
    private String phone;
    private String roleName;
    private String avatar;

}
