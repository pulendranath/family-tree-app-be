package com.example.family.repository;

import com.example.family.dto.FamilyTreeNode;
import com.example.family.model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface UserRelationsRepository extends JpaRepository<UserRelation, Long> {



    @Query(value = "  SELECT \n " +
            "  ur.user_id AS sourceId,\n " +
            "  CONCAT(u1.first_name, ' ', u1.last_name) AS sourceName,\n " +
            "  r.name AS relationType,  r.id AS relationId, \n " +
            "  ur.related_user_id AS targetId,\n " +
            "  CONCAT(u2.first_name, ' ', u2.last_name) AS targetName,\n " +
            "  'FORWARD' AS direction\n " +
            " FROM user_relations ur\n " +
            " JOIN users u1 ON ur.user_id = u1.id\n " +
            " JOIN users u2 ON ur.related_user_id = u2.id\n " +
            " JOIN relations r ON ur.relation_id = r.id\n " +
            " WHERE ur.user_id = :userId \n " +
            "\n " +
            " UNION\n " +
            "\n " +
            " SELECT \n " +
            "  ur.related_user_id AS sourceId,\n " +
            "  CONCAT(u2.first_name, ' ', u2.last_name) AS sourceName,\n " +
            "  r.name AS relationType,  r.id AS relationId, \n " +
            "  ur.user_id AS targetId,\n " +
            "  CONCAT(u1.first_name, ' ', u1.last_name) AS targetName,\n " +
            "  'REVERSE' AS direction\n " +
            " FROM user_relations ur\n " +
            " JOIN users u1 ON ur.user_id = u1.id\n " +
            " JOIN users u2 ON ur.related_user_id = u2.id\n " +
            " JOIN relations r ON ur.relation_id = r.id\n " +
            "WHERE ur.related_user_id = :userId ", nativeQuery = true)
    List<UserRelationsDTO> findAllRelationsForUserId(@Param("userId") Long userId);


    @Query(value = "WITH RECURSIVE family_tree AS (\n " +
            "  SELECT\n " +
            "    ur.user_id AS child_id,\n " +
            "    u.last_name AS child_name,\n " +
            "    ur.related_user_id AS parent_id,\n " +
            "    rp.last_name AS parent_name,\n " +
            "    r.name AS relation\n " +
            "  FROM user_relations ur\n " +
            "  JOIN users u ON ur.user_id = u.id\n " +
            "  JOIN users rp ON ur.related_user_id = rp.id\n " +
            "  JOIN relations r ON ur.relation_id = r.id\n " +
            "  WHERE ur.related_user_id = 3 -- START FROM A ROOT USER ID\n " +
            "\n " +
            "  UNION ALL\n " +
            "\n " +
            "  SELECT\n " +
            "    ur2.user_id AS child_id,\n " +
            "    u2.last_name AS child_name,\n " +
            "    ur2.related_user_id AS parent_id,\n " +
            "    rp2.last_name AS parent_name,\n " +
            "    r2.name AS relation\n " +
            "  FROM user_relations ur2\n " +
            "  JOIN users u2 ON ur2.user_id = u2.id\n " +
            "  JOIN users rp2 ON ur2.related_user_id = rp2.id\n " +
            "  JOIN relations r2 ON ur2.relation_id = r2.id\n " +
            "  JOIN family_tree ft ON ur2.related_user_id = ft.child_id\n " +
            ")\n " +
            "SELECT * FROM family_tree;",
            nativeQuery = true)
    List<Object[]> getAllUserRelations1();

    @Query(value = " WITH RECURSIVE family_tree AS (\n " +
            "  SELECT \n " +
            "    u.id,\n " +
            "    u.first_name,\n " +
            "    u.last_name,\n " +
            "    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\n " +
            "    u.gender,\n " +
            "    u.dob,\n " +
            "    u.dod,\n " +
            "    CAST(NULL AS SIGNED) AS parent_id,\n " +
            "    0 AS generation,\n " +
            "    CONCAT(',', u.id, ',') AS visited_ids,\n " +
            "    CAST(NULL AS SIGNED) AS spouse_id,\n " +
            "    u.img AS imageUrl,\n " +
            "    u.id AS family_group_id\n " +
            "  FROM users u\n " +
            "  WHERE u.id = :id  \n " +
            "\n " +
            "  UNION ALL\n " +
            "\n " +
            "  SELECT\n " +
            "    u.id,\n " +
            "    u.first_name,\n " +
            "    u.last_name,\n " +
            "    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\n " +
            "    u.gender,\n " +
            "    u.dob,\n " +
            "    u.dod,\n " +
            "    CASE \n " +
            "      WHEN r.name = 'CHILD' THEN LEAST(ft.id, u.id)\n " +
            "      WHEN r.name IN ('FATHER', 'MOTHER') THEN ft.id\n " +
            "      ELSE ft.parent_id\n " +
            "    END AS parent_id,\n " +
            "    ft.generation + 1,\n " +
            "    CONCAT(ft.visited_ids, u.id, ',') AS visited_ids,\n " +
            "    CASE\n " +
            "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN u.id\n " +
            "      ELSE ft.spouse_id\n " +
            "    END AS spouse_id,\n " +
            "    u.img AS imageUrl,\n " +
            "    CASE\n " +
            "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN LEAST(ft.id, u.id)\n " +
            "      ELSE ft.family_group_id\n " +
            "    END AS family_group_id\n " +
            "  FROM user_relations ur\n " +
            "  JOIN relations r ON r.id = ur.relation_id\n " +
            "  JOIN users u ON u.id = ur.related_user_id\n " +
            "  JOIN family_tree ft ON ft.id = ur.user_id\n " +
            "  WHERE\n " +
            "    r.name IN ('FATHER', 'MOTHER', 'CHILD', 'WIFE', 'HUSBAND')\n " +
            "    AND ft.visited_ids NOT LIKE CONCAT('%,', u.id, ',%')\n " +
            "\n " +
            "  UNION ALL\n " +
            "\n " +
            "  SELECT\n " +
            "    u.id,\n " +
            "    u.first_name,\n " +
            "    u.last_name,\n " +
            "    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\n " +
            "    u.gender,\n " +
            "    u.dob,\n " +
            "    u.dod,\n " +
            "    CASE \n " +
            "      WHEN r.name = 'CHILD' THEN LEAST(ft.id, u.id)\n " +
            "      WHEN r.name IN ('FATHER', 'MOTHER') THEN ft.id\n " +
            "      ELSE ft.parent_id\n " +
            "    END AS parent_id,\n " +
            "    ft.generation + 1,\n " +
            "    CONCAT(ft.visited_ids, u.id, ',') AS visited_ids,\n " +
            "    CASE\n " +
            "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN ft.id\n " +
            "      ELSE ft.spouse_id\n " +
            "    END AS spouse_id,\n " +
            "    u.img AS imageUrl,\n " +
            "    CASE\n " +
            "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN LEAST(ft.id, u.id)\n " +
            "      ELSE ft.family_group_id\n " +
            "    END AS family_group_id\n " +
            "  FROM user_relations ur\n " +
            "  JOIN relations r ON r.id = ur.relation_id\n " +
            "  JOIN users u ON u.id = ur.user_id\n " +
            "  JOIN family_tree ft ON ft.id = ur.related_user_id\n " +
            "  WHERE\n " +
            "    r.name IN ('FATHER', 'MOTHER', 'CHILD', 'WIFE', 'HUSBAND')\n " +
            "    AND ft.visited_ids NOT LIKE CONCAT('%,', u.id, ',%')\n " +
            ")\n " +
            "\n " +
            "SELECT DISTINCT\n " +
            "  id,\n " +
            "  first_name,\n " +
            "  last_name,\n " +
            "  full_name,\n " +
            "  gender,\n " +
            "  dob,\n " +
            "  dod,\n " +
            "  parent_id,\n " +
            "  generation,\n " +
            "  spouse_id,\n " +
            "  imageUrl,\n " +
            "  family_group_id\n " +
            "FROM family_tree\n " +
            "ORDER BY generation, id; ",
            nativeQuery = true)
    List<FamilyTreeNode> getAllUserRelation(@Param("id") Long id);

    @Modifying
    @Query(value = "UPDATE user_relations ur SET ur.user_id = :newSourceId, ur.related_user_id = :newTargetId, ur.relation_id = :newRelationId " +
            "WHERE ur.user_id = :oldSourceId AND ur.related_user_id = :oldTargetId AND ur.relation_id = :oldRelationId", nativeQuery = true)
    int updateRelation(
            @Param("oldSourceId") Long oldSourceId,
            @Param("oldTargetId") Long oldTargetId,
            @Param("oldRelationId") Long oldRelationId,
            @Param("newSourceId") Long newSourceId,
            @Param("newTargetId") Long newTargetId,
            @Param("newRelationId") Long newRelationId
    );
    @Query(value = "SELECT ur.* FROM user_relations ur WHERE ur.user_id = :sourceId AND ur.related_user_id = :targetId AND ur.relation_id = :relationId", nativeQuery = true)
    Optional<UserRelation> findByUserIdsAndRelationId(
            @Param("sourceId") Long sourceId,
            @Param("targetId") Long targetId,
            @Param("relationId") Long relationId
    );


    @Query(value = "SELECT\n " +
            "    ur.id AS relatedTargetId,\n " +
            "    r.name AS relationType,\n " +
            "    target.id AS targetId,\n " +
            "     target.img as img,\n " +
            "    CONCAT(target.first_name, ' ', target.last_name) AS targetName,\n " +
            "    source.id AS sourceId,\n " +
            "    CONCAT(source.first_name, ' ', source.last_name) AS sourceName\n " +
            "FROM user_relations ur\n " +
            "JOIN relations r ON ur.relation_id = r.id\n " +
            "JOIN users source ON ur.user_id = source.id\n " +
            "JOIN users target ON ur.related_user_id = target.id where  source.id=:id ;",
            nativeQuery = true)
    List<UserRelationProjection> getAllUserRelations11(@Param("id") Long id);

    @Query(value = "WITH RECURSIVE family_tree AS (\n " +
            "  -- Starting from root\n " +
            "  SELECT\n " +
            "    ur.id AS relationId,\n " +
            "    r.name AS relationType,\n " +
            "    ur.user_id,\n " +
            "    ur.related_user_id,\n " +
            "    u1.first_name AS source_first,\n " +
            "    u1.last_name AS source_last,\n " +
            "    u1.img AS source_img,\n " +
            "    u2.first_name AS target_first,\n " +
            "    u2.last_name AS target_last,\n " +
            "    u2.img AS target_img\n " +
            "  FROM user_relations ur\n " +
            "  JOIN relations r ON ur.relation_id = r.id\n " +
            "  JOIN users u1 ON ur.user_id = u1.id\n " +
            "  JOIN users u2 ON ur.related_user_id = u2.id\n " +
            "  WHERE ur.user_id = :id OR ur.related_user_id = :id \n " +
            "\n " +
            "  UNION\n " +
            "\n " +
            "  -- Recursively walk the tree in both directions\n " +
            "  SELECT\n " +
            "    ur.id AS relationId,\n " +
            "    r.name AS relationType,\n " +
            "    ur.user_id,\n " +
            "    ur.related_user_id,\n " +
            "    u1.first_name AS source_first,\n " +
            "    u1.last_name AS source_last,\n " +
            "    u1.img AS source_img,\n " +
            "    u2.first_name AS target_first,\n " +
            "    u2.last_name AS target_last,\n " +
            "    u2.img AS target_img\n " +
            "  FROM user_relations ur\n " +
            "  JOIN relations r ON ur.relation_id = r.id\n " +
            "  JOIN users u1 ON ur.user_id = u1.id\n " +
            "  JOIN users u2 ON ur.related_user_id = u2.id\n " +
            "  JOIN family_tree ft ON ur.user_id = ft.related_user_id OR ur.related_user_id = ft.user_id\n " +
            ")\n " +
            "SELECT DISTINCT * FROM family_tree;",
            nativeQuery = true)
    List<UserRelationProjection> getAllUserRelations(@Param("id") Long id);


    @Query(value = "WITH RECURSIVE descendants AS (\n " +
            "    -- Start with the user\n " +
            "    SELECT \n " +
            "        ur.user_id AS descendant_id,\n " +
            "        u.first_name,\n " +
            "        u.last_name,\n " +
            "        r.name AS relation_to_user,\n " +
            "        1 AS generation\n " +
            "    FROM user_relations ur\n " +
            "    JOIN users u ON ur.user_id = u.id\n " +
            "    JOIN relations r ON ur.relation_id = r.id\n " +
            "    WHERE ur.related_user_id = :id\n " +
            "    UNION ALL\n " +
            "    SELECT \n " +
            "        ur.user_id,\n " +
            "        u.first_name,\n " +
            "        u.last_name,\n " +
            "        r.name,\n " +
            "        d.generation + 1\n " +
            "    FROM user_relations ur\n " +
            "    JOIN users u ON ur.user_id = u.id\n " +
            "    JOIN relations r ON ur.relation_id = r.id\n " +
            "    JOIN descendants d ON ur.related_user_id = d.descendant_id\n " +
            ")\n " +
            "SELECT * FROM descendants\n " +
            "ORDER BY generation;",
            nativeQuery = true)
    List<UserRelationGeneration> test(@Param("id") Long id);

    boolean existsByUserAndRelatedUser(User user, User relatedUser);


    @Query(value = "  SELECT \n " +
            "  CASE \n " +
            "    WHEN EXISTS (\n " +
            "      SELECT 1\n " +
            "      FROM users u\n " +
            "      INNER JOIN user_relations ur ON ur.user_id = u.id \n " +
            "      INNER JOIN relations r ON r.id = ur.relation_id\n " +
            "      WHERE u.id = :id AND ur.related_user_id = :relatedUserid AND r.id = :relationId \n " +
            "    )\n " +
            "    THEN 'true'\n " +
            "    ELSE 'false'\n " +
            "  END AS relation_exists; ", nativeQuery = true)
    boolean existsByUserAndRelatedUserAndRelationType(@Param("id") Long id, @Param("relatedUserid") Long relatedUserId, @Param("relationId") Long relationId);



    List<UserRelation> findByRelatedUserId(Long id);
    List<UserRelation> findByUserId(Long id);
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM User_relations ur WHERE ur.user_id = :userId AND ur.related_user_id = :relatedUserId AND ur.relation_id = :relationId",nativeQuery = true)
    void deleteByUserIdAndRelatedUserIdAndRelationType(@Param("userId") Long userId,
                                                       @Param("relatedUserId") Long relatedUserId,
                                                       @Param("relationId") Long relationId);


}




