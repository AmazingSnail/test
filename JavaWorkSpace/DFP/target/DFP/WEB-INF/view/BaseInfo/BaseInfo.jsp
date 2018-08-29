<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-12
  Time: 13:30  ---人员维护
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
    .easyui-panelB {
        width: 100%;
        height: 100%;
    }
    .BL{
        width:15%;
        height:75%;
    }

    .BP{
        width:87%;
        height:75%;
    }
    #yuanjiao{
        font-family: Arial;
        border: 2px solid #379082;
        border-radius: 20px;
        padding: 30px 30px;
        width: 330px;
    }
    .bi1{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.4em; /*同上*/
    }
    .bi2{
        letter-spacing:1.79em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }
    .bi3{
        letter-spacing:0.15em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */

    }
    .haorooms1{
        height: calc(100% - 40px);
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
        <div class="easyui-panelB "  data-options="fit:true">
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 40px;">
                <div class="wu-toolbar-button" >
                </div>
                <div class="wu-toolbar-search" >
                    <label><span class="m3">事业部：</span></label>
                    <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="BWERKS" panelHeight="auto" data-options="
                               valueField:'statusid',
                                textField:'statusname',
                                panelHeight:'250'"
                            style="width:100px">
                    </select>
                    <label>厂内机型：</label><input id="BZmach" class="easyui-textbox" style="width:100px">
<shiro:hasPermission name="/BaseInfo/adddata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="adddata()" plain="true" style="width: 100px;text-align: center">添加</a>
</shiro:hasPermission>
                    <shiro:hasPermission name="/BaseInfo/deletedata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="deletedata()" plain="true" style="width: 100px;text-align: center">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="/BaseInfo/updatedata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="updatedata()" plain="true" style="width: 100px;text-align: center">修改</a>
</shiro:hasPermission>
<shiro:hasPermission name="/BaseInfo/importdata">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="importdata()" plain="true" style="width: 100px;text-align: center">导入</a>
</shiro:hasPermission>
                </div>
            </div>
            <div class="easyui-layout haorooms1"  >
                <div class="BL" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <ul id="treepmb" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="BP"  data-options="region:'east',split:true">
                    <table id="pm" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var i='' ;
    var j ='';
    var ids = '';
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;

    var name = "";

    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        getplant();


//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#trt_More").hide();

        });
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
//        $("#trt_toolbar").blur(function(){
//            $("#trt_More").toggle();
//        })

//树形结构
        //加载全部节点
        $("#treepmb").tree({
            url: '${pageContext.request.contextPath}/Tractor/query2.action',
            animate:true,
            lines:true,
            onClick: function (node) {
                //右侧跳转到指定页面
//                addTab(node.text,node.menuUrl);

                    i = node.text;
                    j = node.id;
            },
            loadFilter:function(data){
                console.log(data);
                if(data.text){
                    return data.text ;
                }else{
                    return data ;
                }
            }
        });


    });
    function getplant() {
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

                $('#BWERKS').combobox('loadData', data);

            }
        });
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
    $("#treepmb").tree({
        onClick:function(node){
            i = node.text;
            j = node.id;
            Query();
        }
    });
   function Query () {
       var BZmach = $('#BZmach').val();
       var plant1 = localStorage.getItem("Department");
       var plant='';
           plant = $('#BWERKS').combobox('getText');
           $.ajax({
               type:"POST",   //post提交方式默认是get
               url:"${pageContext.request.contextPath}/Tractor/query1.action",
               dataType:"json",
               data: {
                   name:i,
                   BZmach:BZmach,
                   plant: plant
               },
               success:function(data) {
                   console.log(data);
                   fdata = data;
                   $('#pm').datagrid({
                       data: fdata,
                       loadFilter:pagerFilter,
                       rownumbers:true,
                       fit: false, //自动适屏功能
                       nowrap:false,
                       width:'auto',
                       pageList:[25,50,100],//分页列表
                       pagination:true,
                       multiSort:true,
                       remoteSort:false,
                       singleSelect: false, //允许选择多行
                       //fitColumns:true,
                       //fit:true,
                       method:'get',
                       data:fdata,
                       columns: [[
                           {field:'ck', checkbox: true, width: '30' },  //复选框
                           {field:'id',title:'id',width:'50px',editor:'text',halign:"center",align:'left',hidden:'hidden'},
                           {field:'zmach',title:'厂内机型',width:'100px',editor:'text',align:'center',halign:"center"},
                           {field:'type',title:'机型名称',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'model',title:'机型',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'wheelbase',title:'轴距',width:'100px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'outsize',title:'外廓尺寸',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'demarcatedforce',title:'标定牵引力',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'minuse',title:'最小使用质量',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'execstd',title:'执行标准',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型合格证主数据'?false:true,},
                           {field:'zchyj',title:'发动机型号',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型发动机'?false:true,},
                           {field:'power',title:'功率',width:'80px',editor:'text',align:'center',halign:"center",hidden:i=='车型发动机'?false:true,},
                           {field:'tyresize',title:'轮胎位置',width:'80px',editor:'text',align:'center',halign:"center",hidden:i=='车型轮胎'?false:true,},
                           {field:'tirespect',title:'轮胎规格',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型轮胎'?false:true,},
                           {field:'wheelsize',title:'轮距',width:'150px',editor:'text',align:'center',halign:"center",hidden:i=='车型轮胎'?false:true,},
                           {field:'inputman',title:'录入人',width:'80px',editor:'text',align:'center',halign:"center"},
                           {field:'inputtime',title:'录入时间',width:'150px',editor:'text',align:'center',halign:"center"},
                           {field:'modifyman',title:'修改人',width:'80px',editor:'text',align:'center',halign:"center"},
                           {field:'modifytime',title:'修改时间',width:'150px',editor:'text',align:'center',halign:"center"},
                           {field:'plant',title:'事业部',width:'100px',editor:'text',align:'center',halign:"center"},
                       ]]
                   })
                   $('#pm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
               },
           })
           $('#pm').datagrid('loadData',{total:0,rows:[]});
   }
   function b_query() {
       if(i==""){
           $.messager.alert("温馨提示","选择添加目录!");
       }else {

       }
   }
   function adddata() {
       $('#pm').datagrid('clearSelections');
           if(i==""){
               $.messager.alert("温馨提示","选择添加目录!");
           }else {
               var WERKS = $('#BWERKS').combobox('getText');
               var WERKS1 = localStorage.getItem("Department");
               if(WERKS==WERKS1 ||WERKS1 =='信息中心'){
                   if(i=="车型合格证主数据"){
                       $('#pm').datagrid('clearSelections');
                       parent.$.modalDialog({
                           width : '25%',
                           height : '75%',
                           href : '${pageContext.request.contextPath}/DateEdit',//这个页面zaina
                           buttons : [
                               {
                                   text : '确认',
                                   iconCls: "icon-save",
                                   handler : function() {
                                       Savedate();
                                   }
                               },
                               {
                                   text: "取消",
                                   iconCls: "icon-cancel",
                                   handler:function(){
                                       DateEditCancel();
                                       var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                                       $('#treepmb').tree('select', node.target);//设置选中该节点
                                       Query();
//                                       $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                   }
                               }
                           ]
                       });
                   }
                   if(i=="车型发动机"){
                       ZMACH= '';
                       ZMACH2='';
                       ZMACH3 = '';
                       ZCHYJ = '';
                       Power = '';
                       $('#pm').datagrid('clearSelections');
                       parent.$.modalDialog({
                           width : '25%',
                           height : '40%',
                           href : '${pageContext.request.contextPath}/EngineEdit',
                           buttons : [
                               {
                                   text : '确认',
                                   iconCls: "icon-save",
                                   handler : function() {
                                       Save1();
//                                       Query();
//                                       $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                   }
                               },
                               {
                                   text: "取消",
                                   iconCls: "icon-cancel",
                                   handler:function(){
                                       Query();
                                       EngineEdit();
                                       var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                                       $('#treepmb').tree('select', node.target);//设置选中该节点
                                       ZMACH= '';
                                       ZMACH2='';
                                       ZMACH3 = '';
                                       ZCHYJ = '';
                                       Power = '';
                                   }
                               }
                           ]
                       });
                   }
                   if(i=="车型轮胎"){
                       $('#pm').datagrid('clearSelections');
                       parent.$.modalDialog({
                           width : '25%',
                           height : '45%',
                           href : '${pageContext.request.contextPath}/TyreEdit',
                           buttons : [
                               {
                                   text : '确认',
                                   iconCls: "icon-save",
                                   handler : function() {
                                       Save2();
//                                   Query();
//                                       Query();
//                                       $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                   }
                               },
                               {
                                   text: "取消",
                                   iconCls: "icon-cancel",
                                   handler:function(){
                                       TyreEdit();
                                       var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                                       $('#treepmb').tree('select', node.target);//设置选中该节点
                                       Query();
                                       ZMACH= '';
                                       ZMACH2='';
                                       ZMACH3 = '';
                                       TireSpect = '';
                                       Tyresize = '';
                                       Wheelsize = '';
//                                       $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                   }
                               }
                           ]
                       });
                   }
               }else {
                   $.messager.alert("温馨提示","不能跨工厂操作!");
               }


           }



   }

     var tID = '';
    function deletedata() {
        var WERKS = $('#BWERKS').combobox('getText');
        var WERKS1 = localStorage.getItem("Department");
        if(WERKS==WERKS1 ||WERKS1 =='信息中心'){
            var row = $("#pm").datagrid("getSelected");
            var selRow = $('#pm').datagrid('getSelections');
            if(selRow.length <0 ||row==null){
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else{
                $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                    if (r) {
                        //批量行数据id
                        for (var b = 0; b< selRow.length;b++) {
                            if (tID =="") {
                                tID = selRow[b].id;
                            } else {
                                tID = selRow[b].id + "," + tID;
                            }
                        }
                        $.ajax({
                            type:"post",
                            url: "${pageContext.request.contextPath}/Tractor/Delete.action",//要发送的后台地址
                            data:{
                                id:tID,
                                i:i,
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data1) {//ajax请求成功后触发的方法
                                console.log(data1);
                                if (data1.num !=-1) {
                                    $.messager.alert('温馨提示', '删除成功');
                                    Query();
                                    tID = '';
                                    getplant();
                                }else {
                                    $.messager.alert('温馨提示', '删除失败');
                                }

                            },
                        })
                    }
                })
            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂操作!");
        }

    }
    var idm = '';
    var ZMACH= '';
    var Type= '';
    var Model= '';
    var Wheelbase= '';
    var Outsize= '';
    var DemarcatedForce= '';
    var MinUse= '';
    var ExecStd= '';
    var ZMACH2 = '';
    var ZCHYJ = '';
    var Power = '';
    var Tyresize = '';
    var Wheelsize = '';
    var TireSpect = '';
    var ZMACH3 ='';
    function updatedata() {
        var WERKS = $('#BWERKS').combobox('getText');
        var WERKS1 = localStorage.getItem("Department");
        if(WERKS==WERKS1 ||WERKS1 =='信息中心'){
            var row = $("#pm").datagrid("getSelected");
            var selRow = $('#pm').datagrid('getSelections');
            if(selRow.length==0){
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else{
                if(selRow.length<2){
                    idm = row.id;
                    ZMACH = row.zmach;
                    ids = row.id;
                    Type = row.type;
                    Model = row.model;
                    Wheelbase = row.wheelbase;
                    Outsize = row.outsize;
                    DemarcatedForce = row.demarcatedforce;
                    MinUse = row.minuse;
                    ExecStd = row.execstd;
                    ZMACH2 =  row.zmach;
                    ZCHYJ = row.zchyj;
                    Power = row.power;
                    Tyresize = row.tyresize;
                    Wheelsize = row.wheelsize;
                    TireSpect = row.tirespect;
                    ZMACH3 = row.zmach;
                    if(i=="车型合格证主数据"){
                        parent.$.modalDialog({
                            width : '25%',
                            height : '75%',
                            href : '${ctxPath }/DateEdit',
                            buttons : [
                                {
                                    text : '确认',
                                    iconCls: "icon-save",
                                    handler : function() {
                                        Savedate();
                                        Query();
                                        $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                    }
                                },
                                {
                                    text: "取消",
                                    iconCls: "icon-cancel",
                                    handler:function(){
                                        DateEditCancel();
                                        Query();
                                        $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                        var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                                        $('#treepmb').tree('select', node.target);//设置选中该节点
                                        ZMACH= '';
                                        ZMACH2='';
                                        ZMACH3 = '';
                                        ZCHYJ = '';
                                        Power = '';
                                    }
                                }
                            ]
                        });
                    }
                    if(i=="车型发动机"){
                        parent.$.modalDialog({
                            width : '25%',
                            height : '40%',
                            href : '${ctxPath }/EngineEdit',
                            buttons : [
                                {
                                    text : '确认',
                                    iconCls: "icon-save",
                                    handler : function() {
                                        Save1();
                                        Query();
                                        $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                    }
                                },
                                {
                                    text: "取消",
                                    iconCls: "icon-cancel",
                                    handler:function(){
                                        EngineEdit();
                                        Query();
                                        $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                        var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                                        $('#treepmb').tree('select', node.target);//设置选中该节点
                                        ZMACH= '';
                                        ZMACH2='';
                                        ZMACH23 = '';
                                    }
                                }
                            ]
                        });
                    }
                    if(i=="车型轮胎"){
                        parent.$.modalDialog({
                            width : '25%',
                            height : '50%',
                            href : '${ctxPath }/TyreEdit',
                            buttons : [
                                {
                                    text : '确认',
                                    iconCls: "icon-save",
                                    handler : function() {
                                        Save2();
                                        Query();
                                        $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                    }
                                },
                                {
                                    text: "取消",
                                    iconCls: "icon-cancel",
                                    handler:function(){
                                        TyreEdit();
                                        Query();
                                        $('#BWERKS').textbox('setValue',localStorage.getItem("Department"));
                                        var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                                        $('#treepmb').tree('select', node.target);//设置选中该节点
                                        ZMACH= '';
                                        ZMACH2='';
                                        ZMACH3 = '';
                                        TireSpect = '';
                                        Tyresize = '';
                                        Wheelsize = '';
                                    }
                                }
                            ]
                        });
                    }
                }else {
                    $.messager.alert('信息提示', '请选择一条数据！');
                }


            }
        }else {
            $.messager.alert("温馨提示","不能跨工厂操作!");
        }

    }

    function importdata() {
        var WERKS = $('#BWERKS').combobox('getText');
        var WERKS1 = localStorage.getItem("Department");
        if(WERKS==WERKS1 ||WERKS1 =='信息中心'){
            if(i==""){
                $.messager.alert("温馨提示","选择导入目录!");
            }else {
                var myDate = new Date();
                var uyear = myDate.getFullYear();
                var umouth  = myDate.getMonth()+1;
                var uday = myDate.getDate();
                var uhour = myDate.getHours();
                var umin = myDate.getMinutes();
                var ums = myDate.getSeconds();
                var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
                var plant = localStorage.getItem("Department");
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
                            "User": name,
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
                                                "User": localStorage.getItem("User"),
                                                time:time,
                                                plant:plant,
                                                i:i,
                                            },
                                            width: 300,
                                            buttons: {'ok': '确定', 'no': '取消'},
                                            icon: Ext.MessageBox.WARNING,
                                            closable: false,
                                            fn: function (e) {
                                                if (e == 'ok') {
                                                    if (upload.form.isValid()) {
                                                        upload.getForm().submit({

                                                            url: '${pageContext.request.contextPath}/Tractor/import.action',
                                                            method: 'POST',
                                                            params: {
                                                                "User": name,
                                                                "time":time,
                                                                "plant":plant,
                                                                i:i,
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
                                                                            Query();
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
        }else {
            $.messager.alert("温馨提示","不能跨工厂操作!");
        }

    }
</script>

