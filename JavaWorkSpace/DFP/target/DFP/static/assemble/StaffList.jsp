<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .w2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2em; /*同上*/
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
</style>
<div class="easyui-layout" data-options="fit:true"  style="width: 100%">
    <div  data-options="region:'center' ,border:false" >
        <!-- Begin of toolbar -->
        <div class="easyui-panel" title="操作栏" >
            <div id="SatffList-toolbar">
                <div class="wu-toolbar-search">
                    <form id="SatffListForm" method="post">
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="SatffListPlant" panelHeight="auto" data-options="
                url:'/StaffListController/Plantquery',
				method:'get',
				valueField:'remark',
				textField:'Fname',
				panelHeight:'auto'"
                                style="width:100px">
                        </select>&nbsp
<shiro:hasPermission name="/StaffListController/StaffListInerst">
                        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="New()" data-options="iconCls:'icon-add'">新增数据</a>
</shiro:hasPermission>
<shiro:hasPermission name="/StaffListController/StaffListDel">
                        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="Delete()" data-options="iconCls:'icon-delete'">删除</a>
</shiro:hasPermission>
                    </form>
                </div>
            </div>
        </div>
        <table title="人员名单" id="SatffListdatagrid"  class="easyui-datagrid"  data-options="onClickRow: SLdgappend,editor:'text',singleSelect:true" style="height: 89%;width: 99%"></table>
        <div id="SatffListadd" class="easyui-dialog" title="新增" data-options="iconCls:'icon-save',closed:true," style="width:285px;height:250px;padding:10px">
            <table>
                <tr align="center">
                    <td align="center"><span class="w3">事业部</span>:</td>
                    <td align="center"><input class="easyui-textbox" data-options="required:false" type="text" id="SLPlant" ></input></td></tr>
                <tr align="center">
                <tr align="center">
                    <td  align="center"><span class="w2">班长</span>:</td>
                    <td align="center"><input class="easyui-textbox" data-options="required:false" type="text" id="SLworklead" ></input></td></tr>
                <tr align="center">
                    <td align="center"><span class="w3">串装工</span>:</td>
                    <td align="center"><input class="easyui-textbox" data-options="required:false" type="text" id="SLworker" ></input></td>
                </tr>
                <tr align="center">
                    <td align="center"><span class="w2">班组</span>:</td>
                    <td align="center"><input class="easyui-textbox" data-options="required:false" type="text" id="SLworkdepart" ></input></td>
                </tr>
                <tr align="center">
                    <td align="center">车间类型:</td>
                    <td align="center"><input class="easyui-textbox" data-options="required:false"type="text" id="SLworkgroup" ></input></td>
                </tr>
                <tr align="center">
                    <td align="center"><span class="w2">卡号</span>:</td>
                    <td align="center"><input class="easyui-textbox" data-options="required:false" type="number" id="SLIC" ></input></td>
                </tr><tr></tr>
                <tr align="center">
<shiro:hasPermission name="/StaffListController/StaffListInerst">
                    <td align="left"><button class="easyui-linkbutton" iconCls="icon-save" onclick="StaffListAdd()" style="width: 90px;text-align:center" id="SLsave">保存</button></td>
</shiro:hasPermission>
                    <td align="right"><button class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#SatffListadd').dialog('close')" style="width: 90px" >取消</button></td>
                </tr>
            </table>
        </div>
    </div>
    <div title="详细信息" class="easyui-panel" data-options="region:'south',split:false" style="height:24%;">
        <table id="SatffListdg1"  data-options="editor:'text',singleSelect:true" >
            <tr>
                <td>序号:</td>
                <td><input class="easyui-textbox" readonly="readonly" data-options="required:true" type="text" id="id" ></input></td>
                <td>班长:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="worklead" ></input></td>
                <td>串装工:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="worker" ></input></td></tr>
            <tr>
                <td>班组:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="workdepart" ></input></td>
                <!--<td>事业部:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="plant" ></input></td>-->
                <td>车间类型:</td>
                <td><input class="easyui-textbox" data-options="required:true"type="text" id="workgroup" ></input></td>
                <td>串装工卡号:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="IC" ></input></td>
            </tr>
            <tr>
<shiro:hasPermission name="/StaffListController/StaffListupdata">
                <td><button class="easyui-linkbutton" iconCls="icon-save" onclick="StaffListSave()" style="width: 90px" id="save">保存</button></td>
</shiro:hasPermission>
            </tr>
        </table>
    </div>
</div>
</div>
<script type="text/javascript">
    $(function () {
        $("#SatffListPlant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                $("#id").textbox('setValue','');
                $("#worklead").textbox('setValue','');
                $("#worker").textbox('setValue','');
                $("#workdepart").textbox('setValue','');
                $("#workgroup").textbox('setValue','');
                $("#IC").textbox('setValue','');
                var plant = $(this).combobox('getText');
//            alert(plant);
                if(plant!==null){
//                $('#SatffListdatagrid').datagrid('clear');
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "/StaffListController/StaffListquery.action",
                        dataType: "json",
                        data: {
                            plant: plant,
                        },
                        error: function (request) {      // 设置表单提交出错
                            $.messager.alert(request);  //登录错误提示信息
                        },
                        success: function (data) {
                            $('#SatffListdatagrid').datagrid({
                                data:data,
                                fit: false, //自动适屏功能
                                autoRowWidth: true,
                                loadMsg: '正在加载中，请稍等... ',
                                fitColumns:true,//宽度自适应
                                singleSelect:true,
                                width:'auto',
                                method:'get',
                                columns:[[
                                    {field:'id',title:'序号',width:'13%',editor:'text',sortable:true},
                                    {field:'Worker',title:'串装工',width:'13%',editor:'text'},
                                    {field:'Worklead',title:'班长',width:'13%',editor:'text'},
                                    {field:'Groupstate',title:'状态',width:'13%',editor:'text'},
                                    {field:'IC',title:'卡号',width:'13%',editor:'text'},
                                    {field:'Workdepart',title:'班组',width:'13%',editor:'text'},
                                    {field:'Workgroup',title:'工作组',width:'13%',editor:'text'},
                                ]]
                            });
                        }
                    });
                }
            }
        })
    });

    var editindex ="";
    function SLdgappend(index) {
//         $('#MonPlandg1').datagrid('loadData', { total: 0, rows: [] });
        var row  = $('#SatffListdatagrid').datagrid("getSelected");

        $("#id").textbox("setValue",row.id);
        $("#worklead").textbox("setValue",row.Worklead);
        $("#worker").textbox("setValue",row.Worker);
        $("#workdepart").textbox("setValue",row.Workdepart);
        $("#IC").textbox("setValue",row.IC);
        $("#workgroup").textbox("setValue",row.Workgroup);
        editindex=index;
    }
    function Delete() {
        var row  = $('#SatffListdatagrid').datagrid("getSelected");
        $.messager.confirm('提示', '是否删除该条记录？', function(r){
            if (r){
                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url: "/StaffListController/StaffListDel.action",
                    dataType: "json",
                    data: {
                        id: row.id
                    },
                    error: function (request) {      // 设置表单提交出错
                        $.messager.alert(request);  //登录错误提示信息
                    },
                    success: function (data) {
                        if(data.Return ==="OK"){
                            $.messager.alert('提示','删除成功！','info');
                            $('#SatffListdatagrid').datagrid("deleteRow",editindex)
                            $("#id").textbox('setValue','');
                            $("#worklead").textbox('setValue','');
                            $("#worker").textbox('setValue','');
                            $("#workdepart").textbox('setValue','');
                            $("#workgroup").textbox('setValue','');
                            $("#IC").textbox('setValue','');
                        }else{
                            $.messager.alert('提示','删除失败！','info');
                        }
                    }
                });
            }
        });
    }
    function StaffListQuery() {
        var plant = $("#SatffListPlant").combobox('getText');
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "/StaffListController/StaffListquery.action",
            dataType: "json",
            data: {
                plant: plant,
            },
            error: function (request) {      // 设置表单提交出错
                $.messager.alert(request);  //登录错误提示信息
            },
            success: function (data) {
                $('#SatffListdatagrid').datagrid({
                    data:data,
                    fit: false, //自动适屏功能
                    autoRowWidth: true,
                    loadMsg: '正在加载中，请稍等... ',
                    fitColumns:true,//宽度自适应
                    singleSelect:true,
                    width:'auto',
                    method:'get',
                    columns:[[
                        {field:'id',title:'序号',width:'13%',editor:'text',sortable:true},
                        {field:'Worker',title:'串装工',width:'13%',editor:'text'},
                        {field:'Worklead',title:'班长',width:'13%',editor:'text'},
                        {field:'Groupstate',title:'状态',width:'13%',editor:'text'},
                        {field:'IC',title:'卡号',width:'13%',editor:'text'},
                        {field:'Workdepart',title:'班组',width:'13%',editor:'text'},
                        {field:'Workgroup',title:'工作组',width:'13%',editor:'text'},
                    ]]
                });
            }
        });
    }
    function StaffListSave() {
        var row  = $('#SatffListdatagrid').datagrid("getSelected");
        var plant = $("#SatffListPlant").combobox('getText');
        if($("#id").val() ===""||$("#id").val() ===null){
            $.messager.alert('提示','id为空不可修改！','info');
        }else{
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: "/StaffListController/StaffListupdata.action",
                dataType: "json",
                data: {
                    plant: plant,
                    id:$("#id").val(),
                    worklead:$("#worklead").val(),
                    worker:$("#worker").val(),
                    workdepart:$("#workdepart").val(),
                    workgroup:$("#workgroup").val(),
                    IC:$("#IC").val()
                },
                error: function (request) {      // 设置表单提交出错
                    $.messager.alert(request);  //登录错误提示信息
                },
                success: function (data) {
                    if(data.Return ==="OK"){
                        row.Worker = $("#worker").val();
                        row.Worklead=$("#worklead").val();
                        row.Workdepart = $("#workdepart").val();
                        row.Workgroup = $("#workgroup").val();
                        row.IC=$("#IC").val();
                        $('#SatffListdatagrid').datagrid('refreshRow', editindex);
                        $.messager.alert('提示','更改成功！','info');
                        $("#id").textbox('setValue','');
                        $("#worklead").textbox('setValue','');
                        $("#worker").textbox('setValue','');
                        $("#workdepart").textbox('setValue','');
                        $("#workgroup").textbox('setValue','');
                        $("#IC").textbox('setValue','');
                    }else {
                        $.messager.alert('提示','更改失败！','info');
                    }
                }
            });
        }
    }
    function New() {
        $('#SatffListadd').dialog('open');
        $('#SLPlant').textbox("setValue", $("#SatffListPlant").combobox('getText'));
    }
    function StaffListAdd() {
//        alert($('#SLPlant').val());
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "/StaffListController/StaffListInerst.action",
            dataType: "json",
            data: {
                plant: $('#SLPlant').val(),
//                id:$("#id").val(),
                worklead:$("#SLworklead").val(),
                worker:$("#SLworker").val(),
                workdepart:$("#SLworkdepart").val(),
                workgroup:$("#SLworkgroup").val(),
                IC:$("#SLIC").val()
            },
            error: function (request) {      // 设置表单提交出错
                $.messager.alert(request);  //登录错误提示信息
            },
            success: function (data) {
                if(data.Return ==="OK"){
                    $('#SatffListdatagrid').datagrid('appendRow',{
                        Worker:$("#SLworker").val(),
                        Worklead:$("#SLworklead").val(),
                        Workdepart:$("#SLworkdepart").val(),
                        Workgroup:$("#SLworkgroup").val(),
                        IC:$("#SLIC").val(),
                    });
                    $.messager.alert('提示','添加成功！','info');
                    $('#SatffListadd').dialog('close');
                    StaffListQuery();
                }else {
                    $.messager.alert('提示','添加失败！','info');
                }
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
    /**
     * Name 载入数据
     */
    $('#SatffListdatagrid').datagrid({
        loadFilter:pagerFilter,
        rownumbers:true,
        singleSelect:false,
        pageSize:20,
        pagination:true,
        multiSort:true,
        //fitColumns:true,
        //fit:true,
    });
</script>