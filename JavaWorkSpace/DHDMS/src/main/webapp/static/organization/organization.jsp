<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ include file="/commons/global.jsp" %>--%>
<script type="text/javascript">
    var organizationTreeGrid;
    $(function() {
        organizationTreeGrid = $('#organizationTreeGrid').treegrid({
            url : '/organization/treeGrid.action',
            idField : 'id',
            treeField : 'name',
            parentField : 'pid',
            fit : true,
            fitColumns : false,
            border : false,
            frozenColumns : [ [ {
                title : 'id',
                field : 'id',
                width : 40,
                hidden : true
            } ] ],
            columns : [ [ {
                field : 'code',
                title : '编号',
                width : 40
            },{
                field : 'name',
                title : '部门名称',
                width : 180
            }, {
                field : 'seq',
                title : '排序',
                width : 40
            }, {
                field : 'iconCls',
                title : '图标',
                width : 120
            },  {
                width : '130',
                title : '创建时间',
                field : 'createTime'
            },{
                field : 'pid',
                title : '上级资源ID',
                width : 150,
                hidden : true
            }, {
                field : 'address',
                title : '地址',
                width : 120
            } , {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/organization/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="organization-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editOrganizationFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/organization/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="organization-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteOrganizationFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.organization-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.organization-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#orgToolbar'
        });
    });
    function addOrganizationFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 300,
            href : '/static/organization/organizationAdd.jsp',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_treeGrid = organizationTreeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#organizationAddForm');
                    f.submit();
                }
            } ]
        });
    }
//    function editOrganizationFun(id) {
//        if (id != undefined) {
//            organizationTreeGrid.treegrid('select', id);
//        }
//        var node = organizationTreeGrid.treegrid('getSelected');
//        if (node) {
//            parent.$.modalDialog({
//                title : '编辑',
//                width : 500,
//                height : 300,
//                href : '/organization/editPage?id=' + node.id,
//                buttons : [ {
//                    text : '编辑',
//                    handler : function() {
//                        alert(node.id);
//                        parent.$.modalDialog.openner_treeGrid = organizationTreeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
//                        var f = parent.$.modalDialog.handler.find('#organizationEditForm');
//                        f.submit();
//                    }
//                } ]
//            });
//        }
//    }
    
    function deleteOrganizationFun(id) {
        if (id != undefined) {
            organizationTreeGrid.treegrid('select', id);
        }
        var node = organizationTreeGrid.treegrid('getSelected');
        if (node) {
            parent.$.messager.confirm('询问', '您是否要删除当前资源？删除当前资源会连同子资源一起删除!', function(b) {
                if (b) {
                    progressLoad();
                    $.post('${path }/organization/delete', {
                        id : node.id
                    }, function(result) {
                        if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            organizationTreeGrid.treegrid('reload');
                        }else{
                            parent.$.messager.alert('提示', result.msg, 'info');
                        }
                        progressClose();
                    }, 'JSON');
                }
            });
        }
    }
    
    function editOrganizationFun(id) {
        alert(id);
        jQuery.ajax({
            type: "post",   //post提交方式默认是get
            url: "/organization/editPage",
            dataType: "json",
            data: {
                id: id,
            },
            error: function (request) {      // 设置表单提交出错
               alert("出错");
            },
            success: function (data) {


                $("#organizationid").textbox("setValue",id);
                $("#organizationcode").textbox("setValue",data.code);
                $("#organizationname").textbox("setValue",data.name);
                $("#organizationseq").textbox("setValue",data.seq);
                $("#organizationicon").textbox("setValue",data.iconCls);
                $("#organizationaddress").textbox("setValue",data.address);
                $("#organizationAddPid2").textbox("setValue",data.pid);


            }
        });
        $('#organizationAddPid2').combotree({
            url : '/organization/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto'
        });

        $('#organizationAdd2').dialog('open')

    }

    function OrganizationEdit() {

        var nodes=$("#organizationAddPid2").combotree("getValue");
        alert(nodes);



        progressLoad();
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "/organization/edit",
            dataType: "json",
            data: {
                id:$('#organizationid').val(),
                code:$('#organizationcode').val(),
                name:$('#organizationname').val(),
                seq:$('#organizationseq').val(),
                icon:$('#organizationicon').val(),
                address:$('#organizationaddress').val(),
                pid:nodes,


            },
            error: function (request) {      // 设置表单提交出错
                progressClose();
                $.messager.alert(request);  //登录错误提示信息
                $('#organizationAdd').dialog('close')
            },
            success: function (data) {
                progressClose();
                console.log(data)
                parent.$.messager.alert('提示', data.msg, 'info');
                organizationTreeGrid.treegrid('reload');
                $('#organizationAdd2').dialog('close')
            }
        });
    }


</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false"  style="overflow: hidden;">
        <table id="organizationTreeGrid"></table>
    </div>
    <div id="orgToolbar" style="display: none;">
        <shiro:hasPermission name="/organization/add">
            <a onclick="addOrganizationFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
        </shiro:hasPermission>
    </div>

</div>


<div id="organizationAdd2" class="easyui-dialog" title="编辑" data-options="iconCls:'icon-save',closed:true," style="width:285px;height:250px;padding:10px">

    <table>
        <tr align="center" hidden="hidden">
            <td align="center"><span class="w3">id</span>:</td>
            <td align="center"><input name="id" class="easyui-textbox" data-options="required:false" type="text" id="organizationid" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">编号</span>:</td>
            <td align="center"><input name="code" class="easyui-textbox" data-options="required:false" type="text" id="organizationcode" ></input></td>
        </tr>
        <tr align="center">
        <tr align="center">
            <td  align="center"><span class="w2">部门名称</span>:</td>
            <td align="center"><input  name="name" class="easyui-textbox" data-options="required:false" type="text" id="organizationname" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w3">排序</span>:</td>
            <td align="center"><input name="seq" class="easyui-numberspinner" data-options="required:false"  value="0" id="organizationseq" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">菜单图标</span>:</td>
            <td align="center"><input name="icon" class="easyui-textbox" data-options="required:false" type="text" id="organizationicon" ></input></td>
        </tr>
        <tr align="center">
            <td align="center">地址</td>
            <td align="center"><input  name="address" class="easyui-textbox" data-options="required:false"type="text" id="organizationaddress" ></input></td>
        </tr>
        <tr align="center">
            <td align="center"><span class="w2">上级部门</span>:</td>
            <td align="center"><select id="organizationAddPid2" name="pid"   style="width:133px;height: 22px;"></select></td>



        </tr>
        <tr align="center">
            <td align="left"><button class="easyui-linkbutton" iconCls="icon-save"  onclick="OrganizationEdit()" style="width: 90px;text-align:center" id="SLsave">保存</button></td>
            <td align="right"><button class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#organizationAdd2').dialog('close')" style="width: 90px" >取消</button></td>
        </tr>
    </table>

</div>


