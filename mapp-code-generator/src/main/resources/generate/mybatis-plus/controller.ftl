package ${packageName!}<#if model != "">.${model!}</#if>.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mpp.admin.entity.PageEntity;
import ${packageName!}<#if model != "">.${model!}</#if>.entity.${className!};
import ${packageName!}<#if model != "">.${model!}</#if>.service.${className!}Service;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;;

/**
 * @author ${author!}
 * @des ${remake!}
 * @date ${.now?string}
 */
@Controller
@RequestMapping("/${className!?uncap_first}")
public class ${className!}Controller {

    @Autowired
    private ${className!}Service ${className!?uncap_first}Service;

    @RequestMapping("/index")
    public String index() {
        return "${className!?uncap_first}";
    }

    @RequestMapping("/getAll")
    @ResponseBody
    public PageEntity getAll(Integer page, Integer limit, ${className!} ${className!?uncap_first}) {

        QueryWrapper wrapper = new QueryWrapper();
        // 查询条件
     <#list columns as column>
        <#if column.searField>
        String ${column.fieldName} = ${className!?uncap_first}.get${column.fieldName?cap_first}();
         <#if column.matchType != ''>
          <#if column.matchType == '='>
        wrapper.eq(StringUtils.isNotBlank(${column.fieldName}), "${column.columnName}", ${column.fieldName});
          <#elseif column.matchType == 'like'>
        wrapper.like(StringUtils.isNotBlank(${column.fieldName}), "${column.columnName}", ${column.fieldName});
          <#elseif column.matchType == '>'>
        wrapper.gt(StringUtils.isNotBlank(${column.fieldName}), "${column.columnName}", ${column.fieldName});
          <#elseif column.matchType == '>='>
        wrapper.ge(StringUtils.isNotBlank(${column.fieldName}), "${column.columnName}", ${column.fieldName});
          <#elseif column.matchType == '<'>
        wrapper.lt(StringUtils.isNotBlank(${column.fieldName}), "${column.columnName}", ${column.fieldName});
          <#elseif column.matchType == '<='>
        wrapper.le(StringUtils.isNotBlank(${column.fieldName}), "${column.columnName}", ${column.fieldName});
          </#if>
         </#if>
        </#if>
     </#list>
        return (PageEntity) ${className!?uncap_first}Service.page(PageEntity.build(page, limit), wrapper);
    }
}
