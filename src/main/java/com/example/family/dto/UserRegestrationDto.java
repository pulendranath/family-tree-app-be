package com.example.family.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserRegestrationDto {
    private Long id;
    private String email;
    private String password;
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
    private Long relatedUserId;
    private Long relationId;
    private String roleName;
    private String relationType;
}
