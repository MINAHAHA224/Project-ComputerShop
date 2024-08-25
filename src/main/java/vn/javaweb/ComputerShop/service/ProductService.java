package vn.javaweb.ComputerShop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.javaweb.ComputerShop.domain.Cart;
import vn.javaweb.ComputerShop.domain.CartDetail;
import vn.javaweb.ComputerShop.domain.Product;
import vn.javaweb.ComputerShop.domain.User;
import vn.javaweb.ComputerShop.domain.dto.ProductCriteriaDTO;
import vn.javaweb.ComputerShop.repository.CartDetailRepository;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.repository.ProductRepository;
import vn.javaweb.ComputerShop.service.specification.ProductSpecs;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;

    }

    public Product handleSaveProduct(Product a) {
        Product success = this.productRepository.save(a);

        return success;
    }

    public Page<Product> getAllProduct(Pageable page) {

        return this.productRepository.findAll(page);
    }

    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getTarget() == null
                && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null) {
            return this.productRepository.findAll(page);
        }

        Specification<Product> combinedSpec = Specification.where(null);

        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    // case 6
    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null);
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
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    public List<Product> getFirstProductById(long id) {
        return this.productRepository.findFirstById(id);
    }

    public Product getOnlyOneProduct(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {

        User user = this.userService.getUserByEmail(email);

        Cart cart = this.cartRepository.findByUser(user);
        Product product = getOnlyOneProduct(productId);

        if (cart == null) {
            Cart otherCart = new Cart();
            otherCart.setSum(0);
            otherCart.setUser(user);
            cart = this.cartRepository.save(otherCart);

        }
        {
            CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
            if (oldDetail == null) {
                CartDetail cartDetail = new CartDetail();
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

    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public List<CartDetail> getCartDetailByCart(Cart cart) {
        return this.cartDetailRepository.findByCart(cart);
    }

    public CartDetail getCartDetailByProductId(long id) {
        return this.cartDetailRepository.findByProductId(id);
    }

    public void deleteCartDetail(long id) {
        this.cartDetailRepository.deleteCDetailById(id);
    }

    public void deleteCart(long id) {
        this.cartRepository.deleteCartById(id);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
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

    public void handleConfirmCheckout(List<CartDetail> cartDetails) {

        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }

    }

}
