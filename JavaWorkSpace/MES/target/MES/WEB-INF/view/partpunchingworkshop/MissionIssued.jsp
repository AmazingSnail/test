<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-08
  Time: 8:36  下达任务
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
        width:50%;
        height:75%;
    }

    .M{
        width:10%;
        height:75%;
    }
    .x3{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .z2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.9em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="工单管理" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="monp_add()" plain="true">计划导入</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="monp_export()" plain="true">计划导出</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="planadd()" plain="true">合同计划导入</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="planout()" plain="true">合同计划导出</a>--%>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label><span class="z2">年月：</span></label><input  id ="midb1" style="width:110px" class="easyui-datebox">&nbsp</td>
                        <td><label>工序名称：</label><input id="mi_WorkProcedure" class="easyui-textbox" style="width:90px">&nbsp</td>
                       <td> <label>零件编码：</label><input id="mi_fno" class="easyui-textbox" style="width:90px">&nbsp</td>
                       <td><a href="#" class="easyui-linkbutton"  onclick="mi_query()" data-options="iconCls:'icon-search'" style="width:100px">查询</a></td>
                    </tr>
                    <tr>
                        <td> <label><span class="x3">事业部：</span></label>
                            <select class="easyui-combobox" name="mmPlant" style="width:110px" datatype="text" id="miPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:110px">
                            </select></td>
                        <td><label>零件规格：</label><input  id ="mi_PartDrawing" style="width:90px" class="easyui-textbox">
                        </td>
                        <td><label>零件名称：</label><input  id ="mi_PartName" style="width:90px" class="easyui-textbox">
                        </td>

                    </tr>
                </table>
            </div>

        </div>
        <div class="easyui-layout haorooms"   >
            <!--开卡信息-->
            <div class="N" data-options="region:'west',split:true" >
                <table id="MI-Data" class="easyui-datagrid" style="white-space: nowrap;height: 100%"title="工单管理"   data-options="singleSelect:true"></table>
            </div>
            <!--收发按钮-->
            <div class="" data-options="region:'center',split:true">
                <shiro:hasPermission name="/MissionIssued/back">
                <div style="height: 50%;"  >
                    <button id="MI-go" onclick="MI_go()"  class="easyui-linkbutton" style="margin-top: 80px">下达>></button>
                </div>
                <div style="">
                    <button id="MI-back" class="easyui-linkbutton" onclick="MI_back()">删除<<</button>
                </div>
                </shiro:hasPermission>
            </div>
            <!--接收明细-->
            <div class="N"  data-options="region:'east',split:true">
                <table class="easyui-datagrid" id="MI-Input"  style="white-space: nowrap;height: 100%"title="本日任务下达信息(绿色背景：计划已完成；浅绿色背景：生产中)"  data-options="singleSelect:true,editor:'text'" ></table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
var i;
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#midb1').val(year+"-"+month+"-"+day);
//        $('#ptdb').val(year+"-"+month+"-"+day);
        var db = $('#midb1');
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

//        $("#ptPlant").combobox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptstoretake();
//            }
//        });
//        $("#ptdb").datebox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptcolor();
//            }
//        });

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
                $('#miPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
    });

    function mi_query() {
        var uyear = $('#midb1').val().substr(0,4)
        var umouth  = $('#midb1').val().substr(5);
        var plant = $('#miPlant').combobox('getText');
        var partname = $('#mi_PartName').val();
        var fno = $('#mi_fno').val();
        var PartDrawing = $('#mi_PartDrawing').val();
        var WorkProcedure = $('#mi_WorkProcedure').val();
        var name = localStorage.getItem("User");
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MissionIssued/query.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umonth:umouth,
                plant:plant,
                partname:partname,
                PartDrawing:PartDrawing,
                WorkProcedure:WorkProcedure,
                fno:fno,
                name:name,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#MI-Data").datagrid({
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
                    columns:[[
                        {field:'id',title:'id',width: '55px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'workProcedure',title:'工序',width: '55px',align:'center',halign:'center'},
                        {field:'partDrawing',title:'零件规格',width: '60px',align:'right',halign:'center'},
                        {field:'partName',title:'零件名称',width: '80px',align:'left',halign:'center'},
                        {field:'workCentre',title:'打印标记',width:'70px',align:'left',halign: 'center'},
                        {field:'mastPlanNum',title:'总计划',width: '60px',align:'right',halign: 'center'},
                        {field:'remainNum',title:'剩余计划',width: '60px',align:'right',halign: 'center'},
                        {field:'orderTime',title:'交货期',width: '100px',align:'right',halign: 'center'},
                        {field:'fno',title:'零件编码',width: '80px',align:'left',halign: 'center'},
                        {field:'fname',title:'零件描述',width: '220px',align:'left',halign: 'center'},
                        {field:'departMent',title:'部门',width: '70px',align:'left',halign: 'center'},
                        {field:'plant',title:'事业部',width: '70px',align:'center',halign: 'center'},
                    ]],
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $.ajax({//当天任务
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MissionIssued/query1.action",//要发送的后台地址
            data: {

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#MI-Input").datagrid({
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
                    columns:[[
                        {field:'id',title:'id',width: '100px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'ids',title:'umonth-id',width: '80px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'planID',title:'编号',width: '80px',align:'left',halign: 'center'},
                        {field:'partDrawing',title:'零件规格',width: '60px',align:'right',halign:'center'},
                        {field:'partName',title:'零件名称',width: '60px',align:'right',halign:'center'},
                        {field:'equipID',title:'设备编号',editor:{
                            type: 'combobox',
                            options:
                                {
                                    valueField:'equipID',
                                    textField:'equipID',
                                    method:'get',
                                    required:true,
                                    onChange: function (oldVal,newVal) {
                                        var rowkc = $('#MI-Input').datagrid('getRows');
                                        var rowData = rowkc[editIndex];
                                        /*
                             获取冲制工
                                          */
                                        $.ajax({
                                            type: "get",
                                            url: "${ctxPath}/MissionIssued/GetproductMan.action",
                                            data: {
                                                equipID:oldVal,
                                            },
                                            dataType: "json",//后台处理后返回的数据格式
                                            success: function (data) {//ajax请求成功后触发的方法
                                                var ed = $('#MI-Input').datagrid('getEditor', {index: editIndex, field: 'productMan'});
                                                $(ed.target).combobox('loadData', data);

                                            }
                                        });

                                    }
                                }
                        },width: '60px',align:'center',halign:'center'},
                        {field:'mouldID',title:'模具编号',editor:{
                            type: 'combobox',
                            options:
                                {
                                    valueField:'mouldID',
                                    textField:'mouldID',
                                    method:'get',
                                    required:true,
                                }
                        },width: '90px',align:'left',halign: 'center'},
                        {field:'productMan',title:'冲制工',
                            editor:{
                                type:'combobox',
                                options:
                                    {
                                        valueField:'productMan',
                                        textField:'productMan',
                                        method:'get',
                                        required:true,
                                    }
                            },width:'60px',align:'center',halign: 'center'},
                        {field:'orderTime',title:'交付日期',
                            editor:{
                                type:'datebox',
                                options:{
                                    required:true
                                }
                            },width: '90px',align:'right',halign: 'center'},
                        {field:'productNum',title:'下达数量',
                            editor:{
                                type:'validatebox',
                                options:{
                                    required:true
                                }
                            },width:60,align:'right',halign: 'center',required: true},
                        {field:'capacity',title:'目标产量', width: '80px',align:'right',halign: 'center'},
                        {field:'fno',title:'零件编码',width: '70px',align:'left',halign: 'center'},
                        {field:'fname',title:'零件描述',width: '150px',align:'left',halign: 'center'},
                        {field:'workCentre',title:'打印标记',width: '100px',align:'left',halign: 'center'},
                        {field:'inputMan',title:'下达人',width: '70px',align:'center',halign: 'center'},
                        {field:'inputDate',title:'下达时间',width: '150px',align:'right',halign: 'center'},
                        {field:'process',title:'状态',width: '55px',align:'left',halign: 'center'},
                        {field:'departMent',title:'部门',width: '70px',align:'left',halign: 'center'},
                        {field:'plant',title:'事业部',width: '80px',align:'left',halign: 'center'},

                    ]],
                    pagination:true,
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#MI-Input').datagrid({
            rowStyler: function (index, row) {
                var over = row.process;
                if (over=='生产中') {
                    return 'background-color:red;color:white';
                }else if(over=='已完成' ){
                    return 'background-color:green ;color:white;';
                }
            }
        });
        $('#MI-Data').datagrid('loadData',{total:0,rows:[]});
        $('#MI-Input').datagrid('loadData',{total:0,rows:[]});


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

    function MI_go() {
        var one =1;
        var plant=  $('#miPlant').combobox('getText');
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var username = localStorage.getItem("User");
        var row  = $('#MI-Data').datagrid("getSelected");
        var plant1 = localStorage.getItem("Department");

        if(row.plant==plant1){
                if (endEditing()) {
                    /*
                                                                获取单日产能
                                                           */
                    $.ajax({
                        type: "get",
                        url: "${ctxPath}/MissionIssued/GetCapacity.action",
                        async:false,
                        data: {
                            fno : row.fno,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            console.log(data);
                           i =data[0].capacity;
////                            console.log(data);
//                            var ed = $('#MI-Input').datagrid('getEditor', {index: editIndex, field: 'capacity'});
                           $('#capacity').val(data[0].capacity);

                        }
                    });
                    $('#MI-Input').datagrid('appendRow', {
                        partDrawing: row.partDrawing,
                        fno:row.fno,
                        fname:row.fname,
                        plant:row.plant,
                        capacity:i,
                        ids:row.id,
                    });
                    editIndex = $('#MI-Input').datagrid('getRows').length - 1;
                    /*
                          获取设备编号
                     */
                    $.ajax({
                        type: "get",
                        url: "${ctxPath}/MissionIssued/GetEquipID.action",
                        data: {
                            partDrawing: row.partDrawing,
                            plant : row.plant,
                            departMent:row.departMent,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            console.log(data);
                            var ed = $('#MI-Input').datagrid('getEditor', {index: editIndex, field: 'equipID'});
                            $(ed.target).combobox('loadData', data);

                        }
                    });
                    /*
                          获取模具编号
                     */
                    $.ajax({
                        type: "get",
                        url: "${ctxPath}/MissionIssued/GetMouldID.action",
                        data: {
                            partDrawing: row.partDrawing,
                            plant : row.plant,
                            departMent:row.departMent,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            console.log(data);
                            var ed = $('#MI-Input').datagrid('getEditor', {index: editIndex, field: 'mouldID'});
                            $(ed.target).combobox('loadData', data);

                        }
                    });

                    $('#MI-Input').datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
                    $("input.datagrid-editable-input").keydown(function (e) {
                        var code = e.keyCode || e.which;
                        if (code === 13) {
                            var daty = new Date();
                            var NowHour = daty.getHours();
                            var NowMinute = daty.getMinutes();
                            var NowSecond = daty.getSeconds();
                            var mc = (NowHour * 3600) + (NowMinute * 60) + NowSecond;
//                            if ((mc - $('#time12').val()) > 3)//600只是一个时间值，就是5分钟内禁止重复提交
//                            {

                                var einput = $('#MI-Input').datagrid('getEditor', {
                                    index: editIndex,
                                    field: 'productNum'
                                });
                                if ($(einput.target).val() === '0.0' || parseFloat($(einput.target).val()) === 0.0) {
                                    $.messager.alert('温馨提示', '请完善好数据再保存!')
                                } else {

                                        $('#MI-Input').datagrid('endEdit', editIndex);
                                        var rowkc = $('#MI-Input').datagrid('getRows');
                                        var rowData = rowkc[editIndex];
                                        $.messager.confirm('温馨提示', '你确定要保存吗?', function (r) {
                                            if (r) {
                                                if (parseInt(row.remainNum) < parseInt(rowData.productNum)) {
                                                    $.messager.alert('温馨提示', '下达数量不能大于剩余数量！');
                                                }
                                                else {
                                                    $.ajax({
                                                        type: "post",//数据发送的方式（post 或者 get）
                                                        url: "${ctxPath}/MissionIssued/insertTake.action",//要发送的后台地址
                                                        data: {
                                                            fno: row.fno,
                                                            partDrawing:rowData.partDrawing,
                                                            equipID:rowData.equipID,
                                                            mouldID:rowData.mouldID,
                                                            productMan:rowData.productMan,
                                                            productNum:rowData.productNum,
                                                            capacity:rowData.capacity,
                                                            orderTime :rowData.orderTime,
                                                            fname:rowData.fname,
                                                            departMent:row.departMent,
                                                            partName:row.partName,
                                                            plant:rowData.plant,
                                                            inputdate: time,
                                                            workCentre:row.workCentre,
                                                            beginman: localStorage.getItem("User"),
                                                            uyear: uyear,
                                                            umonth: umonth,
                                                            ids:rowData.ids,
                                                        },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                                                        dataType: "json",//后台处理后返回的数据格式
                                                        success: function (data1) {//ajax请求成功后触发的方法
                                                            console.log(data1);
                                                            if (data1.num > 0) {
                                                                var rowIndex = $('#MI-Data').datagrid('getRowIndex', rowData.ids);
                                                                var data = $('#MI-Data').datagrid('getData').rows[rowIndex];
                                                                data.remainNum = parseInt(data.remainNum) - parseInt(rowData.productNum);
                                                                $('#MI-Data').datagrid('refreshRow', rowIndex);
                                                                $.messager.alert('温馨提示', '保存成功!');
                                                                mi_query();
                                                                $("#MI-Data").datagrid('unselectRow', rowIndex);
//                                                                var rowIndex = $('#MI-Input').datagrid('getRowIndex', row.id);
//                                                                editIndex = rowIndex;
//                                                                var data1 = $('#MI-Input').datagrid('getData').rows[rowIndex];
//                                                                data1.isok = 'yes';
//                                                                data1.isMove = 'no';
//                                                                data1.isback = 'no';
//                                                                data1.moveok = 'no';
                                                                $('#MI-Input').datagrid('refreshRow', rowIndex);
                                                             //   $("#time12").val(mc);

                                                            }

                                                        },

                                                        error: function (msg) {//ajax请求失败后触发的方法
                                                            alert(msg);//弹出错误信息
                                                        }
                                                    });

                                                }
                                            }
                                        });
                                    }
                                }


                    });
                }
                else{
                    $.messager.alert('温馨提示', '存在未编辑完数据!');

            }
        }else{
            $.messager.alert('温馨提示', '无权进行操作!');
        }





    }
    var editIndex = undefined;
    var ydIndex = undefined;
    function endEditing(){
        //alert(editIndex);
        if (editIndex == undefined){return true}
        if ($('#MI-Input').datagrid('validateRow', editIndex)){
            //alert(2222);
//            var editor = $('#kc').datagrid('getEditor',{index:editIndex,field:"itemno"});
//            var productname = $(editor.target).val();
//
//
//
//
//            $('#kc').datagrid('getRows')[editIndex]['productname'] = productname;
            $('#MI-Input').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function  MI_back() {
        var row  = $("#MI-Input").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要退回吗?', function (r) {
                            if (r) {
                                if (row.id === undefined) {
                                    if (editIndex == undefined) {
                                        return
                                    }
                                    $('#MI-Input').datagrid('cancelEdit', editIndex)
                                        .datagrid('deleteRow', editIndex);
                                    editIndex = undefined;
                                    $('#MI-Data').datagrid('loadData',{total:0,rows:[]});
                                    $('#MI-Input').datagrid('loadData',{total:0,rows:[]});
                                     mi_query();
                            }else{
                                jQuery.ajax({
                                    type: "POST",   //post提交方式默认是get
                                    url: "${ctxPath}/MissionIssued/deleteTake.action",
                                    dataType: "json",
                                    data: {
                                        fno: row.fno,
                                        id : row.id,
                                        productNum:row.productNum,
                                    },
                                    error: function (request) {      // 设置表单提交出错
                                        $.messager.progress('close');
                                        $.messager.alert('信息提示', '出错了！', 'info');
                                    },
                                    success: function (data) {
                                        console.log(data);
                                        if(data.num>0){
                                            $.messager.alert('信息提示', '删除成功！！！');
                                            mi_query();
                                            $('#MI-Data').datagrid('loadData',{total:0,rows:[]});
                                            $('#MI-Input').datagrid('loadData',{total:0,rows:[]});
                                        }else{
                                            $.messager.alert('信息提示', '删除失败！！！');
                                            $('#MI-Data').datagrid('loadData',{total:0,rows:[]});
                                            $('#MI-Input').datagrid('loadData',{total:0,rows:[]});
                                        }
                                    }
                                })
                            }
                            }
                        })
                    }



    }
</script>