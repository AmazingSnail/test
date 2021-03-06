<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-08
  Time: 10:31---生产任务管理---
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


    .A{
        width:80%;
        height:75%;
    }
    .datagrid-row-selected {

        color: #1A1A1A;
        font-weight:bold;
        font-size: 300%;
    }
    .C{
        width:25%;
        height:75%;
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .w2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="完工管理" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
                <div id="tesxt"><input  id ="ptmdb1" style="width:110px" class="easyui-text" hidden="hidden"></div>
<shiro:hasPermission name="/ProductionTaskManagement/sure">
                <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="sure()" plain="true">完成确认</a>
</shiro:hasPermission>
<shiro:hasPermission name="/ProductionTaskManagement/dissure">
                <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="dissure()" plain="true">确认取消</a>
</shiro:hasPermission>
<shiro:hasPermission name="/ProductionTaskManagement/export">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="ptm_export()" plain="true">导出</a>
</shiro:hasPermission>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr><td>开始时间：<input  id ="ptmdb2" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td>结束时间：<input  id ="ptmdb3" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td>事业部： <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="ptmPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                         style="width:100px">
                        </select></td>
                        <td><label>规 格：</label><input id="ptm-PartDrawing" class="easyui-textbox" style="width:60px">&nbsp</td>
                        <td><label>模具编码：</label><input id="ptm-MouldID" class="easyui-textbox" style="width:80px">&nbsp</td>
                        <td><label>生产状态：</label><select class="easyui-combobox" name="takekind" datatype="text" id="ptm-Status" panelHeight="auto" style="width:70px">
                            <option value=""></option>
                            <option value="SC01">计划中</option>
                            <option value="SC02">生产中</option>
                            <option value="SC03">已完成</option>
                        </select> </td>
                        <td><label class="labelstyle" hidden><input type="radio" name="ptmcheck" value="3" checked="checked" hidden/></label>
                            <label class="labelstyle"><input type="radio" name="ptmcheck" value="3" checked/>全部</label>
                            <label class="labelstyle"><input type="radio" name="ptmcheck" value="2" />现场确认</label>
                            <label class="labelstyle"><input type="radio" name="ptmcheck" value="1" />班长确认</label>
                        </td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="pt_query()" data-options="iconCls:'icon-search'">查询</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'" title="完工管理(绿色字体：已完成;  红色字体：生产中;绿色背景：现场确认;浅绿色：班长确认)">
                        <table id="pt" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
            <div class="C"  data-options="region:'east',split:true" >
                <table class="easyui-datagrid" id="ptid" title="零件筐数(绿色字体：已称重;红色字体：未称重)"  style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>

            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $("#tesxt" ).css("display", "none");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#ptmdb1').val(year+"-"+month);
        $('#ptmdb2').val(year+"-"+month+"-"+"01" );
        $('#ptmdb3').val(year+"-"+month+"-"+day);
        var db = $('#ptmdb1');
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
                $('#ptmPlant').combobox('loadData', data);
                //alert(11111);

            }
        });

    });

    function pt_query() {
        $('#ptid').datagrid('loadData',{total:0,rows:[]});
        var uyear = $('#ptmdb1').val().substr(0,4);;
        var umouth  = $('#ptmdb1').val().substr(5);
        var plant = $('#ptmPlant').combobox('getText');
        var state = $('input[name="ptmcheck"]:checked').val();
        var PartDrawing = $('#ptm-PartDrawing').val();
        var MouldID = $('#ptm-MouldID').val();
        var ptmStatus = $('#ptm-Status').combobox('getValue');
        var name = localStorage.getItem("User");
         var starttime = $('#ptmdb2').datebox('getValue');
        var endtime = $('#ptmdb3').datebox('getValue');
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/ProductionTask/Serach.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umonth:umouth,
                plant:plant,
                state:state,
                partDrawing:PartDrawing,
                mouldID:MouldID,
                starttime:starttime,
                endtime:endtime,
                name:name,
                ptmStatus:ptmStatus,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#pt").datagrid({
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
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'planID',title:'计划编号',width: '90px',align:'center',halign:'center'},
                        {field:'partDrawing',title:'零件规格',width: '60px',align:'right',halign:'center'},
                        {field:'partName',title:'零件名称',width: '70px',align:'left',halign:'center'},
                        {field:'fno',title:'零件编码',width: '100px',align:'left',halign:'center'},
                        {field:'fname',title:'零件描述',width: '200px',align:'left',halign: 'center'},
                        {field:'equipID',title:'设备编号',width:'65px',align:'center',halign: 'center'},
                        {field:'mouldID',title:'模具编号',width: '80px',align:'left',halign: 'center'},
                        {field:'productMan',title:'冲制工',width: '70px',align:'center',halign: 'center'},
                        {field:'productNum',title:'下达数量',width: '55px',align:'right',halign: 'center'},
                        {field:'realFinishNum',title:'完成数量',width: '55px',align:'right',halign: 'center'},
                        {field:'finishNum',title:'理论完成',width: '90px',align:'right',halign: 'center'},
                        {field:'orderTime1',title:'交付时间',width: '110px',align:'right',halign: 'center'},
                        {field:'statusName',title:'生产状态',width: '60px',align:'left',halign: 'center'},
                        {field:'sure',title:'现场完成确认',width: '80px',align:'center',halign: 'center'},
                        {field:'process',title:'班长完成确认',width: '80px',align:'center',halign: 'center'},
                        {field:'beginTime',title:'计划开始',width: '160px',align:'left',halign: 'center'},
                        {field:'endTime',title:'计划结束',width: '110px',align:'left',halign: 'center'},
                        {field:'qualRatio',title:'检验合格率',width: '80px',align:'center',halign: 'center'},
                        {field:'compRatio',title:'计划达成率',width: '80px',align:'center',halign: 'center'},
                        {field:'uyear',title:'年度',width: '60px',align:'right',halign: 'center'},
                        {field:'umouth',title:'月度',width: '60px',align:'right',halign: 'center'},
                    ]],
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#pt').datagrid({
            rowStyler: function (index, row) {
                var over = row.statusName;
                var s = row.sure;
                var s1 = row.process;
                if(over=='生产中'){
                    return 'color:red';
                }else if(over=='已完成'){
                    if(s=='确认'&&s1=='确认'){
                        return 'background-color:green';
                    }else if (s=='确认'&&s1=='未确认'){
                        return 'background-color:#98FB98';
                    }
                }
            }
        });
        $('#pt').datagrid('loadData',{total:0,rows:[]});

//        $('#Mmid').datagrid('loadData',{total:0,rows:[]});

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
//   function  jilian() {
       $("#pt").datagrid({
           //双击事件
           onClickRow : function (index, row) {  //easyui封装好的事件（被单机行的索引，被单击行的值）
               var planID = row.planID;
                var plant = row.plant;
                var department = row.department;
               $.ajax({
                   type:"POST",   //post提交方式默认是get
                   url:"${ctxPath}/ProductionTask/jilian.action",
                   dataType:"json",
                   data: {
                       planID:planID,
                       plant:plant,
                       department:department,
                   },
                   success:function(data) {
                       fdata = data;
                       $('#ptid').datagrid({
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
                           method:'get',
                           data:fdata,
                           columns: [[
                               {field:'serialno',title:'开卡编号',width:'100px',editor:'text',halign:"center",align:'left'},
                               {field:'fno',title:'零件编码',width:'80px',editor:'text',align:'right',halign:"center"},
                               {field:'weightNum',title:'重量',width:'70px',editor:'text',align:'center',sortable:true,remoteSort:false},
                               {field:'partDrawing',title:'零件规格',width:'70px',editor:'text',align:'center'},
                               {field:'reelnum',title:'炉批号',width:'70px',editor:'text',align:'center'},
                               {field:'productMan',title:'冲制工',width:'70px',editor:'text',align:'center'},
                               {field:'productTime',title:'冲制时间',width:'200px',editor:'text',align:'center'},
                               {field: 'id', title: '编号', width: '70',hidden:'true', editor: 'text',align:'center'},
                           ]],
                           pagination:true,
                           sortOrder:'asc',
                           sortName: 'weightNum',
                       })
                       $('#ptid').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                   },

               })
               $('#ptid').datagrid({
                   rowStyler: function (index, row) {
                       var num = row.weightNum;
                       if (num>0) {
                           return 'background-color:#008B45;color:white';
                       }
                   }
               });
               $('#ptid').datagrid('loadData',{total:0,rows:[]});

           }
       });

//   }
function sure() {
    var row = $('#pt').datagrid("getSelected");
    var  sure= row.sure;
    if(sure=="未确认"){
        $.messager.alert('温馨提示', '请现场完成确认！！！');
    }else {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var plant = $('#ptmPlant').combobox('getText');
        var name = localStorage.getItem("User");
        var planID = row.planID;
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/ProductionTask/sure.action',
            dataType: "json",
            data: {
                plant: plant,
                time : time,
                name :name,
                planID :planID,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $.messager.alert('温馨提示', '班长已经完成确认！！！');
                pt_query();

            }
        });
    }
}
    function dissure() {
        var row = $('#pt').datagrid("getSelected");
        var  sure= row.sure;
        if(sure=="未确认"){
            $.messager.alert('温馨提示', '请现场完成确认！！！');
        }else {
            var myDate = new Date();
            var uyear = myDate.getFullYear();
            var umouth  = myDate.getMonth()+1;
            var uday = myDate.getDate();
            var uhour = myDate.getHours();
            var umin = myDate.getMinutes();
            var ums = myDate.getSeconds();
            var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
            var name = localStorage.getItem("User");
            var plant = $('#ptmPlant').combobox('getText');

            var planID = row.planID;
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/ProductionTask/dissure.action',
                dataType: "json",
                data: {
                    plant: plant,
                    time : time,
                    name :name,
                    planID :planID,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $.messager.alert('温馨提示', '取消完成确认！！！');
                    pt_query();

                }
            });
        }
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
    function ptm_export() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var plant = $('#ptmPlant').combobox('getText');
        var state = $('input[name="ptmcheck"]:checked').val();
        var PartDrawing = $('#ptm-PartDrawing').val();
        var MouldID = $('#ptm-MouldID').val();
        var ptmStatus = $('#ptm-Status').val();
        var url = "../${ctxPath}/Export/Export2?uyear="+uyear+"&umouth="+umouth+"&plant="+plant+"&MouldID="+MouldID+"&PartDrawing="+PartDrawing+"&ptmStatus="+ptmStatus+"&state="+state+"";
        window.location.href = url;
    }
</script>



