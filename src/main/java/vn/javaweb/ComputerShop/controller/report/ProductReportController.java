package vn.javaweb.ComputerShop.controller.report;


import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.javaweb.ComputerShop.domain.dto.request.InformationDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductReportDto;
import vn.javaweb.ComputerShop.service.ExportExcelService;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/product/report")
public class ProductReportController {


    private final ExportExcelService exportExcelService;

    // Trang chọn factory (nếu bạn muốn người dùng chọn trước khi xem)
//    @GetMapping("/select")
//    public String showFactorySelectionPage(Model model, HttpSession session) {
//        InformationDTO informationDTO = (InformationDTO) session.getAttribute("informationDTO");
//        // Lấy danh sách các factory để hiển thị trong dropdown
//        List<String> factories = this.exportExcelService.getAllFactories();
//        model.addAttribute("factories", factories);
//        model.addAttribute("currentUser", informationDTO); // Cần cho thông tin người dùng
//        return "admin/product/report_factory_select"; // JSP trang chọn factory
//    }

    // Endpoint xem trước Excel
    @GetMapping("/excel/preview")
    public String previewProductExcel(
            @RequestParam(name = "factory", required = false) String factory, // Lấy factory từ request param
            HttpSession session,
            Model model) {
        InformationDTO informationDTO = (InformationDTO) session.getAttribute("informationDTO");

        try {
            List<ProductReportDto> listProducts = this.exportExcelService.getProductsForReport(factory);
            List<String> allFactories = this.exportExcelService.getAllFactories(); // Để hiển thị lại dropdown

            if (listProducts != null && !listProducts.isEmpty()) {
                model.addAttribute("listProducts", listProducts);
                model.addAttribute("currentUser", informationDTO);
                model.addAttribute("printDate", new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date()));
                model.addAttribute("selectedFactory", factory); // Truyền factory đã chọn để hiển thị và dùng cho link download
            } else {
                model.addAttribute("message", "Không có dữ liệu sản phẩm" +
                        (factory != null && !factory.isEmpty() ? " cho hãng '" + factory + "'" : "") +
                        " để xem trước.");
            }
            model.addAttribute("factories", allFactories); // Danh sách các hãng để người dùng có thể đổi
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error_message", "Lỗi khi chuẩn bị dữ liệu xem trước: " + e.getMessage());
        }
        return "admin/product/productExcelPreview"; // Tên file JSP mới cho xem trước sản phẩm
    }


    // Endpoint tải file Excel
    @GetMapping("/excel/download")
    public void downloadProductExcel(
            @RequestParam(name = "factory", required = false) String factory, // Lấy factory từ request param
            HttpSession session,
            HttpServletResponse response) {

        InformationDTO informationDTO = (InformationDTO) session.getAttribute("informationDTO");

        try {
            List<ProductReportDto> listProducts = this.exportExcelService.getProductsForReport(factory);
            if (listProducts == null || listProducts.isEmpty()) {
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('Không có dữ liệu sản phẩm" +
                        (factory != null && !factory.isEmpty() ? " cho hãng \\'" + factory.replace("'", "\\'") + "\\'" : "") +
                        " để xuất Excel.'); window.history.back();</script>");
                return;
            }
            this.exportExcelService.generateProductsExcelReport(listProducts, informationDTO, factory, response);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('Lỗi khi tạo file Excel: " + e.getMessage().replace("'", "\\'") + "'); window.history.back();</script>");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }






}
