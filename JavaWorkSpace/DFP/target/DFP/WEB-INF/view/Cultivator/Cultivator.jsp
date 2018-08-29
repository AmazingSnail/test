<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-05-30
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
    .easyui-panel {
        width: 100%;
        height: 66%;
    }


    .A{
        width:100%;
        height:75%;
    }
    .divmore{
        margin-left: -5px;
        padding: 10px 10px 10px 10px;
        /*border: 1px solid red;*/
        border-right: 1px solid #E0EEEE;
        border-bottom: 1px solid #E0EEEE;
    }
    .datagrid-row-selected {

        color: #1A1A1A;
        font-weight:bold;
        font-size: 300%;
    }
    .ci9{
        letter-spacing:0.19em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }

    .ci3{
        letter-spacing:1.9em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }
    .ci2{
        letter-spacing:2.88em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }
    .ci5{
        letter-spacing:1.38em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */

    }
    .ci6{
        letter-spacing:0.78em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */

    }
    .C{
        width:44%;
        height:75%;
    }
    .di3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .di2{
        letter-spacing:0.8em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.8em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <iframe style="display:none" id="printIframe1" src=""></iframe>
    <div class="easyui-panel"title="收割机合格证" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:80px">
            <div class="wu-toolbar-button">
                <div id="test7"><input  id ="Cqadb2" style="width:110px" class="easyui-text" hidden="hidden"></div>
<shiro:hasPermission name="/Cultivator/add">
                <a href="#" class="easyui-linkbutton"  onclick="c_add()" data-options="iconCls:'icon-add'"  plain="true">新增</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Cultivator/update">
                <a href="#" class="easyui-linkbutton"  onclick="c_update()" iconCls="icon-search"   plain="true">修改</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Cultivator/add">
                <a href="#" class="easyui-linkbutton"  onclick="c_delete()" iconCls="icon-delete"   plain="true">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Cultivator/print1">
                <a href="#" class="easyui-linkbutton"  onclick="t_print1()" iconCls="icon-print"   plain="true">打印</a>
</shiro:hasPermission>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label>工厂：</label><select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="CPlant" panelHeight="auto" data-options="
                                valueField:'statusid',
                                textField:'statusname',
                                panelHeight:'250'"
                                                      style="width:100px">
                        </select></td>
                        <td><label>生产订单号：</label><input id="COrderID" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>序列号：</label><input id="CserialID" class="easyui-textbox" style="width:150px">&nbsp</td>
                        <td><label>产品料号：</label><input id="CProductID" class="easyui-textbox" style="width:80px">&nbsp</td>
                        <td><label>起始检验日期：</label><input  id ="CSInspectionDate" style="width:110px" class="easyui-datebox"></td>
                        <td><label>结束检验日期：</label><input  id ="CEInspectionDate" style="width:110px" class="easyui-datebox"></td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="c_query()" data-options="iconCls:'icon-search'">查询</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true,border:true" >
                <table id="ci" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#trt_More").hide();
    $("#test7" ).css("display", "none");
    var CDQH='';
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#CSInspectionDate').val(year+"-"+month+"-"+day);
        $('#CEInspectionDate').val(year+"-"+month+"-"+day);
        $('#CZJYRQBEGIN').val(year+"-"+month+"-"+day);
        $('#CZJYRQEND').val(year+"-"+month+"-"+day);
        $('#Cqadb2').val(year+"-"+month+"-"+day);
        var db = $('#Cqadb2');
        db.datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                span.trigger('click'); //触发click事件弹出月份层
                //fix 1.3.x不选择日期点击其他地方隐藏在弹出日期框显示日期面板
                if (p.find('div.calendar-menu').is(':hidden')) p.find('div.calendar-menu').show();
                if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                    tds = p.find('div.calendar-menu-month-inner td');
                    tds.click(function (e) {
                        e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                        var year = /\d{4}/.exec(span.html())[0]//得到年份
                            , month = parseInt($(this).attr('abbr'), 10); //月份，这里不需要+1
                        db.datebox('hidePanel')//隐藏日期对象
                            .datebox('setValue', year + '-' + month); //设置日期的值
                    });
                }, 0);
                yearIpt.unbind();//解绑年份输入框中任何事件
            },
            parser: function (s) {
                if (!s) return new Date();
                var arr = s.split('-');
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
            },
            formatter: function (d) { return d.getFullYear() + '-' + (d.getMonth() + 1);/*getMonth返回的是0开始的，忘记了。。已修正*/ }
        });
        var p = db.datebox('panel'), //日期选择对象
            tds = false, //日期选择对象中月份
            aToday = p.find('a.datebox-current'),
            yearIpt = p.find('input.calendar-menu-year'),//年份输入框
            //显示月份层的触发控件
            span = aToday.length ? p.find('div.calendar-title span') ://1.3.x版本
                p.find('span.calendar-text'); //1.4.x版本
        if (aToday.length) {//1.3.x版本，取消Today按钮的click事件，重新绑定新事件设置日期框为今天，防止弹出日期选择面板

            aToday.unbind('click').click(function () {
                var now=new Date();
                db.datebox('hidePanel').datebox('setValue', now.getFullYear() + '-' + (now.getMonth() + 1));
            });
        }
        GC3 ();
    });
    function GC3 () {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#CWERKS').combobox('loadData', data);
                $('#CPlant').combobox('loadData', data);
            }
        });
    }
    function trt_showMore() {
        $("#trt_More").toggle();
    }
    var InspectionDate1='';
    var plant2='';
    function c_query() {
        var ProductID  = $('#CProductID').val();//物料编码
        var serialID = $('#CserialID').val();//物料描述
        var OrderID = $('#COrderID').val();
        var plant = $('#CPlant').combobox('getText');
        var plant1 = localStorage.getItem("Department");
        var starttime = $('#CSInspectionDate').datebox('getValue');
        var endtime = $('#CEInspectionDate').datebox('getValue');
        var fdata;
        if(plant==plant1||plant1=='信息中心'){
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${pageContext.request.contextPath}/Cultivator/serach.action",//要发送的后台地址
                data: {
                    ProductID:ProductID,
                    serialID:serialID,
                    OrderID:OrderID,
                    plant:plant,
                    plant2:plant2,
                    starttime:starttime,
                    endtime:endtime,
                    InspectionDate1:InspectionDate1,
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if(data.total>0){
                        $.messager.progress('close');
                        console.log(data);
                        fdata = data;
                        InspectionDate1='';
                        plant2='';
                        $("#ci").datagrid({
                            idField:'id',
                            loadFilter:pagerFilter,
                            rownumbers:true,
                            pageList:[50,100,200],//分页列表
                            pagination:true,
                            multiSort:true,
                            remoteSort:false,
                            fit: false, //自动适屏功能
                            nowrap:false,
                            width:'auto',
                            singleSelect: false, //允许选择多行
                            //fitColumns:true,
                            //fit:true,
                            method:'get',
                            data:fdata,
                            //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                            columns:[[
                                {field:'ck', checkbox: true, width: '30' },  //复选框
                                {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                                {field:'plant',title:'工厂',width: '90px',align:'center',halign:'center'},
                                {field:'plantins',title:'工厂描述',width: '90px',align:'center',halign:'center'},
                                {field:'orderid',title:'订单号',width: '120px',align:'center',halign:'center'},
                                {field:'serialid',title:'序列号',width: '150px',align:'center',halign:'center'},
                                {field:'inspectiondate',title:'检验日期',width: '250px',align:'center',halign:'center'},
                                {field:'productid',title:'产品料号',width: '110px',align:'center',halign:'center'},
                                {field:'certid',title:'合格证编号',width: '300px',align:'center',halign:'center'},
                                {field:'certdate',title:'发证日期',width: '150px',align:'center',halign:'center'},
                                {field:'companyname',title:'生产企业名称',width: '180px',align:'center',halign:'center'},
                                {field:'brand',title:'品牌',width: '100px',align:'center',halign:'center'},
                                {field:'type',title:'类型',width: '150px',align:'center',halign:'center'},
                                {field:'zcpxh',title:'型号名称',width: '230px',align:'center',halign: 'center'},
                                {field:'zmach',title:'厂内机型',width: '150px',align:'center',halign:'center'},
                                {field:'zchyj',title:'发动机型号',width: '180px',align:'center',halign:'center'},
                                {field:'zfdjh',title:'发动机号码',width: '100px',align:'center',halign:'center'},
                                {field:'power',title:'功率/kW',width: '100px',align:'center',halign:'center'},
                                {field:'emissionstd',title:'排放标准号及排放阶段',width: '150px',align:'center',halign:'center'},
                                {field:'factoryid',title:'出厂编号',width: '150px',align:'center',halign:'center'},
                                {field:'rackid',title:'机架号',width: '150px',align:'center',halign:'center'},
                                {field:'bodycolor',title:'机身颜色',width: '80px',align:'center',halign:'center'},
                                {field:'controlmode',title:'转向操纵方式',width: '100px',align:'center',halign:'center'},
                                {field:'number',title:'准乘人数',width: '100px',align:'center',halign:'center'},
                                {field:'axlenum',title:'轮轴数',width: '100px',align:'center',halign:'center'},
                                {field:'wheelbase',title:'轴距/mm',width: '100px',align:'center',halign:'center'},
                                {field:'tiresnum',title:'轮胎数',width: '100px',align:'center',halign:'center'},
                                {field:'tirespect',title:'轮胎规格',width: '250px',align:'center',halign:'center'},
                                {field:'wheelsize',title:'轮距（前/后）/mm',width: '120px',align:'center',halign:'center'},
                                {field:'tracknumber',title:'履带数',width: '100px',align:'center',halign:'center'},
                                {field:'tracktype',title:'履带规格',width: '180px',align:'center',halign:'center'},
                                {field:'gauge',title:'轨距/mm',width: '100px',align:'center',halign:'center'},
                                {field:'outsize',title:'外廓尺寸/mm',width: '200px',align:'center',halign:'center'},
                                {field:'cutwidth',title:'割台宽度/mm',width: '100px',align:'center',halign:'center'},
                                {field:'feedvolume',title:'喂入量（kg/s）/行数',width: '120px',align:'center',halign:'center'},
                                {field:'harmachquy',title:'联合收割（获）机质量/kg',width: '120px',align:'center',halign:'center'},
                                {field:'manufacturedate',title:'生产日期',width: '200px',align:'center',halign:'center'},
                                {field:'execstd',title:'执行标准/企标',width: '500px',align:'center',halign:'center'},
                                {field:'checkdate',title:'检验日期',width: '200px',align:'center',halign:'center'},
                            ]],
                        });
                    }else {
                        InspectionDate1='';
                    }


                },
                error: function (msg) {//ajax请求失败后触发的方法
                    alert(msg);//弹出错误信息
                }

            });
            $('#ci').datagrid('loadData',{total:0,rows:[]});
        }else {
            $.messager.alert("温馨提示","不能跨工厂查询!");
            GC3();
        }

    }
    var cdeleteid = '';
    function c_delete () {
        var plant = $('#CPlant').combobox('getText');
        var plant1 = localStorage.getItem("Department");
        if(plant==plant1 ||plant1=='信息中心'){
            var row = $("#ci").datagrid("getSelected");
            var selRow = $('#ci').datagrid('getSelections');//多选删除
            if(selRow.length <0||row==null){
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else{
                $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                    if (r) {
                        var id = row.id;
                        //批量行数据id
                        for (var b = 0; b< selRow.length;b++) {
                            if (cdeleteid =="") {
                                cdeleteid = selRow[b].id;
                            } else {
                                cdeleteid = selRow[b].id + "," + cdeleteid;
                            }
                        }
                        $.ajax({
                            type:"post",
                            url: "${pageContext.request.contextPath}/Cultivator/Deletedata.action",//要发送的后台地址
                            data:{
                                id:cdeleteid,
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data1) {//ajax请求成功后触发的方法
                                console.log(data1);
                                if (data1.num !=-1) {
                                    $.messager.alert('温馨提示', '删除成功');
                                    c_query();
                                    $('#ci').datagrid('clearSelections');
                                    cdeleteid = '';
                                }else {
                                    $.messager.alert('温馨提示', '删除失败');
                                }

                            },
                        })
                    }
                })
            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂删除!");
            getGC();
        }

    }
    function pagerFilter(data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }
    var Zfdjh1 = '';
    var AUFNR1 = '';
    var ZMACH = '';

    function getGDX() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#CZCHYJ').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look1.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#CPower').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look2.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#CutWidth').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/Gauge.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#Gauge').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/TrackType.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#TrackType').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look3.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#COutlineSize').combobox('loadData', data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look4.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#FeedVolume').combobox('loadData',data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look5.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#HarMachQuy').combobox('loadData', data);
            }
        });
    }
    function CZRK_pagerFilter(data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            showRefresh:false,
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }
    function  c_add() {
        $('#ci').datagrid('clearSelections');
        var plant = $('#CPlant').combobox('getText');
        var plant1 = localStorage.getItem("Department");
        if(plant==plant1||plant1=='信息中心'){
            if(plant=='采棉机事业部'||plant=="玉米机事业部"){
                parent.$.modalDialog({
                    width : '55%',
                    height : '78%',
                    href : '${ctxPath }/CultivatorOtherAdd',
                    buttons : [
                        {
                            text : '确认',
                            iconCls: "icon-save",
                            handler : function() {
                                CAddO();
                                GC3();
                            }
                        },
                        {
                            text: "取消",
                            iconCls: "icon-cancel",
                            handler:function(){
                                CultivatorOtherEditCancel();
                                GC3();
                            }
                        }
                    ]
                });
            }else {
                parent.$.modalDialog({
                    width : '78%',
                    height : '70%',
                    href : '${ctxPath }/CultivatorAdd',
                    buttons : [
                        {
                            text: "取消",
                            iconCls: "icon-cancel",
                            handler:function(){
                                CultivatorAddCancel()
                            }
                        }
                    ]
                });
            }

        }else {
            $.messager.alert("温馨提示","不能跨工厂查询!");
            getGC();
        }


    }
    var ids = '';
    var idb = '';
    var CS = '';
    function c_update () {
        var plant = $('#CPlant').combobox('getText');
        var plant1 = localStorage.getItem("Department");
        if(plant==plant1 ||plant1=='信息中心'){
            var rows = $("#ci").datagrid("getSelections");
            if(rows.length==0) {
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else {
                if(rows.length<2){
                    if(plant=='采棉机事业部'||plant=="玉米机事业部"){
                        parent.$.modalDialog({
                            width : '55%',
                            height : '79%',
                            href : '${ctxPath }/CultivatorOtherAdd',
                            buttons : [
                                {
                                    text : '确认',
                                    iconCls: "icon-save",
                                    handler : function() {
                                        CAddO();
                                        GC3();
                                    }
                                },
                                {
                                    text: "取消",
                                    iconCls: "icon-cancel",
                                    handler:function(){
                                        CultivatorOtherEditCancel();
                                        GC3();
                                    }
                                }
                            ]
                        });
                    }else {
                        parent.$.modalDialog({
                            width : '55%',
                            height : '66%',
                            href : '${ctxPath }/CultivatorEdit',
                            buttons : [
                                {
                                    text : '确认',
                                    iconCls: "icon-save",
                                    handler : function() {
                                        CAdd2();
                                        GC3();
                                    }
                                },
                                {
                                    text: "取消",
                                    iconCls: "icon-cancel",
                                    handler:function(){
                                        CultivatorEditCancel();
                                        GC3();

                                    }
                                }
                            ]
                        });
                    }

                }else {
                    $.messager.alert('信息提示', '请选择一条数据修改！');
                }

            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂修改!");
            getGC();
        }


    }
    function doPrint1(){
        $("#printIframe1")[0].contentWindow.print();
        c_query();
    }
    var temID1='';
    function  t_print1 () {
        var plant = $('#CPlant').combobox('getText');
        var plant1 = localStorage.getItem("Department");
        if(plant==plant1 ||plant1=='信息中心'){
            var row = $("#ci").datagrid("getSelected");
            var selRow = $('#ci').datagrid('getSelections');
            if(selRow.length ==0){
                $.messager.alert('信息提示','请选中合格证','info');
            }else{
                //批量行数据id
                for (var i = 0; i < selRow.length;i++) {
                    if (temID1 =="") {
                        temID1 = selRow[i].id;
                    } else {
                        temID1 = selRow[i].id + "," + temID1;
                    }
                }
                var src = $("#printIframe1").attr("src");
                document.getElementById("printIframe1").contentWindow.document.body.innerText = "";
                <%--$("#printIframe").attr("src","${pageContext.request.contextPath}/Cultivator/irprint.action?serialno="+row.id);//暂时静态PDF文件--%>
                $("#printIframe1").attr("src","${pageContext.request.contextPath}/Cultivator/irprint.action?serialno="+temID1);//暂时静态PDF文件
                $("#printIframe1").load(function(){
                    temID="";
                    $('#table').datagrid('clearSelections');
                    doPrint1();
                });
            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂打印!");
            getGC();
        }

    }
</script>