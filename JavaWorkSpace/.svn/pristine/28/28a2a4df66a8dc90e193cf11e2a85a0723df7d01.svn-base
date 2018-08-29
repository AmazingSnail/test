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
    .haorooms{
        height: calc(100% - 78px);
    }
    .haorooms2{
        height: calc(100% - 200px);
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
        <div class="easyui-panel" title="关系维护" data-options="fit:true">
            <div id="wu-toolbar" style="height:78px">
                <div class="wu-toolbar-button">

                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="coldRshipexcelin()" plain="true">导入</a>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="coldRshipexcelout()" plain="true">导出</a>--%>
                    <a href="#" class="easyui-linkbutton"  onclick="coldRshipopendiv()" data-options="iconCls:'icon-add'" plain="true">新增基础数据</a>
                </div>
                <div class="wu-toolbar-search">
                    <span></span>
                    <div>
                        <label>炉批号：</label>
                        <select class="easyui-combobox" name="reelnum" datatype="text" id="coldRship_reelnum" panelHeight="auto" data-options="
                            valueField:'reelnum',
                            textField:'reelnum',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>产品钢卷号：</label>
                        <select class="easyui-combobox" name="freelnum" datatype="text" id="coldRship_Freelnum" panelHeight="auto" data-options="
                            valueField:'freelnum',
                            textField:'freelnum',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <%--<shiro:hasPermission name="/Equipment/edit">--%>
                            <a href="#" class="easyui-linkbutton"  onclick="coldRshipgetData()" data-options="iconCls:'icon-search'">查询</a>
                            <%--<a href="#" class="easyui-linkbutton"  onclick="coldRshipUpdate()" data-options="iconCls:'icon-delete'">删除</a>--%>
                        <%--</shiro:hasPermission>--%>
                    </div>
                </div>
            </div>
            <div class="easyui-layout haorooms" data-options="fit:true" >
                <div class="cz">
                    <%--style="white-space: nowrap;"--%>
                    <table id="coldRship_dgm" class="easyui-datagrid" style="height: 65%"  title="设备清单" data-options="singleSelect:true,onClickRow:coldRship_onClickRow"></table>
                    <div id="coldRshipadd" class="easyui-dialog" title="添加设备" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                        <from>
                            <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                <td>
                                    <tr>
                                        <td><span class="w3">炉批号</span>:<input class="easyui-textbox" type="text" name="reelnum" id="coldRshipFormreelnum"  style="width:150px"></input></td>
                                    </tr>
                                    <tr>
                                        <td><span class="w3">钢卷号</span>:<input class="easyui-textbox" type="text" name="freelnum" id="coldRshipFormfreelnum" style="width:150px" ></input></td>
                                    </tr>
                                    <tr>
                                        <td>采购订单:<input class="easyui-textbox" type="text" name="vbeln" id="coldRshipFormvbeln" style="width:150px" ></input></td>
                                    </tr>
                                    <tr>
                                        <td>重量（kg）:<input class="easyui-textbox" type="number" name="weight" id="coldRshipFormweight" style="width:150px" ></input></td>
                                    </tr>
                                    <tr>
                                        <td><span class="w2">规格</span>:<input class="easyui-textbox" type="text" name="specification" id="coldRshipFormspecification" style="width:150px"  ></input></td>
                                    </tr>
                                    <tr>
                                        <td><span class="w2">备注</span>:<input class="easyui-textbox" type="text" name="note" id="coldRshipFormnote" style="width:150px" ></input></td>
                                    </tr>
                                    <tr >

                                        <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="coldRshipAdd()" id="coldRshipFormSave" data-options="iconCls:'icon-save'" >保存</a></td>

                                    </tr>
                                </td>
                            </table>
                        </from>
                    </div>
                    <div style="overflow:auto;width:100%;height:35%" title="详细信息" class="easyui-panel"   >
                        <form id="coldRship_ff" method="post">
                            <table cellpadding="5" width="auto" style="white-space:nowrap">
                                <tr>
                                    <td>炉批号:</td>
                                    <td><input class="easyui-textbox" type="text" name="reelnum" id="coldRshipreelnum" data-options="required:true" disabled=true ></input></td>
                                    <td>产品钢卷号:</td>
                                    <td><input class="easyui-textbox" type="text" name="freelnum" id="coldRshipfreelnum" data-options="required:true" ></input></td>

                                </tr>
                                <tr>
                                    <td>采购订单:</td>
                                    <td><input class="easyui-textbox" type="text" name="vbeln" id="coldRshipvbeln" data-options="required:true" ></input></td>

                                    <td>重量（kg）:</td>
                                    <td><input class="easyui-textbox" type="number" name="weight" id="coldRshipweight" data-options="required:true"></input></td>

                                </tr>
                                <tr>
                                    <td>规格:</td>
                                    <td><input class="easyui-textbox" type="text" name="specification" id="coldRshipspecification" data-options="required:true" ></input></td>
                                    <td>品种牌号:</td>
                                    <td><input class="easyui-textbox" type="text" name="qualitybrand" id="coldRshipqualitybrand" data-options=""  ></input></td>
                                    <input class="easyui-textbox" type="hidden" name="id" id="coldRshipid"   ></input>
                                </tr>
                                <tr>
                                    <td>材料类型:</td>
                                    <td><input class="easyui-textbox" type="text" name="materialtype" id="coldRshipmaterialtype" data-options="required:true" ></input></td>
                                    <td>钢厂:</td>
                                    <td><input class="easyui-textbox" type="text" name="steelworks" id="coldRshipsteelworks" data-options=""  ></input></td>
                                </tr>
                                <%--<shiro:hasPermission name="/Equipment/edit">--%>
                                    <tr>
                                        <td><a href="#" class="easyui-linkbutton" name="save" onclick="coldRshipSave()" id="coldRshipSave" data-options="iconCls:'icon-save'"  >保存</a></td>
                                    </tr>
                                <%--</shiro:hasPermission>--%>
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
//        $("#coldRship_Plant").combobox({
//            //相当于html >> select >> onChange事件
//            onChange:function(){
//                coldRshipgetData();
//            }
//        });
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
                $('#coldRship_reelnum').combobox('loadData', data);
                $('#coldRship_Freelnum').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#coldRshipFormEquipment").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                $.ajax({
                    type: "post",
                    url: "${ctxPath }/RshipMaintenanceController/selectALL.action",
                    data: {
                        plant: $("#coldRship_Plant").combobox("getText"),
                        equipment:$('#coldRshipFormEquipment').combobox("getText")
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        //alert(data.FLID);
                        $('#coldRshipFormEquipmentserial').textbox('setValue',data.FLID);
                    }
                });
            }
        });

    });
    function coldRshipopendiv() {

        $('#coldRshipadd').dialog('open');

    }

    function coldRshipexcelin(){
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth()+1;
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
                    "month": month,
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
                            if (fs[fs.length - 1].toLowerCase() == 'xls') {
                                Ext.MessageBox.show({
                                    title: '信息',
                                    msg: '<font color="green">确定要上传文件:' + file + '？</font>',
                                    params: {
                                        "year": year,
                                        "month":month,
                                        "User": localStorage.getItem("User"),
                                        "mpupinst": $('input[name="adminFlag"]:checked').val()
                                    },
                                    width: 300,
                                    buttons: {'ok': '确定', 'no': '取消'},
                                    icon: Ext.MessageBox.WARNING,
                                    closable: false,
                                    fn: function (e) {
                                        if (e == 'ok') {
                                            if (upload.form.isValid()) {
                                                upload.getForm().submit({

                                                    url: '${ctxPath }/RshipMaintenanceController/import.action',
                                                    method: 'POST',
                                                    params: {
                                                        "year": year,
                                                        "month":month,
                                                        "User": localStorage.getItem("User"),
                                                        "mpupinst": $('input[name="adminFlag"]:checked').val()
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
    function coldRshipgetData() {
        var fdata;
        $('#coldRship_dgm').datagrid('loadData', {total: 0, rows: []});
        jQuery.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/RshipMaintenanceController/selectALL.action",//要发送的后台地址
            data: {
                reelnum:$("#coldRship_reelnum").combobox("getValue"),
                freelnum:$("#coldRship_Freelnum").combobox("getValue")
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                fdata = data;
                $("#coldRship_dgm").datagrid({
                    idField:'id',
                    rownumbers: true,
                    singleSelect: true,
                    pagination: true,
                    multiSort: true,
                    showRefresh:false,
                    //fitColumns:true,
//                    fit:true,
                    method: 'post',
                    data: fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns: [[
                        {field: 'id', title: '编号', width: 70},
                        {field: 'reelnum', title: '炉批号', width: 80},
                        {field: 'freelnum', title: '产品钢卷号', width: 80},
                        {field: 'vbeln', title: '采购订单',  width: 100},
                        {field: 'weight', title: '重量(KG)', width: 100},
                        {field: 'specification', title: '规格', width: 100},
                        {field: 'note', title: '备注',  width: 100},
                        {field: 'materialtype', title: '材料类型',  width: 100},
                        {field: 'steelworks', title: '钢厂',  width: 100},
                        {field: 'qualitybrand', title: '品种牌号',  width: 100}
                    ]],
                    pageList: [25, 50, 100],

                });
                $('#coldRship_dgm').datagrid({loadFilter: coldRship_pagerFilter}).datagrid('loadData', fdata);

                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });
    }

    var editIndex = undefined;
    function coldRship_onClickRow(index){
            var row = $("#coldRship_dgm").datagrid("getSelected");
            $('#coldRship_ff').form('load',{
                id:row.id,
                reelnum:row.reelnum,
                freelnum:row.freelnum,
                weight:row.weight,
                vbeln:row.vbeln,
                specification:row.specification,
                note:row.note,
                materialtype:row.materialtype,
                steelworks:row.steelworks,
                qualitybrand:row.qualitybrand,
            });

            editIndex = index;
    }
    function coldRship_pagerFilter(data){
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
    function coldRshipAdd() {
        //alert(111111);
        var reelnum = $("#coldRshipFormreelnum").val();
        var freelnum = $("#coldRshipFormfreelnum").val();
        var weight = $("#coldRshipFormweight").combobox("getText");
        var vbeln = $("#coldRshipFormvbeln").val();
        var specification = $("#coldRshipFormspecification").val();
        var qualitybrand = $("#coldRshipqualitybrand").val();
        var steelworks = $("#coldRshipsteelworks").val();
        var materialtype = $("#coldRshipmaterialtype").val();
//        var note = $("#coldRshipFormnote").val();
        $.ajax({
            type: "post",
            data: {
                reelnum: reelnum,
                freelnum: freelnum,
                weight: weight,
                vbeln: vbeln,
                specification: specification,
                materialtype:materialtype,
                steelworks:steelworks,
                qualitybrand:qualitybrand,
//                note: note
            },
            url: "${ctxPath }/RshipMaintenanceController/insert.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '新增成功!');
//                    $('#coldRship_dgm').datagrid('appendRow',{
//                        worklead:Worklead,
//                        worker:Worker,
//                        equipment: Equipment,
//                        equipmentkind: Equipmentkind,
//                        equipmentserial: Equipmentserial,
//                        plant: Plant
//                    });
                    coldRshipgetData();
                    $('#coldRship_ff').form("clear");
                    $('#coldRshipadd').dialog('close');
                }
            }
        })
    }
    function coldRshipSave() {
        var row = $('#coldRship_dgm').datagrid("getSelected");
        var reelnum = $('#coldRshipreelnum').val();
        var freelnum = $('#coldRshipfreelnum').val();
        var vbeln = $('#coldRshipvbeln').val();
        var weight = $('#coldRshipweight').val();
        var specification = $('#coldRshipspecification').val();
        var materialtype = $('#coldRshipmaterialtype').val();
        var steelworks = $('#coldRshipsteelworks').val();
        var materialtype = $('#coldRshipmaterialtype').val();
//        var note = $('#coldRshipnote').val();
//        var plant = $('#coldRshipPlant').val();
        var id = $('#coldRshipid').val();
        if(row===undefined|| row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else {
            $.ajax({
                type: "post",
                data: {
                    id: id,
                    reelnum: reelnum,
                    freelnum: freelnum,
                    vbeln: vbeln,
                    weight: weight,
                    specification: specification,
                    materialtype: materialtype,
                    steelworks: steelworks,
                    materialtype: materialtype,
                },
                url: "${ctxPath }/RshipMaintenanceController/update.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        var rowIndex = $('#coldRship_dgm').datagrid('getRowIndex', row.id);
                        var datarow = $('#coldRship_dgm').datagrid('getData').rows[rowIndex];
                        datarow.reelnum = $('#coldRshipreelnum').val();
                        datarow.freelnum = $('#coldRshipfreelnum').val();
                        datarow.vbeln = $('#coldRshipvbeln').val();
                        datarow.weight = $('#coldRshipweight').val();
                        datarow.specification = $('#coldRshipspecification').val();
                        datarow.note = $('#coldRshipnote').val();
                        $('#coldRship_dgm').datagrid('refreshRow', rowIndex);
                        $('#coldRship_ff').form("clear");
                        $.messager.alert('温馨提示', '修改成功!');
                    }
                }
            })
        }
    }
    function coldRshipUpdate() {
        var row = $('#coldRship_dgm').datagrid("getSelected");
        if(row===undefined||row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else{
            $.ajax({
                type: "post",
                data:{
                    zid:row.id
                },
                url:"${ctxPath }/PlanPB/delete.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        coldRshipgetData();
                        $('#coldRship_ff').form("clear");
                        $.messager.alert('温馨提示', '删除成功!');
                    }
                }
            })
        }

    }
</script>