<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/5
  Time: 8:23--计划管理
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


    .N{
        width:50%;
        height:75%;
    }

    .M{
        width:10%;
        height:75%;
    }
    .x3{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .z2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.9em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 100px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="计划管理" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
            <div class="wu-toolbar-button">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="pm_add()" plain="true">计划导入</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="pm_export()" plain="true">计划导出</a>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <div style="float:left;">
                    <table>
                        <tr>
                            <td><label>物料编码：</label><input id="pm_fno" class="easyui-textbox" style="width:145px">&nbsp&nbsp&nbsp</td>
                            <td> <label>节点工序：</label>
                                <select class="easyui-combobox" name="takekind" datatype="text" id="pm_ProcessNode"  panelHeight="auto" style="width:85px">
                                    <option value="热处" selected="selected">热处</option>
                                    <option value="表处">表处</option>
                                </select>&nbsp&nbsp&nbsp</td>
                            <td rowspan="2"><a href="#" class="easyui-linkbutton"  onclick="pm_query()" data-options="iconCls:'icon-search'" style="width:60px;height: 50px">查询</a></td>
                        </tr>
                        <tr>
                            <td><label>物料描述：</label><input id="pm_fname" class="easyui-textbox" style="width:80px">
                                <select class="easyui-combobox" name="mmPlant" style="width:60px" datatype="text" id="Fname" panelHeight="auto" data-options="
                                valueField:'Statusname',
                                textField:'Statusname',
                                panelHeight:'250'"
                                        style="width:60px">
                                </select>&nbsp&nbsp&nbsp
                            </td>
                            <td><label>打印标记：</label>&nbsp<input  id ="pm_WorkCentre" style="width:85px" class="easyui-textbox">&nbsp&nbsp&nbsp
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="float:left;">
                    <input style="width: 20px;border: 0px;" readonly>
                </div>
               <div style="float:left;">
                   <table>
                       <tr>
                           <td><label><span class="z2">年月：</span></label><input  id ="pmdb1" style="width:110px" class="easyui-datebox">&nbsp&nbsp&nbsp</td>
                           <td rowspan="2"><a href="#" class="easyui-linkbutton"  onclick="pms_query()" data-options="iconCls:'icon-search'" style="width:60px;height: 50px">查询</a></td>
                       </tr>
                       <tr>
                           <td> <label><span class="x3">事业部：</span></label>
                               <select class="easyui-combobox" name="mmPlant" style="width:110px" datatype="text" id="pmiPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                       style="width:110px">
                               </select>&nbsp&nbsp&nbsp</td>
                       </tr>
                   </table>
               </div>

            </div>

        </div>
        <div class="easyui-layout haorooms"   >
            <!--开卡信息-->
            <div class="N" data-options="region:'west',split:true" >
                <table id="PM-Data" class="easyui-datagrid" style="white-space: nowrap;height: 100%"   data-options="singleSelect:true"></table>
            </div>
            <!--收发按钮-->
            <div class="" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
                        <button id="PM-go" onclick="PM_go()"  class="easyui-linkbutton" style="margin-top: 80px">下达>></button>
                    </div>
                    <div style="">
                        <button id="MI-back" class="easyui-linkbutton" onclick="MI_back()">删除<<</button>
                    </div>
            </div>
            <!--接收明细-->
            <div class="N"  data-options="region:'east',split:true">
                <table class="easyui-datagrid" id="PM-Input"  style="white-space: nowrap;height: 100%"data-options="singleSelect:true,editor:'text'" ></table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var i;
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#pmdb1').val(year+"-"+month+"-"+day);
//        $('#ptdb').val(year+"-"+month+"-"+day);
        var db = $('#pmdb1');
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
            url:'${ctxPath }/MonthPlan/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#pmiPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MonthPlan/FindFname.action',
            dataType: "json",
            data: {

            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#Fname').combobox('loadData', data);
                //alert(11111);

            }
        });
    });

    function pm_query() {
        var fno = $('#pm_fno').val();
        var fname = $('#pm_fname').val();
        var ProcessNode = $('#pm_ProcessNode').combobox('getValue');
        var Fname = $('#Fname').combobox('getValue');
        var WorkCentre = $('#pm_WorkCentre').val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/PlanningManagement/query.action",//要发送的后台地址
            data: {
                fno:fno,
                fname:fname,
                ProcessNode:ProcessNode,
                Fname:Fname,
                WorkCentre:WorkCentre,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#PM-Data").datagrid({
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
                        {field:'id',title:'id',width: '55px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'fname',title:'物料描述',width: '250px',align:'left',halign:'center'},
                        {field:'workcentre2',title:'打印标记',width:'150px',align:'left',halign: 'center'},
                        {field:'f1',title:'节点工序',width: '60px',align:'center',halign: 'center'},
                        {field:'fno',title:'物料编码',width: '100px',align:'left',halign: 'center'},
                    ]],
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#PM-Data').datagrid('loadData',{total:0,rows:[]});
    }
    var inputdata = '';
    function pms_query() {
        var fno = $('#pm_fno').val();
        var fname = $('#pm_fname').val();
        var ProcessNode = $('#pm_ProcessNode').combobox('getValue');
        var AxleNum3 = $('#Fname').combobox('getValue');
        var pmiPlant = $('#pmiPlant').combobox('getText');
        var WorkCentre = $('#pm_WorkCentre').val();
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/PlanningManagement/queryDay.action",//要发送的后台地址
            data: {
                fno:fno,
                fname:fname,
                ProcessNode:ProcessNode,
                AxleNum3:AxleNum3,
                Plant:pmiPlant,
                WorkCentre:WorkCentre,
                inputdata:inputdata,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                inputdata= '';
                $("#PM-Input").datagrid({
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
                        {field:'id',title:'id',width: '55px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'fno',title:'物料编码',width: '100px',align:'center',halign: 'center'},
                        {field:'fname',title:'物料描述',width: '250px',align:'left',halign:'center'},
                        {field:'workcentre',title:'打印标记',width:'150px',align:'left',halign: 'center'},
                        {field:'processnode',title:'节点工序',width: '60px',align:'center',halign: 'center'},
                        {field:'surface',title:'表面处理',width: '60px',align:'center',halign: 'center'},
                        {field:'department',title:'车间',width: '90px',align:'center',halign: 'center'},
                        {field:'plant',title:'所属工厂',width: '80px',align:'center',halign: 'center'},
                    ]],
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#PM-Input').datagrid('loadData',{total:0,rows:[]});
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

    function PM_go() {

        var plant=  $('#pmiPlant').combobox('getText');
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var username = localStorage.getItem("User");
        var row  = $('#PM-Data').datagrid("getSelected");
        var f5 =row.f5;
        var plant1 = localStorage.getItem("Department");
            if(row!=null){
                if(plant==plant1) {
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url:'${ctxPath}/PlanningManagement/Juge.action',
                        dataType: "json",
                        data: {
                            fno:row.fno,
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            console.log(data);
                            if(data.num<0){
                                $.ajax({
                                    type: "post",
                                    url: "${ctxPath}/PlanningManagement/insertFno.action",
                                    data: {
                                        time:time,
                                        username:username,
                                        fno:row.fno,
                                        fname:row.fname,
                                        workcentre:row.workcentre2,
                                        f1:row.f1,
                                        f5:f5,
                                        plant:plant1,
                                        ftemp2:row.ftemp2,
                                        ftemp3:row.ftemp3,
                                        ftemp4:row.ftemp4,
                                    },
                                    dataType: "json",//后台处理后返回的数据格式
                                    success: function (data) {//ajax请求成功后触发的方法
                                        console.log(data);
                                        inputdata = uyear+"-"+umonth+"-"+uday;
                                        pms_query();
                                    }
                                });
                            }else {
                                $.messager.alert("温馨提示","该物料编码已存在!!!");
                            }
                        }
                    });

                } else{
                $.messager.alert('温馨提示', '无权进行操作!');
            }
            }
            else{
                $.messager.alert('温馨提示', '请选择行项目');

            }
    }

    function  MI_back() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var row  = $("#PM-Input").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "${ctxPath}/PlanningManagement/deleteTake.action",
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
                                inputdata = uyear+"-"+umonth+"-"+uday;
                                $('#PM-Data').datagrid('loadData',{total:0,rows:[]});
                                $('#PM-Input').datagrid('loadData',{total:0,rows:[]});
                                pms_query();
                            }else{
                                $.messager.alert('信息提示', '删除失败！！！');
                                $('#PM-Data').datagrid('loadData',{total:0,rows:[]});
                                $('#PM-Input').datagrid('loadData',{total:0,rows:[]});
                            }
                        }
                    })
                }
            })
        }



    }
    function pm_add() {
        var date=new Date();
        var planyear = date.getFullYear();
        var planmonth = date.getMonth()+1;
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var upload = new Ext.form.FormPanel({
            frame: true,
            labelWidth: 100,
            labelAlign: 'right',
            fileUpload: true,
            border: true,
            defaults: {
                width: 200,
                allowBlank: false,
                blankText: '该项不能为空！'
            },
            items: [{
                xtype: 'displayfield',
                value: '上传文件为[*.xls]&nbsp;&nbsp;&nbsp;&nbsp;'
//                '<a href="javascript:;" onclick="monp_download_log();" style="color: green;">模版下载</a>'
            }, {
                id: 'formFile',
                fieldLabel: "导入文件",
                name: 'uploadFile',
                params: {
                    "umouth": planmonth,
                    "User": localStorage.getItem("User"),
                },
                xtype: 'textfield',
                fileUpload: true,
                inputType: 'file',
                listeners: {
                    render: function () {
                        Ext.get('formFile').on("change", function () {
                            var file = this.getValue();
                            var fs = file.split('.');
                            if (fs[fs.length - 1].toLowerCase() == 'xls') {
                                Ext.MessageBox.show({
                                    title: '信息',
                                    msg: '<font color="green">确定要上传文件:' + file + '？</font>',
                                    params: {
                                        "year": planyear,
                                        "month":planmonth,
                                        "User": localStorage.getItem("User"),
                                        time:time,
                                    },
                                    width: 300,
                                    buttons: {'ok': '确定', 'no': '取消'},
                                    icon: Ext.MessageBox.WARNING,
                                    closable: false,
                                    fn: function (e) {
                                        if (e == 'ok') {
                                            if (upload.form.isValid()) {
                                                upload.getForm().submit({

                                                    url: '${ctxPath}/PlanningManagement/import.action',
                                                    method: 'POST',
                                                    params: {
                                                        "year": planyear,
                                                        "month":planmonth,
                                                        "User": localStorage.getItem("User"),
                                                        "time":time,
                                                    },
                                                    waitTitle: '系统提示',
                                                    waitMsg: '正在上传,请稍后...',
                                                    success: function (form, action) {
                                                        console.log(action);
                                                        var msg = action.result.message;
                                                        Ext.MessageBox.show({
                                                            title: '信息',
                                                            width: 250,
                                                            msg: msg,
                                                            buttons: {'ok': '确定', 'no': '取消'},
                                                            icon: Ext.MessageBox.INFO,
                                                            closable: false,
                                                            fn: function (e) {
                                                                if (e == 'ok') {
                                                                    win.close();
                                                                    inputdata =  uyear+"-"+umouth+"-"+uday;
                                                                    pms_query();
                                                                } else {
                                                                    Ext.getCmp('formFile').setValue('');
                                                                }
                                                            }
                                                        });
                                                    }
                                                });
                                            }
                                            else {
                                                Ext.MessageBox.show({
                                                    title: '信息',
                                                    width: 200,
                                                    msg: '请填写完成再提交!',
//                                            animEl:'insert.win.info',
                                                    buttons: {'ok': '确定'},
                                                    icon: Ext.MessageBox.ERROR,
                                                    closable: false
                                                });
                                            }
                                        }
                                    }
                                });
                            } else {
                                Ext.MessageBox.show({
                                    title: '信息',
                                    width: 200,
                                    msg: '上传文件格式不对,请重新选择!',
                                    buttons: {'ok': '确定'},
                                    icon: Ext.MessageBox.ERROR,
                                    closable: false,
                                    fn: function (e) {
                                        if (e == 'ok') {
                                            Ext.getCmp('formFile').setValue('');
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            }]
        });
        var win = new Ext.Window({
            title: '上传',
            width: 400,
            height: 150,
            layout: 'fit',
            modal: true,
            items: [upload],
            bbar: ['->', {
//    		id:'insert.win.info',
//    		text:'上传',
//    		handler:function(){
//
//    		}
//    	},{
                text: '关闭',
                handler: function () {
                    win.close();
                }
            }]
        }).show();
    }

    function pm_export() {
        var fno = $('#pm_fno').val();
        var fname = $('#pm_fname').val();
        var ProcessNode = $('#pm_ProcessNode').combobox('getValue');
        var AxleNum3 = $('#AxleNum3').combobox('getValue');
        var pmiPlant = $('#pmiPlant').combobox('getText');
        var WorkCentre = $('#pm_WorkCentre').val();
        var url = "../${ctxPath}/Export/pmExport?fno="+fno+"&fname="+fname+"&ProcessNode="+ProcessNode+"&AxleNum3="+AxleNum3+"&pmiPlant="+pmiPlant+"&WorkCentre="+WorkCentre+"";
        window.location.href = url;
    }
</script>
