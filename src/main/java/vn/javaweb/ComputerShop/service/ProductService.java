package vn.javaweb.ComputerShop.service;

import java.util.*;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import vn.javaweb.ComputerShop.component.MessageService;
import vn.javaweb.ComputerShop.domain.dto.request.*;
import vn.javaweb.ComputerShop.domain.dto.response.*;
import vn.javaweb.ComputerShop.domain.entity.CartDetailEntity;
import vn.javaweb.ComputerShop.domain.entity.CartEntity;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.repository.CartDetailRepository;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.repository.ProductRepository;
import vn.javaweb.ComputerShop.repository.UserRepository;


@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UploadService uploadService;
    private final MessageService messageService;



    public ProductFilterRpDTO handleShowDataProductFilter(ProductFilterDTO productFilterDTO) {
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
        Pageable pageable = PageRequest.of(page - 1, 7);

        ProductFilterRpDTO result = new ProductFilterRpDTO();
        Page<ProductRpDTO> listProduct = this.productRepository.findProductFilter(productFilterDTO, pageable);
        result.setListProduct(listProduct.getContent());
        result.setPage(page);
        result.setTotalPage(listProduct.getTotalPages());
        return result;
    }

    public ProductFilterAdRpDTO handleShowDataProductAdmin(Optional<String> pageOptional) {
        ProductFilterAdRpDTO result = new ProductFilterAdRpDTO();
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
        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<ProductAdRpDTO> listProducts = this.productRepository.findProducts(pageable);
        result.setListProduct(listProducts.getContent());
        result.setPage(page);
        result.setTotalPage(listProducts.getTotalPages());
        return result;
    }


    public ProductUpdateRqDTO handleGetProductUpdate ( Long id){
        ProductUpdateRqDTO result = new ProductUpdateRqDTO();
        ProductEntity product = this.productRepository.findProductEntityById(id);

        result.setId(product.getId());
        result.setImage(product.getImage());
        result.setName(product.getName());
        result.setFactory(product.getFactory());
        result.setPrice(product.getPrice());
        result.setDetailDesc(product.getDetailDesc());
        result.setShortDesc(product.getShortDesc());
        result.setQuantity(product.getQuantity());
        result.setTarget(product.getTarget());
        result.setSold(product.getSold());
        return result;

    }
    @Transactional
    public ResponseBodyDTO handleCreateProduct (ProductCreateRqDTO productCreateRqDTO , MultipartFile file){
        ResponseBodyDTO response = new ResponseBodyDTO();

            String avatarProduct = this.uploadService.handleUploadFile(file, "product");


        boolean checkExistName = this.productRepository.existsProductEntityByName(productCreateRqDTO.getName().trim());
        if ( checkExistName){
            response.setStatus(500);
            response.setMessage("Admin : Tên sản phẩm đã được sử dụng");
            return response;
        }

        ProductEntity newProduct = new ProductEntity();
        newProduct.setName(productCreateRqDTO.getName().trim());
        newProduct.setPrice(productCreateRqDTO.getPrice());
        newProduct.setDetailDesc(productCreateRqDTO.getDetailDesc().trim());
        newProduct.setShortDesc(productCreateRqDTO.getShortDesc().trim());
        newProduct.setQuantity(productCreateRqDTO.getQuantity());
        newProduct.setFactory(productCreateRqDTO.getFactory().trim());
        newProduct.setTarget(productCreateRqDTO.getFactory());
        newProduct.setImage(avatarProduct);
        newProduct.setSold(0);

        // handle save
        this.productRepository.save(newProduct);

        response.setStatus(200);
        response.setMessage("Tạo sản phẩm thành công");
        return response;
    }

    @Transactional
    public ResponseBodyDTO handleUpdateProduct (ProductUpdateRqDTO productUpdateRqDTO , MultipartFile file){
        ProductEntity currentProduct = this.productRepository.findProductEntityById(productUpdateRqDTO.getId());
        ResponseBodyDTO response = new ResponseBodyDTO();

        if ( !currentProduct.getName().equals(productUpdateRqDTO.getName())){
            boolean checkExistName = this.productRepository.existsProductEntityByName(productUpdateRqDTO.getName().trim());
            if ( checkExistName){
                response.setStatus(500);
                response.setMessage("Admin : Tên sản phẩm đã được sử dụng");
                return response;
            }
        }

        currentProduct.setName(productUpdateRqDTO.getName().trim());
        currentProduct.setPrice(productUpdateRqDTO.getPrice());
        currentProduct.setDetailDesc(productUpdateRqDTO.getDetailDesc().trim());
        currentProduct.setShortDesc(productUpdateRqDTO.getShortDesc().trim());
        currentProduct.setQuantity(productUpdateRqDTO.getQuantity());
        currentProduct.setFactory(productUpdateRqDTO.getFactory().trim());
        currentProduct.setTarget(productUpdateRqDTO.getFactory());
        if (file!=null && !Objects.equals(file.getOriginalFilename(), "")){
            String avatarProduct = this.uploadService.handleUploadFile(file, "product");
            currentProduct.setImage(avatarProduct);
        }

        currentProduct.setSold(productUpdateRqDTO.getSold());


        this.productRepository.save(currentProduct);

        response.setStatus(200);
        response.setMessage("Admin : Cập nhật sản phẩm thành công");
        return response;
    }





    public List<ProductRpDTO> getAllProductView() {
        List<ProductRpDTO> listResult = new ArrayList<>();
        Pageable pageable = PageRequest.of(0, 10);
        List<ProductEntity> allProduct = this.productRepository.findAll(pageable).getContent();

        for (ProductEntity product : allProduct) {
            ProductRpDTO result = new ProductRpDTO();
            result.setId(product.getId());
            result.setName(product.getName());
            result.setShortDesc(product.getShortDesc());
            result.setPrice(product.getPrice());
            result.setImage(product.getImage());
            listResult.add(result);
        }

        return listResult;
    }

    @Transactional
    public ResponseBodyDTO handleDeleteProduct ( Long id){
        ResponseBodyDTO response = new ResponseBodyDTO();
        this.productRepository.deleteProductEntityById(id);
        response.setStatus(200);
        response.setMessage("Admin : Xóa sản phẩn thành công");
        return response;

    }


    public ProductDetailRpDTO handleGetProductRpAdmin(Long id) {
        ProductDetailRpDTO productDetail = new ProductDetailRpDTO();
        ProductEntity product = this.productRepository.findProductEntityById(id);

        productDetail.setId(product.getId());
        productDetail.setImage(product.getImage());
        productDetail.setName(product.getName());
        productDetail.setFactory(product.getFactory());
        productDetail.setPrice(product.getPrice());
        productDetail.setDetailDesc(product.getDetailDesc());
        productDetail.setShortDesc(product.getShortDesc());
        productDetail.setQuantity(product.getQuantity());
        productDetail.setTarget(product.getTarget());
        productDetail.setSold(product.getSold());

        return productDetail;
    }

    public ProductDetailRpDTO handleGetProductDetail(long id) {
        ProductDetailRpDTO productDetailRpDTO = new ProductDetailRpDTO();
        ProductEntity entity = this.productRepository.findProductEntityById(id);
        productDetailRpDTO.setId(entity.getId());
        productDetailRpDTO.setName(entity.getName());
        productDetailRpDTO.setImage(entity.getImage());
        productDetailRpDTO.setDetailDesc(entity.getDetailDesc());
        productDetailRpDTO.setShortDesc(entity.getShortDesc());
        productDetailRpDTO.setPrice(entity.getPrice());
        productDetailRpDTO.setFactory(entity.getFactory());
        productDetailRpDTO.setQuantity(entity.getQuantity());
        return productDetailRpDTO;
    }









//    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
//        Optional<CartDetailEntity> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
//        if (cartDetailOptional.isPresent()) {
//            CartDetailEntity cartDetail = cartDetailOptional.get();
//
//            CartEntity currentCart = cartDetail.getCart();
//            // delete cart-detail
//            this.cartDetailRepository.deleteById(cartDetailId);
//
//            // update cart
//            if (currentCart.getSum() > 1) {
//                // update current cart
//                int s = currentCart.getSum() - 1;
//                currentCart.setSum(s);
//                session.setAttribute("sum", s);
//                this.cartRepository.save(currentCart);
//            } else {
//                // delete cart (sum = 1)
//                this.cartRepository.deleteById(currentCart.getId());
//                session.setAttribute("sum", 0);
//            }
//        }
//    }

    @Transactional
    public ResponseBodyDTO handleConfirmCheckout(CartDetailsListDTO cartDetailsListDTO , Locale locale) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        List<CartDetailOneRqDTO> listResult = cartDetailsListDTO.getCartDetailOne();
        for  ( CartDetailOneRqDTO result : listResult){
            CartDetailEntity cartDetail = this.cartDetailRepository.findCartDetailEntityById(result.getId());
            cartDetail.setQuantity(result.getQuantity());
            this.cartDetailRepository.save(cartDetail);
        }
        response.setStatus(200);
        response.setMessage(messageService.getLocalizedMessage("cart.checkout.confirm.success" , locale));
        return response;
    }

}
