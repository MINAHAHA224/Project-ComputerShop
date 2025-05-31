package vn.javaweb.ComputerShop.service;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.javaweb.ComputerShop.component.MailerComponent;
import vn.javaweb.ComputerShop.domain.dto.request.InfoOrderRqDTO;
import vn.javaweb.ComputerShop.domain.dto.request.InformationDTO;
import vn.javaweb.ComputerShop.domain.dto.response.CartDetailRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.CartRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.CheckoutRpDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
import vn.javaweb.ComputerShop.domain.entity.*;
import vn.javaweb.ComputerShop.domain.enums.CartStatus;
import vn.javaweb.ComputerShop.domain.enums.OrderStatus;
import vn.javaweb.ComputerShop.domain.enums.PaymentStatus;
import vn.javaweb.ComputerShop.repository.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CartService {
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final MailerComponent mailerComponent;

    public CartRpDTO handleGetCartDetail (HttpSession session){
        CartRpDTO result = new CartRpDTO();
        String email = (String) session.getAttribute("email");
        UserEntity userCurrent = this.userRepository.findUserEntityByEmail(email).get();
        List<CartDetailRpDTO> listCardDetailRpDTO = new ArrayList<>();
        double TotalPrice = 0.0;
        Optional<CartEntity> cart = this.cartRepository.findCartEntityByUserAndStatus(userCurrent , CartStatus.ACTIVE.toString());
        if (cart.isPresent()){
            CartEntity cartOfUser =cart.get();
            List<CartDetailEntity>  cartDetailsOfUser = cartOfUser.getCartDetails();
            for ( CartDetailEntity cartDetailOfUser : cartDetailsOfUser ){
                CartDetailRpDTO cartDetailRpDTO = new CartDetailRpDTO();
                cartDetailRpDTO.setId(cartDetailOfUser.getId());
                cartDetailRpDTO.setPrice(cartDetailOfUser.getPrice());
                cartDetailRpDTO.setQuantity(cartDetailOfUser.getQuantity());
                cartDetailRpDTO.setStockQuantity(cartDetailOfUser.getQuantity());
                TotalPrice = TotalPrice + (cartDetailOfUser.getPrice() * cartDetailOfUser.getQuantity());

                cartDetailRpDTO.setProductId(cartDetailOfUser.getProduct().getId());
                cartDetailRpDTO.setProductName(cartDetailOfUser.getProduct().getName());
                cartDetailRpDTO.setProductImage(cartDetailOfUser.getProduct().getImage());


                listCardDetailRpDTO.add(cartDetailRpDTO);
            }
        }

        result.setCartDetails(listCardDetailRpDTO);
        result.setTotalPrice(TotalPrice);

        return  result;
    }

    @Transactional
    public ResponseBodyDTO handleDeleteProductInCart(Long id , HttpSession session){
        String email = (String) session.getAttribute("email");
        InformationDTO informationDTO = (InformationDTO)session.getAttribute("informationDTO") ;
        ResponseBodyDTO response = new ResponseBodyDTO();

        UserEntity userCurrent = this.userRepository.findUserEntityByEmail(email).get();
        CartEntity cart = this.cartRepository.findCartEntityByUserAndStatus(userCurrent , CartStatus.ACTIVE.toString()).get();
        ProductEntity product = this.productRepository.findProductEntityById(id);

        try {
            this.cartDetailRepository.deleteCartDetailEntityByCartAndProduct(cart ,product );

            //set lai sum cua cart trong database
            cart.setSum(cart.getSum()-1);
            this.cartRepository.save(cart  );
        }catch (RuntimeException e){
            System.out.println("--ER  handleDeleteProductInCart "+ e.getMessage());
            e.printStackTrace();
            throw e;
        }
        //handle delete


        // set lai sum trong infor
        int currentSum = informationDTO.getSum();
        informationDTO.setSum(currentSum-1);
        // set lai session
        session.setAttribute("informationDTO" ,informationDTO );

        response.setStatus(200);
        response.setMessage("Xóa sản phẩm thành công");
        return response;
    }


    public ResponseBodyDTO handleAddOneProductToCart(HttpSession session, Long productId) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        InformationDTO informationDTO = (InformationDTO) session.getAttribute("informationDTO");
        int sumCurrent = informationDTO.getSum();
        String email = (String) session.getAttribute("email");
        UserEntity user = this.userRepository.findUserEntityByEmail(email).get();

        Optional<CartEntity> cart = this.cartRepository.findCartEntityByUserAndStatus(user ,CartStatus.ACTIVE.toString());
        ProductEntity product = this.productRepository.findProductEntityById(productId);

        if (cart.isEmpty()) {
            CartEntity otherCart = new CartEntity();
            otherCart.setSum(1);
            otherCart.setUser(user);
            otherCart.setStatus(CartStatus.ACTIVE.toString());
            CartEntity newCart =   this.cartRepository.save(otherCart);

            // set cart detail because first buy but one

            CartDetailEntity cartDetail = new CartDetailEntity();
            cartDetail.setCart(newCart);
            cartDetail.setProduct(product);
            cartDetail.setPrice(product.getPrice());
            cartDetail.setQuantity(1);
            this.cartDetailRepository.save(cartDetail);

            // reset sum in informationDTO session
            informationDTO.setSum(sumCurrent+1);
            // set lai session
            session.setAttribute("informationDTO" , informationDTO);


            response.setStatus(200);
            response.setMessage("Thêm sản phẩm vào giỏ hàng thành công");
            return response;

        } else {
            CartEntity cartCurrent = cart.get();
            Optional<CartDetailEntity>  oldDetail = this.cartDetailRepository.findByCartAndProduct(cart.get(), product);
            if (oldDetail.isEmpty()) {
                CartDetailEntity cartDetail = new CartDetailEntity();
                cartDetail.setCart(cart.get());
                cartDetail.setProduct(product);
                cartDetail.setPrice(product.getPrice());
                cartDetail.setQuantity(1);
                this.cartDetailRepository.save(cartDetail);

                // update sum in cart khi ma san pham no ko co thi moi +1 hien thi len gio hang
                int sumCurrentInCart = cartCurrent.getSum() + 1;
                cartCurrent.setSum(sumCurrentInCart);
                this.cartRepository.save(cartCurrent);


                // reset sum in informationDTO session
                informationDTO.setSum(sumCurrent+1);
                // set lai session
                session.setAttribute("informationDTO" , informationDTO);
                response.setStatus(200);
                response.setMessage("Thêm sản phẩm vào giỏ hàng thành công");
                return response;
            } else {
                // con san pham no co roi thi thoi khong + 1 hien thi len gio hang cho du no add x10 so luon cua san pham do
                CartDetailEntity cartDetailCurrent = oldDetail.get();
                long quantityCurrent = cartDetailCurrent.getQuantity();
                cartDetailCurrent.setQuantity(quantityCurrent + 1);
                this.cartDetailRepository.save(cartDetailCurrent);



                response.setStatus(200);
                response.setMessage("Đã thêm số lượng sản phẩm");
                return response;
            }
        }
    }


    public CheckoutRpDTO handleShowDataAfterCheckout (HttpSession session){
        CheckoutRpDTO result = new CheckoutRpDTO();
        String email = (String) session.getAttribute("email");
        UserEntity currentUser = this.userRepository.findUserEntityByEmail(email).get();
        CartEntity cart = this.cartRepository.findCartEntityByUserAndStatus(currentUser , CartStatus.ACTIVE.toString()).get();
        List<CartDetailEntity> cartDetails =  cart.getCartDetails();

        List<CartDetailRpDTO> listCardDetailRpDTO = new ArrayList<>();
        double totalPrice = 0.0;

        for ( CartDetailEntity cartDetailOfUser : cartDetails ){
            CartDetailRpDTO cartDetailRpDTO = new CartDetailRpDTO();
            cartDetailRpDTO.setId(cartDetailOfUser.getId());
            cartDetailRpDTO.setPrice(cartDetailOfUser.getPrice());
            cartDetailRpDTO.setQuantity(cartDetailOfUser.getQuantity());
            totalPrice = totalPrice + (cartDetailOfUser.getPrice() * cartDetailOfUser.getQuantity());

            cartDetailRpDTO.setProductId(cartDetailOfUser.getProduct().getId());
            cartDetailRpDTO.setProductName(cartDetailOfUser.getProduct().getName());
            cartDetailRpDTO.setProductImage(cartDetailOfUser.getProduct().getImage());
            listCardDetailRpDTO.add(cartDetailRpDTO);
        }

        // show infor user to order place
        InfoOrderRqDTO infoOrderRqDTO = new InfoOrderRqDTO();
        infoOrderRqDTO.setReceiverName(currentUser.getFullName().trim());
        infoOrderRqDTO.setReceiverAddress(currentUser.getAddress() != null ? currentUser.getAddress() : "" );
        infoOrderRqDTO.setReceiverPhone(currentUser.getPhone() != null ? currentUser.getPhone() : "");
        infoOrderRqDTO.setTotalPriceToSaveOrder(totalPrice);

        result.setCartDetails(listCardDetailRpDTO);
        result.setTotalPrice(totalPrice);
        result.setInfoOrderRqDTO(infoOrderRqDTO);
        return result;
    }


    @Transactional
    public ResponseBodyDTO handleCreateOrder(HttpSession session , InfoOrderRqDTO infoOrderRqDTO) {

        ResponseBodyDTO response = new ResponseBodyDTO();
        String email = (String) session.getAttribute("email");
        UserEntity user = this.userRepository.findUserEntityByEmail(email).get();
        InformationDTO  informationDTO = (InformationDTO)session.getAttribute("informationDTO");


            OrderEntity order = new OrderEntity();
            order.setUser(user);
            order.setReceiverName(infoOrderRqDTO.getReceiverName());
            order.setReceiverAddress(infoOrderRqDTO.getReceiverAddress());
            order.setReceiverPhone(infoOrderRqDTO.getReceiverPhone());
            order.setTotalPrice(infoOrderRqDTO.getTotalPriceToSaveOrder());
            order.setStatus(OrderStatus.PENDING.toString());
            order.setTime(new Date());
            order.setTypePayment(infoOrderRqDTO.getPaymentMethod());
            order.setStatusPayment(PaymentStatus.UNPAID.toString());

            OrderEntity  orderNew = this.orderRepository.save(order);

            // create orderDetail

            // step 1: get cart by user
            Optional<CartEntity>  cartCurrent = this.cartRepository.findCartEntityByUserAndStatus(user , CartStatus.ACTIVE.toString());
            if (cartCurrent.isPresent()) {
                CartEntity cart = cartCurrent.get();
                List<CartDetailEntity> cartDetails = cart.getCartDetails();

                if (cartDetails != null) {

                List<OrderDetailEntity> orderDetails = new ArrayList<>();
                    for (CartDetailEntity cd : cartDetails) {
                        OrderDetailEntity orderDetail = new OrderDetailEntity();
                        orderDetail.setOrder(orderNew);
                        orderDetail.setProduct(cd.getProduct());
                        orderDetail.setPrice(cd.getPrice() * cd.getQuantity());
                        orderDetail.setQuantity(cd.getQuantity());
                        orderDetails.add(orderDetail);
                        this.orderDetailRepository.save(orderDetail);

                        // set lai quantity cho product
                        ProductEntity productCurrent = cd.getProduct();
                        productCurrent.setSold(productCurrent.getSold() + cd.getQuantity()  );
                        this.productRepository.save(productCurrent);

                    }
                    orderNew.setOrderDetails(orderDetails);
                    this.orderRepository.save(orderNew);
                    // step 2: update status of card
                    if ( infoOrderRqDTO.getPaymentMethod().equals("COD")){
                        cart.setStatus(CartStatus.ORDERED.toString());
                    }

                    this.cartRepository.save(cart);

                    // step 3 : update session
                    informationDTO.setSum(0);
                    session.setAttribute("informationDTO", informationDTO);
                }



                response.setStatus(200);
                response.setMessage("Đặt hàng thành công! Hóa đơn đã được gửi tới email của bạn.");
                response.setData(orderNew);
                if ( infoOrderRqDTO.getPaymentMethod().equals("COD")){
                    mailerComponent.sendInvoiceEmail(orderNew);
                }

            }

        // create new order

        return response;

    }

    public ResponseBodyDTO handleAddProductDetailToCart( Long productId, HttpSession session, Long quantity) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        InformationDTO informationDTO = (InformationDTO) session.getAttribute("informationDTO");
        int sumCurrent = informationDTO.getSum();
        String email = (String) session.getAttribute("email");
        UserEntity user = this.userRepository.findUserEntityByEmail(email).get();

        Optional<CartEntity> cart = this.cartRepository.findCartEntityByUserAndStatus(user ,CartStatus.ACTIVE.toString());
        ProductEntity product = this.productRepository.findProductEntityById(productId);

        if (cart.isEmpty()) {
            CartEntity otherCart = new CartEntity();
            otherCart.setSum(1);
            otherCart.setUser(user);
            otherCart.setStatus(CartStatus.ACTIVE.toString());
            CartEntity newCart =   this.cartRepository.save(otherCart);

            // set cart detail because first buy but one

            CartDetailEntity cartDetail = new CartDetailEntity();
            cartDetail.setCart(newCart);
            cartDetail.setProduct(product);
            cartDetail.setPrice(product.getPrice());
            cartDetail.setQuantity((int)quantity.longValue());
            this.cartDetailRepository.save(cartDetail);

            // reset sum in informationDTO session
            informationDTO.setSum(sumCurrent+1);
            // set lai session
            session.setAttribute("informationDTO" , informationDTO);


            response.setStatus(200);
            response.setMessage("Thêm sản phẩm vào giỏ hàng thành công");
            return response;

        } else {
            CartEntity cartCurrent = cart.get();
            Optional<CartDetailEntity>  oldDetail = this.cartDetailRepository.findByCartAndProduct(cart.get(), product);
            if (oldDetail.isEmpty()) {
                CartDetailEntity cartDetail = new CartDetailEntity();
                cartDetail.setCart(cart.get());
                cartDetail.setProduct(product);
                cartDetail.setPrice(product.getPrice());
                cartDetail.setQuantity( (int)quantity.longValue());
                this.cartDetailRepository.save(cartDetail);

                // update sum in cart khi ma san pham no ko co thi moi +1 hien thi len gio hang
                int sumCurrentInCart = cartCurrent.getSum() + 1;
                cartCurrent.setSum(sumCurrentInCart);
                this.cartRepository.save(cartCurrent);


                // reset sum in informationDTO session
                informationDTO.setSum(sumCurrent+1);
                // set lai session
                session.setAttribute("informationDTO" , informationDTO);
                response.setStatus(200);
                response.setMessage("Thêm sản phẩm vào giỏ hàng thành công");
                return response;
            } else {
                // con san pham no co roi thi thoi khong + 1 hien thi len gio hang cho du no add x10 so luon cua san pham do
                CartDetailEntity cartDetailCurrent = oldDetail.get();
                long quantityCurrent = cartDetailCurrent.getQuantity();
                cartDetailCurrent.setQuantity(quantityCurrent + (int)quantity.longValue());
                this.cartDetailRepository.save(cartDetailCurrent);



                response.setStatus(200);
                response.setMessage("Đã thêm số lượng sản phẩm");
                return response;
            }
        }


    }
}
