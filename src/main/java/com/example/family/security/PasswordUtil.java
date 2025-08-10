package com.example.family.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

@Component
public class PasswordUtil {

    private final PasswordEncoder passwordEncoder;
    private final String passKey;

    public PasswordUtil(PasswordEncoder passwordEncoder, @Value("${jwt.secret}") String passKey) {
        this.passwordEncoder = passwordEncoder;
        this.passKey = passKey;
    }

    public String hashPassword(String password) {
        System.out.println("passKey: " + passKey);
        return passwordEncoder.encode(password + passKey); // Optional: Add passKey for extra security
    }

}
