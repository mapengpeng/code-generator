package ${packageName!}<#if model != "">.${model!}</#if>.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${packageName!}<#if model != "">.${model!}</#if>.${className};

/**
 * @author ${author!}
 * @des ${remake!}
 * @date ${.now?string}
 */
public interface ${className}Mapper extends BaseMapper<${className}> {
}
