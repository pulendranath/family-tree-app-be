package com.example.family.util;

import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Path;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void send(String toEmail, String token) {
        try{
            String resetLink = "http://localhost:3000/reset-password?token=" + token;

            String htmlContent =
                    Files.readString(Path.of("src/main/resources/mail/reset-password.html"))
                            .replace("{{RESET_LINK}}", resetLink);

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(toEmail);
            helper.setSubject("Reset Your Password");
            helper.setText(htmlContent, true); // true = is HTML
            helper.setFrom("your-email@gmail.com");

            mailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}

