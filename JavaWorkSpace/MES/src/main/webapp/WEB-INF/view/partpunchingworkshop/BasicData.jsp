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
    .e4{
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
                    <select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="bdPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                            style="width:100px">
                    </select>&nbsp
<shiro:hasPermission name="/BasicData/adddata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="adddata()" plain="true" style="width: 100px;text-align: center">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="/BasicData/deletedata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="deletedata()" plain="true" style="width: 100px;text-align: center">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/BasicData/updatedata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="updatedata()" plain="true" style="width: 100px;text-align: center">修改</a>
</shiro:hasPermission>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="H" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <ul id="tree_base" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="J"  data-options="region:'east',split:true">
                    <table id="bd" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlgbz" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 580px;  padding: 10px;"
     closed="true" buttons="#dlgbz-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        检验标准添加/修改
    </div>
    <form id="fmsave" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px;text-align: center" >
                <tr>
                    <td>物料编码：<input name="Infname" id="bdfno" class="easyui-validatebox" onblur="bdonblur();" style="width: 150px;height: 20px"  align="left"  /></td>
                </tr>
                <tr>
                    <td><span class="e2">图号：</span><input name="Inlocation"  id="bdfname" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>图号名称：<input name="Inlocation"  id="bdljms" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e3">孔心距：</span><input name="Inlocation"  id="bdlocation" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e2">孔径：</span><input name="Inlocation"  id="bdkj" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>孔位置度：<input name="Inlocation"  id="bdkwzd" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e2">厚度：</span><input name="Inlocation"  id="bdhd" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e2">外观：</span><input name="Inlocation"  id="bdwg" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>链板高度：<input name="Inlocation"  id="bdtbgd" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e3">光亮带：</span><input name="Inlocation"  id="bdgld" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgbz-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Savedate()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>


<div id="dlgcn" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 280px;  padding: 10px;"
     closed="true" buttons="#dlgcn-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        产能添加/修改
    </div>
    <form id="fmsave1" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >

                <tr>
                    <td>零件编码：<input name="Infname" id="bdputfname" class="easyui-validatebox" onblur="bdCapacity();" style="width: 147px;height: 20px"  align="left" /></td>
                </tr>

                <tr>
                    <td>零件描述：<input name="Inlocation"  id="bdputOutlocation" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

                <tr>
                    <td>单日产能(kg)：<input name="Inlocation"  id="bdput" class="easyui-textbox" style="width: 120px;height: 25px"    /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgcn-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveCapacity()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgjob" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 390px;  padding: 10px;"
     closed="true" buttons="#dlgjob-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
         报工编码添加/修改
    </div>
    <form id="fmjob" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >

                <tr>
                    <td>物料编码：<input name="Infname" id="job-fno" class="easyui-validatebox" onblur="JobFno();" style="width: 147px;height: 20px"  align="left" /></td>
                </tr>

                <tr>
                    <td>物料描述：<input name="Inlocation"  id="job-fname" class="easyui-textbox" style="width: 150px;height: 25px"   readonly /></td>
                </tr>
                <tr>
                    <td>报工编码：<input name="Infname" id="job-fno1" class="easyui-validatebox" onblur="JobFno1();" style="width: 147px;height: 20px"  align="left" /></td>
                </tr>
                <tr>
                    <td>报工描述：<input name="Inlocation"  id="job-fname1" class="easyui-textbox" style="width: 150px;height: 25px"  readonly  /></td>
                </tr>
                <tr>
                    <td>打印标记：<input name="Inlocation"  id="job-workcentre2" class="easyui-textbox" style="width: 150px;height: 25px"  readonly  /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgjob-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveJob()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgM" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 390px;  padding: 10px;"
     closed="true" buttons="#dlgM-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        外购材料添加/修改
    </div>
    <form id="fmM" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >

                <tr>
                    <td>物料编码：<input name="Infname" id="Mfno" class="easyui-validatebox" onblur="MFno();" style="width: 147px;height: 20px"  align="left" /></td>
                </tr>

                <tr>
                    <td>物料描述：<input name="Inlocation"  id="Mfname" class="easyui-textbox" style="width: 150px;height: 25px"  readonly  /></td>
                </tr>
                <tr>
                    <td>物料类型：<input name="Infname" id="Mworkcentre5" class="easyui-textbox" style="width: 150px;height: 25px"  readonly  /></td>
                </tr>
                <tr>
                    <td>材料材质：<input name="Inlocation"  id="Mtemp3" class="easyui-textbox" style="width: 150px;height: 25px"  readonly  /></td>
                </tr>
                <tr>
                    <td>材料规格：<input name="Inlocation"  id="Mtemp4" class="easyui-textbox" style="width: 150px;height: 25px"   readonly /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgM-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveM()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgS" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 250px;  padding: 10px;"
     closed="true" buttons="#dlgS-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        材料供方添加/修改
    </div>
    <form id="fmS" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >

                <tr>
                    <td>物料类型：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="MeterType" panelHeight="auto" data-options="
                                valueField:'MeterType',
                                textField:'MeterType',
                                panelHeight:'250'"
                                            style="width:100px">
                    </select></td>
                </tr>

                <tr>
                    <td>供应厂商：<input name="Inlocation"  id="supper" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

            </table>

        </div>

    </form>
</div>
<div id="dlgS-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveS()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="dlgsb" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 450px;  padding: 10px;"
     closed="true" buttons="#dlgcn-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        设备添加/修改
    </div>
    <form id="fmsave2" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr id="ReturnrReason" style="display: none">
                    <td>设备编号：<input name="Infname" id="Equipid" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" readonly  /></td>
                </tr>
                <tr>
                    <td>设备名称：<input name="Infname" id="EquipName" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>

                <tr>
                    <td>设备型号：<input name="Inlocation"  id="EquipType" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

                <tr>
                    <td>设备厂编：<input name="Inlocation"  id="EquipDHID" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>生产厂家：<input name="Inlocation"  id="Manufacturer" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr id="ReturnrReason1" style="display: none">
                    <td><span class="e2">部门：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="DepartMent" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                                           style="width:100px">
                    </select></td>
                </tr>
                <tr>
                    <td><span class="e4">设备ip：</span><input name="Inlocation"  id="ip" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e4">ip编号：</span><input name="Inlocation"  id="ipno" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlgcn-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveEquip()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate()" iconcls="icon-cancel">取消</a>
</div>
<script type="text/javascript">
    var i='' ;
    var ids='';
    var j = '';//判断点击添加还是修改（报工）
    var n = '';//判断点击添加还是修改(外购)
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
    var name = localStorage.getItem("User");
    function getMeterType () {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/BasicData/MeterType.action',
            dataType: "json",
            data: {

            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#MeterType').combobox('loadData', data);
            }
        });
    }
    function Savedate () {
        var  PartDrawing = $('#bdfname').val();//图号
        var  PartName = $('#bdljms').val();//图号名称
        var  HoleHD = $('#bdlocation').val();//孔心距
        var  Aperture = $('#bdkj').val();//孔径
        var  HoleSite = $('#bdkwzd').val();//孔位置度
        var  Height = $('#bdtbgd').val();//链板高度
        var  Thickness = $('#bdhd').val();//厚度
        var  Facade = $('#bdwg').val();//外观
        var  Leuchtfeld = $('#bdgld').val();//光亮带
        if(PartDrawing!=""&&PartName!=""&&HoleHD!=""
            &&Aperture!=""&&HoleSite!=""&&Height!=""
            &&Thickness!=""&&Facade!=""&&Leuchtfeld!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/BasicData/Insert.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    PartDrawing:PartDrawing,
                    PartName:PartName,
                    HoleHD:HoleHD,
                    Aperture:Aperture,
                    HoleSite:HoleSite,
                    Height:Height,
                    Thickness:Thickness,
                    Facade:Facade,
                    Leuchtfeld:Leuchtfeld,
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
                        $("#dlgbz").dialog("close");
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
        $("#dlgbz").dialog("close");
        $("#fmsave1").form('clear');
        $("#dlgcn").dialog("close");
        $("#fmsave2").form('clear');
        $("#fmjob").form('clear');
        $("#dlgsb").dialog("close");
        $("#dlgjob").dialog("close");
        $("#fmM").form('clear');
        $("#dlgM").dialog("close");
        $("#fmS").form('clear');
        $("#dlgS").dialog("close");

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
                $('#DepartMent').combobox('loadData', data);
                //alert(11111);

            }
        });
    }
    function deletedata () {
        var row = $("#bd").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    var id = row.id;
                    var EquipID = row.equipID;
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/BasicData/Deletedata.action",//要发送的后台地址
                        data:{
                            id:id,
                            i:i,
                            EquipID:EquipID,
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
    function SaveCapacity() {
        var  fno = $('#bdputfname').val();//物料编码
        var  fname = $('#bdputOutlocation').val();//物料描述
        var  Capacity = $('#bdput').val();//产能
        if(fno!=""&&fname!=""&&Capacity!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/BasicData/Insert1.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    fno:fno,
                    fname:fname,
                    Capacity:Capacity,
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
                        $("#dlgcn").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }


    }
    function SaveEquip () {
        var  EquipName = $('#EquipName').val();
        var  EquipType = $('#EquipType').val();
        var  EquipDHID = $('#EquipDHID').val();
        var  ip = $('#ip').val();
        var ipno = $('#ipno').val();
        var  Manufacturer = $('#Manufacturer').val();
        var  DepartMent = $('#DepartMent').combobox("getText");
        if(EquipName!=""&&EquipType!=""&&EquipDHID!=""&&Manufacturer!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/BasicData/InsertEquip.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    EquipName:EquipName,
                    EquipType:EquipType,
                    EquipDHID:EquipDHID,
                    i:i,
                    id:ids,
                    Manufacturer:Manufacturer,
                    ip:ip,
                    ipno:ipno,
                    DepartMent:DepartMent,
                    plant: localStorage.getItem("Department")
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    if(data.num>0){
                        $.messager.alert('温馨提示', '保存成功!!!');
                        $("#fmsave2").form('clear');
                        $("#dlgsb").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function updatedata(){
        var row = $("#bd").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            ids = row.id;
            if(i=="检验标准"){
                $("#bdfname").val(row.partDrawing);
                $('#bdljms').textbox("setValue",row.partName);
                $('#bdlocation').textbox("setValue",row.holeHD);
                $('#bdkj').textbox("setValue",row.aperture);
                $('#bdkwzd').textbox("setValue",row.holeSite);
                $('#bdtbgd').textbox("setValue",row.height);
                $('#bdhd').textbox("setValue",row.thickness);
                $('#bdwg').textbox("setValue",row.facade);
                $('#bdgld').textbox("setValue",row.leuchtfeld);
                $("#dlgbz").dialog("open");

            }
            if(i=="产能表"){
                var row = $("#bd").datagrid("getSelected");
                ids = row.id;
                $('#bdputfname').val(row.fno);
                $('#bdputOutlocation').textbox("setValue",row.fname);
                $('#bdput').textbox("setValue",row.capacity);
                $("#dlgcn").dialog("open");
            }
            if(i=='设备表'){
                var row = $("#bd").datagrid("getSelected");
                ids = row.id;
                $("#ReturnrReason").css('display', '');
                $('#Equipid').textbox("setValue",row.equipID);
                $('#ip').textbox("setValue",row.ip);
                $('#ipno').textbox("setValue",row.ipno);
                $('#EquipName').textbox("setValue",row.equipName);
                $('#EquipType').textbox("setValue",row.equipType);
                $('#EquipDHID').textbox("setValue",row.equipDHID);
                $('#Manufacturer').textbox("setValue",row.manufacturer);
                $("#ReturnrReason1").css('display', 'none');
                $("#dlgsb").dialog("open");
            }
            if(i=='报工编码'){
                j =2 ;
                var row = $("#bd").datagrid("getSelected");
                ids = row.id;
                $('#job-fno').val(row.fno);
                $('#job-fno1').val(row.jobFno);
                $('#job-fname').textbox("setValue",row.fname);
                $('#job-fname1').textbox("setValue",row.jobFname);
                $('#job-workcentre2').textbox("setValue",row.workcentre2);
                $("#dlgjob").dialog("open");
            }
            if(i=="外购材料"){
                n =2 ;
                var row = $("#bd").datagrid("getSelected");
                ids = row.id;
                $('#Mfno').val(row.fno);
                $('#Mworkcentre5').textbox("setValue",row.workcentre5);
                  $('#Mtemp3').textbox("setValue",row.ftemp3);
                  $('#Mfname').textbox("setValue",row.fname);
                $('#Mtemp4').textbox("setValue",row.ftemp4);
                $("#dlgM").dialog("open");
            }
            if(i=="材料供方"){
                $('#MeterType').combobox('setValues',row.meterType.split(','));
                $('#supper').textbox("setValue",row.supplier);
                $("#dlgS").dialog("open");
            }
        }

    }
     function bdonblur () {
         var  bdfno = $('#bdfno').val();
         if(bdfno==""){
             return false;
         }else {
             $.ajax({
                 type:"post",
                 url: "${ctxPath}/MouldManage/look.action",//要发送的后台地址
                 data:{
                     partDrawing:bdfno,
                 },
                 dataType: "json",//后台处理后返回的数据格式
                 success: function (data1) {//ajax请求成功后触发的方法
                     console.log(data1);
                     if (data1.num !=-1) {
                         $('#bdljms').textbox("setValue",data1.projectname);
                         $('#bdfname').textbox("setValue",data1.project);
                     }else {
                         $.messager.alert('温馨提示', '此模具规格不存在');
                     }

                 },
             })
         }

     }
    function bdCapacity () {
        var  fno = $('#bdputfname').val();//
        if(fno==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/look2.action",//要发送的后台地址
                data:{
                    fno:fno,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        $('#bdputOutlocation').textbox("setValue",data1.fname);
                    }else {
                        $.messager.alert('温馨提示', '此物料编码不存在');
                    }

                },
            })
        }

    }
    function JobFno () {
        var  fno = $('#job-fno').val();//
        if(fno==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/look2.action",//要发送的后台地址
                data:{
                    fno:fno,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        $('#job-fname').textbox("setValue",data1.fname);
                    }else {
                        $.messager.alert('温馨提示', '此物料编码不存在');
                    }

                },
            })
        }

    }
    function JobFno1 () {
        var  fno = $('#job-fno1').val();//
        if(fno==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/look2.action",//要发送的后台地址
                data:{
                    fno:fno,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        $('#job-fname1').textbox("setValue",data1.fname);
                        $('#job-workcentre2').textbox("setValue",data1.workcentre2);
                    }else {
                        $.messager.alert('温馨提示', '此物料编码不存在');
                    }

                },
            })
        }

    }
    function SaveJob () {
        var  fno = $('#job-fno').val();//物料编码
        var  fname = $('#job-fname').val();//物料描述
        var  jfname = $('#job-fname1').val();//物料描述
        var  jfno = $('#job-fno1').val();//物料编码
        var  workcentre2 = $('#job-workcentre2').val();//
           if(j =='1'){
               if(fno!=""&&fname!=""&&jfname!=""&&jfno!=""){

                   jQuery.ajax({
                       type: "POST",   //post提交方式默认是get
                       url:'${ctxPath }/BasicData/Fno.action',
                       dataType: "json",
                       data: {
                           fno:fno
                       },
//                data:$("#login").val(),   //序列化
                       error: function (request) {      // 设置表单提交出错
                           $("#showMsg").html(request);  //登录错误提示信息

                       },
                       success: function (data) {
                           if(data.num==0){
                               jQuery.ajax({
                                   type: "POST",   //post提交方式默认是get
                                   url:'${ctxPath }/BasicData/Savefno.action',
                                   dataType: "json",
                                   data: {
                                       fno:fno,
                                       fname:fname,
                                       jfname:jfname,
                                       jfno:jfno,
                                       workcentre2:workcentre2,
                                       time:time,
                                       name:name,
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
                                           $("#fmjob").form('clear');
                                           $("#dlgjob").dialog("close");
                                           ids = '';
                                           query();
                                       }


                                   }
                               });
                           }else {
                               $.messager.alert("温馨提示","这个物料编码存在多个报工编码");
                           }


                       }
                   });
               }else {
                   $.messager.alert("温馨提示","数据不能为空!");
               }
           }else {
               if(fno!=""&&fname!=""&&jfname!=""&&jfno!=""){

                   jQuery.ajax({
                       type: "POST",   //post提交方式默认是get
                       url:'${ctxPath }/BasicData/Savefno.action',
                       dataType: "json",
                       data: {
                           fno:fno,
                           fname:fname,
                           jfname:jfname,
                           jfno:jfno,
                           workcentre2:workcentre2,
                           time:time,
                           name:name,
                           i:i,
                           id:ids,
                       },
//                data:$("#login").val(),   //序列化
                       error: function (request) {      // 设置表单提交出错
                           $("#showMsg").html(request);  //登录错误提示信息

                       },
                       success: function (data) {
                           if(data.num>0){
                               $.messager.alert('温馨提示', '更新成功!!!');
                               $("#fmjob").form('clear');
                               $("#dlgjob").dialog("close");
                               ids = '';
                               query();
                           }


                       }
                   });
               }else {
                   $.messager.alert("温馨提示","数据不能为空!");
               }
           }


    }
    function MFno () {
        var  fno = $('#Mfno').val();//
        if(fno==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/look2.action",//要发送的后台地址
                data:{
                    fno:fno,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        $('#Mfname').textbox("setValue",data1.fname);
                        $('#Mworkcentre5').textbox("setValue",data1.workcentre5);
                        $('#Mtemp3').textbox("setValue",data1.ftemp3);
                        $('#Mtemp4').textbox("setValue",data1.ftemp4);

                    }else {
                        $.messager.alert('温馨提示', '此物料编码不存在');
                    }

                },
            })
        }
    }
    function SaveM () {
        var  fno = $('#Mfno').val();//物料编码
        var  fname = $('#Mfname').val();//物料描述
        var  workcentre5 = $('#Mworkcentre5').val();//物料描述
        var  temp3 = $('#Mtemp3').val();//物料编码
        var  temp4 = $('#Mtemp4').val();//
        if(n =='1'){
            if(fno!=""&&fname!=""&&temp3!=""&&temp4!=""){

                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url:'${ctxPath }/BasicData/MFno.action',
                    dataType: "json",
                    data: {
                        fno:fno
                    },
//                data:$("#login").val(),   //序列化
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息

                    },
                    success: function (data) {
                        if(data.num==0){
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/BasicData/SaveM.action',
                                dataType: "json",
                                data: {
                                    fno:fno,
                                    fname:fname,
                                    workcentre5:workcentre5,
                                    temp3:temp3,
                                    temp4:temp4,
                                    time:time,
                                    name:name,
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
                                        $("#fmM").form('clear');
                                        $("#dlgM").dialog("close");
                                        ids = '';
                                        query();
                                    }


                                }
                            });
                        }else {
                            $.messager.alert("温馨提示","这个物料编码已存在");
                        }


                    }
                });
            }else {
                $.messager.alert("温馨提示","数据不能为空!");
            }
        }else {
            if(fno!=""&&fname!=""&&temp3!=""&&temp4!=""){

                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url:'${ctxPath }/BasicData/SaveM.action',
                    dataType: "json",
                    data: {
                        fno:fno,
                        fname:fname,
                        workcentre5:workcentre5,
                        temp3:temp3,
                        temp4:temp4,
                        time:time,
                        name:name,
                        i:i,
                        id:ids,
                    },
//                data:$("#login").val(),   //序列化
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息

                    },
                    success: function (data) {
                        if(data.num>0){
                            $.messager.alert('温馨提示', '更新成功!!!');
                            $("#fmM").form('clear');
                            $("#dlgM").dialog("close");
                            ids = '';
                            query();
                        }


                    }
                });
            }else {
                $.messager.alert("温馨提示","数据不能为空!");
            }
        }


    }
    function SaveS () {
        var  MeterType = $('#MeterType').combobox("getText");
        var  supper = $('#supper').val();
        if(supper!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/BasicData/SaveaS.ction',
                dataType: "json",
                data: {
                    MeterType:MeterType,
                    supper:supper,
                    time:time,
                    name:name,
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
                        $("#fmS").form('clear');
                        $("#dlgS").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
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
                $('#bdPlant').combobox('loadData', data);
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
        $("#tree_base").tree({
            url: '${ctxPath }/BasicData/serach',
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


    function adddata() {
        if(i==""){
            $.messager.alert("温馨提示","选择添加目录!");
        }else {
            Canceldate();
            if(i=="检验标准"){
                $("#dlgbz").dialog("open");
            }
            if(i=="产能表"){
                $("#dlgcn").dialog("open");
            }
            if(i=="设备表"){
                getDepartment();
                $("#ReturnrReason").css('display', 'none');
                $("#ReturnrReason1").css('display', '');
                $("#dlgsb").dialog("open");
            }
            if(i=="报工编码"){
                j= 1;
                 $("#dlgjob").dialog("open");
            }
            if(i=="外购材料"){
                n= 1;
                $("#dlgM").dialog("open");
            }
            if(i=="材料供方"){
                getMeterType ();
                $("#dlgS").dialog("open");
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
            url:"${ctxPath }/BasicData/query.action",
            dataType:"json",
            data: {
                name:i,
                plant: localStorage.getItem("Department")
            },
            success:function(data) {
                console.log(data);
                fdata = data;
                if(i=="检验标准"||i=="产能表"||i=="设备表"){
                    $('#bd').datagrid({
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
                            {field:'partDrawing',title:'图号',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'partName',title:'图号名称',width:'121px',editor:'text',align:'left',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'fno',title:'零件编码',width:'80px',editor:'text',align:'left',halign:"center",hidden:i=='产能表'?false:true,},
                            {field:'fname',title:'零件描述',width:'200px',editor:'text',align:'left',halign:"center",hidden:i=='产能表'?false:true,},
                            {field:'holeHD',title:'孔心距',width:'120px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'aperture',title:'孔径',width:'120px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'holeSite',title:'孔位置度',width:'70px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'thickness',title:'厚度',width:'120px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'facade',title:'外观',width:'200px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'height',title:'链板高度',width:'120px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'leuchtfeld',title:'光亮带',width:'70px',editor:'text',align:'right',halign:"center",hidden:i=='检验标准'?false:true,},
                            {field:'capacity',title:'单日产能（kg）',width:'100px',editor:'text',align:'right',halign:"center",hidden:i=='产能表'?false:true,},
                            {field:'workHours',title:'生产工时',width:'100px',editor:'text',align:'right',halign:"center",hidden:i=='产能表'?false:true,},
                            {field:'equipID',title:'设备编号',width:'70px',editor:'text',align:'left',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'equipName',title:'设备名称',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'equipType',title:'设备型号',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'equipDHID',title:'设备厂编号',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'manufacturer',title:'生产厂家',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'ip',title:'ip地址',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'ipno',title:'编号',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'departMent',title:'部门',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'plant',title:'事业部',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                        ]]
                    })
                    $('#bd').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
                }else {
                    $('#bd').datagrid({
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
                            {field:'fno',title:'物料编码',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='材料供方'?true:false,},
                            {field:'fname',title:'物料描述',width:'250px',editor:'text',align:'left',halign:"center",hidden:i=='材料供方'?true:false,},
                            {field:'jobFno',title:'报工编码',width:'100px',editor:'text',align:'left',halign:"center",hidden:i=='报工编码'?false:true,},
                            {field:'jobFname',title:'报工编码描述',width:'250px',editor:'text',align:'left',halign:"center",hidden:i=='报工编码'?false:true,},
                            {field:'workcentre2',title:'打印标记',width:'150px',editor:'text',align:'left',halign:"center",hidden:i=='报工编码'?false:true,},
                            {field:'workcentre5',title:'物料类型',width:'150px',editor:'text',align:'left',halign:"center",hidden:i=='外购材料'?false:true,},
                            {field:'ftemp3',title:'材质',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='外购材料'?false:true,},
                            {field:'ftemp4',title:'规格',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='外购材料'?false:true,},
                            {field:'meterType',title:'物料类型',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='材料供方'?false:true,},
                            {field:'supplier',title:"供应商",width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='材料供方'?false:true,},
                            {field:'inputMan',title:'添加人',width:'100px',editor:'text',align:'center',halign:"center",},
                            {field:'inputTime',title:'添加时间',width:'150px',editor:'text',align:'left',halign:"center"},
                            {field:'modifyMan',title:'修改人',width:'100px',editor:'text',align:'center',halign:"center",},
                            {field:'modifyTime',title:'修改时间',width:'150px',editor:'text',align:'left',halign:"center",},
                        ]]
                    })
                    $('#bd').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
                }


            },

        })
        $('#bd').datagrid('loadData',{total:0,rows:[]});
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


