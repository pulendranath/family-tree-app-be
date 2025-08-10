package com.example.family.repository;

import com.example.family.dto.FamilyTreeNode;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FamilyTreeRepository {

    private final NamedParameterJdbcTemplate namedJdbcTemplate;

    public FamilyTreeRepository(NamedParameterJdbcTemplate namedJdbcTemplate) {
        this.namedJdbcTemplate = namedJdbcTemplate;
    }

    public List<FamilyTreeNode> getFamilyTree(Integer rootUserId) {
        String sql =  " WITH RECURSIVE family_tree AS (\n" +
                "  -- Anchor: Start from root user\n" +
                "  SELECT \n" +
                "    u.id,\n" +
                "    u.first_name,\n" +
                "    u.last_name,\n" +
                "    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\n" +
                "    u.gender,\n" +
                "    u.dob,\n" +
                "    u.dod,\n" +
                "    CAST(NULL AS SIGNED) AS parent_id,\n" +
                "    0 AS generation,\n" +
                "    CONCAT(',', u.id, ',') AS visited_ids,\n" +
                "    CAST(NULL AS SIGNED) AS spouse_id,\n" +
                "    u.img AS imageUrl,\n" +
                "    u.id AS family_group_id\n" +
                "  FROM users u\n" +
                "  WHERE u.id = :id \n" +
                "\n" +
                "  UNION ALL\n" +
                "\n" +
                "  -- Forward direction\n" +
                "  SELECT\n" +
                "    u.id,\n" +
                "    u.first_name,\n" +
                "    u.last_name,\n" +
                "    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\n" +
                "    u.gender,\n" +
                "    u.dob,\n" +
                "    u.dod,\n" +
                "\n" +
                "    CASE \n" +
                "      WHEN r.name = 'CHILD' THEN ft.id\n" +
                "      WHEN r.name IN ('FATHER', 'MOTHER') THEN ft.id\n" +
                "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN NULL\n" +
                "      ELSE ft.parent_id\n" +
                "    END AS parent_id,\n" +
                "\n" +
                "    ft.generation + 1,\n" +
                "    CONCAT(ft.visited_ids, u.id, ',') AS visited_ids,\n" +
                "\n" +
                "    CASE\n" +
                "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN ft.id\n" +
                "      ELSE NULL\n" +
                "    END AS spouse_id,\n" +
                "\n" +
                "    u.img AS imageUrl,\n" +
                "\n" +
                "    CASE\n" +
                "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN LEAST(ft.id, u.id)\n" +
                "      WHEN r.name = 'CHILD' THEN ft.id\n" +
                "      ELSE ft.family_group_id\n" +
                "    END AS family_group_id\n" +
                "\n" +
                "  FROM user_relations ur\n" +
                "  JOIN relations r ON r.id = ur.relation_id\n" +
                "  JOIN users u ON u.id = ur.related_user_id\n" +
                "  JOIN family_tree ft ON ft.id = ur.user_id\n" +
                "  WHERE\n" +
                "    r.name IN ('FATHER', 'MOTHER', 'CHILD', 'WIFE', 'HUSBAND')\n" +
                "    AND ft.visited_ids NOT LIKE CONCAT('%,', u.id, ',%')\n" +
                "\n" +
                "  UNION ALL\n" +
                "\n" +
                "  -- Reverse direction\n" +
                "  SELECT\n" +
                "    u.id,\n" +
                "    u.first_name,\n" +
                "    u.last_name,\n" +
                "    CONCAT(u.first_name, ' ', u.last_name) AS full_name,\n" +
                "    u.gender,\n" +
                "    u.dob,\n" +
                "    u.dod,\n" +
                "\n" +
                "    CASE \n" +
                "      WHEN r.name = 'CHILD' THEN ft.id\n" +
                "      WHEN r.name IN ('FATHER', 'MOTHER') THEN ft.id\n" +
                "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN NULL\n" +
                "      ELSE ft.parent_id\n" +
                "    END AS parent_id,\n" +
                "\n" +
                "    ft.generation + 1,\n" +
                "    CONCAT(ft.visited_ids, u.id, ',') AS visited_ids,\n" +
                "\n" +
                "    CASE\n" +
                "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN ft.id\n" +
                "      ELSE NULL\n" +
                "    END AS spouse_id,\n" +
                "\n" +
                "    u.img AS imageUrl,\n" +
                "\n" +
                "    CASE\n" +
                "      WHEN r.name IN ('WIFE', 'HUSBAND') THEN LEAST(ft.id, u.id)\n" +
                "      WHEN r.name = 'CHILD' THEN ft.id\n" +
                "      ELSE ft.family_group_id\n" +
                "    END AS family_group_id\n" +
                "\n" +
                "  FROM user_relations ur\n" +
                "  JOIN relations r ON r.id = ur.relation_id\n" +
                "  JOIN users u ON u.id = ur.user_id\n" +
                "  JOIN family_tree ft ON ft.id = ur.related_user_id\n" +
                "  WHERE\n" +
                "    r.name IN ('FATHER', 'MOTHER', 'CHILD', 'WIFE', 'HUSBAND')\n" +
                "    AND ft.visited_ids NOT LIKE CONCAT('%,', u.id, ',%')\n" +
                ")\n" +
                "\n" +
                "SELECT DISTINCT\n" +
                "  id,\n" +
                "  first_name,\n" +
                "  last_name,\n" +
                "  full_name,\n" +
                "  gender,\n" +
                "  dob,\n" +
                "  dod,\n" +
                "  parent_id,\n" +
                "  generation,\n" +
                "  spouse_id,\n" +
                "  imageUrl,\n" +
                "  family_group_id\n" +
                "FROM family_tree\n" +
                "ORDER BY generation, id;\n ";

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("id", rootUserId);

        return namedJdbcTemplate.query(sql, params, (rs, rowNum) -> {
            FamilyTreeNode node = new FamilyTreeNode();
            node.setId(rs.getInt("id"));
            node.setFirstName(rs.getString("first_name"));
            node.setLastName(rs.getString("last_name"));
            node.setFullName(rs.getString("full_name"));
            node.setGender(rs.getString("gender"));
            node.setDob(rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null);
            node.setDod(rs.getDate("dod") != null ? rs.getDate("dod").toLocalDate() : null);
            node.setParentId(rs.getObject("parent_id") != null ? rs.getInt("parent_id") : null);
            node.setGeneration(rs.getInt("generation"));
            node.setSpouseId(rs.getObject("spouse_id") != null ? rs.getInt("spouse_id") : null);
            node.setImageUrl(rs.getString("imageUrl"));
            node.setFamilyGroupId(rs.getInt("family_group_id"));
            return node;
        });
    }
}


