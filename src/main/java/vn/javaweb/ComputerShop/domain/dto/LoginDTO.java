package vn.javaweb.ComputerShop.domain.dto;

public class LoginDTO {
    private String email;
    private String passWord;

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getEmail() {
        return email;
    }

    public String getPassWord() {
        return passWord;
    }

}
