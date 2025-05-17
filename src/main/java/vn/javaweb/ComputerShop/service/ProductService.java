package vn.javaweb.ComputerShop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
import vn.javaweb.ComputerShop.domain.entity.CartDetailEntity;
import vn.javaweb.ComputerShop.domain.entity.CartEntity;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.domain.dto.request.ProductCriteriaDTO;
import vn.javaweb.ComputerShop.repository.CartDetailRepository;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.repository.ProductRepository;
import vn.javaweb.ComputerShop.service.specification.ProductSpecs;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;



    public ProductEntity handleSaveProduct(ProductEntity a) {
        ProductEntity success = this.productRepository.save(a);

        return success;
    }

    public List<ProductRpDTO> getAllProduct() {
        List<ProductRpDTO> listResult = new ArrayList<>();
        Pageable pageable = PageRequest.of(0, 10);
        List<ProductEntity> allProduct = this.productRepository.findAll(pageable).getContent();

        for ( ProductEntity product : allProduct ){
            ProductRpDTO result = new ProductRpDTO();
            result.setId(product.getId());
            result.setName(product.getName());
            result.setShortDesc(product.getShortDesc());
            result.setPrice(product.getPrice());
            result.setImage(product.getImage());
            listResult.add(result);
        }

        return listResult ;
    }

    public Page<ProductEntity> fetchProductsWithSpec(Pageable page, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getTarget() == null
                && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null) {
            return this.productRepository.findAll(page);
        }

        Specification<ProductEntity> combinedSpec = Specification.where(null);

        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<ProductEntity> currentSpecs = ProductSpecs.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<ProductEntity> currentSpecs = ProductSpecs.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<ProductEntity> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    // case 6
    public Specification<ProductEntity> buildPriceSpecification(List<String> price) {
        Specification<ProductEntity> combinedSpec = Specification.where(null);
        for (String p : price) {
            double min = 0;
            double max = 0;

            switch (p) {
                case "duoi-10-trieu":
                    min = 0;
                    max = 10000000;
                    break;
                case "10-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "tren-20-trieu":
                    min = 20000000;
                    max = 200000000;
                    break;
            }

            if (min != 0 && max != 0) {
                Specification<ProductEntity> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    public List<ProductEntity> getFirstProductById(long id) {
        return this.productRepository.findFirstById(id);
    }

    public ProductEntity getOnlyOneProduct(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {

        UserEntity user = this.userService.getUserByEmail(email);

        CartEntity cart = this.cartRepository.findByUser(user);
        ProductEntity product = getOnlyOneProduct(productId);

        if (cart == null) {
            CartEntity otherCart = new CartEntity();
            otherCart.setSum(0);
            otherCart.setUser(user);
            cart = this.cartRepository.save(otherCart);

        }
        {
            CartDetailEntity oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
            if (oldDetail == null) {
                CartDetailEntity cartDetail = new CartDetailEntity();
                cartDetail.setCart(cart);
                cartDetail.setProduct(product);
                cartDetail.setPrice(product.getPrice());
                cartDetail.setQuantity(quantity);
                this.cartDetailRepository.save(cartDetail);

                // update sum
                int s = cart.getSum() + 1;
                cart.setSum(s);
                this.cartRepository.save(cart);
                session.setAttribute("sum", s);
            } else {

                oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                this.cartDetailRepository.save(oldDetail);
            }

        }

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

    public void handleConfirmCheckout(List<CartDetailEntity> cartDetails) {

        for (CartDetailEntity cartDetail : cartDetails) {
            Optional<CartDetailEntity> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetailEntity currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }

    }

}
