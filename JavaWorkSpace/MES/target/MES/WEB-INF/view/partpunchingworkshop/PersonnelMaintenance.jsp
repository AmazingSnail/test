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
                    <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="pmPlant" panelHeight="auto" data-options="
                                valueField:'Fname',
                                textField:'Fremark',
                                panelHeight:'250'"
                            style="width:100px">
                    </select>
<shiro:hasPermission name="/PersonnelMaintenance/addperson">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addperson()" plain="true" style="width: 100px;text-align: center">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="/PersonnelMaintenance/deleteperson">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="deleteperson()" plain="true" style="width: 100px;text-align: center">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/PersonnelMaintenance/updateperson">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="updateperson()" plain="true" style="width: 100px;text-align: center">修改</a>
</shiro:hasPermission>
<shiro:hasPermission name="/PersonnelMaintenance/addimg">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-pictures" onclick="addimg()" plain="true" style="width: 100px;text-align: center">添加图片</a>
</shiro:hasPermission>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="L" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <ul id="treepm" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="P"  data-options="region:'east',split:true">
                    <table id="pm" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlgpm" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 400px;  padding: 10px;"
     closed="true" buttons="#dlgpm-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        检验人员添加/修改
    </div>
    <form id="fmsave" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td>工号：<input name="Infname" id="userid2" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>姓名：<input name="Infname" id="Outfname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>班组：<select class="easyui-combobox" name="takekind" datatype="text"  id="takekind" panelHeight="auto" style="width:150px">
                        <option value="早班" selected="selected">早班</option>
                        <option value="中班">中班</option>
                        <option value="晚班">晚班</option>
                    </select></td>
                </tr>
                <tr>
                    <td>班长：<input name="Inlocation"  id="Outmonitor" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>工序：<select class="easyui-combobox" name="takekind" datatype="text" id="outtakekind"  panelHeight="auto" style="width:150px">
                        <option value="冲制"selected="selected">冲制</option>
                        <option value="报废">报废</option>
                    </select></td>
                </tr>
                <tr>
                    <td>部门：<select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="department" panelHeight="auto" data-options="
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
<div id="dlgpm-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveSer()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgcj" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 540px;  padding: 10px;"
     closed="true" buttons="#dlgcj-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        生产人员添加/修改
    </div>
    <form id="fmsave1" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td><span class="pm1">工号：</span><input name="Infname" id="userid" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>任务人：<input name="Infname" id="WorkMan" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td><span class="pm1">姓名：</span><input name="Infname" id="putfname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td><span class="pm1">班组：</span><select class="easyui-combobox" name="takekind" datatype="text" id="banzu" panelHeight="auto"  style="width:150px">
                        <option value="早班"selected="selected">早班</option>
                        <option value="中班">中班</option>
                        <option value="晚班">晚班</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">在岗：</span><select class="easyui-combobox" name="takekind" datatype="text" id="isSet" panelHeight="auto"  style="width:150px">
                        <option value="是"selected="selected">是</option>
                        <option value="否">否</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">班长：</span><input name="Inlocation"  id="putmonitor" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="pm1">工序：</span><select class="easyui-combobox" name="takekind" datatype="text" id="pututtakekind"  panelHeight="auto" style="width:150px">
                        <option value="冲制"selected="selected">冲制</option>
                        <option value="报废">报废</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">部门：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="put" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                    style="width:100px">
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm1">设备：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="EquipID" panelHeight="auto" data-options="
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
<div id="dlgcj-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveProcess()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlghot" class="easyui-dialog"  title="添加/修改" style="width:320px; height: 410px;  padding: 10px;"
     closed="true" buttons="#dlghot-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        维修人员添加/修改
    </div>
    <form id="fmsave2" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td><span class="pm3">工号：</span><input name="Infname" id="userid1" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"   /></td>
                </tr>
                <tr>
                    <td>微信账号：<input name="Infname" id="WeChatID" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"   /></td>
                </tr>
                <tr>
                    <td><span class="pm3">姓名：</span><input name="Infname" id="name" class="easyui-textbox" style="width: 150px;height: 25px"  align="left"  /></td>
                </tr>
                <tr>
                    <td><span class="pm3">工种：</span><select class="easyui-combobox" name="takekind" datatype="text" id="puttakekind"  panelHeight="auto" style="width:150px">
                        <option value="机修" selected="selected">机修</option>
                        <option value="电工">电工</option>
                        <option value="钳工">钳工</option>
                    </select></td>
                </tr>
                <tr>
                    <td><span class="pm3">班长：</span><input name="Inlocation"  id="location" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="pm3">部门：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="DepartMent1" panelHeight="auto" data-options="
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
<div id="dlghot-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveDevice()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgimg" class="easyui-dialog"  title="添加/修改" style="width:700px; height: 100px;  padding: 10px;"
     closed="true">
    <div class="ftitle" align="center" style="font-size: 15px">
        添加图片
    </div>
            <form id="test" action="DeviceManagement/upload" method="post" enctype="multipart/form-data" onsubmit="return sub();">
                序号：<input name="ID"  id="ID" class="easyui-textbox" style="width: 40px;height: 25px"    />
                人员姓名：<input name="imgname"  id="imgname" class="easyui-textbox" style="width: 80px;height: 25px"    />
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
            $("#dlgimg").dialog("close");
            Query();
        });

        return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
    }
    function SaveDevice () {//维修人员
        var department = $('#DepartMent1').combobox('getText');//部门
        var UserName = $('#name').val();//姓名
        var WeChatID = $('#WeChatID').val();//姓名
        var monitor = $('#location').val();//班长
        var userid = $('#userid1').val();//工号
        var takekind1 = $('#puttakekind').combobox('getText');//工序
        var plant = $('#pmPlant').combobox('getText');
        if(department!=""&&UserName!=""&&monitor!=""&&userid!=""&&takekind1!=""){
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
                    takekind1:takekind1,
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
                    $("#fmsave2").form('clear');
                    $("#dlghot").dialog("close");
                    ids = '';
                    Query();

                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function Canceldate() {
        $("#fmsave").form('clear');
        $("#dlgpm").dialog("close");
        $("#fmsave1").form('clear');
        $("#dlgcj").dialog("close");
        $("#fmsave2").form('clear');
        $("#dlghot").dialog("close");
        getDepartment();
    }
    function SaveSer () {//检验人员
    var department = $('#department').combobox('getText');//部门
    var UserName = $('#Outfname').val();//姓名
    var monitor = $('#Outmonitor').val();//班长
    var userid = $('#userid2').val();//工号
    var takekind = $('#outtakekind').combobox('getText');//工序
    var plant = $('#pmPlant').combobox('getText');
    var team = $('#takekind').combobox('getText');//班组
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
                    $("#fmsave").form('clear');
                    $("#dlgpm").dialog("close");
                    ids = '';
                    Query();

                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

}
    function SaveProcess () {//生产人员添加
    var UserName = $('#putfname').val();//姓名
    var monitor = $('#putmonitor').val();//班长
    var userid = $('#userid').val();//工号
    var WorkMan = $('#WorkMan').val();//任务人
    var put = $('#put').combobox('getText');//部门
    var team = $('#banzu').combobox('getText');//班组
    var takekind = $('#pututtakekind').combobox('getText');
    var EquipID = $('#EquipID').combobox('getText');
    var isSet = $('#isSet').combobox('getText');
    var plant = $('#pmPlant').combobox('getText');
    if(UserName!=""&&monitor!=""&&userid!=""&&put!=""&&team!=""&&takekind!=""&&EquipID!=""){
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
                takekind:takekind,
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
                $("#fmsave1").form('clear');
                $("#dlgcj").dialog("close");
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
            department:'零件车间',
        },
        success:function(data) {
            fdata = data;
            $('#pm').datagrid({
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
            $('#pm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

        },

    })
    $('#pm').datagrid('loadData',{total:0,rows:[]});
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
                $('#pmPlant').combobox('loadData', data);
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
                        $('#pm').datagrid({
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
                        $('#pm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                    },

                })
                $('#pm').datagrid({
                    rowStyler: function (index, row) {
                        var over = row.isSet;
                        if (over=='否') {
                            return 'background-color:#FF4500;color:white';
                        }
                    }
                });
                $('#pm').datagrid('loadData',{total:0,rows:[]});

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
        $("#treepm").tree({
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
                $('#DepartMent1').combobox('loadData', data);
                $('#department').combobox('loadData', data);
                $('#put').combobox('loadData', data);
                //alert(11111);

            }
        });
    }
    $('#put').combobox({
        onChange: function (newValue, oldValue) {
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/PersonnelMaintenance/selectDeviceNName.action',
                dataType: "json",
                data: {
                    plant:  $('#pmPlant').combobox('getText'),
                    department:newValue,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $('#EquipID').combobox('loadData', data);
                }
            });
        }
    });
    function addperson() {
        if(i==""){
            $.messager.alert("温馨提示","选择添加目录!");
        }else {
            Canceldate();
            if(i=="检验人员"){
                getDepartment();
                $("#dlgpm").dialog("open");
            }
            if(i=="生产人员"){
                getDepartment();
                $("#dlgcj").dialog("open");

            }
            if(i=="维修人员"){
                getDepartment();
                $("#dlghot").dialog("open");
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
    $("#treepm").tree({
        onClick:function(node){
            i = node.text;
            Query();
        }
    });
   function deleteperson() {
       var row = $("#pm").datagrid("getSelected");
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
   function addimg () {
       var row = $("#pm").datagrid("getSelected");
       if(row ===null){
           $.messager.alert('信息提示', '请选择有效行项目！');
       }else {
           $('#ID').textbox("setValue",row.id);
           $('#imgname').textbox("setValue",row.userName);
           $('#dlgimg').dialog('open');

       }
   }
   function updateperson () {
       var row = $("#pm").datagrid("getSelected");
       if(row ===null){
           $.messager.alert('信息提示', '请选择有效行项目！');
           $('#px').datagrid('loadData',{total:0,rows:[]});
       }else{
           getDepartment();
           if(i=="检验人员"){
               $('#userid2').textbox("setValue",row.userID);
               $('#Outfname').textbox("setValue",row.userName);
               $('#Outmonitor').textbox("setValue",row.monitor);
               $('#takekind').combobox('setValues',row.team);
               $('#department').combobox('setValues',row.departMent);
               $('#outtakekind').combobox('setValues',row.workprocedure);
               $("#dlgpm").dialog("open");
               $('#px').datagrid('loadData',{total:0,rows:[]});
           }
           if(i=="生产人员"){
               $('#putfname').textbox("setValue",row.userName);
               $('#userid').textbox("setValue",row.userID);
               $('#putmonitor').textbox("setValue",row.monitor);
               $('#EquipID').textbox("setValue",row.equipID);
               $('#put').textbox("setValue",row.departMent);
               $('#WorkMan').textbox("setValue",row.workMan);
               $('#banzu').combobox('setValues',row.team);
               $('#isSet').combobox('setValues',row.isSet);
               $('#pututtakekind').combobox('setValues',row.workprocedure);
               $("#dlgcj").dialog("open");
               $('#px').datagrid('loadData',{total:0,rows:[]});
               jQuery.ajax({
                   type: "POST",   //post提交方式默认是get
                   url:'${ctxPath }/PersonnelMaintenance/selectDevice.action',
                   dataType: "json",
                   data: {
                       plant: localStorage.getItem("Department")
                   },
//                data:$("#login").val(),   //序列化
                   error: function (request) {      // 设置表单提交出错
                       $("#showMsg").html(request);  //登录错误提示信息

                   },
                   success: function (data) {
                       $('#EquipID').combobox('loadData', data);
                       //alert(11111);

                   }
               });
           }
           if(i=="维修人员"){
               $('#userid1').textbox("setValue",row.userID);
               $('#puttakekind').textbox("setValue",row.workTypes);
               $('#DepartMent1').textbox("setValue",row.departMent);
               $('#WeChatID').textbox("setValue",row.weChatID);
               $('#name').textbox("setValue",row.userName);
               $('#location').textbox("setValue",row.monitor);
               $("#dlghot").dialog("open");
               $('#px').datagrid('loadData',{total:0,rows:[]});
           }
       }
       ids = row.id;


   }
</script>

