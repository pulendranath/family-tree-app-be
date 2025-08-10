package com.example.family.repository;

import com.example.family.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String emailId);

    Optional<User> findByMobileNumber(Long mobileNumber);

    Optional<User> findByAadhar(long aadharId);

    Page<User> findByFirstNameContainingIgnoreCase(String firstName, Pageable pageable);

    Page<User> findAll(Pageable pageable); // For generic list
    @Query(value = "SELECT * FROM users WHERE " +
            "LOWER(first_name) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(last_name) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(email) LIKE LOWER(CONCAT('%', :query, '%'))", nativeQuery = true)
    Page<User> searchByMultipleFields(@Param("query") String query, Pageable pageable);

    @Query(value = "select u.* FROM users u WHERE u.mobile_number LIKE (CONCAT('%', :query, '%')) OR u.aadhar LIKE (CONCAT('%', :query, '%'))", nativeQuery = true)
    Page<User> finBydMobileNumberORAadhar(@Param("query") Long number, Pageable pageable);


}
