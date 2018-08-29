<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/6
  Time: 10:26 工艺文档添加
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script type="text/javascript" src="${ctxPath }/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctxPath }/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>
<style>
    .easyui-panel {
        width: 100%;
        height: 66%;
    }


    .A{
        width:100%;
        height:75%;
    }
    .divmore{
        margin-left: -5px;
        padding: 10px 10px 10px 10px;
        /*border: 1px solid red;*/
        border-right: 1px solid #E0EEEE;
        border-bottom: 1px solid #E0EEEE;
    }
    .datagrid-row-selected {

        color: #1A1A1A;
        font-weight:bold;
        font-size: 300%;
    }
    .C{
        width:44%;
        height:75%;
    }
    .ti9{
        letter-spacing:0.17em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-0.13em; /*同上*/
    }
    .ti10{
        letter-spacing:0.4em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-0.1em; /*同上*/
    }
    .ti3{
        letter-spacing:1.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        /*margin-ttright:-1.25em; !*同上*!*/
    }
    .pp2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .pp1{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .ti5{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.1em; /*同上*/
    }
    .ti6{
        letter-spacing:0.85em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.1em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 70px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<html>
<body class="easyui-layout">
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="热处理工艺模板维护" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:70px">
            <div class="wu-toolbar-button">
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label>零件图号：</label>&nbsp<input id="partDrawing" name="partDrawing" data-options="events:{blur:checkLoginName},validType:'partDrawing',required:true"   class="easyui-textbox" style="width:176px">&nbsp</td>
                        <td><label>图号名称：</label><input id="partname" class="easyui-textbox" style="width:140px" disabled readonly>&nbsp</td>
                    </tr>
                    <tr>
                        <td><label>模板名称：</label> <select class="easyui-combobox" name="MBname" style="width:176px" datatype="text" id="MBname" panelHeight="auto" data-options="
                                valueField:'templetname',
                                textField:'templetname',
                                panelHeight:'250'"
                                                         style="width:176px">
                        </select> </td>
                        <td><label>模板编号：</label><input id="MBid" class="easyui-textbox" style="width:140px" disabled readonly>&nbsp</td>
                    </tr>
                </table>
            </div>
        </div>
        <hr>
         <div style="float:left;text-align: center">
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火一区温度：</label><input id="quenchtemp1" class="easyui-textbox" readonly style="width:50%" disabled><br>
             <input type="text" style="height:20px;border: 0px;outline:none;"><br>
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火二区温度：</label><input id="quenchtemp2" class="easyui-textbox" readonly style="width:50%" disabled><br>
             <input type="text" style="height:20px;border: 0px;outline:none;"><br>
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火三区温度：</label><input id="quenchtemp3" class="easyui-textbox" readonly style="width:50%" disabled> <br>
             <input type="text" style="height:20px;border: 0px;outline:none;"><br>
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火四区温度：</label><input id="quenchtemp4" class="easyui-textbox" readonly style="width:50%" disabled><br>
             <input type="text" style="height:20px;border: 0px;outline:none;"><br>
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火五区温度：</label><input id="quenchtemp5" class="easyui-textbox" readonly style="width:50%" disabled><br>
             <input type="text" style="height:20px;border: 0px;outline:none;"><br>
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火保温时间：</label><input id="quenchtime" class="easyui-textbox" readonly style="width:50%" disabled><br>
             <input type="text" style="height:20px;border: 0px;outline:none;"><br>
             <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
             <label>淬火介质温度：</label><input id="cooltemp" class="easyui-textbox" readonly style="width:50%" disabled><br>
         </div>
        <div style="height:75%; width:1px; border-left:1px  solid;float:left;margin-left: 10%;color: grey" ></div>
        <div style="float:left">
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label><span class="pp2">碳势</span>：</label><input id="carpotential" class="easyui-textbox" readonly style="width:50%" disabled><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label><span class="pp2">渗层</span>：</label><input id="coating" class="easyui-textbox" readonly style="width:50%" disabled><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label><span class="pp1">渗碳硬度</span>：</label><input id="quenchhard" class="easyui-textbox" readonly style="width:50%" disabled><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label><span class="pp1">回火温度</span>：</label><input id="tempertemp" class="easyui-textbox" readonly style="width:50%" disabled><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label><span class="pp1">甲醇流量</span>：</label><input id="carbinolf" class="easyui-textbox" readonly style="width:50%" disabled><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label><span class="pp1">回火硬度</span>：</label><input id="temperhard" class="easyui-textbox" readonly style="width:50%" disabled><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <input type="text" style="width:10px;border: 0px;outline:none;height: 100%">
            <label>回火保温时间：</label><input id="tempertime" class="easyui-textbox" readonly style="width:50%" disabled><br>

        </div>
    </div>
</div>

<script type="text/javascript">
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
    var name = localStorage.getItem("User");
    var ids = '';
    function ProductionProcessEditCancel() {
        parent.$.modalDialog.handler.dialog('close');
    }
    $(function () {
       getPlant();
    })
    function getPlant() {
        $.ajax({
            type:"post",
            url: "${ctxPath}/ProductionProcess/getMB.action",//要发送的后台地址
            data:{
                plant: localStorage.getItem("Department")
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data1) {//ajax请求成功后触发的方法
                console.log(data1);
                $('#MBname').combobox('loadData', data1);

                var row = $("#ppid").datagrid("getSelected");
                ids = row.id;
                if(ids!=''){
                    $('#partname').textbox("setValue",row.partname);
                    $('#partDrawing').textbox("setValue",row.partdrawing);
                    $('#MBname').textbox("setValue",row.templetname);
                    $('#MBid').textbox("setValue",row.templetnum);
                    $('#quenchtemp1').textbox("setValue",row.quenchtemp1);
                    $('#quenchtemp2').textbox("setValue",row.quenchtemp2);
                    $('#quenchtemp3').textbox("setValue",row.quenchtemp3);
                    $('#quenchtemp4').textbox("setValue",row.quenchtemp4);
                    $('#quenchtemp5').textbox("setValue",row.quenchtemp5);
                    $('#quenchtime').textbox("setValue",row.quenchtime);
                    $('#cooltemp').textbox("setValue",row.cooltemp);
                    $('#carpotential').textbox("setValue",row.carpotential);
                    $('#coating').textbox("setValue",row.coating);
                    $('#quenchhard').textbox("setValue",row.quenchhard);
                    $('#tempertemp').textbox("setValue",row.tempertemp);
                    $('#carbinolf').textbox("setValue",row.carbinolf);
                    $('#temperhard').textbox("setValue",row.temperhard);
                    $('#tempertime').textbox("setValue",row.tempertime);
                }else {

                }

            },
        })
    }
    $('#MBname').combobox({
        onChange:function (newValue, oldValue) {
            $.ajax({
                type:"post",
                url: "${ctxPath}/ProductionProcess/getTempletnum.action",//要发送的后台地址
                data:{
                    templetname:newValue,
                    plant: localStorage.getItem("Department")
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                        $('#MBid').textbox("setValue",data1.Templetnum);
                        $('#quenchtemp1').textbox("setValue",data1.QuenchTemp1);
                        $('#quenchtemp2').textbox("setValue",data1.QuenchTemp2);
                        $('#quenchtemp3').textbox("setValue",data1.QuenchTemp3);
                        $('#quenchtemp4').textbox("setValue",data1.QuenchTemp4);
                        $('#quenchtemp5').textbox("setValue",data1.QuenchTemp5);
                        $('#quenchtime').textbox("setValue",data1.QuenchTime);
                        $('#cooltemp').textbox("setValue",data1.CoolTemp);
                        $('#carpotential').textbox("setValue",data1.Carpotential);
                        $('#coating').textbox("setValue",data1.Coating);
                        $('#quenchhard').textbox("setValue",data1.QuenchHard);
                        $('#tempertemp').textbox("setValue",data1.TemperTemp);
                        $('#carbinolf').textbox("setValue",data1.CarbinolF);
                        $('#temperhard').textbox("setValue",data1.TemperHard);
                        $('#tempertime').textbox("setValue",data1.TemperTime);
                },
            })
        }
    })
    var partDrawing = '';
    function checkLoginName(e){
        var inputValueName = $(this).next("input").attr("name");
        if( inputValueName!='') {
            if(inputValueName == "partDrawing"){
                partDrawing = this.value;
            }
        }
        if(partDrawing==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/LookSame.action",//要发送的后台地址
                data:{
                    partDrawing:partDrawing,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        $('#partname').textbox("setValue",data1.projectname);
                    }else {
                        $('#partname').val("");
                        $('#partDrawing').val("");
                        $.messager.alert('温馨提示', '此图号名称不存在');

                    }

                },
            })
        }

    }
    function Insert  () {
        var partDrawing = $('#partDrawing').val();
        var partname = $('#partname').val();
        var MBid = $('#MBid').val();
        var MBname = $('#MBname').combobox('getValue');
        $.ajax({
            type:"post",
            url: "${ctxPath}/ProductionProcess/Juge.action",//要发送的后台地址
            data:{
                partDrawing:partDrawing,
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data1) {//ajax请求成功后触发的方法
                console.log(data1);
                if(data1.num>0){
                    $.messager.alert('温馨提示', '此图号存在!!!');
                }else {
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/ProductionProcess/Insert.action",//要发送的后台地址
                        data:{
                            plant: localStorage.getItem("Department"),
                            time:time,
                            name:name,
                            partDrawing:partDrawing,
                            partname:partname,
                            MBid:MBid,
                            MBname:MBname,
                            ids:ids,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if(data1.num>0){
                                $.messager.alert('温馨提示', '保存成功!!!');
                                ProductionProcessEditCancel();
                                ppquery();
                            }else {
                                $.messager.alert('温馨提示', '保存失败!!!');
                            }

                        },
                    })
                }

            },
        })

    }
</script>
</body>
</html>
