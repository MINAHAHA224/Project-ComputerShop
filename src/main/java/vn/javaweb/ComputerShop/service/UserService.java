package vn.javaweb.ComputerShop.service;

import java.util.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import vn.javaweb.ComputerShop.component.GoogleOauth2;
import vn.javaweb.ComputerShop.domain.dto.request.InformationDTO;
import vn.javaweb.ComputerShop.domain.entity.AuthMethodEntity;
import vn.javaweb.ComputerShop.domain.entity.RoleEntity;
import vn.javaweb.ComputerShop.domain.entity.UserEntity;
import vn.javaweb.ComputerShop.domain.dto.request.LoginDTO;
import vn.javaweb.ComputerShop.domain.dto.request.RegisterDTO;
import vn.javaweb.ComputerShop.repository.AuthMethodRepository;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.repository.RoleRepository;
import vn.javaweb.ComputerShop.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final CartRepository cartRepository;
    private  final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final AuthMethodRepository authMethodRepository;


    private final RestTemplate restTemplate = new RestTemplate();
    private final GoogleOauth2 googleOauth2;


    public InformationDTO handleLogin (LoginDTO loginDTO , HttpSession session ){
        String email = loginDTO.getEmail().trim();
        String password = loginDTO.getPassword().trim();
        UserEntity user = new UserEntity();
        Optional<UserEntity> emailOnDb  = this.userRepository.findUserEntityByEmail(email);
        if (emailOnDb.isPresent()){
            user = emailOnDb.get();
        }else {
            return null;
        }

        if ( !passwordEncoder.matches(password , user.getPassword())){
            return null;
        }

        // set data for Spring Security
        try {
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                    email,
                    password,
                    user.getAuthorities()
            );
            authenticationManager.authenticate(authenticationToken);
            //add data into SecurityContextHolder to view used to authorized
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            // set session
            InformationDTO informationDTO = new InformationDTO();
            informationDTO.setId(user.getId());
            informationDTO.setEmail(user.getEmail());
            informationDTO.setRole(user.getRole().getName());
            informationDTO.setFullName(user.getFullName());
            informationDTO.setAvatar(user.getAvatar());
            informationDTO.setSum(user.getCart() == null ? 0 : user.getCart().getSum());

            return informationDTO;
        }catch (RuntimeException e){
            System.out.println("--ER authenticationToken ");
            e.printStackTrace();
            return null;
        }


    }

    @Transactional
    public boolean  handleRegister (RegisterDTO registerDTO) {
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
            return true;
        }catch (RuntimeException e){
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
    public InformationDTO handleLoginOauth2Google(String code, HttpServletResponse response) {

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
        String external_id = (String)userInfo.get("sub");
        String email = (String)userInfo.get("email");
        String name = (String)userInfo.get("name");
        String picture = (String)userInfo.get("picture");

        boolean existEmail = this.userRepository.existsByEmail(email);
        // if exists => create token for security
        if ( existEmail){
            UserEntity user = this.userRepository.findUserEntityByEmail(email).get();

            informationDTO.setId(user.getId());
            informationDTO.setEmail(user.getEmail());
            informationDTO.setFullName(user.getFullName());
            informationDTO.setAvatar(user.getAvatar());
            informationDTO.setRole(user.getRole().getName());
            informationDTO.setSum(user.getCart() != null ? user.getCart().getSum()  : 0 );
            return informationDTO;
        }else {
            try {
                // save user first
                UserEntity userNew = new UserEntity();
                userNew.setEmail(email);
                userNew.setFullName(name);
                RoleEntity role = this.roleRepository.findByName("USER");
                userNew.setRole(role);
                UserEntity userCurrent =  this.userRepository.save(userNew);

                // save AuthMethod second
                AuthMethodEntity authMethod = new AuthMethodEntity();
                authMethod.setUser(userCurrent);
                authMethod.setLogin_type("GOOGLE");
                authMethod.setExternal_id(external_id);
                this.authMethodRepository.save(authMethod);



            }catch (RuntimeException e){
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
            return informationDTO;

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
