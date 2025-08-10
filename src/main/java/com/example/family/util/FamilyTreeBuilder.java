package com.example.family.util;

import com.example.family.dto.PersonNode;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.*;

public class FamilyTreeBuilder {

    public static PersonNode buildTree(List<Map<String, Object>> flatData) {
        flatData.sort(Comparator.comparingInt(a -> (int) a.get("generation")));

        Map<Integer, PersonNode> idMap = new HashMap<>();
        PersonNode root = null;

        for (Map<String, Object> item : flatData) {
            int id = (int) item.get("id");
            String name = item.get("first_name") + " " + item.get("last_name");
            int generation = (int) item.get("generation");

            PersonNode node = new PersonNode(id, name, generation);
            idMap.put(id, node);

            if (generation == 1) {
                root = node;
            } else {
                // Find parent from previous generation
                for (PersonNode parent : idMap.values()) {
                    if (parent.generation == generation - 1) {
                        parent.children.add(node);
                        break;
                    }
                }
            }
        }

        return root;
    }

    public static void printTree(PersonNode node, int level) {
        if (node == null) return;
        System.out.println("  ".repeat(level) + "- " + node.name);
        for (PersonNode child : node.children) {
            printTree(child, level + 1);
        }
    }
}

