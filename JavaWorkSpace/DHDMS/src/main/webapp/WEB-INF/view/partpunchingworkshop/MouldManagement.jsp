<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-06
  Time: 14:42  ---模具管理----
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
        width:85%;
        height:75%;
    }

    .C{
        width:20%;
        height:75%;
    }
    .mm3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .mm2{
        letter-spacing:2.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2.1em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 100px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
        <div class="easyui-panel" title="模具管理" data-options="fit:true">
            <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
                <div class="wu-toolbar-button">
                    <div id="test"><input  id ="mmdb2" style="width:110px" class="easyui-text" hidden="hidden"></div>
<shiro:hasPermission name="/MouldManagement/uploadForm">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="monp_uploadForm()" plain="true">导入</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MouldManagement/mmexport1">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="mmexport1()" plain="true">导出</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MouldManagement/saveMould">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="SaveMould()" plain="true">接收模具</a>
</shiro:hasPermission>
<shiro:hasPermission name="/MouldManagement/outMould">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="OutMould()" plain="true">发出模具</a>
</shiro:hasPermission>
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <table>
                        <tr>
                            <td><span class="mm3">事业部：</span></label>
                                <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="mmPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                        style="width:100px">
                                </select></td>
                            <td><label>模具编码：</label><input id="mm-MouldID" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td><label><span class="mm2">吨位</span>：</label><input id="mm-Tonnage" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td><select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="mm-Nwx" panelHeight="auto" data-options="
                                valueField:'StatusName',
                                textField:'StatusName',
                                panelHeight:'250'"
                                        style="width:100px">
                            </select> </td>

                        </tr>
                        <tr>
                            <td><label><span class="mm2">部门</span>：</label>
                                <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="mmdepartment" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                        style="width:100px">
                                </select></td>
                            <td> <label>规格名称：</label><input id="mm-MouldName" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <label><span class="mm2">库位</span>：</label><input id="mm-Location" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="mm_query()" data-options="iconCls:'icon-search'" style="width: 100px">查询</a></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="A" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <div style="width: 100%;height:53%" data-options="region:'center'">
                            <table id="mm" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                        </div>
                    </div>
                </div>
                <div class="C"  data-options="region:'east',split:true">
                    <table class="easyui-datagrid" id="Mmid"   style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>
                </div>
            </div>
        </div>
    </div>
<div id="dlgmmsave" class="easyui-dialog"  title="模具接收" style="width:330px; height: 500px;  padding: 10px;"
     closed="true" buttons="#dlgmmsave-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        模具接收
    </div>
    <form id="fmsave" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" id="table">
                <tr>
                    <td >接收类型：<select class="easyui-combobox" name="Intakekind"  datatype="text"  id="Intakekind"   panelHeight="auto" style="width:146px">
                        <option value="">请选择</option>
                        <option value="外购接收">外购接收</option>
                        <option value="外借接收">外借接收</option>
                    </select>
                    </td>
                </tr>
                <tr id="MouldID2">
                    <td>模具编码：<input name="Infname" id="MouldID1"  class="easyui-validatebox" onblur="saveonblur();"  style="width: 146px;height: 20px"align="left" /></td>
                </tr>
                <tr id="Infname2">
                    <td>模具名称：<input name="Infname" id="Infname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr id="partDrawing2">
                    <td>模具规格：<input name="Infname" id="partDrawing" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr id="Inlocation2">
                    <td>存放库位：<input name="Inworkcentre2" id="Inlocation" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr id="InTonnage2">
                    <td>冲床吨位：<input name="Inlocation"  id="InTonnage" class="easyui-textbox" style="width: 150px;height: 25px"   /></td>
                </tr>
                <tr id="number2">
                    <td><span class="w3">颗/次：</span><input name="Inlocation"  id="number" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr id="temple2">
                    <td><span class="w3">备 注：</span><input name="Inlocation"  id="temple" class="easyui-textbox" style="width: 150px;height: 25px"   /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgmmsave-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="OtherSave()" iconcls="icon-save">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlgmmsave').dialog('close')" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgmmout" class="easyui-dialog"  title="模具发出" style="width:330px; height: 420px;  padding: 10px;"
     closed="true" buttons="#dlgmmout-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        模具发出
    </div>
    <form id="fmout" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td>发出类型：<select class="easyui-combobox" name="takekind" datatype="text"  id="outtakekind" panelHeight="auto" style="width:150px">
                        <option value="外借">外借</option>
                        <option value="报废">报废</option>
                    </select>
                    </td>
                </tr>

                <tr id="LDepartment1">
                    <td>外借部门：<input name="Infname" id="LDepartment" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"  /></td>
                </tr>
                <tr>
                    <td>模具编码：<input name="Inworkcentre2" id="MouldID" onblur="outonblur();"  style="width: 150px;height: 20px" align="left"  /></td>
                </tr>
                <tr id="MouldName1">
                    <td>模具名称：<input name="Inlocation"  id="MouldName" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr id="Outtemple1">
                    <td><span class="w3">备 注：</span><input name="Remark"  id="Outtemple" class="easyui-textbox" style="width: 150px;height: 25px"   /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgmmout-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="OtherOut()" iconcls="icon-save">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlgmmout').dialog('close')" iconcls="icon-cancel">取消</a>
</div>

<script type="text/javascript">
    $("#test" ).css("display", "none");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#mmdb2').val(year+"-"+month+"-"+day);
        $('#mmdb1').val(year+"-"+month+"-"+day);
        $('#mmdb').val(year+"-"+month+"-"+day);
        var db = $('#mmdb2');
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
                $('#mmPlant').combobox('loadData', data);
                //alert(11111);

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
                $('#mmdepartment').combobox('loadData', data);
            }
        });

        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MouldManage/Query1.action',
            dataType: "json",
            data: {

            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息
            },
            success: function (data) {
                $('#mm-Nwx').combobox('loadData', data);
            }
        });

    });
    function mm_query() {
        var uyear = $('#mmdb2').val().substr(0,4)
        var umouth  = $('#mmdb2').val().substr(5);
        var plant = $('#mmPlant').combobox('getText');
        var department = $('#mmdepartment').combobox('getText');
        var MouldID = $('#mm-MouldID').val();
        var Tonnage = $('#mm-Tonnage').val();
        var MouldName = $('#mm-MouldName').val();
        var Location = $('#mm-Location').val();
        var nwx = $('#mm-Nwx').combobox('getText');
        var fdata;

        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MouldManage/Search.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umonth:umouth,
                plant:plant,
                MouldID:MouldID,
                Tonnage:Tonnage,
                MouldName:MouldName,
                Location:Location,
                nwx:nwx,
                department:department,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#mm").datagrid({
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
                        {field:'mouldID',title:'模具编码',width: '90px',align:'left',halign:'center'},
                        {field:'mouldName',title:'模具名称',width: '100px',align:'left',halign:'center'},
                        {field:'tonnage',title:'吨位',width: '60px',align:'center',halign:'center'},
                        {field:'location',title:'库位',width: '60px',align:'center',halign: 'center'},
                        {field:'nunber',title:'颗/次',width:'60px',align:'center',halign: 'center'},
                        {field:'inputMan',title:'接收人',width: '60px',align:'center',halign: 'center'},
                        {field:'inputDate',title:'接收时间',width: '160px',align:'right',halign: 'center'},
                        {field:'statusName',title:'状态',width: '55px',align:'center',halign: 'center'},
                        {field:'equipID',title:'设备使用编号',width: '90px',align:'left',halign: 'center'},
                        {field:'lDepartment',title:'外借部门',width: '55px',align:'left',halign: 'center'},
                        {field:'moldRpBegTime',title:'使用时间',width: '200px',align:'right',halign: 'center'},
                        {field:'loanTime',title:'外借时间',width: '110px',align:'right',halign: 'center'},
                        {field:'departMent',title:'部门',width: '70px',align:'center',halign: 'center'},
                        {field:'plant',title:'事业部',width: '70px',align:'center',halign: 'center'},

                    ]],
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
//        $.ajax({
//            type: "post",//数据发送的方式（post 或者 get）
//            url: "/MouldManage/Query1.action",//要发送的后台地址
//            data: {
////                uyear:uyear,
////                umonth:umouth,
////                plant:plant,
////                fname:fname,
////                f1:f1,
////                f5:f5,
////                name:name,
////                workcentre2:Workcentre2,
////                fno:fno,
////                ser:ser,
////                nwx:nwx,
//            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//                $.messager.progress('close');
//                console.log(data);
//                fdata = data;
//                $("#Mmid").datagrid({
//                    idField:'id',
//                    loadFilter:pagerFilter,
//                    rownumbers:true,
//                    singleSelect:true,
//                    pageList:[25,50,100],//分页列表
//                    pagination:true,
//                    multiSort:true,
//                    remoteSort:false,
//                    fit: false, //自动适屏功能
//                    nowrap:false,
//                    width:'auto',
//                    //fitColumns:true,
//                    //fit:true,
//                    method:'get',
//                    data:fdata,
//                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
//                    columns:[[
//                        {field:'xh',title:'序号',width: '55px',align:'left',halign: 'center',hidden:'true'},
//                        {field:'mjbm',title:'模具编码',width: '90px',align:'center',halign:'center'},
//                        {field:'sysm',title:'使用说明',width: '110px',align:'left',halign:'center'},
//                        {field:'dzr',title:'动作人',width: '70px',align:'right',halign:'center'},
//                        {field:'dzsj',title:'动作时间',width: '110px',align:'left',halign: 'center'},
//                    ]],
//                    pagination:true,
//                    sortOrder:'asc',
//                    sortName:'SapStore',
//                });
////                $('#HalfPartOut-Data').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
////                $('#HalfPartOut-Data').datagrid({
////                    rowStyler: function (index, row) {
////                        var CLNumber =parseFloat(row.CLNumber);
////                        var ConnectPlan =parseFloat(row.ConnectPlan);
////                        //alert(11);
////                        if (CLNumber !== ConnectPlan) {
////                            return 'color:black;';
////                        }
////                        else {
//////                            return 'color:Green;font-weight:bold;';
////                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
////                        }
////
////                    }
////                });
//
//
//            },
//            error: function (msg) {//ajax请求失败后触发的方法
//                alert(msg);//弹出错误信息
//            }
//
//        });
        $('#mm').datagrid('loadData',{total:0,rows:[]});
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

    function SaveMould() {
        $("#dlgmmsave").dialog("open");
        $('#Infname2').hide();
        $('#MouldID2').hide();
        $('#partDrawing2').hide();
        $('#Inlocation2').hide();
        $('#InTonnage2').hide();
        $('#number2').hide();
        $('#temple2').hide();
    }
    function OutMould() {
        $("#dlgmmout").dialog("open");
    }

    $('#Intakekind').combobox({
        onChange:function(newValue,oldValue){
            if(newValue=='外购接收'){
                $('#MouldID2').hide();
                $('#Infname2').show();
                $('#partDrawing2').show();
                $('#Inlocation2').show();
                $('#InTonnage2').show();
                $('#number2').show();
                $('#temple2').show();
            }else if(newValue=='外借接收') {
                $('#Infname2').show();
                $('#MouldID2').show();
                $('#partDrawing2').show();
                $('#Inlocation2').show();
                $('#InTonnage2').show();
                $('#number2').show();
                $('#temple2').show();
            }else {
                $('#Infname2').hide();
                $('#MouldID2').hide();
                $('#partDrawing2').hide();
                $('#Inlocation2').hide();
                $('#InTonnage2').hide();
                $('#number2').hide();
                $('#temple2').hide();
            }
        }
    });
    $('#outtakekind').combobox({
        onChange: function (newValue, oldValue) {
            if (newValue == '报废') {
                $('#MouldName1').hide();
                $('#LDepartment1').hide();
            }else {
                $('#MouldName1').show();
                $('#LDepartment1').show();
            }
        }
    })
    ;
    function saveonblur () {
        var  MouldID1 = $('#MouldID1').val();
        if(MouldID1 ==''){
            return false;
        }else {
            $.ajax({
                        type:"post",
                        url: "${ctxPath}/MouldManage/look1.action",//要发送的后台地址
                        data:{
                            MouldID:MouldID1,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num != -1) {
                                $('#Infname').textbox("setValue", data1.mouldName);
                                $('#partDrawing').textbox("setValue", data1.partDrawing);
                                $('#Inlocation').textbox("setValue", data1.location);
                                $('#InTonnage').textbox("setValue",data1.tonnage);
                                $('#number').textbox("setValue",data1.nunber);
                                $('#temple').textbox("setValue",data1.remark);
                            }else {
                                $.messager.alert('温馨提示', '此模具编号不存在');
                                $('#fmsave').form('clear');
                            }
                        }
                    })
            }


    }
    function outonblur () {
        var  MouldID = $('#MouldID').val();
        if(MouldID==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/look1.action",//要发送的后台地址
                data:{
                    MouldID:MouldID,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num != -1) {
                        $('#MouldName').textbox("setValue", data1.mouldName);
                    }else {
                        $.messager.alert('温馨提示', '此模具编号不存在');
                        $('#fmout').form('clear');
                    }
                }
            })
        }

    }
    function OtherSave () {
        var myDate = new Date();
        var uyear = myDate.getFullYear();//当前年
        var umonth = myDate.getMonth()+1;//当前月
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var  takekind = $('#Intakekind').combobox('getText');
        var  Infname = $('#Infname').val();
        var  Inlocation = $('#Inlocation').val();
        var  InTonnage = $('#InTonnage').val();
        var number = $('#number').val();
        var temple = $('#temple').val();
        var plant =  $('#mmPlant').combobox('getText');
        var department = $('#mmdepartment').combobox('getText');
        var name = localStorage.getItem("User");
        var partDrawing = $('#partDrawing').val();

            if(takekind=='外购接收'){
                if(number!=""&&Infname!=""&&Inlocation!=""&&InTonnage!=""&&partDrawing!="") {
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/MouldManage/look.action",//要发送的后台地址
                        data:{
                            partDrawing:partDrawing,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1.num);
                            if (data1.num > 0) {
                                $.ajax(
                                    {
                                        type:"post",
                                        url: "${ctxPath}/MouldManage/InsertMoldStore.action",//要发送的后台地址
                                        data:{
                                            year:uyear,
                                            month:umonth,
                                            plant:plant,
                                            name:name,
                                            takekind:takekind,
                                            time:time,
                                            Infname:Infname,
                                            Inlocation:Inlocation,
                                            InTonnage:InTonnage,
                                            number:number,
                                            temple:temple,
                                            partDrawing:partDrawing,
                                            department:department
                                        },
                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (data1) {//ajax请求成功后触发的方法
                                            console.log(data1.num);
                                            if (data1.num > 0) {
                                                $.messager.alert('温馨提示', '接收成功');
                                                $('#fmsave').form('clear');
                                                $('#dlgmmsave').dialog("close");
                                                mm_query();
                                            }

                                        },

                                    }
                                )
                            }else {
                                $.messager.alert('温馨提示', '此模具规格不存在');
                                $('#fmsave').form('clear');
                            }

                        },
                    })
                }else {
                    $.messager.alert("温馨提示","数据不能为空!");
                }
            }else {
                var  MouldID1 = $('#MouldID1').val();
                if(number!=""&&Infname!=""&&Inlocation!=""&&InTonnage!=""&&partDrawing!=""&&MouldID1!="") {
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/MouldManage/update.action",//要发送的后台地址
                        data:{
                            MouldID:MouldID1,
                            time:time,
                            name:name,
                            takekind:takekind,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num >0) {
                                $.messager.alert('温馨提示', '此模具接收成功');
                                mm_query();
                                $('#fmsave').form('clear');
                                $('#dlgmmsave').dialog("close");
                            }else {
                                $.messager.alert('温馨提示', '此模具接收失败');
                                $('#fmsave').form('clear');
                            }
                        }
                    })
                }else {
                    $.messager.alert("温馨提示","数据不能为空!");
                }

            }

    }
    function OtherOut() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();//当前年
        var umonth = myDate.getMonth()+1;//当前月
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var  outtakekind = $('#outtakekind').combobox('getText');
        var LDepartment = $('#LDepartment').val();
        var  MouldID = $('#MouldID').val();
        var Outtemple = $('#Outtemple1').val();
        var name = localStorage.getItem("User");

            if(outtakekind=='外借'){
                if(outtakekind!=""&&LDepartment!=""&&MouldID!=""){
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/MouldManage/out.action",//要发送的后台地址
                        data:{
                            MouldID:MouldID,
                            time:time,
                            name:name,
                            LDepartment:LDepartment,
                            Outtemple:Outtemple,
                            outtakekind:outtakekind,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num >0) {
                                $.messager.alert('温馨提示', '此模具发出成功');
                                mm_query();
                                $('#fmout').form('clear');
                                $('#dlgmmout').dialog("close");
                            }else {
                                $.messager.alert('温馨提示', '此模具发出失败');
                                $('#fmout').form('clear');
                            }
                        }
                    })
                }else {
                    $.messager.alert("温馨提示","数据不能为空!");
                }

            }else {
                if(MouldID!=""){
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/MouldManage/Deleteid.action",//要发送的后台地址
                        data:{
                            MouldID:MouldID,
                            Outtemple:Outtemple,
                            time:time,
                            name:name,
                            outtakekind:outtakekind,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num >0) {
                                $.messager.alert('温馨提示', '此模具报废成功');
                                mm_query();
                                $('#fmout').form('clear');
                                $('#dlgmmout').dialog("close");
                            }else {
                                $.messager.alert('温馨提示', '此模具报废成功');
                                $('#fmout').form('clear');
                            }
                        }
                    })
                }else {
                    $.messager.alert("温馨提示","数据不能为空!");
                }


            }


    }
    function mmexport1(){
        var plant = $('#mmPlant').combobox('getText');
        var department = $('#mmdepartment').combobox('getText');
        var MouldID = $('#mm-MouldID').val();
        var Tonnage = $('#mm-Tonnage').val();
        var MouldName = $('#mm-MouldName').val();
        var Location = $('#mm-Location').val();
        var nwx = $('#mm-Nwx').combobox('getText');
        var url = "../${ctxPath}/MouldManage/Export?plant="+plant+"&department="+department+"&MouldID="+MouldID+"" +
            "&Tonnage="+Tonnage+"&MouldName="+MouldName+"&Location="+Location+"&nwx=+"+nwx+"";
        window.location.href = url;
    }
</script>


