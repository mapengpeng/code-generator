package ${packageName!}<#if model != "">.${model!}</#if>.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ${packageName!}<#if model != "">.${model!}</#if>.entity.${className!};

/**
 * @author ${author!}
 * @des ${remake!}
 * @date ${.now?string}
 */
public interface ${className!}Service extends IService<${className!}> {
}
