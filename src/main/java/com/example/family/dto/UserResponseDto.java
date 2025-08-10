package com.example.family.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.time.LocalDate;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponseDto {

    private Long id;
    private String email;
    private String firstName;
    private String lastName;
    private String fullName;
    private String gender;
    private LocalDate dob;
    private LocalDate dod;
    private Long mobileNumber;
    private Long otherMobileNumber;
    private String address1;
    private String address2;
    private String address3;
    private String village;
    private String state;
    private String district;
    private String nationality;
    private Integer pinCode;
    private Long aadhar;
    private String homePhone;

}
