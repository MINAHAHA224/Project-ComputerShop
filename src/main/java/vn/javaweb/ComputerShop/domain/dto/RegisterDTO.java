package vn.javaweb.ComputerShop.domain.dto;

import jakarta.validation.constraints.NotNull;
import vn.javaweb.ComputerShop.service.validator.RegisterChecked;

@RegisterChecked
public class RegisterDTO {
    private String firstName;
    private String lastName;

    @NotNull
    private String email;

    @NotNull
    private String passWord;

    @NotNull
    private String confirmPassword;

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getPassWord() {
        return passWord;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

}
