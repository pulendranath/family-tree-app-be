package com.example.family.controller;

import com.example.family.model.Role;
import com.example.family.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/admin/role")
@PreAuthorize("hasRole('ADMIN')")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @GetMapping("/id")
    public Role getRole(@RequestParam Long id) {

        return roleService.getRole(id);
    }

    @GetMapping
    public Page<Role> getRoles(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, @RequestParam(defaultValue = "id") String sortBy) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy));
        return roleService.getRoles(pageable);
    }

    @PostMapping
    public Role addRole(@RequestParam String roleName) {
        return roleService.addRole(roleName);
    }

    @PutMapping
    public Role updateRole(@RequestParam Role role) {
        return roleService.updateRole(role);
    }

    @DeleteMapping
    public String deleteRole(@RequestParam Role role) {
        return roleService.deleteRole(role);
    }

}
