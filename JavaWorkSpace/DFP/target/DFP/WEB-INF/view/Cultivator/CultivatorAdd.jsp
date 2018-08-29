<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-06-15
  Time: 10:25
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
    .ti2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-2em; /*同上*/
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
        height: calc(100% - 60px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<html>
<body class="easyui-layout">
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="新增合格证" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:60px">
            <div class="wu-toolbar-button">
                <div id="test4"><input  id ="qadb" style="width:110px" class="easyui-text" hidden="hidden"></div>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label>工厂：</label><select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="CWERKS1" panelHeight="auto" data-options="
                                valueField:'statusid',
                                textField:'statusname',
                                panelHeight:'250'"
                                                      style="width:100px">
                        </select></td>
                        <td><label>生产订单号：</label><input id="CAUFNR1" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>序列号：</label><input id="CZSERI1" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>起始检验日期：</label><input id="CZJYRQBEGIN1" class="easyui-datebox" style="width:100px">&nbsp</td>
                        <td><label>检验结束日期：</label><input  id ="CZJYRQEND1" style="width:110px" class="easyui-datebox"></td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="c_spaquery()" data-options="iconCls:'icon-search'" id="button2">查询</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true,border:true" >
                <table id="table" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
            </div>
        </div>
    </div>
</div>
<div id="dlgcj" class="easyui-dialog"  title="固定项" style="width:55%; height: 60%;  padding: 10px;"
     closed="true" buttons="#dlgcj-buttons">
    <form id="fmsave1" method="post">
        <div class="wu-toolbar-search" style="white-space:nowrap;margin-top: 1%;text-align: left">
            <label>机型：</label><input id="JX1" class="easyui-textbox"  style="width:15%"><a href="#" class="easyui-linkbutton"  onclick="Find1()" data-options="iconCls:'icon-search'" id="button3">查询</a><label>当前第</label><span id="DQT1"  style="width:5%;text-align: center ;margin-bottom: 1%"></span><label>条</label><br>
            <label><span class="ci2">序列号</span>：</label><input id="CserialNum" class="easyui-textbox" readonly style="width:200px;text-align: left">&nbsp&nbsp&nbsp&nbsp<label>产品料号：</label><input id="CProductNum" class="easyui-textbox" readonly style="width:200px;">&nbsp<br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ci3">出厂编号</span>：</label><input id="CFactoryID" readonly class="easyui-textbox" style="width:200px">&nbsp&nbsp&nbsp&nbsp<label>功率/KW：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="CPower" panelHeight="auto" data-options="
        required:'true',
                                valueField:'Power',
                                textField:'Power',
                                panelHeight:'250'"

                    style="width:196px"></select>
            <br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ci5">发动机型号</span>：</label><select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="CZCHYJ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'ZCHYJ',
                                textField:'ZCHYJ',
                                panelHeight:'250'"
                                                                  style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>轨距/mm：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="Gauge" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'Gauge',
                                textField:'Gauge',
                                panelHeight:'250'"
                    style="width:196px"></select><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ci6">割台宽度/mm</span>：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="CutWidth" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'base',
                                textField:'base',
                                panelHeight:'250'"
                    style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>履带规格：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="TrackType" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'TrackType',
                                textField:'TrackType',
                                panelHeight:'250'"
                    style="width:196px"></select> <br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ci9">喂入量（kg/s）/行数</span>：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="FeedVolume" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'force',
                                textField:'force',
                                panelHeight:'250'"
                    style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>外廓尺寸：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="COutlineSize" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'OutlineSize',
                                textField:'OutlineSize',
                                panelHeight:'250'"
                    style="width:196px"></select><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label>联合收割（获）机质量/kg：</label>
            <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="HarMachQuy" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'MinUse',
                                textField:'MinUse',
                                panelHeight:'250'"
                    style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>生产日期：</label><input id="CManufactureDate" class="easyui-datebox" style="width:200px" data-options="required:true">&nbsp<br>
            <div style="text-align: right;margin-top: 2%">
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="CBack()" iconcls="icon-undo" id="CBack">上一条</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="CGOS()" iconcls="icon-redo" id="CGO">下一条</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="CAdd1()" iconcls="icon-save">保存</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Cancelda3()" iconcls="icon-cancel">取消</a>
            </div>
        </div>

    </form>


</div>

<script type="text/javascript">
    $("#test4" ).css("display", "none");
    var InspectionDate1='';
    var plant2='';
    var CDQH='';
    var Zfdjh1 = '';
    var AUFNR1 = '';
    var ZMACH = '';
    var ids = '';
    var idb = '';
    var CS = '';
    var name = '';
    $(function () {

        var db = $('#qadb');
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
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/queryUser.action',
            dataType: "json",
            data: {
                user:localStorage.getItem("User")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                name= data[0].name;
            }
        });
        getGC2();//获取工厂
    });
    function CultivatorAddCancel() {
        parent.$.modalDialog.handler.dialog('close');

    }
    function Cancelda3() {
        $("#dlgcj").dialog("close");
        $('#button2').linkbutton('enable');
    }
    var ZSERI  = '';
    function CBack() {
        $('#CGO').linkbutton('enable');
        $('#fmsave1').form('clear');
        $('#CPower').combobox('loadData', {});//清空option选项
        $('#CZCHYJ').combobox('loadData', {});//清空option选项
        $('#Gauge').combobox('loadData', {});//清空option选项
        $('#CutWidth').combobox('loadData', {});//清空option选项
        $('#TrackType').combobox('loadData', {});//清空option选项
        $('#FeedVolume').combobox('loadData', {});//清空option选项
        $('#COutlineSize').combobox('loadData', {});//清空option选项
        $('#HarMachQuy').combobox('loadData', {});//清空option选项
        var  cback = --CDQH ;
        if(cback>-1){
            var rows = $('#table').datagrid('getRows');
            var row = rows[cback];//根据index获得其中一行。
            document.getElementById('DQT1').innerText=cback+1;
            var ZSERI = row.ZSERI;
            var ProductNum =  row.PLNBEZ;
            if(row.ZMACH!=''){
                $('#JX1').textbox('setValue',row.ZMACH);
                $('#button2').linkbutton('disable');
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#CserialNum').textbox('setValue',ZSERI);
                $('#CProductNum').textbox('setValue',row.PLNBEZ);
                $('#CFactoryID').textbox('setValue',ZSERI);
                $("#dlgcj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgcj').dialog("open");
            }else {
                $('#JX1').textbox('setValue','');
                $('#button2').linkbutton('disable');
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#CserialNum').textbox('setValue',ZSERI);
                $('#CProductNum').textbox('setValue',ProductNum);
                $('#CFactoryID').textbox('setValue',ZSERI);
                $("#dlgcj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgcj').dialog("open");
            }

        }else {
            $('#CBack').linkbutton('disable');
            CGOS();
        }

    }
    function CGOS() {
        $('#CBack').linkbutton('enable');
        $('#fmsave1').form('clear');
        $('#CPower').combobox('loadData', {});//清空option选项
        $('#CZCHYJ').combobox('loadData', {});//清空option选项
        $('#Gauge').combobox('loadData', {});//清空option选项
        $('#CutWidth').combobox('loadData', {});//清空option选项
        $('#TrackType').combobox('loadData', {});//清空option选项
        $('#FeedVolume').combobox('loadData', {});//清空option选项
        $('#COutlineSize').combobox('loadData', {});//清空option选项
        $('#HarMachQuy').combobox('loadData', {});//清空option选项
        var  cgo = ++CDQH ;
        var rows = $('#table').datagrid('getRows');
        if(cgo<rows.length){
            var row = rows[cgo];//根据index获得其中一行。
            ProductNum =  row.PLNBEZ;
            document.getElementById('DQT1').innerText=cgo+1;
            ZMACH = row.ZMACH;
            Zfdjh = row.ZFDJH;
            AUFNR = row.AUFNR;
            if(row.ZMACH!=''){
                $('#JX1').textbox('setValue',row.ZMACH);
                $('#button2').linkbutton('disable');
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#CserialNum').textbox('setValue',ZSERI);
                $('#CProductNum').textbox('setValue',row.PLNBEZ);
                $('#CFactoryID').textbox('setValue',ZSERI);
                $("#dlgcj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgcj').dialog("open");
            }else {
                $('#JX1').textbox('setValue','');
                $('#button2').linkbutton('disable');
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#CserialNum').textbox('setValue',ZSERI);
                $('#CProductNum').textbox('setValue',ProductNum);
                $('#CFactoryID').textbox('setValue',ZSERI);
                $("#dlgcj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgcj').dialog("open");
            }


        }else {
            $('#CGO').linkbutton('disable');
            CBack();
        }

    }
    function  CAdd1() {
        var serialNum = $('#CserialNum').val();
        var ProductNum = $('#CProductNum').val();
        var ZCHYJ = $('#CZCHYJ').combobox('getText');
        var Power = $('#CPower').combobox('getText');
        var FactoryID = $('#CFactoryID').val();
        var Gauge = $('#Gauge').combobox('getText');
        var CutWidth = $('#CutWidth').combobox('getText');
        var FeedVolume = $('#FeedVolume').combobox('getText');
        var TrackType = $('#TrackType').combobox('getText');
        var COutlineSize = $('#COutlineSize').combobox('getText');
        var HarMachQuy = $('#HarMachQuy').combobox('getText');
        var CManufactureDate = $('#CManufactureDate').datebox('getValue');
        var plant = $('#CWERKS1').combobox('getValue');
        var plant1 = $('#CWERKS1').combobox('getText');
        var SSS = $('#JX1').val();
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var month = '';
        if(umouth.length>2){
            month = umouth;
        }else {
            month = "0"+umouth;
        }
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var  Certdate = uyear+"-"+umouth+"-"+uday;
        if(SSS!=''&&serialNum!=''&& ProductNum!=''&& ZCHYJ!=''&& Power!=''&& FactoryID!=''&& Gauge!=''
            && CutWidth!=''&& FeedVolume!=''&& TrackType!=''&& COutlineSize!=''&& HarMachQuy!=''&&CManufactureDate!=''){
            $.ajax({
                type:"post",
                url: "${pageContext.request.contextPath}/Cultivator/Juge.action",//要发送的后台地址
                data:{
                    ZSERI:serialNum,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        var row = new Array();
                        row = data1.rows;
                        idb = row[0].id;
                        $.ajax({
                            type: "post",//数据发送的方式（post 或者 get）
                            url: "${pageContext.request.contextPath}/Cultivator/insert.action",//要发送的后台地址
                            data: {
                                serialNum:serialNum,
                                ProductNum:ProductNum,
                                ZCHYJ:ZCHYJ,
                                Power:Power,
                                Zfdjh:Zfdjh1,
                                ZMACH:ZMACH,
                                AUFNR:AUFNR1,
                                ZJYRQ:ZJYRQ,
                                OutlineSize:COutlineSize,
                                TrackType:TrackType,
                                FactoryID:FactoryID,
                                Gauge:Gauge,
                                CutWidth:CutWidth,
                                FeedVolume:FeedVolume,
                                HarMachQuy:HarMachQuy,
                                CManufactureDate:CManufactureDate,
                                time:time,
                                plant:plant,
                                plant1:plant1,
                                user: name,
                                ids:idb,
                                Certdate:Certdate
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    if(CS=='1'){
                                        $.messager.alert('温馨提示', '保存成功');
                                        InspectionDate1 = uyear+"-"+month+"-"+uday+" 00:00:00";
                                        plant2 = $('#CWERKS1').combobox('getText');
                                        c_query();
                                        ids='';
                                        getGC2();
                                    }else {
                                        $.messager.alert('温馨提示', '保存成功');
                                        InspectionDate1 = uyear+"-"+month+"-"+uday+" 00:00:00";
                                        plant2 = $('#CWERKS1').combobox('getText');
                                        c_query();
                                        ids='';
                                        getGC2();
                                    }

                                }


                            },
                            error: function (msg) {//ajax请求失败后触发的方法
                                alert(msg);//弹出错误信息
                            }

                        });
                    }else {
                        $.ajax({
                            type: "post",//数据发送的方式（post 或者 get）
                            url: "${pageContext.request.contextPath}/Cultivator/insert.action",//要发送的后台地址
                            data: {
                                serialNum:serialNum,
                                ProductNum:ProductNum,
                                ZCHYJ:ZCHYJ,
                                Power:Power,
                                Zfdjh:Zfdjh1,
                                ZMACH:ZMACH,
                                AUFNR:AUFNR1,
                                ZJYRQ:ZJYRQ,
                                OutlineSize:COutlineSize,
                                TrackType:TrackType,
                                FactoryID:FactoryID,
                                Gauge:Gauge,
                                CutWidth:CutWidth,
                                FeedVolume:FeedVolume,
                                HarMachQuy:HarMachQuy,
                                CManufactureDate:CManufactureDate,
                                time:time,
                                plant:plant,
                                plant1:plant1,
                                user: name,
                                ids:ids,
                                Certdate:Certdate
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    if(CS=='1'){
                                        $.messager.alert('温馨提示', '保存成功');
                                        InspectionDate1 = uyear+"-"+month+"-"+uday+" 00:00:00";
                                        plant2 = $('#CWERKS1').combobox('getText');
                                        c_query();
                                        ids='';
                                    }else {
                                        $.messager.alert('温馨提示', '保存成功');
                                        InspectionDate1 = uyear+"-"+month+"-"+uday+" 00:00:00";
                                        plant2 = $('#CWERKS1').combobox('getText');
                                        c_query();
                                        ids='';
                                    }

                                }


                            },
                            error: function (msg) {//ajax请求失败后触发的方法
                                alert(msg);//弹出错误信息
                            }

                        });
                    }

                },
            })
        }else{
            $.messager.alert('温馨提示', '保存信息不完整!!!');
        }


    }
    function getGC2() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#CWERKS1').combobox('loadData', data);
                $('#CPlant').combobox('loadData', data);
                var date=new Date();
                var year = date.getFullYear();
                var month = date.getMonth()+1;
                var day = date.getDate();
                $('#CZJYRQBEGIN1').datebox('setValue', year+"-"+month+"-"+day);
                $('#CZJYRQEND1').datebox('setValue', year+"-"+month+"-"+day);
                $('#table').datagrid('loadData',{total:0,rows:[]});
            }
        });
    }
    var ZJYRQ = '';//检验日期
    function c_spaquery () {
        var ZSERI  = $('#CZSERI1').val();
        var SYB =  localStorage.getItem("Department");
        var AUFNR = $('#CAUFNR1').val();//物料描述
        var WERKS = $('#CWERKS1').combobox('getValue');//工厂
        var SYB3 =  $('#CWERKS1').combobox('getText');
        var ZJYRQBEGIN = $('#CZJYRQBEGIN1').datebox('getValue');
        var ZJYRQEND = $('#CZJYRQEND1').datebox('getValue');
            if(SYB3==SYB||SYB=='信息中心'){
                $.messager.progress({
                    title:'请稍后',
                    msg:'页面加载中...'
                });
                $.ajax({
                    type: "post",//数据发送的方式（post 或者 get）
                    url: "${pageContext.request.contextPath}/Cultivator/serachRFCS.action",//要发送的后台地址
                    data: {
                        ZSERI:ZSERI,
                        AUFNR:AUFNR,
                        WERKS:WERKS,
                        ZJYRQBEGIN:ZJYRQBEGIN,
                        ZJYRQEND:ZJYRQEND,
                    },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        console.log(data);
                        fdata = data;
                        $.messager.progress('close');
                        $("#table").datagrid({
                            idField:'id',
                            loadFilter:pagerFilter,
                            rownumbers:true,
                            singleSelect:true,
                            pageList:[50,100,200],//分页列表
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
                                {field:'WERKS',title:'工厂',width: '80px',align:'center',halign:'center'},
                                {field:'AUFNR',title:'生产订单号',width: '120px',align:'center',halign:'center'},
                                {field:'ZSERI',title:'序列号',width: '150px',align:'center',halign:'center'},
                                {field:'ZJYRQ',title:'检验日期',width: '150px',align:'center',halign:'center'},
                                {field:'ZMACH',title:'机型',width: '100px',align:'center',halign:'center'},
                                {field:'ZFDJH',title:'发动机号',width: '100px',align:'center',halign:'center'},
                                {field:'ZCHYJ',title:'柴油机',width: '100px',align:'center',halign: 'center'},
                                {field:'PLNBEZ',title:'产品料号',width: '150px',align:'center',halign:'center'},
                                {field:'MAKTX',title:'物料描述',width: '250px',align:'center',halign:'center'},
                            ]],
                        });



                    },
                    error: function (msg) {//ajax请求失败后触发的方法
                        alert(msg);//弹出错误信息
                        $.messager.progress('close');
                    }

                });
                $('#table').datagrid('loadData',{total:0,rows:[]});
            }else {
                $.messager.alert("温馨提示","不能跨工厂查询!");
                getGC2();
            }

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
    var ProductNum = '';
    $("#table").datagrid({
        //双击事件
        onDblClickRow: function (index, row) {
            $('#fmsave1').form('clear');
            $('#CPower').combobox('loadData', {});//清空option选项
            $('#CZCHYJ').combobox('loadData', {});//清空option选项
            $('#Gauge').combobox('loadData', {});//清空option选项
            $('#CutWidth').combobox('loadData', {});//清空option选项
            $('#TrackType').combobox('loadData', {});//清空option选项
            $('#FeedVolume').combobox('loadData', {});//清空option选项
            $('#COutlineSize').combobox('loadData', {});//清空option选项
            $('#HarMachQuy').combobox('loadData', {});//清空option选项
            var rowIndex=$('#table').datagrid('getRowIndex',$('#table').datagrid('getSelected'));
            CDQH  = rowIndex;
            document.getElementById('DQT1').innerText=CDQH+1;
            if(row.AUFNR==undefined){
            $.messager.alert("温馨提示","此机型数据不存在!!!");
        }else{
                if(row.ZMACH!=''){
                    $('#button2').linkbutton('disable');
                    var ZSERI = row.ZSERI;
                    ProductNum   =  row.PLNBEZ;
                    Zfdjh1 = row.ZFDJH;
                    AUFNR1= row.AUFNR;
                    ZMACH = row.ZMACH;
                    ZSERI = row.ZSERI;
                    ZJYRQ = row.ZJYRQ;
                    $('#JX1').textbox('setValue',row.ZMACH);
                    $('#CserialNum').textbox('setValue',ZSERI);
                    $('#CProductNum').textbox('setValue',row.PLNBEZ);
                    $('#CFactoryID').textbox('setValue',ZSERI);
                    $("#dlgcj").dialog({
                        title: '固定项',
                        width: 800,
                        height:450,
                        modal: true,
                    });
                    $('#dlgcj').dialog("open");
                    $("#CPower").combobox({editable:false});
                }else {
                    var rowIndex=$('#table').datagrid('getRowIndex',$('#table').datagrid('getSelected'));
                    CDQH  = rowIndex;
                    $('#button2').linkbutton('disable');
                    var ZSERI = row.ZSERI;
                    ProductNum   =  row.PLNBEZ;
                    Zfdjh1 = row.ZFDJH;
                    AUFNR1= row.AUFNR;
                    ZMACH = row.ZMACH;
                    ZSERI = row.ZSERI;
                    ZJYRQ = row.ZJYRQ;
                    $('#JX1').textbox('setValue','');
                    $('#CserialNum').textbox('setValue',ZSERI);
                    $('#CProductNum').textbox('setValue',row.PLNBEZ);
                    $('#CFactoryID').textbox('setValue',ZSERI);
                    $("#dlgcj").dialog({
                        title: '固定项',
                        width: 800,
                        height:450,
                        modal: true,
                    });
                    $('#dlgcj').dialog("open");
                    $("#CPower").combobox({editable:false});
                }

            }
        }

    });
    function Find1  () {
        var s = $('#JX1').val();
        var m = $('#CserialNum').val();//序列号
        if(s!=''){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${pageContext.request.contextPath}/Tractor/Juge1.action',
                dataType: "json",
                data: {
                    ZMACH:s,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    console.log(data);
                    if(data.num!=-1){
                        ZMACH = s;
                        getGDX1();
                        $.ajax({
                            type:"post",
                            url: "${pageContext.request.contextPath}/Cultivator/Juge.action",//要发送的后台地址
                            data:{
                                ZSERI:m,
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data1) {//ajax请求成功后触发的方法
                                console.log(data1);
                                if (data1.num !=-1) {
//                                    $("#CPower").combobox({editable:true});
                                    var row = new Array();
                                    row = data1.rows;
                                    $('#CserialNum').textbox('setValue',row[0].serialid);
                                    $('#CProductNum').textbox('setValue',row[0].productid);
                                    $('#CZCHYJ').textbox('setValue',row[0].zchyj);
                                    $('#CPower').textbox('setValue',row[0].power);
                                    $('#CFactoryID').textbox('setValue',row[0].factoryid);
                                    $('#Gauge').textbox('setValue',row[0].gauge);
                                    $('#CutWidth').textbox('setValue',row[0].cutwidth);
                                    $('#TrackType').textbox('setValue',row[0].tracktype);
                                    $('#FeedVolume').textbox('setValue',row[0].feedvolume);
                                    $('#COutlineSize').textbox('setValue',row[0].outsize);
                                    $('#HarMachQuy').textbox('setValue',row[0].harmachquy);
                                    $('#CManufactureDate').datebox('setValue', row[0].manufacturedate);
//                                    $("#CPower").combobox({editable:true});
                                }else {
                                    $('#CZCHYJ').textbox('setValue','');
                                    $('#CPower').textbox('setValue','');
                                    $('#Gauge').textbox('setValue','');
                                    $('#CutWidth').textbox('setValue','');
                                    $('#TrackType').textbox('setValue','');
                                    $('#FeedVolume').textbox('setValue','');
                                    $('#COutlineSize').textbox('setValue','');
                                    $('#HarMachQuy').textbox('setValue','');
                                    $('#CManufactureDate').datebox('setValue', '');
//                                    $("#CPower").combobox({editable:false});
                                }

                            },
                        })
                    }else {
                        $.messager.alert("温馨提示","请维护机型数据!!!");//请维护机型数据
                    }
                }
            });
        }else {
            $.messager.alert("温馨提示","请输入机型!!!");//请维护机型数据
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

    function getGDX1() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#CZCHYJ').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look1.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#CPower').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look2.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#CutWidth').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/Gauge.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#Gauge').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/TrackType.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#TrackType').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look3.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#COutlineSize').combobox('loadData', data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look4.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#FeedVolume').combobox('loadData',data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Cultivator/look5.action',
            dataType: "json",
            data: {
                ZMACH:ZMACH,
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#HarMachQuy').combobox('loadData', data);
            }
        });
    }

</script>
</body>
</html>

