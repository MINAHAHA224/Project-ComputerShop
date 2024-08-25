package vn.javaweb.ComputerShop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.javaweb.ComputerShop.domain.Role;
import vn.javaweb.ComputerShop.domain.User;
import vn.javaweb.ComputerShop.domain.dto.RegisterDTO;
import vn.javaweb.ComputerShop.repository.CartRepository;
import vn.javaweb.ComputerShop.repository.RoleRepository;
import vn.javaweb.ComputerShop.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final CartRepository cartRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, CartRepository cartRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.cartRepository = cartRepository;
    }

    public User handleSaveUser(User a) {
        User eric = this.userRepository.save(a);

        return eric;
    }

    public List<User> getAllUser() {
        return this.userRepository.findAll();
    }

    public List<User> getFirstUserByEmail(String email) {
        return this.userRepository.findFirstByEmail(email);
    }

    public List<User> getFirstUserById(long id) {
        return this.userRepository.findFirstById(id);
    }

    public User getUserUpdateById(long id) {
        return this.userRepository.findById(id);
    }

    public User getAllUserById(long id) {
        return this.userRepository.findAllById(id);
    }

    public void deleteUserById(long id) {

        this.userRepository.deleteById(id);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassWord());
        return user;
    }

    // check exist email
    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findUserByEmail(email);
    }

    public void handleSaveCart(User user) {
        this.cartRepository.findByUser(user);
    }
    // check login\

}
