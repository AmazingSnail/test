<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ include file="/commons/global.jsp" %>--%>
<script type="text/javascript">
    var resourceTreeGrid;
    $(function() {
        resourceTreeGrid = $('#resourceTreeGrid').treegrid({
            url : '/resource/treeGrid',
            idField : 'id',
            treeField : 'name',
            parentField : 'pid',
            fit : true,
            fitColumns : false,
            border : false,
            frozenColumns : [ [ {
                title : '编号',
                field : 'id',
                width : 40
            } ] ],
            columns : [ [ {
                field : 'name',
                title : '资源名称',
                width : 150
            }, {
                field : 'url',
                title : '资源路径',
                width : 200
            }, {
                field : 'openMode',
                title : '打开方式',
                width : 60
            }, {
                field : 'opened',
                title : '菜单状态',
                width : 60,
                formatter : function(value, row, index) {
                    if (value == 1) {
                        return '打开';
                    } else {
                        return '关闭';
                    }
                }
            }, {
                field : 'seq',
                title : '排序',
                width : 40
            }, {
                field : 'iconCls',
                title : '图标',
                width : 120
            }, {
                field : 'resourceType',
                title : '资源类型',
                width : 80,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '菜单';
                    case 1:
                        return '按钮';
                    }
                }
            }, {
                field : 'pid',
                title : '上级资源ID',
                width : 150,
                hidden : true
            }, {
                field : 'status',
                title : '状态',
                width : 40,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '正常';
                    case 1:
                        return '停用';
                    }
                }
            }, {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/resource/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="resource-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editResourceFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/resource/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="resource-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteResourceFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.resource-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.resource-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#resourceToolbar'
        });
    });

//    function editResourceFun(id) {
//        if (id != undefined) {
//            resourceTreeGrid.treegrid('select', id);
//        }
//        var node = resourceTreeGrid.treegrid('getSelected');
//        if (node) {
//            parent.$.modalDialog({
//                title : '编辑',
//                width : 500,
//                height : 350,
//                href : '/static/resource/resourceEdit.jsp?id=' + node.id,
//                buttons : [ {
//                    text : '确定',
//                    handler : function() {
//                        parent.$.modalDialog.openner_treeGrid = resourceTreeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
//                        var f = parent.$.modalDialog.handler.find('#resourceEditForm');
//                        f.submit();
//                    }
//                } ]
//            });
//        }
//    }

    function editResourceFun(id) {
        jQuery.ajax({
            type: "post",   //post提交方式默认是get
            url: "/resource/editPage",
            dataType: "json",
            data: {
                id: id,
            },
            error: function (request) {      // 设置表单提交出错
                alert("出错");
            },
            success: function (data) {

                $("#resourceid").textbox("setValue",id);
                $("#resourcename").textbox("setValue",data.name);
                var resourceType=data.resourceType;
                $("#resourceEditType").combobox("setValue",resourceType);
                $("#resourceurl").textbox("setValue",data.url);
                var openMode = data.openMode;
                $("#resourceEditOpenMode").combobox("setValue",openMode);
                $("#resourceicon").textbox("setValue",data.iconCls);
                $("#resourceseq").textbox("setValue",data.seq);

                var status = data.status;
                $("#resourceEditStatus").combobox("setValue",status);

                var opened = data.opened;
                $("#resourceEditOpened").combobox("setValue",opened);
                $("#resourceEditPid").textbox("setValue",data.pid);




            }
        });
        $('#resourceEditPid').combotree({
            url : '/resource/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',

        });

        $('#resourceAdd').dialog('open')
    }

    function deleteResourceFun(id) {
        if (id != undefined) {
            resourceTreeGrid.treegrid('select', id);
        }
        var node = resourceTreeGrid.treegrid('getSelected');
        if (node) {
            parent.$.messager.confirm('询问', '您是否要删除当前资源？删除当前资源会连同子资源一起删除!', function(b) {
                if (b) {
                    progressLoad();
                    $.post('/resource/delete', {
                        id : node.id
                    }, function(result) {
                        if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            resourceTreeGrid.treegrid('reload');
//                            parent.indexMenuZTree.reAsyncChildNodes(null, "refresh");
                        }
                        progressClose();
                    }, 'JSON');
                }
            });
        }
    }

    function addResourceFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 350,
            href : '/static/resource/resourceAdd.jsp',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_treeGrid = resourceTreeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#resourceAddForm');
                    f.submit();
                }
            } ]
        });
    }

    function resourceEdit() {
        var nodes=$("#resourceEditPid").combotree("getValue");
        progressLoad();
        var resourceType = $('#resourceEditType').combobox("getValue");
        var openMode = $('#resourceEditOpenMode').combobox("getValue");
        if(openMode=="无(用于上层菜单)"){
            openMode = null;
        }
        var status = $('#resourceEditStatus').combobox("getValue");
        var opened = $('#resourceEditOpened').combobox("getValue");
        //alert($('#resourceEditPid').val());
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "/resource/edit",
            dataType: "json",
            data: {
                id:$('#resourceid').val(),
                name:$('#resourcename').val(),
                resourceType:resourceType,
                url:$('#resourceurl').val(),
                openMode:openMode,
                icon:$('#resourceicon').val(),
                seq:$('#resourceseq').val(),
                status:status,
                opened:opened,
                pid:nodes,




            },
            error: function (request) {      // 设置表单提交出错
                progressClose();
                $.messager.alert(request);  //登录错误提示信息
                $('#resourceAdd').dialog('close')
            },
            success: function (data) {
                progressClose();
                console.log(data)
                parent.$.messager.alert('提示', data.msg, 'info');
                resourceTreeGrid.treegrid('reload');
                $('#resourceAdd').dialog('close')
            }
        });
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false"  style="overflow: hidden;">
        <table id="resourceTreeGrid"></table>
    </div>
</div>
<div id="resourceToolbar" style="display: none;">
    <shiro:hasPermission name="/resource/add">
        <a onclick="addResourceFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>

<div id="resourceAdd" class="easyui-dialog" title="编辑" data-options="iconCls:'icon-save',closed:true," style="width:300px;height:400px;padding:10px">
    <table>
        <tr align="center" hidden="hidden">
            <td align="center"><input name="resourceid" class="easyui-textbox" data-options="required:false" type="text" id="resourceid" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">资源名称</span>:</td>
            <td align="center"><input name="resourcename" class="easyui-textbox" data-options="required:false" type="text" id="resourcename" ></input></td>
        </tr>
        <tr align="center">
        <tr align="center">
            <td  align="center"><span class="w2">资源类型</span>:</td>
            <td align="center">
                <select id="resourceEditType" name="resourceEditType" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <%--<option value="0">菜单</option>--%>
                    <option value="1">按钮</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">资源路径</span>:</td>
            <td align="center"><input name="resourceurl" class="easyui-textbox" data-options="required:false"   id="resourceurl" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">打开方式</span>:</td>
            <td align="center">
                <select id="resourceEditOpenMode" name="openMode" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <option>无(用于上层菜单)</option>
                    <option value="ajax">ajax</option>
                    <option value="iframe">iframe</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center">菜单图标</td>
            <td align="center"><input  name="resourceicon" class="easyui-textbox" data-options="required:false"type="text" id="resourceicon" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">排序</span>:</td>
            <td align="center"><input name="seq" class="easyui-numberspinner" data-options="required:false"  value="0" id="resourceseq" ></input></td>


        </tr>
        <tr align="center">
            <td align="center"><span class="w3">状态</span>:</td>
            <td align="center">
                <select id="resourceEditStatus" name="resourceEditStatus" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                    <option value="0">正常</option>
                    <option value="1">停用</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">菜单状态</span>:</td>
            <td align="center">
                <select id="resourceEditOpened" name="opened" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <%--<option value="0">关闭</option>--%>
                    <option value="1">打开</option>
                </select>
            </td>


        </tr>
        <tr align="center">
            <td align="center"><span class="w2">上级资源</span>:</td>
            <td align="center">
                <select id="resourceEditPid" name="pid" style="width: 135px; height: 24px;"></select>
            </td>
        </tr>
        <tr align="center">
            <td align="left"><button class="easyui-linkbutton" iconCls="icon-save" onclick="resourceEdit()" style="width: 90px;text-align:center" id="SLsave">保存</button></td>
            <td align="right"><button class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#resourceAdd').dialog('close')" style="width: 90px" >取消</button></td>
        </tr>
    </table>
</div>
