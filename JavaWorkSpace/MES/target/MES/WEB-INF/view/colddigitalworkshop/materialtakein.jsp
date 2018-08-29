<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .A{
        width:50%;
        height:75%;
    }
    .B{
        width: 10%;
        height: 75%;
    }
    .C{
        width:50%;
        height:75%;
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 78px);
    }
    .divmore{
        margin-left: -5px;
        padding: 10px 10px 10px 10px;
        /*border: 1px solid red;*/
        border-right: 1px solid #E0EEEE;
        border-bottom: 1px solid #E0EEEE;
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <div class="easyui-panel" title="材料接收" data-options="fit:true">
            <div id="mti_toolbar" style="overflow:auto;width:100%;height: 78px">
                <div class="wu-toolbar-button" style="border-bottom: 1px #D4D4D4 solid">
                    <shiro:hasPermission name="/mti/Print">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="mti_Print()" plain="true">打印</a>
                    </shiro:hasPermission>
                    <span>丨</span>
                    <spam></spam>
                    <select class="easyui-combobox" name="freelnum" datatype="text" id="mti_freelnum" panelHeight="auto" data-options="
                                valueField:'freelnum',
                                textField:'freelnum',
                                panelHeight:'250',
                                 panelWidth:'150'"
                            style="width:100px">
                    </select>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="mti_searchreelnum()" >查询炉批号</a>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>--%>
                    <spam>炉批号：</spam><input id="mti_reelnum" class="easyui-textbox" type="text" style="width:100px" >
                    <spam></spam><input id="mti_vbeln" class="easyui-textbox" type="text" style="width:100px" >
                    <spam></spam><input id="mti_weight" class="easyui-textbox" type="text" style="width:50px" >
                    <spam></spam><input id="mti_specification" class="easyui-textbox" type="text" style="width:100px" >
                    <spam></spam><input id="mti_materialtype" class="easyui-textbox" type="text" style="width:100px" >
                    <spam></spam><input id="mti_steelworks" class="easyui-textbox" type="text" style="width:100px" >
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <table>
                        <tr>
                            <td><label>查询年月：</label></td><td><input  id ="mti_dbk" style="width:100px" ></td>
                            <!--class="easyui-datebox"-->
                            <td><label><span class="w3">事业部</span>：</label></td>
                            <td><select class="easyui-combobox" name="Plant" datatype="text" id="mti_Plant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250',
                                required:true"
                                    style="width:100px">

                            </select></td>
                            <td><label>采购订单：</label><td><input id="mti_PoNo" class="easyui-textbox" style="width:100px" onkeypress="mti_getKey()"></td>
                            <td><label>供应商代码：</label></td><td><input id="mti_SupportNo" class="easyui-textbox" data-options="required:true" style="width:100px" ></td>
                            <td><label>供应商名称：</label></td><td><input id="mti_SupportName" class="easyui-textbox" style="width:100px" onkeypress="mti_getKey()"></td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="mti_forGetDate()" data-options="iconCls:'icon-search'">查询</a></td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="mti_showMore()" data-options="iconCls:'icon-search'">更多</a></td>
                            <td style="width: 20px"></td>
                            <shiro:hasPermission name="/mti/SAPtakeIn">
                            <td><a href="#" class="easyui-linkbutton"  onclick="mti_SAPtakeIn()" data-options="iconCls:'icon-search'">SAP采购收货</a></td>
                            </shiro:hasPermission>
                            <%--<shiro:hasPermission name="/mti/SAPQualityToUnrestricted">--%>
                            <%--<td><a href="#" class="easyui-linkbutton"  onclick="mti_SAPQualityToUnrestricted()" data-options="iconCls:'icon-search'">SAP质检至非限制</a></td>--%>
                            <%--</shiro:hasPermission>--%>
                            <shiro:hasPermission name="/mti/SAPtakeReturn">
                            <td><a href="#" class="easyui-linkbutton"  onclick="mti_SAPtakeReturn()" data-options="iconCls:'icon-search'">SAP采购退货</a></td>
                            </shiro:hasPermission>
                        </tr>

                    </table>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white;display: none" id="mti_More">
                        <table>
                            <tr>
                                <td><input type="checkbox" id="mti_bzflag" name="mti_bzflag" checked="1" value="3"/>&nbsp <label>只查当日入库记录</label></td>
                            </tr>
                        </table>
                    </div>
                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <iframe id="proxy" hidden style="display: none;"></iframe>
            <div class="easyui-layout haorooms"  >
                <div class="A" data-options="region:'west',split:true" >
                    <div id="mti_cc" class="easyui-layout" data-options="fit:true" style="width:100%;height:auto">
                        <div style="width: 100%;height:30%" data-options="region:'center'">
                            <table id="mti_po" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="采购订单数据" data-options="singleSelect:true,onClickRow:mti_poOnClickRow"></table>
                            <%--<div class = "divmore" style="width: 95%;height:15% " >--%>
                                <%--<table>--%>
                                    <%--<tr>--%>
                                        <%--<td><label>采购组织：</label></td><td><input id="mti_EKORG" class="wu-text" style="width:100px"></td>--%>
                                        <%--<td><label>采购组描述：</label></td><td><input id="mti_EKGRPName" class="wu-text" style="width:100px"></td>--%>
                                        <%--<td><label>公司代码：</label></td><td><input id="mti_BUKRS" class="wu-text" style="width:100px"></td>--%>

                                    <%--</tr>--%>
                                    <%--<tr>--%>
                                        <%--<td><label>采购组：</label></td><td><input id="mti_EKGRP" class="wu-text" style="width:100px"></td>--%>
                                        <%--<td><label>采购组织描述：</label></td><td><input id="mti_EKORGName" class="wu-text" style="width:100px"></td>--%>
                                        <%--<td><label>创建日期：</label></td><td><input id="mti_PoCreatTime" class="wu-text" style="width:100px"></td>--%>
                                    <%--</tr>--%>
                                <%--</table>--%>
                            <%--</div>--%>
                        </div>

                        <div style="height: 50%" data-options="region:'south',split:false" class="easyui-panel">
                            <table id="mti_poitems" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="采购订单行项目" data-options="singleSelect:true,onClickRow:mti_poitemsOnClickRow"></table>
                        </div>
                    </div>
                </div>

                <div class="B" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
                        <shiro:hasPermission name="/mti/go">
                            <button id="mti_go" onclick="mti_go()"  class="easyui-linkbutton" style="margin-top: 100px">接收</button>
                        </shiro:hasPermission>
                    </div>
                    <div style="">
                        <shiro:hasPermission name="/mti/back">
                            <button id="mti_back" class="easyui-linkbutton" onclick="mti_back()">删除</button>
                        </shiro:hasPermission>
                    </div>
                </div>
                <div class="C"  data-options="region:'east',split:true">
                    <table class="easyui-datagrid" id="mti_takemsg" title="收货记录" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,onClickRow:mti_takemsgonClickRow,editor:'text'" ></table>
                </div>


            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        $('#mti_dbk').val(year+"-"+month);
        var db = $('#mti_dbk');
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
//    getMplan();
//    getKCard();
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/Syb/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#mti_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/RshipMaintenanceController/selectALLSelect.action',
            dataType: "json",
            data: {
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
//                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#mti_freelnum').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("input[name='MDMKCardCheck']").eq(0).attr("checked","checked");
        $("#mti_More").hide();
        $("#mti_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#mti_More").hide();

        });
        $('#mti_SupportNo').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mti_forGetDate();
                    }
                }
            })
        });
    });

    function mti_getKey() {
        if(event.keyCode==13){
            mti_forGetDate();
        }
    }
    function mti_searchreelnum() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/RshipMaintenanceController/selectbyfreelnum.action',
            dataType: "json",
            data: {
                freelnum: $("#mti_freelnum").combobox("getValue")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
//                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#mti_reelnum').textbox('setValue', data.reelnum);
                $('#mti_vbeln').textbox('setValue', data.vbeln);
                $('#mti_weight').textbox('setValue', data.weight);
                $('#mti_specification').textbox('setValue', data.specification);
                $('#mti_materialtype').textbox('setValue', data.materialtype);
                $('#mti_steelworks').textbox('setValue', data.steelworks);
                //alert(11111);

            }
        });
    }
    function mti_showMore() {
        $("#mti_More").toggle();
    }
    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }
    function mti_go() {
        var myDate = new Date();
        var plant=  $('#mti_Plant').combobox('getText');

        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var day = myDate.getDate();
        //alert(time);
        var username = localStorage.getItem("User");
        var row  = $('#mti_poitems').datagrid("getSelected");
        var rowhead = $('#mti_po').datagrid("getSelected");
        var LeaveNumber = 0;
        if(row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else {
            var data = $('#mti_takemsg').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if (mti_endEditing()){
                   $.ajax({
                    type: "post",//数据发送的方式（post 或者 get）
                    url: "${ctxPath }/Materialtakein/selectColdmaterlinLeaveNumber.action",//要发送的后台地址
                    data: {
                        pono: rowhead.EBELN,
                        poitem: row.EBELP
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
//                    alert(Number(data.number));
                        console.log(data);
                        LeaveNumber = data.number;
//                        alert(Number(data.number)+"====="+Number(row.L_MENGE));
                        if (Number(data.number) < Number(row.L_MENGE)) {
                            if (mti_endEditing()) {
                                //alert(1231231);
                                $('#mti_takemsg').datagrid('appendRow', {
                                    PoNo: rowhead.EBELN,
                                    PoItem: row.EBELP,
                                    fno: row.MATNR,
                                    fname: row.TXZ01,
                                    materialtype:$('#mti_materialtype').val(),
                                    steelworks:$('#mti_steelworks').val(),
                                    Number: $('#mti_weight').val(),//手输
                                    PoNumber: row.MENGE,
                                    TakeNumber: row.T_MENGE,
                                    LeftNumber: row.L_MENGE,
                                    isok: true,
                                    LGORT: row.LGORT,
                                    unit: row.MEINS,
                                    inputman: username,
                                    //inputdate: row.inputdate,
                                    isMove: false,
                                    //Moveman: row.Moveman,
                                    //Movedate: row.Movedate,
                                    plant: plant,
                                    UpLimit: row.UEBTO,
                                    DownLimit: row.UNTTO,
                                    IsDone: row.ELIKZ,
                                    uyear: uyear,
                                    umonth: umonth,
                                    SupportNo: rowhead.LIFNR,
                                    SupportName: rowhead.NAME1,
                                    EKORG: $("#mti_EKGRP").val(),
                                    EKORGName: $("#mti_EKORGName").val(),
                                    EKGRP: $("#mti_EKORG").val(),
                                    EKGRPName: $("#mti_EKGRPName").val(),
                                    PoCreatTime: $("#mti_PoCreatTime").val(),
                                    BUKRS: $("#mti_BUKRS").val(),
                                    MoveOk: false,
                                    ReturnOk: false,
                                    StockType: "质检",
                                    //MaterialDoc: row.MaterialDoc,
                                    //MaterialDocYear: row.MaterialDocYear,
                                    //MaterialDocItem: row.MaterialDocItem,
                                    BatchNo: $('#mti_reelnum').val(),//手输
                                    IsTrans: false,
                                    //TransMan: row.TransMan,
                                    //TransDate: row.TransDate,
                                    MoneyState: row.MoneyState,
                                    NETPR: row.NETPR,
                                    PEINH: row.PEINH
                                    //location: row.location,
                                });
                                editIndex = $('#mti_takemsg').datagrid('getRows').length - 1;
                                $('#mti_takemsg').datagrid('selectRow', editIndex)
                                    .datagrid('beginEdit', editIndex);
                                $('.datagrid-editable .textbox,.datagrid-editable .datagrid-editable-input,.datagrid-editable .textbox-text').keydown(function (e) {
                                    var code = e.keyCode || e.which;
                                    if (code === 13) {

                                        if ($('#mti_takemsg').datagrid('validateRow', editIndex)) {


                                            $('#mti_takemsg').datagrid('endEdit', editIndex);
                                            var rowkc = $('#mti_takemsg').datagrid('getRows');
                                            var rowData = rowkc[editIndex];
                                            $.messager.confirm('温馨提示', '你确定要保存吗?', function (r) {
                                                if (r) {

                                                    if (parseInt(Number(rowData.Number) + Number(LeaveNumber)) > parseInt(row.L_MENGE)*1.1) {
                                                        $.messager.alert('温馨提示', '超出采购数量！！');
                                                        $('#mti_takemsg').datagrid('cancelEdit', editIndex)
                                                            .datagrid('deleteRow', editIndex);
                                                    } else {

                                                        $.ajax({
                                                            type: "post",//数据发送的方式（post 或者 get）
                                                            url: "${ctxPath }/Materialtakein/insertColdmsg.action",//要发送的后台地址
                                                            data: {
                                                                PoNo: rowData.PoNo,
                                                                PoItem: rowData.PoItem,
                                                                fno: rowData.fno,
                                                                fname: rowData.fname,
                                                                Number: rowData.Number,
                                                                PoNumber: rowData.PoNumber,
                                                                TakeNumber: rowData.TakeNumber,
                                                                LeftNumber: rowData.LeftNumber,
                                                                materialtype:rowData.materialtype,
                                                                steelworks:rowData.steelworks,
                                                                isok: rowData.isok,
                                                                LGORT: rowData.LGORT,
                                                                unit: rowData.unit,
                                                                inputman: rowData.inputman,
//                                                    inputdate: rowData.inputdate,
                                                                isMove: rowData.isMove,
//                                                    Moveman: rowData.Moveman,
//                                                    Movedate: rowData.Movedate,
                                                                plant: rowData.plant,
                                                                UpLimit: rowData.UpLimit,
                                                                DownLimit: rowData.DownLimit,
                                                                IsDone: rowData.IsDone,
                                                                uyear: rowData.uyear,
                                                                umonth: rowData.umonth,
                                                                SupportNo: rowData.SupportNo,
                                                                SupportName: rowData.SupportName,
                                                                EKORG: rowData.EKORG,
                                                                EKORGName: rowData.EKORGName,
                                                                EKGRP: rowData.EKGRP,
                                                                EKGRPName: rowData.EKGRPName,
                                                                PoCreatTime: rowData.PoCreatTime,
                                                                BUKRS: rowData.BUKRS,
                                                                MoveOk: rowData.MoveOk,
                                                                ReturnOk: rowData.ReturnOk,
                                                                StockType: rowData.StockType,
//                                                    MaterialDoc: rowData.MaterialDoc,
//                                                    MaterialDocYear: rowData.MaterialDocYear,
//                                                    MaterialDocItem: rowData.MaterialDocItem,
                                                                BatchNo: rowData.BatchNo,
                                                                IsTrans: rowData.IsTrans,
//                                                    TransMan: rowData.TransMan,
//                                                    TransDate: rowData.TransDate,
                                                                MoneyState: rowData.MoneyState,
                                                                NETPR: rowData.NETPR,
                                                                PEINH: rowData.PEINH,
                                                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}

                                                            dataType: "json",//后台处理后返回的数据格式
                                                            success: function (data) {//ajax请求成功后触发的方法
                                                                if (data.num > 0) {
                                                                    mti_getcold(rowhead);
                                                                    $('#mti_reelnum').textbox('setValue', '');
                                                                    $('#mti_vbeln').textbox('setValue', '');
                                                                    $('#mti_weight').textbox('setValue', '');
                                                                    $('#mti_specification').textbox('setValue', '');
                                                                    $('#mti_materialtype').textbox('setValue', '');
                                                                    $('#mti_steelworks').textbox('setValue', '');
                                                                    $.messager.alert('温馨提示', '保存成功！');
//
                                                                }
                                                            },
                                                            error: function (msg) {//ajax请求失败后触发的方法
                                                                $.messager.alert('温馨提示', '出错了！');
                                                            }
                                                        });
                                                    }
                                                }
                                            });

                                        } else {
                                            $.messager.alert('温馨提示', '请完善好数据再保存!')
                                        }
                                    }
                                });
                            }
                            else {
                                $.messager.alert('温馨提示', '存在未编辑完数据!');
                            }
                        } else {
                            $.messager.alert('温馨提示', '此行项目已完成收货，只需进行SAP采购收货即可!')
                        }
                    }
                });
            }else{
                $.messager.alert('温馨提示', '存在未保存的数据!');
            }
        }
    }


    /**
     * Name 退回按钮
     */
    function mti_back() {
        var row  = $('#mti_takemsg').datagrid("getSelected");
        var rowhead = $("#mti_po").datagrid("getSelected");
        //alert(row.id);
        if(row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else {
            var ismove = row.isMove;
            if (ismove ===true){
                $.messager.alert('温馨提示', '此行项目已进行SAP收货，无法删除！！');
            }else{
                $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                    if (r) {
                        if (row.id === undefined) {
                            if (editIndex == undefined) {
                                return
                            }
                            $('#mti_takemsg').datagrid('cancelEdit', editIndex)
                                .datagrid('deleteRow', editIndex);
                            editIndex = undefined;
                        } else {
                            $.ajax({
                                type: "post",
                                url: "${ctxPath }/Materialtakein/deletecoldmsg.action",
                                data: {
                                    id: row.id,
                                    fno:row.fno,
                                    fname:row.fname,
                                    plant:row.plant,
                                    number:row.Number
                                },
                                dataType: "json",//后台处理后返回的数据格式
                                success: function (data) {//ajax请求成功后触发的方法
                                    if (data.num > 0) {
                                        //对库存数据进行恢复。
                                        mti_getcold(rowhead);
                                        $.messager.alert('温馨提示', '删除成功!');

                                    }
                                }
                            });
                        }
                    }
                })
            }
        }
    }
    /**
     * Name 搜索按钮事件
     */
    function mti_forGetDate() {
        var plant = $("#mti_Plant").combobox("getText");
        var SupportNo = $("#mti_SupportNo").val();
        if(plant === ""||plant===null || SupportNo ===""||SupportNo===null){
            $.messager.alert('温馨提示', '请先选择事业部和供应商代码!');
        }else{
            mti_getpo();
        }

    }
    /**
     * Name 获取未清采购订单数据
     */
    var SBdata;
    function mti_getpo(type) {
        var   fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/Materialtakein/ZMM_O_003M7.action",//要发送的后台地址
            data: {
                plant:$('#mti_Plant').combobox('getText'),
                PoNo:$('#mti_PoNo').val(),
                SupportNo:$('#mti_SupportNo').val(),
                UserName:localStorage.getItem('User')
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                fdata = data;
                $("#mti_po").datagrid({
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:fdata,
                    columns:[[
                        //{field:'id',title:'编号',width:100},
                        {field:'LIFNR',title:'供应商',width:100},
                        {field:'NAME1',title:'供应商描述',width:150, sortable: true},
                        {field:'EBELN',title:'未清采购订单',width:100},
                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',
                });

                $('#mti_po').datagrid({loadFilter:mti_pagerFilter}).datagrid('loadData', fdata);
//                $('#mti_po').datagrid({
//                    rowStyler: function (index, row) {
//                        var IsPrint =row.IsPrint;
//                        //alert(11);
//                        if (IsPrint !== '1') {
//                            return 'color:black;';
//                        }
//                        else {
////                            return 'color:Green;font-weight:bold;';
//                            return 'color:red';
//                        }
//
//                    }
//                });
                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });




    }
    /**
     * Name 获取冷轧
     */
    function mti_getcold(coldrow) {
        //alert(11111);
        //alert(plant+"===="+dhorderno+"===="+PartDrawing+"===="+fname);
        $.messager.progress({
            title:'请稍等',
            msg:'页面加载中...'
        });
        var type = $('input[name="mti_bzflag"]:checked').val();
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/Materialtakein/selectColdmaterlin.action",//要发送的后台地址
            data: {
                PoNo:coldrow.EBELN,
                inputman:localStorage.getItem('User'),
                plant:$('#mti_Plant').combobox('getText'),
                type:type
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                $("#mti_takemsg").datagrid({
                    idField:'id',
                    loadFilter:mti_pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    columns:[[
                        {field:'Number',title:'收货数量',width:60,editor:{
                            type:'textbox',
                            options:{
                                required:true
                            }
                        },sortable: true},
                        {field:'BatchNo',title:'炉批号',width:100,editor:{
                            type:'textbox',
                            options:{
                                required:true
                            }
                        },sortable: true},
                        {field:'materialtype',title:'物料类型',width:100,editor:{
                            type:'textbox',
                            options:{
//                                required:true
                            }
                        },sortable: true},
                        {field:'steelworks',title:'钢厂',width:100,editor:{
                            type:'textbox',
                            options:{
//                                required:true
                            }
                        },sortable: true},
                        {field:'id',title:'序号',width:100,hidden:'true', sortable: true},
                        {field:'PoNo',title:'采购订单号',width:100,sortable: true},
                        {field:'fname',title:'物料描述',width:250,sortable: true},
                        {field:'fno',title:'物料编码',width:100,sortable: true},
                        {field:'serialno',title:'编号',width:100,sortable: true},

                        {field:'PoItem',title:'采购订单行项目',width:100,sortable: true},
                        {field:'PoNumber',title:'订单数量',width:100,sortable: true},
                        {field:'TakeNumber',title:'已收数量',width:100,sortable: true},
                        {field:'LeftNumber',title:'剩余数量',width:100,sortable: true},
                        {field:'isok',title:'确认收货',width:100,sortable: true},
                        {field:'LGORT',title:'收货地点',width:110,sortable: true},
                        {field:'unit',title:'单位',width:150,sortable: true},
                        {field:'inputman',title:'录入人',width:40,sortable: true},
                        {field:'inputdate',title:'录入时间',width:50,sortable: true},
                        {field:'isMove',title:'SAP移库',width:80, sortable: true},
                        {field:'Moveman',title:'SAP移库人',width:80, sortable: true},
                        {field:'Movedate',title:'SAP移库时间',width:160,sortable: true},
                        {field:'plant',title:'事业部',width:100, sortable: true},
                        {field:'UpLimit',title:'过量限度',width:130,sortable: true},
                        {field:'DownLimit',title:'不足限度',width:80, sortable: true},
                        {field:'IsDone',title:'收货完成',width:160, sortable: true},
                        {field:'uyear',title:'年度',width:80, sortable: true},
                        {field:'umonth',title:'月度',width:60,sortable: true},
                        {field:'SupportNo',title:'供应商编码',width:100,sortable: true},
                        {field:'SupportName',title:'供应商名称',width:100,sortable: true},
                        {field:'EKORG',title:'采购组织',width:100,sortable: true},
                        {field:'EKORGName',title:'采购组织描述',width:100,sortable: true},
                        {field:'EKGRP',title:'采购组',width:100,sortable: true},
                        {field:'EKGRPName',title:'采购组描述',width:100,sortable: true},
                        {field:'PoCreatTime',title:'采购订单创建时间',width:100,sortable: true},
                        {field:'BUKRS',title:'公司代码',width:100,sortable: true},
                        {field:'MoveOk',title:'移库失败',width:100,sortable: true},
                        {field:'ReturnOk',title:'退货失败',width:100,sortable: true},
                        {field:'StockType',title:'库存状态',width:100,sortable: true},
                        {field:'MaterialDoc',title:'物料凭证',width:100,sortable: true},
                        {field:'MaterialDocYear',title:'凭证年度',width:100,sortable: true},
                        {field:'MaterialDocItem',title:'凭证行',width:100,sortable: true},

                        {field:'IsTrans',title:'质检至非限制',width:100,sortable: true},
                        {field:'TransMan',title:'质检转换人',width:100,sortable: true},
                        {field:'TransDate',title:'质检转换时间',width:100,sortable: true},
                        {field:'MoneyState',title:'估价标示',width:100,sortable: true},
                        {field:'NETPR',title:'净价',width:100,sortable: true},
                        {field:'PEINH',title:'价格单位',width:100,sortable: true},
                        {field:'ZSUM',title:'总金额',width:100,sortable: true},
                        {field:'location',title:'库位',width:100,sortable: true}
                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',

                });
                $('#mti_takemsg').datagrid({
                    rowStyler: function (index, row) {
                        var isMove =row.isMove;
                        //alert(11);
                        if (isMove !== true) {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'color:red';
                        }

                    }
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }
        });

    }

    function mti_SAPtakeIn(){
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var row  = $('#mti_takemsg').datagrid("getSelected");
        if(row===null){
            $.messager.alert('温馨提示', '请选择有效的收货记录行项目!');
        }else {
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${ctxPath }/Materialtakein/SAPtakeIn.action",//要发送的后台地址
                data: {
                    id: row.id,
                    inputman:localStorage.getItem("User")
                },
                dataType: "json",
                success: function (data) {//ajax请求成功后触发的方法
                    console.log(data);
                    if(data.num>0){
                        $.messager.alert('温馨提示', 'SAP采购入库成功!');
                        mti_pomxh();
                        mti_getcold(row);
                    }else{
                        mti_pomxh();
                        $.messager.alert('温馨提示', data.retsalse);
                    }
                }
            });
        }
    }

    function mti_SAPQualityToUnrestricted(){
        var row  = $('#mti_po').datagrid("getSelected");
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/Materialtakein/SAPtakeChange.action",//要发送的后台地址
            data: {
                PoNo: row.EBELN,
                inputman:localStorage.getItem("User"),
                plant:$('#mti_Plant').combobox('getText')
            },
            dataType: "json",
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                if(data.num>0){
                    $.messager.alert('温馨提示', 'SAP质检转非限制成功!');
                    mti_getcold(row);
                }else{
                    $.messager.alert('温馨提示', 'SAP质检转非限制失败!');
                }
            }
        });
    }

    function mti_SAPtakeReturn(){
        var row  = $('#mti_po').datagrid("getSelected");
        var rowcold = $("#mti_takemsg").datagrid("getSelected");
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/Materialtakein/SAPtakeBack.action",//要发送的后台地址
            data: {
                id: rowcold.id,
                inputman:localStorage.getItem("User"),
                plant:$('#mti_Plant').combobox('getText')
            },
            dataType: "json",
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
//                alert(data.num);
                if(data.num>0){
                    mti_pomxh();
                    mti_getcold(row);
                    $.messager.alert('温馨提示', 'SAP采购退货成功!');
                }else{
                    mti_pomxh();
                    $.messager.alert('温馨提示', 'SAP采购退货失败!');
                }
            }
        });
    }

    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var poIndex = undefined;
    var poItemIndex = undefined;
    function mti_endEditing(){
        if (editIndex == undefined){return true}
        if ($('#mti_takemsg').datagrid('validateRow', editIndex)){
            $('#mti_takemsg').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function mti_poOnClickRow(index){
            mti_pomxh();
            poIndex  =index;
    }
    function mti_pomxh() {
        var row = $("#mti_po").datagrid("getSelected");
        var PoNo = row.EBELN;
        var SupportNo = row.LIFNR;
        $.messager.progress({
            title:'请稍等',
            msg:'页面加载中...'
        });
        $.ajax({
            type: "post",
            url: "${ctxPath }/Materialtakein/ZMM_O_003M5.action",
            dataType: "json",//后台处理后返回的数据格式
            data: {
                plant:$('#mti_Plant').combobox('getText'),
                PoNo:PoNo,
                SupportNo:SupportNo,
                UserName:localStorage.getItem('User')
            },
            success: function (data) {//ajax请求成功后触发的方法
                $("#mti_poitems").datagrid({
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    columns:[[
                        //{field:'id',title:'编号',width:100},
                        {field:'EBELP',title:'行项目',width:50},
                        {field:'MATNR',title:'编码',width:100, sortable: true},
                        {field:'TXZ01',title:'物料描述',width:250},
                        {field:'L_MENGE',title:'剩余数量',width:100},
                        {field:'MENGE',title:'采购数量',width:100},
                        {field:'T_MENGE',title:'已收数量',width:100},
                        {field:'EVERS',title:'估价标识',width:100},
                        {field:'LGORT',title:'收货地点',width:100},
                        {field:'ELIKZ',title:'收货完成',width:100},
                        {field:'R_MENGE',title:'退货数量',width:100},
                        {field:'MEINS',title:'单位',width:100},
                        {field:'UEBTO',title:'过量限度',width:100},
                        {field:'UNTTO',title:'不足限度',width:100},
                        {field:'WERKS',title:'工厂',width:100},
                        {field:'NETPR',title:'净价',width:100},
                        {field:'PEINH',title:'价格单位',width:100},
                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',
                });
                $("#mti_EKORG").val(data.EKORG);
                $("#mti_EKGRPName").val(data.EKOTX);
                $("#mti_BUKRS").val(data.BUKRS);
                $("#mti_EKGRP").val(data.EKGRP);
                $("#mti_EKORGName").val(data.EKNAM);
                $("#mti_PoCreatTime").val(data.AEDAT);
                $('#mti_poitems').datagrid({loadFilter:mti_pagerFilter}).datagrid('loadData', data);
                mti_getcold(row);
            }
        });
    }
    function mti_poitemsOnClickRow(index){

            var row = $("#mti_poitems").datagrid("getSelected");

            poItemIndex  =index;

    }
    function mti_takemsgonClickRow(index){
        if (editIndex !== index){

            var data = $('#mti_takemsg').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#mti_takemsg').datagrid('selectRow', editIndex);
                }
            }
            editIndex = index;
        }
    }
    function mti_Print() {
        var row = $("#mti_takemsg").datagrid("getSelected");
//        row.IsPrint = '1';
//        $.ajax({
//            type: "post",//数据发送的方式（post 或者 get）
//            url: "/KCard/updateDY.action",//要发送的后台地址
//            data: {
//                id:row.id,
//                IsPrint:row.IsPrint
//            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//            }
//        });
//        $('#kc').datagrid('refreshRow', editIndex);
        var tarValue = "[{reportlet:'/SD/CGRKDY.cpt',id:'"+row.id+"'}]";
//设置url地址，加上Date().getTime()防止缓存
        var url = "http://172.16.0.57:8090/WebReport/proxy2.html?_=" + new Date().getTime()
            + "&tarValue=" + tarValue;
//添加一个新的iframe，并为该iframe添加一个src，用来打开proxy.html，让其执行跨域打印的js代码
        var iframe = document.getElementById('proxy');
        if (!iframe) {
            // 如果iframe还没有加进去，则加进去
            iframe = document.createElement('iframe');
            document.getElementsByTagName('head')[0].appendChild(iframe);
            iframe.setAttribute('name','proxy');
            iframe.setAttribute('id','proxy');
        }
        iframe.setAttribute('src', url);


    }


    /**
     * Name 载入菜单树
     */
    $('#wu-category-tree').tree({
        url:'',
        onClick:function(node){
            alert(node.text);
        }
    });
    /**
     * Name 添加记录
     */
    function add(){
        $('#wu-form').form('submit', {
            url:'',
            success:function(data){
                if(data){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog').dialog('close');
                }
                else
                {
                    $.messager.alert('信息提示','提交失败！','info');
                }
            }
        });
    }

    /**
     * Name 修改记录
     */
    function edit(){
        $('#wu-form').form('submit', {
            url:'',
            success:function(data){
                if(data){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog').dialog('close');
                }
                else
                {
                    $.messager.alert('信息提示','提交失败！','info');
                }
            }
        });
    }

    /**
     * Name 删除记录
     */
    function remove(){
        $.messager.confirm('信息提示','确定要删除该记录？', function(result){
            if(result){
                var items = $('#wu-datagrid').datagrid('getSelections');
                var ids = [];
                $(items).each(function(){
                    ids.push(this.productid);
                });
                //alert(ids);return;
                $.ajax({
                    url:'',
                    data:'',
                    success:function(data){
                        if(data){
                            $.messager.alert('信息提示','删除成功！','info');
                        }
                        else
                        {
                            $.messager.alert('信息提示','删除失败！','info');
                        }
                    }
                });
            }
        });
    }

    /**
     * Name 打开添加窗口
     */
    function openAdd(){
        $('#wu-form').form('clear');
        $('#wu-dialog').dialog({
            closed: false,
            modal:true,
            title: "添加信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#wu-dialog').dialog('close');
                }
            }]
        });
    }

    /**
     * Name 打开修改窗口
     */
    function openEdit(){
        $('#wu-form').form('clear');
        var item = $('#wu-datagrid').datagrid('getSelected');
        //alert(item.productid);return;
        $.ajax({
            url:'',
            data:'',
            success:function(data){
                if(data){
                    $('#wu-dialog').dialog('close');
                }
                else{
                    //绑定值
                    $('#wu-form').form('load', data)
                }
            }
        });
        $('#wu-dialog').dialog({
            closed: false,
            modal:true,
            title: "修改信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: edit
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#wu-dialog').dialog('close');
                }
            }]
        });
    }

    /**
     * Name 分页过滤器
     */

    function mti_pagerFilter(data){
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
