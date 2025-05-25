package vn.javaweb.ComputerShop.controller.client;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import vn.javaweb.ComputerShop.domain.dto.request.InformationDTO;
import vn.javaweb.ComputerShop.domain.dto.request.LoginDTO;
import vn.javaweb.ComputerShop.domain.dto.request.RegisterDTO;
import vn.javaweb.ComputerShop.domain.dto.request.ResetPasswordDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.service.UserService;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AccessController {
    private final UserService userService;

    @GetMapping("/login")
    public String getLogin(Model model) {
        LoginDTO loginDTO = new LoginDTO();
        model.addAttribute("loginDTO", loginDTO);
        return "client/auth/login";
    }

    @PostMapping("/login")
    public String postLogin(Model model, HttpSession session
            , @Valid @ModelAttribute("loginDTO") LoginDTO loginDTO

            , BindingResult bindingResult) {


        List<FieldError> errors = bindingResult.getFieldErrors();
        if (bindingResult.hasErrors()) {
            for (FieldError error : errors) {
                System.out.println("--ER " + error.getField() + " - " + error.getDefaultMessage());
            }

            return "client/auth/login";
        }
        ResponseBodyDTO handleLogin = this.userService.handleLogin(loginDTO, session);
        if (handleLogin.getStatus() == 200 && ((InformationDTO) handleLogin.getData()).getRole().equals("ADMIN")) {
            session.setAttribute("informationDTO", handleLogin.getData());
            model.addAttribute("messageSuccess" ,handleLogin.getMessage());
            return "admin/dashboard/show";
        } else if (handleLogin.getStatus() == 200) {
            session.setAttribute("informationDTO", handleLogin.getData());
            model.addAttribute("messageSuccess" ,handleLogin.getMessage());
            return "client/homepage/show";
        } else {
            model.addAttribute("messageError", handleLogin.getMessage());
            return "client/auth/login";

        }
    }


    @GetMapping("/register")
    public String getRegister(Model model) {

        model.addAttribute("registerDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String postRegister(Model model, @Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO,
                               BindingResult bindingResult) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println("--ER " + error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        ResponseBodyDTO handleRegister = this.userService.handleRegister(registerDTO);
        if (handleRegister.getStatus() == 200) {
            model.addAttribute("messageSuccess", handleRegister.getMessage());
            return "client/auth/login";
        } else {
            model.addAttribute("messageError", handleRegister.getMessage());
            return "client/auth/register";
        }
    }


    @GetMapping(value = "/auth/google")
    public ModelAndView redirectToGoogle() {
        return this.userService.handleRedirectToGoogle();
    }

    @GetMapping("/auth/oauth2/code/google")
    public String handleGoogleCallback(@RequestParam("code") String code
            , HttpServletResponse response, HttpSession session , Model model) {

        InformationDTO informationDTO = this.userService.handleLoginOauth2Google(code, response, session);
        session.setAttribute("informationDTO", informationDTO);

        return "client/homepage/show";
    }


    @GetMapping("/forgotPassword")
    public String getPageForgotPassword(Model model) {
        model.addAttribute("email", "");
        return "client/auth/forgotPassword";
    }

    @PostMapping("/forgotPassword")
    public String postForgotPassword(Model model
            , @RequestParam(name = "email", required = true) String email
            , RedirectAttributes redirectAttributes) {
        ResponseBodyDTO sendOTPtoEmail = this.userService.handleSendOTP(email.trim());
        if (sendOTPtoEmail.getStatus() != 200) {
            model.addAttribute("messageError", sendOTPtoEmail.getMessage());
            model.addAttribute("email", email.trim());
            return "client/auth/forgotPassword";
        } else {
            model.addAttribute("email", email.trim());
            model.addAttribute("messageSuccess", sendOTPtoEmail.getMessage());
            return "client/auth/verifyOTP";
        }

    }

//    @GetMapping("/verifyOTP")
//    public String getVerifyOTP(Model model,
//                               @ModelAttribute("email") String email // Nhận email từ flash attribute
//    ) {
//        if (email == null || email.isEmpty()) {
//            return "client/auth/verifyOTP";
//        }
//        model.addAttribute("email", email);
//        return "client/auth/verifyOTP";
//    }

    @PostMapping("/verifyOtp")
    public String postOTPtoVerify(Model model
            , @RequestParam(name = "email", required = true) String email
            , @RequestParam(name = "OTP", required = false) String OTP
            , @RequestParam(name = "action", required = true) String action
            , RedirectAttributes redirectAttributes) {
        if (action.equals("VERIFY-OTP")) {
            ResponseBodyDTO sendOTPtoEmail = this.userService.handleVerifyOTP(email, OTP);
            if (sendOTPtoEmail.getStatus() != 200) {
                model.addAttribute("email", email);
                model.addAttribute("messageError", sendOTPtoEmail.getMessage());
                return "client/auth/verifyOTP";
            } else {
                ResetPasswordDTO resetPasswordDTO = new ResetPasswordDTO();
                resetPasswordDTO.setEmail(email);
                model.addAttribute("resetPasswordDTO", resetPasswordDTO);
                model.addAttribute("messageSuccess", sendOTPtoEmail.getMessage());
                return "client/auth/resetPassword";
            }
        }
        if (action.equals("RESENT-OTP")) {
            ResponseBodyDTO resentOtp = this.userService.handleSendOTP(email.trim());
            model.addAttribute("email", email.trim());
            model.addAttribute("messageSuccess", resentOtp.getMessage());
            return "client/auth/verifyOTP";
        }
        return null;
    }

//    @GetMapping("/resetPassword")
//    public String getPageResetPassword(Model model,
//                                       @ModelAttribute("email") String email, // Nhận email từ flash attribute
//                                       HttpServletRequest request) {
//        if (email == null || email.isEmpty()) {
//            return "client/auth/forgotPassword";
//        }
//
//        ResetPasswordDTO resetPasswordDTO = new ResetPasswordDTO();
//        resetPasswordDTO.setEmail(email); // Gán email vào DTO để hiển thị trong trường ẩn
//        model.addAttribute("resetPasswordDTO", resetPasswordDTO);
//        return "client/auth/resetPassword";
//    }

    @PostMapping(value = "/resetPassword")
    public String postResetPassword(Model model
            , @Valid @ModelAttribute("resetPasswordDTO") ResetPasswordDTO resetPasswordDTO
            , BindingResult bindingResult, RedirectAttributes redirectAttributes) {

        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println("-- ER " + error.getField() + " -- " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            model.addAttribute("resetPasswordDTO", resetPasswordDTO);
            return "client/auth/resetPassword";
        }

        ResponseBodyDTO handleResetPass = this.userService.handleResetPassword(resetPasswordDTO);
        if (handleResetPass.getStatus() == 200) {
            redirectAttributes.addFlashAttribute("messageSuccess", handleResetPass.getMessage());
            return "redirect:/login";
        } else {
            model.addAttribute("resetPasswordDTO", resetPasswordDTO);
            model.addAttribute("messageError", handleResetPass.getMessage());
            return "client/auth/resetPassword";
        }

    }


}
