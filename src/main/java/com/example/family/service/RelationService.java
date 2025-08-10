package com.example.family.service;

import com.example.family.model.Relation;
import com.example.family.repository.RelationsRepository;
import com.example.family.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RelationService {

    @Autowired
    public RelationsRepository relationsRepository;


    public Relation getRelation(Long relationId) throws UsernameNotFoundException {
        try {
            return relationsRepository.findById(relationId).orElse(null);
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error fetching relationName: " + ex.getMessage());
        }
    }

    public List<Relation> getRelations() throws UsernameNotFoundException {
        try {
            return relationsRepository.findAll();
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error fetching relationName: " + ex.getMessage());
        }
    }

    public Relation addRelation(String relationName) throws UsernameNotFoundException {
        try {
            if (relationsRepository.findByName(relationName).isPresent())
                throw new RuntimeException("relationName exists");
            Relation relation = new Relation();
            relation.setName(relationName);
            return relationsRepository.save(relation);
        } catch (Exception ex) {
            // log the actual exception for debugging
            throw new UsernameNotFoundException("Error creating relation: " + ex.getMessage());
        }
    }


    @Transactional
    public Relation updateRelation(Relation relation) {

        if (relation == null) {
            throw new RuntimeException("Input json data is null");
        }
        if (!ValidationUtil.isValidEmail(relation.getName())) {
            throw new RuntimeException("relationName invalid");
        }
        Relation existingRelation = relationsRepository.findByName(relation.getName()).orElse(null);
        if (existingRelation == null) {
            throw new RuntimeException("Relation not exists");
        }
        return relationsRepository.save(relation);

    }

    @Transactional
    public String deleteRelation(Relation relation) {

        if (relation == null) {
            throw new RuntimeException("Input json data is null");
        }
        if (!ValidationUtil.isValidEmail(relation.getName())) {
            throw new RuntimeException("relationName invalid");
        }
        Relation existingRelation = relationsRepository.findByName(relation.getName()).orElse(null);
        if (existingRelation == null) {
            throw new RuntimeException("Relation not exists");
        }
        relationsRepository.delete(relation);
        return "Relation deleted successfully";

    }

}
