package com.example.family.dto;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@SqlResultSetMapping(
        name = "FamilyTreeMapping",
        classes = @ConstructorResult(
                targetClass = FamilyTreeNode.class,
                columns = {
                        @ColumnResult(name = "id", type = Long.class),
                        @ColumnResult(name = "first_name", type = String.class),
                        @ColumnResult(name = "last_name", type = String.class),
                        @ColumnResult(name = "gender", type = String.class),
                        @ColumnResult(name = "dob", type = LocalDate.class),
                        @ColumnResult(name = "dod", type = LocalDate.class),
                        @ColumnResult(name = "parent_id", type = Long.class),
                        @ColumnResult(name = "generation", type = Integer.class),
                }
        )
)
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class FamilyTreeNode {
    @Id
    private Integer id;
    private String firstName;
    private String lastName;
    private String fullName;
    private String gender;
    private LocalDate dob;
    private LocalDate dod;
    private Integer parentId;
    private Integer generation;
    private Integer spouseId;
    private String imageUrl;
    private Integer familyGroupId;


}

