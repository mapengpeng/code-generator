package ${packageName!}<#if model != "">.${model!}</#if>.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${packageName!}<#if model != "">.${model!}</#if>.entity.${className!};
import ${packageName!}<#if model != "">.${model!}</#if>.mapper.${className!}Mapper;
import ${packageName!}<#if model != "">.${model!}</#if>.service.${className!}Service;
import org.springframework.stereotype.Service;

/**
 * @author ${author!}
 * @des ${remake!}
 * @date ${.now?string}
 */
@Service
public class ${className!}ServiceImpl extends ServiceImpl<${className!}Mapper, ${className!}> implements ${className!}Service {
}
