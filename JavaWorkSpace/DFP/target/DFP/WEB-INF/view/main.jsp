

<%--
  Created by IntelliJ IDEA.
  User: tongc
  Date: 2017-9-18
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html xmlns:shiro="http://shiro.apache.org/tags">
<head>
    <link rel="icon" sizes="any" mask href="logo.png">
    <link rel="icon" type="image/png" href="/DFP/static/login/favicon.png">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />--%>
    <meta name="copyright" content="" />
    <style type="text/css">
        body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
        p{margin-left:5px; font-size:14px;padding: 0px;}
    </style>

    <title>DFP生产系统</title>
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/1.5.2/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/wu.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/icon.css" />
    <script type="text/javascript" src="${ctxPath }/static/js/ext/ext-all.js"></script>
    <script src="${ctxPath }/static/js/ext/ext-lang-zh_CN.js"></script>
    <link href="${ctxPath }/static/js/ext/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctxPath }/static/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/jquery.form.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/extJs.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/ext/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/ext/ext-all.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/echarts/echarts.min.js"></script>
    <script src="${ctxPath }/static/js/jquery.table2excel.js"></script>
    <style>
        .wu-header { height:99px; position:relative; z-index:0; overflow:hidden;  background:url(${ctxPath }/static/img/HMDM.jpg) ;}
        /*border-bottom:0px #95b8e7 solid; bottom repeat-x;background-size:cover*/
        .wu-header-left { position:absolute; z-index:0; left:0px; bottom:0px;top: 0px;}
        #rectangle {
            width: 100%;
            height: 100px;
            background: #2a9de7;
        }
        #rectangle1 {
            width: 100%;
            height: 100px;
            background: #2a9de7;
        }
        #rectangle2 {
            width: 10%;
            height: 260px;

        }
        #rectangle3 {
            width: 45%;
            height: 260px;
        }

        #rectangle4 {
            width: 30%;
            height: 260px;
        }
        #rectangle5 {
            width: 45%;
            height: 200px;
        }
        #main5 {
            width: 70%;
            height: 400px;

        }

        .bg{
            display: flex;
            width:500px;
            height: 500px;
            margin:0 auto;
            background: #272822;
            -webkit-align-items: center;
            align-items: center;
            justify-content: center;
        }
        #s {
            width: 11%;
            height: 15%;
            background: cadetblue;
        }
        #s1 {
            width: 12%;
            height: 16%;
            background: mediumpurple;
        }
        #s2 {
            width: 11%;
            height: 15%;
            background: yellow;
        }
        #s3 {
            width: 11%;
            height: 15%;
            background: grey;
        }
        #s4 {
            width: 11%;
            height: 15%;
            background: red;
        }
        #s5 {
            width: 10px;
            height: 10px;
            background: cadetblue;
        }
        .s7 {
            width: 12%;
            height: 20%;
            background: #ffe48d;
        }
        #sa1 {
            width: 10%;
            height: 17%;
            background: red;
        }
        #sa2 {
            width: 10%;
            height: 17%;
            background: yellow;
        }
        #sa3 {
            width: 10%;
            height: 17%;
            background: darkgreen;
        }
        #sa4 {
            width: 10%;
            height: 17%;
            background: cadetblue;
        }
        #sa {
            width: 12%;
            height: 22%;
            background: mediumpurple;
        }
    </style>
</head>
<body class="easyui-layout">
<!-- begin of header -->
<div class="wu-header" data-options="region:'north',border:false,split:true">
    <div class="wu-header-left" data-options="iconCls:'icon-DH'" >
        <%--<h1 ><font style="top: 10px" >HMDM主数据管理系统</font></h1>--%>
        <img   src="${ctxPath }/static/img/DFP.png">
    </div>
    <%--<div class="wu-header-left" data-options="iconCls:'icon-DH'">--%>
    <%--<h1><img src="${ctxPath }/static/css/icons/dhlogo.png" style="width: 50px"><font style="top: 10px">TIOTHMDM主数据创建</font></h1>--%>
    <%--</div>--%>
    <div class="wu-header-right">
        <p><font id="User" class="easyui-tooltip" style="color: #ffffff;bottom: -1px;" title=""></font>，欢迎您！</p>
        <b><span id="UserName"></span></b>&nbsp;&nbsp;
        <shiro:hasPermission name="/user/editPwdPage">
            <a href="javascript:void(0)" onclick="editUserPwd()" class="easyui-linkbutton" plain="true"  >修改密码</a>
        </shiro:hasPermission>&nbsp;&nbsp;
        <p><a href="http://www.dhchain.com/">官网</a>|<a href="#"  onclick="confirm1()">退出</a></p>

    </div>
</div>
<!-- end of header -->
<!-- begin of sidebar -->
<div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航菜单'" style="width:200px;">
    <div class="easyui-accordion" data-options="border:false,fit:true">
        <div id="rcmenu" class="easyui-menu" style="">
            <div id="closeall">关闭全部</div>
            <div id="closeother">关闭其他</div>
            <div id="closeright">关闭右侧</div>
            <div id="closeleft">关闭左侧</div>
        </div>
        <%--<div title="零件车间" data-options="iconCls:'icon-user-home '" style="padding:5px;">--%>
            <%--<ul class="easyui-tree wu-side-tree">--%>
                <%--<li iconCls="icon-lorry-add"><a href="javascript:void(0)" data-icon="icon-lorry-add" data-link="${ctxPath }/ContractPlan" iframe="0">合同计划</a></li>--%>
                <%--<li iconCls="icon-lorry-link"><a href="javascript:void(0)" data-icon="icon-lorry-link" data-link="${ctxPath }/MonthPlan" iframe="0">月度计划</a></li>--%>
                <%--<li iconCls="icon-script-code"><a href="javascript:void(0)" data-icon="icon-script-code" data-link="${ctxPath }/MissionIssued" iframe="0">工单管理</a></li>--%>
                <%--<li iconCls="icon-script-key"><a href="javascript:void(0)" data-icon="icon-script-key" data-link="${ctxPath }/ProductionTaskManagement" iframe="0">完工管理</a></li>--%>
                <%--<li iconCls="icon-report-key"><a href="javascript:void(0)" data-icon="icon-report-key" data-link="${ctxPath }/ElementDetail" iframe="0">报表查询</a></li>--%>
                <%--<li iconCls="icon-package-white"><a href="javascript:void(0)" data-icon="icon-package-white" data-link="${ctxPath }/DeviceManagement" iframe="0">设备管理</a></li>--%>
                <%--<li iconCls="icon-package-system"><a href="javascript:void(0)" data-icon="icon-package-system" data-link="${ctxPath }/EquipmentMaintenance" iframe="0">设备维修</a></li>--%>
                <%--<li iconCls="icon-book"><a href="javascript:void(0)" data-icon="icon-book" data-link="${ctxPath }/ProcessDocumentation" iframe="0">工艺文档</a></li>--%>
                <%--<li iconCls="icon-vcard-edit"><a href="javascript:void(0)" data-icon="icon-vcard-edit" data-link="${ctxPath }/QualityAssurance" iframe="0">质量管理</a></li>--%>
                <%--<li iconCls="icon-vcard-key"><a href="javascript:void(0)" data-icon="icon-vcard-key" data-link="${ctxPath }/MouldManagement" iframe="0">模具管理</a></li>--%>
                <%--<li iconCls="icon-users"><a href="javascript:void(0)" data-icon="icon-users" data-link="${ctxPath }/PersonnelMaintenance" iframe="0">人员管理</a></li>--%>
                <%--<li iconCls="icon-package"><a href="javascript:void(0)" data-icon="icon-package" data-link="${ctxPath }/BasicData" iframe="0">基础资料</a></li>--%>
                <%--<li iconCls="icon-phone-key"><a href="javascript:void(0)" data-icon="icon-phone-key" data-link="${ctxPath }/Info" iframe="0">信息资料</a></li>--%>
                <%--<li iconCls="icon-wand"><a href="javascript:void(0)" data-icon="icon-wand" data-link="${ctxPath }/Equipmentnspection" iframe="0">设备点检</a></li>--%>
                <%--<li iconCls="icon-table-cell"><a href="javascript:void(0)" data-icon="icon-table-cell" data-link="${ctxPath }/Material" iframe="0">材料记录</a></li>--%>
            <%--</ul>--%>
        <%--</div>--%>
        <div title="合格证" data-options="iconCls:'icon-package'" style="padding:5px;">
            <ul class="easyui-tree wu-side-tree" id="tree">
                        <li iconCls="icon-package-go">
                    <a href="javascript:void(0)" data-icon="icon-package-go" data-link="${pageContext.request.contextPath}/Tractor" iframe="0">拖拉机合格证</a>
                        </li>
                        <li iconCls="icon-package-start">
                <a href="javascript:void(0)" data-icon="icon-package-start" data-link="${pageContext.request.contextPath}/Cultivator" iframe="0">收割机合格证</a>
                        </li>
                <li iconCls="icon-package-start">
                    <a href="javascript:void(0)" data-icon="icon-package" data-link="${pageContext.request.contextPath}/BaseInfo" iframe="0">基础数据</a>
                </li>

            </ul>
        </div>
        <div title="权限管理" data-options="iconCls:'icon-money'" style="padding:5px;">
            <ul class="easyui-tree wu-side-tree">
                <li iconCls="icon-money-add"><a href="javascript:void(0)" data-icon="icon-money-add" data-link="${pageContext.request.contextPath}/resource" iframe="0">资源管理</a></li>
                <li iconCls="icon-money-add"><a href="javascript:void(0)" data-icon="icon-money-add" data-link="${pageContext.request.contextPath}/role" iframe="0">角色管理</a></li>
                <li iconCls="icon-money-add"><a href="javascript:void(0)" data-icon="icon-money-add" data-link="${pageContext.request.contextPath}/user" iframe="0">用户管理</a></li>
                <li iconCls="icon-money-add"><a href="javascript:void(0)" data-icon="icon-money-add" data-link="${pageContext.request.contextPath}/organization" iframe="0">部门管理</a></li>
            </ul>
        </div>
    </div>
    <%--<div title="权限管理" data-options="iconCls:'icon-money'" style="padding:5px;">--%>

    <%--</div>--%>
</div>
</div>
<!-- end of sidebar -->
<!-- begin of main -->
<div class="wu-main" data-options="region:'center'">
    <div id="wu-tabs" class="easyui-tabs" data-options="border:false,fit:true">
        <div title="首页" >
            <div class="msg_desc" style="width: 100%;height: 99%">
                <img style="max-width:100%;overflow:hidden;width:100%;height:100%;" src="/DFP/static/login/main.jpg" alt="">
            </div>
        </div>
    </div>
</div>
<!-- end of main -->
<!-- begin of footer -->
<div class="wu-footer" data-options="region:'south',border:true,split:true" title="大集团信息中心研发V1.0">

</div>
<!-- end of footer -->
<script type="text/javascript">
    var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cspan id='cnzz_stat_icon_1273801292'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s13.cnzz.com/z_stat.php%3Fid%3D1273801292%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));
    (function(doc, win) {
        var docEl = doc.documentElement,
            resizeEvt = 'orientationchange' in window ? 'orientationchange': 'resize',
            recalc = function() {
                var clientWidth = docEl.clientWidth;
                if (!clientWidth) return;
                docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
            };


        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);//定义rem
    //    var wi = document.body.clientWidth;
    //    var hi  = document.body.clientHeight;
    //    console.log(localStorage.getItem("Department"));
    // 基于准备好的dom，初始化echarts实例
//    var myChart = echarts.init(document.getElementById('main2'));
//    var myChart1 = echarts.init(document.getElementById('main5'));

//    option = {
//        title : {
//            text: '计划管理',
//            x: 'left',
//
//        },
//        tooltip : {
//            formatter: "{a} <br/>{b} : {c}%"
//        },
//        series : [
//            {
//                type:'gauge',
//                splitNumber: 10,       // 分割段数，默认为5
//                axisLine: {            // 坐标轴线
//                    lineStyle: {       // 属性lineStyle控制线条样式
//                        color:  [[0.2, '#c23531'], [0.8, '#63869e'], [1, '#91c7ae']],
//                        width: 8
//                    }
//                },
//                axisTick: {            // 坐标轴小标记
//                    splitNumber: 10,   // 每份split细分多少段
//                    length :12,        // 属性length控制线长
//                    lineStyle: {       // 属性lineStyle控制线条样式
//                        color: 'auto'
//                    }
//                },
//                axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
//                    textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
//                        color: 'auto'
//                    }
//                },
//                splitLine: {           // 分隔线
//                    show: true,        // 默认显示，属性show控制显示与否
//                    length :30,         // 属性length控制线长
//                    lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
//                        color: 'auto'
//                    }
//                },
//                pointer : {
//                    width : 5
//                },
//                title : {
//                    show : true,
//                    offsetCenter: [0, '-40%'],       // x, y，单位px
//                    textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
//                        fontWeight: 'bolder'
//                    }
//                },
//                detail : {
//                    formatter:'{value}%',
//                    textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
//                        color: 'auto',
//                        fontWeight: '80'
//                    }
//                },
//                data:getFinish(),
//            }
//        ]
//    };
//    option1 = {
//
//        title: {
//            text: '当月产量明细'
//
//        },
//        tooltip : {
//            trigger: 'axis'
//        },
//        toolbox: {
//            show : true,
//            feature : {
//                mark : {show: true},
//                dataView : {show: true, readOnly: false},
//                magicType: {show: true, type: ['line', 'bar']},
//                restore : {show: true},
//                saveAsImage : {show: true}
//            }
//        },
//        calculable : true,
//        legend: {
//            data:['原材料消耗量','零件产量','原材料利用率']
//        },
//        xAxis : [
//            {
//                type : 'category',
//                data : ['1','2','3','4','5','6','7','8','9','10','11','12','13'
//                    ,'14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31']
//            }
//        ],
//        yAxis : [
//            {
//                type : 'value',
//                name : '消耗/产量',
//                axisLabel : {
//                    formatter: '{value} Kg'
//                }
//            },
//            {
//                type : 'value',
//                name : '原材料利用率',
//                axisLabel : {
//                    formatter: '{value} %'
//                }
//            }
//        ],
//        series : [
//
//            {
//                name:'原材料消耗量',
//                type:'bar',
//                data:getData(),
//            },
//            {
//                name:'零件产量',
//                type:'bar',
//                data:getData1(),
//            },
//            {
//                name:'原材料利用率',
//                type:'line',
//                yAxisIndex: 1,
//                data:getgetData2(),
//            }
//        ]
//    };

//    myChart.setOption(option);
//    myChart1.setOption(option1);
    function doSomething(){
        var title = "工艺文档";
        var url = "${ctxPath }/ProcessDocumentation";
        var iconCls = "icon-book";
        var iframe = 0;
        parent.addTab(title,url,iconCls,iframe);
    }
    function doOrderPlan(){
        var title = "合同计划";
        var url = "${ctxPath }/ContractPlan";
        var iconCls = "icon-lorry-add";
        var iframe = 0;
        parent.addTab(title,url,iconCls,iframe);
    }
    function doBasicData(){
        var title = "基础资料";
        var url = "${ctxPath }/BasicData";
        var iconCls = "icon-package";
        var iframe = 0;
        parent.addTab(title,url,iconCls,iframe);
    }
    function getData(){//原材料
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var jsonstr = [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3,12,12,10,0.1,1.3,
            2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3,12,10];
        var s;
        $.ajax({
            type:"post",
            async:false,
            url: "${ctxPath}/QualityAssurance/Matial.action",//要发送的后台地址
            data:{
                uyear:uyear,
                umonth:umouth,
                plant:localStorage.getItem("Department"),
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data1) {//ajax请求成功后触发的方法
                console.log(data1);
                s = data1.rows;
            },
        })
        jsonstr = s;
        return jsonstr;

    }
    function getData1(){//产量
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var jsonstr = '';
        var s;
        $.ajax({
            type:"post",
            async:false,
            url: "${ctxPath}/QualityAssurance/Matial1.action",//要发送的后台地址
            data:{
                uyear:uyear,
                umonth:umouth,
                plant:localStorage.getItem("Department"),
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data1) {//ajax请求成功后触发的方法
                console.log(data1);
                s = data1.rows;
            },
        })
        jsonstr = s;
        return jsonstr;

    }
    function getgetData2 () {//利用率
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var jsonstr = '';
        var s;
        $.ajax({
            type:"post",
            async:false,
            url: "${ctxPath}/QualityAssurance/Matial2.action",//要发送的后台地址
            data:{
                uyear:uyear,
                umonth:umouth,
                plant:localStorage.getItem("Department"),
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data1) {//ajax请求成功后触发的方法
                console.log(data1);
                s = data1.rows;
            },
        })
        jsonstr = s;
        return jsonstr;
    }
    function getFinish () {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var i=0 ;
        var a=0 ;
        var b=0 ;
        var c=0 ;
        $.ajax({
            type:"post",
            async:false,
            url: "${ctxPath}/QualityAssurance/Find.action",//要发送的后台地址
            data:{
                uyear:uyear,
                umonth:umouth,
                plant:localStorage.getItem("Department"),
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data1) {//ajax请求成功后触发的方法
                console.log(data1);
                i = data1.num2;
                a = data1.num;
                b = data1.num1;
                c = data1.num3;
            },
        })
        document.getElementById('rectangle').innerHTML='本月计划:'+a+'Kg';
        document.getElementById('rectangle1').innerHTML='本月完成:'+b+'Kg';
        document.getElementById('prople').innerHTML= c;
        a = [{name: '完成率',value: i}];
        return  a ;
    }
    $(function(){
        $("#User").html(localStorage.getItem("User"));
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/queryUser.action',
            dataType: "json",
            data: {
                user:localStorage.getItem("User")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                document.getElementById('UserName').innerHTML= data[0].name;
            }
        });
        $('.wu-side-tree a').bind("click",function(){
            var title = $(this).text();
            var url = $(this).attr('data-link');
            var iconCls = $(this).attr('data-icon');
            var iframe = $(this).attr('iframe')==1?true:false;
            addTab(title,url,iconCls,iframe);
        });
//        otherinfo();
    });
    <%--function otherinfo() {--%>
        <%--var myDate = new Date();--%>
        <%--var uyear = myDate.getFullYear();--%>
        <%--var umouth  = myDate.getMonth()+1;--%>
        <%--var a = 0;--%>
        <%--var b = 0;--%>
        <%--var c = 0;--%>
        <%--var d = 0;--%>
        <%--var e = 0;--%>
        <%--var f = 0;--%>
        <%--var g = 0;--%>
        <%--var h = 0;--%>
        <%--var i = 0;--%>
        <%--var j = 0;--%>
        <%--var k = 0;--%>
        <%--var l = 0;--%>
        <%--var m = 0;--%>
        <%--var n = 0;--%>
        <%--&lt;%&ndash;$.ajax({&ndash;%&gt;--%>
            <%--&lt;%&ndash;type:"post",&ndash;%&gt;--%>
            <%--&lt;%&ndash;async:false,&ndash;%&gt;--%>
            <%--&lt;%&ndash;url: "${ctxPath}/QualityAssurance/Other.action",//要发送的后台地址&ndash;%&gt;--%>
            <%--&lt;%&ndash;data:{&ndash;%&gt;--%>
                <%--&lt;%&ndash;uyear:uyear,&ndash;%&gt;--%>
                <%--&lt;%&ndash;umonth:umouth,&ndash;%&gt;--%>
                <%--&lt;%&ndash;plant:localStorage.getItem("Department"),&ndash;%&gt;--%>
            <%--&lt;%&ndash;},&ndash;%&gt;--%>
            <%--&lt;%&ndash;dataType: "json",//后台处理后返回的数据格式&ndash;%&gt;--%>
            <%--&lt;%&ndash;success: function (data1) {//ajax请求成功后触发的方法&ndash;%&gt;--%>
                <%--&lt;%&ndash;console.log(data1);&ndash;%&gt;--%>
                <%--&lt;%&ndash;a = data1.a;&ndash;%&gt;--%>
                <%--&lt;%&ndash;b = data1.b;&ndash;%&gt;--%>
                <%--&lt;%&ndash;c = data1.c;&ndash;%&gt;--%>
                <%--&lt;%&ndash;d = data1.d;&ndash;%&gt;--%>
                <%--&lt;%&ndash;e = data1.e;&ndash;%&gt;--%>
                <%--&lt;%&ndash;f = data1.f;&ndash;%&gt;--%>
                <%--&lt;%&ndash;g = data1.g;&ndash;%&gt;--%>
                <%--&lt;%&ndash;h = data1.h;&ndash;%&gt;--%>
                <%--&lt;%&ndash;i = data1.i;&ndash;%&gt;--%>
                <%--&lt;%&ndash;j = data1.j;&ndash;%&gt;--%>
                <%--&lt;%&ndash;k = data1.k;&ndash;%&gt;--%>
                <%--&lt;%&ndash;l = data1.l;&ndash;%&gt;--%>
                <%--&lt;%&ndash;m = data1.m;&ndash;%&gt;--%>
                <%--&lt;%&ndash;n = data1.n;&ndash;%&gt;--%>
            <%--&lt;%&ndash;},&ndash;%&gt;--%>
        <%--&lt;%&ndash;})&ndash;%&gt;--%>
        <%--document.getElementById("s1").value = a;--%>
        <%--document.getElementById("s").value = b;--%>
        <%--document.getElementById("s2").value = c;--%>
        <%--document.getElementById("s3").value = d;--%>
        <%--document.getElementById("s4").value = e;--%>
        <%--document.getElementById("OrderPlan").value = f;--%>
        <%--document.getElementById("Capacity").value = g;--%>
        <%--document.getElementById("ChkStd").value = h;--%>
        <%--document.getElementById("CraftFile").value = i;--%>
        <%--document.getElementById("sa").value = j;--%>
        <%--document.getElementById("sa1").value = k;--%>
        <%--document.getElementById("sa2").value = l;--%>
        <%--document.getElementById("sa3").value = m;--%>
        <%--document.getElementById("sa4").value = n;--%>

    <%--}--%>
    function editUserPwd() {
        parent.$.modalDialog({
            title : '修改密码',
            width : 300,
            height : 250,
            href : '${ctxPath }/userEditPwd',
            buttons : [ {
                text : '确定',
                handler : function() {
                    var f = parent.$.modalDialog.handler.find('#editUserPwdForm');
                    f.submit();
                }
            } ]
        });
    }
//    function myrefresh(){
//        otherinfo();
//        getFinish();
//        getgetData2();
//        getData1();
//        getData();
//    }
//    setTimeout('myrefresh()',10000); //指定1秒刷新一次

    /**
     * Name 载入树形菜单
     */
    $('#wu-side-tree').tree({
        url:'menu.php',
        cache:false,
        onClick:function(node){
            var url = node.attributes['url'];
            if(url==null || url == ""){
                return false;
            }
            else{
                addTab(node.text, url, '', node.attributes['iframe']);
            }
        }
    });
    function confirm1(){
        $.messager.confirm('提醒', '确定退出吗？', function(r){
            if (r){
                window.location.href='${ctxPath }';
            }
        });
    }
    /**
     * Name 选项卡初始化
     */
    $('#wu-tabs').tabs({
        tools:[{
            iconCls:'icon-reload',
            border:false,
            handler:function(){
                //$('#wu-datagrid').datagrid('reload');
            }
        }]
    });

    /**
     * Name 添加菜单选项
     * Param title 名称
     * Param href 链接
     * Param iconCls 图标样式
     * Param iframe 链接跳转方式（true为iframe，false为href）
     */
    function addTab(title, href, iconCls, iframe){
        var tabPanel = $('#wu-tabs');
        if(!tabPanel.tabs('exists',title)){
            var content = '<iframe scrolling="auto" frameborder="0"  src="'+ href +'" style="width:100%;height:100%;"></iframe>';
            if(iframe){
                tabPanel.tabs('add',{
                    title:title,
                    content:content,
                    iconCls:iconCls,
                    fit:true,
                    cls:'pd3',
                    closable:true
                });
            }
            else{
                tabPanel.tabs('add',{
                    title:title,
                    href:href,
                    iconCls:iconCls,
                    fit:true,
                    cls:'pd3',
                    closable:true
                });
            }
        }
        else
        {
            tabPanel.tabs('select',title);
        }
    }
    function openTab(text,url,iconCls){
        if($("#wu-tabs").tabs("exists",text)){
            $("#wu-tabs").tabs("select",text);
        }else{
            var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${ctxPath }/static/workflow/"+url+"'></iframe>";
            $("#wu-tabs").tabs("add",{
                title:text,
                iconCls:iconCls,
                closable:true,
                content:content
            });
        }
    }

    function closeTab(text){
        $("#wu-tabs").tabs("close",text)
    }

    /**
     * Name 移除菜单选项
     */
    function removeTab(){
        var tabPanel = $('#wu-tabs');
        var tab = tabPanel.tabs('getSelected');
        if (tab){
            var index = tabPanel.tabs('getTabIndex', tab);
            tabPanel.tabs('close', main);
        }
    }


    $(".tabs").bind('contextmenu',function(e){
        e.preventDefault();
        $('#rcmenu').menu('show', {
            left: e.pageX,
            top: e.pageY
        });
    });
    //关闭所有标签页
    $("#closeall").bind("click",function(){
        var tablist =$('#wu-tabs').tabs('tabs');
//        console.log(tablist);
        //  return;
        for(var i=tablist.length-1;i>=1;i--){
            $('#wu-tabs').tabs('close',i);
        }
    });
    //关闭其他页面（先关闭右侧，再关闭左侧）
    $("#closeother").bind("click",function(){
        var tablist = $('#wu-tabs').tabs('tabs');
        var tab = $('#wu-tabs').tabs('getSelected');
        var index = $('#wu-tabs').tabs('getTabIndex',tab);
        for(var i=tablist.length-1;i>index;i--){
            $('#wu-tabs').tabs('close',i);
        }
        var num = index-1;
        if(num < 1){
            return;
        }else{
            for(var i=num;i>=1;i--){
                $('#wu-tabs').tabs('close',i);
            }
            $("#wu-tabs").tabs("select", 1);
        }
    });
    //关闭右边的选项卡
    $("#closeright").bind("click",function(){
        var tablist = $('#wu-tabs').tabs('tabs');
        var tab = $('#wu-tabs').tabs('getSelected');
        var index = $('#wu-tabs').tabs('getTabIndex',tab);
        for(var i=tablist.length-1;i>index;i--){
            $('#wu-tabs').tabs('close',i);
        }
    });
    //关闭右边的选项卡
    $("#closeleft").bind("click",function(){
        var tablist = $('#wu-tabs').tabs('tabs');
        var tab = $('#wu-tabs').tabs('getSelected');
        var index = $('#wu-tabs').tabs('getTabIndex',tab);
        var num = index-1;
        if(num < 1){
            return;
        }else{
            for(var i=num;i>=1;i--){
                $('#wu-tabs').tabs('close',i);
            }
            $("#wu-tabs").tabs("select", 1);
        }
    });
</script>
</body>
</html>

