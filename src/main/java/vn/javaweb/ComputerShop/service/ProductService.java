package vn.javaweb.ComputerShop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;
import vn.javaweb.ComputerShop.domain.dto.request.*;
import vn.javaweb.ComputerShop.domain.dto.response.ProductDetailRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductFilterRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
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
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;


    public ProductFilterRpDTO handleShowDataProductFilter(ProductFilterDTO productFilterDTO, Pageable pageable) {
        ProductFilterRpDTO result = new ProductFilterRpDTO();
        Page<ProductRpDTO> listProduct = this.productRepository.findProductFilter(productFilterDTO, pageable);
        result.setListProduct(listProduct.getContent());
        result.setPage(pageable.getPageNumber());
        result.setTotalPage(listProduct.getTotalPages());
        return result;
    }

    public Page<ProductEntity> getAllProduct(Pageable page) {

        return this.productRepository.findAll(page);
    }

    public ProductEntity handleSaveProduct(ProductEntity a) {
        ProductEntity success = this.productRepository.save(a);

        return success;
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


    public List<ProductEntity> getFirstProductById(long id) {
        return this.productRepository.findFirstById(id);
    }

    public ProductEntity getOnlyOneProduct(long id) {


        return this.productRepository.findById(id);
    }

    public ProductDetailRpDTO getProductDetail(long id) {
        ProductDetailRpDTO productDetailRpDTO = new ProductDetailRpDTO();
        ProductEntity entity = this.productRepository.findById(id);
        productDetailRpDTO.setId(entity.getId());
        productDetailRpDTO.setName(entity.getName());
        productDetailRpDTO.setImage(entity.getImage());
        productDetailRpDTO.setDetailDesc(entity.getDetailDesc());
        productDetailRpDTO.setShortDesc(entity.getShortDesc());
        productDetailRpDTO.setPrice(entity.getPrice());
        productDetailRpDTO.setFactory(entity.getFactory());
        return productDetailRpDTO;
    }

    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }






    public CartEntity getCartByUser(UserEntity user) {
        return this.cartRepository.findByUser(user);
    }



    public List<CartDetailEntity> getCartDetailByCart(CartEntity cart) {
        return this.cartDetailRepository.findByCart(cart);
    }

    public CartDetailEntity getCartDetailByProductId(long id) {
        return this.cartDetailRepository.findByProductId(id);
    }

    public void deleteCartDetail(long id) {
        this.cartDetailRepository.deleteCDetailById(id);
    }

    public void deleteCart(long id) {
        this.cartRepository.deleteCartById(id);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetailEntity> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetailEntity cartDetail = cartDetailOptional.get();

            CartEntity currentCart = cartDetail.getCart();
            // delete cart-detail
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getSum() > 1) {
                // update current cart
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    @Transactional
    public ResponseBodyDTO handleConfirmCheckout(CartDetailsListDTO cartDetailsListDTO) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        List<CartDetailOneRqDTO> listResult = cartDetailsListDTO.getCartDetailOne();
        for  ( CartDetailOneRqDTO result : listResult){
            CartDetailEntity cartDetail = this.cartDetailRepository.findCartDetailEntityById(result.getId());
            cartDetail.setQuantity(result.getQuantity());
            this.cartDetailRepository.save(cartDetail);
        }
        response.setStatus(200);
        response.setMessage("Xác nhận thanh toán thành công");
        return response;
    }

}
