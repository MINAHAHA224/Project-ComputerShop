package vn.javaweb.ComputerShop.service;

import java.time.LocalDateTime;
import java.util.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import vn.javaweb.ComputerShop.component.GoogleOauth2;
import vn.javaweb.ComputerShop.component.MailerComponent;
import vn.javaweb.ComputerShop.domain.dto.request.InformationDTO;
import vn.javaweb.ComputerShop.domain.dto.request.ResetPasswordDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ResponseBodyDTO;
import vn.javaweb.ComputerShop.domain.entity.*;
import vn.javaweb.ComputerShop.domain.dto.request.LoginDTO;
import vn.javaweb.ComputerShop.domain.dto.request.RegisterDTO;
import vn.javaweb.ComputerShop.repository.*;
import vn.javaweb.ComputerShop.utils.SecurityUtils;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final CartRepository cartRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final AuthMethodRepository authMethodRepository;
    private final UserOtpRepository userOtpRepository;
    private final MailerComponent mailerComponent;



    private final RestTemplate restTemplate = new RestTemplate();
    private final GoogleOauth2 googleOauth2;


    public ResponseBodyDTO handleLogin(LoginDTO loginDTO, HttpSession session) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        String email = loginDTO.getEmail().trim();
        String password = loginDTO.getPassword().trim();
        UserEntity user = new UserEntity();
        Optional<UserEntity> emailOnDb = this.userRepository.findUserEntityByEmail(email);
        if (emailOnDb.isPresent()) {
            user = emailOnDb.get();
        } else {
            response.setStatus(500);
            response.setMessage("Email chưa được đăng kí");
            return response;
        }

        if (!passwordEncoder.matches(password, user.getPassword())) {
            response.setStatus(500);
            response.setMessage("Mật khẩu không đúng");
            return response;
        }


        // set data for Spring Security
        try {
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                    email,
                    password,
                    user.getAuthorities()
            );
            Authentication authenticationResult = authenticationManager.authenticate(authenticationToken);
            //add data into SecurityContextHolder to view used to authorized
             SecurityContextHolder.getContext().setAuthentication(authenticationResult);
            // set session

            // Lưu SecurityContext vào HttpSession


            // Lưu vào HttpSession
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
            HttpServletResponse responseForSecurity = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
            HttpSessionSecurityContextRepository repo = new HttpSessionSecurityContextRepository();
            repo.saveContext(SecurityContextHolder.getContext(), request, responseForSecurity);

            // Lấy thông tin người dùng đã xác thực
            String testEmailFromSecurity = SecurityUtils.getPrincipal(); // Đây là username (email)
            System.out.println("Logged in user (from SecurityUtils after setAuthentication): " + testEmailFromSecurity);
            System.out.println("Authorities in SecurityContext: " + SecurityContextHolder.getContext().getAuthentication().getAuthorities());


            InformationDTO informationDTO = new InformationDTO();
            informationDTO.setId(user.getId());
            informationDTO.setEmail(user.getEmail());
            informationDTO.setRole(user.getRole().getName());
            informationDTO.setFullName(user.getFullName());
            informationDTO.setAvatar(user.getAvatar());
            Optional<CartEntity> cartCurrent = this.cartRepository.findCartEntityByUserAndStatus(user, "ACTIVE");
            informationDTO.setSum(cartCurrent.isPresent() ? cartCurrent.get().getSum() : 0);

            session.setAttribute("email", user.getEmail());
            response.setStatus(200);
            response.setMessage("Đăng nhập thành công");
            response.setData(informationDTO);
            return response;

        } catch (RuntimeException e) {
            System.out.println("--ER authenticationToken ");
            e.printStackTrace();
            throw e;
        }


    }

    @Transactional
    public ResponseBodyDTO handleRegister(RegisterDTO registerDTO) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        response.setMessage("Đăng ký không thành công");
        try {
            UserEntity user = new UserEntity();
            user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
            user.setEmail(registerDTO.getEmail());
            user.setPassword(registerDTO.getPassword());
            String hashPassword = this.passwordEncoder.encode(user.getPassword());
            user.setPassword(hashPassword);
            RoleEntity role = this.roleRepository.findByName("USER");
            user.setRole(role);

            this.userRepository.save(user);
            response.setStatus(200);
            response.setMessage("Đăng ký thành công");
            return response;
        } catch (RuntimeException e) {
            System.out.println("--ER handleRegister " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }


    public ModelAndView handleRedirectToGoogle() {
        String url = googleOauth2.getAuthUrl();
        return new ModelAndView("redirect:" + url);
    }

    @Transactional
    public InformationDTO handleLoginOauth2Google(String code, HttpServletResponse response, HttpSession session) {

        InformationDTO informationDTO = new InformationDTO();
        // 1. Get access token
        HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(
                googleOauth2.buildTokenRequestBody(code),
                googleOauth2.getHeadersForToken()
        );

        ResponseEntity<Map> tokenResponse = restTemplate.postForEntity(
                googleOauth2.getTokenEndpoint(), tokenRequest, Map.class);

        String accessToken = (String) tokenResponse.getBody().get("access_token");

        //Call userinfo endpoint , google need bearer not bearer for user use to connect api to software
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<Map> userInfoResponse = restTemplate.exchange(
                googleOauth2.getUserInfoEndpoint(), HttpMethod.GET, entity, Map.class);

        Map<String, Object> userInfo = userInfoResponse.getBody();
        String external_id = (String) userInfo.get("sub");
        String email = (String) userInfo.get("email");
        String name = (String) userInfo.get("name");
        String picture = (String) userInfo.get("picture");

        boolean existEmail = this.userRepository.existsByEmail(email);
        // if exists => create token for security
        if (existEmail) {
            UserEntity user = this.userRepository.findUserEntityByEmail(email).get();

            informationDTO.setId(user.getId());
            informationDTO.setEmail(user.getEmail());
            informationDTO.setFullName(user.getFullName());
            informationDTO.setAvatar(user.getAvatar());
            informationDTO.setRole(user.getRole().getName());
            Optional<CartEntity> cartCurrent = this.cartRepository.findCartEntityByUserAndStatus(user, "ACTIVE");
            informationDTO.setSum(cartCurrent.isPresent() ? cartCurrent.get().getSum() : 0);

            session.setAttribute("email", user.getEmail());

            return informationDTO;
        } else {
            try {
                // save user first
                UserEntity userNew = new UserEntity();
                userNew.setEmail(email);
                userNew.setFullName(name);
                RoleEntity role = this.roleRepository.findByName("USER");
                userNew.setRole(role);
                UserEntity userCurrent = this.userRepository.save(userNew);

                // save AuthMethod second
                AuthMethodEntity authMethod = new AuthMethodEntity();
                authMethod.setUser(userCurrent);
                authMethod.setLogin_type("GOOGLE");
                authMethod.setExternal_id(external_id);
                this.authMethodRepository.save(authMethod);


            } catch (RuntimeException e) {
                System.out.println("--ER handleLoginOauth2Google " + e.getMessage());
                e.printStackTrace();
                throw e;
            }

            UserEntity user = this.userRepository.findUserEntityByEmail(email).get();
            informationDTO.setId(user.getId());
            informationDTO.setEmail(email);
            informationDTO.setFullName(name);
            informationDTO.setAvatar(picture);
            informationDTO.setRole(user.getRole().getName());
            informationDTO.setSum(0);

            session.setAttribute("email", email);

            return informationDTO;

        }


    }

    @Transactional
    public ResponseBodyDTO handleSendOTP(String email) {
        ResponseBodyDTO responseBodyDTO = new ResponseBodyDTO();
        responseBodyDTO.setStatus(500);
        responseBodyDTO.setMessage("Đã có lỗi xảy ra trong quá trình xử lý mã OTP");

        // first  check email exist

        Optional<UserEntity> user = this.userRepository.findUserEntityByEmail(email);
        if (user.isPresent()) {
            // second check email has OTP not yet expired , if it has , can not canSentEmail = false
            boolean canSentEmail = true;
            List<UserOtpEntity> listUserOtp = this.userOtpRepository.findUserOtpEntityByUser(user.get());
            for (UserOtpEntity userOtp : listUserOtp) {
                if (userOtp.getExpiredTime().isAfter(LocalDateTime.now())) {
                    canSentEmail = false;
                    break;
                }
            }
            if (canSentEmail) {
                try {

                    String OTP = this.mailerComponent.generateOTP(6);
                    boolean handleSend = this.mailerComponent.sendConfirmLink(email, OTP);
                    UserOtpEntity userOtp = new UserOtpEntity();
                    userOtp.setUser(user.get());
                    userOtp.setOtpCode(OTP);
                    userOtp.setCreatedAt(LocalDateTime.now());
                    userOtp.setExpiredTime(LocalDateTime.now().plusMinutes(1));
                    userOtp.setUsed(false);
                    // set OTP to database
                    this.userOtpRepository.save(userOtp);
                    // set body
                    responseBodyDTO.setStatus(200);
                    responseBodyDTO.setMessage("Mã OTP đã được gửi vào email của bạn ");
                    return responseBodyDTO;
                } catch (RuntimeException e) {
                    System.out.println("--ER handleSendOTP " + e.getMessage());
                    e.printStackTrace();
                    throw e;
                }
            } else {
                responseBodyDTO.setStatus(500);
                responseBodyDTO.setMessage("Email đã được gửi mã OTP đang còn hiệu lực");
                return responseBodyDTO;
            }

        } else {
            responseBodyDTO.setStatus(500);
            responseBodyDTO.setMessage("Email chưa được đăng ký  hoặc đã có lỗi xảy ra");
            return responseBodyDTO;
        }
    }

    @Transactional
    public ResponseBodyDTO handleVerifyOTP(String email, String OTP) {
        ResponseBodyDTO response = new ResponseBodyDTO();

        response.setStatus(500);
        response.setMessage("Đã có lỗi xảy ra trong quá trình xử lý mã OTP");
        Optional<UserEntity> user = this.userRepository.findUserEntityByEmail(email);
        if (user.isPresent()) {
            // check first email have OTP not yet Expired if has userOtpEnough = have data  otherwise has no data
            List<UserOtpEntity> listUserOtp = this.userOtpRepository.findUserOtpEntityByUser(user.get());
            UserOtpEntity userOtpEnough = new UserOtpEntity();
            for (UserOtpEntity userOtp : listUserOtp) {
                if (userOtp.getExpiredTime().isAfter(LocalDateTime.now())) {
                    userOtpEnough = userOtp;
                    break;
                }
            }

            // if has userOtpEnough = have data , accept and update userOtp
            if (userOtpEnough.getId() != null) {
                boolean used = userOtpEnough.isUsed();
                String otpDb = userOtpEnough.getOtpCode();

                if (otpDb.equals(OTP) && !used) {
                    // Update OTP is used
                    try {
                        userOtpEnough.setUsed(true);
                        this.userOtpRepository.save(userOtpEnough);
                        response.setStatus(200);
                        response.setMessage("Xác thực mã OTP thành công");
                        return response;
                    } catch (RuntimeException e) {
                        System.out.println("-- ER update userOtp " + e.getMessage());
                        e.printStackTrace();
                        throw e;
                    }

                } else {
                    response.setStatus(500);
                    response.setMessage("Mã OTP không đúng hoặc  đã được sử dụng");
                    return response;
                }


                //  otherwise has no data , announcement error
            } else {
                response.setStatus(500);
                response.setMessage("Mã OTP đã hết hạn");

            }
        } else {
            response.setStatus(500);
            response.setMessage("Email không tồn tại");
            return response;
        }

        return response;


    }


    @Transactional
    public ResponseBodyDTO handleResetPassword(ResetPasswordDTO resetPasswordDTO) {
        ResponseBodyDTO response = new ResponseBodyDTO();
        response.setMessage("Có lỗi xảy ra khi đặt lại mật khẩu");
        try {
            UserEntity user = this.userRepository.findUserEntityByEmail(resetPasswordDTO.getEmail().trim()).get();
            user.setPassword(passwordEncoder.encode(resetPasswordDTO.getPassword()));
            this.userRepository.save(user);

            response.setStatus(200);
            response.setMessage("Đặt lại mật khẩu thành công");
            return response;
        } catch (RuntimeException e) {
            System.out.println("--ER " + e.getMessage());
            e.printStackTrace();
            throw e;
        }


    }


    public List<UserEntity> getAllUser() {
        return this.userRepository.findAll();
    }

    public List<UserEntity> getFirstUserByEmail(String email) {
        return this.userRepository.findFirstByEmail(email);
    }

    public List<UserEntity> getFirstUserById(long id) {
        return this.userRepository.findFirstById(id);
    }

    public UserEntity getUserUpdateById(long id) {
        return this.userRepository.findById(id);
    }

    public UserEntity getAllUserById(long id) {
        return this.userRepository.findAllById(id);
    }

    public void deleteUserById(long id) {

        this.userRepository.deleteById(id);
    }

    public RoleEntity getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }


    // check exist email


    public UserEntity getUserByEmail(String email) {
        return this.userRepository.findUserEntityByEmail(email).get();
    }

    public void handleSaveCart(UserEntity user) {
        this.cartRepository.findByUser(user);
    }
    // check login\

}
