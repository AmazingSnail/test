<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ include file="/commons/global.jsp" %>--%>

<script type="text/javascript">
    var userDataGrid;
    var organizationTree;

    $(function() {
        organizationTree = $('#organizationTree').tree({
            url : '/organization/tree.action',
            parentField : 'pid',
            lines : true,
            onClick : function(node) {
                userDataGrid.datagrid('load', {
                    organizationId: node.id
                });
            }
        });

        userDataGrid = $('#userDataGrid').datagrid({
            url : '/user/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'createTime',
	        sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '80',
                title : '登录名',
                field : 'loginName',
                sortable : true
            }, {
                width : '80',
                title : '姓名',
                field : 'name',
                sortable : true
            },{
                width : '80',
                title : '部门ID',
                field : 'organizationId',
                hidden : true
            },{
                width : '80',
                title : '所属部门',
                field : 'organizationName'
            },{
                width : '130',
                title : '创建时间',
                field : 'createTime',
                sortable : true
            },  {
                width : '40',
                title : '性别',
                field : 'sex',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '男';
                    case 1:
                        return '女';
                    }
                }
            }, {
                width : '40',
                title : '年龄',
                field : 'age',
                sortable : true
            },{
                width : '120',
                title : '电话',
                field : 'phone',
                sortable : true
            }, 
            {
                width : '200',
                title : '角色',
                field : 'rolesList'
            }, {
                width : '60',
                title : '用户类型',
                field : 'userType',
                sortable : true,
                formatter : function(value, row, index) {
                    if(value == 0) {
                        return "管理员";
                    }else if(value == 1) {
                        return "用户";
                    }
                    return "未知类型";
                }
            },{
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
                } , {
                    width : '60',
                    title : '工作流',
                    field : 'actstate',
                    sortable : true,
                    formatter : function(value, row, index) {
                        switch (value) {
                            case true:
                                return '启用';
                            default:
                                return '禁用';
                        }
                    }
                } , {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/user/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editUserFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/user/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteUserFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.user-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#userToolbar'
        });
    });
    
    function addUserFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 300,
            href : '/static/user/userAdd.jsp',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = userDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#userAddForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteUserFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = userDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            userDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
            if (b) {
                progressLoad();
                $.post('/user/delete', {
                    id : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        userDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }
    
//    function editUserFun(id) {
//        if (id == undefined) {
//            var rows = userDataGrid.datagrid('getSelections');
//            id = rows[0].id;
//        } else {
//            userDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
//        }
//        parent.$.modalDialog({
//            title : '编辑',
//            width : 500,
//            height : 300,
//            href : '/static/user/userEdit.jsp?id=' + id,
//            buttons : [ {
//                text : '确定',
//                handler : function() {
//                    parent.$.modalDialog.openner_dataGrid = userDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
//                    var f = parent.$.modalDialog.handler.find('#userEditForm');
//                    f.submit();
//                }
//            } ]
//        });
//    }
    var roleTree;
    function editUserFun(id) {
        jQuery.ajax({
            type: "post",   //post提交方式默认是get
            url: "/user/editPage",
            dataType: "json",
            data: {
                id: id,
            },
            error: function (request) {      // 设置表单提交出错
                alert("出错");
            },
            success: function (data) {

                $("#userid").textbox("setValue",id);
                $("#userName").textbox("setValue",data.name);
                $("#loginName").textbox("setValue",data.loginName);
                var sex = data.sex;
//                if(sex == '0'){
//                    sex = '男';
//                }else{
//                    sex = '女';
//                }
                $("#userEditSex").combobox("setValue",sex);
                $("#userage").textbox("setValue",data.age);
                var userType = data.userType;
//                if(userType=='0'){
//                    userType='管理员'
//                }else {
//                    userType='用户'
//                }
                $("#userEditUserType").combobox("setValue",userType);
                $("#userEditorganizationId").textbox("setValue",data.organizationId);
                $("#userEditRoleIds").combobox("setValue", "");
//                $("#userEditRoleIds").textbox("setValue",data.rolesList);

                $("#userphone").textbox("setValue",data.phone);
                var status = data.status;
//                if(status=='0'){
//                    status='正常'
//                }else {
//                    status='停用'
//                }
                $("#userEditStatus").combobox("setValue",status);
                var actstate = data.actstate;
                if(actstate == true){
                    actstate = '启用';
                }else{
                    actstate = '禁用';
                }
                $("#useractstate").combobox("setValue",actstate);

            }
        });

        $('#userAdd2').dialog('open')

        $('#userEditorganizationId').combotree({
            url : '/organization/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto'
            <%--value : '${user.organizationId}'--%>
        });
        var node;
        roleTree= $('#userEditRoleIds').combotree({
            url : '/role/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            multiple : true,
            required : true,
            cascadeCheck : false,
            onClick : function(node) {alert(node)},
            onLoadSuccess : function(node, data) {
                progressLoad();
                $.post( '/role/findRoleIdListByUserId', {
                    id : id
                }, function(result) {
                    var ids;
                    if (result.success == true && result.obj != undefined) {
                        ids = $.stringToList(result.obj + '');
                    }

                    if (ids.length > 0) {
                        for ( var i = 0; i < ids.length; i++) {
                            if (
                                node = $('#userEditRoleIds').combotree('tree').tree('find', ids[i])) {
                                $('#userEditRoleIds').combotree('tree').tree('check', node.target);
                                $('#userEditRoleIds').combotree('tree').tree('expandAll', node.target);
                            }
                        }
                    }
                }, 'json');
                progressClose();
            },


        });


    }

    function searchUserFun() {
        userDataGrid.datagrid('load', $.serializeObject($('#searchUserForm')));
    }
    function cleanUserFun() {
        $('#searchUserForm input').val('');
        userDataGrid.datagrid('load', {});
    }


    function userEdit() {
        var id = $('#userid').val();
        var sex = $('#userEditSex').combobox("getValue");
//        if(sex == "男"){
//            sex = "0";
//        }else if(sex == "女"){
//            sex = "1";
//        }
        var userType = $('#userEditUserType').combobox("getValue");
//        if(userType == "管理员"){
//            userType = "0";
//        }else if(userType == "用户"){
//            userType = "1";
//        }
        var status = $('#userEditStatus').combobox("getValue");
//        if(status == "正常"){
//            status = "0";
//        }else if(status == "停用"){
//            status ="1";
//        }
        progressLoad();
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "/user/edit",
            dataType: "json",
            data: {
                id:$('#userid').val(),
                loginName:$('#loginName').val(),
                name:$('#userName').val(),
                sex:sex,
                age:$('#userage').val(),
                userType:userType,
                organizationId:$('#userEditorganizationId').val(),
                roleIds:$('#userEditRoleIds').val(),
                phone:$('#userphone').val(),
                status:status,
                actstate:$('#useractstate').val(),



            },
            error: function (request) {      // 设置表单提交出错
                progressClose();
                $.messager.alert(request);  //登录错误提示信息
                $('#userAdd2').dialog('close')
            },
            success: function (data) {
                progressClose();
                console.log(data)
                parent.$.messager.alert('提示', data.msg, 'info');
                userDataGrid.datagrid('reload');
                $('#userAdd2').dialog('close')
            }
        });
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">

    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchUserForm">
            <table>
                <tr>
                    <th>姓名:</th>
                    <td><input name="name" placeholder="请输入用户姓名"/></td>
                    <th>创建时间:</th>
                    <td>
                        <input name="createdateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                        <input  name="createdateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="searchUserFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="cleanUserFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'用户列表'" >
        <table id="userDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'组织机构'"  style="width:150px;overflow: hidden; ">
        <ul id="organizationTree" style="width:160px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="userToolbar" style="display: none;">
    <shiro:hasPermission name="/user/add">
        <a onclick="addUserFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>

<div id="userAdd2" class="easyui-dialog" title="编辑" data-options="iconCls:'icon-save',closed:true," style="width:300px;height:400px;padding:10px">
    <table>
        <tr align="center" hidden="hidden">
            <td align="center"><input name="userid" class="easyui-textbox" data-options="required:false" type="text" id="userid" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">登录名</span>:</td>
            <td align="center"><input name="loginName" class="easyui-textbox" data-options="required:false" type="text" id="loginName" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">姓名</span>:</td>
            <td align="center"><input name="userName" class="easyui-textbox" data-options="required:false" type="text" id="userName" ></input></td>
        </tr>
        <tr align="center">
            <td  align="center"><span class="w2">性别</span>:</td>
            <td align="center">
                <select id="userEditSex" name="usersex" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <option value="0">男</option>
                    <option value="1">女</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">年龄</span>:</td>
            <td align="center"><input name="userage" class="easyui-numberbox" data-options="required:false"   id="userage" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">用户类型</span>:</td>
            <td align="center">
                <select id="userEditUserType" name="userType" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <option value="0">管理员</option>
                    <option value="1">用户</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center">部门</td>
            <td align="center"><input  name="organizationId" class="easyui-combobox" data-options="required:false"type="text" id="userEditorganizationId" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">角色</span>:</td>
            <td align="center">
                <input name="roleIds" class="easyui-combobox" data-options="required:false" id="userEditRoleIds"  value="0"  >
                <%--<ul id="userEditRoleIds"></ul>--%>
                </input>
            </td>


        </tr>
        <tr align="center">
            <td align="center"><span class="w3">电话</span>:</td>
            <td align="center"><input name="phone" class="easyui-numberbox" data-options="required:false"  value="0" id="userphone" ></input></td>

        </tr>
        <tr align="center">
            <td align="center"><span class="w2">用户状态</span>:</td>
            <td align="center">
                <select id="userEditStatus" name="userstatus" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <option value="0">正常</option>
                    <option value="1">停用</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">工作流</span>:</td>
            <td align="center">
                <select id="useractstate" name="useractstate" class="easyui-combobox" data-options="width:135,height:24,editable:false,panelHeight:'auto'">
                    <option value= true>启用</option>
                    <option value= false>禁用</option>
                </select>
            </td>
        </tr>

        <tr align="center">
            <td align="left"><button class="easyui-linkbutton" iconCls="icon-save" onclick="userEdit()" style="width: 90px;text-align:center" id="SLsave">保存</button></td>
            <td align="right"><button class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#userAdd2').dialog('close')" style="width: 90px" >取消</button></td>
        </tr>
    </table>
</div>