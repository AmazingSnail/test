<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/1.5.2/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/wu.css" />
<link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/icon.css" />
<script type="text/javascript" src="${ctxPath }/static/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctxPath }/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctxPath }/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>
<head runat="server">

</head>
<script src="${ctxPath }/static/js/jquery.table2excel.js"></script>
<div class="easyui-layout" data-options="fit:true"  style="width: 100%">
    <div  data-options="region:'center' ,border:false" >
        <!-- Begin of toolbar -->
        <div class="easyui-panel" title="操作栏" >
            <div id="wu-toolbar">
                <div class="wu-toolbar-button">


                    <a href="javascript:submit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  plain="true">发送</a>&nbsp;&nbsp;
                    <a id="attrappl_refuse" href="javascript:submit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-no'"   plain="true" >驳回</a>



                </div>
                <div class="wu-toolbar-search">
                    <table  style="white-space: nowrap; width: 700px;">
                        <tr>
                            <td style="white-space: nowrap; width: 80px;">
                                <label>申请单号：</label>
                            </td>
                            <td>
                                <input id="attrapplbz_applyno" name="attrapplbz_applyno" type="text" disabled = true style="width:100px"></input>
                            </td>
                            <td style="white-space: nowrap; width: 80px;">
                                <label>扩充类型：</label>
                            </td>
                            <td>
                                <input id="attrapplbz_applytype" name="attrapplbz_applytype" type="text" disabled = true style="width:100px"></input>
                            </td>
                        </tr>
                        <tr>

                            <td style="white-space: nowrap; width: 80px;">
                                <label>申请人：</label>
                            </td>
                            <td>
                                <input id="attrapplbz_inputman" name="attrapplbz_inputman" type="text" disabled = true style="width:100px"></input>
                            </td>
                            <td style="white-space: nowrap; width: 80px;">
                                <label>申请时间：</label>
                            </td>
                            <td>
                                <input id="attrapplbz_inputdate" name="attrapplbz_inputdate" type="text" disabled = true  style="width:100px"></input>
                            </td>
                        </tr>
                        <tr>

                            <td style="white-space: nowrap; width: 80px;">
                                <label>属性名称：</label>
                            </td>
                            <td>


                                <input  id="attrapplbz_attrname" name="attrapplbz_attrname" type="text" disabled = true style="width:100px"></input>

                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap; width: 80px;">
                                <label>申请说明：</label>
                            </td>
                            <td>
                                <textarea id="attrapplbz_applyreasons" name="attrapplbz_applyreasons" style="height:40px;width:400px"></textarea>
                            </td>


                        </tr>
                        <tr>
                            <td style="white-space: nowrap; width: 80px;">批注：</td>
                            <td colspan="4">
                                <textarea id="exp_comment" style="height:40px;width:400px"  name="exp_comment" rows="2" cols="49" class="easyui-validatebox" required="true"></textarea>
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

                        </tr>
                    </table>

                </div>

                <div id="typedetail-more" style="position:absolute;z-index: 1001;background-color: white;display: none;border:solid 1px #CCC; height: 100px;">

                </div>

            </div>
            <a  id="attrappl_edit" style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"  onclick="Edit()" data-options="iconCls:'icon-edit'">编辑</a>
            <a  id="attrappl_save" style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"  onclick="Save()" data-options="iconCls:'icon-cancel'">保存</a>
        </div>
        <%--<a  style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"   iconCls="icon-add" onclick="Addattrappl()" plain="true">新建</a>&nbsp&nbsp--%>
        <%--<a  style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"   iconCls="icon-delete" onclick="Delete()" plain="true">删除</a>&nbsp&nbsp--%>
        <%--<a  style="width:100px " href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="$('#bz').window('open')" plain="true">导入</a>&nbsp&nbsp--%>
        <%--<a  style="width:100px " href="#"  class="easyui-linkbutton" iconCls="icon-help" onclick="javascript:exportexcel()"  runat="server" plain="true">导出</a>--%>
        <!-- End of toolbar -->
        <table title="属性申请" id="attrapplbz-datagrid"  class="easyui-datagrid"  data-options="onClickRow: dgappend,editor:'text',singleSelect:true" style="height: 50%;width: 99%">

        </table>
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
        <form id="form1" style="height: 84%;width: 99%;display:none" runat="server"><table id="attrapplbz-datagridl"  style="height: 84%;width: 99%;display:none">

        </table></form>

        <div id="bz" class="easyui-window" title="导入" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:300px;height:200px;padding:10px;">
            <form id="bz-questionTypesManage" method="post" enctype="multipart/form-data" action="/PlanProductController/import">
                <p align="center">选择文件：<input id="bz-uploadExcel" name="bz-uploadExcel"  class="easyui-filebox" style="width:200px" data-options="prompt:'请选择文件...'"></p>
                <input id="bz-plantvalue" name="bz-plantvalue" hidden="hidden">
            </form>　<p align="center">　<a href="#" class="easyui-linkbutton" style="width:122px" onclick="uploadExcel()" >导入</a></p>

        </div>
    </div>

</div>

<script type="text/javascript">
    var applyno;
    var attrid;
    var applystate;

    var unitJSON = [{
        "name" : "新建",
        "value" : 0,

    }, {
        "name" : "修改",
        "value" : 1 ,


    }
    ];
    function unitFormatter(value, rowData, rowIndex) {
        for (var i = 0; i < unitJSON.length; i++) {
            if (unitJSON[i].value == value) {
                return unitJSON[i].name;
            }
        }
        return value;
    }

    jQuery.ajax({
        type:"POST",   //post提交方式默认是get
        url:"${ctxPath }/attrappl/getAttrApplByTaskId.action",
        dataType:"json",
        async: false,
        data:{
            taskId:'${param.taskId}',//$('#typename').val(),
        },
        error:function(request) {
            $.messager.progress('close');
            $("#showMsg").html(request);
        },
        success:function(results) {
            $("#attrapplbz_applyno").val(results.applyno);
            applyno = results.applyno;
            attrid = results.attrid;
            $("#attrapplbz_inputman").val(results.inputman);
            $("#attrapplbz_applytype").val(results.applytype);
            $("#attrapplbz_inputdate").val(results.inputdate);
            $("#attrapplbz-state").val(results.applystate);
            $("#attrapplbz_applyreasons").val(results.reason);
            $("#attrapplbz_attrname").val(results.attrname);

            applystate = results.applystate;
            if(applystate=="开始审核"){
                $("#attrappl_refuse").hide()

            }else{
                $("#attrappl_edit").hide()
                $("#attrappl_save").hide()
            }
        }
    });


    jQuery.ajax({
        type:"POST",   //post提交方式默认是get
        url:"${ctxPath }/attrappl/selectDetail.action",
        dataType:"json",

        data:{
            applyno:applyno


        },
//                data:$("#login").val(),   //序列化
        error:function(request) {
            $.messager.progress('close');
            $("#showMsg").html(request);  //登录错误提示信息

        },
        success:function(results) {

            $.messager.progress('close');
            var IsCheckFlag = true;

            $('#attrapplbz-datagrid').datagrid({
                data:results,
                fit: false, //自动适屏功能
                autoRowWidth: true,
                showFooter:true,
                fitColumns:true,//宽度自适应
                singleSelect:false,
                rownumbers:true,
                width:'auto',
                method:'get',
                checkOnSelect:false,
                selectOnCheck: true,
                columns: [[
                    {field:'id',width:'4%',title:'编号',halign: 'center', sortable: true,checkbox: true},
                    {field:'Fattrid',title:'父属性id',width:'4%',halign: 'center', hidden : true},
                    {field:'itemno',title:'行号',halign: 'center',width:'4%'},
                    {field:'rowtype',title:'修改类型',width:'4%',formatter : unitFormatter,editor : {
                        type : "combobox",
                        options : {
                            data : unitJSON, /* unitJSON是JSON格式的对象数组 */
                            valueField : "value",/* value是unitJSON对象的属性名 */
                            textField : "name"/* name是unitJSON对象的属性名 */
                        }
                    }

                    },
                    {field:'fattrname',title:'父属性名称',halign: 'center',width:'12%'},
                    {field:'fattrno',title:'父属性编码',halign: 'center',width:'12%'},
                    {field:'attrname',title:'子属性名称',halign: 'center',width:'12%',editor:'text'},
                    {field:'attrno',title:'子属性编码',halign: 'center',width:'12%',editor:'text'},
                    {field:'Mattrname',title:'修改属性名称',halign: 'center',width:'12%',editor:'text'},
                    {field:'Mattrno',title:'修改属性编码',halign: 'center',width:'12%',editor:'text'},
                    {field:'inputman',title:'创建人',width:'12%',halign: 'center', hidden : true},
                    {field:'inputdate',title:'创建时间',width:'12%',halign: 'center', hidden : true},
                    {field:'modifyman',title:'修改人',width:'12%',halign: 'center', hidden : true},
                    {field:'modifydate',title:'修改时间',width:'12%',halign: 'center', hidden : true},
                    {field:'iscode',title:'参与编码',width:'6%',halign: 'center',align:'center',editor : {
                        type : "checkbox",
                        options:{
                            on: "是",
                            off: "否"
                        }

                    },
                        formatter: function(value) {
                            if (value == "是") {
                                return "√";
                            } else {
                                return "";
                            }
                        },
                    },
                    {field:'isrelate',title:'层级关联',width:'6%',halign: 'center',align:'center',editor : {
                        type : "checkbox",
                        options:{
                            on: "是",
                            off: "否"
                        }

                    },
                        formatter: function(value) {
                            if (value == "是") {
                                return "√";
                            } else {
                                return "";
                            }
                        },

                    },
                    {field:'islocked',title:'冻结',width:'6%',halign: 'center',align:'center',editor : {
                        type : "checkbox",
                        options:{
                            on: "是",
                            off: "否"
                        }
                    },
                        formatter: function(value) {
                            if (value == "是") {
                                return "√";
                            } else {
                                return "";
                            }
                        },

                    },
                ]],


            });



        }
    });

    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var ydIndex = undefined;
    var flag = false;
    function dgappend(index) {
        var row  = $('#attrapplbz-datagrid').datagrid("getSelected");


    }

    function Edit(){
        var rows = $('#attrapplbz-datagrid').datagrid('getSelections');
        for(var i=0;i<rows.length;i++){
            var row=rows[i];

            var index=$('#attrapplbz-datagrid').datagrid('getRowIndex',row);
            $('#attrapplbz-datagrid').datagrid('beginEdit',index);
        }

    }

    function Save(){
        $.messager.confirm('询问', '确定保存分类?', function(b) {
            if(b){
                var rows = $('#attrapplbz-datagrid').datagrid('getSelections');
                for(var i=0;i<rows.length;i++){
                    var row=rows[i];

                    var index=$('#attrapplbz-datagrid').datagrid('getRowIndex',row);
                    $('#attrapplbz-datagrid').datagrid('endEdit',index);
                    jQuery.ajax({
                        type:"POST",   //post提交方式默认是get
                        url:"${ctxPath }/attrappl/edit.action",
                        dataType:"json",
                        async: false,
                        data:{
                            itemno:row.itemno,
                            rowtype:row.rowtype,
                            fattrname:row.fattrname,
                            fattrno:row.fattrno,
                            attrname:row.attrname,
                            attrno:row.attrno,
                            Mattrname:row.Mattrname,
                            Mattrno:row.Mattrno,
                            iscode:row.iscode,
                            isrelate:row.isrelate,
                            islocked:row.islocked,
                            Fattrid:row.Fattrid,
                            id :row.id

                        },

                        error:function(request) {

                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success:function(results) {

                        }
                    });
                }

            }
        })



    }
    function endEditing(){

        if (editIndex == undefined){return true}
        if ($('#attrapplbz-datagrid').datagrid('validateRow', editIndex)){
            $('#attrapplbz-datagrid').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }

    function submit(state){
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${ctxPath }/attrappl/pass.action",
            dataType:"json",
            data:{
                state:state,
                comment:$("#exp_comment").val(),
                UserId:localStorage.getItem("User"),
                GroupId:localStorage.getItem("actGroup"),
                taskId:${param.taskId}

            },

            error:function(request) {

                $("#showMsg").html(request);  //登录错误提示信息

            },
            success:function(results) {
                if(results.success){
                    $.messager.alert("系统提示","提交成功！");
                    window.parent.closeTab("办理任务");
                    window.parent.query();

                }else{
                    $.messager.alert("系统系统","提交失败，请联系管理员！");
                    return;
                }

            }
        });



    }

    function rollBackWorkFlow(){
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${ctxPath }/attrappl/rollBackWorkFlow.action",
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
    }
    function getRowIndex(target){
        var tr = $(target).closest('tr.datagrid-row');

        return parseInt(tr.attr('datagrid-row-index'));
    }
    function editrow(target){
        if(aaaaa()){
            var i =getRowIndex(target);
            var aa = $(target).closest('tr.datagrid-row').find("input[name=id]");
            aa.attr("checked", true);
            var row = $('#attrapplbz-datagrid').datagrid('getRows')[i];
            $('#attrapplbz-datagrid').datagrid('beginEdit',i);
            $('.editcls').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
            $('.cancel').linkbutton({text:'取消编辑',plain:true,iconCls:'icon-cancel'});
            $('.savecls').linkbutton({text:'保存',plain:true,iconCls:'icon-save'});
            editIndex = i;
            ydIndex = i;
            flag = true;
        }else{
            $.messager.alert('温馨提示', '存在未编辑完数据!');
        }
    }



    function uploadExcel(){
        //得到上传文件的全路径
        var fileName= $('#bz-uploadExcel').filebox('getValue');
        //进行基本校验
        if(fileName==""){
            $.messager.alert('提示','请选择上传文件！','info');
        }else{
            //对文件格式进行校验
            var d1=/\.[^\.]+$/.exec(fileName);
            if(d1==".xls"||d1==".xlsx"){

                $("#plantvalue").val($('#Plant').combobox('getText'));
                document.getElementById("questionTypesManage").submit();
                return false;

            }else{
                $.messager.alert('提示','请选择xls格式文件！','info');
                $('#bz-uploadExcel').filebox('setValue','');
            }
        }


    }
    function exportexcel(){
        $("#attrapplbz-datagridl").table2excel({
            // 不被导出的表格行的CSS class类
            exclude: ".noExl",
            // 导出的Excel文档的名称，（没看到作用）
            name: "Excel Document Name",
            // Excel文件的名称
            filename: "包装入库"
        });
    }
</script>
