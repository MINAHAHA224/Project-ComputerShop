package vn.javaweb.ComputerShop.domain.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "user_otp")
public class UserOtpEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "otp_code")
    private String otpCode;
    @Column(name = "expiry_time")
    private LocalDateTime expiredTime;
    @Column(name = "is_used")
    private boolean isUsed;
    @Column(name = "created_at")
    private LocalDateTime  createdAt;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;
}
