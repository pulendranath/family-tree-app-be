package com.example.family.dto;

import lombok.Data;

import java.util.List;


@Data
public class UserWithRelationsDTO {
    private Long userId;
    private String name;
    private List<RelationDTO> relations;

    @Data
    public static class RelationDTO {
        private String relationName;
        private Long relatedUserId;
        private String relatedUserName;
    }
}

