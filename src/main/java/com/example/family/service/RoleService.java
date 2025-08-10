package com.example.family.service;

import com.example.family.model.Role;
import com.example.family.repository.RolesRepository;
import com.example.family.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RoleService {

    @Autowired
    public RolesRepository rolesRepository;


    public Role getRole(Long roleId) throws UsernameNotFoundException {
        try {
            return rolesRepository.findById(roleId).orElse(null);
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error fetching Role: " + ex.getMessage());
        }
    }

    public Page<Role> getRoles(Pageable pageable) throws UsernameNotFoundException {
        try {
            return rolesRepository.findAll(pageable);
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error fetching Role: " + ex.getMessage());
        }
    }

    public Role addRole(String roleName) throws UsernameNotFoundException {
        try {
            if (rolesRepository.findByName(roleName).isPresent())
                throw new RuntimeException("roleName exists");
            Role role = new Role();
            role.setName(roleName);
            return rolesRepository.save(role);
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error creating Role: " + ex.getMessage());
        }
    }


    @Transactional
    public Role updateRole(Role role) {

        if (role == null) {
            throw new RuntimeException("Input json data is null");
        }
        if (!ValidationUtil.isValidEmail(role.getName())) {
            throw new RuntimeException("roleName invalid");
        }
        Role existingRole = rolesRepository.findByName(role.getName()).orElse(null);
        if (existingRole == null) {
            throw new RuntimeException("Role not exists");
        }
        return rolesRepository.save(role);

    }

    @Transactional
    public String deleteRole(Role role) {

        if (role == null) {
            throw new RuntimeException("Input json data is null");
        }
        if (!ValidationUtil.isValidEmail(role.getName())) {
            throw new RuntimeException("roleName invalid");
        }
        Role existingRole = rolesRepository.findByName(role.getName()).orElse(null);
        if (existingRole == null) {
            throw new RuntimeException("Role not exists");
        }
        rolesRepository.delete(role);
        return "Role deleted successfully";

    }

}
