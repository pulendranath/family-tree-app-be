package com.example.family.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RelationsUpdateDto {
    private Long id;
    private Long oldId;
    private Long relatedUserId;
    private Long oldRelatedUserId;
    private Long oldRelationType;
    private Long relationId;

}
