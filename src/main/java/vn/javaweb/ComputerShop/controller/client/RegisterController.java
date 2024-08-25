package vn.javaweb.ComputerShop.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import jakarta.validation.Valid;
import vn.javaweb.ComputerShop.domain.User;
import vn.javaweb.ComputerShop.domain.dto.RegisterDTO;
import vn.javaweb.ComputerShop.service.UserService;

@Controller
public class RegisterController {
    private final UserService userService;
    private PasswordEncoder passwordEncoder;

    public RegisterController(UserService userService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/register")
    public String getRegister(Model model) {

        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String postRegister(Model model, @Valid @ModelAttribute("registerUser") RegisterDTO registerUserDto,
            BindingResult registerBingdingResult) {
        List<FieldError> errors = registerBingdingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        if (registerBingdingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.userService.registerDTOtoUser(registerUserDto);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);

        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.handleSaveUser(user);

        return "redirect:/login";
    }

}
