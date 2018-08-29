<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-05-30
  Time: 13:13 拖拉机
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

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
    .ci9{
        letter-spacing:0.19em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }

    .ci3{
        letter-spacing:1.9em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }
    .ci2{
        letter-spacing:2.88em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }
    .ci5{
        letter-spacing:1.38em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */

    }
    .ci6{
        letter-spacing:0.78em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */

    }
    .ti9{
        letter-spacing:0.17em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-0.13em; /*同上*/
    }
    .ti10{
        letter-spacing:0.4em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-0.1em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }


</style>
<div class="easyui-layout" data-options="fit:true">
    <iframe style="display:none" id="printIframe" src=""></iframe>
    <div class="easyui-panel"title="拖拉机合格证" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:80px">
            <div class="wu-toolbar-button">
                <div id="test1"><input  id ="qadb2" style="width:110px" class="easyui-text" hidden="hidden"></div>
<shiro:hasPermission name="/Tractor/add">
                <a href="#" class="easyui-linkbutton"  onclick="t_add()" data-options="iconCls:'icon-add'" plain="true">新增</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Tractor/update">
                <a href="#" class="easyui-linkbutton"  onclick="t_update()" iconCls="icon-search"   plain="true">修改</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Tractor/delete">
                <a href="#" class="easyui-linkbutton"  onclick="t_delete()" iconCls="icon-delete"   plain="true">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/Tractor/print">
                <a href="#" class="easyui-linkbutton"  onclick="t_print()" iconCls="icon-print"   plain="true">打印</a>
</shiro:hasPermission>
                <%--<shiro:hasPermission name="/Tractor/print">--%>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="Export()" plain="true">导出</a>--%>
<%--</shiro:hasPermission>--%>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label>工厂：</label><select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="WERKS" panelHeight="auto" data-options="
                               valueField:'statusid',
                                textField:'statusname',
                                panelHeight:'250'"
                                                      style="width:100px">
                        </select></td>
                        <td><label>生产订单号：</label><input id="OrderID" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>序列号：</label><input id="serialID" class="easyui-textbox" style="width:150px">&nbsp</td>
                        <td><label>产品料号：</label><input id="ProductID" class="easyui-textbox" style="width:80px">&nbsp</td>
                        <td><label>起始检验日期：</label><input  id ="SInspectionDate" style="width:110px" class="easyui-datebox"></td>
                        <td><label>结束检验日期：</label><input  id ="EInspectionDate" style="width:110px" class="easyui-datebox"></td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="t_query()" data-options="iconCls:'icon-search'">查询</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true,border:true" >
                <table id="ti" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
            </div>
        </div>
    </div>
</div>
<div id="dlgtj" class="easyui-dialog"  title="固定项" style="width:50%; height: 68%;  padding: 10px;"
     closed="true" buttons="#dlgm-buttons">
    <form id="fmsave" method="post">
        <label>机型：</label><input id="ZTJX" class="easyui-textbox"  style="width:15%"><a href="#" class="easyui-linkbutton"  onclick="FindZT()" data-options="iconCls:'icon-search'" id="button2">查询</a><input type="text" style="height:20px;width:20%;border: 0px;outline:none;"><label><span class="ci4">发动机号码</span>：</label><input id="ZTFDJHM" class="easyui-textbox"  style="width:25%"><br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti2">序列号</span>：</label><input id="ZTserialNum" class="easyui-textbox"  style="width:25%">&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">产品料号</span>：</label><input id="ZTProductNum" class="easyui-textbox"  style="width:27%">&nbsp<br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti6">发动机型号</span>：</label><select class="easyui-combobox"  contenteditable="false" style="width:25%" name="MonthPlan-Plant" datatype="text" id="ZTZCHYJ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'ZCHYJ',
                                textField:'ZCHYJ',
                                panelHeight:'250'"
                                                              style="width:25%"></select>&nbsp&nbsp&nbsp&nbsp<label><span class="ti5">功率/KW</span>：</label>
        <select class="easyui-combobox" style="width:26.5%" name="MonthPlan-Plant" datatype="text" id="ZTPower" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'Power',
                                textField:'Power',
                                panelHeight:'250'"
                style="width:26.5%"></select><br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti3">生产订单</span>：</label><input id="ZTFactoryID"  class="easyui-textbox" style="width:25%">&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">机身颜色</span>：</label>
        <select class="easyui-combobox" name="takekind" datatype="text" id="ZTBodyColor"  panelHeight="auto" style="width:26%">
            <option value="红色" selected="selected">红色</option>
            <option value="蓝色">蓝色</option>
        </select><br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti5">轴距/mm</span>：</label>
        <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="ZTWheelBase" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'base',
                                textField:'base',
                                panelHeight:'250'"
                style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp<label>前轮距（规格）/mm：</label>
        <select class="easyui-combobox" style="width:14%" name="MonthPlan-Plant" datatype="text" id="ZTWheelSizeQ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'WheelSizeQ',
                                textField:'WheelSizeQ',
                                panelHeight:'250'"
                style="width:14%"></select>
        <select class="easyui-combobox" style="width:13%" name="MonthPlan-Plant" datatype="text" id="ZTTireSpectQ" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'TireSpectQ',
                                textField:'TireSpectQ',
                                panelHeight:'250'"
                style="width:13%"></select>
        <br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti2">轮胎数</span>：</label>
        <select class="easyui-combobox" name="takekind" datatype="text" id="ZTAxleNum"  panelHeight="auto" style="width:24%">
            <option value="4" selected="selected">4</option>
            <option value="6">6</option>
            <option value="2">2</option>
        </select>&nbsp&nbsp&nbsp&nbsp&nbsp<label>后轮距（规格）/mm：</label>
        <select class="easyui-combobox" style="width:14%" name="MonthPlan-Plant" datatype="text" id="ZTWheelSizeH" panelHeight="auto" data-options="
                               required:'true',
                                valueField:'WheelSizeH',
                                textField:'WheelSizeH',
                                panelHeight:'250'"
                style="width:14%"></select>
        <select class="easyui-combobox" style="width:13%" name="MonthPlan-Plant" datatype="text" id="ZTTireSpectH" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'TireSpectH',
                                textField:'TireSpectH',
                                panelHeight:'250'"
                style="width:13%"></select><br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti3">外廓尺寸</span>：</label>
        <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="ZTOutlineSize" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'OutlineSize',
                                textField:'OutlineSize',
                                panelHeight:'250'"
                style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp&nbsp<label><span class="ti10">标定牵引力/N</span>：</label>
        <select class="easyui-combobox" style="width:27%" name="MonthPlan-Plant" datatype="text" id="ZTDemarcatedForce" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'force',
                                textField:'force',
                                panelHeight:'250'"
                style="width:27%"></select>
        <br>
        <input type="text" style="height:20px;border: 0px;outline:none;"><br>
        <label><span class="ti9">最小使用质量/kg</span>：</label>
        <select class="easyui-combobox" style="width:24%" name="MonthPlan-Plant" datatype="text" id="ZTMinUse" panelHeight="auto" data-options="
                                required:'true',
                                valueField:'MinUse',
                                textField:'MinUse',
                                panelHeight:'250',
                               "
                style="width:24%"></select>&nbsp&nbsp&nbsp&nbsp&nbsp<label><span class="ti3">生产日期</span>：</label><input id="ZTManufactureDate" class="easyui-datebox" style="width:27%" data-options="required:true">&nbsp<br>

        <div  style="text-align: right;margin-top: 3%">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="AddZT()" iconcls="icon-save">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="CanceldaZT()" iconcls="icon-cancel">取消</a>
        </div>
    </form>


</div>
<script type="text/javascript">
    $("#trt_More").hide();
    $("#test1" ).css("display", "none");
    var DQH = '';//当前行
    var XS ='';
    var temID="";
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#SInspectionDate').val(year+"-"+month+"-"+day);
        $('#EInspectionDate').val(year+"-"+month+"-"+day);
        $('#qadb2').val(year+"-"+month+"-"+day);
        var db = $('#qadb2');
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
        getGC();//获取工厂
    });
    function getGC() {
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
                $('#WERKS').combobox('loadData', data);
                $('#TWERKS').combobox('loadData', data);

            }
        });
    }
    var deleteid = '';
    function t_delete () {
        var WERKS1 = localStorage.getItem("Department");
        var WERKS = $('#WERKS').combobox('getText');
        alert(WERKS1);
        alert(WERKS);
        if(WERKS1==WERKS ||WERKS1=='信息中心'){
            var row = $("#ti").datagrid("getSelected");
            var selRow = $('#ti').datagrid('getSelections');//多选删除
            if(selRow.length <0||row==null){
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else{
                $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                    if (r) {
                        //批量行数据id
                        for (var b = 0; b< selRow.length;b++) {
                            if (deleteid =="") {
                                deleteid = selRow[b].id;
                            } else {
                                deleteid = selRow[b].id + "," + deleteid;
                            }
                        }
                        $.ajax({
                            type:"post",
                            url: "${pageContext.request.contextPath}/Tractor/Deletedata.action",//要发送的后台地址
                            data:{
                                id:deleteid,
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data1) {//ajax请求成功后触发的方法
                                console.log(data1);
                                if (data1.num !=-1) {
                                    $.messager.alert('温馨提示', '删除成功');
                                    t_query();
                                    deleteid='';
                                    getGC();
                                }else {
                                    $.messager.alert('温馨提示', '删除失败');
                                }

                            },
                        })
                    }
                })
            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂删除!");
            getGC();
        }

    }
    var ids = '';
    var Zfdjh = '';
    var AUFNR = '';
    var ZMACH = '';

    function t_update () {
        var WERKS1 = localStorage.getItem("Department");
        var WERKS = $('#WERKS').combobox('getText');
        if(WERKS1==WERKS||WERKS1=='信息中心'){
            var rows = $("#ti").datagrid("getSelections");
            if(rows.length==0) {
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else {
                if(rows.length<2){
                    parent.$.modalDialog({
                        width : '50%',
                        height : '72%',
                        href : '${ctxPath }/TractorEdit',
                        buttons : [
                            {
                                text : '确认',
                                iconCls: "icon-save",
                                handler : function() {
                                    Add2();
                                    getGC();
                                }
                            },
                            {
                                text: "取消",
                                iconCls: "icon-cancel",
                                handler:function(){
                                    TractorEditCancel();
                                    getGC();
                                }
                            }
                        ]
                    });
                }else {
                    $.messager.alert('信息提示', '请选择一条数据修改！');
                }

            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂修改!");
            getGC();
        }


//
    }
    function CanceldaJ () {
        $('#dlgj2').dialog("close");
    }
    var temID="";
    var InspectionDate='';
    function t_query() {
        $('#ti').datagrid('clearSelections');
        var ProductID  = $('#ProductID').val();//物料编码
        var serialID = $('#serialID').val();//物料描述
        var OrderID = $('#OrderID').val();
        var WERKS = $('#WERKS').combobox('getText');
        var WERKS1 = localStorage.getItem("Department");
        var starttime = $('#SInspectionDate').datebox('getValue');
        var endtime = $('#EInspectionDate').datebox('getValue');
        var fdata;
        var WERKS1 = localStorage.getItem("Department");
        var WERKS = $('#WERKS').combobox('getText');
        if(WERKS1==WERKS||WERKS1=='信息中心'){
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${pageContext.request.contextPath}/Tractor/serach.action",//要发送的后台地址
                data: {
                    ProductID:ProductID,
                    serialID:serialID,
                    OrderID:OrderID,
                    plant2:WERKS,
                    starttime:starttime,
                    endtime:endtime,
                    InspectionDate:InspectionDate,
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if(data.total>0){
                        $.messager.progress('close');
                        console.log(data);
                        fdata = data;
                        InspectionDate  = '';
                        $("#ti").datagrid({
                            idField:'id',
                            loadFilter:pagerFilter,
                            rownumbers:true,
                            pageList:[50,100,200],//分页列表
                            pagination:true,
                            multiSort:true,
                            remoteSort:false,
                            fit: false, //自动适屏功能
                            nowrap:false,
                            width:'auto',
                            singleSelect: false, //允许选择多行
                            //fitColumns:true,
                            //fit:true,
                            method:'get',
                            data:fdata,
                            //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                            columns:[[
                                {field:'ck', checkbox: true, width: '30' },  //复选框
                                {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                                {field:'plant',title:'工厂',width: '90px',align:'center',halign:'center'},
                                {field:'plantins',title:'工厂描述',width: '90px',align:'center',halign:'center'},
                                {field:'orderid',title:'订单号',width: '120px',align:'center',halign:'center'},
                                {field:'serialid',title:'序列号',width: '120px',align:'center',halign:'center'},
                                {field:'inspectiondate',title:'检验日期',width: '200px',align:'center',halign:'center'},
                                {field:'productid',title:'产品料号',width: '120px',align:'center',halign:'center'},
                                {field:'certid',title:'合格证编号',width: '280px',align:'center',halign:'center'},
                                {field:'certdate',title:'发证日期',width: '150px',align:'center',halign:'center'},
                                {field:'companyname',title:'生产企业名称',width: '180px',align:'center',halign:'center'},
                                {field:'brand',title:'品牌',width: '100px',align:'center',halign:'center'},
                                {field:'type',title:'类型',width: '100px',align:'center',halign:'center'},
                                {field:'zcpxh',title:'型号名称',width: '180px',align:'center',halign: 'center'},
                                {field:'zchyj',title:'发动机型号',width: '150px',align:'center',halign:'center'},
                                {field:'zfdjh',title:'发动机号码',width: '100px',align:'center',halign:'center'},
                                {field:'zmach',title:'厂内机型',width: '150px',align:'center',halign:'center'},
                                {field:'power',title:'功率/kW',width: '100px',align:'center',halign:'center'},
                                {field:'emissionstd',title:'排放标准号及排放阶段',width: '150px',align:'center',halign:'center'},
                                {field:'factoryid',title:'出厂编号',width: '120px',align:'center',halign:'center'},
                                {field:'zseri',title:'底盘号',width: '120px',align:'center',halign:'center'},
                                {field:'bodycolor',title:'机身颜色',width: '100px',align:'center',halign:'center'},
                                {field:'controlmode',title:'转向操纵方式',width: '100px',align:'center',halign:'center'},
                                {field:'number',title:'准乘人数',width: '100px',align:'center',halign:'center'},
                                {field:'axlenum',title:'轮轴数',width: '100px',align:'center',halign:'center'},
                                {field:'wheelbase',title:'轴距/mm',width: '100px',align:'center',halign:'center'},
                                {field:'tiresnum',title:'轮胎数',width: '100px',align:'center',halign:'center'},
                                {field:'tirespect',title:'轮胎规格',width: '250px',align:'center',halign:'center'},
                                {field:'wheelsize',title:'轮距（前/后）/mm',width: '120px',align:'center',halign:'center'},
                                {field:'tracknumber',title:'履带数',width: '100px',align:'center',halign:'center'},
                                {field:'tracktype',title:'履带规格',width: '200px',align:'center',halign:'center'},
                                {field:'gauge',title:'轨距/mm',width: '100px',align:'center',halign:'center'},
                                {field:'outlinesize',title:'外廓尺寸/mm',width: '200px',align:'center',halign:'center'},
                                {field:'demarcatedforce',title:'标定牵引力/n',width: '100px',align:'center',halign:'center'},
                                {field:'minuse',title:'最小使用质量/kg',width: '120px',align:'center',halign:'center'},
                                {field:'maxload',title:'最大允许载质量/kg',width: '120px',align:'center',halign:'center'},
                                {field:'manufacturedate',title:'生产日期',width: '200px',align:'center',halign:'center'},
                                {field:'execstd',title:'执行标准/企标',width: '500px',align:'center',halign:'center'},
                                {field:'checkdate',title:'检验日期',width: '200px',align:'center',halign:'center'},
                            ]],
                        });
                    }else {
                        InspectionDate  ='';
                    }
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    alert(msg);//弹出错误信息
                }
            });
            $('#ti').datagrid('loadData',{total:0,rows:[]});
        }else {
            $.messager.alert("温馨提示","不能跨工厂查询!");
            getGC();
        }



    }
   function Export() {
       var ProductID  = $('#ProductID').val();//物料编码
       var serialID = $('#serialID').val();//物料描述
       var OrderID = $('#OrderID').val();
       var WERKS = $('#WERKS').combobox('getText');
       var WERKS1 = localStorage.getItem("Department");
       var starttime = $('#SInspectionDate').datebox('getValue');
       var endtime = $('#EInspectionDate').datebox('getValue');
       if(WERKS1==WERKS||WERKS1=='信息中心'){
           var url = "../${pageContext.request.contextPath}/Export/Export?ProductID="+ProductID+"&serialID="+serialID+"&OrderID="+OrderID+"&WERKS="+WERKS+"&starttime="+starttime+"&endtime="+endtime+"";
           window.location.href = url;
       }else {
           $.messager.alert("温馨提示","不能跨工厂导出!");
           getGC();
       }
   }
    function doPrint(){
        $("#printIframe")[0].contentWindow.print();
        t_query();
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
    function  t_add() {
        var WERKS1 = localStorage.getItem("Department");
        var WERKS = $('#WERKS').combobox('getText');
        if(WERKS1==WERKS||WERKS1=='信息中心'){
            if(WERKS=='重拖事业部'){
                $("#dlgtj").dialog({
                    title: '固定项',
                    width: 850,
                    height:480,
                    modal: true,
                });
                $('#dlgtj').dialog("open");
            }else {
                parent.$.modalDialog({
                    width : '78%',
                    height : '70%',
                    href : '${pageContext.request.contextPath}/TractorAdd',
                    buttons : [
                        {
                            text: "取消",
                            iconCls: "icon-cancel",
                            handler:function(){
                                TractorAddCancel();
                            }
                        }
                    ]
                });
            }

        }else {
            $.messager.alert("温馨提示","不能跨工厂添加!");
            getGC();
        }

    }
    function CanceldaZT () {
        $("#dlgtj").dialog("close");
        $("#fmsave").form('clear');
    }
    $("#ZTWheelSizeH").combobox({

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
                    $('#ZTTireSpectH').combobox('loadData',data);
                }
            });

        }

    });
    $("#ZTWheelSizeQ").combobox({

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
                    $('#ZTTireSpectQ').combobox('loadData',data);
                }
            });

        }

    });
    function oncilick2() {
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
                $('#ZTZCHYJ').combobox('loadData', data);

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
                $('#ZTPower').combobox('loadData', data);

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
                $('#ZTWheelBase').combobox('loadData', data);

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
                $('#ZTOutlineSize').combobox('loadData', data);
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
                $('#ZTMinUse').combobox('loadData', data);
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
                $('#ZTWheelSizeQ').combobox('loadData', data);
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
                $('#ZTWheelSizeH').combobox('loadData',data);
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
                $('#ZTDemarcatedForce').combobox('loadData',data);
            }
        });
    }
    function FindZT() {
        var s = $('#ZTJX').val();
        var m = $('#ZTserialNum').val();//序列号
        var FDJHM1 = $('#ZTFDJHM').val();//发动机
        var CserialNum1 = $('#ZTserialNum').val();//底盘号
        var CFactoryID1 = $('#ZTFactoryID').val();//出厂编号
        if(s!=''&&m!=''&&FDJHM1!=''&&FDJHM1!=''&&CFactoryID1!=''){
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
                        oncilick2();
                        $.ajax({
                            type:"post",
                            url: "${pageContext.request.contextPath}/Tractor/Juge.action",//要发送的后台地址
                            data:{
                                ZSERI:CserialNum1,
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data1) {//ajax请求成功后触发的方法
                                console.log(data1);
                                if (data1.num !=-1) {
                                    var row = new Array();
                                    row = data1.rows;
                                    $('#ZTJX').textbox('setValue',row[0].zmach);
                                    $('#ZTZCHYJ').textbox('setValue',row[0].zchyj);
                                    $('#ZTPower').textbox('setValue',row[0].power);
                                    $('#ZTBodyColor').textbox('setValue',row[0].bodycolor);
                                    $('#ZTWheelBase').textbox('setValue',row[0].wheelbase);
                                    var myArray=new Array();
                                    myArray = row[0].wheelsize.split("|");
                                    var WheelSizeQ = myArray[0];
                                    var WheelSizeH = myArray[1];
                                    var myArray1=new Array();
                                    myArray1 = row[0].tirespect.split("|");
                                    var TireSpectQ = myArray1[0];
                                    var TireSpectH = myArray1[1];
                                    $('#ZTWheelSizeQ').textbox('setValue', TireSpectQ);//前轮
                                    $('#ZTWheelSizeH').textbox('setValue', TireSpectH);//后轮
                                    $('#ZTAxleNum').textbox('setValue',row[0].tiresnum);
                                    $('#ZTTireSpectQ').textbox('setValue',  WheelSizeQ);//前 规格
                                    $('#ZTTireSpectH').textbox('setValue',WheelSizeH);//后规格
                                    $('#ZTOutlineSize').textbox('setValue',row[0].outlinesize);
                                    $('#ZTDemarcatedForce').textbox('setValue',row[0].demarcatedforce);
                                    $('#ZTMinUse').textbox('setValue',row[0].minuse);
                                    $('#ZTManufactureDate').datebox('setValue', row[0].manufacturedate);
                                }else {
                                    $('#ZTZCHYJ').textbox('setValue','');
                                    $('#ZTPower').textbox('setValue','');
                                    $('#ZTBodyColor').textbox('setValue','');
                                    $('#ZTWheelBase').textbox('setValue','');
                                    $('#ZTWheelSizeQ').textbox('setValue','');
                                    $('#ZTWheelSizeH').textbox('setValue','');
                                    $('#ZTAxleNum').textbox('setValue',4);
                                    $('#ZTTireSpectQ').textbox('setValue','');
                                    $('#ZTTireSpectH').textbox('setValue','');
                                    $('#ZTOutlineSize').textbox('setValue','');
                                    $('#ZTDemarcatedForce').textbox('setValue','');
                                    $('#ZTMinUse').textbox('setValue','');
                                }

                            },
                        })
                    }else {
                        $.messager.alert("温馨提示","请维护机型数据!!!");//请维护机型数据
                    }
                }
            });
        }else{
            $.messager.alert("温馨提示","请输入数据!!!");//请维护机型数据
        }

    }
    function  t_print () {
        var WERKS1 = localStorage.getItem("Department");
        var WERKS = $('#WERKS').combobox('getText');
        if(WERKS1==WERKS ||WERKS1=='信息中心'){
            var row = $("#ti").datagrid("getSelected");
            var selRow = $('#ti').datagrid('getSelections');
            if(selRow.length ==0){
                $.messager.alert('信息提示','请选中合格证','info');
            }else{
                //批量行数据id
                for (var i = 0; i < selRow.length;i++) {
                    if (temID =="") {
                        temID = selRow[i].id;
                    } else {
                        temID = selRow[i].id + "," + temID;
                    }
                }
                var src = $("#printIframe").attr("src");
                document.getElementById("printIframe").contentWindow.document.body.innerText = "";
                <%--$("#printIframe").attr("src","${pageContext.request.contextPath}/Cultivator/irprint.action?serialno="+row.id);//暂时静态PDF文件--%>
                $("#printIframe").attr("src","${pageContext.request.contextPath}/Tractor/irprint.action?serialno="+temID);//暂时静态PDF文件
                $("#printIframe").load(function(){
                    temID="";
                    $('#dialogtable').datagrid('clearSelections');
                    doPrint();
                });
            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂打印!");
            getGC();
        }

    }
    var sn = '';
    function AddZT () {

        var ProductNum = $('#ZTProductNum').val();
        var ZCHYJ = $('#ZTZCHYJ').combobox('getText');
        var Power = $('#ZTPower').combobox('getText');
        var FactoryID = $('#ZTFactoryID').val();
        var  ZTFDJHM = $('#ZTFDJHM').val();//发动机号码
        var BodyColor = $('#ZTBodyColor').combobox('getText');
        var WheelBase = $('#ZTWheelBase').combobox('getText');
        var WheelSizeQ = $('#ZTWheelSizeQ').combobox('getText');
        var WheelSizeH = $('#ZTWheelSizeH').combobox('getText');
        var AxleNum = $('#ZTAxleNum').combobox('getText');
        var TireSpectQ = $('#ZTTireSpectQ').combobox('getText');
        var TireSpectH = $('#ZTTireSpectH').combobox('getText');
        var OutlineSize = $('#ZTOutlineSize').combobox('getText');
        var DemarcatedForce = $('#ZTDemarcatedForce').combobox('getText');
        var MinUse = $('#ZTMinUse').combobox('getValue');
        var ManufactureDate = $('#ZTManufactureDate').datebox('getValue');
        var plant = $('#WERKS').combobox('getText');
        var plant1 = $('#WERKS').combobox('getValue');
        var serialNum1 = $('#ZTJX').val();
        var serialNum = $('#ZTserialNum').val();
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
        if(serialNum1!=''&&serialNum!=''&& ProductNum!=''&& ZCHYJ!=''&& Power!=''&& FactoryID!=''&& BodyColor!=''
            && WheelBase!=''&& WheelSizeQ!=''&& WheelSizeH!=''&& AxleNum!=''&& TireSpectQ!=''
            && TireSpectH!=''&& OutlineSize!=''&& DemarcatedForce!=''&& MinUse!=''&& ManufactureDate!=''&&ZTFDJHM!=''){

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
                                Zfdjh:ZTFDJHM,
                                AUFNR:FactoryID,
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
                                Zfdjh:ZTFDJHM,
                                AUFNR:FactoryID,
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
                                ids:ids,
                                user: name,
                                time:time,
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if(data.num>0){
                                    if(XS=='1'){
                                        $.messager.alert('温馨提示', '保存成功');
                                        t_query();
                                        ids='';
                                    }else {
                                        $.messager.alert('温馨提示', '保存成功');
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
</script>

