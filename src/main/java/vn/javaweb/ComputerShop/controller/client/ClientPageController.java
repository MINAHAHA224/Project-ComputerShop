package vn.javaweb.ComputerShop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.javaweb.ComputerShop.domain.dto.request.ChangePasswordDTO;
import vn.javaweb.ComputerShop.domain.dto.request.ProductFilterDTO;
import vn.javaweb.ComputerShop.domain.dto.request.UserProfileUpdateDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductFilterRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
import vn.javaweb.ComputerShop.service.ProductService;
import vn.javaweb.ComputerShop.service.UploadService;
import vn.javaweb.ComputerShop.service.UserService;

@Controller
@RequiredArgsConstructor
public class ClientPageController {
    private final ProductService productService;
    private final UserService userService;
    private final UploadService uploadService;


    @GetMapping("/home")
    public String getHomepage(Model model) {
        List<ProductRpDTO> listResult = this.productService.getAllProductView();
        model.addAttribute("products", listResult);


        return "client/homepage/show";
    }


    @GetMapping("/accessDeny")
    public String getAccessDenyPage() {

        return "client/auth/deny";
    }

    @GetMapping("/products")
    public String getProductsPage(Model model, ProductFilterDTO productFilterDTO, HttpServletRequest request) {

        ProductFilterRpDTO result = this.productService.handleShowDataProductFilter(productFilterDTO);

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + result.getPage(), "");
        }
        model.addAttribute("queryString", qs);

        model.addAttribute("products", result.getListProduct());
        model.addAttribute("currentPage", result.getPage());
        model.addAttribute("totalPages", result.getTotalPage());

        return "client/product/show";
    }


    @GetMapping(value = "/account-management")
    public String getAccountPage(Model model, HttpSession session) {
        UserProfileUpdateDTO userProfileUpdateDTO = this.userService.handleGetDataUserToProfile(session);
        model.addAttribute("userProfileUpdateDTO", userProfileUpdateDTO);
        model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
        return "client/profile/index";
    }

    @PostMapping(value = "/user/profile/update-info")
    public String postUpdateProfile (Model model ,
                                     RedirectAttributes redirectAttributes ,
                                     @Valid @ModelAttribute("userProfileUpdateDTO") UserProfileUpdateDTO userProfileUpdateDTO ,
                                     BindingResult bindingResult , HttpSession session){



            if (bindingResult.hasErrors() ){
                List<FieldError> errors = bindingResult.getFieldErrors();
                for (FieldError error : errors ){
                    System.out.println("-- ER  " + error.getField() + " - " + error.getDefaultMessage());
                }

                model.addAttribute("userProfileUpdateDTO", userProfileUpdateDTO);
                model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
                return "client/profile/index";
            }

        ResponseBodyDTO updateProfile = this.userService.handleUpdateProfile (session , userProfileUpdateDTO);

        if (updateProfile.getStatus() != 200 ){
            model.addAttribute("userProfileUpdateDTO", userProfileUpdateDTO);
            model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
            model.addAttribute("messageError" , updateProfile.getMessage());
            return "client/profile/index";
        }else {

            redirectAttributes.addFlashAttribute("messageSuccess" ,updateProfile.getMessage());
            return "redirect:/account-management";
        }

    }


    @PostMapping(value = "/user/profile/change-password")
    public String postUpdateChangePass (Model model , RedirectAttributes redirectAttributes,
                                        @Valid @ModelAttribute("changePasswordDTO") ChangePasswordDTO changePasswordDTO ,
                                        BindingResult bindingResult , HttpSession session){
        if ( bindingResult.hasErrors()){

            List<FieldError> errors = bindingResult.getFieldErrors();

            for (FieldError error : errors ){
                System.out.println("-- ER  " + error.getField() + " - " + error.getDefaultMessage());
            }
            UserProfileUpdateDTO userProfileUpdateDTO = this.userService.handleGetDataUserToProfile(session);
            model.addAttribute("userProfileUpdateDTO", userProfileUpdateDTO);
            model.addAttribute("changePasswordDTO", changePasswordDTO);

            return "client/profile/index";
        }

        if (!changePasswordDTO.getNewPassword().trim().equals(changePasswordDTO.getConfirmNewPassword().trim()) ){
            UserProfileUpdateDTO userProfileUpdateDTO = this.userService.handleGetDataUserToProfile(session);
            model.addAttribute("userProfileUpdateDTO", userProfileUpdateDTO);
            model.addAttribute("changePasswordDTO", changePasswordDTO);
            model.addAttribute("messageError" , "Mật khẩu nhập lai không khớp");
            return "client/profile/index";
        }

        ResponseBodyDTO updatePassword  = this.userService.handleUpdatePassword (session , changePasswordDTO);
        if (updatePassword.getStatus() != 200 ){
            redirectAttributes.addFlashAttribute("messageError" , updatePassword.getMessage());
            return "redirect:/account-management";

        }else {
            redirectAttributes.addFlashAttribute("messageSuccess" , updatePassword.getMessage());
            return "redirect:/account-management";
        }


    }

    @PostMapping(value = "/user/profile/update-avatar")
    public String postUpdateAvatar (Model model ,
                                   HttpSession session , RedirectAttributes redirectAttributes,
                                   @RequestParam("avatarFile") MultipartFile avatarFile){

       ResponseBodyDTO updateAvatar = this.userService.handleUpdateAvatar ( session , avatarFile);

       if (updateAvatar.getStatus() != 200 ){
           redirectAttributes.addFlashAttribute("messageError" , updateAvatar.getMessage());
           return "redirect:/account-management";

       }else {
           redirectAttributes.addFlashAttribute("messageSuccess" , updateAvatar.getMessage());
           return "redirect:/account-management";
       }
    }



}
