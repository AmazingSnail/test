<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/6
  Time: 8:57 ==生产工艺
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
    .cz{
        width:100%;
        height:100%;
    }
    .pp2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .pp1{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .w1{
        letter-spacing:0.1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.1em; /*同上*/
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 78px);
    }


    body{
        padding: 0px;
        margin: 0px;
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <iframe id="proxy2" style="display:none"></iframe>
        <div class="easyui-panel " title="生产工艺" data-options="fit:true">
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 78px;">
                <div class="wu-toolbar-button" >
                        <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="pp_add()" plain="true">导入</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="pp_export()" plain="true">导出</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="ppadd()" plain="true">添加</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="ppdelete()" plain="true">删除</a>
                </div>
                <div class="wu-toolbar-search" >
                    <div style="white-space:nowrap">
                        <table>
                            <tr>
                                <td> <label><span class="x3">事业部：</span></label>
                                    <select class="easyui-combobox" name="mmPlant" style="width:110px" datatype="text" id="ppPlant" panelHeight="auto" data-options="
                             valueField:'Fname',
                                textField:'Fremark',
                                panelHeight:'250'"
                                            style="width:110px">
                                    </select></td>
                                <td><label>图号：</label><input  id ="pp-PartDrawing" style="width:110px" class="easyui-textbox">&nbsp</td>
                                <td><label>图号名称：</label><input  id ="pp-PartName" style="width:110px" class="easyui-textbox">&nbsp</td>
                                <td><label>材质：</label><input  id ="pp-matail" style="width:110px" class="easyui-textbox">&nbsp</td>
                                <td><label>模板名称：</label><input  id ="pp-MBMC" style="width:110px" class="easyui-textbox">&nbsp</td>
                                <td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="ppquery()"  >查询</a></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div id="trt_dd" class="easyui-layout cz"  data-options="fit:true">
                    <div style="width: 100%;height:100%" data-options="region:'center'">
                        <table id="ppid" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="生产工艺" data-options=""></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var id="";
    function ppdelete() {
        var row = $("#ppid").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    var id = row.id;
                    $.ajax({
                        type:"post",
                        url: "${ctxPath}/ProductionProcess/Deletedata.action",//要发送的后台地址
                        data:{
                            id:id,
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data1) {//ajax请求成功后触发的方法
                            console.log(data1);
                            if (data1.num !=-1) {
                                $.messager.alert('温馨提示', '删除成功');
                                ppquery();
                            }else {
                                $.messager.alert('温馨提示', '删除失败');
                            }

                        },
                    })
                }
            })
        }
    }
function ppadd() {
    $('#ppid').datagrid('clearSelections');
    parent.$.modalDialog({
        width : '40%',
        height : '70%',
        href : '${ctxPath }/ProductionProcessEdit',
        buttons : [
            {
                text : '确认',
                iconCls: "icon-save",
                handler : function() {
                    Insert();
                    ppquery();
                }
            },
            {
                text: "取消",
                iconCls: "icon-cancel",
                handler:function(){
                    ProductionProcessEditCancel();
                }
            }
        ]
    });
}
    $("#ppid").datagrid({
        //双击事件
        onDblClickRow: function (index, row) {
            parent.$.modalDialog({
                width : '40%',
                height : '70%',
                href : '${ctxPath }/ProductionProcessEdit',
                buttons : [
                    {
                        text : '确认',
                        iconCls: "icon-save",
                        handler : function() {
                            Insert();
                        }
                    },
                    {
                        text: "取消",
                        iconCls: "icon-cancel",
                        handler:function(){
                            ProductionProcessEditCancel();
                        }
                    }
                ]
            });
        }
    });
    function pdonblur () {
        var  Outfname = $('#Outfname').val();
        if(Outfname==""){
            return false;
        }else {
            $.ajax({
                type:"post",
                url: "${ctxPath}/MouldManage/look.action",//要发送的后台地址
                data:{
                    partDrawing:Outfname,
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data1) {//ajax请求成功后触发的方法
                    console.log(data1);
                    if (data1.num !=-1) {
                        $('#Outworkcentre2').textbox("setValue",data1.projectname);
                    }else {
                        $('#Outfname').val("");
                        $.messager.alert('温馨提示', '此模具规格不存在');

                    }

                },
            })
        }

    }
    //    function  UpDocument  () {
    //            $("#excelFile").trigger("click");
    //    };

    //文件上传
    function UpDocument(){
        var myDate = new Date();
        var uyear = myDate.getFullYear();//当前年
        var umonth = myDate.getMonth()+1;//当前月
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var name = localStorage.getItem("User");
        var  Outfname = $('#Outfname').val();
        var  Outworkcentre2= $('#Outworkcentre2').val();
        var  ids=id;
        if(Outfname!=""){
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
                    value: '上传文件为[*.pdf]&nbsp;&nbsp;&nbsp;&nbsp;'
//                '<a href="javascript:;" onclick="monp_download_log();" style="color: green;">模版下载</a>'
                }, {
                    id: 'formFile',
                    fieldLabel: "导入文件",
                    name: 'uploadFile',
                    params: {
                        "umouth": umonth,
                        "User": localStorage.getItem("User"),
                        "mpupinst": $('input[name="adminFlag"]:checked').val()
                    },
                    xtype: 'textfield',
                    fileUpload: true,
                    inputType: 'file',
                    listeners: {
                        render: function () {
                            Ext.get('formFile').on("change", function () {
                                var file = this.getValue();
                                var fs = file.split('.');
                                if (fs[fs.length - 1].toLowerCase() == 'pdf') {
                                    Ext.MessageBox.show({
                                        title:'信息',
                                        msg:'<font color="green">确定要上传文件:'+file+'？</font>',
                                        params:{
                                            "time":time,
                                            "name":name,
                                            "PartDrawing":Outfname,
                                            "PartName":Outworkcentre2,
                                            "AddFileName":file,
                                            "id":ids,
                                        },
                                        width:300,
                                        buttons:{'ok':'确定','no':'取消'},
                                        icon:Ext.MessageBox.WARNING,
                                        closable:false,
                                        fn:function(e){
                                            if(e == 'ok'){
                                                if (upload.form.isValid()) {
                                                    upload.getForm().submit({
                                                        url: '${ctxPath}/ProcessDocument/upload.action',
                                                        method: 'POST',
                                                        params: {
                                                            "time":time,
                                                            "name":name,
                                                            "PartDrawing":Outfname,
                                                            "PartName":Outworkcentre2,
                                                            "AddFileName":file,
                                                            "id":ids,
                                                        },
                                                        waitTitle :'系统提示',
                                                        waitMsg :'正在上传,请稍后...',
                                                        success : function(form,action) {
                                                            console.log(action);
                                                            var msg = action.result.message;
                                                            Ext.MessageBox.show({
                                                                title:'信息',
                                                                width:250,
                                                                msg:msg,
                                                                buttons:{'ok':'确定','no':'取消'},
                                                                icon:Ext.MessageBox.INFO,
                                                                closable:false,
                                                                fn:function(e){
                                                                    if(e=='ok'){
                                                                        var id = action.result.id;
                                                                        win.close();
                                                                        $.ajax({
                                                                            type:"post",
                                                                            url: "${ctxPath}/ProcessDocument/search.action",//要发送的后台地址
                                                                            data:{
                                                                                id:id,
                                                                            },
                                                                            dataType: "json",//后台处理后返回的数据格式
                                                                            success: function (data1) {//ajax请求成功后触发的方法
                                                                                console.log(data1);
                                                                                if (data1.num !=-1) {
                                                                                    // $('#Outlocation').textbox("setValue",data1.craftFileName);
                                                                                    id="";
                                                                                    $('#fmsave').form('clear');
                                                                                    $("#dlgpdsave").dialog("close");
                                                                                    pdquery();
                                                                                }else {
                                                                                    $.messager.alert('温馨提示', '此模具规格不存在');
                                                                                    $('#fmsave').form('clear');
                                                                                    $("#dlgpdsave").dialog("close");
                                                                                    id="";
                                                                                }

                                                                            },
                                                                        })
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
                                                        title:'信息',
                                                        width:200,
                                                        msg:'请填写完成再提交!',
//                                            animEl:'insert.win.info',
                                                        buttons:{'ok':'确定'},
                                                        icon:Ext.MessageBox.ERROR,
                                                        closable:false
                                                    });
                                                }
                                            }
                                        }
                                    });
                                }else {
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
                }],
            });
            var win = new Ext.Window({
                title:'附件一',
                width:400,
                height:150,
                layout:'fit',
                modal:true,
                items:[upload],
                bbar:['->',{
                    id:'insert.win.info',
//    		text:'上传',
//    		handler:function(){
//
//    		}
//    	},{
                    text:'关闭',
                    handler:function(){
                        win.close();
                    }
                }]
            }).show();
        }else {
            $.messager.alert('温馨提示', '产品图号不能为空');
        }


    }


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
            url:'${ctxPath }/PersonnelMaintenance/query1.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#ppPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
    });
    function ppquery() {
       var plant = $('#ppPlant').combobox("getText");
       var PartDrawing = $('#pp-PartDrawing').val();
       var PartName = $('#pp-PartName').val();
       var matail = $('#pp-matail').val();
       var MBMC = $('#pp-MBMC').val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/ProductionProcess/query.action",//要发送的后台地址
            data: {
                plant:plant,
                PartDrawing:PartDrawing,
                PartName:PartName,
                matail:matail,
                MBMC:MBMC,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#ppid").datagrid({
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
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'partdrawing',title:'图号',width: '100px',align:'left',halign:'center'},
                        {field:'partname',title:'图号名称',width: '150px',align:'left',halign:'center'},
                        {field:'templetnum',title:'模板编号',width: '220px',align:'left',halign: 'center'},
                        {field:'templetname',title:'模板名称',width:'70px',align:'center',halign: 'center'},
                        {field:'material',title:'材质',width: '150px',align:'right',halign: 'center'},
                        {field:'quenchtemp1',title:'淬火1区温度',width: '100px',align:'center',halign: 'center'},
                        {field:'quenchtemp2',title:'淬火2区温度',width: '100px',align:'center',halign: 'center'},
                        {field:'quenchtemp3',title:'淬火3区温度',width: '100px',align:'center',halign: 'center'},
                        {field:'quenchtemp4',title:'淬火4区温度',width: '100px',align:'center',halign: 'center'},
                        {field:'quenchtemp5',title:'淬火5区温度',width: '100px',align:'center',halign: 'center'},
                        {field:'quenchtime',title:'淬火保温时间',width: '150px',align:'right',halign: 'center'},
                        {field:'carbinolf',title:'甲醇流量',width: '100px',align:'center',halign: 'center'},
                        {field:'carpotential',title:'碳势',width: '100px',align:'center',halign: 'center'},
                        {field:'quenchhard',title:'淬火硬度',width: '100px',align:'center',halign: 'center'},
                        {field:'coating',title:'渗层',width: '100px',align:'center',halign: 'center'},
                        {field:'cooltemp',title:'淬火介质温度',width: '100px',align:'center',halign: 'center'},
                        {field:'tempertemp',title:'回火温度',width: '100px',align:'center',halign: 'center'},
                        {field:'tempertime',title:'回火保温时间',width: '180px',align:'right',halign: 'center'},
                        {field:'temperhard',title:'回火硬度',width: '100px',align:'center',halign: 'center'},
                    ]],
                });
//                $('#HalfPartOut-Data').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
//                $('#HalfPartOut-Data').datagrid({
//                    rowStyler: function (index, row) {
//                        var CLNumber =parseFloat(row.CLNumber);
//                        var ConnectPlan =parseFloat(row.ConnectPlan);
//                        //alert(11);
//                        if (CLNumber !== ConnectPlan) {
//                            return 'color:black;';
//                        }
//                        else {
////                            return 'color:Green;font-weight:bold;';
//                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
//                        }
//
//                    }
//                });


            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#ppid').datagrid('loadData',{total:0,rows:[]});
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
    function pdadd() {
        $("#fmsave").form('clear');
        $("#dlgpdsave").dialog("open");
    }
</script>
