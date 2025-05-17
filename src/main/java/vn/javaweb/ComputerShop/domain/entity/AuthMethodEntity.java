package vn.javaweb.ComputerShop.domain.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "auth_method")
public class AuthMethodEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "login_type")
    private String login_type;

    @Column(name = "external_id")
    private String external_id;

    @OneToOne
    @JoinColumn( name = "user_id")
    private UserEntity user;
}
