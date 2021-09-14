package com.mapp.code.generator.util;


import com.mapp.code.generator.entity.ColumnInfo;
import com.mapp.code.generator.entity.TableInfo;
import freemarker.template.Template;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;

import java.io.File;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 *
 */
@Slf4j
public class Generator {

    // 框架，模板键值对
    private static Map<String, List<String>> templates = new HashMap<>();
    private static String MYBATIS_PLUS = "mybatis-plus";
    private static String MYBATIS = "mybatis";
    private static String SEPARATOR = File.separator;

    static {

        // mybatis-plus 模板
        List<String> javaTemplates = Stream.of("controller.ftl"
                , "domain.ftl"
                , "mapper.ftl"
                , "service.ftl"
                , "serviceImpl.ftl").map(x -> MYBATIS_PLUS + SEPARATOR + x).collect(Collectors.toList());

        // mybatis 模板
        List<String> javaTemplates2 = Stream.of("controller.ftl"
                , "domain.ftl"
                , "mapper.ftl"
                , "service.ftl"
                , "serviceImpl.ftl").map(x -> MYBATIS + SEPARATOR + x).collect(Collectors.toList());

        templates.put("mybatis-plus", javaTemplates);
        templates.put("mybatis", javaTemplates2);
    }

    // 模板集合
    public static List<String> getTemplates(String backType) {

        return templates.get(backType);
    }


    // 生成模板
    public static void generate(TableInfo table, ZipOutputStream zip) {
        Map<String, Object> parms = new HashMap<>();
        parms.put("tableName", table.getTableName());
        parms.put("comment", table.getTableComment());
        parms.put("className", table.getClassName());
        parms.put("columns", table.getColumnInfoList());
        parms.put("packageName", table.getPackageName());
        parms.put("model", table.getModel());
        parms.put("author", table.getAuthor());
        parms.put("remake", table.getRemake());

        try(Writer writer = new OutputStreamWriter(zip, "utf-8");) {
            for (String name : getTemplates(table.getBackType())) {
                Template template = TemplateUtil.getTemplate(name);
                zip.putNextEntry(new ZipEntry(getFileName(name, table.getClassName())));
                template.process(parms, writer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    // 类型驼峰规则转换
    public static List<ColumnInfo> convertJavaTypeAndName(List<ColumnInfo> columns) {
        columns.forEach(x -> {
            switch (x.getType().toLowerCase()) {
                case "varchar":
                    x.setFieldType("String");
                    break;
                case "char":
                    x.setFieldType("String");
                    break;
                case "date":
                    x.setFieldType("LocalDate");
                    break;
                case "time":
                    x.setFieldType("LocalTime");
                    break;
                case "datetime":
                    x.setFieldType("LocalDateTime");
                    break;
                case "int":
                    x.setFieldType("Integer");
                    break;
                case "decimal":
                    x.setFieldType("BigDecimal");
                    break;
                case "numeric":
                    x.setFieldType("BigDecimal");
                    break;
                default:
                    x.setFieldType("String");
                    break;
            }
            char[] arr = {'_'};
            x.setFieldName(WordUtils.capitalizeFully(x.getColumnName(), arr).replaceAll("_", ""));
            x.setFieldName(StringUtils.uncapitalize(x.getFieldName()));
        });
        return columns;
    }

    // 转换表名
    public static String convertJavaClassName(String tableName) {
        return WordUtils.capitalizeFully(tableName, new char[]{'_'}).replaceAll("_", "");
    }

    // 文件名称
    public static String getFileName(String ftl, String className) {
        String result = "";
        if (ftl.indexOf("jsp.ftl") > 0) {
            result = className + "manager.jsp";
        }else if (ftl.indexOf("domain.ftl") > 0) {
            result = className + ".java";
        }else if (ftl.indexOf("mapper.ftl") > 0) {
            result = className + "Mapper.java";
        }else if (ftl.indexOf("service.ftl") > 0) {
            result = className + "Service.java";
        }else if (ftl.indexOf("serviceImpl.ftl") > 0) {
            result = className + "ServiceImpl.java";
        }else if (ftl.indexOf("controller.ftl") > 0) {
            result = className + "Controller.java";
        }else {
            result = "unknow";
        }
        return result;
    }

}
