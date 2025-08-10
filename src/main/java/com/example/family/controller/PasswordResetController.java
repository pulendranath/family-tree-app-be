package com.example.family.controller;

import com.example.family.model.ResetPasswordRequest;
import com.example.family.model.User;
import com.example.family.service.PasswordResetTokenService;
import com.example.family.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/myFamily")
public class PasswordResetController {

    @Autowired
    private PasswordResetTokenService tokenService;

    @Autowired
    private UserService userService;

    @GetMapping("/validate-reset-token")
    public ResponseEntity<?> validateToken(@RequestParam String token) {
        boolean valid = tokenService.validateToken(token);
        if (valid) {
            return ResponseEntity.ok("Token is valid");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Token expired or invalid"));
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody ResetPasswordRequest request) {
       /* boolean valid = tokenService.validateToken(request.getToken());
        if (!valid) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Invalid or expired token"));
        }*/

        User user = tokenService.getUserByToken(request.getToken());
        userService.updatePassword(user, request.getNewPassword());

        tokenService.invalidateToken(request.getToken()); // Optional

        return ResponseEntity.ok(Map.of("message", "Password reset successfully"));
    }
}

