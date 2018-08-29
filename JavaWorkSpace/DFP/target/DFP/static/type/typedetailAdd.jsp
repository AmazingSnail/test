<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">

    var user = localStorage.getItem("User");
    $('#inputman').val(user);
    jQuery.ajax({
        type: "POST",   //post提交方式默认是get
        url:'${ctxPath }/typekind/selectKind.action',
        dataType: "json",
        data: {
            typeid:parent.zsjtypedetailId
        },

        error: function (request) {      // 设置表单提交出错
            alert('查询错误');

        },
        success: function (data) {
            $('#kindno').combobox('loadData', data);


        }
    });
    $('#fid').combotree({
        url : '${ctxPath }/typedetail/Tree?typeid='+zsjtypedetailId,
        parentField : 'pid',
        lines : true,
        panelHeight : 'auto'
    });
    $('#fid').combotree('setValue',0);
    $('#typeid').val(parent.zsjtypedetailId);
    $(function() {


        $('#typedetailAddForm').form({
            url : '${ctxPath }/typedetail/add',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                console.log(result);
                if (result.success) {
                    parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为resource.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
//                    parent.indexMenuZTree.reAsyncChildNodes(null, "refresh");
                    parent.typeDetailQuery();
                } else {
                    var form = $('#typedetailAddForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });



    });

</script>
<div style="padding: 3px;">
    <form id="typedetailAddForm" method="post">
        <table class="grid">
            <tr>
                <td>分类代码</td>
                <td><input name="typeno"  id = "typeno" type="text" placeholder="请输入分类代码" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>分类名称</td>
                <td><input name="typename"  id = "typename" type="text" placeholder="请输入分类名称" class="easyui-validatebox span2" data-options="required:true" ></td>
            </tr>
            <tr>
                <td>分类层次</td>
                <td>
                    <select name="kindno" id = "kindno" class="easyui-combobox" data-options="
                     width:140,height:29,editable:false,panelHeight:'auto', panelHeight:'auto',
                            valueField:'kindno',
                            textField:'kindno',
                         ">


                    </select>
                </td>
                <td>冻结</td>
                <td>
                    <select name="islocked"  id = "islocked" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </td>
            </tr>
            <tr align="center" hidden="hidden">
                <td align="center"><input name="inputman" class="easyui-textbox" data-options="required:false" type="text" id="inputman" ></input></td>
                <td align="center"><input name="typeid" class="easyui-textbox" data-options="required:false" type="text" id="typeid" ></input></td>
            </tr>
            <tr>
                <td>上级资源</td>
                <td colspan="3">
                    <select id="fid" name="fid" style="width: 200px; height: 29px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#fid').combotree('clear');" >清空</a>
                </td>

            </tr>


        </table>
    </form>
</div>