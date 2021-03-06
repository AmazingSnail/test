<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-06-15
  Time: 14:53
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
    .labelstyle{
        margin-right: 3px;
    }
</style>
<!DOCTYPE html>
<html>
<body class="easyui-layout">
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="修改合格证" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:100%">
            <div class="wu-toolbar-button">
                <div id="test3"><input  id ="qadb" style="width:110px" class="easyui-text" hidden="hidden"></div>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap;margin-top: 1%;text-align: left">
                <label >机型：</label><span id="jixing2" style="color: red;"></span><input type="text" style="height:20px;width:40%;border: 0px;outline:none;"><label><span class="ti4">发动机号码</span>：</label><input id="FDJHM" class="easyui-textbox"  style="width:25%"><br>
                <input type="text" style="height:5px;border: 0px;outline:none;"><br>
                <label><span class="ti2">序列号</span>：</label><input id="serialNum1" class="easyui-textbox" readonly style="width:25%">&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">产品料号</span>：</label><input id="ProductNum1" class="easyui-textbox" readonly style="width:27%">&nbsp<br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti6">发动机型号</span>：</label><select class="easyui-combobox" style="width:25%" name="MonthPlan-Plant1" datatype="text" id="ZCHYJ1" panelHeight="auto" data-options="
                                valueField:'ZCHYJ',
                                textField:'ZCHYJ',
                                panelHeight:'250'"
                                                                      style="width:25%"></select>&nbsp&nbsp&nbsp&nbsp<label><span class="ti5">功率/KW</span>：</label>
                <select class="easyui-combobox" style="width:26.5%" name="MonthPlan-Plant" datatype="text" id="Power1" panelHeight="auto" data-options="
                                valueField:'Power',
                                textField:'Power',
                                panelHeight:'250'"
                        style="width:26.5%"></select><br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti3">生产订单</span>：</label><input id="FactoryID1" readonly class="easyui-textbox" style="width:25%">&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">机身颜色</span>：</label>
                <select class="easyui-combobox" name="takekind" datatype="text" id="BodyColor1"  panelHeight="auto" style="width:26%">
                    <option value="红色" selected="selected">红色</option>
                    <option value="蓝色">蓝色</option>
                </select><br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti5">轴距/mm</span>：</label>
                <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="WheelBase1" panelHeight="auto" data-options="
                                valueField:'base',
                                textField:'base',
                                panelHeight:'250'"
                        style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp<label>前轮距（规格）/mm：</label>
                <select class="easyui-combobox" style="width:14%" name="MonthPlan-Plant" datatype="text" id="WheelSizeQ1" panelHeight="auto" data-options="
                                valueField:'WheelSizeQ',
                                textField:'WheelSizeQ',
                                panelHeight:'250'"
                        style="width:14%"></select>
                <select class="easyui-combobox" style="width:13%" name="MonthPlan-Plant" datatype="text" id="TireSpectQ1" panelHeight="auto" data-options="
                                valueField:'TireSpectQ',
                                textField:'TireSpectQ',
                                panelHeight:'250'"
                        style="width:13%"></select>
                <br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti2">轮胎数</span>：</label>
                <select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum1"  panelHeight="auto" style="width:24%">
                    <option value="4" selected="selected">4</option>
                    <option value="6">6</option>
                    <option value="2">2</option>
                </select>&nbsp&nbsp&nbsp&nbsp&nbsp<label>后轮距（规格）/mm：</label>
                <select class="easyui-combobox" style="width:14%" name="MonthPlan-Plant" datatype="text" id="WheelSizeH1" panelHeight="auto" data-options="
                                valueField:'WheelSizeH',
                                textField:'WheelSizeH',
                                panelHeight:'250'"
                        style="width:14%"></select>
                <select class="easyui-combobox" style="width:13%" name="MonthPlan-Plant" datatype="text" id="TireSpectH1" panelHeight="auto" data-options="
                                valueField:'TireSpectH',
                                textField:'TireSpectH',
                                panelHeight:'250'"
                        style="width:13%"></select><br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti3">外廓尺寸</span>：</label>
                <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="OutlineSize1" panelHeight="auto" data-options="
                                valueField:'OutlineSize',
                                textField:'OutlineSize',
                                panelHeight:'250'"
                        style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp&nbsp<label><span class="ti10">标定牵引力/N</span>：</label>
                <select class="easyui-combobox" style="width:27%" name="MonthPlan-Plant" datatype="text" id="DemarcatedForce1" panelHeight="auto" data-options="
                                valueField:'force',
                                textField:'force',
                                panelHeight:'250'"
                        style="width:27%"></select>
                <br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti9">最小使用质量/kg</span>：</label>
                <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="MinUse1" panelHeight="auto" data-options="
                                valueField:'MinUse',
                                textField:'MinUse',
                                panelHeight:'250'"
                        style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">生产日期</span>：</label><input id="ManufactureDate1" class="easyui-datebox" style="width:27%">&nbsp<br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ti3">发证日期</span>：</label><input id="Certdate" class="easyui-datebox" style="width:27%">&nbsp
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $("#test3" ).css("display", "none");
    function TractorEditCancel() {
        parent.$.modalDialog.handler.dialog('close');
    }
    var ids = "";
    var Zfdjh ="" ;
    var AUFNR ="" ;
    var ZMACH = "";
    var plant = "";
    var plant1  = "";
    var date = "";
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
        getdate();//获取工厂

    })

    function getdate() {
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
                var row = $("#ti").datagrid("getSelected");
                ids = row.id;
                Zfdjh = row.zfdjh;
                AUFNR = row.orderid;
                ZMACH = row.zmach;
                plant = row.plant;
                plant1  = row.plantins;
                date  = row.certdate;
                oncilick();
                document.getElementById('jixing2').innerText=row.zmach;
                $('#serialNum1').textbox('setValue',row.zseri);
                $('#FDJHM').textbox('setValue',row.zfdjh);
                $('#ProductNum1').textbox('setValue',row.productid);
                $('#ZCHYJ1').textbox('setValue',row.zchyj);
                $('#Power1').textbox('setValue',row.power);
                $('#FactoryID1').textbox('setValue',row.orderid);
                $('#BodyColor1').textbox('setValue',row.bodycolor);
                $('#WheelBase1').textbox('setValue',row.wheelbase);
                var myArray=new Array();
                myArray = row.wheelsize.split("|");
                var WheelSizeQ = myArray[0];
                var WheelSizeH = myArray[1];
                var myArray1=new Array();
                myArray1 = row.tirespect.split("|");
                var TireSpectQ = myArray1[0];
                var TireSpectH = myArray1[1];
                $('#WheelSizeQ1').textbox('setValue',   TireSpectQ);//前轮
                $('#WheelSizeH1').textbox('setValue',TireSpectH );//后轮
                $('#AxleNum1').textbox('setValue',row.tiresnum);//轮胎数
                $('#TireSpectQ1').textbox('setValue',  WheelSizeQ);//前 规格
                $('#TireSpectH1').textbox('setValue',WheelSizeH);//后规格
                $('#OutlineSize1').textbox('setValue',row.outlinesize);
                $('#DemarcatedForce1').textbox('setValue',row.demarcatedforce);
                $('#MinUse1').textbox('setValue',row.minuse);
                $('#ManufactureDate1').datebox('setValue', row.manufacturedate);
                $('#Certdate').datebox('setValue', row.certdate);
            }
        });
    }
    function Add2 () {
        var serialNum = $('#serialNum1').val();
        var ProductNum = $('#ProductNum1').val();
        Zfdjh = $('#FDJHM').val();
        var ZCHYJ = $('#ZCHYJ1').combobox('getValue');
        var Power = $('#Power1').combobox('getValue');
        var FactoryID = $('#FactoryID1').val();
        var BodyColor = $('#BodyColor1').combobox('getValue');
        var WheelBase = $('#WheelBase1').combobox('getValue');
        var WheelSizeQ = $('#WheelSizeQ1').combobox('getValue');
        var WheelSizeH = $('#WheelSizeH1').combobox('getValue');
        var AxleNum = $('#AxleNum1').combobox('getValue');
        var TireSpectQ = $('#TireSpectQ1').combobox('getValue');
        var TireSpectH = $('#TireSpectH1').combobox('getValue');
        var OutlineSize = $('#OutlineSize1').combobox('getValue');
        var DemarcatedForce = $('#DemarcatedForce1').combobox('getValue');
        var MinUse = $('#MinUse1').combobox('getValue');
        var ManufactureDate = $('#ManufactureDate1').datebox('getValue');
        var Certdate = $('#Certdate').datebox('getValue');
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
        if(serialNum!=''&& ProductNum!=''&& ZCHYJ!=''&& Power!=''&& FactoryID!=''&& BodyColor!=''
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
                                AUFNR:FactoryID,
                                ZMACH:ZMACH,
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
                                user: localStorage.getItem("User"),
                                time:time,
                                Certdate:Certdate,
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    $.messager.alert('温馨提示', '修改成功');
                                    InspectionDate = date.substring(0,11)+"00:00:00";
                                    t_query();
                                    ids='';
                                    TractorEditCancel();
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
                                AUFNR:FactoryID,
                                ZMACH:ZMACH,
                                FDJHM:FDJHM,
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
                                user: localStorage.getItem("User"),
                                time:time,
                                Certdate:Certdate,
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    $.messager.alert('温馨提示', '保存成功');
                                    InspectionDate = date;
                                    t_query();
                                    ids='';
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
    function oncilick() {
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
                $('#ZCHYJ1').combobox('loadData', data);

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
                $('#Power1').combobox('loadData', data);

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
                $('#WheelBase1').combobox('loadData', data);

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
                $('#OutlineSize1').combobox('loadData', data);
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
                $('#MinUse1').combobox('loadData', data);
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
                $('#WheelSizeQ1').combobox('loadData', data);
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
                $('#WheelSizeH1').combobox('loadData',data);
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
                $('#DemarcatedForce1').combobox('loadData',data);
            }
        });
    }
    $("#WheelSizeH1").combobox({
        onChange: function (n,o) {
            $('#TireSpectH1').combobox('clear');
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
                    $('#TireSpectH1').combobox('loadData',data);
                }
            });

        }

    });
    $("#WheelSizeQ1").combobox({
        onChange: function (n,o) {
            $('#TireSpectQ1').combobox('clear');
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
                    $('#TireSpectQ1').combobox('loadData',data);
                }
            });

        }

    });
</script>
</body>
</html>
