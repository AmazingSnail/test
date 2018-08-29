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
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <div class="easyui-panel" title="串装入库" data-options="fit:true">
            <div id="wu-toolbar" style="height: 10%">
                <div class="wu-toolbar-button">

                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="openAdd()" plain="true">打印</a>--%>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>--%>

                </div>
                <div class="wu-toolbar-search">
                    <span></span>
                    <div>
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="equiplist_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <shiro:hasPermission name="/Equipment/edit">
                        <a href="#" class="easyui-linkbutton"  onclick="opendiv()" data-options="iconCls:'icon-add'">新增基础数据</a>
                        <a href="#" class="easyui-linkbutton"  onclick="equiplistUpdate()" data-options="iconCls:'icon-delete'">删除</a>
                        </shiro:hasPermission>
                    </div>
                </div>
            </div>
            <div class="easyui-layout" data-options="fit:true" >
                <div class="cz" >

                    <table id="equiplist_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 65%" title="设备清单" data-options="singleSelect:true,onClickRow:onClickRow"></table>
                    <div id="equiplistadd" class="easyui-dialog" title="添加设备" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                        <from>
                            <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                <td>
                                    <tr>
                                        <td><span class="w2">班长</span>:<input class="easyui-textbox" type="text" name="worklead" id="equiplistFormWorklead"  style="width:150px"></input></td>
                                    </tr>
                                    <tr>
                                        <td>机装人员:<input class="easyui-textbox" type="text" name="worker" id="equiplistFormWorker" style="width:150px" ></input></td>
                                    </tr>
                                    <tr>
                                        <td>设备规格:<select class="easyui-combobox" name="equipment" datatype="text" id="equiplistFormEquipment" panelHeight="auto" data-options="
                                                valueField:'FLName',
                                                textField:'FLName',
                                                panelHeight:'150'"
                                                         style="width:150px"></select>&nbsp</td>
                                    </tr>
                                    <tr>
                                        <td>设备编号:<input class="easyui-textbox" type="text" name="equipmentserial" id="equiplistFormEquipmentserial" style="width:150px" disabled=true ></input></td>
                                    </tr>
                                    <tr>
                                        <td><span class="w2">类型</span>:<input class="easyui-textbox" type="text" name="equipmentkind" id="equiplistFormEquipmentkind" style="width:150px"  ></input></td>
                                    </tr>
                                    <tr>
                                        <td><span class="w3">事业部</span>:<input class="easyui-textbox" type="text" name="plant" id="equiplistFormPlant" disabled=true style="width:150px" ></input></td>
                                    </tr>
                                    <tr >

                                        <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="equiplistAdd()" id="equiplistFormSave" data-options="iconCls:'icon-save'" >保存</a></td>

                                    </tr>
                                </td>
                            </table>
                        </from>
                    </div>
                    <div style="overflow:auto;width:100%;height:25%" title="详细信息" class="easyui-panel"   >
                        <form id="equiplist_ff" method="post">
                            <table cellpadding="5" width="auto" style="white-space:nowrap">
                                <tr>
                                    <td>班长:</td>
                                    <td><input class="easyui-textbox" type="text" name="worklead" id="equiplistWorklead" data-options="required:true" ></input></td>
                                    <td>机装人员:</td>
                                    <td><input class="easyui-textbox" type="text" name="worker" id="equiplistWorker" data-options="required:true" ></input></td>

                                </tr>
                                <tr>
                                    <td>设备规格:</td>
                                    <td><input class="easyui-textbox" type="text" name="equipment" id="equiplistEquipment" data-options="required:true" disabled=true></input></td>

                                    <td>设备编号:</td>
                                    <td><input class="easyui-textbox" type="text" name="equipmentserial" id="equiplistEquipmentserial" data-options="required:true"disabled=true></input></td>

                                </tr>
                                <tr>
                                    <td>类型:</td>
                                    <td><input class="easyui-textbox" type="text" name="equipmentkind" id="equiplistEquipmentkind" data-options="required:true" ></input></td>
                                    <td>事业部:</td>
                                    <td><input class="easyui-textbox" type="text" name="plant" id="equiplistPlant" data-options="required:true" disabled=true ></input></td>

                                </tr>
<shiro:hasPermission name="/Equipment/edit">
                                <tr>
                                    <td><a href="#" class="easyui-linkbutton" name="save" onclick="equiplistSave()" id="equiplistSave" data-options="iconCls:'icon-save'"  >保存</a></td>
                                </tr>
</shiro:hasPermission>
                            </table>
                        </form>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $("#equiplist_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                equiplistgetData();
            }
        });
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
                $('#equiplist_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#equiplistFormEquipment").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                $.ajax({
                    type: "get",
                    url: "/Syb/getFlowLineFLID.action",
                    data: {
                        plant: $("#equiplist_Plant").combobox("getText"),
                        equipment:$('#equiplistFormEquipment').combobox("getText")
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        //alert(data.FLID);
                        $('#equiplistFormEquipmentserial').textbox('setValue',data.FLID);
                    }
                });
            }
        });

    });
    function opendiv() {
        var plant = $('#equiplist_Plant').combobox("getText");
        $('#equiplistFormPlant').textbox('setValue',plant);
        $.ajax({
            type: "get",
            url: "/Syb/getFlowLine.action",
            data: {
                plant: plant
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $('#equiplistFormEquipment').combobox('loadData', data);
            }
        });
        $('#equiplistadd').dialog('open');

    }
    function equiplistgetData() {
        var fdata;
        jQuery.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "/PlanPB/query.action",//要发送的后台地址
            data: {
                plant: $('#equiplist_Plant').combobox('getText'),
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                fdata = data;
                $("#equiplist_dgm").datagrid({
                    idField:'id',
                    rownumbers: true,
                    singleSelect: true,
                    pageSize: 20,
                    pagination: true,
                    multiSort: true,
                    showRefresh:false,
                    //fitColumns:true,
                    //fit:true,
                    method: 'get',
                    loadMsg: "正在加载数据.....",
                    data: fdata,
                    id: 'kcard',
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns: [[
                        {field: 'id', title: '编号', width: 70},
                        {field: 'worklead', title: '班长', width: 80},
                        {field: 'worker', title: '机装人员', width: 80},
                        {field: 'equipment', title: '设备规格',  width: 100},
                        {field: 'equipmentkind', title: '类型', width: 100},
                        {field: 'equipmentserial', title: '设备编号', width: 100},
                        {field: 'plant', title: '事业部',  width: 100},
                    ]],

                });
                $('#equiplist_dgm').datagrid({loadFilter: equiplist_pagerFilter}).datagrid('loadData', fdata);

                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });
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
    function equiplist_pagerFilter(data){
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
    function equiplistAdd() {
        //alert(111111);
        var Worklead = $("#equiplistFormWorklead").val();
        var Worker = $("#equiplistFormWorker").val();
        var Equipment = $("#equiplistFormEquipment").combobox("getText");
        var Equipmentserial = $("#equiplistFormEquipmentserial").val();
        var Equipmentkind = $("#equiplistFormEquipmentkind").val();
        var Plant = $("#equiplistFormPlant").val();
        $.ajax({
            type: "post",
            data: {
                zworklead: Worklead,
                zworker: Worker,
                zequipment: Equipment,
                zequipmentkind: Equipmentkind,
                zequipmentserial: Equipmentserial,
                zplant: Plant
            },
            url: "/PlanPB/insert.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '新增成功!');
//                    $('#equiplist_dgm').datagrid('appendRow',{
//                        worklead:Worklead,
//                        worker:Worker,
//                        equipment: Equipment,
//                        equipmentkind: Equipmentkind,
//                        equipmentserial: Equipmentserial,
//                        plant: Plant
//                    });
                    equiplistgetData();
                    $('#equiplist_ff').form("clear");
                    $('#equiplistadd').dialog('close');
                }
            }
        })
    }
    function equiplistSave() {
        var row = $('#equiplist_dgm').datagrid("getSelected");
        var worklead = $('#equiplistWorklead').val();
        var worker = $('#equiplistWorker').val();
        var equipment = $('#equiplistEquipment').val();
        var equipmentkind = $('#equiplistEquipmentkind').val();
        var equipmentserial = $('#equiplistEquipmentserial').val();
        var plant = $('#equiplistPlant').val();

        if(row===undefined|| row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else {
            var id = row.id;
            $.ajax({
                type: "post",
                data: {
                    zid: id,
                    zworklead: worklead,
                    zworker: worker,
                    zequipment: equipment,
                    zequipmentkind: equipmentkind,
                    zequipmentserial: equipmentserial,
                    zplant: plant
                },
                url: "/PlanPB/update.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        var rowIndex = $('#equiplist_dgm').datagrid('getRowIndex', row.id);
                        var datarow = $('#equiplist_dgm').datagrid('getData').rows[rowIndex];
                        datarow.worklead = $('#equiplistWorklead').val();
                        datarow.worker = $('#equiplistWorker').val();
                        datarow.equipment = $('#equiplistEquipment').val();
                        datarow.equipmentkind = $('#equiplistEquipmentkind').val();
                        datarow.equipmentserial = $('#equiplistEquipmentserial').val();
                        datarow.plant = $('#equiplistPlant').val();
                        $('#equiplist_dgm').datagrid('refreshRow', rowIndex);
                        $('#equiplist_ff').form("clear");
                        $.messager.alert('温馨提示', '修改成功!');
                    }
                }
            })
        }
    }
    function equiplistUpdate() {
        var row = $('#equiplist_dgm').datagrid("getSelected");
        if(row===undefined||row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else{
            $.ajax({
                type: "post",
                data:{
                    zid:row.id
                },
                url:"/PlanPB/delete.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        equiplistgetData();
                        $('#equiplist_ff').form("clear");
                        $.messager.alert('温馨提示', '删除成功!');
                    }
                }
            })
        }

    }
</script>