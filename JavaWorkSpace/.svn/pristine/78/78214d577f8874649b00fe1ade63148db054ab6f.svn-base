<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/6
  Time: 13:22 报错信息
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
    .cz{
        width:100%;
        height:100%;
    }
    .pp2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .pp1{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .w1{
        letter-spacing:0.1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.1em; /*同上*/
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
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
        <div class="easyui-panel " title="报错信息" data-options="fit:true">
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 60px;">
                <div class="wu-toolbar-button" >
                </div>
                <div class="wu-toolbar-search" >
                    <div style="white-space:nowrap">
                        <table>
                            <tr>
                                <td> <label><span class="x3">事业部：</span></label>
                                    <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="fiPlant" panelHeight="auto" data-options="
                                valueField:'plant',
                                textField:'plant',
                                panelHeight:'250'"
                                            style="width:90px">
                                    </select></td>
                                <td>开始时间：<input  id ="fi2" style="width:100px" class="easyui-datebox">&nbsp</td>
                                <td>结束时间：<input  id ="fi3" style="width:100px" class="easyui-datebox">&nbsp</td>
                                <td> <label><span class="x3">设备编号：</span></label>
                                    <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="fiequipid" panelHeight="auto" data-options="
                                valueField:'equid',
                                textField:'equid',
                                panelHeight:'250'"
                                            style="width:90px">
                                    </select></td>
                                <td> <label><span class="x3">故障类型：</span></label>
                                    <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="fitype" panelHeight="auto" data-options="
                                valueField:'type',
                                textField:'type',
                                panelHeight:'250'"
                                            style="width:90px">
                                    </select></td>
                                <td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="fiquery()"  >查询</a></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div id="trt_dd" class="easyui-layout cz"  data-options="fit:true">
                    <div style="width: 100%;height:100%" data-options="region:'center'">
                        <table id="fi" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="报错信息" data-options=""></table>
                    </div>
                </div>
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
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#fi2').val(year+"-"+month+"-"+day);
        //$('#trt_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#fi3').val(year+"-"+month+"-"+day);
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/DeviceManagement/Search.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#fiPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/ProductionDetail/getequid.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#fiequipid').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/ProductionDetail/Type.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#fitype').combobox('loadData', data);
                //alert(11111);

            }
        });
    });
    function fiquery() {
        var plant = $('#fiPlant').combobox('getText');
        var equipid = $('#fiequipid').combobox('getText');
        var type = $('#fitype').combobox('getText');
        var starttime =  $('#fi2').datebox('getValue');
        var endtime =  $('#fi3').datebox('getValue');
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/FalseInformation/query.action",//要发送的后台地址
            data: {
                plant:plant,
                equipid:equipid,
                type:type,
                starttime:starttime,
                endtime:endtime,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#fi").datagrid({
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
                        {field:'faultid',title:'故障编号',width: '100px',align:'center',halign:'center'},
                        {field:'equipid',title:'设备编号',width: '80px',align:'center',halign:'center'},
                        {field:'faulttypes',title:'故障类型',width: '80px',align:'center',halign: 'center'},
                        {field:'faultorient',title:'故障位置',width:'70px',align:'center',halign: 'center'},
                        {field:'faultmessage',title:'故障信息',width: '80px',align:'center',halign: 'center'},
                        {field:'standard',title:'参考标准',width: '100px',align:'center',halign: 'center'},
                        {field:'begintime',title:'故障发生时间',width: '150px',align:'right',halign: 'center'},
                        {field:'endtime',title:'故障结束时间',width: '150px',align:'right',halign: 'center'},
                    ]],
                });


            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#ppid').datagrid('loadData',{total:0,rows:[]});
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
</script>
