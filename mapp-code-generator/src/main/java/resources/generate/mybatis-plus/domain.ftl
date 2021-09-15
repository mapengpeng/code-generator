package ${packageName!}<#if model != "">.${model!}</#if>.entity;

import com.baomidou.mybatisplus.annotation.TableName;

/**
 * @author ${author!}
 * @des ${remake!}
 * @date ${.now?string}
 */
@TableName("${tableName!}")
public class ${className!} {

    <#list columns as column>
        /** ${column.columnComnent!} */
        private ${column.fieldType!} ${column.fieldName!};

    </#list>
    <#list columns as column>
        public ${column.fieldType!} get${column.fieldName?cap_first} () {
            return ${column.fieldName!};
        }
        public void set${column.fieldName?cap_first} (${column.fieldType!} ${column.fieldName}) {
            this.${column.fieldName!} = ${column.fieldName!};
        }
    </#list>
}
