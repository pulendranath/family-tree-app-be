package com.example.family.controller;

import com.example.family.dto.AuthRequest;
import com.example.family.dto.AuthResponse;
import com.example.family.dto.UserRegestrationDto;
import com.example.family.model.PasswordResetToken;
import com.example.family.model.ResetPasswordRequest;
import com.example.family.model.User;
import com.example.family.repository.PasswordResetTokenRepository;
import com.example.family.security.JwtUtil;
import com.example.family.service.ResetPasswordService;
import com.example.family.service.UserService;
import com.example.family.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Optional;

@CrossOrigin(
        origins = "http://localhost:3000",
        allowedHeaders = "*",
        allowCredentials = "true",
        methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.OPTIONS}
)
@RestController
@RequestMapping("/myFamily")
public class AuthController {
    @Autowired
    private UserService userService;
    @Autowired
    private AuthenticationManager authManager;
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private PasswordResetTokenRepository tokenRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Value("${jwt.secret}")
    String passKey;

    @Autowired
    private ResetPasswordService resetPasswordService;



    @PostMapping("/register")
    public String register(@RequestBody UserRegestrationDto req) {

        if (req == null) {
            return "Input json data is null";
        }
        if (!ValidationUtil.isValidEmail(req.getEmail())) {
            return "EmailId invalid";
        }
        if (!ValidationUtil.isValidPassword(req.getPassword())) {
            return "Password invalid";
        }

        User u = userService.register(req);
        return "User registered: " + u.getUsername() + " (id: " + u.getId() + ")";
    }

    @PostMapping("/login")
    public ResponseEntity login(@RequestBody AuthRequest req) {
        try {
            /*Authentication auth = authManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            req.getEmail(),
                            req.getPassword() + passKey
                    )
            );*/

            //String role = auth.getAuthorities().iterator().next().getAuthority();
            Optional<User> us = userService.findByEmail(req.getEmail());
            //String token = jwtUtil.generateToken(req.getEmail(), (us.isPresent() ? us.get().getId() : 0), role);
            String token = jwtUtil.generateToken("abc@gmail.com", 2L, "ADMIN");
            //String refreshToken = jwtUtil.generateRefreshToken(req.getEmail(), (us.isPresent() ? us.get().getId() : 0), role);
            String refreshToken = jwtUtil.generateRefreshToken("abc@gmail.com", 5L, "ADMIN");

            return ResponseEntity.ok(new AuthResponse(token, refreshToken));

        } catch (BadCredentialsException ex) {

            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<String> forgotPassword(@RequestBody AuthRequest authRequest) {
        //String email = request.get("email");
        if (authRequest == null || !ValidationUtil.isValidEmail(authRequest.getEmail())) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Invalid input");
        }
        boolean success = userService.sendResetLink(authRequest.getEmail());
        if (success) {
            return ResponseEntity.ok("Reset link sent to your email");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
        // return ResponseEntity.ok("Reset link sent to your email");
    }

}
