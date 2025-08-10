package com.example.family.dto;

import java.util.List;

public class TranslateRequest {
    private List<String> names;
    private String targetLang;

    // Getters and Setters
    public List<String> getNames() {
        return names;
    }

    public void setNames(List<String> names) {
        this.names = names;
    }

    public String getTargetLang() {
        return targetLang;
    }

    public void setTargetLang(String targetLang) {
        this.targetLang = targetLang;
    }
}

