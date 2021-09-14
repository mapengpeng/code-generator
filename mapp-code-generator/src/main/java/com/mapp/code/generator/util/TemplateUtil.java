package com.mapp.code.generator.util;

import cn.hutool.core.io.FileUtil;
import cn.hutool.extra.template.engine.freemarker.SimpleStringTemplateLoader;
import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.IOException;

/**
 * @author mapp
 * @des
 * @date 2019/3/14
 */
@Slf4j
public class TemplateUtil {


    private static Configuration config = null;

    public static freemarker.template.Template getTemplate(String template) {
        Template temp = null;
        try {
            if (config == null) {
                config = new Configuration(Configuration.VERSION_2_3_23);
                config.setTemplateLoader(new SimpleStringTemplateLoader());
                config.setDirectoryForTemplateLoading(FileUtil.file("generate"));
                config.setDefaultEncoding("UTF-8");
            }
            temp = config.getTemplate(template);
        } catch (IOException e) {
            e.printStackTrace();
            log.error("文件夹不存在");
        }
        return temp;
    }
}
