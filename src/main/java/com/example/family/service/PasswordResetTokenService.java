package com.example.family.service;

import com.example.family.model.PasswordResetToken;
import com.example.family.model.User;
import com.example.family.repository.PasswordResetTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class PasswordResetTokenService {

    @Autowired
    private PasswordResetTokenRepository tokenRepo;

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

