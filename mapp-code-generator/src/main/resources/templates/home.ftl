<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>代码生成</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${request.contextPath}/css/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${request.contextPath}/css/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${request.contextPath}/css/public.css" media="all">
    <style>
        .layui-card {border:1px solid #f2f2f2;border-radius:5px;}
        .icon {margin-right:10px;color:#1aa094;}
        .icon-cray {color:#ffb800!important;}
        .icon-blue {color:#1e9fff!important;}
        .icon-tip {color:#ff5722!important;}
        .layuimini-qiuck-module {text-align:center;margin-top: 10px}
        .layuimini-qiuck-module a i {display:inline-block;width:100%;height:60px;line-height:60px;text-align:center;border-radius:2px;font-size:30px;background-color:#F8F8F8;color:#333;transition:all .3s;-webkit-transition:all .3s;}
        .layuimini-qiuck-module a cite {position:relative;top:2px;display:block;color:#666;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;font-size:14px;}
        .welcome-module {width:100%;height:210px;}
        .panel {background-color:#fff;border:1px solid transparent;border-radius:3px;-webkit-box-shadow:0 1px 1px rgba(0,0,0,.05);box-shadow:0 1px 1px rgba(0,0,0,.05)}
        .panel-body {padding:10px}
        .panel-title {margin-top:0;margin-bottom:0;font-size:12px;color:inherit}
        .label {display:inline;padding:.2em .6em .3em;font-size:75%;font-weight:700;line-height:1;color:#fff;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25em;margin-top: .3em;}
        .layui-red {color:red}
        .main_btn > p {height:40px;}
        .layui-bg-number {background-color:#F8F8F8;}
        .layuimini-notice:hover {background:#f6f6f6;}
        .layuimini-notice {padding:7px 16px;clear:both;font-size:12px !important;cursor:pointer;position:relative;transition:background 0.2s ease-in-out;}
        .layuimini-notice-title,.layuimini-notice-label {
            padding-right: 70px !important;text-overflow:ellipsis!important;overflow:hidden!important;white-space:nowrap!important;}
        .layuimini-notice-title {line-height:28px;font-size:14px;}
        .layuimini-notice-extra {position:absolute;top:50%;margin-top:-8px;right:16px;display:inline-block;height:16px;color:#999;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-row layui-col-space15">
                    <div class="layui-col-md12">
                        <div class="layui-card">
<#--                            <div class="layui-card-header"><i class="fa fa-credit-card icon icon-blue"></i></div>-->
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <table id="demo" lay-filter="test"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getColumn">表详细信息</button>
    </div>
</script>
<script src="${request.contextPath}/css/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab','echarts'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab,
            echarts = layui.echarts;

        miniTab.listen();

        // echarts 窗口缩放自适应
        window.onresize = function(){
            echartsRecords.resize();
        }
    });

    layui.use('table', function(){
        var table = layui.table;
        //第一个实例
        var tableIns = table.render({
            elem: '#demo'
            ,height: 'full - 200'
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,url: '${request.contextPath}/gen/getTable' //数据接口
            ,toolbar: '#toolbarDemo'
            ,page: true //开启分页
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{title:'序号', type:'numbers'}
                ,{field: 'tableName', title: '表名'}
                ,{field: 'type', title: '类型'}
                ,{field: 'tableComment', title: '说明'}
            ]]
            ,response: {
                countName: 'total'
                ,dataName: 'records'
            }
        });

        active = {
            reload: function(){
                var username = $('#username');
                //执行重载
                tableIns.reload({
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        username: username.val()
                    }
                });
            }
        };

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getColumn':
                    var data = checkStatus.data;
                    var tableName = data[0].tableName;
                    var comment = data[0].tableComment;

                    var index = layer.open({
                        type: 2,
                        content: ['${request.contextPath}/gen/column?tableName=' + tableName],
                        maxmin: true,
                        title: '表名称：' + tableName + ' 说明：' + comment,
                        btn: ['生成代码', '关闭'],
                        btn1: function (index, layero) {
                            var body = layer.getChildFrame('body', index);
                            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
                            iframeWin.generate();
                        }
                    });
                    layer.full(index);
                    break;
            };
        });
    });
    // 重载
    $('#search').on('click', function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
</script>
</body>
</html>
