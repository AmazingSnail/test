<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/1.5.2/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/1.5.2/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/css/1.5.2/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/css/1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>

</head>
<body style="margin: 1px">
<table id="user_dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/actUser/userPage.action" fit="true" toolbar="#user_tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="80" align="center">用户名</th>
 		<th field="password" width="80" align="center">密码</th>
 		<th field="firstName" width="50" align="center">姓</th>
 		<th field="lastName" width="50" align="center">名</th>
 		<th field="email" width="100" align="center">邮箱</th>
 	</tr>
 </thead>
</table>
<div id="user_tb">
 <div>
	<a href="javascript:openUserAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openUserModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 	&nbsp;用户名&nbsp;<input type="text" id="user_s_id" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
 	<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>

<div id="user_dlg" class="easyui-dialog" style="width: 620px;height: 250px;padding: 10px 20px" closed="true" buttons="#user_dlg-buttons">
 
 	<form id="user_fm" method="post">
 		<table cellpadding="8px">
 			<tr>
				<td>部门：</td>

				<td><select id="user_department" style="width:150px;">


				</select></td>
 				<td>用户名：</td>
 				<td>
					<%--<select type="text" id="user_id" name="id" class="easyui-validatebox" required="true"></select>--%>
					<select  id="user_id" name="id"  style="width:150px;">

					</select>
 				</td>
 				<%--<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>--%>
 				<%--<td>密码：</td>--%>
 				<%--<td>--%>
 					<input type="hidden" id="user_password" name="password" class="easyui-validatebox" required="true"/>
 				<%--</td>--%>
 			</tr>
 			<tr>
 				<td>姓：</td>
 				<td>
 					<input type="text" id="user_firstName" name="firstName" class="easyui-validatebox"  />
 				</td>
 				<%--<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>--%>
 				<td>名：</td>
 				<td>
 					<input type="text" id="user_lastName" name="lastName" class="easyui-validatebox" />
 				</td>
 			</tr>
 			<tr>
 				<td>邮箱：</td>
 				<td colspan="4">
 					<input type="text" style="width: 200px" id="user_email" name="email" class="easyui-validatebox" validType="email" required="true"/>
 					<input type="hidden" id="user_flag" name="flag"/>
 				</td>
 			</tr>
 		</table>
 	</form>
 
</div>

<div id="user_dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
<script type="text/javascript">

    function searchUser(){
        $("#user_dg").datagrid('load',{
            "id":$("#user_s_id").val()
        });
    }
    $("#user_id").change(function(){
        var name = $("#user_id").val();
        $("#user_firstName").val(name.substring(0,1));
        $("#user_lastName").val(name.substring(1));
        $("#user_password").val("11");
	});
    $('#user_department').change(function(){

        var department = $(this).val();
        //ajax异步提交
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"/select.action",
            dataType:"json",
            data:{
                department: department,

            },
//                data:$("#login").val(),   //序列化
            error:function(request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success:function(data) {

                $("#user_id").empty();

                for(var i = 0 ; i<data.rows.length;i++){

                    $("#user_id").append("<option value="+data.rows[i].name+">"+data.rows[i].name+"</option>"); //为Select追加一个Option(下拉项)
                }
            }
        });

    });
    function deleteUser(){
        var selectRows=$("#user_dg").datagrid("getSelections");
        if(selectRows.length==0){
            $.messager.alert("系统提示","请选择要删除的数据！");
            return;
        }
        var strIds=[];
        for(var i=0;i<selectRows.length;i++){
            strIds.push(selectRows[i].id);
        }
        var ids=strIds.join(",");
        $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectRows.length+"</font>条数据吗?",function(r){
            if(r){
                $.post("${pageContext.request.contextPath}/actUser/deleteUser.action",{ids:ids},function(result){
                    if(result.success){
                        $.messager.alert("系统提示","数据已经成功删除！");
                        $("#user_dg").datagrid("reload");
                    }else{
                        $.messager.alert("系统提示","数据删除失败，请联系管理员！");
                    }
                },"json");
            }
        });
    }


    function openUserAddDiglog(){

        $("#user_dlg").dialog("open").dialog("setTitle","添加用户信息");
        $("#user_flag").val(1);
        $("#user_id").attr("readonly",false);
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"/selectDepartment.action",
            dataType:"json",

//                data:$("#login").val(),   //序列化
            error:function(request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success:function(data) {



                $("#user_department").append("<option value=''>请选择部门</option>");
                for(var i = 0 ; i<data.rows.length;i++){

                    $("#user_department").append("<option value="+data.rows[i].department+">"+data.rows[i].department+"</option>"); //为Select追加一个Option(下拉项)
                }
            }
        });
    }

    function openUserModifyDiglog(){
        var selectRows=$("#user_dg").datagrid("getSelections");
        if(selectRows.length!=1){
            $.messager.alert("系统提示","请选择一条要编辑的数据！");
            return;
        }
        var row=selectRows[0];
        $("#user_dlg").dialog("open").dialog("setTitle","编辑用户信息");
        $("#user_fm").form("load",row);
        $("#user_flag").val(2);
        $("#user_id").attr("readonly",true);
    }


    function checkData(){
        if($("#user_id").val()==''){
            $.messager.alert("系统系统","请输入用户名！");
            $("#user_id").focus();
            return;
        }
        var flag=$("#user_flag").val();
        if(flag==1){
            <%--$.post("${pageContext.request.contextPath}/actUser/existUserName.action",{userName:$("#id").val()},function(result){--%>
                <%--if(result.exist){--%>
                    <%--$.messager.alert("系统系统","该用户名已存在，请更换下！");--%>
                    <%--$("#id").focus();--%>
                <%--}else{--%>
                    saveUser();
//                }
//            },"json");
        }else{
            saveUser();
        }
    }

    function saveUser(){
        $("#user_fm").form("submit",{
            url:'/actUser/userSave.action',
            onSubmit:function(){
                return $(this).form("validate");
            },
            success:function(result){
                var result=eval('('+result+')');
                if(result.success){
                    $.messager.alert("系统系统","保存成功！");
                    resetValue();
                    $("#user_dlg").dialog("close");
                    $("#user_dg").datagrid("reload");
                }else{
                    $.messager.alert("系统系统","保存失败！");
                    return;
                }
            }
        });
    }

    function resetValue(){
        $("#user_id").val("");
        $("#user_password").val("");
        $("#user_firstName").val("");
        $("#user_lastName").val("");
        $("#user_email").val("");
    }

    function closeUserDialog(){
        $("#user_dlg").dialog("close");
        resetValue();
    }

</script>
</body>
</html>