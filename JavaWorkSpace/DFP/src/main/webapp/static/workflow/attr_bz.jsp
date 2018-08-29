<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>项目组长审批</title>
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/1.5.2/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/1.5.2/themes/icon.css">
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.min.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>

</head>
<body style="margin: 5px">
<div id="p" class="easyui-panel" title="审批" style="width: 700px;height: 280px;padding: 10px">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>主数据扩展单号：</td>
                <td>
                    <input type="text" id="exp_applyno" name="exp_applyno" readonly="readonly"/>
                </td>
                <td>&nbsp;</td>
                <td>扩展类型：</td>
                <td>
                    <input type="text" id="exp_applytype" name="exp_applytype" readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td>请托人：</td>
                <td>
                    <input type="text" id="exp_inputman" name="exp_inputman" readonly="readonly"/>
                </td>
                <td>&nbsp;</td>
                <td>请托时间：</td>
                <td>
                    <input type="text" id="exp_inputdate" name="exp_inputdate" readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td valign="top">扩展原因：</td>
                <td colspan="4">
                    <textarea id="exp_applyreasons" name="exp_applyreasons" rows="2" cols="49" readonly="readonly"></textarea>
                </td>
            </tr>
            <tr>
                <td valign="top">批注：</td>
                <td colspan="4">
                    <textarea id="exp_comment" name="exp_comment" rows="2" cols="49" class="easyui-validatebox" required="true"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="hidden" name="taskId" value="${param.taskId}"/>
                </td>
                <td>
                    <input type="hidden" name="UserId" id="UserId" />
                </td>
                <td>
                    <input type="hidden" name="GroupId" id="GroupId" />
                </td>
                <td colspan="4">
                    <a href="javascript:submit(1)" class="easyui-linkbutton" iconCls="icon-ok" >批准</a>&nbsp;&nbsp;
                    <a href="javascript:submit(2)" class="easyui-linkbutton" iconCls="icon-no" >驳回</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<div style="padding-top: 5px">
    <table id="dg" title="批注列表" class="easyui-datagrid"
           fitColumns="true"
           url="${ctxPath }/task/listHistoryComment.action?taskId=${param.taskId}" style="width: 700px;height: 200px;">
        <thead>
        <tr>
            <th field="time" width="120" align="center">批注时间</th>
            <th field="userId" width="100" align="center">批注人</th>
            <th field="message" width="200" align="center">批注信息</th>
        </tr>
        </thead>
    </table>
</div>
<script type="text/javascript">
    $(function () {
        $("#GroupId").val(localStorage.getItem("actGroup"));
        $("#UserId").val(localStorage.getItem("User"));
    });
    function submit(state){
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"/attrappl/pass.action",
            dataType:"json",
            data:{
                state:1,
                comment:$("#exp_comment").val(),
                UserId:localStorage.getItem("User"),
                GroupId:localStorage.getItem("actGroup"),
                taskId:${param.taskId}

            },

            error:function(request) {

                $("#showMsg").html(request);  //登录错误提示信息

            },
            success:function(results) {
                console.log(results);
//                var result=eval('('+results+')');
                if(results.success){
                    $.messager.alert("提示","提交成功！");
                    window.parent.closeTab("办理任务");
                    window.parent.query();

                }else{
                    $.messager.alert("系统系统","提交失败，请联系管理员！");
                    return;
                }

            }
        });


        <%--$("#fm").form("submit",{--%>
        <%--url:'${ctxPath }/expApply/pass.action?state='+state,--%>
        <%--onSubmit:function(){--%>
        <%--return $(this).form("validate");--%>
        <%--},--%>
        <%--success:function(result){--%>
        <%--var result=eval('('+result+')');--%>
        <%--if(result.success){--%>
        <%--//$.messager.alert("系统系统","提交成功！");--%>
        <%--window.parent.closeTab("办理任务");--%>

        <%--}else{--%>
        <%--$.messager.alert("系统系统","提交失败，请联系管理员！");--%>
        <%--return;--%>
        <%--}--%>

        <%--}--%>
        <%--});--%>
    }
    $(function(){
        $.post("${ctxPath }/attrappl/getAttrApplByTaskId.action",{taskId:'${param.taskId}'},function(result){
            console.log(result);
            $("#exp_applyno").val(result.applyno);
            $("#exp_applytype").val(result.applytype);
            $("#exp_inputman").val(result.inputman);
            $("#exp_inputdate").val(result.inputdate);
            $("#exp_applyreasons").val(result.applyreasons);

        },"json");
    });
</script>
</body>
</html>