<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ include file="/commons/global.jsp" %>--%>
<script type="text/javascript">
    var roleDataGrid;
    $(function() {
        roleDataGrid = $('#roleDataGrid').datagrid({
            url : '/role/dataGrid',
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'id',
            sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            frozenColumns : [ [ {
                width : '100',
                title : 'id',
                field : 'id',
                sortable : true
            }, {
                width : '80',
                title : '名称',
                field : 'name',
                sortable : true
            } , {
                width : '80',
                title : '排序号',
                field : 'seq',
                sortable : true
            }, {
                width : '200',
                title : '描述',
                field : 'description'
            } , {
                width : '60',
                title : '状态',
                field : 'status',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '正常';
                    case 1:
                        return '停用';
                    }
                }
            }, {
                width : '60',
                title : '工作流',
                field : 'actGroupState',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                        case true:
                            return '启用';
                        case false:
                            return '禁用';
                        default:
                            return '未知状态';
                    }
                }
            }, {
                field : 'action',
                title : '操作',
                width : 200,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/role/grant">
                            str += $.formatString('<a href="javascript:void(0)" class="role-easyui-linkbutton-ok" data-options="plain:true,iconCls:\'fi-check icon-green\'" onclick="grantRoleFun(\'{0}\');" >授权</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/role/edit">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="role-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editRoleFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/role/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="role-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteRoleFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.role-easyui-linkbutton-ok').linkbutton({text:'授权'});
                $('.role-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.role-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#roleToolbar'
        });
    });

    function addRoleFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 300,
            href : '/static/role/roleAdd.jsp',
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = roleDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#roleAddForm');
                    f.submit();
                }
            } ]
        });
    }


    function editRoleFun(id) {
        $('#roleGrantLayout').dialog('close');
        jQuery.ajax({
            type: "post",   //post提交方式默认是get
            url: "/role/editPage",
            dataType: "json",
            data: {
                id: id,
            },
            error: function (request) {      // 设置表单提交出错
                alert("出错");
            },
            success: function (data) {
                console.log(data)

                $("#roleid").textbox("setValue",id);
                $("#rolename").textbox("setValue",data.name);
                $("#roleseq").textbox("setValue",data.seq);
                var status = data.status;
                if(status=="0"){
                    status = "正常";
                }else{
                    status = "关闭";
                }
                $("#roleEditStatus").textbox("setValue",status);
                $("#roledescription").textbox("setValue",data.description);
                var actGroupState = data.actGroupState;
                if(actGroupState == true){
                    actGroupState = '启用';
                }else{
                    actGroupState = '禁用';
                }
                $("#roleactGroupState").combobox("setValue",actGroupState);
            }
        });
        $('#roleAdd').dialog('open')
    }

    function deleteRoleFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = roleDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            roleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path }/role/delete', {
                    id : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        roleDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }

    var resourceTree;
    var roleId;

    function grantRoleFun(id) {
        $('#roleAdd').dialog('close');
        roleId = id;
        $(function() {
            resourceTree = $('#resourceTree').tree({
                url : '/resource/allTrees',
                parentField : 'pid',
                lines : true,
                checkbox : true,
                onClick : function(node) {},
                onLoadSuccess : function(node, data) {
                    progressLoad();
                    $.post( '/role/findResourceIdListByRoleId', {
                        id : id
                    }, function(result) {
                        var ids;
                        if (result.success == true && result.obj != undefined) {
                            ids = $.stringToList(result.obj + '');
                        }

                        if (ids.length > 0) {
                            for ( var i = 0; i < ids.length; i++) {
                                if (resourceTree.tree('find', ids[i])) {
                                    resourceTree.tree('check', resourceTree.tree('find', ids[i]).target);
                                }
                            }
                        }
                    }, 'json');
                    progressClose();
                },
                cascadeCheck : false
            });

        });
        $('#roleGrantLayout').dialog('open')

    }

    function grant(){
        var allresourceids ='';
        var checknodes = resourceTree.tree('getChecked');
        console.log(checknodes);
        for(var i = 0; i < checknodes.length; i++){
            allresourceids = allresourceids + checknodes[i].id + ',';
        }
        if(allresourceids.endsWith(",")){
            allresourceids = allresourceids.substr(0,allresourceids.length-1);
        }
        if(allresourceids==""){
            alert("你还未授权")
        }else{
            progressLoad();
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: "/role/grant",
                dataType: "json",
                data: {
                    id:roleId,
                    resourceIds:allresourceids

                },
                error: function (request) {      // 设置表单提交出错
                    progressClose();
                    $.messager.alert(request);  //登录错误提示信息
                    $('#roleGrantLayout').dialog('close')
                },
                success: function (data) {
                    progressClose();
                    console.log(data)
                    parent.$.messager.alert('提示', data.msg, 'info');
                    roleDataGrid.datagrid('reload');
                    $('#roleGrantLayout').dialog('close')
                }
            });
        }



    }

    function checkAll() {
        var allresourceids = '';
        var nodes = resourceTree.tree('getChecked', 'unchecked');
        if (nodes && nodes.length > 0) {
            for ( var i = 0; i < nodes.length; i++) {
                resourceTree.tree('check', nodes[i].target);

            }
        }

    }

    function checkInverse() {
        var allresourceids = '';
        var unchecknodes = resourceTree.tree('getChecked', 'unchecked');
        var checknodes = resourceTree.tree('getChecked');
        if (unchecknodes && unchecknodes.length > 0) {
            for ( var i = 0; i < unchecknodes.length; i++) {
                resourceTree.tree('check', unchecknodes[i].target);
            }
        }
        if (checknodes && checknodes.length > 0) {
            for ( var i = 0; i < checknodes.length; i++) {
                resourceTree.tree('uncheck', checknodes[i].target);
            }
        }

    }

    function uncheckAll() {
        var nodes = resourceTree.tree('getChecked');
        if (nodes && nodes.length > 0) {
            for ( var i = 0; i < nodes.length; i++) {
                resourceTree.tree('uncheck', nodes[i].target);
            }
        }


    }
    function RoleEdit() {
        progressLoad();
        var roleEditStatus = $('#roleEditStatus').val();
        if(roleEditStatus == "正常"){
            roleEditStatus = "0"
        }else if(roleEditStatus == "停用"){
            roleEditStatus = "1"
        }
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "/role/edit",
            dataType: "json",
            data: {
                id:$('#roleid').val(),
                name:$('#rolename').val(),
                seq:$('#roleseq').val(),
                status:roleEditStatus,
                description:$('#roledescription').val(),
                actGroupState:$('#roleactGroupState').val(),

            },
            error: function (request) {      // 设置表单提交出错
                progressClose();
                $.messager.alert(request);  //登录错误提示信息
                $('#roleGrantLayout').dialog('close')
            },
            success: function (data) {
                progressClose();
                console.log(data)
                parent.$.messager.alert('提示', data.msg, 'info');
                roleDataGrid.datagrid('reload');
                $('#roleGrantLayout').dialog('close')
            }
        });
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',fit:true,border:false">
        <table id="roleDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="roleToolbar" style="display: none;">
    <shiro:hasPermission name="/role/add">
        <a onclick="addRoleFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>

<div id="roleAdd" class="easyui-dialog" title="编辑" data-options="iconCls:'icon-save',closed:true," style="width:285px;height:250px;padding:10px">
    <table>
        <tr align="center" hidden="hidden">
            <td align="center"><span class="w3">id</span>:</td>
            <td align="center"><input name="roleid" class="easyui-textbox" data-options="required:false" type="text" id="roleid" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">角色名称</span>:</td>
            <td align="center"><input name="rolename" class="easyui-textbox" data-options="required:false" type="text" id="rolename" ></input></td>
        </tr>
        <tr align="center">
        <tr align="center">
            <td  align="center"><span class="w2">排序</span>:</td>
            <td align="center"><input name="seq" class="easyui-numberspinner" data-options="required:false"  value="0" id="roleseq" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">状态</span>:</td>
            <td align="center">
                <select id="roleEditStatus" name="rolestatus" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                <option value="0">正常</option>
                <option value="1">停用</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">工作流</span>:</td>
            <td align="center">
                <select id="roleactGroupState" name="roleactGroupState" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                    <option value=true>启用</option>
                    <option value=false>禁用</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">备注</span>:</td>
            <td align="center"><textarea name="description" class="easyui-textbox" id="roledescription"> </textarea></td>
        </tr>

        <tr align="center">
            <td align="left"><button class="easyui-linkbutton" iconCls="icon-save" onclick="RoleEdit()" style="width: 90px;text-align:center" id="SLsave">保存</button></td>
            <td align="right"><button class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#roleAdd').dialog('close')" style="width: 90px" >取消</button></td>
        </tr>
    </table>
</div>

<div id="roleGrantLayout"   title="授权" class="easyui-dialog"  data-options="closed:true" style="width:400px;height:300px;padding:10px">
    <div   data-options="region:'west'"  title="系统资源" style="width: 300px; padding: 1px;">
        <div class="well well-small">
            <form id="roleGrantForm" method="post">
                <input name="id" type="hidden"  value="${id}" readonly="readonly">
                <ul id="resourceTree"></ul>
                <input id="resourceIds" name="resourceIds" type="hidden" />
            </form>
        </div>
    </div>
    <div  data-options="region:'center'" title="" style="overflow: hidden; padding: 10px;">
        <div>
            <button class="btn btn-success" onclick="checkAll();">全选</button>

            <button class="btn btn-warning" onclick="checkInverse();">反选</button>

            <button class="btn btn-inverse" onclick="uncheckAll();">取消</button>


            <button class="btn btn-inverse" onclick="grant();">授权</button>
        </div>
    </div>
</div>
