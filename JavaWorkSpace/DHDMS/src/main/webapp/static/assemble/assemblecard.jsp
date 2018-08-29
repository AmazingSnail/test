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
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <div class="easyui-panel" title="开流转卡" data-options="fit:true">
            <div id="wu-toolbar" style="overflow:auto;width:100%;height: 95px">
                <div class="wu-toolbar-button">
                    <shiro:hasPermission name="/KCard/Print">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="Print()" plain="true">打印</a>
                    </shiro:hasPermission>
                    <span>丨</span>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>--%>
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <div>
                        <label>查询年月：</label><input  id ="dbk" style="width:100px" >&nbsp
                        <!--class="easyui-datebox"-->
                        <label>厂编合同：</label><input id="KCard_dhorderno" class="wu-text" style="width:100px">&nbsp
                        <label>规格：</label><input id="KCard_PartDrawing" class="wu-text" style="width:100px">&nbsp
                        <label>班长：</label>
                        <select class="easyui-combobox" name="BMan" datatype="text" id="KCard_BMan" panelHeight="auto" data-options="
                            url:'/Syb/BMan.action',
                            method:'post',
                            valueField:'worklead',
                            textField:'worklead',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>内外销：</label>
                        <select class="easyui-combobox" name="Nwx" datatype="text" id="KCard_Nwx" panelHeight="auto"
                                style="width:100px">
                            <option value="">全部</option>
                            <option value="N">内销</option>
                            <option value="W">外销</option>
                        </select>&nbsp
                    </div>
                    <div>
                        <label><span class="w3">事业部</span>：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="KCard_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">

                        </select>

                        <label>物料描述：</label><input id="KCard_fname" class="wu-text" style="width:100px">&nbsp
                        <label>节数：</label><input id="KCard_F3" class="wu-text" style="width:100px">&nbsp
                        <label>颜色：</label><input id="KCard_color" class="wu-text" style="width:100px">&nbsp

                        <a href="#" class="easyui-linkbutton"  onclick="KCard_forGetDate()" data-options="iconCls:'icon-search'">搜索</a>
                    </div>

                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <iframe id="proxy" hidden style="display: none;"></iframe>
            <div class="easyui-layout" data-options="fit:true" >
                <div class="A" data-options="region:'west',split:true" >

                    <table id="yd" class="easyui-datagrid" style="white-space: nowrap;height: 63%" title="月度计划表(绿背景代表：计划数已全部开卡)" data-options="singleSelect:true,onClickRow:asblycardOnClickRow"></table>
                    <div style="overflow:auto;width:100%;height: 20%" title="详细信息" class="easyui-panel" >
                        <form id="dgmx" method="post">
                            <table cellpadding="5" width="auto"  style="white-space:nowrap;" >
                                <tr>
                                    <td>厂编合同号:</td>
                                    <td><input class="easyui-textbox" type="text" name="dhorderno" data-options="required:true" disabled=true></input></td>
                                    <td>SAP订单号:</td>
                                    <td><input class="easyui-textbox" type="text" name="SAPSDOrder" data-options="required:true" disabled=true></input></td>
                                    <td>接单:</td>
                                    <td><input class="easyui-textbox" type="text" name="TakeOrder" data-options="required:true" disabled=true></input></td>
                                    <td>完成:</td>
                                    <td><input class="easyui-textbox" type="text" name="CompleteOrder" data-options="required:true" disabled=true></input></td>
                                    <td>交货期:</td>
                                    <td><input class="easyui-textbox" type="text" name="OrderTime" data-options="required:true" disabled=true></input></td>
                                </tr>
                                <tr>
                                    <td>描述:</td>
                                    <td><input class="easyui-textbox" type="text" name="Descrip" data-options="required:true" disabled=true></input></td>
                                    <td>计划入库数:</td>
                                    <td><input class="easyui-textbox" type="text" name="number" data-options="required:true" disabled=true></input></td>
                                    <td>计划串装数:</td>
                                    <td><input class="easyui-textbox" type="text" name="ConnectPlan" data-options="required:true" disabled=true></input></td>
                                    <td>本日串装:</td>
                                    <td><input class="easyui-textbox" type="text" name="DayNum" data-options="required:true" disabled=true></input></td>
                                    <td>累计串装:</td>
                                    <td><input class="easyui-textbox" type="text" name="SumDayNum" data-options="required:true" disabled=true></input></td>

                                </tr>
                                <tr>
                                    <td>计划入库数:</td>
                                    <td><input class="easyui-textbox" type="text" name="number" data-options="required:true" disabled=true></input></td>
                                    <td>本日入库:</td>
                                    <td><input class="easyui-textbox" type="text" name="DayInput" data-options="required:true" disabled=true></input></td>
                                    <td>累计入库:</td>
                                    <td><input class="easyui-textbox" type="text" name="SumDayInput" data-options="required:true" disabled=true></input></td>
                                    <td>是否验货:</td>
                                    <td><input class="easyui-textbox" type="text" name="ischeck" data-options="required:true" disabled=true></input></td>
                                    <td>是否组合件:</td>
                                    <td><input class="easyui-textbox" type="text" name="IsCl" data-options="required:true" disabled=true></input></td>
                                </tr>
                                <tr>
                                    <td>颜色:</td>
                                    <td><input class="easyui-textbox" type="text" name="Color" data-options="required:true" disabled=true></input></td>
                                    <td>内外销:</td>
                                    <td><input class="easyui-textbox" name="nwx" data-options="required:true" disabled=true></input></td>
                                    <td>单节重差:</td>
                                    <td><input class="easyui-textbox" name="singleWeightOK" data-options="required:true" disabled=true></input></td>
                                    <td>工程兴化:</td>
                                    <td><input class="easyui-textbox" name="GCXH" data-options="required:true" disabled=true></input></td>
                                    <td>配组合件:</td>
                                    <td><input class="easyui-textbox" type="text" name="ismix" data-options="required:true" disabled=true></input></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>

                <div class="B" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
                        <shiro:hasPermission name="/KCard/go">
                            <button id="go" onclick="go()"  class="easyui-linkbutton" style="margin-top: 100px">开卡>></button>
                        </shiro:hasPermission>
                    </div>
                    <div style="">
                        <shiro:hasPermission name="/KCard/back">
                            <button id="back" class="easyui-linkbutton" onclick="back()">删除<<</button>
                        </shiro:hasPermission>
                    </div>
                </div>
                <div class="A"  data-options="region:'east',split:true">
                    <table class="easyui-datagrid" id="kc" title="本日开卡信息 (红字表示：已打印行项目)" style="white-space: nowrap;height: 83%" data-options="singleSelect:true,onClickRow:onClickRow2,editor:'text'" ></table>
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
        $('#dbk').val(year+"-"+month);
        var db = $('#dbk');
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
            url:'/Syb/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#KCard_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#KCard_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#KCard_BMan').combobox('clear');
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "/Syb/BMan.action",
                        dataType: "json",
                        data: {
                            plant: plant
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $('#KCard_BMan').combobox('loadData', data);

                        }
                    });
                }

            }
        })
    });

    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }
    function go() {
        var myDate = new Date();
        var plant=  $('#KCard_Plant').combobox('getText');

        var uyear = myDate.getFullYear();
        var umouth = myDate.getMonth()+1;
        var day = myDate.getDate();
        var time = uyear+"-"+umouth+"-"+day;
        //alert(time);
        var zDescrip;
        var zF3;
        var zPartDrawing;
        var zdhorderno;
        var zOrderLine;
        var username = localStorage.getItem("User");
        var num = getRowIndex("#kc");
        //alert(num);
        var data = $('#kc').datagrid('getData').rows[num];
//            if(parseInt(data.inputnum) === 0 || data.ReportMan ===""){
//                $.messager.alert('温馨提示','前一张开卡记录数量为0或缺少串装工！！');
//            }else{
        var row  = $('#yd').datagrid("getSelected");
        zdhorderno = row.dhorderno;
        zPartDrawing = row.PartDrawing;
        zF3 = row.F3;
        zDescrip = row.Descrip;
        zOrderLine = row.OrderLine;
        //alert(zOrderLine);
        if(row.Dutyman !== username){
            $.messager.alert('温馨提示','该数据责任班长为'+row.Dutyman +',无法开卡！');
        }else
        if (row.umouth<umouth||row.uyear<uyear){
            $.messager.alert('温馨提示','上月数据无法开卡！！');
        }else
        if(parseInt(row.CLNumber)>=parseInt(row.ConnectPlan)){
            $.messager.alert('温馨提示','计划已完成，无需开单！！');
        }
        else{
            if (endEditing()) {
                var zunit = '';
                if(row.meins ==='件'){
                    zunit = 'PC';
                }else{
                    zunit = 'KG'
                }
                $('#kc').datagrid('appendRow', {
                    dhorderno: zdhorderno,
                    PartDrawing: zPartDrawing,
                    F3: zF3,
                    Descrip: zDescrip,
                    itemno: zOrderLine,
                    plant: plant,
                    fno: row.fno,
                    SAPSDOrder: row.SAPSDOrder,
                    takenum: 0,
                    surenum: 0,
                    meins: row.meins,
                    fname: row.fname,
                    inputnum: 0,
                    inputman:localStorage.getItem("User"),
                    dutyman: row.Dutyman,
                    tasktype: 1,
                    MillionF3:row.MillionF3,
                    unit:zunit,
                    isprint: 0,
                    planid: row.id,
                    OrderLine: row.OrderLine,
                    IsTake: 0,
                    ConnectZore: 1,
                    SplitF3: row.SplitF3,
                    Color:row.Color,
                    iscl:row.IsCl,
                    SureMan:localStorage.getItem("User"),
                    Suredate:time,
                    IsSure:1,
                    OrderTime:row.OrderTime,
                    IsOK:0,
                    planTransmit:0,
                    printtimes:0,
                    nwx:row.nwx,
                    Contrast:0,
                    f10:'',
                    SendTime:row.OrderTime,
                    inputnumKG:0,
                    Ftemp10:row.Ftemp10,
                    GCXH:row.GCXH,
                    PackTake:0,
                    PackTakeMan:'',
                    issurespot:0,
                    ismix:row.ismix,
                    PoNo:row.PoNo,
                    PoItem:row.PoItem
                });
                editIndex = $('#kc').datagrid('getRows').length - 1;
                //alert($('#KCard_Plant').combobox('getText')+"-------------"+row.Dutyman);
                $.ajax({
                    type: "get",
                    url: "/KCard/queryCZG.action",
                    data: {
                        plant: $('#KCard_Plant').combobox('getText'),
                        worklead: row.Dutyman
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        var ed = $('#kc').datagrid('getEditor', {index: editIndex, field: 'ReportMan'});
                        $(ed.target).combobox('loadData', data);
                    }
                });

                $('#kc').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
                $("input.datagrid-editable-input").keydown(function (e) {
                    var code = e.keyCode || e.which;
                    if (code === 13) {
                        var ed = $('#kc').datagrid('getEditor', {index:editIndex,field:'ReportMan'});
                        var einput = $('#kc').datagrid('getEditor', {index:editIndex,field:'inputnum'});
                        var ReportMan = $(ed.target).combobox('getText');
                        //alert(ReportMan);

                        if($(einput.target).val() === '0'|| parseInt($(einput.target).val()) === 0){
                            $.messager.alert('温馨提示', '请完善好数据再保存!')
                        }else{
                            $('#kc').datagrid('endEdit', editIndex);
                            var rowkc = $('#kc').datagrid('getRows');
                            var rowData = rowkc[editIndex];
                            $.messager.confirm('温馨提示', '你确定要保存吗?', function (r) {
                                if (r) {

                                    if(parseInt(rowData.inputnum)>(parseInt(row.ConnectPlan)-parseInt(row.CLNumber))){
                                        $.messager.alert('温馨提示','超出计划串装数！！');
                                        $('#kc').datagrid('cancelEdit', editIndex)
                                            .datagrid('deleteRow', editIndex);
                                    }else{

                                        //alert(rowData.id);
//                                            var ed = $('#kc').datagrid('getEditor',{index:editIndex,field:'ReportMan'});
//
//                                            alert(ed);
//                                                var czgvalue = $(ed.target).combobox( 'getText');

                                        $.ajax({
                                            type: "get",//数据发送的方式（post 或者 get）
                                            url: "/KCard/insert.action",//要发送的后台地址
                                            data: {
                                                zF3: rowData.F3,
                                                zDescrip: rowData.Descrip,
                                                zdhorderno: rowData.dhorderno,
                                                zPartDrawing: rowData.PartDrawing,
                                                zinputdate: time,
                                                zuyear: uyear,
                                                zumouth: umouth,
                                                zOrderline: rowData.itemno,
                                                zplant: plant,
                                                fno: rowData.fno,
                                                SAPSDOrder: rowData.SAPSDOrder,
                                                takenum: rowData.takenum,
                                                surenum: rowData.surenum,
                                                meins: rowData.meins,
                                                Dunit: zunit,
                                                fname: rowData.fname,
                                                inputnum: rowData.inputnum,
                                                inputman: rowData.inputman,
                                                dutyman: rowData.dutyman,
                                                tasktype: rowData.tasktype,
                                                ReportMan: ReportMan,
                                                worklead: rowData.worklead,
                                                isprint: rowData.isprint,
                                                planid: rowData.planid,
                                                OrderLine: rowData.OrderLine,
                                                IsTake: rowData.IsTake,
                                                ConnectZore: rowData.IsTake,
                                                Ftemp10: rowData.Ftemp10,
                                                GCXH: rowData.GCXH,
                                                SplitF3:rowData.SplitF3,
                                                Color:rowData.Color,
                                                iscl:rowData.iscl,
                                                SureMan:"",
                                                //localStorage.getItem("User")
                                                Suredate:"",
                                                OrderTime:rowData.OrderTime,
                                                IsOK:0,
                                                planTransmit:0,
                                                printtimes:0,
                                                nwx:row.nwx,
                                                Contrast:0,
                                                f10:'',
                                                MillionF3:rowData.MillionF3,
                                                SendTime:rowData.OrderTime,
                                                inputnumKG:0,
                                                PackTake:0,
                                                PackTakeMan:'',
                                                issurespot:0,
                                                ismix:rowData.ismix,
                                                PoNo:rowData.PoNo,
                                                PoItem:rowData.PoItem,
                                                equipment: SBdata.equipment,
                                                equipmentkind: SBdata.equipmentkind,
                                                equipmentSerial: SBdata.equipmentSerial
                                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}

                                            dataType: "json",//后台处理后返回的数据格式
                                            success: function (data) {//ajax请求成功后触发的方法
                                                if (data.num > 0) {
                                                    getKCard();
                                                    $.ajax({
                                                        type: "get",//数据发送的方式（post 或者 get）
                                                        url: "/Mplan/updatekczt.action",//要发送的后台地址
                                                        data: {
                                                            id: row.id,
                                                            CLNumber: parseInt(row.CLNumber)+parseInt(rowData.inputnum)
                                                        },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                                                        dataType: "json",//后台处理后返回的数据格式
                                                        success: function (data) {//ajax请求成功后触发的方法
                                                            if (data.num > 0) {
                                                                //getMplan();
                                                                var rowIndex = $('#yd').datagrid('getRowIndex',rowData.planid);
                                                                var data = $('#yd').datagrid('getData').rows[rowIndex];
                                                                data.CLNumber = parseInt(data.CLNumber)+parseInt(rowData.inputnum);
                                                                $('#yd').datagrid('refreshRow', rowIndex);
                                                            }
                                                        },
                                                        error: function (msg) {//ajax请求失败后触发的方法
                                                            alert(msg);//弹出错误信息
                                                        }
                                                    });
                                                }
                                            },
                                            error: function (msg) {//ajax请求失败后触发的方法
                                                alert(msg);//弹出错误信息
                                            }
                                        });
                                    }
                                }
                            });


                        }  //alert(444444);
                    }
                });
            }
            else{
                $.messager.alert('温馨提示', '存在未编辑完数据!');
            }
        }
//                }

    }


    /**
     * Name 退回按钮
     */
    function back() {
        var row  = $('#kc').datagrid("getSelected");
        //alert(row.id);
        $.messager.confirm('温馨提示', '你确定要退回吗?', function (r) {
            if (r) {
                if (row.id === undefined) {
                    if (editIndex == undefined) {
                        return
                    }
                    $('#kc').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);
                    editIndex = undefined;
                } else {
                    $.ajax({
                        type: "get",
                        url: "/KCard/delete.action",
                        data: {
                            id: row.id
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            if (data.num > 0) {
                                //alert("这是修改Mplan的地方");
                                $.ajax({
                                    type: "get",//数据发送的方式（post 或者 get）
                                    url: "/Mplan/updatekcth.action",//要发送的后台地址
                                    data: {
                                        id: row.planid,
                                        CLNumber: parseInt(row.inputnum)
                                    },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                                    dataType: "json",//后台处理后返回的数据格式
                                    success: function (data) {//ajax请求成功后触发的方法
                                        if (data.num > 0) {
                                            var rowIndex = $('#yd').datagrid('getRowIndex',row.planid);
                                            var data = $('#yd').datagrid('getData').rows[rowIndex];
                                            data.CLNumber = parseInt(data.CLNumber)-parseInt(row.inputnum);
                                            $('#yd').datagrid('refreshRow', rowIndex);
                                            $('#kc').datagrid('deleteRow', editIndex);
//                                            getMplan();
//                                            getKCard();
                                        }
                                    },
                                    error: function (msg) {//ajax请求失败后触发的方法
                                        alert(msg);//弹出错误信息
                                    }
                                });
                            }
                        }
                    });
                }
            }
        })
    }
    /**
     * Name 搜索按钮事件
     */
    function KCard_forGetDate() {
        getMplan();
        getKCard();
    }
    /**
     * Name 获取开卡数据表
     */
    var SBdata;
    function getKCard() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        //var   plant= $('#plant').

        var   dhorderno=$('#KCard_dhorderno').val();
        var   PartDrawing=$('#KCard_PartDrawing').val();
        var   fname=$('#KCard_fname').val();
        var   fdata;
        $.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "/KCard/query.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umouth:umouth,
                plant:$('#KCard_Plant').combobox('getText'),
//                dhorderno:dhorderno,
//                PartDrawing:PartDrawing,
//                fname:fname,
                uday:uday,
                inputman:localStorage.getItem('User')
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                fdata = data;
                $("#kc").datagrid({
                    rownumbers:true,
                    singleSelect:true,
                    pageSize:50,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    id:'kcard',
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'serialno',title:'编号',width:100},

                        {field:'fno',title:'物料编码',width:100, sortable: true},
                        {field:'ReportMan',title:'串装工',id:'CZG',editor:{
                            type:'combobox',
                            options:{
                                valueField:'worker',
                                textField:'worker',
                                method:'get',
                                required:true,
                                onChange:function(oldVal,newVal){
                                    var row  = $('#yd').datagrid("getSelected");
                                    $.ajax({
                                        type: "post",
                                        url: "/KCard/getSB.action",
                                        data: {
                                            plant: $('#KCard_Plant').combobox('getText'),
                                            worklead: row.Dutyman,
                                            worker:newVal
                                        },
                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (datasb) {//ajax请求成功后触发的方法
                                            SBdata = datasb;
                                            //alert(SBdata.equipment);
//                                            editIndexSB = $('#kc').datagrid('getRows').length - 1;
//                                            $('#kc').datagrid('updateRow', {
//                                                index: $('#kc').datagrid('getRowIndex',editIndexSB),
//                                                row: {
//                                                    equipment: SBdata.equipment,
//                                                    equipmentkind: SBdata.equipmentkind,
//                                                    equipmentSerial: SBdata.equipmentSerial
//                                                }
//                                            });
                                        }
                                    });
                                }
                            }},width:100, sortable: true},
                        {field:'inputnum',title:'开卡数',editor:'text',width:100},

                        {field:'inputNumKG',title:'开卡公斤数',width:100},
                        {field:'takenum',title:'入库补卡数',width:100},
                        {field:'fname',title:'物料描述',width:100, sortable: true},

                        {field:'OrderTime',title:'交货期',width:100, sortable: true},
                        {field:'dhorderno',title:'厂编合同号',width:100, sortable: true},
                        {field:'F3',title:'节数',width:100},
                        {field:'unit',title:'单位',width:100},
                        {field:'AssScanNum',title:'实际节数',hidden:'true',width:100},
                        {field:'SplitF3',title:'拆分节数',width:100},
                        {field:'equipment',title:'设备规格',width:100},
                        {field:'ConnectZore',title:'串零',width:100},

                        {field:'isok',title:'开卡确认',width:100},
                        {field:'ismix',title:'配组合件',width:100},
                        {field:'PartDrawing',title:'规格',width:100},
                        {field:'itemno',title:'合同及行号',width:100},
                        {field:'SAPSDOrder',title:'销售订单号',width:100},
                        {field:'inputman',title:'开卡人',width:100},
                        {field:'inputdate',title:'开卡时间',width:100},

                        {field:'Descrip',title:'描述',width:100},
                        {field:'TempInfo',title:'备注',width:100},



                        {field:'surenum',title:'确认串装数',width:100},
                        {field:'IsCL',title:'无需入库',width:100},
                        {field:'takeman',title:'包装接受人',width:100},
                        {field:'takedate',title:'包装接受时间',width:100},
                        {field:'dutyman',title:'责任人',width:100},
                        {field:'plant',title:'事业部',width:100},
                        {field:'meins',title:'单位',width:100},
                        {field:'itemno',title:'行项目',width:100},
                        {field:'planid',title:'计划ID',width:100},
                        {field:'umouth',title:'月度',width:100},
                        {field:'uyear',title:'年度',width:100},
                        {field:'serialno_hide',title:'serialno_hide',width:100},
                        {field:'MillionF3',title:'产值万节',width:100},

                        {field:'IsPrint',title:'已打印',width:100},
                        {field:'Ftemp10',title:'转换关系',width:100},
                        {field:'GCXH',title:'工程兴化',width:100 },
                        {field:'equipmentSerial',title:'设备编号',width:100},
                        {field:'equipmentkind',title:'设备类型',width:100},
                        {field:'id',title:'系统编号',width:100},
                    ]],
//                    sortName:'ReportMan',
//                    sortName:'OrderTime',
//                    sortName:'dhorderno',
//                    sortName:'fno',
                    sortOrder:'asc',
                });

                $('#kc').datagrid({loadFilter:pagerFilter}).datagrid('loadData', fdata);
                $('#kc').datagrid({
                    rowStyler: function (index, row) {
                        var IsPrint =row.IsPrint;
                        //alert(11);
                        if (IsPrint !== '1') {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'color:red';
                        }

                    }
                });
                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });




    }
    /**
     * Name 获取月度计划表
     */
    function getMplan() {
        //alert(11111);
        var uyear = $('#dbk').val().substr(0,4);
        var umouth = $('#dbk').val().substr(5);


        //var   plant= $('#plant').combobox('getText');
        var   color = $('#KCard_color').val();
        var F3 = $('#KCard_F3').val();
        var nwx = $('#KCard_Nwx').val();
        var   dhorderno=$('#KCard_dhorderno').val();
        var   PartDrawing=$('#KCard_PartDrawing').val();
        var   fname=$('#KCard_fname').val();
        var   fdata;
        //alert(plant+"===="+dhorderno+"===="+PartDrawing+"===="+fname);
        $.messager.progress({
            title:'请稍等',
            msg:'页面加载中...'
        });
        jQuery.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "/Mplan/query.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umouth:umouth,
                plant:$('#KCard_Plant').combobox('getText'),
                Dutyman:$('#KCard_BMan').combobox('getText'),
                dhorderno:dhorderno,
                PartDrawing:PartDrawing,
                fname:fname,
                Color:color,
                F3:F3,
                nwx:nwx
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                fdata = data;
                $("#yd").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageSize:20,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[

                        {field:'dhorderno',title:'厂编合同号',hidden:'true',width:110},

                        {field:'Color',title:'颜色',hidden:'true',width:50},
                        {field:'Descrip',title:'描述',hidden:'true',width:160},





                        {field:'beginConnect',title:'期初补卡',hidden:'true',width:100},
                        {field:'SumDayNum',title:'累计串装',hidden:'true',width:100},
                        {field:'IsCl',title:'是否组合件',hidden:'true',width:100},
                        {field:'number',title:'本月计划|计划入库数',hidden:'true',width:100},
                        {field:'CompleteOrder',title:'完成',hidden:'true',width:100},
                        {field:'DayInput',title:'本日入库',hidden:'true',width:100},
                        {field:'DayNum',title:'本日串装',hidden:'true',width:100},
                        {field:'MillionF3',title:'产值万节',hidden:'true',width:100},
                        {field:'nwx',title:'内外销',hidden:'true',width:100},
                        {field:'WorkPart',title:'工段',hidden:'true',width:100},
                        {field:'MillionWight',title:'万节重量',hidden:'true',width:100},
                        {field:'TakeOrder',title:'接单',hidden:'true',width:100},

                        {field:'OrderLine',title:'合同加行号',width:130, sortable: true},
                        {field:'fno',title:'物料编码',width:80, sortable: true},
                        {field:'fname',title:'物料描述',width:160, sortable: true},
                        {field:'CLNumber',title:'本月开卡数',width:80},
                        {field:'ConnectPlan',title:'计划串装数',width:80},
                        {field:'Dutyman',title:'责任班长',width:80, sortable: true},
                        {field:'PartDrawing',title:'规格',width:110},
                        {field:'OrderTime',title:'交货期',width:100, sortable: true},
                        {field:'F3',title:'节数',width:40},
                        {field:'id',title:'序号',width:60},

                        {field:'MaterialDutyman',title:'责任人|配料责任人',hidden:'true',width:100},
                        {field:'plant',title:'事业部',hidden:'true',width:100},
                        {field:'submitstate',title:'Bom状态',hidden:'true',width:100},
                        {field:'singleWeightOK',title:'单节重差',hidden:'true',width:100},
                        {field:'period',title:'生产周期',hidden:'true',width:100},
                        {field:'MachineKind',title:'机器大类',hidden:'true',width:100},
                        {field:'uyear',title:'年度',hidden:'true',width:100},
                        {field:'umouth',title:'月度',hidden:'true',width:100},
                        {field:'SAPSDOrder',title:'SAP订单号',hidden:'true',width:100},
                        {field:'GCXH',title:'工程兴化',hidden:'true',width:100},
                        {field:'ismix',title:'配组合件',hidden:'true',width:100},
                        {field:'SumDayInput',title:'累计入库',hidden:'true',width:100},
                        {field:'ischeck',title:'是否验货',hidden:'true',width:100},
                        {field:'meins',title:'单位',hidden:'true',width:100},
                        {field:'OutputValue',title:'物料产值',hidden:'true',width:100},
                        {field:'Ftemp10',title:'转换关系',hidden:'true',width:100},
                        {field:'ConnectValue',title:'计划串装产值',hidden:'true',width:100},
                        {field:'DayNumValue',title:'累计串装产值',hidden:'true',width:100},
                        {field:'NumberValue',title:'计划入库产值',hidden:'true',width:100},
                        {field:'DayInputValue',title:'累计入库产值',hidden:'true',width:100},
                        {field:'PoNo',title:'采购订单', hidden:'true',width:100},
                        {field:'PoItem',title:'采购订单行项目',hidden:'true',width:100}
                    ]],
                    sortOrder:'asc',
                });
                $('#yd').datagrid({
                    rowStyler: function (index, row) {
                        var CLNumber =parseFloat(row.CLNumber);
                        var ConnectPlan =parseFloat(row.ConnectPlan);
                        //alert(11);
                        if (CLNumber < ConnectPlan) {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
                        }

                    }
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }
        });

    }

    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var ydIndex = undefined;
    function endEditing(){
        if (editIndex == undefined){return true}
        if ($('#kc').datagrid('validateRow', editIndex)){
            //alert(2222);
//            var editor = $('#kc').datagrid('getEditor',{index:editIndex,field:"itemno"});
//            var productname = $(editor.target).val();
//
//
//
//
//            $('#kc').datagrid('getRows')[editIndex]['productname'] = productname;
            $('#kc').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function asblycardOnClickRow(index){
        if (ydIndex != index){
            var row = $("#yd").datagrid("getSelected");
            $('#dgmx').form('load',{
                id:row.id,
                dhorderno:row.dhorderno,
                SAPSDOrder:row.SAPSDOrder,
                TakeOrder:row.TakeOrder,
                CompleteOrder:row.CompleteOrder,
                OrderTime:row.OrderTime,
                Color:row.Color,
                Descrip:row.Descrip,
                ConnectPlan:row.ConnectPlan,
                DayNum:row.DayNum,
                SumDayNum:row.SumDayNum,
                beginConnect:row.beginConnect,
                number:row.number,
                DayInput:row.DayInput,
                SumDayInput:row.SumDayInput,
                ischeck:row.ischeck,
                IsCl:row.IsCl,
                ismix:row.ismix,
                nwx:row.nwx,
                singleWeightOK:row.singleWeightOK,
                GCXH:row.GCXH
            });
//        $.ajax({
//            type: "get",
//            url: "/KCard/queryCZG.action?plant=" + $('#Plant').combobox('getText') + "&&worklead=" + row.dutyman + "",
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//                $('#ReportMan1').combobox('loadData', data);
//            }
//        });
            ydIndex  =index;
        }
    }
    function onClickRow2(index){
        if (editIndex !== index){

            var data = $('#kc').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#kc').datagrid('selectRow', editIndex);
                }
            }

//        $.ajax({
//            type: "get",
//            url: "/KCard/queryCZG.action?plant=" + $('#Plant').combobox('getText') + "&&worklead=" + row.dutyman + "",
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//                $('#ReportMan1').combobox('loadData', data);
//            }
//        });
            editIndex = index;
        }
    }
    function Print() {
        var row = $("#kc").datagrid("getSelected");
        row.IsPrint = '1';
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "/KCard/updateDY.action",//要发送的后台地址
            data: {
                id:row.id,
                IsPrint:row.IsPrint
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
            }
        });
        $('#kc').datagrid('refreshRow', editIndex);
        var tarValue = "[{reportlet:'/SD/ZPJJKC.cpt',id:'"+row.id+"'}]";
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
