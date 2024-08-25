package vn.javaweb.ComputerShop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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

import jakarta.validation.Valid;
import vn.javaweb.ComputerShop.domain.Product;
import vn.javaweb.ComputerShop.service.ProductService;
import vn.javaweb.ComputerShop.service.UploadService;
import vn.javaweb.ComputerShop.service.UserService;

@Controller
public class ProductController {
    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UserService userService, UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProduct(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {
                page = 1;
            }
        } catch (Exception e) {
            page = 1;
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 2);
        Page<Product> listProducts = this.productService.getAllProduct(pageable);

        List<Product> allProduct = listProducts.getContent();
        model.addAttribute("products", allProduct);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", listProducts.getTotalPages());
        return "admin/product/show";
    }

    // Create product not update

    @GetMapping("/admin/product/create")
    public String getCreateProduct(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String postCreateProduct(Model model, @Valid @ModelAttribute("newProduct") Product product,
            BindingResult createProductNBindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {
        List<FieldError> errors = createProductNBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        if (createProductNBindingResult.hasErrors()) {
            return "admin/product/create";
        }
        String avatarProduct = this.uploadService.handleUploadFile(file, "product");
        product.setImage(avatarProduct);
        product.setSold(0);
        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    // Product detail
    @GetMapping("/admin/product/{id}")
    public String getProductDetail(Model model, @PathVariable long id) {
        List<Product> allProduct = this.productService.getFirstProductById(id);
        model.addAttribute("products", allProduct);
        return "admin/product/detail";
    }

    // product update
    @GetMapping("/admin/product/update/{id}")
    public String getProductUpdate(Model model, @PathVariable long id) {
        Product onlyOneProduct = this.productService.getOnlyOneProduct(id);
        model.addAttribute("product", onlyOneProduct);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postProductUpdate(@Valid @ModelAttribute("product") Product hoidanit,
            BindingResult updateProductNBindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {

        List<FieldError> errors = updateProductNBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        if (updateProductNBindingResult.hasErrors()) {
            return "admin/product/update";
        }
        Product currentProduct = this.productService.getOnlyOneProduct(hoidanit.getId());
        hoidanit.setImage(this.uploadService.handleUploadFile(file, "product"));
        if (currentProduct.getName() != hoidanit.getName() ||
                currentProduct.getPrice() != hoidanit.getPrice() ||
                currentProduct.getDetailDesc() != hoidanit.getDetailDesc() ||
                currentProduct.getShortDesc() != hoidanit.getShortDesc() ||
                currentProduct.getQuantity() != hoidanit.getQuantity() ||
                currentProduct.getFactory() != hoidanit.getFactory() ||
                currentProduct.getTarget() != hoidanit.getTarget() ||
                currentProduct.getSold() != hoidanit.getSold() ||
                currentProduct.getImage() != hoidanit.getImage()) {

            this.productService.handleSaveProduct(hoidanit);
        }
        return "redirect:/admin/product";
    }

    // product delete

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProduct(Model model, @PathVariable long id) {

        List<Product> oneProduct = this.productService.getFirstProductById(id);
        model.addAttribute("product1", oneProduct);

        Product twoProduct = this.productService.getOnlyOneProduct(id);
        model.addAttribute("product2", twoProduct);
        return "admin/product/delete";
    }

    @PostMapping("/admin/user/product")
    public String postDeleteProduct(@ModelAttribute("product") Product hoidanit) {
        this.productService.deleteProductById(hoidanit.getId());

        return "redirect:/admin/product";
    }

}
