package com.example.family.controller;

import com.example.family.dto.UserRegestrationDto;
import com.example.family.dto.UserResponseDto;
import com.example.family.model.User;
import com.example.family.service.RelationService;
import com.example.family.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(
        origins = "http://localhost:3000",
        allowedHeaders = "*",
        allowCredentials = "true",
        methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.OPTIONS}
)
@RestController
@RequestMapping("/myFamily")
@Tag(name = "User Management", description = "Operations related to users")
public class UserController {
    @Autowired
    private UserService userService;
    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private RelationService relationService;

    @GetMapping("/getUser")
    @Operation(summary = "Get user by ID", description = "Returns a single user")
    public UserResponseDto getUser(@RequestParam Long id) {
        log.info("Fetching user info for userId: {}", id);
        return userService.getUser(id);
    }

    @GetMapping("/getAllPersons")
    public Page<User> getAllPersons(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, @RequestParam(defaultValue = "id") String sortBy) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy));
        return userService.getAllPersons(pageable);
    }

    @PutMapping("/updateUser")
    public User update(@RequestBody UserRegestrationDto req) {
        return userService.updateUser(req);
    }
}
