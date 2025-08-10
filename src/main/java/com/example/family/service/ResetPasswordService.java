package com.example.family.service;

import com.example.family.model.PasswordResetToken;
import com.example.family.model.User;
import com.example.family.repository.PasswordResetTokenRepository;
import com.example.family.repository.UserRepository;
import com.example.family.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ResetPasswordService {

    @Autowired
    private PasswordResetTokenRepository tokenRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public String resetPassword(String token, String newPassword) {
        PasswordResetToken tokenRepoByToken = tokenRepo.findByToken(token);
        if (tokenRepoByToken == null) {
            return "Invalid token";
        }

        var resetToken = tokenRepoByToken.getToken();
        if (tokenRepoByToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            return "Token expired";
        }

        var optionalUser = userRepo.findByEmail(tokenRepoByToken.getEmail());
        if (optionalUser.isEmpty()) {
            return "User not found";
        }

        var user = optionalUser.get();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepo.save(user);
        tokenRepo.deleteByEmail(user.getEmail());

        return "Password successfully reset";
    }


    public boolean validateToken(String token) {
        PasswordResetToken prt = tokenRepo.findByToken(token);
        return prt != null && prt.getExpiryDate().isAfter(LocalDateTime.now());
    }

    public User getUserByToken(String token) {
        PasswordResetToken prt = tokenRepo.findByToken(token);
        return prt.getUser();
    }

    public void invalidateToken(String token) {
        PasswordResetToken prt = tokenRepo.findByToken(token);
        if (prt != null) tokenRepo.delete(prt);
    }
}

