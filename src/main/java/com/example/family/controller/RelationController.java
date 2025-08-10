package com.example.family.controller;

import com.example.family.model.Relation;
import com.example.family.service.RelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/admin/relation")
@PreAuthorize("hasRole('ADMIN')")
public class RelationController {

    @Autowired
    private RelationService relationService;

    @GetMapping("/id")
    public Relation getRelation(@RequestParam Long id) {

        return relationService.getRelation(id);
    }



    @PostMapping
    public Relation addRelation(@RequestParam String relationName) {
        return relationService.addRelation(relationName);
    }

    @PutMapping
    public Relation updateRelation(@RequestParam Relation relation) {
        return relationService.updateRelation(relation);
    }

    @DeleteMapping
    public String deleteRelation(@RequestParam Relation relation) {
        return relationService.deleteRelation(relation);
    }

}
