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
                <div id="test"><input  id ="qadb" style="width:110px" class="easyui-text" hidden="hidden"></div>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr><td><label>工厂：</label><select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="TWERKS1" panelHeight="auto" data-options="
                                valueField:'statusid',
                                textField:'statusname',
                                panelHeight:'250'"
                                                      style="width:100px">
                    </select></td>
                        <td><label>生产订单号：</label><input id="AUFNR1" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>序列号：</label><input id="ZSERI1" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>起始检验日期：</label><input id="ZJYRQBEGIN1" class="easyui-datebox" style="width:100px">&nbsp</td>
                        <td><label>检验结束日期：</label><input  id ="ZJYRQEND1" style="width:110px" class="easyui-datebox"></td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="t_spaquery()" data-options="iconCls:'icon-search'" id="button1">查询</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true,border:true" >
                <table id="dialogtable" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
            </div>
        </div>
    </div>
</div>
<div id="dlgj" class="easyui-dialog"  title="固定项" style="width:50%; height: 68%;  padding: 10px;"
     closed="true" buttons="#dlgm-buttons">
    <form id="fmsave" method="post">
        <label>机型：</label><input id="JX" class="easyui-textbox"  style="width:15%"><a href="#" class="easyui-linkbutton"  onclick="Find()" data-options="iconCls:'icon-search'" id="button2">查询</a><label>当前第</label><span id="DQT"  style="width:5%;text-align: center ;margin-bottom: 1%"></span><label>条</label><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti2">序列号</span>：</label><input id="serialNum" class="easyui-textbox" readonly style="width:25%">&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">产品料号</span>：</label><input id="ProductNum" class="easyui-textbox" readonly style="width:27%">&nbsp<br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti6">发动机型号</span>：</label><select class="easyui-combobox"  contenteditable="false" style="width:25%" name="MonthPlan-Plant" datatype="text" id="ZCHYJ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'ZCHYJ',
                                textField:'ZCHYJ',
                                panelHeight:'250'"
                                                                  style="width:25%"></select>&nbsp&nbsp&nbsp&nbsp<label><span class="ti5">功率/KW</span>：</label>
            <select class="easyui-combobox" style="width:26.5%" name="MonthPlan-Plant" datatype="text" id="Power" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'Power',
                                textField:'Power',
                                panelHeight:'250'"
                    style="width:26.5%"></select><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti3">出厂编号</span>：</label><input id="FactoryID" readonly class="easyui-textbox" style="width:25%">&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">机身颜色</span>：</label>
            <select class="easyui-combobox" name="takekind" datatype="text" id="BodyColor"  panelHeight="auto" style="width:26%">
                <option value="红色" selected="selected">红色</option>
                <option value="蓝色">蓝色</option>
            </select><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti5">轴距/mm</span>：</label>
            <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="WheelBase" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'base',
                                textField:'base',
                                panelHeight:'250'"
                    style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp<label>前轮距（规格）/mm：</label>
            <select class="easyui-combobox" style="width:14%" name="MonthPlan-Plant" datatype="text" id="WheelSizeQ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'WheelSizeQ',
                                textField:'WheelSizeQ',
                                panelHeight:'250'"
                    style="width:14%"></select>
            <select class="easyui-combobox" style="width:13%" name="MonthPlan-Plant" datatype="text" id="TireSpectQ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'TireSpectQ',
                                textField:'TireSpectQ',
                                panelHeight:'250'"
                    style="width:13%"></select>
            <br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti2">轮胎数</span>：</label>
            <select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum"  panelHeight="auto" style="width:24%">
                <option value="4" selected="selected">4</option>
                <option value="6">6</option>
                <option value="2">2</option>
            </select>&nbsp&nbsp&nbsp&nbsp&nbsp<label>后轮距（规格）/mm：</label>
            <select class="easyui-combobox" style="width:14%" name="MonthPlan-Plant" datatype="text" id="WheelSizeH" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'WheelSizeH',
                                textField:'WheelSizeH',
                                panelHeight:'250'"
                    style="width:14%"></select>
            <select class="easyui-combobox" style="width:13%" name="MonthPlan-Plant" datatype="text" id="TireSpectH" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'TireSpectH',
                                textField:'TireSpectH',
                                panelHeight:'250'"
                    style="width:13%"></select><br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti3">外廓尺寸</span>：</label>
            <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="OutlineSize" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'OutlineSize',
                                textField:'OutlineSize',
                                panelHeight:'250'"
                    style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp&nbsp<label><span class="ti10">标定牵引力/N</span>：</label>
            <select class="easyui-combobox" style="width:27%" name="MonthPlan-Plant" datatype="text" id="DemarcatedForce" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'force',
                                textField:'force',
                                panelHeight:'250'"
                    style="width:27%"></select>
            <br>
            <input type="text" style="height:20px;border: 0px;outline:none;"><br>
            <label><span class="ti9">最小使用质量/kg</span>：</label>
            <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="MinUse" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'MinUse',
                                textField:'MinUse',
                                panelHeight:'250',
                               "
                    style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">生产日期</span>：</label><input id="ManufactureDate" class="easyui-datebox" style="width:27%" data-options="required:true">&nbsp<br>

            <div  style="text-align: right;margin-top: 3%">
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Back()" iconcls="icon-undo" id="Back">上一条</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="GOS()" iconcls="icon-redo" id="GOS">下一条</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Add1()" iconcls="icon-save">保存</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Cancelda1()" iconcls="icon-cancel">取消</a>
            </div>
    </form>


</div>

<script type="text/javascript">
    $("#test" ).css("display", "none");
//    $(function()
//    {
//        var date=new Date();
//        var year = date.getFullYear();
//        var month = date.getMonth()+1;
//        var day = date.getDate();
//      $('#ZJYRQBEGIN1').datebox('setValue', year+"-"+month+"-"+day);
//
//    });
    var DQH = '';//当前行
    var XS ='';
    var ids = '';
    var idb='';
    var temID="";
    var InspectionDate='';
    var Zfdjh = '';
    var AUFNR = '';
    var ZMACH = '';
    var ZSERI = '';
    var ZJYRQ = '';//检验日期
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
        getGC1();//获取工厂
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
    });
    function TractorAddCancel() {
        parent.$.modalDialog.handler.dialog('close');
        $("#dlgj").dialog("close");
    }
    function Back() {
        $('#fmsave').form('clear');
        $('#GOS').linkbutton('enable');
        $('#ZCHYJ').combobox('loadData', {});//清空option选项
        $('#Power').combobox('loadData', {});//清空option选项
        $('#WheelBase').combobox('loadData', {});//清空option选项
        $('#WheelSizeQ').combobox('loadData', {});//清空option选项
        $('#TireSpectQ').combobox('loadData', {});//清空option选项
        $('#WheelSizeH').combobox('loadData', {});//清空option选项
        $('#TireSpectH').combobox('loadData', {});//清空option选项
        $('#OutlineSize').combobox('loadData', {});//清空option选项
        $('#DemarcatedForce').combobox('loadData', {});//清空option选项
        $('#MinUse').combobox('loadData', {});//清空option选项
        $('#ManufactureDate').datebox('setValue', '');
        $('#ZCHYJ').textbox('setValue','');
        $('#Power').textbox('setValue','');
        $('#BodyColor').textbox('setValue','');
        $('#WheelSizeQ').textbox('setValue','');
        $('#WheelSizeH').textbox('setValue','');
        $('#AxleNum').textbox('setValue',4);
        $('#TireSpectQ').textbox('setValue','');
        $('#TireSpectH').textbox('setValue','');
        $('#MinUse').textbox('setValue','');
        $('#DemarcatedForce').textbox('setValue','');
        $('#OutlineSize').textbox('setValue','');
        $('#WheelBase').textbox('setValue','');
        var  back = --DQH ;
        if(back>-1){
            var rows = $('#dialogtable').datagrid('getRows');
            var row = rows[back];//根据index获得其中一行。
            document.getElementById('DQT').innerText=back+1;
            var ZSERI = row.ZSERI;
            var ProductNum =  row.PLNBEZ;
            if(row.ZMACH!=''){
                $('#JX').textbox('setValue',row.ZMACH);
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#serialNum').textbox('setValue',ZSERI);
                $('#ProductNum').textbox('setValue',row.PLNBEZ);
                $('#FactoryID').textbox('setValue',ZSERI);
                $("#dlgj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgj').dialog("open");
            }else {
                $('#JX').textbox('setValue','');
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#serialNum').textbox('setValue',ZSERI);
                $('#ProductNum').textbox('setValue',row.PLNBEZ);
                $('#FactoryID').textbox('setValue',ZSERI);
                $("#dlgj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgj').dialog("open");
            }
        }else {
            $('#Back').linkbutton('disable');
            GOS();
        }

    }
    function GOS() {
        $('#Back').linkbutton('enable');
        $('#fmsave').form('clear');
        $('#ZCHYJ').combobox('loadData', {});//清空option选项
        $('#Power').combobox('loadData', {});//清空option选项
        $('#WheelBase').combobox('loadData', {});//清空option选项
        $('#WheelSizeQ').combobox('loadData', {});//清空option选项
        $('#TireSpectQ').combobox('loadData', {});//清空option选项
        $('#WheelSizeH').combobox('loadData', {});//清空option选项
        $('#TireSpectH').combobox('loadData', {});//清空option选项
        $('#OutlineSize').combobox('loadData', {});//清空option选项
        $('#DemarcatedForce').combobox('loadData', {});//清空option选项
        $('#MinUse').combobox('loadData', {});//清空option选项
        $('#ManufactureDate').datebox('setValue', '');
        $('#ZCHYJ').textbox('setValue','');
        $('#Power').textbox('setValue','');
        $('#BodyColor').textbox('setValue','');
        $('#WheelSizeQ').textbox('setValue','');
        $('#WheelSizeH').textbox('setValue','');
        $('#AxleNum').textbox('setValue',4);
        $('#TireSpectQ').textbox('setValue','');
        $('#TireSpectH').textbox('setValue','');
        $('#MinUse').textbox('setValue','');
        $('#DemarcatedForce').textbox('setValue','');
        $('#OutlineSize').textbox('setValue','');
        $('#WheelBase').textbox('setValue','');
        var  go = ++DQH ;
        var rows = $('#dialogtable').datagrid('getRows');
        if(go<rows.length-1){

            var row = rows[go];//根据index获得其中一行。
            var ZSERI = row.ZSERI;
            document.getElementById('DQT').innerText=go+1;
            var ProductNum =  row.PLNBEZ;
            if(row.ZMACH!=''){
                $('#JX').textbox('setValue',row.ZMACH);
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#serialNum').textbox('setValue',ZSERI);
                $('#ProductNum').textbox('setValue',row.PLNBEZ);
                $('#FactoryID').textbox('setValue',ZSERI);
                $("#dlgj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgj').dialog("open");
            }else {
                $('#JX').textbox('setValue',"");
                ZMACH = row.ZMACH;
                Zfdjh = row.ZFDJH;
                AUFNR = row.AUFNR;
                ZJYRQ  =  row.ZJYRQ;
                ZSERI = row.ZSERI;
                $('#serialNum').textbox('setValue',ZSERI);
                $('#ProductNum').textbox('setValue',ProductNum);
                $('#FactoryID').textbox('setValue',ZSERI);
                $("#dlgj").dialog({
                    title: '固定项',
                    width: 800,
                    height:480,
                    modal: true,
                });
                $('#dlgj').dialog("open");
            }

        }else {
            $('#GOS').linkbutton('disable');
            Back();
        }

    }
    var sn ='';
    function Add1 () {

        var serialNum = $('#serialNum').val();
        var ProductNum = $('#ProductNum').val();
        var ZCHYJ = $('#ZCHYJ').combobox('getText');
        var Power = $('#Power').combobox('getText');
        var FactoryID = $('#FactoryID').val();
        var BodyColor = $('#BodyColor').combobox('getText');
        var WheelBase = $('#WheelBase').combobox('getText');
        var WheelSizeQ = $('#WheelSizeQ').combobox('getText');
        var WheelSizeH = $('#WheelSizeH').combobox('getText');
        var AxleNum = $('#AxleNum').combobox('getText');
        var TireSpectQ = $('#TireSpectQ').combobox('getText');
        var TireSpectH = $('#TireSpectH').combobox('getText');
        var OutlineSize = $('#OutlineSize').combobox('getText');
        var DemarcatedForce = $('#DemarcatedForce').combobox('getText');
        var MinUse = $('#MinUse').combobox('getText');
        var ManufactureDate = $('#ManufactureDate').datebox('getValue');
        var plant = $('#TWERKS1').combobox('getText');
        var plant1 = $('#TWERKS1').combobox('getValue');
        var serialNum1 = $('#JX').val();
        var serialNum = $('#serialNum').val();
        if(ZMACH!=''){
            sn = ZMACH;
        }else {
            sn = serialNum1;
        }
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
       if(serialNum1!=''&&serialNum!=''&& ProductNum!=''&& ZCHYJ!=''&& Power!=''&& FactoryID!=''&& BodyColor!=''
           && WheelBase!=''&& WheelSizeQ!=''&& WheelSizeH!=''&& AxleNum!=''&& TireSpectQ!=''
           && TireSpectH!=''&& OutlineSize!=''&& DemarcatedForce!=''&& MinUse!=''&& ManufactureDate!=''){
           $.ajax({
               type:"post",
               url: "${pageContext.request.contextPath}/Tractor/Juge.action",//要发送的后台地址
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
                           url: "${pageContext.request.contextPath}/Tractor/insert.action",//要发送的后台地址
                           data: {
                               serialNum:serialNum,
                               ProductNum:ProductNum,
                               ZCHYJ:ZCHYJ,
                               Power:Power,
                               Zfdjh:Zfdjh,
                               AUFNR:AUFNR,
                               ZMACH:sn,
                               FactoryID:FactoryID,
                               BodyColor:BodyColor,
                               WheelBase:WheelBase,
                               WheelSizeQ:WheelSizeQ,
                               WheelSizeH:WheelSizeH,
                               AxleNum:AxleNum,
                               plant:plant,
                               plant1:plant1,
                               TireSpectQ:TireSpectQ,
                               TireSpectH:TireSpectH,
                               OutlineSize:OutlineSize,
                               DemarcatedForce:DemarcatedForce,
                               MinUse:MinUse,
                               ManufactureDate:ManufactureDate,
                               ids:idb,
                               user: name,
                               time:time,
                               Certdate:Certdate,
                           },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                           dataType: "json",//后台处理后返回的数据格式
                           success: function (data) {//ajax请求成功后触发的方法
                               if(data.num>0){
                                   if(XS=='1'){
                                       $.messager.alert('温馨提示', '保存成功');
                                       t_query();
                                       ids='';
                                       getGC1();
                                   }else {
                                       $.messager.alert('温馨提示', '保存成功');
                                       t_query();
                                       ids='';
                                       getGC1();
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
                           url: "${pageContext.request.contextPath}/Tractor/insert.action",//要发送的后台地址
                           data: {
                               serialNum:serialNum,
                               ProductNum:ProductNum,
                               ZCHYJ:ZCHYJ,
                               Power:Power,
                               Zfdjh:Zfdjh,
                               AUFNR:AUFNR,
                               ZMACH:sn,
                               ZJYRQ:ZJYRQ,
                               FactoryID:FactoryID,
                               BodyColor:BodyColor,
                               WheelBase:WheelBase,
                               WheelSizeQ:WheelSizeQ,
                               WheelSizeH:WheelSizeH,
                               AxleNum:AxleNum,
                               plant:plant,
                               plant1:plant1,
                               TireSpectQ:TireSpectQ,
                               TireSpectH:TireSpectH,
                               OutlineSize:OutlineSize,
                               DemarcatedForce:DemarcatedForce,
                               MinUse:MinUse,
                               ManufactureDate:ManufactureDate,
                               ids:ids,
                               user: name,
                               time:time,
                               Certdate:Certdate,
                           },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                           dataType: "json",//后台处理后返回的数据格式
                           success: function (data) {//ajax请求成功后触发的方法
                               if(data.num>0){
                                   if(XS=='1'){
                                       $.messager.alert('温馨提示', '保存成功');
                                       InspectionDate = uyear+"-"+month+"-"+uday+" 00:00:00";
                                       t_query();
                                       ids='';
                                   }else {
                                       $.messager.alert('温馨提示', '保存成功');
                                       InspectionDate = uyear+"-"+month+"-"+uday+" 00:00:00";
                                       t_query();
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
       } else {
           $.messager.alert('温馨提示', '保存信息不完整!!!');
       }




    }
    function Cancelda1 () {
        $("#dlgj").dialog("close");
    }
    function getGC1() {
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
                $('#TWERKS1').combobox('loadData', data);
                $('#WERKS').combobox('loadData', data);
                var date=new Date();
                var year = date.getFullYear();
                var month = date.getMonth()+1;
                var day = date.getDate();
                $('#qadb').val(year+"-"+month+"-"+day);
                $('#ZJYRQBEGIN1').datebox('setValue', year+"-"+month+"-"+day);
                $('#ZJYRQEND1').datebox('setValue', year+"-"+month+"-"+day);
            }
        });
    }
    function t_spaquery () {

        $('#dialogtable').datagrid('clearSelections');
        var ZSERI  = $('#ZSERI1').val();
        var AUFNR = $('#AUFNR1').val();//物料描述

        var WERKS = $('#TWERKS1').combobox('getValue');//工厂
        var SYB4 =  $('#TWERKS1').combobox('getText');
        var ZJYRQBEGIN = $('#ZJYRQBEGIN1').datebox('getValue');
        var ZJYRQEND = $('#ZJYRQEND1').datebox('getValue');
        var fdata;
        var SYB1 = localStorage.getItem("Department");
            if(SYB4==SYB1||SYB1=='信息中心'){
                $.messager.progress({
                    title:'请稍后',
                    msg:'页面加载中...'
                });
                $.ajax({
                    type: "post",//数据发送的方式（post 或者 get）
                    url: "${pageContext.request.contextPath}/Tractor/serachRFC.action",//要发送的后台地址
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
                        $.messager.progress('close');
                        fdata = data;
                        $("#dialogtable").datagrid({
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
                $('#dialogtable').datagrid('loadData',{total:0,rows:[]});

            }else {
                $.messager.alert("温馨提示","不能跨工厂查询!");
                getGC1();
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
    var aa = '';
    var ab = '';
    var ac = '';
    var ad = '';
    var af = '';
    var ae = '';
    var ag = '';
    var ah = '';
    var ZSERI = '';
    var ProductNum = '';
    $("#dialogtable").datagrid({
        onDblClickRow: function (index, row) {
            $('#fmsave').form('clear');
            $('#ZCHYJ').combobox('loadData', {});//清空option选项
            $('#Power').combobox('loadData', {});//清空option选项
            $('#WheelBase').combobox('loadData', {});//清空option选项
            $('#WheelSizeQ').combobox('loadData', {});//清空option选项
            $('#TireSpectQ').combobox('loadData', {});//清空option选项
            $('#WheelSizeH').combobox('loadData', {});//清空option选项
            $('#TireSpectH').combobox('loadData', {});//清空option选项
            $('#OutlineSize').combobox('loadData', {});//清空option选项
            $('#DemarcatedForce').combobox('loadData', {});//清空option选项
            $('#MinUse').combobox('loadData', {});//清空option选项
            $('#ManufactureDate').datebox('setValue', '');
            $('#ZCHYJ').textbox('setValue','');
            $('#Power').textbox('setValue','');
            $('#BodyColor').textbox('setValue','');
            $('#WheelSizeQ').textbox('setValue','');
            $('#WheelSizeH').textbox('setValue','');
            $('#AxleNum').textbox('setValue',4);
            $('#TireSpectQ').textbox('setValue','');
            $('#TireSpectH').textbox('setValue','');
            $('#MinUse').textbox('setValue','');
            $('#DemarcatedForce').textbox('setValue','');
            $('#OutlineSize').textbox('setValue','');
            $('#WheelBase').textbox('setValue','');
            if(row.AUFNR==undefined){
                $.messager.alert("温馨提示","此机型数据不存在!!!");//请维护机型数据
            }else{
                    var rowIndex=$('#dialogtable').datagrid('getRowIndex',$('#dialogtable').datagrid('getSelected'));
                    DQH  = rowIndex;
                document.getElementById('DQT').innerText=DQH+1;
                ZSERI = row.ZSERI;
                ProductNum =  row.PLNBEZ;
                    if(row.ZMACH!=''){
                        $('#JX').textbox('setValue',row.ZMACH);
                        ZMACH = row.ZMACH;
                        Zfdjh = row.ZFDJH;
                        AUFNR = row.AUFNR;
                        ZJYRQ  =  row.ZJYRQ;
                        ZSERI = row.ZSERI;
                        $('#serialNum').textbox('setValue',ZSERI);
                        $('#ProductNum').textbox('setValue',row.PLNBEZ);
                        $('#FactoryID').textbox('setValue',ZSERI);
                        $("#dlgj").dialog({
                            title: '固定项',
                            width: 800,
                            height:480,
                            modal: true,
                        });
                        $('#dlgj').dialog("open");
                    }else {
                        $('#JX').textbox('setValue',"");
                        Zfdjh = row.ZFDJH;
                        ZMACH = row.ZMACH;
                        AUFNR = row.AUFNR;
                        ZJYRQ  =  row.ZJYRQ;
                        ZSERI = row.ZSERI;
                        $('#serialNum').textbox('setValue',ZSERI);
                        $('#ProductNum').textbox('setValue',row.PLNBEZ);
                        $('#FactoryID').textbox('setValue',ZSERI);
                        $("#dlgj").dialog({
                            title: '固定项',
                            width: 850,
                            height:600,
                            modal: true,
                        });
                        $('#dlgj').dialog("open");

                    }



            }

        }
    });
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
    $("#WheelSizeH").combobox({

        onChange: function (n,o) {
            $('#TireSpectH').combobox('clear');
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${pageContext.request.contextPath}/Tractor/sprect.action',
                dataType: "json",
                data: {
                    ZMACH:ZMACH,
                    n:n,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    console.log(data);
                    $('#TireSpectH').combobox('loadData',data);
                }
            });

        }

    });
    $("#WheelSizeQ").combobox({

        onChange: function (n,o) {
            $('#TireSpectQ').combobox('clear');
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${pageContext.request.contextPath}/Tractor/sprect1.action',
                dataType: "json",
                data: {
                    ZMACH:ZMACH,
                    n:n,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    console.log(data);
                    $('#TireSpectQ').combobox('loadData',data);
                }
            });

        }

    });

    function oncilick1() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look.action',
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
                $('#ZCHYJ').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look1.action',
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
                $('#Power').combobox('loadData', data);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look2.action',
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
                if(data.length>1){
                    $('#WheelBase').combobox('loadData', data);
                }else {
                    $("#WheelBase ").combobox('select',data[0].base);
                    $('#WheelBase').combobox('loadData', data);
                }


            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look3.action',
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
                if(data.length>1){
                    $('#OutlineSize').combobox('loadData', data);
                }else {
                    $('#OutlineSize').combobox('loadData', data);
                    $("#OutlineSize ").combobox('select',data[0].OutlineSize);
                }

            }
        });

        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look5.action',
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
                if(data.length>1){
                    $('#MinUse').combobox('loadData', data);
                }else {
                    $('#MinUse').combobox('loadData', data);
                    $("#MinUse ").combobox('select',data[0].MinUse);
                }

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look6.action',
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
                $('#WheelSizeQ').combobox('loadData', data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look7.action',
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
                $('#WheelSizeH').combobox('loadData',data);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/look4.action',
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
                if(data.length>1){
                    $('#DemarcatedForce').combobox('loadData', data);
                }else {
                    $('#DemarcatedForce').combobox('loadData',data);
                    $("#DemarcatedForce ").combobox('select',data[0].force);
                }

            }
        });
    }
    var sm ='';
    function Find () {
        var s = $('#JX').val();

        var sd = $('#serialNum').val();
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
                        oncilick1();
                        $.ajax({
                            type:"post",
                            url: "${pageContext.request.contextPath}/Tractor/Juge.action",//要发送的后台地址
                            data:{
                                ZSERI:sd,
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data1) {//ajax请求成功后触发的方法
                                console.log(data1);
                                if (data1.num !=-1) {
                                    var row = new Array();
                                    row = data1.rows;
                                    $('#JX').textbox('setValue',ZMACH);
                                    $('#ZCHYJ').textbox('setValue',row[0].zchyj);
                                    $('#Power').textbox('setValue',row[0].power);
                                    $('#BodyColor').textbox('setValue',row[0].bodycolor);
                                    $('#WheelBase').textbox('setValue',row[0].wheelbase);
                                    var myArray=new Array();
                                    myArray = row[0].wheelsize.split("|");
                                    var WheelSizeQ = myArray[0];
                                    var WheelSizeH = myArray[1];
                                    var myArray1=new Array();
                                    myArray1 = row[0].tirespect.split("|");
                                    var TireSpectQ = myArray1[0];
                                    var TireSpectH = myArray1[1];
                                    $('#WheelSizeQ').textbox('setValue', TireSpectQ);//前轮
                                    $('#WheelSizeH').textbox('setValue', TireSpectH);//后轮
                                    $('#AxleNum').textbox('setValue',row[0].tiresnum);
                                    $('#TireSpectQ').textbox('setValue',  WheelSizeQ);//前 规格
                                    $('#TireSpectH').textbox('setValue',WheelSizeH);//后规格
                                    $('#OutlineSize').textbox('setValue',row[0].outlinesize);
                                    $('#DemarcatedForce').textbox('setValue',row[0].demarcatedforce);
                                    $('#MinUse').textbox('setValue',row[0].minuse);
                                    $('#ManufactureDate').datebox('setValue', row[0].manufacturedate);
                                }else {
                                    $('#ManufactureDate').datebox('setValue', '');
                                    $('#ZCHYJ').textbox('setValue','');
                                    $('#Power').textbox('setValue','');
                                    $('#BodyColor').textbox('setValue','');
                                    $('#WheelSizeQ').textbox('setValue','');
                                    $('#WheelSizeH').textbox('setValue','');
                                    $('#AxleNum').textbox('setValue',4);
                                    $('#TireSpectQ').textbox('setValue','');
                                    $('#TireSpectH').textbox('setValue','');
                                }

                            },
                        })
                    }else {
                        $.messager.alert("温馨提示","请维护机型数据!!!");//请维护机型数据
                    }
                }
            });
        }else{
            $.messager.alert("温馨提示","请输入机型!!!");//请维护机型数据
        }

    }
</script>
</body>
</html>

