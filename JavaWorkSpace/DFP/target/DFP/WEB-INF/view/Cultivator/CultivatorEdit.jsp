<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-06-16
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
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
<html>
<body class="easyui-layout">
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="修改合格证" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:100%">
            <div class="wu-toolbar-button">
                <div id="test3"><input  id ="qadb" style="width:110px" class="easyui-text" hidden="hidden"></div>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap;margin-top: 1%;text-align: left">
                <label>机型：</label><input id="jixing2" class="easyui-textbox" style="color: red"><a href="#" class="easyui-linkbutton"  onclick="FindOther()" data-options="iconCls:'icon-search'" id="button">查询</a><input type="text" style="height:20px;width:20%;border: 0px;outline:none;"><label><span class="ci4">发动机号码</span>：</label><input id="FDJHM1" class="easyui-textbox"  style="width:25%"><br>
                <input type="text" style="height:5px;border: 0px;outline:none;"><br>
                <label><span class="ci2">底盘号</span>：</label><input id="CserialNum1" class="easyui-textbox"  style="width:200px;text-align: left">&nbsp&nbsp&nbsp&nbsp<label>产品料号：</label><input id="CProductNum1" class="easyui-textbox" readonly style="width:200px;">&nbsp<br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ci3">出厂编号</span>：</label><input id="CFactoryID1"  class="easyui-textbox" style="width:200px">&nbsp&nbsp&nbsp&nbsp<label>功率/KW：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="CPower1" panelHeight="auto" data-options="
        required:'true',
                                valueField:'Power',
                                textField:'Power',
                                panelHeight:'250'"

                        style="width:196px"></select>
                <br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ci5">发动机型号</span>：</label><select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="CZCHYJ1" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'ZCHYJ',
                                textField:'ZCHYJ',
                                panelHeight:'250'"
                                                                      style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>轨距/mm：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="Gauge1" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'Gauge',
                                textField:'Gauge',
                                panelHeight:'250'"
                        style="width:196px"></select><br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ci6">割台宽度/mm</span>：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="CutWidth1" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'base',
                                textField:'base',
                                panelHeight:'250'"
                        style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>履带规格：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="TrackType1" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'TrackType',
                                textField:'TrackType',
                                panelHeight:'250'"
                        style="width:196px"></select> <br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label><span class="ci9">喂入量（kg/s）/行数</span>：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="FeedVolume1" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'force',
                                textField:'force',
                                panelHeight:'250'"
                        style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>外廓尺寸：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="COutlineSize1" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'OutlineSize',
                                textField:'OutlineSize',
                                panelHeight:'250'"
                        style="width:196px"></select><br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label>联合收割（获）机质量/kg：</label>
                <select class="easyui-combobox" style="width:196px" name="MonthPlan-Plant" datatype="text" id="HarMachQuy1" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'MinUse',
                                textField:'MinUse',
                                panelHeight:'250'"
                        style="width:196px"></select>&nbsp&nbsp&nbsp&nbsp<label>生产日期：</label><input id="CManufactureDate1" class="easyui-datebox" style="width:200px" data-options="required:true">&nbsp<br>
                <input type="text" style="height:20px;border: 0px;outline:none;"><br>
                <label>生产日期：</label><input id="Certdate1" class="easyui-datebox" style="width:200px" data-options="required:true">&nbsp
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $("#test3" ).css("display", "none");
    function CultivatorEditCancel() {
        parent.$.modalDialog.handler.dialog('close');
    }
    var ids = "";
    var Zfdjh1 ="" ;
    var AUFNR1="" ;
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
        getdate1();//获取工厂

    })

    function getdate1() {
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
                var row = $("#ci").datagrid("getSelected");
                    ids = row.id;
                    Zfdjh1 = row.zfdjh;
                    AUFNR1 = row.orderid;
                    ZMACH = row.zmach;
                    plant = row.plantins;
                    plant1 = row.plant;
                    date = row.certdate;
                    getGDX();
                    $('#CserialNum1').textbox('setValue',row.serialid);
                    $('#jixing2').textbox('setValue',row.zmach);
                    $('#button').linkbutton('disable');
                    $('#jixing2').textbox('textbox').attr('readonly',true);  //设置输入框为禁用
                    $('#FDJHM1').textbox('setValue',row.zfdjh);
                    $('#CProductNum1').textbox('setValue',row.productid);
                    $('#CZCHYJ1').textbox('setValue',row.zchyj);
                    $('#CPower1').textbox('setValue',row.power);
                    $('#CFactoryID1').textbox('setValue',row.factoryid);
                    $('#Gauge1').textbox('setValue',row.gauge);
                    $('#CutWidth1').textbox('setValue',row.cutwidth);
                    $('#TrackType1').textbox('setValue',row.tracktype);
                    $('#FeedVolume1').textbox('setValue',row.feedvolume);
                    $('#COutlineSize1').textbox('setValue',row.outsize);
                    $('#HarMachQuy1').textbox('setValue',row.harmachquy);
                    $('#CManufactureDate1').datebox('setValue', row.manufacturedate);
                    $('#Certdate1').datebox('setValue', row.certdate);
                }

        });
    }
    function  CAdd2() {
        var serialNum = $('#CserialNum1').val();
        var ProductNum = $('#CProductNum1').val();
        Zfdjh1 = $('#FDJHM1').val();
        var ZCHYJ = $('#CZCHYJ1').combobox('getText');
        var Power = $('#CPower1').combobox('getText');
        var FactoryID = $('#CFactoryID1').val();
        var Gauge = $('#Gauge1').combobox('getText');
        var CutWidth = $('#CutWidth1').combobox('getText');
        var FeedVolume = $('#FeedVolume1').combobox('getText');
        var TrackType = $('#TrackType1').combobox('getText');
        var COutlineSize = $('#COutlineSize1').combobox('getText');
        var HarMachQuy = $('#HarMachQuy1').combobox('getText');
        var CManufactureDate = $('#CManufactureDate1').datebox('getValue');
        var Certdate1 = $('#Certdate1').datebox('getValue');
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
        if(serialNum!=''&& ProductNum!=''&& ZCHYJ!=''&& Power!=''&& FactoryID!=''&& Gauge!=''
            && CutWidth!=''&& FeedVolume!=''&& TrackType!=''&& COutlineSize!=''&& HarMachQuy!=''&&CManufactureDate!=''&&Certdate1!=''){
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
                                user: localStorage.getItem("User"),
                                ids:idb,
                                Certdate:Certdate1,
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    $.messager.alert('温馨提示', '修改成功');
                                    InspectionDate1 = date.substring(0,11)+"00:00:00";
                                    plant2 = plant1;
                                    c_query();
                                    ids='';
                                    CultivatorEditCancel();

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
                                user: localStorage.getItem("User"),
                                ids:ids,
                                Certdate:Certdate1,
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    $.messager.alert('温馨提示', '修改成功');
                                    InspectionDate1 = date.substring(0,11)+"00:00:00";
                                    plant2 =plant1;
                                    c_query();
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
        }else {
            $.messager.alert('温馨提示', '保存信息不完整!!!');
        }


    }
    function getGDX() {
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
                $('#CZCHYJ1').combobox('loadData', data);

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
                $('#CPower1').combobox('loadData', data);

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
                $('#CutWidth1').combobox('loadData', data);

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
                $('#Gauge1').combobox('loadData', data);

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
                $('#TrackType1').combobox('loadData', data);

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
                $('#COutlineSize1').combobox('loadData', data);
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
                $('#FeedVolume1').combobox('loadData',data);
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
                $('#HarMachQuy1').combobox('loadData', data);
            }
        });
    }

</script>
</body>
</html>

