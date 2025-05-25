package vn.javaweb.ComputerShop.controller.client;

import java.util.ArrayList;
import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import vn.javaweb.ComputerShop.domain.dto.request.ProductFilterDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductFilterRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.domain.dto.request.ProductCriteriaDTO;
import vn.javaweb.ComputerShop.service.ProductService;
import vn.javaweb.ComputerShop.service.UserService;

@Controller
@RequiredArgsConstructor
public class HomepageController {
    private final ProductService productService;




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
    public String getProductsPage(Model model,ProductFilterDTO productFilterDTO, HttpServletRequest request) {
        int page = 1;
        try {
            if (!productFilterDTO.getPage().isEmpty()) {
                page = Integer.parseInt(productFilterDTO.getPage());
            } else {
                page = 1;
            }
        } catch (Exception e) {
            page = 1;
        }
        Pageable pageable = PageRequest.of(page - 1, 6);
        ProductFilterRpDTO result = this.productService.handleShowDataProductFilter(productFilterDTO , pageable );

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + page, "");
        }
        model.addAttribute("queryString", qs);

        model.addAttribute("products", result.getListProduct());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getTotalPage());

        return "client/product/show";
    }

}
