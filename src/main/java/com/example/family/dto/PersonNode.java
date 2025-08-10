package com.example.family.dto;

import java.util.ArrayList;
import java.util.List;

public class PersonNode {
    public int id;
    public String name;
    public int generation;
    public List<PersonNode> children = new ArrayList<>();

    public PersonNode(int id, String name, int generation) {
        this.id = id;
        this.name = name;
        this.generation = generation;
    }
}

