<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办任务管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/1.5.2/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/1.5.2/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/css/1.5.2/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/css/1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>

</head>
<body style="margin: 1px">

<table id="dg" title="待办任务管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
   fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="100" align="center">任务ID</th>
 		<th field="name" width="100" align="center">任务名称</th>
 		<th field="createTime" width="100" align="center">创建时间</th>
 		<th field="action" width="100" align="center" formatter="formatAction">操作</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
 	&nbsp;任务名称&nbsp;<input type="text"  class="easyui-textbox" id="s_name" size="20" onkeydown="if(event.keyCode==13) searchTask()"/>
 	<a href="javascript:searchTask()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
<script type="text/javascript">
    var url;
	$(function () {
		$("#dg").datagrid(
		    {url:"${pageContext.request.contextPath}/task/taskPage.action",
            queryParams:{userId:localStorage.getItem("actGroup") }})
    });
    function searchTask(){

        $("#dg").datagrid('load',{
            "s_name":$("#s_name").val(),
            "userId":localStorage.getItem("actGroup")
        });
    }
    function formatAction(val,row){
        return "<a href='javascript:openFinishTaskTab("+row.id+")'>办理任务</a>&nbsp;<a target='_blank' href='${pageContext.request.contextPath}/task/showCurrentView.action?taskId="+row.id+"&"+row.name+"'>查看当前流程图</a>"
    }

    function openFinishTaskTab(taskId){
        $.post("${pageContext.request.contextPath}/task/redirectPage.action",{taskId:taskId},function(result){
            window.parent.openTab('办理任务',result.url+"?taskId="+taskId,'icon-check');
        },"json");
    }

</script>
</body>
</html>