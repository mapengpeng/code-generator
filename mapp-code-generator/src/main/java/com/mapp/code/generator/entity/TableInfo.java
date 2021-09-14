package com.mapp.code.generator.entity;

import lombok.Data;

import java.util.*;

@Data
public class TableInfo {

    private String tableName;
    private String type;
    private String tableComment;
    private Date createTime;
    private String author;
    private Set<String> pkName = new HashSet<>();
    private List<ColumnInfo> columnInfoList = new ArrayList<>();

    private String className;
    private String packageName;
    private String model;
    private String remake;
    private String backType;
}
