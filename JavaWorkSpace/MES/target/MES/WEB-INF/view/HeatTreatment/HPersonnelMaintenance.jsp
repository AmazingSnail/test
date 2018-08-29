<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/6
  Time: 15:53 人员管理
  To change this template use File | Settings | File Templates.
--%><%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .L{
        width:15%;
        height:75%;
    }

    .P{
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
    .pm1{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.4em; /*同上*/
    }
    .pm3{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-1em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 40px);
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
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 40px;">
                <div class="wu-toolbar-button" >
                </div>
                <div class="wu-toolbar-search" >
                    <label><span class="m3">事业部：</span></label>
                    <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="hpmPlant" panelHeight="auto" data-options="
                               valueField:'Fname',
                                textField:'Fremark',
                                panelHeight:'250'"
                            style="width:100px">
                    </select>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="paddperson()" plain="true" style="width: 100px;text-align: center">添加</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="hdeleteperson()" plain="true" style="width: 100px;text-align: center">删除</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="hupdateperson()" plain="true" style="width: 100px;text-align: center">修改</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-pictures" onclick="haddimg()" plain="true" style="width: 100px;text-align: center">添加图片</a>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="L" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <ul id="htreepm" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="P"  data-options="region:'east',split:true">
                    <table id="hpm" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="hdlgpm" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 400px;  padding: 10px;"
     closed="true" buttons="#hdlgpm-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        检验人员添加/修改
    </div>
    <form id="hfmsave" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td>工号：<input name="Infname" id="huserid2" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>姓名：<input name="Infname" id="hOutfname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>班组：<select class="easyui-combobox" name="takekind" datatype="text"  id="htakekind" panelHeight="auto" style="width:150px">
                        <option value="早班" selected="selected">早班</option>
                        <option value="中班">中班</option>
                        <option value="晚班">晚班</option>
                    </select></td>
                </tr>
                <tr>
                    <td>班长：<input name="Inlocation"  id="hOutmonitor" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>工序：<select class="easyui-combobox" name="htakekind" datatype="text" id="outhtakekind"  panelHeight="auto" style="width:150px">
                        <option value="热处理"selected="selected">热处理</option>
                    </select></td>
                </tr>
                <tr>
                    <td>部门：<select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="hdepartment" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                   style="width:100px">
                    </select></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="hdlgpm-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="HSaveSer()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="HCanceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="hdlgcj" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 540px;  padding: 10px;"
     closed="true" buttons="#hdlgcj-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        生产人员添加/修改
    </div>
    <form id="hfmsave1" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td><span class="pm1">工号：</span><input name="Infname" id="huserid" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>任务人：<input name="Infname" id="hWorkMan" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td><span class="pm1">姓名：</span><input name="Infname" id="hputfname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td><span class="pm1">班组：</span><select class="easyui-combobox" name="htakekind" datatype="text" id="hbanzu" panelHeight="auto"  style="width:150px">
                        <option value="早班"selected="selected">早班</option>
                        <option value="中班">中班</option>
                        <option value="晚班">晚班</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">在岗：</span><select class="easyui-combobox" name="htakekind" datatype="text" id="hisSet" panelHeight="auto"  style="width:150px">
                        <option value="是"selected="selected">是</option>
                        <option value="否">否</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">班长：</span><input name="Inlocation"  id="hputmonitor" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="pm1">工序：</span><select class="easyui-combobox" name="htakekind" datatype="text" id="pututhtakekind"  panelHeight="auto" style="width:150px">
                        <option value="热处理"selected="selected">热处理</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">部门：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="hput" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                                            style="width:100px">
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">设备：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="hEquipID" panelHeight="auto" data-options="
                                valueField:'EquipID',
                                textField:'EquipID',
                                panelHeight:'250'"
                                                            style="width:100px">
                    </select>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
<div id="hdlgcj-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="HSaveProcess()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="HCanceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="hdlghot" class="easyui-dialog"  title="添加/修改" style="width:320px; height: 410px;  padding: 10px;"
     closed="true" buttons="#hdlghot-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        维修人员添加/修改
    </div>
    <form id="hfmsave2" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td><span class="pm3">工号：</span><input name="Infname" id="huserid1" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"   /></td>
                </tr>
                <tr>
                    <td>微信账号：<input name="Infname" id="hWeChatID" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"   /></td>
                </tr>
                <tr>
                    <td><span class="pm3">姓名：</span><input name="Infname" id="hname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"  /></td>
                </tr>
                <tr>
                    <td><span class="pm3">工种：</span><select class="easyui-combobox" name="htakekind" datatype="text" id="puthtakekind"  panelHeight="auto" style="width:150px">
                        <option value="机修" selected="selected">机修</option>
                        <option value="电工">电工</option>
                        <option value="钳工">钳工</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm3">班长：</span><input name="Inlocation"  id="hlocation" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="pm3">部门：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="hDepartMent1" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                                            style="width:100px">
                    </select></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="hdlghot-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="HSaveDevice()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="HCanceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="hdlgimg" class="easyui-dialog"  title="添加/修改" style="width:700px; height: 100px;  padding: 10px;"
     closed="true">
    <div class="ftitle" align="center" style="font-size: 15px">
        添加图片
    </div>
    <form id="test" action="DeviceManagement/upload" method="post" enctype="multipart/form-data" onsubmit="return sub();">
        序号：<input name="ID"  id="hID" class="easyui-textbox" style="width: 40px;height: 25px"    />
        人员姓名：<input name="imgname"  id="himgname" class="easyui-textbox" style="width: 80px;height: 25px"    />
        <input type="file" name="file" width="100px">
        <input type="submit" style="width: 100px;height: 25px" value="上传">

    </form>
    </form>
</div>
<script type="text/javascript">
    var i='' ;
    var ids = '';
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;

    var name = localStorage.getItem("User");
    function sub() {
        // jquery 表单提交
        $("#test").ajaxSubmit(function(message) {
            // 对于表单提交成功后处理，message为返回内容
            $.messager.alert("温馨提示","上传成功!");
            $("#fmimg").form('clear');
            $("#hdlgimg").dialog("close");
            Query();
        });

        return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
    }
    function HSaveDevice () {//维修人员
        var department = $('#hDepartMent1').combobox('getText');//部门
        var UserName = $('#hname').val();//姓名
        var WeChatID = $('#hWeChatID').val();//姓名
        var monitor = $('#hlocation').val();//班长
        var userid = $('#huserid1').val();//工号
        var htakekind1 = $('#puthtakekind').combobox('getText');//工序
        var plant = $('#hpmPlant').combobox('getText');
        if(department!=""&&UserName!=""&&monitor!=""&&userid!=""&&htakekind1!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/PersonnelMaintenance/Insert.action',
                dataType: "json",
                data: {
                    UserName:UserName,
                    name:name,
                    time:time,
                    monitor:monitor,
                    put:department,
                    team:'',
                    WeChatID:WeChatID,
                    takekind1:htakekind1,
                    plant,plant,
                    i:i,
                    EquipID:'',
                    id:ids,
                    userid:userid,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $.messager.alert('温馨提示', '保存成功!!!');
                    $("#hfmsave2").form('clear');
                    $("#hdlghot").dialog("close");
                    ids = '';
                    Query();

                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function HCanceldate() {
        $("#hfmsave").form('clear');
        $("#hdlgpm").dialog("close");
        $("#hfmsave1").form('clear');
        $("#hdlgcj").dialog("close");
        $("#hfmsave2").form('clear');
        $("#hdlghot").dialog("close");
        getDepartment();
    }
    function HSaveSer () {//检验人员
        var department = $('#hdepartment').combobox('getText');//部门
        var UserName = $('#hOutfname').val();//姓名
        var monitor = $('#hOutmonitor').val();//班长
        var userid = $('#huserid2').val();//工号
        var takekind = $('#outhtakekind').combobox('getText');//工序
        var plant = $('#hpmPlant').combobox('getText');
        var team = $('#htakekind').combobox('getText');//班组
        if(department!=""&&UserName!=""&&monitor!=""&&userid!=""&&takekind!=""&&team!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/PersonnelMaintenance/Insert.action',
                dataType: "json",
                data: {
                    UserName:UserName,
                    name:name,
                    time:time,
                    monitor:monitor,
                    put:department,
                    team:team,
                    takekind:takekind,
                    plant,plant,
                    i:i,
                    EquipID:'',
                    id:ids,
                    userid:userid,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $.messager.alert('温馨提示', '保存成功!!!');
                    $("#hfmsave").form('clear');
                    $("#hdlgpm").dialog("close");
                    ids = '';
                    Query();

                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function HSaveProcess () {//生产人员添加
        var UserName = $('#hputfname').val();//姓名
        var monitor = $('#hputmonitor').val();//班长
        var userid = $('#huserid').val();//工号
        var WorkMan = $('#hWorkMan').val();//任务人
        var put = $('#hput').combobox('getText');//部门
        var team = $('#hbanzu').combobox('getText');//班组
        var htakekind = $('#pututhtakekind').combobox('getText');
        var EquipID = $('#hEquipID').combobox('getText');
        var isSet = $('#hisSet').combobox('getText');
        var plant = $('#hpmPlant').combobox('getText');
        if(UserName!=""&&monitor!=""&&userid!=""&&put!=""&&team!=""&&htakekind!=""&&EquipID!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/PersonnelMaintenance/Insert.action',
                dataType: "json",
                data: {
                    UserName:UserName,
                    name:name,
                    userid:userid,
                    time:time,
                    monitor:monitor,
                    put:put,
                    team:team,
                    WorkMan:WorkMan,
                    takekind:htakekind,
                    EquipID:EquipID,
                    plant,plant,
                    userid:userid,
                    i:i,
                    id:ids,
                    isSet:isSet,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $.messager.alert('温馨提示', '保存成功!!!');
                    $("#hfmsave1").form('clear');
                    $("#hdlgcj").dialog("close");
                    ids = '';
                    Query();

                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }




    }
    function Query() {
        $.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${ctxPath }/PersonnelMaintenance/query.action",
            dataType:"json",
            data: {
                UserTypes:i,
                department:'热处理车间'
            },
            success:function(data) {
                fdata = data;
                $('#hpm').datagrid({
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
                        {field:'id',title:'序号',width:'50px',editor:'text',halign:"center",align:'center'},
                        {field:'userName',title:'姓名',width:'70px',editor:'text',align:'center',halign:"center"},
                        {field:'userID',title:'工号',width:'100px',editor:'text',align:'center',halign:"center"},
                        {field:'team',title:'班组',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?true:false,},
                        {field:'monitor',title:'班长',width:'70px',editor:'text',align:'center'},
                        {field:'equipID',title:'设备编号',width:'70px',editor:'text',align:'center',hidden:i=='生产人员'?false:true,},
                        {field:'workprocedure',title:'工序',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?true:false,},
                        {field:'workTypes',title:'工种',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                        {field:'departMent',title:'部门',width:'70px',editor:'text',align:'center'},
                        {field:'userTypes',title:'类别',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                        {field:'workMan',title:'任务人',width:'70px',editor:'text',align:'center',hidden:i=='生产人员'?false:true,},
                        {field:'isSet',title:'在岗',width:'70px',editor:'text',align:'center',hidden:i=='生产人员'?false:true,},
                        {field:'weChatID',title:'微信账号',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                        {field:'imgName',title:'照片名称',width:'100px',editor:'text',align:'center'},
                    ]]
                })
                $('#hpm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

            },

        })
        $('#hpm').datagrid('loadData',{total:0,rows:[]});
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
            url:'${ctxPath }/PersonnelMaintenance/query1.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#hpmPlant').combobox('loadData', data);
                $.ajax({
                    type:"POST",   //post提交方式默认是get
                    url:"${ctxPath }/PersonnelMaintenance/query.action",
                    dataType:"json",
                    data: {
                        UserTypes:i,
                    },
                    success:function(data) {
                        console.log(data);
                        fdata = data;
                        $('#hpm').datagrid({
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
                                {field:'id',title:'序号',width:'50px',editor:'text',halign:"center",align:'center'},
                                {field:'userName',title:'姓名',width:'70px',editor:'text',align:'center',halign:"center"},
                                {field:'userID',title:'工号',width:'100px',editor:'text',align:'center',halign:"center"},
                                {field:'team',title:'班组',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?true:false,},
                                {field:'monitor',title:'班长',width:'70px',editor:'text',align:'center'},
                                {field:'equipID',title:'设备编号',width:'70px',editor:'text',align:'center',hidden:i=='生产人员'?false:true,},
                                {field:'workprocedure',title:'工序',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                                {field:'workTypes',title:'工种',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                                {field:'departMent',title:'部门',width:'70px',editor:'text',align:'center'},
                                {field:'userTypes',title:'类别',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                                {field:'workMan',title:'任务人',width:'70px',editor:'text',align:'center',hidden:i=='生产人员'?false:true,},
                                {field:'isSet',title:'在岗',width:'70px',editor:'text',align:'center',hidden:i=='生产人员'?false:true,},
                                {field:'weChatID',title:'微信账号',width:'70px',editor:'text',align:'center',hidden:i=='维修人员'?false:true,},
                                {field:'imgName',title:'照片名称',width:'70px',editor:'text',align:'center'},
                            ]]
                        })
                        $('#hpm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                    },

                })
                $('#hpm').datagrid({
                    rowStyler: function (index, row) {
                        var over = row.isSet;
                        if (over=='否') {
                            return 'background-color:#FF4500;color:white';
                        }
                    }
                });
                $('#hpm').datagrid('loadData',{total:0,rows:[]});

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
        $("#htreepm").tree({
            url: '${ctxPath }/PersonnelMaintenance/serach',
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
    function getDepartment() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/PersonnelMaintenance/Department.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#hDepartMent1').combobox('loadData', data);
                $('#hdepartment').combobox('loadData', data);
                $('#hput').combobox('loadData', data);
                //alert(11111);

            }
        });
    }
    $('#hput').combobox({
        onChange: function (newValue, oldValue) {
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/PersonnelMaintenance/selectDeviceNName.action',
                dataType: "json",
                data: {
                    plant:  $('#hpmPlant').combobox('getText'),
                    department:newValue,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $('#hEquipID').combobox('loadData', data);
                }
            });
        }
    });

    function paddperson() {
        if(i==""){
            $.messager.alert("温馨提示","选择添加目录!");
        }else {
            if(i=="检验人员"){
                getDepartment();
                $('#huserid2').textbox("setValue",'');
                $('#hOutfname').textbox("setValue",'');
                $('#hOutmonitor').textbox("setValue",'');
                $('#htakekind').combobox('setValues','早班');
                $('#hdepartment').combobox('setValues','');
                $('#outhtakekind').combobox('setValues','热处理');
                $("#hdlgpm").dialog({
                    title: '检验人员',
                    width: 300,
                    height: 420,
                    modal: true,
                });
                $("#hdlgpm").dialog("open"); // 打开dialog
            }
            if(i=="生产人员"){
                getDepartment();
                $('#hputfname').textbox("setValue",'');
                $('#huserid').textbox("setValue",'');
                $('#hputmonitor').textbox("setValue",'');
                $('#hEquipID').textbox("setValue",'');
                $('#hput').textbox("setValue",'');
                $('#hWorkMan').textbox("setValue",'');
                $('#hbanzu').combobox('setValues','早班');
                $('#hisSet').combobox('setValues','是');
                $('#pututhtakekind').combobox('setValues','热处理');
                $("#hdlgcj").dialog({
                    title: '生产人员',
                    width: 300,
                    height:530,
                    modal: true,
                });
                $("#hdlgcj").dialog("open");

            }
            if(i=="维修人员"){
                getDepartment();
                $('#huserid1').textbox("setValue",'');
                $('#puthtakekind').textbox("setValue",'');
                $('#hDepartMent1').textbox("setValue",'');
                $('#hWeChatID').textbox("setValue",'');
                $('#hname').textbox("setValue",'');
                $('#hlocation').textbox("setValue",'');
                $("#hdlghot").dialog({
                    title: '维修人员',
                    width: 300,
                    height:400,
                    modal: true,
                });
                $("#hdlghot").dialog("open");
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
    $("#htreepm").tree({
        onClick:function(node){
            i = node.text;
            Query();
        }
    });
    function hdeleteperson() {
        var row = $("#hpm").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    var id = row.id;
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url:'${ctxPath }/PersonnelMaintenance/DeleteData.action',
                        dataType: "json",
                        data: {
                            id:id,
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $.messager.alert('温馨提示', '删除成功!!!');
                            Query();
                        }
                    });
                }
            })
        }


    }
    function haddimg () {
        var row = $("#hpm").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else {
            $('#hID').textbox("setValue",row.id);
            $('#himgname').textbox("setValue",row.userName);
            $("#hdlgimg").dialog({
                title: '添加图片',
                width: 700,
                height:100,
                modal: true,
            });
            $('#hdlgimg').dialog('open');

        }
    }
    function hupdateperson () {
        var row = $("#hpm").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
            $('#px').datagrid('loadData',{total:0,rows:[]});
        }else{
            getDepartment();
            if(i=="检验人员"){
                $('#huserid2').textbox("setValue",row.userID);
                $('#hOutfname').textbox("setValue",row.userName);
                $('#hOutmonitor').textbox("setValue",row.monitor);
                $('#htakekind').combobox('setValues',row.team);
                $('#hdepartment').combobox('setValues',row.departMent);
                $('#outhtakekind').combobox('setValues',row.workprocedure);
                $("#hdlgpm").dialog({
                    title: '检验人员',
                    width: 300,
                    height: 420,
                    modal: true,
                });
                $("#hdlgpm").dialog("open"); // 打开dialog
                $('#px').datagrid('loadData',{total:0,rows:[]});
            }
            if(i=="生产人员"){
                $('#hputfname').textbox("setValue",row.userName);
                $('#huserid').textbox("setValue",row.userID);
                $('#hputmonitor').textbox("setValue",row.monitor);
                $('#hEquipID').textbox("setValue",row.equipID);
                $('#hput').textbox("setValue",row.departMent);
                $('#hWorkMan').textbox("setValue",row.workMan);
                $('#hbanzu').combobox('setValues',row.team);
                $('#hisSet').combobox('setValues',row.isSet);
                $('#pututhtakekind').combobox('setValues',row.workprocedure);
                $("#hdlgcj").dialog({
                    title: '生产人员',
                    width: 300,
                    height:530,
                    modal: true,
                });
                $("#hdlgcj").dialog("open");
                $('#px').datagrid('loadData',{total:0,rows:[]});
            }
            if(i=="维修人员"){
                $('#huserid1').textbox("setValue",row.userID);
                $('#puthtakekind').textbox("setValue",row.workTypes);
                $('#hDepartMent1').textbox("setValue",row.departMent);
                $('#hWeChatID').textbox("setValue",row.weChatID);
                $('#hname').textbox("setValue",row.userName);
                $('#hlocation').textbox("setValue",row.monitor);
                $("#hdlghot").dialog({
                    title: '维修人员',
                    width: 300,
                    height:400,
                    modal: true,
                });
                $("#hdlghot").dialog("open");
                $('#px').datagrid('loadData',{total:0,rows:[]});
            }
        }
        ids = row.id;


    }
</script>

