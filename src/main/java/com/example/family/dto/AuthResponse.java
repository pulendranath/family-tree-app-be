package com.example.family.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthResponse {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public String token;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public String refreshToken;
}