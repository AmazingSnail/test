<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-05-17
  Time: 12:47 内销库存报表
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


    .DA{
        width:70%;
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
    .DC{
        width:44%;
        height:75%;
    }
    .di3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .di2{
        letter-spacing:0.8em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.8em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="内销库存报表" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
                <shiro:hasPermission name="/DomesticInventoryReport/export">
                    <td><a href="#" class="easyui-linkbutton" plain="true" onclick="di_export()" data-options="iconCls:'icon-table-go'">导出</a></td>
                </shiro:hasPermission>
                <shiro:hasPermission name="/DomesticInventoryReport/export">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print"   plain="true">打印</a>
                </shiro:hasPermission>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label>物料编码：</label><input id="MATNR" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>物料描述：</label><input id="MAKTX" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <shiro:hasPermission name="/DomesticInventoryReport/query">
                        <td><a href="#" class="easyui-linkbutton"  onclick="di_query()" data-options="iconCls:'icon-search'">查询</a></td>
                        </shiro:hasPermission>

                        <shiro:hasPermission name="/DomesticInventoryReport/query">
                            <td><a href="#" class="easyui-linkbutton"  onclick="trt_showMore()" data-options="iconCls:'icon-search'">更多</a></td>
                        </shiro:hasPermission>
                    </tr>
                </table>
                <div class = "divmore" style="position: absolute;z-index:1001;background-color: white" id="trt_More">
                    <div style="margin-top: 5px">
                            <label>节数：</label><input id="f3" class="easyui-textbox" style="width:80px">
                            <label>标记描述：</label><input id="zbjnrx" class="easyui-textbox" style="width:80px">
                            <label>部件特征：</label><select class="easyui-combobox" name="Plant" datatype="text" id="f2" panelHeight="auto" data-options="
                            valueField:'f2',
                            textField:'f2',
                            panelHeight:'250'"
                                                        style="width:80px">
                    </select>
                        <label><span class="di2">部件特征二：</span></label><select class="easyui-combobox" name="Plant" datatype="text" id="f11" panelHeight="auto" data-options="
                            valueField:'f11',
                            textField:'f11',
                            panelHeight:'250'"
                                                                              style="width:120px">
                    </select>
                    </div>
                        <div style="margin-top: 5px">
                            <label>套筒：</label><select class="easyui-combobox" name="Plant" datatype="text" id="f4" panelHeight="auto" data-options="
                            valueField:'f4',
                            textField:'f4',
                            panelHeight:'250'"
                                                                          style="width:80px">
                        </select>
                            <label>表面处理：</label><select class="easyui-combobox" name="Plant" datatype="text" id="f5" panelHeight="auto" data-options="
                            valueField:'f5',
                            textField:'f5',
                            panelHeight:'250'"
                                                       style="width:80px">
                        </select>
                            <label>铆头方式：</label><select class="easyui-combobox" name="Plant" datatype="text" id="f10" panelHeight="auto" data-options="
                            valueField:'f10',
                            textField:'f10',
                            panelHeight:'250'"
                                                        style="width:80px">
                        </select>
                            <label><span class="di3">连接装配方式：</span></label><select class="easyui-combobox" name="Plant" datatype="text" id="f9" panelHeight="auto" data-options="
                            valueField:'f9',
                            textField:'f9',
                            panelHeight:'250'"
                                                                                   style="width:120px">
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <%--<div class="A" data-options="region:'west'border:false" >--%>

            <%--</div>--%>
            <%--<div class="C"  data-options="region:'east',split:true,border:true,collapsible:true" >--%>


            <%--</div>--%>
            <div class="DA" data-options="region:'west',split:true,border:true" >
                <table id="di" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
            </div>
            <div class="DC"   data-options="region:'center'" style="width:70%">
                <table class="easyui-datagrid" id="diid" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>
            </div>


        </div>
    </div>
</div>


<script type="text/javascript">
    $("#trt_More").hide();
    $(function () {
    });
    function trt_showMore() {
        $("#trt_More").toggle();
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/query.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f2').combobox('loadData', data);
                //alert(11111);

            }
        });

        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/queryf4.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f4').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/queryf5.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f5').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/queryf6.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f6').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/queryf9.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f9').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/queryf11.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f11').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Inventory/queryf10.action',
            dataType: "json",
            data: {
//                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#f10').combobox('loadData', data);
                //alert(11111);

            }
        });
    }

    function di_query() {
        $("#trt_More").hide();
        $('#diid').datagrid('loadData',{total:0,rows:[]});
        var matnr  = $('#MATNR').val();//物料编码
        var maktx = $('#MAKTX').val();//物料描述
        var zbjnrx = $('#zbjnrx').val();
        var f2 = $('#f2').combobox('getText');
        var f3 = $('#f3').val();
        var f4 = $('#f4').combobox('getText');
        var f5 = $('#f5').combobox('getText');
        var f9 = $('#f9').combobox('getText');
        var f10 = $('#f10').combobox('getText');
        var f11 = $('#f11').combobox('getText');
        var fdata;
        var s = $.trim(matnr);
        var s1 = $.trim(maktx);
        if(s.length==10||s.length==0){
            $.messager.progress({
                title:'请稍后',
                msg:'页面加载中...'
            });
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${pageContext.request.contextPath}/Inventory/Judge.action",//要发送的后台地址
                data: {
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                error:function(data) {
                    $.messager.progress('close');
                    $("#showMsg").html(data);  //登录错误提示信息
                },
                success: function (data) {//ajax请求成功后触发的方法
                   if(data.num>0){
                       $.ajax({
                           type: "post",//数据发送的方式（post 或者 get）
                           url: "${pageContext.request.contextPath}/Inventory/serach.action",//要发送的后台地址
                           data: {
                               matnr:s,
                               maktx:s1,
                               zbjnrx:zbjnrx,
                               f2:f2,
                               f3:f3,
                               f4:f4,
                               f5:f5,
                               f10:f10,
                               f9:f9,
                               f11:f11,
                           },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                           dataType: "json",//后台处理后返回的数据格式
                           success: function (data) {//ajax请求成功后触发的方法
                               if(data.total>0){
                                   $.messager.progress('close');
                                   console.log(data);
                                   fdata = data;

                                   $("#di").datagrid({
                                       idField:'id',
                                       loadFilter:pagerFilter,
                                       rownumbers:true,
                                       singleSelect:true,
                                       pageList:[100,200,500],//分页列表
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
                                       frozenColumns:[[
                                           {field:'matnr',title:'物料编码',width: '90px',align:'left',halign:'center'},
                                           {field:'maktx',title:'物料描述',width: '220px',align:'left',halign:'center'},

                                           ]],
                                       columns:[[
                                           {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                                           {field:'zbjnrx',title:'标记描述',width: '150px',align:'left',halign:'center'},
                                           {field:'f3',title:'节数',width: '100px',align:'center',halign:'center'},
                                           {field:'basme',title:'基本单位',width: '60px',align:'center',halign:'center'},
                                           {field:'mbwbest',title:'现库存结存',width: '100px',align:'right',halign: 'center',
                                               styler: function cellStyler(value,row,index){
                                                   if (value >0){
                                                       return 'color:blue;';
                                                   }
                                               }
                                           },
                                           {field:'f1',title:'节点工序',width: '100px',align:'center',halign:'center'},
                                           {field:'f2',title:'部件特征',width: '100px',align:'center',halign:'center'},
                                           {field:'f4',title:'套筒',width: '100px',align:'center',halign:'center'},
                                           {field:'f5',title:'表面处理',width: '100px',align:'center',halign:'center'},
//                                           {field:'f6',title:'打印方式',width: '100px',align:'center',halign:'center'},
//                                           {field:'f7',title:'LOGO标示程序号',width: '120px',align:'center',halign:'center'},
//                                           {field:'f8',title:'打印比例',width: '100px',align:'center',halign:'center'},
                                           {field:'f9',title:'连接装配方式',width: '230px',align:'center',halign:'center'},
                                           {field:'f10',title:'铆头方式',width: '100px',align:'center',halign:'center'},
                                           {field:'f11',title:'部件特征二',width: '100px',align:'center',halign:'center'},
                                           {field:'f12',title:'指定供应商',width: '100px',align:'center',halign:'center'},
                                       ]],
                                   });
                               }else {
                                   $.messager.progress('close');
                                   $.messager.alert('信息提示', '物料信息不存在!!!');
                               }


                           },
                           error: function (msg) {//ajax请求失败后触发的方法
                               alert(msg);//弹出错误信息
                           }

                       });

                       $('#di').datagrid('loadData',{total:0,rows:[]});
                   }else {
                       $.messager.progress('close');
                       $.messager.alert('信息提示', '正在数据更新，请三分钟后查询！');
                   }
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    alert(msg);//弹出错误信息
                }

            });

        }else {
            $.messager.alert('信息提示', '物料编码有误!!!');
        }


//        $('#Mmid').datagrid('loadData',{total:0,rows:[]});

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
    //   function  jilian() {
    $("#di").datagrid({
        //双击事件
        onClickRow : function (index, row) {  //easyui封装好的事件（被单机行的索引，被单击行的值）
            var matnr = row.matnr;

            $.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${pageContext.request.contextPath}/Inventory/onclick.action",
                dataType:"json",
                data: {
                    matnr:matnr
                },
                success:function(data) {
                    fdata = data;
                    $('#diid').datagrid({
                        data: fdata,
                        loadFilter:pagerFilter,
                        rownumbers:true,
                        singleSelect:true,
                        fit: false, //自动适屏功能
                        nowrap:false,
                        width:'auto',
                        pageList:[25,50,100],//分页列表
                        pagination:true,
                        multiSort:true,
                        remoteSort:false,
                        showFooter: true,
                        method:'get',
                        data:fdata,
                        frozenColumns:[[
                            {field:'matnr',title:'物料编码',width: '90px',align:'left',halign:'center'},
                            {field:'maktx',title:'物料描述',width: '220px',align:'left',halign:'center'},
                        ]],
                        columns: [[
                            {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},

                            {field:'mbwbest',title:'现库存结存',width: '100px',align:'right',halign: 'center'},
                            {field:'werks',title:'工厂 ',width: '100px',align:'center',halign: 'center'},
                            {field:'lgort',title:'库存地点',width: '100px',align:'center',halign: 'center'},
                        ]],
                    })
                    $('#diid').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                },

            })

            $('#diid').datagrid('loadData',{total:0,rows:[]});

        }
    });

    //   }

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
    function di_export() {
        var matnr  = $('#MATNR').val();//物料编码
        var maktx = $('#MAKTX').val();//物料描述
        var url = "../${pageContext.request.contextPath}/Inventory/Export?matnr="+matnr+"&maktx="+maktx+"";
        window.location.href = url;
    }
</script>












