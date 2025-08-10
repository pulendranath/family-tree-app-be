package com.example.family.controller;

import com.example.family.dto.*;
import com.example.family.model.*;
import com.example.family.service.RelationService;
import com.example.family.service.TranslationService;
import com.example.family.service.UserRelationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/myFamily")
@Tag(name = "User Management", description = "Operations related to users")
public class UserRelationController {

    private static final Logger log = LoggerFactory.getLogger(UserRelationController.class);
    @Autowired
    private RelationService relationService;
    @Autowired
    private UserRelationService userRelationService;

    @Autowired
    private TranslationService translationService;


    @GetMapping("/getRelationTypes")
    public List<Relation> getRelations() {
        return relationService.getRelations();
    }

    @PostMapping("/addAncestor")
    public UserRelation addAncestor(@RequestBody DeleteRelationRequest deleteRelationRequest) {
        return userRelationService.addAncestor(deleteRelationRequest);
    }

    @PutMapping("/updateAncestor")
    public UserRelation updateAncestor(@RequestBody DeleteRelationRequest deleteRelationRequest) {
        return userRelationService.updateAncestor(deleteRelationRequest);
    }

    @GetMapping("/search")
    public Page<User> searchPersons(@RequestParam(defaultValue = "") String name, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        return userRelationService.searchPersons(name, pageable);
    }

    @GetMapping("/getAllUserRelations")
    public List<FamilyTreeNode> getAllUserRelations(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        return userRelationService.getAllUserRelations(pageable);
    }

    @GetMapping("/getAllUserRelation")
    public List<UserRelationProjection> getAllUserRelation(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, @RequestParam Long id) {
        Pageable pageable = PageRequest.of(page, size);
        return userRelationService.getAllUserRelations(id, pageable);
    }

    @GetMapping("/getAncestors")
    public List<UserRelationsDTO> getAncestors(@RequestParam Long id) {
        log.info("Fetching Ancestors info for userId: {}", id);
        return userRelationService.getAncestors(id);
    }


    @DeleteMapping("/deleteAncestor")
    public String deleteAncestor(@RequestBody DeleteRelationRequest deleteRelationRequest) {
        return userRelationService.deleteAncestor(deleteRelationRequest);
    }



}
