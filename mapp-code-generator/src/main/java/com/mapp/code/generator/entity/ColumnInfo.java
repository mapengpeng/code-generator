package com.mapp.code.generator.entity;

import lombok.Data;

@Data
public class ColumnInfo {
    private String columnName;
    private String type;
    private String columnComnent;
    private String columnLenth;
    private String isNull;
    private String isPk;
    private int index;
    private String defaultValue;
    private String isAutoInc;
    private String digits;

    private String fieldType;
    private String fieldName;
    private boolean searField;
    private boolean listField;
    private String tableName;
    private String matchType;
}
