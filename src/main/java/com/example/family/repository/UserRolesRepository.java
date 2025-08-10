package com.example.family.repository;

import com.example.family.model.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

public interface UserRolesRepository extends JpaRepository<UserRole, Long> {

    //insert into userRoles
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO user_roles(user_id, role_id) VALUES (:userId, :roleId)", nativeQuery = true)
    void assignRole(@Param("userId") Long userId, @Param("roleId") Integer roleId);


    Optional<UserRole> findByUserId(Long userId);

}
