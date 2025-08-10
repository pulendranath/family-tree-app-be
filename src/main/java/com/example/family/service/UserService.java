package com.example.family.service;

import com.example.family.dto.UserRegestrationDto;
import com.example.family.dto.UserResponseDto;
import com.example.family.exception.InvalidInputException;
import com.example.family.model.*;
import com.example.family.repository.*;
import com.example.family.security.PasswordUtil;
import com.example.family.util.EmailService;
import com.example.family.util.ValidationUtil;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    public UserRolesRepository userRolesRepository;
    @Autowired
    public RelationsRepository relationsRepository;
    @Autowired
    public UserRelationsRepository userRelationsRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    public RolesRepository rolesRepository;
    @Autowired
    private PasswordUtil passwordUtil;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PasswordResetTokenRepository tokenRepository;

    @Override
    public UserDetails loadUserByUsername(String emailId) throws UsernameNotFoundException {
        try {
            return userRepository.findByEmail(emailId).orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + emailId));
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error fetching user: " + ex.getMessage());
        }
    }

    @Transactional
    public User register(UserRegestrationDto userRegestrationDto) {

        if (userRepository.findByEmail(userRegestrationDto.getEmail()).isPresent())
            throw new RuntimeException("Username exists");
        ModelMapper modelMapper = new ModelMapper();
        userRegestrationDto.setPassword(passwordUtil.hashPassword(userRegestrationDto.getPassword()));
        User user = modelMapper.map(userRegestrationDto, User.class);
        User newUser = userRepository.save(user);

        String roleName = userRegestrationDto.getRoleName() != null ? userRegestrationDto.getRoleName() : "ROLE_USER";
        Optional<Role> role = rolesRepository.findByName(roleName);
        role.ifPresent(value -> userRolesRepository.assignRole(newUser.getId(), value.getId()));
        return newUser;
    }

    // returns up to 4 generations: parent, grandparent, ...
    public UserResponseDto getUser(Long userId) {
        if (ValidationUtil.isNullOrZero(userId)) {
            throw new InvalidInputException(userId + " must not be null or zero.");
        }
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            ModelMapper modelMapper = new ModelMapper();
            return modelMapper.map(user, UserResponseDto.class);
        }
        return new UserResponseDto();

    }


    public Page<User> getAllPersons(Pageable pageable) {
        return userRepository.findAll(pageable);
    }


    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional
    public User updateUser(UserRegestrationDto userRegestrationDto) {

        if (userRegestrationDto == null) {
            throw new RuntimeException("Input json data is null");
        }

        User existingUser = userRepository.findById(userRegestrationDto.getId()).orElse(null);
        if (existingUser == null) {
            throw new RuntimeException("User not exists");
        }
        if (!existingUser.getEmail().equalsIgnoreCase(userRegestrationDto.getEmail())) {
            throw new RuntimeException("Email id shouldn't be change");
        }
        ModelMapper modelMapper = new ModelMapper();
        userRegestrationDto.setPassword(existingUser.getPassword());
        userRegestrationDto.setId(existingUser.getId());
        User user = modelMapper.map(userRegestrationDto, User.class);
        User updatedUser = userRepository.save(user);

        //update relation here
        if (!ValidationUtil.isNullOrZero(userRegestrationDto.getRelatedUserId())) {
            UserRelation userRelation = new UserRelation();
            userRelation.setUser(updatedUser);
            userRelation.setRelatedUser(userRepository.findById(userRegestrationDto.getRelatedUserId()).orElse(null));
            userRelation.setRelation(relationsRepository.findById(userRegestrationDto.getRelationId()).orElse(null));
            userRelationsRepository.save(userRelation);
        }

        if (!ValidationUtil.isNullOrZero(existingUser.getId())) {
            UserRole userRole = userRolesRepository.findByUserId(existingUser.getId()).orElse(null);
            if (userRole == null) {
                String roleName = userRegestrationDto.getRoleName() != null ? userRegestrationDto.getRoleName() : "ROLE_USER";
                Optional<Role> role = rolesRepository.findByName(roleName);
                role.ifPresent(value -> userRolesRepository.assignRole(updatedUser.getId(), value.getId()));
            }
        }
        return updatedUser;
    }


    public boolean sendResetLink(String email) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (!optionalUser.isPresent()) {
            return false;
        }
        String token = UUID.randomUUID().toString();

        User user= optionalUser.get();
        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setToken(token);
        resetToken.setUser(user);
        resetToken.setEmail(user.getEmail());
        resetToken.setExpiryDate(LocalDateTime.now().plusHours(1));
        tokenRepository.save(resetToken);
        emailService.send(email, token);

        return true;
    }

    public void updatePassword(User user, String newPassword) {
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        userRepository.save(user);
    }

}
