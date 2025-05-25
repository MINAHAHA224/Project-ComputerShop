package vn.javaweb.ComputerShop.controller.admin;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import vn.javaweb.ComputerShop.domain.entity.OrderEntity;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.repository.OrderRepository;
import vn.javaweb.ComputerShop.repository.ProductRepository;
import vn.javaweb.ComputerShop.repository.UserRepository;
import vn.javaweb.ComputerShop.service.UploadService;
import vn.javaweb.ComputerShop.service.UserService;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    private final UserService userService;
    private final UploadService uploadService;
    // Mã hóa thông tin
    private PasswordEncoder passwordEncoder;
    // img detail

    @GetMapping("/admin")
    public String getDashboard(Model model) {

        List<UserEntity> users = this.userRepository.findAll();
        List<ProductEntity> products = this.productRepository.findAll();
        List<OrderEntity> orders = this.orderRepository.findAll();

        int coutIdUser = users.size();
        int coutIdProduct = products.size();
        int coutIdOrder = orders.size();

        model.addAttribute("coutIdUser", coutIdUser);
        model.addAttribute("coutIdProduct", coutIdProduct);
        model.addAttribute("coutIdOrder", coutIdOrder);

        return "admin/dashboard/show";
    }

    @GetMapping("/admin/user")
    public String showUserPage(Model model) {
        List<UserEntity> listUser = this.userService.getAllUser();
        model.addAttribute("updateUser", listUser);

        return "admin/user/show";
    }

    // Create when we click button create

    @GetMapping("/admin/user/create")
    public String getCreateUser(Model model) {
        model.addAttribute("newUser", new UserEntity());

        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String postCreateUser(Model model,
                                 @Valid @ModelAttribute("newUser") UserEntity hoidanit, BindingResult newUserBingdingResult,
                                 @RequestParam("hoidanitFile") MultipartFile file) {

        List<FieldError> errors = newUserBingdingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        if (newUserBingdingResult.hasErrors()) {
            return "admin/user/create";
        }

        String avatar = this.uploadService.handleUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(hoidanit.getPassword());

        hoidanit.setAvatar(avatar);
        hoidanit.setPassword(hashPassword);

        hoidanit.setRole(this.userService.getRoleByName(hoidanit.getRole().getName()));
//        this.userService.handleSaveUser(hoidanit);
        return "redirect:/admin/user";
    }

    // Detail when we click button detail

    @GetMapping("/admin/user/{id}")
    public String getDetailPage(Model model, @PathVariable long id, HttpServletResponse response) {
        List<UserEntity> dataToDetail = this.userService.getFirstUserById(id);
        model.addAttribute("listInfoUser", dataToDetail);

        return "admin/user/detail";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdatePage(Model model, @PathVariable long id) {

        UserEntity dataToConfigUpdatePage = this.userService.getUserUpdateById(id);
        model.addAttribute("newUser", dataToConfigUpdatePage);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdatePage(Model model, @Valid @ModelAttribute("newUser") UserEntity hoidanit,
            BindingResult updateUserBingdingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {
        List<FieldError> errors = updateUserBingdingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        if (updateUserBingdingResult.hasErrors()) {
            return "admin/user/update";
        }
        UserEntity dataCurrentInfo = this.userService.getUserUpdateById(hoidanit.getId());
        String newAvater = this.uploadService.handleUploadFile(file, "avatar");
        if (dataCurrentInfo.getFullName() != hoidanit.getFullName() ||
                dataCurrentInfo.getAddress() != hoidanit.getAddress() ||
                dataCurrentInfo.getPhone() != hoidanit.getPhone() ||
                dataCurrentInfo.getRole() != hoidanit.getRole() ||
                dataCurrentInfo.getAvatar() != newAvater) {
            dataCurrentInfo.setFullName(hoidanit.getFullName());
            dataCurrentInfo.setAddress(hoidanit.getAddress());
            dataCurrentInfo.setPhone(hoidanit.getPhone());
            dataCurrentInfo.setRole(this.userService.getRoleByName(hoidanit.getRole().getName()));
            dataCurrentInfo.setAvatar(newAvater);
        }

//        this.userService.handleSaveUser(dataCurrentInfo);

        return "redirect:/admin/user";
    }

    // delete when we click button delete
    @GetMapping("/admin/user/delete/{id}")
    public String getDeletePage(Model model, @PathVariable long id) {

        List<UserEntity> dataToShowDelete = this.userService.getFirstUserById(id);
        model.addAttribute("user", dataToShowDelete);

        UserEntity dataConfigDelete = this.userService.getAllUserById(id);
        model.addAttribute("newUser", dataConfigDelete);
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeletePage(Model model, @ModelAttribute("newUser") UserEntity hoidanit) {
        this.userService.deleteUserById(hoidanit.getId());

        return "redirect:/admin/user";
    }

}
