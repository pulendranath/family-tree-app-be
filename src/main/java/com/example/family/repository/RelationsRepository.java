package com.example.family.repository;

import com.example.family.model.Relation;
import com.example.family.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RelationsRepository extends JpaRepository<Relation, Long> {
    Optional<Relation> findByName(String name);
}
