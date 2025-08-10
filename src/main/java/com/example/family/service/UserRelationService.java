package com.example.family.service;

import com.example.family.dto.*;
import com.example.family.exception.InvalidInputException;
import com.example.family.model.*;
import com.example.family.repository.FamilyTreeRepository;
import com.example.family.repository.RelationsRepository;
import com.example.family.repository.UserRelationsRepository;
import com.example.family.repository.UserRepository;
import com.example.family.util.ValidationUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserRelationService {

    @Autowired
    public UserRelationsRepository userRelationsRepository;
    @Autowired
    private UserRepository userRepository;

    @Autowired
    public RelationsRepository relationsRepository;

    @Autowired
    private FamilyTreeRepository familyTreeRepository;

    public UserRelation addAncestor(DeleteRelationRequest deleteRelationRequest) {

        //userid
        User existingUser = userRepository.findById(deleteRelationRequest.getNewSourceId()).orElse(null);
        if (existingUser == null) {
            throw new RuntimeException("User not exists");
        }

        //relativeuserid
        User relativeUser = userRepository.findById(deleteRelationRequest.getNewTargetId()).orElse(null);
        if (relativeUser == null) {
            throw new RuntimeException("relativeUser not exists");
        }

        //relationid
        Relation relation = relationsRepository.findById(deleteRelationRequest.getNewRelationId()).orElse(null);
        if (relation == null) {
            throw new RuntimeException("relation not exists");
        }

        boolean exists = userRelationsRepository.existsByUserAndRelatedUserAndRelationType(existingUser.getId(), relativeUser.getId(), relation.getId());
        if (exists) {
            throw new RuntimeException("Relation already exists.");
        }


        UserRelation userRelation = new UserRelation();
        userRelation.setUser(existingUser);
        userRelation.setRelatedUser(relativeUser);
        userRelation.setRelation(relation);

        return userRelationsRepository.save(userRelation);
    }

    @Transactional
    public UserRelation updateAncestor(DeleteRelationRequest deleteRelationRequest) {

        //userid
        User existingUser = userRepository.findById(deleteRelationRequest.getOldSourceId()).orElse(null);
        if (existingUser == null) {
            throw new RuntimeException("User not exists");
        }

        //relativeuserid
        User existingRelativeUser = userRepository.findById(deleteRelationRequest.getOldTargetId()).orElse(null);
        if (existingRelativeUser == null) {
            throw new RuntimeException("relativeUser not exists");
        }

        //relationid
        Relation existingRelation = relationsRepository.findById(deleteRelationRequest.getOldRelationId()).orElse(null);
        if (existingRelation == null) {
            throw new RuntimeException("relation not exists");
        }

        //userid
        User newUser = userRepository.findById(deleteRelationRequest.getNewSourceId()).orElse(null);
        if (newUser == null) {
            throw new RuntimeException("User not exists");
        }

        //relativeuserid
        User newRelativeUser = userRepository.findById(deleteRelationRequest.getNewTargetId()).orElse(null);
        if (newRelativeUser == null) {
            throw new RuntimeException("relativeUser not exists");
        }

        //relationid
        Relation newRelation = relationsRepository.findById(deleteRelationRequest.getNewRelationId()).orElse(null);
        if (newRelation == null) {
            throw new RuntimeException("relation not exists");
        }

        boolean newRelationExists = userRelationsRepository.existsByUserAndRelatedUserAndRelationType(newUser.getId(), newRelativeUser.getId(), newRelation.getId());
        if (newRelationExists) {
            throw new RuntimeException("Nothing to change.");
        }

        boolean newTargetRelationExists = userRelationsRepository.existsByUserAndRelatedUserAndRelationType(deleteRelationRequest.getNewSourceId(), deleteRelationRequest.getNewTargetId(), deleteRelationRequest.getNewRelationId());
        if (newTargetRelationExists) {
            throw new RuntimeException("Relation already exists.");
        }

        int updatedCount= userRelationsRepository.updateRelation(deleteRelationRequest.getOldSourceId(), deleteRelationRequest.getOldTargetId(), deleteRelationRequest.getOldRelationId(),
                deleteRelationRequest.getNewSourceId(), deleteRelationRequest.getNewTargetId(), deleteRelationRequest.getNewRelationId());

        if (updatedCount == 0) {
            throw new RuntimeException("No matching relation found to update.");
        }
        return userRelationsRepository.findByUserIdsAndRelationId( deleteRelationRequest.getNewSourceId(), deleteRelationRequest.getNewTargetId(), deleteRelationRequest.getNewRelationId())
                .orElseThrow(() -> new RuntimeException("Updated relation not found"));
    }


    public Page<User> searchPersons(String name, Pageable pageable) {


        if (ValidationUtil.isNumeric(name) && ValidationUtil.isNullOrZero(Long.valueOf(name))) {
            return userRepository.finBydMobileNumberORAadhar(Long.valueOf(name), pageable);
        } else {
            return userRepository.searchByMultipleFields(name, pageable);
        }
    }

    public FamilyNode getAllUsersWithRelations1(Pageable pageable) throws JsonProcessingException {


        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

        String json = mapper.writeValueAsString(getAncestorsFromLeaf(1l));
        System.out.println(json);

        return buildTreeFromRoot(1l);

    }

    public List<FamilyTreeNode> getAllUserRelations(Pageable pageable) {
        List<FamilyTreeNode> familyTreeNodes = familyTreeRepository.getFamilyTree(2);
        for (FamilyTreeNode familyTreeNode : familyTreeNodes) {
            if (familyTreeNode.getSpouseId() != null) {
                for (FamilyTreeNode familyTreeNode1 : familyTreeNodes) {
                    if (familyTreeNode1.getId().equals(familyTreeNode.getSpouseId())) {
                        familyTreeNode1.setSpouseId(familyTreeNode.getId());
                    }
                }
            }

        }
        return familyTreeNodes;
    }

    public List<UserRelationProjection> getAllUserRelations(Long id, Pageable pageable) {

        return userRelationsRepository.getAllUserRelations(id);
    }

    public List<UserRelationDTO> getAllUserRelations1(Pageable pageable) {

        List<Object[]> rows = userRelationsRepository.getAllUserRelations1();

        List<UserRelationDTO> result = new ArrayList<>();

        for (Object[] row : rows) {
            UserRelationDTO node = new UserRelationDTO(
                    ((Number) row[0]).longValue(),        // child_id
                    (String) row[1],                      // child_name
                    ((Number) row[2]).longValue(),        // parent_id
                    (String) row[3],                      // parent_name
                    (String) row[4]                       // relation
            );
            result.add(node);
        }

        return result;



       /* for (UserRelation ur : userRelationsRepository.findAllRelationsForUser()) {
            Long userId = ur.getUser().getId();

            System.out.println("userId: " + userId);
            UserWithRelationsDTO dto = map.computeIfAbsent(userId, id -> {
                User u = ur.getUser();
                UserWithRelationsDTO d = new UserWithRelationsDTO();
                d.setUserId(id);
                d.setName(u.getFirstName() + " " + u.getLastName());
                d.setRelations(new ArrayList<>());
                return d;
            });

            UserWithRelationsDTO.RelationDTO r = new UserWithRelationsDTO.RelationDTO();
            r.setRelationName(ur.getRelation().getName());
            r.setRelatedUserId(ur.getRelatedUser().getId());
            r.setRelatedUserName(ur.getRelatedUser().getFirstName() + " " + ur.getRelatedUser().getLastName());
            dto.getRelations().add(r);
        }*/

        // return new PageImpl<>(new ArrayList<>(map.values()), PageRequest.of(pageable.getPageNumber(), pageable.getPageSize()), map.values().size());

    }

    public FamilyNode buildTreeFromRoot(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        FamilyNode root = new FamilyNode();
        root.setUser(user);
        root.setRelation("Self");

        addChildrenRecursive(root);
        return root;
    }

    private void addChildrenRecursive(FamilyNode parentNode) {
        List<UserRelation> childrenRelations = userRelationsRepository.findByRelatedUserId(parentNode.getUser().getId());

        for (UserRelation rel : childrenRelations) {
            FamilyNode childNode = new FamilyNode();
            childNode.setUser(rel.getUser());
            childNode.setRelation(rel.getRelation().getName());
            parentNode.getChildren().add(childNode);

            addChildrenRecursive(childNode); // recursive step
        }
    }

    // returns up to 4 generations: parent, grandparent, ...
    public List<UserRelationsDTO> getAncestors(Long userId) {
        if (ValidationUtil.isNullOrZero(userId)) {
            throw new InvalidInputException(userId + " must not be null or zero.");
        }
        return userRelationsRepository.findAllRelationsForUserId(userId);
    }


    public List<FamilyNode> getAncestorsFromLeaf(Long userId) {
        List<FamilyNode> path = new ArrayList<>();
        getAncestorRecursive(userId, path);
        return path;
    }

    private void getAncestorRecursive(Long userId, List<FamilyNode> path) {
        User current = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        FamilyNode node = new FamilyNode();
        node.setUser(current);
        node.setRelation("Self");
        path.add(node);

        List<UserRelation> parentRel = userRelationsRepository.findByUserId(userId);
        if (parentRel != null) {
            for (UserRelation rel : parentRel) {
                FamilyNode parentNode = new FamilyNode();
                parentNode.setUser(rel.getRelatedUser());
                parentNode.setRelation(rel.getRelation().getName());
                path.add(parentNode);

                getAncestorRecursive(rel.getRelatedUser().getId(), path); // go up
            }
        }
    }

    public String deleteAncestor(DeleteRelationRequest deleteRelationRequest) {

        //userid
        User existingUser = userRepository.findById(deleteRelationRequest.getOldSourceId()).orElse(null);
        if (existingUser == null) {
            throw new RuntimeException("User not exists");
        }

        //relativeuserid
        User relativeUser = userRepository.findById(deleteRelationRequest.getOldTargetId()).orElse(null);
        if (relativeUser == null) {
            throw new RuntimeException("relativeUser not exists");
        }

        //relationid
        Relation relation = relationsRepository.findById(deleteRelationRequest.getOldRelationId()).orElse(null);
        if (relation == null) {
            throw new RuntimeException("relation not exists");
        }

        boolean exists = userRelationsRepository.existsByUserAndRelatedUserAndRelationType(existingUser.getId(), relativeUser.getId(), deleteRelationRequest.getOldRelationId());
        if (!exists) {
            throw new RuntimeException("Relation not exists.");
        }

        try {
            userRelationsRepository.deleteByUserIdAndRelatedUserIdAndRelationType(existingUser.getId(), relativeUser.getId(),relation.getId() );
            return "user relation deleted successfully";
        } catch (Exception exception) {
            throw new RuntimeException("unable to delete user relations");
        }
    }
}
