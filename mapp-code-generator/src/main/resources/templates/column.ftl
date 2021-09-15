<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="${request.contextPath}/css/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${request.contextPath}/css/themes/default.css" media="all">
    <style>
        body {
            background-color: #F2F2F2;;
        }
        .read {
            background-color: #cabebe57;
        }
    </style>
</head>
<body>

<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">包名设置</li>
        <li>表信息</li>
    </ul>
    <div class="layui-tab-content" style="height: 100px;">
        <div class="layui-tab-item layui-show">
            <form id="packageForm" class="layui-form" action="">
                <div class="layui-row layui-col-space10">
                    <div class="layui-col-md2">
                    </div>
                    <div class="layui-col-md8">
                        <div class="layui-form-item">
                            <label class="layui-form-label">包名称</label>
                            <div class="layui-input-block">
                                <input type="text" name="packageName" lay-verify="required" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">模块名称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="model" lay-verify="" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">作者</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="author" lay-verify="required" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">实体类名称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="className" value="${className}" lay-verify="required" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">功能描述</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="remake" lay-verify="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">后台框架</label>
                                <div class="layui-input-inline">
                                    <select name="backType">
                                        <option value="mybatis-plus" selected>mvc+mybatis-plus</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md2">
                    </div>
                </div>
            </form>
        </div>
        <div class="layui-tab-item">
            <form id="form" class="layui-form">
                <input type="hidden" name="tableName" value="${tableName!}" />
                <input type="hidden" name="tableComment" value="${tableComment!}" />
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th>字段名称</th>
                        <th>描述</th>
                        <th>字段类型</th>
                        <th>java类型</th>
                        <th>java属性名称</th>
                        <th>查询条件</th>
                        <th>匹配方式</th>
                    </tr>
                    </thead>
                    <tbody>
            <#list columns as column >
            <tr>
                <td><input type="text" name="columnInfoList[${column_index}].columnName" readonly class="layui-input read" value="${column.columnName!}"/></td>
                <td><input type="text" name="columnInfoList[${column_index}].columnComnent" readonly class="layui-input read" value="${column.columnComnent!}"/></td>
                <td><input type="text" name="columnInfoList[${column_index}].type" readonly class="layui-input read" value="${column.type!}"/></td>
                <td>
                    <select name="columnInfoList[${column_index}].fieldType">
                        <option value="String" <#if column.fieldType == "String" >selected</#if>>String</option>
                        <option value="Integer" <#if column.fieldType == 'Integer' >selected</#if>>Integer</option>
                        <option value="Double" <#if column.fieldType == 'Double' >selected</#if>>Double</option>
                        <option value="BigDecimal" <#if column.fieldType == 'BigDecimal' >selected</#if>>BigDecimal</option>
                        <option value="LocalDate" <#if column.fieldType == 'LocalDate' >selected</#if>>LocalDate</option>
                        <option value="LocalDateTime" <#if column.fieldType == 'LocalDateTime' >selected</#if>>LocalDateTime</option>
                        <option value="boolean" <#if column.fieldType == 'boolean' >selected</#if>>Boolean</option>
                    </select>
                </td>
                <td><input type="text" class="layui-input" name="columnInfoList[${column_index}].fieldName" value="${column.fieldName!}"/></td>

                <td>
                    <input type="checkbox" name="columnInfoList[${column_index}].searField" title="是">
                </td>
                <td>
                    <select name="columnInfoList[${column_index}].matchType">
                        <option value=""></option>
                        <option value="=">=</option>
                        <option value="like">like</option>
                        <#--<option value="between">between</option>-->
                        <#--<option value="end">end</option>-->
                        <option value=">"> ></option>
                        <option value=">="> >=</option>
                        <option value="<"> <</option>
                        <option value="<="> <=</option>
                    </select>
            </tr>
            </#list>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>


<script src="${request.contextPath}/js/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="${request.contextPath}/css/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['element', 'form'], function () {
        var form = layui.form;
        var element = layui.element;
    })
    
    function generate() {
        window.location.href = '${request.contextPath}/gen/genearte?' + $("#form").serialize() + '&' + $("#packageForm").serialize()
    }
</script>

</body>
</html>