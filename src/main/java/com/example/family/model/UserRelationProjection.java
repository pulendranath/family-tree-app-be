package com.example.family.model;

public interface UserRelationProjection {

    Long getRelatedTargetId();

    String getRelationType();

    Long getSourceId();

    String getSourceName();

    Long getTargetId();

    String getImg();

    String getTargetName();
}



