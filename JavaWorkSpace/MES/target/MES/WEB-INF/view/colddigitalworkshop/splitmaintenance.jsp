<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>

    .cz{
        width:100%;
        height:100%;
    }
    .B{
        width: 10%;
        height: 96%;
    }
    .w2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2em; /*同上*/
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .spm_haorooms{
        height: calc(100% - 60px);
    }
</style>

<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <div class="easyui-panel" title="拆分维护" data-options="fit:true">
            <div id="wu-toolbar" style="height: 60px">
                <div class="wu-toolbar-button">

                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="openAdd()" plain="true">打印</a>--%>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>--%>
                    <shiro:hasPermission name="/spm/parentAdd">
                        <a href="#" class="easyui-linkbutton"  onclick="spm_parentAdd()" data-options="iconCls:'icon-add'" plain="true">新增冷卷料</a>
                    </shiro:hasPermission>
                </div>
                <div class="wu-toolbar-search">
                    <span></span>
                    <div>
                        <label>冷卷物料代码：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="spm_MFno" panelHeight="auto" data-options="
                            valueField:'fno',
                            textField:'fno',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>冷卷尺寸规格描述：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="spm_FName" panelHeight="auto" data-options="
                            valueField:'fname',
                            textField:'fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <a href="#" class="easyui-linkbutton"  onclick="spm_getSplitData()" data-options="iconCls:'icon-search'">查询</a>
                    </div>
                </div>
            </div>
            <div class="easyui-layout spm_haorooms"  >
                <div class="cz" >

                    <%--<table id="equiplist_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 75%" title="设备清单" data-options="singleSelect:true,onClickRow:onClickRow"></table>--%>
                        <table id="spm_splitmsg"  class="easyui-treegrid" data-options="
                        <%--url:'/SplitMaintenance/selectSmaintebabce.action',--%>
            fitColumns: true,
            rownumbers: true,
            onContextMenu:spm_onContextMenu,
            idField: 'fnohiddon',
            treeField: 'fno',singleSelect:true,
            "  toolbar="#spm_tb" title="拆分维护"  style="height: 100%;width: 100%">
                            <thead>
                            <tr>
                                <th data-options="field:'id'" width="220">编号</th>
                                <th data-options="field:'fno'" width="150" >物料编码</th>
                                <th data-options="field:'name'" width="200">物料描述e</th>
                                <th data-options="field:'matec'" width="200">物料类型</th>
                                <th data-options="field:'fnoname'" width="200">名称</th>
                                <th data-options="field:'fparentid'" width="200">上级编号</th>
                            </tr>
                            </thead>

                        </table>
                        <div id="spm_tb">
                            <div>
                                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="spm_collapseAll()">全部收起</a>
                                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="spm_expandAll()">全部展开</a>
                            </div>
                        </div>
                        <div id="spm_mm" class="easyui-menu" style="width:120px;">
<shiro:hasPermission name="/spm/append">
                            <div onclick="spm_append()" data-options="iconCls:'icon-add'">添加下级</div>
</shiro:hasPermission>
<shiro:hasPermission name="/spm/removeit">
                            <div onclick="spm_removeit()" data-options="iconCls:'icon-remove'">删除</div>
</shiro:hasPermission>
                            <div class="menu-sep"></div>
<shiro:hasPermission name="/spm/update">
                            <div onclick="spm_update()">修改</div>
</shiro:hasPermission>
                        </div>
                        <div id="spm_listadd" class="easyui-dialog" title="添加下级物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                            <from id="spm_listaddfrom">
                                <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                    <td>
                                        <tr>
                                            <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="spm_fno"  style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>物料描述:<input class="easyui-textbox" type="text" name="name" id="spm_name" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>物料类型:<input class="easyui-textbox" type="text" name="matec" id="spm_matec" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td><span class="w2">名称</span>:<input class="easyui-textbox" type="text" name="Fnoname" id="spm_Fnoname" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>上级编码:<input class="easyui-textbox" type="text" name="fparentid" id="spm_fparentid" style="width:150px" disabled=true ></input></td>
                                        </tr>
                                        <tr >

                                            <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="spm_listAdd()" id="spm_listAddbutton" data-options="iconCls:'icon-save'" >保存</a></td>

                                        </tr>
                                    </td>
                                </table>
                            </from>
                        </div>
                        <div id="spm_parentAdd" class="easyui-dialog" title="添加毛料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                            <from id="spm_parentaddfrom">
                                <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                    <td>
                                        <tr>
                                            <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="spm_parentfno"  style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>物料描述:<input class="easyui-textbox" type="text" name="name" id="spm_parentname" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr >
                                            <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="spm_parentlistAdd()" id="spm_parentAddbutton" data-options="iconCls:'icon-save'" >保存</a></td>
                                        </tr>
                                    </td>
                                </table>
                            </from>
                        </div>
                        <div id="spm_listupdate" class="easyui-dialog" title="修改下级物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                            <from id="spm_listupdatefrom">
                                <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                    <td>
                                        <tr>
                                            <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="spm_updatefno"  style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>物料描述:<input class="easyui-textbox" type="text" name="name" id="spm_updatename" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>物料类型:<input class="easyui-textbox" type="text" name="matec" id="spm_updatematec" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td><span class="w2">名称</span>:<input class="easyui-textbox" type="text" name="Fnoname" id="spm_updateFnoname" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>上级编码:<input class="easyui-textbox" type="text" name="fparentid" id="spm_updatefparentid" style="width:150px" disabled=true ></input></td>
                                        </tr>
                                        <input class="easyui-textbox" type="hidden" name="id" id="spm_updateid"  />
                                        <tr >

                                            <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="spm_listUpdate()" id="spm_listupdatebutton" data-options="iconCls:'icon-save'" >修改</a></td>

                                        </tr>
                                    </td>
                                </table>
                            </from>
                        </div>
                        <div id="spm_parentUpdate" class="easyui-dialog" title="修改毛料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                            <from id="spm_parentUpdatefrom">
                                <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                    <td>
                                        <tr>
                                            <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="spm_parentUpdatefno"  style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <tr>
                                            <td>物料描述:<input class="easyui-textbox" type="text" name="name" id="spm_parentUpdatename" style="width:150px" data-options="required:'true'"></input></td>
                                        </tr>
                                        <input class="easyui-textbox" type="hidden" name="id" id="spm_parentupdateid"  />
                                        <tr >

                                            <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="spm_parentlistUpdate()" id="spm_parentUpdatebutton" data-options="iconCls:'icon-save'" >修改</a></td>
                                        </tr>
                                    </td>
                                </table>
                            </from>
                        </div>
                </div>


            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/SplitMaintenance/selectSplitMaoLiao.action",//要发送的后台地址
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $("#spm_MFno").combobox("loadData",data);
                $("#spm_FName").combobox("loadData",data);
            }
        })
    });

    function spm_append(){
        var row = $("#spm_splitmsg").treegrid("getSelected");
        var fno= row.fno;
        $('#spm_listaddfrom').form("clear");
        $('#spm_listaddfrom').form('load',{
            fparentid:fno,
        });
        $('#spm_listadd').dialog('open');
    }
    function spm_removeit(){
        var row = $("#spm_splitmsg").treegrid("getSelected");
        if(row.fparentid!==null){
            $.messager.confirm('温馨提示', '确定要删除'+row.fno+'物料吗？', function (r) {
                if (r) {
                    jQuery.ajax({
                        type: "post",//数据发送的方式（post 或者 get）
                        url: "${ctxPath }/SplitMaintenance/deleteChild.action",//要发送的后台地址
                        data: {
                            id : row.id
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            if (data.num > 0) {
                                $.messager.alert('温馨提示', '删除成功!');

                                spm_getSplitData();
                            }
                        }
                    })
                }
            })
        }else{
            $.messager.confirm('温馨提示', '删除毛料将会删除掉毛料下的所有物料,请慎重考虑!', function (r) {
                if (r) {
                    jQuery.ajax({
                        type: "post",//数据发送的方式（post 或者 get）
                        url: "${ctxPath }/SplitMaintenance/deleteParent.action",//要发送的后台地址
                        data: {
                            id : row.id
                        },
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            if (data.num > 0) {
                                $.messager.alert('温馨提示', '删除成功!');

                                spm_getSplitData();
                            }
                        }
                    })
                }
            })
        }
    }
    function spm_parentAdd(){
        $("#spm_parentAdd").dialog('open');
    }
    function spm_update(){
        var row = $("#spm_splitmsg").treegrid("getSelected");
        if(row.fparentid!==null){
            $('#spm_listupdatefrom').form("clear");
            $('#spm_listupdatefrom').form('load',{
                id:row.id,
                fno:row.fno,
                name:row.name,
                matec:row.matec,
                Fnoname:row.Fnoname,
                fparentid:row.fparentid,
            });
            $('#spm_listupdate').dialog('open');
        }else{
            $('#spm_parentUpdatefrom').form("clear");
            $('#spm_parentUpdatefrom').form('load',{
                id:row.id,
                fno:row.fno,
                name:row.name
            });
            $('#spm_parentUpdate').dialog('open');
        }
    }
    function spm_listUpdate(){
        var id = $("#spm_updateid").val();
        var fno =  $("#spm_updatefno").val();
        var name =  $("#spm_updatename").val();
        var matec =  $("#spm_updatematec").val();
        var fnoname =  $("#spm_updateFnoname").val();
        var fparentid =  $("#spm_updatefparentid").val();
        $.ajax({
            type: "post",
            data: {
                id:id,
                fno: fno,
                name: name,
                matec: matec,
                fnoname: fnoname,
                fparentid: fparentid
            },
            url: "${ctxPath }/SplitMaintenance/update.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '修改成功!');

                    spm_getSplitData();

                    $('#spm_listupdate').dialog('close');
                }
            }
        })
    }
    function spm_parentlistUpdate(){
        var id = $("#spm_parentupdateid").val();
        var fno =  $("#spm_parentUpdatefno").val();
        var name =  $("#spm_parentUpdatename").val();
        $.ajax({
            type: "post",
            data: {
                id:id,
                fno: fno,
                name: name
            },
            url: "${ctxPath }/SplitMaintenance/update.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '修改成功!');

                    spm_getSplitData();

                    $('#spm_parentUpdate').dialog('close');
                }
            }
        })
    }
    function spm_parentlistAdd(){
        var fno =  $("#spm_parentfno").val();
        var name =  $("#spm_parentname").val();
        $.ajax({
            type: "post",
            data: {
                fno: fno,
                name: name,
                matec: "",
                fnoname: "",
            },
            url: "${ctxPath }/SplitMaintenance/insertParent.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '新增成功!');

                    spm_getSplitData();

                    $('#spm_listadd').dialog('close');
                }else{
                    $.messager.alert('温馨提示', '新增失败，已存在或数据异常！！！!');
                }
            }
        })
    }
    function spm_collapseAll(){
        $('#spm_splitmsg').treegrid('collapseAll');
    }
    function spm_expandAll(){
        $('#spm_splitmsg').treegrid('expandAll');
    }

    function spm_getSplitData() {
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/SplitMaintenance/selectSmaintebabce.action",//要发送的后台地址
            data: {
                fno: $("#spm_MFno").combobox("getValue"),
                name:$("#spm_FName").combobox("getValue")
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $("#spm_splitmsg").treegrid({
//                    pagination: true,
//                    multiSort: true,
//                    showRefresh:false,
                    //fitColumns:true,
                    //fit:true,
                    data:data,
                    loadMsg: "正在加载数据.....",
                    pagerFilter:spm_pagerFilter,
//                    onDrop:spm_onDrop,
//                    onLoadSuccess:spm_onLoadSuccess,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns: [[
                        {field: 'id', title: '编号', width: 70},
                        {field: 'fno', title: '物料编码', width: 80},
                        {field: 'fnohiddon', title: '物料编码隐藏', hidden:'true',width: 80},
                        {field: 'name', title: '物料描述', width: 80},
                        {field: 'matec', title: '物料类型',  width: 100},
                        {field: 'fnoname', title: '名称', width: 100},
                        {field: 'fparentid', title: '上级编号', width: 100},
                    ]],
                    rowStyler:function(row){
                        var fparentid =row.fparentid;
                        if( fparentid === null ){
                            return 'background-color:#A4D3EE;font-weight:bold;';
                        }
                    },

                });

//                $('#spm_splitmsg').datagrid({loadFilter: spm_pagerFilter}).datagrid('loadData', data);
//
                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });
    }
    function spm_onContextMenu(e,row){
        e.preventDefault();
        $(this).treegrid('select', row.id);
        $('#spm_mm').menu('show',{
            left: e.pageX,
            top: e.pageY
        });
    }
    function spm_onLoadSuccess(row){
        $(this).treegrid('enableDnd', row?row.id:null);
    }
    function spm_onDrop(row,oldrow){
        alert(row.id+"============="+old.id);
    }
    var editIndex = undefined;
    function onClickRow(index){
        if (editIndex != index){
            var row = $("#equiplist_dgm").datagrid("getSelected");
            $('#equiplist_ff').form('load',{
                id:row.id,
                worklead:row.worklead,
                worker:row.worker,
                equipment:row.equipment,
                equipmentkind:row.equipmentkind,
                equipmentserial:row.equipmentserial,
                plant:row.plant,
            });

            editIndex = index;
        }
    }
    function spm_pagerFilter(data){
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
    function spm_listAdd() {
        //alert(111111);
        var fno =  $("#spm_fno").val();
        var name =  $("#spm_name").val();
        var matec =  $("#spm_matec").val();
        var fnoname =  $("#spm_Fnoname").val();
        var fparentid =  $("#spm_fparentid").val();
        $.ajax({
            type: "post",
            data: {
                fno: fno,
                name: name,
                matec: matec,
                fnoname: fnoname,
                fparentid: fparentid
            },
            url: "${ctxPath }/SplitMaintenance/insertChild.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '新增成功!');

                    spm_getSplitData();

                    $('#spm_listadd').dialog('close');
                }else{
                    $.messager.alert('温馨提示', '新增失败：已存在或数据有误！！！！!');
                }
            }
        })
    }
</script>