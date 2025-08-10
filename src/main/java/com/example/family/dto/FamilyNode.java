package com.example.family.dto;

import com.example.family.model.User;

import java.util.ArrayList;
import java.util.List;

public class FamilyNode {
    private User user;
    private String relation;
    private List<FamilyNode> children = new ArrayList<>();

    public FamilyNode() {
    }

    public FamilyNode(User user, String relation, List<FamilyNode> children) {
        this.user = user;
        this.relation = relation;
        this.children = children;
    }

    public User getUser() {
        return user;
    }

    public FamilyNode setUser(User user) {
        this.user = user;
        return this;
    }

    public String getRelation() {
        return relation;
    }

    public FamilyNode setRelation(String relation) {
        this.relation = relation;
        return this;
    }

    public List<FamilyNode> getChildren() {
        return children;
    }

    public FamilyNode setChildren(List<FamilyNode> children) {
        this.children = children;
        return this;
    }

    @Override
    public String toString() {
        return "FamilyNode{" +
                "user=" + user +
                ", relation='" + relation + '\'' +
                ", children=" + children +
                '}';
    }
}

