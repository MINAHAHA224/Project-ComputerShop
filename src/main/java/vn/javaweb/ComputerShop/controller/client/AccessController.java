package vn.javaweb.ComputerShop.controller.client;

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
import vn.javaweb.ComputerShop.domain.dto.request.InformationDTO;
import vn.javaweb.ComputerShop.domain.dto.request.LoginDTO;
import vn.javaweb.ComputerShop.domain.dto.request.RegisterDTO;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.service.UserService;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class AccessController {
    private final UserService userService;

    @GetMapping("/login")
    public String getLogin(Model model) {
        LoginDTO loginDTO = new LoginDTO();
        model.addAttribute("loginDTO" , loginDTO);
        return "client/auth/login";
    }

    @PostMapping("/login")
    public String postLogin(Model model , HttpSession session
            , @Valid @ModelAttribute("loginDTO")LoginDTO loginDTO
            , RedirectAttributes redirectAttributes
            , BindingResult bindingResult){


        List<FieldError> errors = bindingResult.getFieldErrors();
        if (bindingResult.hasErrors()){
            for ( FieldError error : errors){
                System.out.println("--ER " + error.getField() + " - " + error.getDefaultMessage());
            }

            return "client/auth/login";
        }
        InformationDTO handleLogin = this.userService.handleLogin(loginDTO , session);

        if ( handleLogin.getId()!=null){
            session.setAttribute("informationDTO", handleLogin);

            return "redirect:/home";
        }else {
            model.addAttribute("message" , "Đăng nhập không thành công");
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
                               BindingResult bindingResult , RedirectAttributes redirectAttributes) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println("--ER " + error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        boolean handleRegister = this.userService.handleRegister(registerDTO);
        if (handleRegister ){
            redirectAttributes.addFlashAttribute("message" , "Đăng ký thành công");
            return "redirect:/login";
        }else {
            model.addAttribute("message" , "Đăng ký không thành công");
            return "client/auth/register";
        }
    }



    @GetMapping(value = "/auth/google")
    public ModelAndView redirectToGoogle (){
        return this.userService.handleRedirectToGoogle();
    }

    @GetMapping("/auth/oauth2/code/google")
    public String handleGoogleCallback(@RequestParam("code") String code , HttpServletResponse response , HttpSession session) {

       InformationDTO informationDTO = this.userService.handleLoginOauth2Google(code , response);
        session.setAttribute("informationDTO", informationDTO);
       return  "redirect:/home";
    }





}
