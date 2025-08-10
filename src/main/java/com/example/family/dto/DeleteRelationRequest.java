package com.example.family.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteRelationRequest {
    private Long oldSourceId;
    private Long oldTargetId;
    private Long oldRelationId;
    private Long newSourceId;
    private Long newTargetId;
    private Long newRelationId;
}


