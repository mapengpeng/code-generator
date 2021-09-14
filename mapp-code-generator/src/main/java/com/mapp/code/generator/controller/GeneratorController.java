package com.mapp.code.generator.controller;

import com.mapp.code.generator.entity.DBInfo;
import com.mapp.code.generator.entity.Page;
import com.mapp.code.generator.entity.TableInfo;
import com.mapp.code.generator.util.Generator;
import com.mapp.code.generator.util.MateDataUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.zip.ZipOutputStream;

/**
 * @author mapp
 * @des 代码生成器
 * @date 2019/3/13
 */
@Controller
@RequestMapping("/gen")
public class GeneratorController {


    @RequestMapping("/index")
    public String index() {
        return "gencode";
    }

    @RequestMapping("/column")
    public String column(String tableName, ModelMap modelMap) {
        DBInfo dbInfo = MateDataUtil.getDbInfo();
        List<TableInfo> tableInfoList = dbInfo.getTableInfoList();
        for (TableInfo tableInfo : tableInfoList) {
            if (tableName.equals(tableInfo.getTableName())) {
                modelMap.put("columns", Generator.convertJavaTypeAndName(tableInfo.getColumnInfoList()));
                modelMap.put("tableName", tableName);
                modelMap.put("tableComment", tableInfo.getTableComment());
                modelMap.put("className", Generator.convertJavaClassName(tableName));
            }
        }

        return "column";
    }

    /**
     * 表信息
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/getTable")
    @ResponseBody
    public Page getTable(Integer page, Integer limit) {
        DBInfo dbInfo = MateDataUtil.getDbInfo();
        List<TableInfo> tableInfoList = dbInfo.getTableInfoList();
        int total = tableInfoList.size();
        Page res = new Page(page, limit, total);
        res.setRecords(tableInfoList.subList((page - 1) * limit, (page * limit) > total ? total : (page * limit)));
        return res;
    }

    /**
     * 生成代码
     *
     * @param table
     * @param response
     */
    @RequestMapping("/genearte")
    @ResponseBody
    public void genearte(TableInfo table, HttpServletResponse response) {
        try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
             ZipOutputStream zipOutputStream = new ZipOutputStream(outputStream);
             OutputStream out = response.getOutputStream()) {
            // 生成代码
            Generator.generate(table, zipOutputStream);

            byte[] data = outputStream.toByteArray();
            response.reset();
            response.setHeader("Content-Disposition", "attachment; filename=\"code.zip\"");
            response.addHeader("Content-Length", "" + data.length);
            response.setContentType("application/octet-stream; charset=UTF-8");
            out.write(data);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
