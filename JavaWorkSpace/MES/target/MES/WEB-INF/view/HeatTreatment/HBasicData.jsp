<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/7
  Time: 10:12 基础资料
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
    table.imagetable1 {
        font-family: verdana,arial,sans-serif;
        font-size:11px;
        color:#333333;
        border-width: 1px;
        border-color: #999999;
        border-collapse: collapse;
    }
    table.imagetable1 th {
        border-width: 1px;
        padding: 8px;
        border-style: solid;
        border-color: #999999;
    }
    table.imagetable1 td {
        border-width: 1px;
        padding: 6px;
        border-style: solid;
        border-color: #999999;
    }
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
                    <select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="hbdPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                            style="width:100px">
                    </select>&nbsp
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="hadddata()" plain="true" style="width: 100px;text-align: center">添加</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="hdeletedata()" plain="true" style="width: 100px;text-align: center">删除</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="hupdatedata()" plain="true" style="width: 100px;text-align: center">修改</a>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="H" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <ul id="htree_base" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="J"  data-options="region:'east',split:true">
                    <table id="hbd" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="hdlggy" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 450px;  padding: 10px;"
closed="true" buttons="#hdlggy-buttons">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:40px">
            <div class="wu-toolbar-button">
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label>模板名称：</label><input id="MBname" class="easyui-textbox" style="width:300px">&nbsp</td>
                        <td><label>模板编号：</label><input id="MBid" class="easyui-textbox" style="width:200px" readonly disabled>&nbsp</td>
                    </tr>
                </table>
            </div>
        </div>
        <hr>
           <div style="float:left;width: 50%" id="document1">
               <table border="0" class="imagetable1" style="width: 99%;text-align: center">
                   <tr>
                       <td></td><td>标准值</td><td>上差</td>
                       <td>下差</td> <td>厚度</td>
                   </tr>
                   <tr>
                       <td>淬火一区温度：</td><td><input id="quenchtemp1" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="quenchtemp1up" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="quenchtemp1low" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>淬火二区温度：</td><td><input id="quenchtemp2" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="quenchtemp2up" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="quenchtemp2low" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>淬火三区温度：</td><td><input id="quenchtemp3" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="quenchtemp3up" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="quenchtemp3low" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>淬火四区温度：</td><td><input id="quenchtemp4" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="quenchtemp4up" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="quenchtemp4low" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>淬火五区温度：</td><td><input id="quenchtemp5" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="quenchtemp5up" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="quenchtemp5low" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>淬火保温时间：</td><td><input id="QuenchTime" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="QuenchTimeup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="QuenchTimelow" style="width: 80%"></td><td><span>min</span></td>
                   </tr>
                   <tr>
                       <td>淬火介质温度：</td><td><input id="CoolTemp" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="CoolTempup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="CoolTemplow" style="width: 80%"></td><td><span>L/h</span></td>
                   </tr>

               </table>
           </div>
           <div style="height:84%; width:1px; border-left:1px  solid;float:left;color: grey" ></div>
            <div style="float:left;"><input type="text" style="width:5px;border: 0px;outline:none;height: 75%"></div>
           <div id="document2">
               <table border="0" class="imagetable1" style="width: 48%;text-align: center" id="product2">
                   <tr>
                       <td></td><td>标准值</td><td>上差</td>
                       <td>下差</td> <td>厚度</td>
                   <tr>
                   <tr>
                       <td>碳势：</td><td><input id="Carpotential" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="Carpotentialup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="Carpotentiallow" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>渗碳硬度：</td><td><input id="quenchhard" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="quenchhardup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="quenchhardlow" style="width: 80%"></td><td><span></span></td>
                   </tr>
                   <tr>
                       <td>渗层：</td><td><input id="coating" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="coatingup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="coatinglow" style="width: 80%"></td><td><span>min</span></td>
                   </tr>
                   <tr>
                       <td>回火温度：</td><td><input id="tempertemp" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="tempertempup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="tempertemplow" style="width: 80%"></td><td><span>°C</span></td>
                   </tr>
                   <tr>
                       <td>回火保温时间：</td><td><input id="tempertime" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="tempertimeup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="tempertimelow" style="width: 80%"></td><td><span>min</span></td>
                   </tr>
                   <tr>
                       <td>回火硬度：</td><td><input id="temperhard" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="temperhardup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="temperhardlow" style="width: 80%"></td><td><span></span></td>
                   </tr>
                   <tr>
                       <td>甲醇流量：</td><td><input id="CarbinolF" style="width:80%" class="easyui-textbox"></td>
                       <td><input id="CarbinolFup" style="width:80%" class="easyui-textbox"></td><td><input class="easyui-textbox" id="CarbinolFlow" style="width: 80%"></td><td><span>L/h</span></td>
                   </tr>
               </table>
           </div>
</div>
<div id="hdlggy-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="hSaveGY()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="hCanceldate()" iconcls="icon-cancel">取消</a>
</div>
<div id="hdlgsb" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 450px;  padding: 10px;"
     closed="true" buttons="#hdlgsb-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        设备添加/修改
    </div>
    <form id="fmsave2" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr id="ReturnrReason" style="display: none">
                    <td>设备编号：<input name="Infname" id="hEquipid" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" readonly  /></td>
                </tr>
                <tr>
                    <td>设备名称：<input name="Infname" id="hEquipName" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>

                <tr>
                    <td>设备型号：<input name="Inlocation"  id="hEquipType" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

                <tr>
                    <td>设备厂编：<input name="Inlocation"  id="hEquipDHID" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>生产厂家：<input name="Inlocation"  id="hManufacturer" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr id="ReturnrReason1" style="display: none">
                    <td><span class="e2">部门：</span><select class="easyui-combobox" name="mmPlant" style="width:150px" datatype="text"  id="hDepartMent" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                                           style="width:100px">
                    </select></td>
                </tr>
                <tr>
                    <td><span class="e4">设备ip：</span><input name="Inlocation"  id="hip" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td><span class="e4">ip编号：</span><input name="Inlocation"  id="hipno" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="hdlgsb-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="hSaveEquip()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="hCanceldate()" iconcls="icon-cancel">取消</a>
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
    function hCanceldate() {
        $("#hdlgsb").dialog("close");
        $("#fmsave2").form('clear');
        $("#hdlggy").dialog("close");
        $('#MBname').textbox('setValue','');

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
                $('#hDepartMent').combobox('loadData', data);
                //alert(11111);

            }
        });
    }
    function hdeletedata () {
        var row = $("#hbd").datagrid("getSelected");
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
    function  hSaveGY() {
        var plant = $('#hbdPlant').combobox('getValue');
        var plant1 = $('#hbdPlant').combobox('getText');
        var MBname = $('#MBname').val();
        var MBid = $('#MBid').val();
        var quenchtemp1 = $('#quenchtemp1').val();
        var quenchtemp1up = $('#quenchtemp1up').val();
        var quenchtemp1low = $('#quenchtemp1low').val();
        var quenchtemp2 = $('#quenchtemp2').val();
        var quenchtemp2up = $('#quenchtemp2up').val();
        var quenchtemp2low = $('#quenchtemp2low').val();
        var quenchtemp3 = $('#quenchtemp3').val();
        var quenchtemp3up = $('#quenchtemp3up').val();
        var quenchtemp3low = $('#quenchtemp3low').val();
        var quenchtemp4 = $('#quenchtemp4').val();
        var quenchtemp4up = $('#quenchtemp4up').val();
        var quenchtemp4low = $('#quenchtemp4low').val();
        var quenchtemp5 = $('#quenchtemp5').val();
        var quenchtemp5up = $('#quenchtemp5up').val();
        var quenchtemp5low = $('#quenchtemp5low').val();
        var QuenchTime = $('#QuenchTime').val();
        var QuenchTimeup = $('#QuenchTimeup').val();
        var QuenchTimelow = $('#QuenchTimelow').val();
        var CoolTemp = $('#CoolTemp').val();
        var CoolTempup = $('#CoolTempup').val();
        var CoolTemplow = $('#CoolTemplow').val();
        var QuenchHard = $('#quenchhard').val();
        var QuenchHardup = $('#quenchhardup').val();
        var QuenchHardlow = $('#quenchhardlow').val();
        var CarbinolF = $('#CarbinolF').val();
        var CarbinolFup = $('#CarbinolFup').val();
        var CarbinolFlow = $('#CarbinolFlow').val();
        var Carpotential = $('#Carpotential').val();
        var Carpotentialup = $('#Carpotentialup').val();
        var Carpotentiallow = $('#Carpotentiallow').val();
        var coating = $('#coating').val();
        var coatingup = $('#coatingup').val();
        var coatinglow = $('#coatinglow').val();
        var tempertemp = $('#tempertemp').val();
        var tempertempup = $('#tempertempup').val();
        var tempertemplow = $('#tempertemplow').val();
        var tempertime = $('#tempertime').val();
        var tempertimeup = $('#tempertimeup').val();
        var tempertimelow = $('#tempertimelow').val();
        var temperhard = $('#temperhard').val();
        var temperhardup = $('#temperhardup').val();
        var temperhardlow = $('#temperhardlow').val();
//        if(MBname!=''&&quenchtemp1!=''&&quenchtemp1up!=''&&quenchtemp1low!=''&&quenchtemp2!=''&&quenchtemp2up!=''&&quenchtemp2low!=''
//            &&quenchtemp3!=''&&quenchtemp3up!=''&&quenchtemp3low!=''&&quenchtemp4!=''&&quenchtemp4up!=''&&quenchtemp4low!=''&&quenchtemp5!=''
//            &&quenchtemp5up!=''&&quenchtemp5low!=''&&QuenchTime!=''&&QuenchTimeup!=''&&QuenchTimelow!=''&&CoolTemp!=''&&CoolTempup!=''
//            &&CoolTemplow!=''&&QuenchHardup!=''&&QuenchHard!=''&&QuenchHardlow!=''&&CarbinolF!=''&&CarbinolFup!=''&&CarbinolFlow!=''
//            &&Carpotential!=''&&Carpotentialup!=''&&Carpotentiallow!=''&&coating!=''&&coatingup!=''&&coatinglow!=''
//            &&tempertemp!=''&&tempertempup!=''&&tempertimelow!=''&&temperhard!=''&&temperhardup!=''&&temperhardlow!=''&&YDYQ!=''&&YDYQup!=''
//            &&YDYQlow!=''&&RX!=''&&RXup!=''&&RXlow!='' ){
            $.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${ctxPath }/ProductionProcess/InsertMould.action",
                dataType:"json",
                data: {
                    plant:plant,
                    plant1:plant1,
                    MBname:MBname,
                    MBid:MBid,
                    quenchtemp1:quenchtemp1,
                    quenchtemp1up:quenchtemp1up,
                    quenchtemp1low:quenchtemp1low,
                    quenchtemp2:quenchtemp2,
                    quenchtemp2up:quenchtemp2up,
                    quenchtemp2low:quenchtemp2low,
                    quenchtemp3:quenchtemp3,
                    quenchtemp3up:quenchtemp3up,
                    quenchtemp3low:quenchtemp3low,
                    quenchtemp4:quenchtemp4,
                    quenchtemp4up:quenchtemp4up,
                    quenchtemp4low:quenchtemp4low,
                    quenchtemp5:quenchtemp5,
                    quenchtemp5up:quenchtemp5up,
                    quenchtemp5low:quenchtemp5low,
                    QuenchTime:QuenchTime,
                    QuenchTimeup:QuenchTimeup,
                    QuenchTimelow:QuenchTimelow,
                    CoolTemp:CoolTemp,
                    CoolTempup:CoolTempup,
                    CoolTemplow:CoolTemplow,
                    QuenchHardup:QuenchHardup,
                    QuenchHard:QuenchHard,
                    QuenchHardlow:QuenchHardlow,
                    CarbinolF:CarbinolF,
                    CarbinolFup:CarbinolFup,
                    CarbinolFlow:CarbinolFlow,
                    Carpotential:Carpotential,
                    Carpotentialup:Carpotentialup,
                    Carpotentiallow:Carpotentiallow,
                    coating:coating,
                    coatingup:coatingup,
                    coatinglow:coatinglow,
                    tempertemp:tempertemp,
                    tempertempup:tempertempup,
                    tempertemplow:tempertemplow,
                    temperhard:temperhard,
                    temperhardup:temperhardup,
                    temperhardlow:temperhardlow,
                    time:time,
                    name:name,
                    ids:ids,
                    tempertime:tempertime,
                    tempertimeup:tempertimeup,
                    tempertimelow:tempertimelow,
                },
                success:function(data) {
                    console.log(data);
                    $.messager.alert('信息提示', '保存成功!!!');
                    query();
                    hCanceldate();
                },
            })
//        }else {
//            $.messager.alert('信息提示', '请完善数据!!!');
//        }

    }
    function hSaveEquip () {
        var  EquipName = $('#hEquipName').val();
        var  EquipType = $('#hEquipType').val();
        var  EquipDHID = $('#hEquipDHID').val();
        var  ip = $('#hip').val();
        var ipno = $('#hipno').val();
        var  Manufacturer = $('#hManufacturer').val();
        var  DepartMent = $('#hDepartMent').combobox("getText");
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
                        $("#hdlgsb").dialog("close");
                        ids = '';
                        query();
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }

    }
    function hupdatedata(){
        var row = $("#hbd").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            ids = row.id;
            if(i=='设备表'){
                var row = $("#hbd").datagrid("getSelected");
                ids = row.id;
                $("#ReturnrReason").css('display', '');
                $('#hEquipid').textbox("setValue",row.equipID);
                $('#hip').textbox("setValue",row.ip);
                $('#hipno').textbox("setValue",row.ipno);
                $('#hEquipName').textbox("setValue",row.equipName);
                $('#hEquipType').textbox("setValue",row.equipType);
                $('#hEquipDHID').textbox("setValue",row.equipDHID);
                $('#hManufacturer').textbox("setValue",row.manufacturer);
                $("#ReturnrReason1").css('display', 'none');
                $("#hdlgsb").dialog({
                    title: '设备表',
                    width: 300,
                    height: 450,
                    modal: true,
                });
                $("#hdlgsb").dialog("open");
            }else if(i=='工艺模板'){
                var row = $("#hbd").datagrid("getSelected");
                ids = row.id;
                alert(ids);
                $('#MBname').textbox("setValue",row.templetname);
                $('#MBid').textbox("setValue",row.templetnum);
                 $('#quenchtemp1').textbox("setValue",row.quenchtemp1);
                $('#quenchtemp1up').textbox("setValue",row.quenchtemp1up);
             $('#quenchtemp1low').textbox("setValue",row.quenchtemp1low);
               $('#quenchtemp2').textbox("setValue",row.quenchtemp2);
            $('#quenchtemp2up').textbox("setValue",row.quenchtemp2up);
              $('#quenchtemp2low').textbox("setValue",row.quenchtemp2low);
               $('#quenchtemp3').textbox("setValue",row.quenchtemp3);
              $('#quenchtemp3up').textbox("setValue",row.quenchtemp3up);
               $('#quenchtemp3low').textbox("setValue",row.quenchtemp3low);
              $('#quenchtemp4').textbox("setValue",row.quenchtemp4);
               $('#quenchtemp4up').textbox("setValue",row.quenchtemp4up);
                $('#quenchtemp4low').textbox("setValue",row.quenchtemp4low);
          $('#quenchtemp5').textbox("setValue",row.quenchtemp5);
             $('#quenchtemp5up').textbox("setValue",row.quenchtemp5up);
                $('#quenchtemp5low').textbox("setValue",row.quenchtemp5low);
               $('#QuenchTime').textbox("setValue",row.quenchtime);
                $('#QuenchTimeup').textbox("setValue",row.quenchtimeup);
              $('#QuenchTimelow').textbox("setValue",row.quenchtimelow);
               $('#CoolTemp').textbox("setValue",row.cooltemp);
                $('#CoolTempup').textbox("setValue",row.cooltempup);
                $('#CoolTemplow').textbox("setValue",row.cooltemplow);
                $('#quenchhard').textbox("setValue",row.quenchhard);
                 $('#quenchhardup').textbox("setValue",row.quenchhardup);
                 $('#quenchhardlow').textbox("setValue",row.quenchhardlow);
               $('#CarbinolF').textbox("setValue",row.carbinolf);
              $('#CarbinolFup').textbox("setValue",row.carbinolfup);
            $('#CarbinolFlow').textbox("setValue",row.carbinolflow);
              $('#Carpotential').textbox("setValue",row.carpotential);
               $('#Carpotentialup').textbox("setValue",row.carpotentialup);
               $('#Carpotentiallow').textbox("setValue",row.carpotentiallow);
                $('#coating').textbox("setValue",row.coating);
                $('#coatingup').textbox("setValue",row.coatingup);
                $('#coatinglow').textbox("setValue",row.coatinglow);
               $('#tempertemp').textbox("setValue",row.tempertemp);
               $('#tempertempup').textbox("setValue",row.tempertempup);
               $('#tempertemplow').textbox("setValue",row.tempertemplow);
               $('#tempertime').textbox("setValue",row.tempertime);
                $('#tempertimeup').textbox("setValue",row.tempertimeup);
                $('#tempertimelow').textbox("setValue",row.tempertimelow);
                $('#temperhard').textbox("setValue",row.temperhard);
               $('#temperhardup').textbox("setValue",row.temperhardup);
                $('#temperhardlow').textbox("setValue",row.temperhardlow);
//                $('#YDYQ').textbox("setValue",row.templetnum);;
//                 $('#YDYQup').textbox("setValue",row.templetnum);;
//                 $('#YDYQlow').textbox("setValue",row.templetnum);;
//              $('#RX').textbox("setValue",row.templetnum);;
//               $('#RXup').textbox("setValue",row.templetnum);;
//                 $('#RXlow').textbox("setValue",row.templetnum);;
                $("#hdlggy").dialog({
                    title: '工艺模板',
                    width:800,
                    height:440,
                    modal: true,
                });
                $("#hdlggy").dialog("open");
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
            url:'${ctxPath }/BasicData/getDepartMent.action',
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
                $('#hbdPlant').combobox('loadData', data);
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
        $("#htree_base").tree({
            url: '${ctxPath }/BasicData/serachA',
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


    function hadddata() {
        $("#hbd").datagrid("clearSelections");
        if(i==""){
            $.messager.alert("温馨提示","选择添加目录!");
        }else {
            hCanceldate();

            if(i=="设备表"){
                getDepartment();
                $("#ReturnrReason").css('display', 'none');
                $("#ReturnrReason1").css('display', '');
                $("#hdlgsb").dialog({
                    title: '设备表',
                    width: 300,
                    height: 450,
                    modal: true,
                });
                $("#hdlgsb").dialog("open");
            }
            if(i=="工艺模板"){
                getDepartment();
                $('#MBname').textbox("setValue",'');
                $('#MBid').textbox("setValue",'');
                $('#quenchtemp1').textbox("setValue",'');
                $('#quenchtemp1up').textbox("setValue",'');
                $('#quenchtemp1low').textbox("setValue",'');
                $('#quenchtemp2').textbox("setValue",'');
                $('#quenchtemp2up').textbox("setValue",'');
                $('#quenchtemp2low').textbox("setValue",'');
                $('#quenchtemp3').textbox("setValue",'');
                $('#quenchtemp3up').textbox("setValue",'');
                $('#quenchtemp3low').textbox("setValue",'');
                $('#quenchtemp4').textbox("setValue",'');
                $('#quenchtemp4up').textbox("setValue",'');
                $('#quenchtemp4low').textbox("setValue",'');
                $('#quenchtemp5').textbox("setValue",'');
                $('#quenchtemp5up').textbox("setValue",'');
                $('#quenchtemp5low').textbox("setValue",'');
                $('#QuenchTime').textbox("setValue",'');
                $('#QuenchTimeup').textbox("setValue",'');
                $('#QuenchTimelow').textbox("setValue",'');
                $('#CoolTemp').textbox("setValue",'');
                $('#CoolTempup').textbox("setValue",'');
                $('#CoolTemplow').textbox("setValue",'');
                $('#quenchhard').textbox("setValue",'');
                $('#quenchhardup').textbox("setValue",'');
                $('#quenchhardlow').textbox("setValue",'');
                $('#CarbinolF').textbox("setValue",'');
                $('#CarbinolFup').textbox("setValue",'');
                $('#CarbinolFlow').textbox("setValue",'');
                $('#Carpotential').textbox("setValue",'');
                $('#Carpotentialup').textbox("setValue",'');
                $('#Carpotentiallow').textbox("setValue",'');
                $('#coating').textbox("setValue",'');
                $('#coatingup').textbox("setValue",'');
                $('#coatinglow').textbox("setValue",'');
                $('#tempertemp').textbox("setValue",'');
                $('#tempertempup').textbox("setValue",'');
                $('#tempertemplow').textbox("setValue",'');
                $('#tempertime').textbox("setValue",'');
                $('#tempertimeup').textbox("setValue",'');
                $('#tempertimelow').textbox("setValue",'');
                $('#temperhard').textbox("setValue",'');
                $('#temperhardup').textbox("setValue",'');
                $('#temperhardlow').textbox("setValue",'');
                $("#hdlggy").dialog({
                    title: '工艺模板',
                    width:800,
                    height:440,
                    modal: true,
                });
                $("#hdlggy").dialog("open");
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
    $("#htree_base").tree({
        onClick:function(node){
            i = node.text;
            query();
        }
    });
    function query () {
        var plant = $('#hbdPlant').combobox('getValue');
        $.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${ctxPath }/BasicData/queryh.action",
            dataType:"json",
            data: {
                name:i,
                plant:plant+"4",
            },
            success:function(data) {
                console.log(data);
                fdata = data;
                    $('#hbd').datagrid({
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
                            {field:'equipID',title:'设备编号',width:'70px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'equipName',title:'设备名称',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'equipType',title:'设备型号',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'equipDHID',title:'设备厂编号',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'manufacturer',title:'生产厂家',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'ip',title:'ip地址',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'ipno',title:'编号',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'departMent',title:'部门',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'plant',title:'事业部',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='设备表'?false:true,},
                            {field:'templetnum',title:'模板编号',width: '80px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'templetname',title:'模板名称',width:'120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp1',title:'淬火1区温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp1st',title:'淬火1区温度标准差',width: '120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp2',title:'淬火2区温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp2st',title:'淬火2区温度标准差',width: '120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp3',title:'淬火3区温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp3st',title:'淬火3区温度标准差',width: '120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp4',title:'淬火4区温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp4st',title:'淬火4区温度标准差',width: '120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp5',title:'淬火5区温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtemp5st',title:'淬火5区温度标准差',width: '120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtime',title:'淬火保温时间',width: '150px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchtimest',title:'淬火保温时间标准差',width: '150px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'carbinolf',title:'甲醇流量',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'carbinolfst',title:'甲醇流量标准差',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'carpotential',title:'碳势',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'carpotentialst',title:'碳势标准差',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchhard',title:'淬火硬度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'quenchhardst',title:'淬火硬度标准差',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'coating',title:'渗层',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'coatingst',title:'渗层标准差',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'cooltemp',title:'淬火介质温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'cooltempst',title:'淬火介质温度标准差',width: '150px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'tempertemp',title:'回火温度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'tempertempst',title:'回火温度标准差',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'tempertime',title:'回火保温时间',width: '180px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'tempertimest',title:'回火保温时间标准差',width: '180px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'temperhard',title:'回火硬度',width: '100px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                            {field:'temperhardst',title:'回火硬度标准差',width: '120px',align:'center',halign: 'center',hidden:i=='工艺模板'?false:true,},
                        ]]
                    })
                    $('#hbd').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

            },

        })
        $('#hbd').datagrid('loadData',{total:0,rows:[]});
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
