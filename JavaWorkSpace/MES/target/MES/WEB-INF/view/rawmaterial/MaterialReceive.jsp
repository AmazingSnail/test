<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/5
  Time: 9:21 ---  原材料接收
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
    .mm3{
        letter-spacing:0.28em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .z2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.9em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 60px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="原材料接收" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 60px">
            <div class="wu-toolbar-button">
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td> <label><span class="mm3">事业部：</span></label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="mrPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select>&nbsp&nbsp&nbsp</td>
                        <td><label>供应商编码：</label><input id="superid" class="easyui-textbox" style="width:100px" required onkeypress="mr_getKey()">&nbsp&nbsp&nbsp</td>
                        <td> <label>供应商描述：</label><input id="supername" class="easyui-textbox" style="width:90px">&nbsp&nbsp&nbsp</td>
                        <td> <label>采购订单：</label><input id="PONO" class="easyui-textbox" style="width:90px">&nbsp&nbsp&nbsp</td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="mr_query()" data-options="iconCls:'icon-search'" style="width:60px;height:25px">查询</a></td>
                    </tr>
                </table>
            </div>

        </div>
        <%--<div class="easyui-layout haorooms"   >--%>
            <%--<!--开卡信息-->--%>
            <%--<div class="N" data-options="region:'west',split:true" >--%>
                <%--<table id="MR-Data" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>--%>
            <%--</div>--%>
            <%--<!--收发按钮-->--%>
            <%--<div class="" data-options="region:'center',split:true">--%>
                    <%--<div style="height: 50%;"  >--%>
                        <%--<button id="PMI-go" onclick="MR_go()"  class="easyui-linkbutton" style="margin-top: 80px">接收>></button>--%>
                    <%--</div>--%>
                    <%--<div style="">--%>
                        <%--<button id="MI-back" class="easyui-linkbutton" onclick="MR_back()">删除<<</button>--%>
                    <%--</div>--%>
            <%--</div>--%>
            <%--<!--接收明细-->--%>
            <%--<div class="N"  data-options="region:'east',split:true">--%>
                <%--<table class="easyui-datagrid" id="MR-Input"  style="white-space: nowrap;height: 100%"   data-options="singleSelect:true,editor:'text'" ></table>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true" >
                <div id="mti_cc" class="easyui-layout" data-options="fit:true" style="width:100%;height:auto">
                    <div style="width: 100%;height:30%" data-options="region:'center'">
                        <table id="mti_po" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="采购订单数据" data-options="singleSelect:true,onClickRow:mti_poOnClickRow"></table>
                    </div>

                    <div style="height: 50%" data-options="region:'south',split:false" class="easyui-panel">
                        <table id="mti_poitems" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="采购订单行项目" data-options="singleSelect:true,onClickRow:mti_poitemsOnClickRow"></table>
                    </div>
                </div>
            </div>

            <div class="B" data-options="region:'center',split:true">
                <div style="height:80%;"  >
                        <button id="mti_go" onclick="mti_go()"  class="easyui-linkbutton" style="margin-top: 100px;width: 100%">接收</button>
                </div>
                <div style="">
                        <button id="mti_back" class="easyui-linkbutton" onclick="mti_back()" style="width: 100%">删除</button>
                </div>
            </div>
            <div class="C"  data-options="region:'east',split:true">
                <table class="easyui-datagrid" id="mti_takemsg" title="收货记录" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,onClickRow:mti_takemsgonClickRow,editor:'text'" ></table>
            </div>


        </div>
    </div>
</div>


<script type="text/javascript">
    var i;
    $(function () {
//        $("#ptPlant").combobox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptstoretake();
//            }
//        });
//        $("#ptdb").datebox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptcolor();
//            }
//        });
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
                $('#mrPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
    });
    function  mr_getKey() {
        if(event.keyCode==13){
            mr_query();
        }
    }
    function mr_query() {
        var   fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/MaterialReceive/ZMM_O_003M7.action",//要发送的后台地址
            data: {
                plant:$('#mrPlant').combobox('getText'),
                PoNo:$('#PONO').val(),
                SupportNo:$('#superid').val(),
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

                $('#mti_po').datagrid({loadFilter:pagerFilter}).datagrid('loadData', fdata);
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
    function mti_poOnClickRow() {

    }
    function getDay() {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var time = year+"-"+month+"-"+day;
        $.ajax({//当天任务
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MaterialReceive/queryDday.action",//要发送的后台地址
            data: {
                time:time,
                plant: localStorage.getItem("Department")
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#MR-Input").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
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
                        {field:'id',title:'id',width: '100px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'serialno',title:'编号',width: '90px',align:'center',halign: 'center'},
                        {field:'fname',title:'物料描述',width: '200px',align:'left',halign: 'center'},
                        {field:'material',title:'物料材质',width: '100px',align:'center',halign: 'center'},
                        {field:'pono',title:'采购订单',editor: {
                            type: 'validatebox',
                            options: {
                                required: true
                            }
                        },width: '80px',align:'center',halign:'center'},
                        {field:'heatno',title:'炉批号',editor: {
                            type: 'validatebox',
                            options: {
                                required: true
                            }
                        },width: '80px',align:'center',halign:'center'},
                        {field:'supporname',title:'供货商',
                            editor:{
                                type:'combobox',
                                options:
                                    {
                                        valueField:'supporname',
                                        textField:'supporname',
                                        method:'get',
                                        required:true,
                                    }
                            },width:'100px',align:'center',halign: 'center'},
                        {field:'receivenum',title:'重量',
                            editor:{
                                type:'validatebox',
                                options:{
                                    required:true
                                }
                            },width:60,align:'center',halign: 'center',required: true},
                        {field:'item',title:'件/托',
                            editor:{
                                type:'validatebox',
                            },width:60,align:'center',halign: 'center',required: true},
                        {field:'receivedate',title:'入库日期',width: '150px',align:'left',halign: 'center'},
                        {field:'receiveman',title:'收货人',width: '80px',align:'center',halign: 'center'},
                        {field:'receivetime',title:'收货时间',width: '150px',align:'left',halign: 'center'},
                    ]],
                    pagination:true,
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#MR-Input').datagrid({
            rowStyler: function (index, row) {
                var over = row.process;
                if (over=='生产中') {
                    return 'background-color:red;color:white';
                }else if(over=='已完成' ){
                    return 'background-color:green ;color:white;';
                }
            }
        });
        $('#MR-Input').datagrid('loadData',{total:0,rows:[]});
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

    function MR_go() {
        var one =1;
        var plant=  $('#mrPlant').combobox('getText');//委托事业部
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var username = localStorage.getItem("User");
        var row  = $('#MR-Data').datagrid("getSelected");
        var plant1 = localStorage.getItem("Department");
        if(plant1==plant){
            if (endEditing()) {
                $('#MR-Input').datagrid('appendRow', {
                    fname:row.fname,
                    material:row.ftemp3,
                });
                editIndex = $('#MR-Input').datagrid('getRows').length - 1;
                /*
                 获取供应商
                 */
                $.ajax({
                    type: "post",
                    url: "${ctxPath}/MaterialReceive/FindSp.action",
                    data: {
                      plant :localStorage.getItem("Department"),
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        console.log(data);
                        var ed = $('#MR-Input').datagrid('getEditor', {index: editIndex, field: 'supporname'});
                        $(ed.target).combobox('loadData', data);

                    }
                });
                $('#MR-Input').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
                $("input.datagrid-editable-input").keydown(function (e) {
                    var code = e.keyCode || e.which;
                    if (code === 13) {
                        var daty = new Date();
                        var NowHour = daty.getHours();
                        var NowMinute = daty.getMinutes();
                        var NowSecond = daty.getSeconds();
                        var mc = (NowHour * 3600) + (NowMinute * 60) + NowSecond;
//                            if ((mc - $('#time12').val()) > 3)//600只是一个时间值，就是5分钟内禁止重复提交
//                            {
                        var einput = $('#MR-Input').datagrid('getEditor', {
                            index: editIndex,
                            field: 'receivenum'
                        });
                        if ($(einput.target).val() === '0.0' || parseFloat($(einput.target).val()) === 0.0) {
                            $.messager.alert('温馨提示', '请完善好数据再保存!')
                        } else {
                            $('#MR-Input').datagrid('endEdit', editIndex);
                            var rowkc = $('#MR-Input').datagrid('getRows');
                            var rowData = rowkc[editIndex];
                            $.messager.confirm('温馨提示', '你确定要保存吗?', function (r) {
                                if (r) {
                                    $.ajax({
                                        type: "post",//数据发送的方式（post 或者 get）
                                        url: "${ctxPath}/MaterialReceive/MaterialReceive.action",//要发送的后台地址
                                        data: {
                                            fno: row.fno,
                                            ftemp3: row.ftemp3,
                                            ftemp4: row.ftemp4,
                                            ftemp7: row.ftemp7,
                                            pono:rowData.pono,
                                            supporname:rowData.supporname,
                                            receivenum:rowData.receivenum,
                                            item:rowData.item,
                                            fname:rowData.fname,
                                            heatno:rowData.heatno,
                                            plant: localStorage.getItem("Department"),
                                            inputdate: time,
                                            ReceiveMan: localStorage.getItem("User"),
                                            uyear:uyear,
                                            umonth:umonth,
                                        },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (data1) {//ajax请求成功后触发的方法
                                            console.log(data1);
                                            if (data1.num > 0) {
                                                $.messager.alert('温馨提示', '保存成功!');
                                                getDay();
                                            }

                                        },

                                        error: function (msg) {//ajax请求失败后触发的方法
                                            alert(msg);//弹出错误信息
                                        }
                                    });
                                }
                            });
                        }
                    }


                });
            }
            else{
                $.messager.alert('温馨提示', '存在未编辑完数据!');

            }
        }else {
            $.messager.alert('温馨提示', '不能跨事业部操作!');
        }







    }
    var editIndex = undefined;
    var ydIndex = undefined;
    function endEditing(){
        //alert(editIndex);
        if (editIndex == undefined){return true}
        if ($('#MR-Input').datagrid('validateRow', editIndex)){
            //alert(2222);
//            var editor = $('#kc').datagrid('getEditor',{index:editIndex,field:"itemno"});
//            var productname = $(editor.target).val();
//
//
//
//
//            $('#kc').datagrid('getRows')[editIndex]['productname'] = productname;
            $('#MR-Input').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function  MR_back() {
        var row  = $("#MR-Input").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    if (row.id === undefined) {
                        if (editIndex == undefined) {
                            return
                        }
                        $('#MR-Input').datagrid('cancelEdit', editIndex)
                            .datagrid('deleteRow', editIndex);
                        editIndex = undefined;
                        $('#MR-Data').datagrid('loadData',{total:0,rows:[]});
                        $('#MR-Input').datagrid('loadData',{total:0,rows:[]});
                        getDay();
                    }else{
                        jQuery.ajax({
                            type: "POST",   //post提交方式默认是get
                            url: "${ctxPath}/MaterialReceive/deleteMaterial.action",
                            dataType: "json",
                            data: {
                                id : row.id,
                            },
                            error: function (request) {      // 设置表单提交出错
                                $.messager.progress('close');
                                $.messager.alert('信息提示', '出错了！', 'info');
                            },
                            success: function (data) {
                                console.log(data);
                                if(data.num>0){
                                    $.messager.alert('信息提示', '删除成功！！！');
                                    getDay();
                                    $('#MR-Input').datagrid('loadData',{total:0,rows:[]});
                                }else{
                                    $.messager.alert('信息提示', '删除失败！！！');
                                    $('#MR-Input').datagrid('loadData',{total:0,rows:[]});
                                }
                            }
                        })
                    }
                }
            })
        }



    }
</script>
