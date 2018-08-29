<%--<%@ page language="java" contentType="text/html; charset=utf-8"--%>
         <%--pageEncoding="utf-8"%>--%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<%--<html>--%>
<%--<head>--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">--%>
    <%--<title>文件上传下载</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<form action="http://localhost:9090/MES/DeviceManagement/upload" method="post" enctype="multipart/form-data">--%>
    <%--选择文件:<input type="file" name="file" width="120px">--%>
    <%--<input type="submit" value="上传">--%>
<%--</form>--%>
<%--<hr>--%>
<%--<form action="http://localhost:8080/uploadDemo/rest/file/down" method="get">--%>
    <%--<input type="submit" value="下载">--%>
<%--</form>--%>
<%--</body>--%>
<%--</html>--%>
<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-14
  Time: 10:13----基础资料
  To change this template use File | Settings | File Templates.
--%>
<%--
 Created by IntelliJ IDEA.
 User: chent
 Date: 2018-03-12
 Time: 13:30  ---人员维护
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
    .H{
        width:15%;
        height:75%;
    }

    .J{
        width:90%;
        height:75%;
    }
    #yuanjiao{
        font-family: Arial;
        border: 2px solid #379082;
        border-radius: 20px;
        padding: 30px 30px;
        width: 330px;
    }
    .e2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-1em; /*同上*/
    }
    .e3{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 60px);
    }


    body{
        padding: 0px;
        margin: 0px;
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <iframe id="proxy2" style="display:none"></iframe>
        <div class="easyui-panel "  data-options="fit:true">
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 60px;">
                <div class="wu-toolbar-button" >
                </div>
                <div class="wu-toolbar-search" >
                    <label><span class="m3">事业部：</span></label>
                    <select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="bdPlant1" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                            style="width:100px">
                    </select>&nbsp
<shiro:hasPermission name="/Info/addinfo">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addinfo()" plain="true" style="width: 100px;text-align: center">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Info/deleteinfo">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="deleteinfo()" plain="true" style="width: 100px;text-align: center">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Info/updateinfo">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="updateinfo()" plain="true" style="width: 100px;text-align: center">修改</a>
</shiro:hasPermission>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="H" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <ul id="tree_base1" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="J"  data-options="region:'east',split:true">
                    <table id="info" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlgfc" class="easyui-dialog"  title="添加/修改" style="width:300px; height: 230px;  padding: 10px;"
     closed="true" buttons="#dlgfc-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
      发出指令添加/修改
    </div>
    <form id="fmsave" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px;text-align: center" >
                <tr>
                    <td>发出地址：<input name="Inlocation"  id="ip" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>发出指令：<input name="Inlocation"  id="ReOrder" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgfc-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveFC()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>


<div id="dlgxr" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 350px;  padding: 10px;"
     closed="true" buttons="#dlgxr-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        写入指令添加/修改
    </div>
    <form id="fmsave1" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >

                <tr>
                    <td>设备编号：<input name="Inlocation"  id="EquipID" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

                <tr>
                    <td>写入指令：<input name="Inlocation"  id="WriOrder" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>写入名称：<input name="Inlocation"  id="OrderName" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>写入标识：<input name="Inlocation"  id="FieType" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgxr-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveXR()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgzt" class="easyui-dialog"  title="添加/修改" style="width:300px; height: 310px;  padding: 10px;"
     closed="true" buttons="#dlgxr-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        状态添加/修改
    </div>
    <form id="fmsave2" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >

                <tr>
                    <td>基础代码：<input name="Infname" id="StatusID" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>

                <tr>
                    <td>基础状态：<input name="Inlocation"  id="StatusName" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

                <tr>
                    <td>状态所属：<input name="Inlocation"  id="DepartMent" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

            </table>

        </div>

    </form>
</div>
<div id="dlgxr-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveZT()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<script type="text/javascript">
    var i='' ;
    var ids='';
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
    var name = localStorage.getItem("User");

    function SaveFC () {
        var  ReOrder = $('#ReOrder').val();//指令
        var  ip = $('#ip').val();//ip
        if(ReOrder!=""&&ip!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/Info/Insert.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    ip:ip,
                    ReOrder:ReOrder,
                    i:i,
                    id:ids,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    if(data.num>0){
                        $.messager.alert('温馨提示', '保存成功!!!');
                        $("#fmsave").form('clear');
                        $("#dlgfc").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function Canceldate() {
        $("#fmsave").form('clear');
        $("#dlgfc").dialog("close");
        $("#fmsave1").form('clear');
        $("#dlgxr").dialog("close");
        $("#fmsave2").form('clear');
        $("#dlgzt").dialog("close");
    }

    function deleteinfo () {
        var row = $("#info").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    var id = row.id;
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/Info/Deletedata.action",//要发送的后台地址
                        data:{
                            id:id,
                            i:i,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num !=-1) {
                                $.messager.alert('温馨提示', '删除成功');
                                query();
                            }else {
                                $.messager.alert('温馨提示', '删除失败');
                            }

                        },
                    })
                }
            })
        }


    }
    function SaveXR() {
        var  EquipID = $('#EquipID').val();
        var  WriOrder = $('#WriOrder').val();
        var  OrderName = $('#OrderName').val();
        var  FieType = $('#FieType').val();
        if(EquipID!=""&&WriOrder!=""&&OrderName!=""&&FieType!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/Info/Insert1.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    EquipID:EquipID,
                    WriOrder:WriOrder,
                    OrderName:OrderName,
                    FieType:FieType,
                    i:i,
                    id:ids,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    if(data.num>0){
                        $.messager.alert('温馨提示', '保存成功!!!');
                        $("#fmsave1").form('clear');
                        $("#dlgxr").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }


    }
    function SaveZT () {
        var  StatusID = $('#StatusID').val();
        var  StatusName = $('#StatusName').val();
        var  DepartMent = $('#DepartMent').val();
        if(StatusID!=""&&StatusName!=""&&DepartMent!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/Info/Insert2.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    StatusName:StatusName,
                    StatusID:StatusID,
                    i:i,
                    id:ids,
                    DepartMent:DepartMent,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    if(data.num>0){
                        $.messager.alert('温馨提示', '保存成功!!!');
                        $("#fmsave2").form('clear');
                        $("#dlgzt").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function updateinfo(){
        var row = $("#info").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            ids = row.id;
            if(i=="发出指令"){
                $('#ip').textbox("setValue",row.ip);
                $('#ReOrder').textbox("setValue",row.reOrder);
                $("#dlgfc").dialog("open");

            }
            if(i=="写入指令"){
                var row = $("#info").datagrid("getSelected");
                ids = row.id;
                $('#EquipID').textbox("setValue",row.equipID);
                $('#WriOrder').textbox("setValue",row.wriOrder);
                $('#OrderName').textbox("setValue",row.orderName);
                $('#FieType').textbox("setValue",row.fieType);
                $("#dlgxr").dialog("open");
            }
            if(i=='状态信息'){
                var row = $("#info").datagrid("getSelected");
                ids = row.id;
                $('#StatusID').textbox('textbox').attr('readonly',true);  //设置输入框为禁用
                $('#DepartMent').textbox('textbox').attr('readonly',true);  //设置输入框为禁用
                $('#StatusID').textbox("setValue",row.statusID);
                $('#StatusName').textbox("setValue",row.statusName);
                $('#DepartMent').textbox("setValue",row.departMent);
                $("#dlgzt").dialog("open");
            }
        }

    }


    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#trt_db1').val(year+"-"+month+"-"+day);
        //$('#trt_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#trt_db2').val(year+"-"+month+"-"+day);
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
                $('#bdPlant1').combobox('loadData', data);
                //alert(11111);

            }
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#trt_More").hide();

        });

//        $("#trt_toolbar").blur(function(){
//            $("#trt_More").toggle();
//        })

//树形结构
        //加载全部节点
        $("#tree_base1").tree({
            url: '${ctxPath }/Info/serach',
            animate:true,
            lines:true,
            onClick: function (node) {
                //右侧跳转到指定页面
//                addTab(node.text,node.menuUrl);
//                    alert(node.text);
                i = node.text;
            },
            loadFilter:function(data){
                console.log(data);
                if(data.text){
                    return data.text ;
                }else{
                    return data ;
                }
            }
        });
    });

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
    function addinfo() {
        if(i==""){
            $.messager.alert("温馨提示","选择添加目录!");
        }else {
            Canceldate();
            if(i=="发出指令"){
                $("#dlgfc").dialog("open");
            }
            if(i=="写入指令"){
                $("#dlgxr").dialog("open");
            }
            if(i=="状态信息"){
                $('#StatusID').textbox('textbox').attr('readonly',false);  //设置输入框为禁用
                $('#DepartMent').textbox('textbox').attr('readonly',false);  //设置输入框为禁用
                $("#dlgzt").dialog("open");
            }
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
    $("#tree_base").tree({
        onClick:function(node){
            i = node.text;
            query();
        }
    });
    function query () {
        $.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${ctxPath }/Info/query.action",
            dataType:"json",
            data: {
                name:i,
            },
            success:function(data) {
                fdata = data;
                $('#info').datagrid({
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
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    columns: [[
                        {field:'id',title:'id',width:'50px',editor:'text',halign:"center",align:'left',hidden:'hidden'},
                        {field:'equipID',title:'设备编号',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='写入指令'?false:true,},
                        {field:'wriOrder',title:'写入指令',width:'200px',editor:'text',align:'left',halign:"center",hidden:i=='写入指令'?false:true,},
                        {field:'orderName',title:'指令信息',width:'150px',editor:'text',align:'left',halign:"center",hidden:i=='写入指令'?false:true,},
                        {field:'fieType',title:'标识',width:'50px',editor:'text',align:'left',halign:"center",hidden:i=='写入指令'?false:true,},
                        {field:'ip',title:'ip',width:'120px',editor:'text',align:'right',halign:"center",hidden:i=='发出指令'?false:true,},
                        {field:'reOrder',title:'发出指令',width:'200px',editor:'text',align:'right',halign:"center",hidden:i=='发出指令'?false:true,},
                        {field:'statusName',title:'名称',width:'120px',editor:'text',align:'center',halign:"center",hidden:i=='状态信息'?false:true,},
                        {field:'statusID',title:'代码',width:'70px',editor:'text',align:'center',halign:"center",hidden:i=='状态信息'?false:true,},
                        {field:'departMent',title:'所属',width:'70px',editor:'text',align:'center',halign:"center",hidden:i=='状态信息'?false:true,},
                    ]]
                })
                $('#info').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

            },

        })
        $('#info').datagrid('loadData',{total:0,rows:[]});
    }
</script>



