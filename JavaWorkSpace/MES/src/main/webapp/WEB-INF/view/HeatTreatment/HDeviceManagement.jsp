<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/6
  Time: 11:35--设备管理
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
    .PZ{
        width:15%;
        height:75%;
    }

    .PX{
        width:90%;
        height:75%;
    }
    .yuanjiao{
        font-family: Arial;
        border: 2px solid #379082;
        border-radius: 20px;
        padding: 20px 20px;
        width: 120px;
        height: 80px;
    }
    .yuanjiao1{
        font-family: Arial;
        border: 2px solid #379082;
        border-radius: 20px;
        padding: 20px 20px;
        width: 120px;
        height: 120px;
    }

    td
    {
        text-align:right;
    }

    .haorooms{
        height: calc(100% - 50px);
    }


    body{
        padding: 0px;
        margin: 0px;
    }
    .labelstyle{
        margin-right: 3px;
    }
    .vw {
        width: 50%;
        height: 50vw;
        background: #ccc;
    }
    #square {
        width: 10px;
        height: 10px;
        background: red;
    }
    #square1 {
        width: 10px;
        height: 10px;
        background: green;
    }
    #square2 {
        width: 10px;
        height: 10px;
        background: yellow;
    }
    #square3 {
        width: 10px;
        height: 10px;
        background: grey;
    }
    #square4 {
        width: 10px;
        height: 10px;
        background: #708090;
    }
    #square5 {
        width: 10px;
        height: 10px;
        background: cadetblue;
    }
</style>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <iframe id="proxy2" style="display:none"></iframe>
        <div class="easyui-panel " title="设备管理
             " data-options="fit:true" >
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 50px;">
                <div class="wu-toolbar-button" >
                </div>
                <div class="wu-toolbar-search" >
                    <table>
                        <tr>
                            <td>
                                <shiro:hasPermission name="/DeviceManagement/install2">
                                    <a href="#" class="easyui-linkbutton"  onclick="install2()" iconCls="icon-vector" style="width: 70px;text-align: left">设置</a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/DeviceManagement/reflash">
                                    <a href="#" class="easyui-linkbutton"  onclick="reflash()" iconCls="icon-search" style="width: 70px;text-align: left">刷新</a>
                                </shiro:hasPermission>
                            </td>
                            <td align="center">
                                <label style="font-size: 20px;margin-left: 500px;">当前时间：</label> <a id="pdivBottom" style="width: auto;height: 50px;vertical-align:middle;font-size: 20px;text-align: right"></a></td>
                        </tr>
                    </table>

                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="PZ" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <br>
                        <label><span class="m3">事业部：</span></label>
                        <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="pdmPlant" panelHeight="auto" data-options="
                                valueField:'plant',
                                textField:'plant',
                                panelHeight:'250'"
                                style="width:100px">
                        </select>
                        <br>
                        <br>
                        <hr/>
                        <ul id="tree_menu1" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="PX"  data-options="region:'east',split:true" style="text-align: left" >
                    <div style="height: 2px"></div>
                    <div style="text-align: left">
                        运行状态: 运行：<input id="square1" />  停机：<input id="square2" />
                        关机：<input id="square3" /> 故障：<input id="square" /> 未知：<input id="square4" />
                        未启用：<input id="square5"/>
                    </div>
                    <hr/>
                    <div style="height: 10px"></div>
                    <div id="PZT" style="height: 20px;width: auto;text-align:justify;">
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;">总台数：</label><span id="pzts"style="width: auto;vertical-align:middle;height: 100px;font-size: 20px;">0</span>&nbsp&nbsp&nbsp
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;">运行：</label><span id="pyx" style="width: auto;height: 100px;vertical-align:middle;font-size: 20px">0</span>&nbsp&nbsp&nbsp
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;">停机：</label><span id="ptj" style="width: auto;height: 100px;vertical-align:middle;font-size: 20px">0</span>&nbsp&nbsp&nbsp
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;">关机：</label><span id="pgj" style="width: auto;height: 100px;vertical-align:middle;font-size: 20px">0</span>&nbsp&nbsp&nbsp
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;"> 故障：</label><span id="pgz" style="width: auto;height: 100px;vertical-align:middle;font-size: 20px">0</span>&nbsp&nbsp&nbsp
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;">未知：</label><span id="pwz" style="width: auto;height: 100px;vertical-align:middle;font-size: 20px">0</span>&nbsp&nbsp&nbsp
                        <label style="font-size: 18px;vertical-align:middle;display:inline-block;">未启用：</label><span id="pwqy" style="width: auto;height: 100px;vertical-align:middle;font-size: 20px">0</span>&nbsp&nbsp&nbsp
                    </div>
                    <hr />
                    <div id="pshebei" style="width: 1000px">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlgdm" class="easyui-dialog"  title="设备基础数据设置" style="width:400px; height: 280px;  padding: 10px;"
     closed="true" buttons="#dlgdm-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        设备基础数据设置
    </div>
    <form id="fmsave" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td>设备状态刷新时间：<input name="Infname" id="Outfname" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>设备数据读取间隔：<input name="Inlocation"  id="Outlocation1" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>
                <tr>
                    <td>停机报警间隔时间：<input name="Inlocation"  id="Outlocation" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                </tr>

            </table>

        </div>

    </form>
</div>
<div id="dlgdm-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="OtherSave()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlgpdsave').dialog('close')" iconcls="icon-cancel">取消</a>
</div>
<script type="text/javascript">
    var i;
    function reflash() {
        if(i=='零件车间'){
            document.getElementById('pshebei').innerHTML='';
            var date=new Date();
            var year = date.getFullYear();
            var month = date.getMonth()+1;
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/DeviceManagement/DeviceInfo.action',
            dataType: "json",
            data: {
                plant : $('#pdmPlant').combobox('getText'),
                department:  i,
                year:year,
                month:month,
            },
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                    var num = data[0].num;
                    var s  = data[0].total;
                    console.log(num);
                    var noApplicationRecord = document.getElementById('pshebei');
                    var html='';
                    var a =0;
                    var b ='';
                    var c ='';
                    for(var j=0;j<num;j++){
                        var  a=data[j].EquipID;
                        var  b=data[j].DatePower;
                        var  c=data[j].FactNum;
                        console.log(c);
                        var status = data[j].EquipStatus;
                        if(status=="SB01"){
                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB02"){
                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:yellow; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB03"){
                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:grey; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB04"){
                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:red; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB05"){
                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:#708090; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB06"){
                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:cadetblue; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                        }
                        else{
                            html+=divTemp;
                        }
                        noApplicationRecord.innerHTML=html;

                    }
                    //IDs,即为所有有id的span的字串
                    $('#pzts').html(data[0].num);
                    $('#pyx').html(data[s].a);
                    $('#ptj').html(data[s].b);
                    $('#pgj').html(data[s].c);
                    $('#pgz').html(data[s].d);
                    $('#pwz').html(data[s].e);
                    $('#pwqy').html(data[s].f);
            }
        });
        }else if(i=='热处理车间'){
            document.getElementById('pshebei').innerHTML='';
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/DeviceManagement/DeviceInfoH.action',
                dataType: "json",
                data: {
                    plant : $('#pdmPlant').combobox('getText'),
                    department:  i,
                },
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    console.log(data);
                        var num = data[0].num;
                        var s  = data[0].total;
                        console.log(num);
                        var noApplicationRecord = document.getElementById('pshebei');
                        var html='';
                        var a =0;
                        var b ='';
                        var c ='';
                    for(var j=0;j<num;j++){
                        var  a=data[j].EquipID;
                        var  b=data[j].quenchtemp3;
                        var  c=data[j].tempertemp2;
                        var  d=data[j].carpotential;
                        var  e=data[j].cooltemp;
                        var status = data[j].EquipStatus;
                        if(status=="SB01"){
                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB02"){
                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB03"){
                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB04"){
                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB05"){
                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                            html+=divTemp;
                        }else if(status=="SB06"){
                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                        }
                        else{
                            html+=divTemp;
                        }
                        noApplicationRecord.innerHTML=html;

                    }
                        //IDs,即为所有有id的span的字串
                        $('#pzts').html(data[0].num);
                        $('#pyx').html(data[s].a);
                        $('#ptj').html(data[s].b);
                        $('#pgj').html(data[s].c);
                        $('#pgz').html(data[s].d);
                        $('#pwz').html(data[s].e);
                        $('#pwqy').html(data[s].f);
                    }


            });
        }
    }
    function date()
    {
        var date=new Date();
        var year=date.getFullYear();
        var month=date.getMonth()+1;
        var day=date.getDate();
        var hour="00"+date.getHours();
        hour=hour.substr(hour.length-2);
        var minute="00"+date.getMinutes();
        minute=minute.substr(minute.length-2);
        var second="00"+date.getSeconds();
        second=second.substr(second.length-2);
        document.getElementById("pdivBottom").innerHTML=year+"年"+month+"月"+day+"日"+" "+hour+":"+minute+":"+second+" ";
    }
    setInterval("date()",1000);


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
                $('#pdmPlant').combobox('loadData', data);
                //alert(11111);

            }
        });

        $(document).click(function(e){

            $("#trt_More").hide();

        });

//树形结构
        //加载全部节点
        $("#tree_menu1").tree({
            type:"post",
            url: '${ctxPath }/DeviceManagement/query1?param1='+localStorage.getItem("Department"),
            queryParams: { },
            onBeforeExpand:function(node,param){
            },
            animate:true,
            lines:true,
            onClick: function (node) {
                i = node.text;

                $(document).ready(function(){
                    if(i=='零件车间'){
                        var date=new Date();
                        var year = date.getFullYear();
                        var month = date.getMonth()+1;
                        document.getElementById('pshebei').innerHTML='';
                        jQuery.ajax({
                            type: "POST",   //post提交方式默认是get
                            url:'${ctxPath }/DeviceManagement/DeviceInfo.action',
                            dataType: "json",
                            data: {
                                plant : $('#pdmPlant').combobox('getText'),
                                department:  i,
                                year:year,
                                month:month,
                            },
                            error: function (request) {      // 设置表单提交出错
                                $("#showMsg").html(request);  //登录错误提示信息

                            },
                            success: function (data) {
                                console.log(data);
                                var num = data[0].num;
                                var s  = data[0].total;
                                console.log(num);
                                var noApplicationRecord = document.getElementById('pshebei');
                                var html='';
                                var a =0;
                                var b ='';
                                var c ='';
                                for(var j=0;j<num;j++){
                                    var  a=data[j].EquipID;
                                    var  b=data[j].DatePower;
                                    var  c=data[j].FactNum;
                                    console.log(c);
                                    var status = data[j].EquipStatus;
                                    if(status=="SB01"){
                                        var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB02"){
                                        var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:yellow; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB03"){
                                        var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:grey; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB04"){
                                        var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:red; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB05"){
                                        var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:#708090; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB06"){
                                        var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:cadetblue; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                    }
                                    else{
                                        html+=divTemp;
                                    }
                                    noApplicationRecord.innerHTML=html;

                                }
                                //IDs,即为所有有id的span的字串
                                $('#pzts').html(data[0].num);
                                $('#pyx').html(data[s].a);
                                $('#ptj').html(data[s].b);
                                $('#pgj').html(data[s].c);
                                $('#pgz').html(data[s].d);
                                $('#pwz').html(data[s].e);
                                $('#pwqy').html(data[s].f);
                            }
                        });
                    }else if(i=='热处理车间'){
                        document.getElementById('pshebei').innerHTML='';
                        jQuery.ajax({
                            type: "POST",   //post提交方式默认是get
                            url:'${ctxPath }/DeviceManagement/DeviceInfoH.action',
                            dataType: "json",
                            data: {
                                plant : $('#pdmPlant').combobox('getText'),
                                department:  i,
                            },
                            error: function (request) {      // 设置表单提交出错
                                $("#showMsg").html(request);  //登录错误提示信息

                            },
                            success: function (data) {
                                console.log(data);
                                var num = data[0].num;
                                var s  = data[0].total;
                                console.log(num);
                                var noApplicationRecord = document.getElementById('pshebei');
                                var html='';
                                var a =0;
                                var b ='';
                                var c ='';
                                for(var j=0;j<num;j++){
                                    var  a=data[j].EquipID;
                                    var  b=data[j].quenchtemp3;
                                    var  c=data[j].tempertemp2;
                                    var  d=data[j].carpotential;
                                    var  e=data[j].cooltemp;
                                    var status = data[j].EquipStatus;
                                    if(status=="SB01"){
                                        var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB02"){
                                        var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB03"){
                                        var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB04"){
                                        var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB05"){
                                        var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                        html+=divTemp;
                                    }else if(status=="SB06"){
                                        var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                            "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                            +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                            "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                            "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                    }
                                    else{
                                        html+=divTemp;
                                    }
                                    noApplicationRecord.innerHTML=html;

                                }
                                //IDs,即为所有有id的span的字串
                                $('#pzts').html(data[0].num);
                                $('#pyx').html(data[s].a);
                                $('#ptj').html(data[s].b);
                                $('#pgj').html(data[s].c);
                                $('#pgz').html(data[s].d);
                                $('#pwz').html(data[s].e);
                                $('#pwqy').html(data[s].f);
                            }


                        });
                    }
                })
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
        function showtime()//创建函数
        {
            var nowTime = new Date();//创建时间对象实例
            var hours = nowTime.getHours();//获取当前小时数
            var minutes = nowTime.getMinutes();//获取当前分钟数
            var seconds = nowTime.getSeconds();//获取当前秒数
            var timer = " "+((hours>12)?hours-12:hours);//将小时数质赋予变量timer
            timer +=((minutes<10)?"0:":":")+minutes;//将分钟数值赋予变量timer
            timer += ((seconds<10)?"0:":":")+seconds;//将秒数值赋予变量timer
            timer +=" "+((hours>12)?"pm":"am");//将字符am或pm赋予变量timer
            document.getElementById('clock').innerHTML =timer;
            setTimeout("showtime()",1000);
        }

    });
    $("#pdmPlant").combobox({
        onChange: function (n,o) {
            $("#tree_menu1").tree({
                url: '${ctxPath }/DeviceManagement/query1?param1='+n,
                queryParams: { },
                onBeforeExpand:function(node,param){

                },
                animate:true,
                lines:true,
                onClick: function (node) {
                    //右侧跳转到指定页面
//                addTab(node.text,node.menuUrl);
                    $(document).ready(function(){
                        i=node.text;
                        document.getElementById('pshebei').innerHTML='';
                        if(i=='零件车间'){
                            var date=new Date();
                            var year = date.getFullYear();
                            var month = date.getMonth()+1;
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/DeviceManagement/DeviceInfo.action',
                                dataType: "json",
                                data: {
                                    plant : $('#pdmPlant').combobox('getText'),
                                    department:  i,
                                    year:year,
                                    month:month,
                                },
                                error: function (request) {      // 设置表单提交出错
                                    $("#showMsg").html(request);  //登录错误提示信息

                                },
                                success: function (data) {
                                    console.log(data);
                                    var num = data[0].num;
                                    var s  = data[0].total;
                                    console.log(num);
                                    var noApplicationRecord = document.getElementById('pshebei');
                                    var html='';
                                    var a =0;
                                    var b ='';
                                    var c ='';
                                    for(var j=0;j<num;j++){
                                        var  a=data[j].EquipID;
                                        var  b=data[j].DatePower;
                                        var  c=data[j].FactNum;
                                        console.log(c);
                                        var status = data[j].EquipStatus;
                                        if(status=="SB01"){
                                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB02"){
                                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:yellow; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB03"){
                                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:grey; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB04"){
                                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:red; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB05"){
                                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:#708090; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB06"){
                                            var  divTemp ="<div  class='yuanjiao'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:cadetblue; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >能耗：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "产量：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span></div>";
                                        }
                                        else{
                                            html+=divTemp;
                                        }
                                        noApplicationRecord.innerHTML=html;

                                    }
                                    //IDs,即为所有有id的span的字串
                                    $('#pzts').html(data[0].num);
                                    $('#pyx').html(data[s].a);
                                    $('#ptj').html(data[s].b);
                                    $('#pgj').html(data[s].c);
                                    $('#pgz').html(data[s].d);
                                    $('#pwz').html(data[s].e);
                                    $('#pwqy').html(data[s].f);
                                }
                            });
                        }else if(i=='热处理车间'){
                            document.getElementById('pshebei').innerHTML='';
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/DeviceManagement/DeviceInfoH.action',
                                dataType: "json",
                                data: {
                                    plant : $('#pdmPlant').combobox('getText'),
                                    department:  i,
                                },
                                error: function (request) {      // 设置表单提交出错
                                    $("#showMsg").html(request);  //登录错误提示信息

                                },
                                success: function (data) {
                                    console.log(data);
                                    var num = data[0].num;
                                    var s  = data[0].total;
                                    console.log(num);
                                    var noApplicationRecord = document.getElementById('pshebei');
                                    var html='';
                                    var a =0;
                                    var b ='';
                                    var c ='';
                                    for(var j=0;j<num;j++){
                                        var  a=data[j].EquipID;
                                        var  b=data[j].quenchtemp3;
                                        var  c=data[j].tempertemp2;
                                        var  d=data[j].carpotential;
                                        var  e=data[j].cooltemp;
                                        var status = data[j].EquipStatus;
                                        if(status=="SB01"){
                                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB02"){
                                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB03"){
                                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB04"){
                                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB05"){
                                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                            html+=divTemp;
                                        }else if(status=="SB06"){
                                            var  divTemp ="<div  class='yuanjiao1'  style='margin: 20px 20px 20px 30px;text-align: center;font-size: 15px;background:green; float:left; display:inline'>" +
                                                "<span style='font-size: 20px;height: 20px;text-align: left'  >"+a+"</span><br><br>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'"
                                                +" >淬火：</label><span style='font-size: 15px;height: 10px;vertical-align:middle;' >"+b+"" +
                                                "</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "回火：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+c+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "碳势：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+d+"</span>"+"<label class='three'style='font-size: 15px;height: 10px;vertical-align:middle;'><br><br>"+
                                                "油温：</label><span style='font-size: 17px;height: 10px;vertical-align:middle;' >"+e+"</span></div>";
                                        }
                                        else{
                                            html+=divTemp;
                                        }
                                        noApplicationRecord.innerHTML=html;

                                    }
                                    //IDs,即为所有有id的span的字串
                                    $('#pzts').html(data[0].num);
                                    $('#pyx').html(data[s].a);
                                    $('#ptj').html(data[s].b);
                                    $('#pgj').html(data[s].c);
                                    $('#pgz').html(data[s].d);
                                    $('#pwz').html(data[s].e);
                                    $('#pwqy').html(data[s].f);
                                }


                            });
                        }
                    })
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
    function install2() {
        $("#dlgdm").dialog("open");
    }
</script>

