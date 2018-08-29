<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-06
  Time: 14:42 ---月度计划
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }


    .N{
        width:75%;
        height:75%;
    }

    .M{
        width:30%;
        height:75%;
    }
    .m3{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .cc2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.9em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 100px);
    }
    .labelstyle{
        margin-right: 3px;
    }
    #ms {
        width: 10px;
        height: 10px;
        background: #AEEEEE;
    }
    #ms1 {
        width: 10px;
        height: 10px;
        background: #EEC900;
    }
    #ms2 {
        width: 10px;
        height: 10px;
        background: #9F79EE;
    }
    #ms3 {
        width: 10px;
        height: 10px;
        background: #6E8B3D;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="月度计划" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
            <div class="wu-toolbar-button">
<shiro:hasPermission name="/MonthPlan/add">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="monp_add()" plain="true">计划导入</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MonthPlan/export">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="monp_export()" plain="true">计划导出</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MonthPlan/delete">
                <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="plandelete()" plain="true">计划删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MonthPlan/contract">
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="Contract()" plain="true">匹配合同</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MonthPlan/send">
                <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="Send()" plain="true">提交</a>
</shiro:hasPermission>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label><span class="cc2">年月：</span></label><input  id ="mpptdb1" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td><label>工序名称：</label><input id="WorkProcedure" class="easyui-textbox" style="width:90px">&nbsp</td>
                        <td><label>零件编码：</label><input id="Fno" class="easyui-textbox" style="width:100px"  ></td>
                        <td><label>零件名称：</label><input  id ="PartName" style="width:90px" class="easyui-textbox" >
                        </td>
                        <td> <a href="#" class="easyui-linkbutton"  onclick="mpquery()" data-options="iconCls:'icon-search'" style="width:100px">查询</a></td>
                    </tr>
                    <tr>
                        <td> <label><span class="m3">事业部：</span></label>
                            <select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="MonthPlan-Plant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:100px">
                            </select></td>
                        <td><label>零件规格：</label><input  id ="PartDrawing" style="width:90px "  class="easyui-textbox">
                        </td>
                        <td> <label>零件描述：</label><input id="Fname" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label class="labelstyle"><input type="radio" name="monthCheck" value="3"  checked="checked"/>全部</label>
                            <label class="labelstyle"><input type="radio" name="monthCheck" value="2" />已完成</label>
                            <label class="labelstyle"><input type="radio" name="monthCheck" value="1" />未完成</label>
                        </td>
                        <td>
                            <label class="labelstyle"><input type="radio" name="monthCheck" value="4" />已提交</label>
                            <label class="labelstyle"><input type="radio" name="monthCheck" value="5" />未提交</label>
                        </td>

                    </tr>
                </table>
            </div>

        </div>
        <div class="easyui-layout haorooms"  >
            <div class="N" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'" title="工艺文档: 浅蓝色  产能: 黄色  检验标准：淡紫色  合同 : 深色">
                        <table id="mp" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
            <div class="M"  data-options="region:'east',split:true">
                <table class="easyui-datagrid" id="mpid"   style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#mpptdb1').val(year+"-"+month+"-"+day);
//        $('#ptdb').val(year+"-"+month+"-"+day);
        var db = $('#mpptdb1');
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
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MonthPlan/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#MonthPlan-Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $('#Fno').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#WorkProcedure').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#PartName').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#PartDrawing').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#Fname').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
    });
//    function mp_getKey() {
//         alert(1);
//        if(event.keyCode==13){
//            mpquery();
//        }
//    }

    function Send () {
        var state = $('input[name="monthCheck"]:checked').val();
        if(state=="5"){
            var uyear = $('#mpptdb1').val().substr(0,4)
            var umonth  = $('#mpptdb1').val().substr(5);
            var plant = $('#MonthPlan-Plant').combobox('getText');
            $.messager.confirm('温馨提示', '你确定要提交吗?', function (r) {
                if (r) {
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/MonthPlan/Send.action",//要发送的后台地址
                        data:{
                            uyear:uyear,
                            umonth:umonth,
                            plant:plant,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num !=-1) {
                                $.messager.alert('温馨提示', '提交成功！！！');
                                mpquery();
                            }else {
                                $.messager.alert('温馨提示', '提交失败');
                                mpquery();
                            }

                        },
                    })
                }
            })
        }else {
            $.messager.alert('温馨提示', '请选择未提交！！！');
        }

    }

    function plandelete() {
        var row = $("#mp").datagrid("getSelected");
        var ids = row.id;
        $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
            if (r) {
                $.ajax({
                    type:"post",
                    url: "${ctxPath}/MonthPlan/delete1.action",//要发送的后台地址
                    data:{
                        ids:ids,
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data1) {//ajax请求成功后触发的方法
                        console.log(data1);
                        if (data1.num !=-1) {
                            $.messager.alert('温馨提示', '删除成功！！！');
                            mpquery();
                        }else {
                            $.messager.alert('温馨提示', '删除失败');
                            mpquery();
                        }

                    },
                })
            }})
    }
    function mpquery() {
        var uyear = $('#mpptdb1').val().substr(0,4)
        var umouth  = $('#mpptdb1').val().substr(5);
        var plant = $('#MonthPlan-Plant').combobox('getText');
        var fname = $('#Fname').val();
        var WorkProcedure = $('#WorkProcedure').val();
        var Fno = $('#Fno').val();
        var PartDrawing = $('#PartDrawing').val();
        var PartName = $('#PartName').val();
        var name = localStorage.getItem("User");
        var state = $('input[name="monthCheck"]:checked').val();
        var fdata;

        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MonthPlan/Serach.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umonth:umouth,
                plant:plant,
                fname:fname,
                WorkProcedure:WorkProcedure,
                name:name,
                PartDrawing:PartDrawing,
                fno:Fno,
                state:state,
                PartName:PartName
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#mp").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    fit: false, //自动适屏功能
                    nowrap:false,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    frozenColumns:[[
                        {field:'workProcedure',title:'工序名称',width: '60px',align:'center',halign:'center',
                            styler: function (value, row, index) {
                            if(row.craftFile=="1")
                                return 'background-color:#AEEEEE;color:white';
                            }},
                        {field:'partDrawing',title:'零件规格',width: '70px',align:'right',halign:'center',
                            styler: function (value, row, index) {
                                if(row.capacity=="1")
                                    return 'background-color:#EEC900;color:white';
                            }},
                        {field:'partName',title:'零件名称',width: '60px',align:'left',halign: 'center',
                            styler: function (value, row, index) {
                                if(row.chkStd=="1")
                                    return 'background-color:#9F79EE;color:white';
                            }},
                        {field:'workCentre',title:'打印标记',width:'70px',align:'left',halign: 'center',
                            styler: function (value, row, index) {
                                if(row.orderPlan=="1")
                                    return 'background-color:#6E8B3D;color:white';
                            }},
                    ]],
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'mastPlanNum',title:'总计划数',width:'60px',align:'right',halign: 'center'},
                        {field:'lastRemainNum',title:'上月计划',width: '60px',align:'right',halign: 'center'},
                        {field:'planNum',title:'大计划数',width: '60px',align:'right',halign: 'center'},
                        {field:'patchPlan',title:'临时计划',width: '60px',align:'right',halign: 'center'},
                        {field:'outputNum',title:'本日产出',width: '60px',align:'right',halign: 'center'},
                        {field:'accOutputNum',title:'累计产出',width: '60px',align:'right',halign: 'center'},
                        {field:'remainNum',title:'剩余计划',width: '60px',align:'right',halign: 'center'},
                        {field:'orderTime',title:'交货期',width: '100px',align:'right',halign: 'center'},
                        {field:'fno',title:'零件编码',width: '90px',align:'center',halign: 'center'},
                        {field:'fname',title:'零件描述',width: '220px',align:'left',halign: 'center'},
                        {field:'inputMan',title:'导入人',width: '70px',align:'center',halign: 'center'},
                        {field:'inputDate',title:'导入时间',width: '160px',align:'right',halign: 'center'},
                        {field:'departMent',title:'部门',width: '70px',align:'center',halign: 'center'},
                        {field:'plant',title:'事业部',width: '70px',align:'center',halign: 'center'},
                        {field:'craftFile',title:'工艺文档',width: '70px',align:'center',halign: 'center'},
                        {field:'capacity',title:'产能',width: '70px',align:'center',halign: 'center'},
                        {field:'chkStd',title:'检验标准',width: '70px',align:'center',halign: 'center'},
                        {field:'orderPlan',title:'合同',width: '70px',align:'center',halign: 'center'},
                        {field:'uyear',title:'年度',width: '70px',align:'center',halign: 'center',hidden:'true'},
                        {field:'umouth',title:'月度',width: '70px',align:'center',halign: 'center',hidden:'true'},
                    ]],
                    pagination:true,
                });
//
                $('#mp').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#mp').datagrid('loadData',{total:0,rows:[]});
        $('#mpid').datagrid('loadData',{total:0,rows:[]});
    }

    function Contract () {
        var uyear = $('#mpptdb1').val().substr(0,4)
        var umouth  = $('#mpptdb1').val().substr(5);
        var plant = $('#MonthPlan-Plant').combobox('getText');
        var fname = $('#Fname').val();
        var WorkProcedure = $('#WorkProcedure').val();
        var Fno = $('#Fno').val();
        var PartDrawing = $('#PartDrawing').val();
        var PartName = $('#PartName').val();
        var name = localStorage.getItem("User");
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MonthPlan/contract.action',
            dataType: "json",
            data: {
                uyear:uyear,
                umonth:umouth,
                plant:plant,
                fname:fname,
                WorkProcedure:WorkProcedure,
                name:name,
                PartDrawing:PartDrawing,
                fno:Fno,
                PartName:PartName
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success:function(data) {
                console.log(data);
                $.messager.alert('温馨提示', '匹配成功！！！');
            },
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
    $("#mp").datagrid({
        //双击事件
        onClickRow : function (index, row) {  //easyui封装好的事件（被单机行的索引，被单击行的值）
            var fno = row.fno;
             var uyear = row.uyear;
             var umouth = row.umouth;
             var num = row.accOutputNum;
             var fdata;
            $.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${ctxPath}/MonthPlan/finish.action",
                dataType:"json",
                data: {
                    fno:fno,
                    uyear:uyear,
                    umouth:umouth,
                    num:num
                },
                success:function(data) {
                    console.log(data);
                    fdata = data;
                    $('#mpid').datagrid({
                        data: fdata,
                        loadFilter:pagerFilter,
                        rownumbers:true,
                        singleSelect:true,
                        fit: false, //自动适屏功能
                        nowrap:false,
                        width:'auto',
                        pageList:[25,50,100],//分页列表
                        pagination:true,
                        multiSort:true,
                        remoteSort:false,
                        showFooter: true,
                        //fitColumns:true,
                        //fit:true,
                        method:'get',
                        data:fdata,
                        columns: [[
                            {field:'orderLine',title:'厂编合同号',width: '150px',align:'left',halign:'center'},
                            {field:'planNum',title:'计划数量',width: '60px',align:'right',halign: 'center'},
                            {field:'orderTime',title:'交货期',width: '100px',align:'right',halign: 'center'},
                            {field:'partDrawing',title:'规格',width: '100px',align:'right',halign: 'center'},
                            {field:'fno',title:'零件编码',width: '80px',align:'center',halign:'center'},
                            {field:'fname',title:'零件描述',width: '220px',align:'left',halign:'center'},
                            {field:'workCentre',title:'打印标记',width: '80px',align:'left',halign: 'center'},
                            {field:'over',title:'完成情况',width: '60px',align:'center',halign: 'center'},
                            {field:'workprocedure',title:'工序',width: '60px',align:'left',halign: 'center'},
                            {field:'plant',title:'事业部',width: '60px',align:'center',halign: 'center'},
                            {field:'departMent',title:'部门',width: '60px',align:'center',halign: 'center'},
                            {field:'uyear',title:'年度',width: '50px',align:'center',halign: 'center'},
                            {field:'umouth',title:'月度',width: '50px',align:'center',halign: 'center'},
                        ]]
                    })
                    $('#mpid').datagrid({
                        rowStyler: function (index, row) {
                            var over = row.over;
                            if (over=='完成') {
                                return 'background-color:#008B45;color:white';
                            }else if(over=='Yes' ){
                                return 'background-color:#808000 ;color:white;';
                            }
                        }
                    });
                    $('#ptid').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                },

            })

            $('#mpid').datagrid('loadData',{total:0,rows:[]});
        }
    });
function monp_add() {
    var date=new Date();
    var planyear = date.getFullYear();
    var planmonth = date.getMonth()+1;
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
    var plant = localStorage.getItem("Department");
    var upload = new Ext.form.FormPanel({
        frame: true,
        labelWidth: 100,
        labelAlign: 'right',
        fileUpload: true,
        border: true,
        defaults: {
            width: 200,
            allowBlank: false,
            blankText: '该项不能为空！'
        },
        items: [{
            xtype: 'displayfield',
            value: '上传文件为[*.xls]&nbsp;&nbsp;&nbsp;&nbsp;'
//                '<a href="javascript:;" onclick="monp_download_log();" style="color: green;">模版下载</a>'
        }, {
            id: 'formFile',
            fieldLabel: "导入文件",
            name: 'uploadFile',
            params: {
                "umouth": planmonth,
                "User": localStorage.getItem("User"),
            },
            xtype: 'textfield',
            fileUpload: true,
            inputType: 'file',
            listeners: {
                render: function () {
                    Ext.get('formFile').on("change", function () {
                        var file = this.getValue();
                        var fs = file.split('.');
                        if (fs[fs.length - 1].toLowerCase() == 'xls') {
                            Ext.MessageBox.show({
                                title: '信息',
                                msg: '<font color="green">确定要上传文件:' + file + '？</font>',
                                params: {
                                    "year": planyear,
                                    "month":planmonth,
                                    "User": localStorage.getItem("User"),
                                    time:time,
                                    plant:plant,
                                },
                                width: 300,
                                buttons: {'ok': '确定', 'no': '取消'},
                                icon: Ext.MessageBox.WARNING,
                                closable: false,
                                fn: function (e) {
                                    if (e == 'ok') {
                                        if (upload.form.isValid()) {
                                            upload.getForm().submit({

                                                url: '${ctxPath}/MonthPlan/import.action',
                                                method: 'POST',
                                                params: {
                                                    "year": planyear,
                                                    "month":planmonth,
                                                    "User": localStorage.getItem("User"),
                                                    "time":time,
                                                    "plant":plant,
                                                },
                                                waitTitle: '系统提示',
                                                waitMsg: '正在上传,请稍后...',
                                                success: function (form, action) {
                                                    console.log(action);
                                                    var msg = action.result.message;
                                                    Ext.MessageBox.show({
                                                        title: '信息',
                                                        width: 250,
                                                        msg: msg,
                                                        buttons: {'ok': '确定', 'no': '取消'},
                                                        icon: Ext.MessageBox.INFO,
                                                        closable: false,
                                                        fn: function (e) {
                                                            if (e == 'ok') {
                                                                win.close();
                                                                mpquery();
                                                            } else {
                                                                Ext.getCmp('formFile').setValue('');
                                                            }
                                                        }
                                                    });
                                                }
                                            });
                                        }
                                        else {
                                            Ext.MessageBox.show({
                                                title: '信息',
                                                width: 200,
                                                msg: '请填写完成再提交!',
//                                            animEl:'insert.win.info',
                                                buttons: {'ok': '确定'},
                                                icon: Ext.MessageBox.ERROR,
                                                closable: false
                                            });
                                        }
                                    }
                                }
                            });
                        } else {
                            Ext.MessageBox.show({
                                title: '信息',
                                width: 200,
                                msg: '上传文件格式不对,请重新选择!',
                                buttons: {'ok': '确定'},
                                icon: Ext.MessageBox.ERROR,
                                closable: false,
                                fn: function (e) {
                                    if (e == 'ok') {
                                        Ext.getCmp('formFile').setValue('');
                                    }
                                }
                            });
                        }
                    });
                }
            }
        }]
    });
    var win = new Ext.Window({
        title: '上传',
        width: 400,
        height: 150,
        layout: 'fit',
        modal: true,
        items: [upload],
        bbar: ['->', {
//    		id:'insert.win.info',
//    		text:'上传',
//    		handler:function(){
//
//    		}
//    	},{
            text: '关闭',
            handler: function () {
                win.close();
            }
        }]
    }).show();
}

function monp_export() {
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var plant = $('#MonthPlan-Plant').combobox('getText');
    var fname = $('#Fname').val();
    var WorkProcedure = $('#WorkProcedure').val();
    var Fno = $('#Fno').val();
    var PartDrawing = $('#PartDrawing').val();
    var PartName = $('#PartName').val();
    var name = localStorage.getItem("User");
    var state = $('input[name="monthCheck"]:checked').val();
    var url = "../${ctxPath}/MonthPlan/mpmonpExport?uyear="+uyear+"&umouth="+umouth+"&plant="+plant+"&WorkProcedure="+WorkProcedure+"&PartDrawing="+PartDrawing+"&Fno="+Fno+"&state="+state+"&PartName="+PartName+"&name=+"+name+"&fname=+"+fname+"";
    window.location.href = url;
}
</script>


