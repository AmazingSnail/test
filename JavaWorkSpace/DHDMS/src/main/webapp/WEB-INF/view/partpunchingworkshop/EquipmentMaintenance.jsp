<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-09
  Time: 8:09----设备维修管理----
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
        width:79%;
        height:75%;
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
    .r{position:fixed; bottom:0;}
    #report{display:none}
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="设备维修管理" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="monp_uploadForm()" plain="true">导入</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="monp_export1()" plain="true">导出</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="SaveMould()" plain="true">接收模具</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="OutMould()" plain="true">发出模具</a>--%>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <div id="test2"><input  id ="emdb2" style="width:110px" class="easyui-text" hidden="hidden"></div>
                        <td><label><span class="w3">事业部</span>：</label>
                            <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="emPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:100px">
                            </select></td>
                        <td><label>起始时间：</label><input  id ="emdb1" style="width:110px" class="easyui-datebox"></td>
                        <td><label>维修人员：</label>
                            <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="Username" panelHeight="auto" data-options="
                                valueField:'Username',
                                textField:'Username',
                                panelHeight:'250'"
                                                         style="width:100px">
                        </select></td>
                        <td><label>检修状态：</label> <select class="easyui-combobox" name="Pkgin-FnameStr" datatype="text" id="emSerStatus" panelHeight="auto" style="width:100px">
                            <option value="">   </option>
                            <option value="WX01">呼叫中</option>
                            <option value="WX02">检修中</option>
                            <option value="WX03">检修完成</option>
                            <option value="WX04">已完成</option>
                        </select> </td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="emquery()" data-options="iconCls:'icon-search'">查询</a></td>
                    </tr>
                    <tr>
                        <td><label><span class="w2">部门</span>：</label>
                            <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="emdepartment" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                    style="width:100px">
                            </select></td>
                        <td><label>结束时间：</label><input  id ="emdb" style="width:110px" class="easyui-datebox"></td>
                        <td> <label>故障类型：</label> <select class="easyui-combobox" name="Pkgin-FnameStr" datatype="text" id="emFaultTypes" panelHeight="auto" style="width:100px">
                            <option value="">   </option>
                            <option value="GZ01">电气故障</option>
                            <option value="GZ02">机械故障</option>
                            <option value="GZ03">模具故障</option>
                        </select></td>
                        <td> <label>设备编号： </label><input id="emEquipID" class="easyui-textbox" style="width:100px"></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'">
                        <table id="em" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  title="故障明细（检修状态：绿色:已完成，浅绿色：检修完成,
                           灰色：检修中，红色：应答中)" data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
            <div class="C" title="故障分析报告" id="report" data-options="region:'east',split:true" hidden="hidden" >
                <div style="height: 20px"></div>
                <label style="font-size: 15px;margin-left: 10px">故障描述及原因分析：</label>
                <div style="height: 20px"></div>
                    <textarea style="border:solid 10px #f4f5f7;width:80%;height:20%;resize:none ;margin-left: 20px" id="Fault"></textarea>
                <div style="height: 20px"></div>
                <label style="font-size: 15px;margin-left: 10px">处理结果：</label>
                <div style="height: 20px"></div>
                <textarea style="border:solid 10px #f4f5f7;width:80%;height:20%;resize:none;margin-left: 20px" id="Results"></textarea>
                <div style="height: 20px"></div>
                <div style="width:80%">
                <a href="#" class="easyui-linkbutton"  onclick="SaveRe()" iconCls="icon-note-add" style="width: 80px;font-size: 20px;height: 30px ;text-align: center;float:left;margin-left: 70px">提交</a>
               <a href="#" class="easyui-linkbutton"  onclick="SaveRe()" iconCls="icon-note-edit" style="width: 80px;font-size: 20px;height: 30px ;text-align: center;float:right;margin-right: 25px">修改</a>
                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    function SaveRe () {
        var row = $('#em').datagrid('getSelected');
        var s = row.statusName1;
        var faultid = row.faultID;
        var EquipID = row.equipID;
        var plant = $('#emPlant').combobox('getText');
        var department = $('#emdepartment').combobox('getText');
        var username = localStorage.getItem("User");
        var Fault=$("#Fault").val();
        var Results=$("#Results").val();
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        $.ajax({
            type:'post',
            url: "${ctxPath }/EquipmentMaintenance/Insert.action",//要发送的后台地址
            data:{
                faultid:faultid,
                time:time,
                username:username,
                Results:Results,
                Fault:Fault,
                EquipID:EquipID,
            },
            dataType: "json",
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息
            },
            success: function (data) {
                console.log(data);
                $.messager.alert('温馨提示', '提交成功!')
//                var Fault = data[0].Fault;
//                var Results = data[0].Results;
//                $("#Fault").val(Fault);
//                $("#Results").val(Results);
                emquery1();
            }
        })
    }


    $("#test2" ).css("display", "none");


    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#emdb1').val(year+"-"+month+"-"+day);
        $('#emdb').val(year+"-"+month+"-"+day);
        $('#emdb2').val(year+"-"+month+"-"+day);
        var db = $('#emdb2');
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
                $('#emPlant').combobox('loadData', data);
                $("#report" ).hide();

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MouldManage/Query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息
            },
            success: function (data) {
                $('#emdepartment').combobox('loadData', data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/EquipmentMaintenance/Search.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息
            },
            success: function (data) {
                $('#Username').combobox('loadData', data);
            }
        });
//


    });
    function emquery() {
        $('#report').hide();
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var plant = $('#emPlant').combobox('getText');
        var department = $('#emdepartment').combobox('getText');
        var Username = $('#Username').combobox('getText');
        var emSerStatus = $('#emSerStatus').combobox('getValue');
        var emFaultTypes = $('#emFaultTypes').combobox('getValue');
        var EquipID = $('#emEquipID').val();
        var starttime = $('#emdb1').datebox('getValue');
        var endtime = $('#emdb').datebox('getValue');
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/EquipmentMaintenance/Serach.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umouth:umouth,
                plant:plant,
                department:department,
                Username:Username,
                emSerStatus:emSerStatus,
                emFaultTypes:emFaultTypes,
                EquipID:EquipID,
                starttime:starttime,
                endtime:endtime,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#em").datagrid({
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
                        //{field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'xh',title:'序号',width: '90px',align:'center',halign:'center',hidden:'true'},
                        {field:'faultID',title:'故障编号',width: '80px',align:'left',halign:'center'},
                        {field:'equipID',title:'设备编号',width: '70px',align:'center',halign:'center'},
                        {field:'statusName',title:'故障类型',width: '70px',align:'center',halign: 'center'},
                        {field:'callMan',title:'呼叫人',width:'70px',align:'center',halign: 'center'},
                        {field:'callTime',title:'呼叫时间',width: '150px',align:'right',halign: 'center'},
                        {field:'serviceMan',title:'维修人',width: '70px',align:'center',halign: 'center'},
                        {field:'serviceTime',title:'完成时间',width: '150px',align:'right',halign: 'center'},
                        {field:'accumTime',title:'持续时间',width: '150',align:'right',halign: 'center'},
                        {field:'statusName1',title:'检修状态',width: '70px',align:'center',halign: 'center'},
                        {field:'repSendTime',title:'报告完成时间',width: '150px',align:'right',halign: 'center'},
                    ]],
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#em').datagrid({
            rowStyler: function (index, row) {
                var over = row.statusName1;
                if(over=='检修中'){
                    return 'color:red';
                }else if(over=='检修完成'){
                        return 'background-color:green';
                    }else if (over=='已完成'){
                        return 'background-color:#98FB98';
                    }
                }
        });
        $('#em').datagrid('loadData',{total:0,rows:[]});
    }
    function emquery1() {
        $('#report').hide();
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var plant = $('#emPlant').combobox('getText');
        var department = $('#emdepartment').combobox('getText');
        var Username = $('#Username').combobox('getText');
        var emSerStatus = "WX04";
        var emFaultTypes = $('#emFaultTypes').combobox('getValue');
        var EquipID = $('#emEquipID').val();
        var starttime = $('#emdb1').datebox('getValue');
        var endtime = $('#emdb').datebox('getValue');
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/EquipmentMaintenance/Serach.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umouth:umouth,
                plant:plant,
                department:department,
                Username:Username,
                emSerStatus:emSerStatus,
                emFaultTypes:emFaultTypes,
                EquipID:EquipID,
                starttime:starttime,
                endtime:endtime,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#em").datagrid({
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
                        //{field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'xh',title:'序号',width: '90px',align:'center',halign:'center',hidden:'true'},
                        {field:'faultID',title:'故障编号',width: '100px',align:'left',halign:'center'},
                        {field:'equipID',title:'设备编号',width: '70px',align:'center',halign:'center'},
                        {field:'statusName',title:'故障类型',width: '70px',align:'center',halign: 'center'},
                        {field:'callMan',title:'呼叫人',width:'70px',align:'center',halign: 'center'},
                        {field:'callTime',title:'呼叫时间',width: '150px',align:'left',halign: 'center'},
                        {field:'serviceMan',title:'维修人',width: '70px',align:'center',halign: 'center'},
                        {field:'serviceTime',title:'完成时间',width: '150px',align:'left',halign: 'center'},
                        {field:'accumTime',title:'持续时间',width: '100',align:'left',halign: 'center'},
                        {field:'statusName1',title:'检修状态',width: '70px',align:'center',halign: 'center'},
                        {field:'repSendTime',title:'报告完成时间',width: '150px',align:'left',halign: 'center'},
                    ]],
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#em').datagrid('loadData',{total:0,rows:[]});
    }
    $('#em').datagrid({
        onClickRow:function(rowIndex,rowData){
            var row = $('#em').datagrid('getSelected');
            var s = row.statusName1;
            var faultid = row.faultID;
            var EquipID = row.equipID;
            var plant = $('#emPlant').combobox('getText');
            var department = $('#emdepartment').combobox('getText');
            var username = localStorage.getItem("User");
            var Fault=$("#Fault").val();
            var Results=$("#Results").val();
            var myDate = new Date();
            var uyear = myDate.getFullYear();
            var umonth = myDate.getMonth()+1;
            var uday = myDate.getDate();
            var uhour = myDate.getHours();
            var umin = myDate.getMinutes();
            var ums = myDate.getSeconds();
            var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
            if(s=='检修完成'){
                $("#Fault").val("");
                $("#Results").val("");
                $('#report').show();
            }else if(s=='已完成') {
                $('#report').show();
                $.ajax({
                    type:'post',
                    url: "${ctxPath }/EquipmentMaintenance/Serach1.action",//要发送的后台地址
                    data:{
                        faultid:faultid,
                        plant:plant,
                        department:department,
                    },
                    dataType: "json",
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息
                    },
                    success: function (data) {
                        console.log(data);
                        var Fault = data[0].Fault;
                        var Results = data[0].Results;
                        $("#Fault").val(Fault);
                        $("#Results").val(Results);
                    }
                })
            }else {
                $('#report').hide();
            }

        }
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

</script>
