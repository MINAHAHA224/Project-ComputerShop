package vn.javaweb.ComputerShop.controller.client;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import vn.javaweb.ComputerShop.domain.dto.request.ProductFilterDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductFilterRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
import vn.javaweb.ComputerShop.service.ProductService;

@Controller
@RequiredArgsConstructor
public class ClientPageController {
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

        ProductFilterRpDTO result = this.productService.handleShowDataProductFilter(productFilterDTO  );

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

}
