<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/1.5.2/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/wu.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPath }/static/css/icon.css" />
    <script type="text/javascript" src="${ctxPath }/static/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/js/jquery.form.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctxPath }/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body class="easyui-layout">
<div class="easyui-layout" data-options="fit:true"  style="width: 100%">
    <div  data-options="region:'center' ,border:false" >
        <!-- Begin of toolbar -->
        <div class="easyui-panel" title="操作栏" >
            <div id="code-wu-toolbar">
                <div class="wu-toolbar-button">




                    <a href="javascript:submit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  plain="true">发送</a>&nbsp;&nbsp;
                    <a id="codeapply_refuse" href="javascript:submit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-no'"   plain="true" >驳回</a>
                </div>
                <div class="wu-toolbar-search" style=" border:solid 1px #CCC;">
                    <table  style="white-space: nowrap; width: 700px;">
                        <tr>
                            <td style="white-space: nowrap; width: 80px;"><label>申请单号：</label> </td>
                            <td style="white-space: nowrap; width: 100px;">
                                <input class="easyui-textbox" data-options="required:false" type="text" id="codeapplbz-applyno" readonly="true" >
                            </td>
                            <td style="white-space: nowrap; width: 20px;"></td>
                            <td style="white-space: nowrap; width: 80px;"><label>申请人：</label> </td>
                            <td style="white-space: nowrap; width: 100px;">
                                <input class="easyui-textbox" data-options="required:false" type="text" id="codeapplbz-inputman" readonly="true" >
                            </td>
                            <td style="white-space: nowrap; width: 80px;"></td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap; width: 80px;"><label>分类代码：</label> </td>
                            <td style="white-space: nowrap; width: 100px;">
                                <%--<input id="codeappl-typeno" class="easyui-searchbox" data-options="prompt:'输入编码类型',searcher:doSearch" ></input>--%>
                                <input class="easyui-textbox" data-options="required:false" type="text" id="codeapplbz-typeno" readonly="true" >
                            </td>
                            <td style="white-space: nowrap; width: 20px;"></td>
                            <td style="white-space: nowrap; width: 80px;"><label>申请时间：</label> </td>
                            <td style="white-space: nowrap; width: 100px;">
                                <input class="easyui-textbox" data-options="required:false" type="text" id="codeapplbz-inputdate" readonly="true" style="background: grey">
                            </td>
                            <td style="white-space: nowrap; width: 80px;"></td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap; width: 80px;"><label>分类名称：</label> </td>
                            <td style="white-space: nowrap; width: 100px;">
                                <input class="easyui-textbox" data-options="required:false" type="text" id="codeapplbz-typename" readonly="true" style="background: grey;">
                            </td>
                            <td style="white-space: nowrap; width: 20px;"></td>
                            <td style="white-space: nowrap; width: 80px;"><label>申请状态：</label> </td>
                            <td style="white-space: nowrap; width: 100px;">
                                <input class="easyui-textbox" data-options="required:false" type="text" id="codeapplbz-state" readonly="true" style="background: grey">
                            </td>

                        </tr>
                        <tr>
                            <td style="white-space: nowrap; width: 80px;">批注：</td>
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

                            </td>
                        </tr>
                    </table>
                </div>
                <div title="编辑" data-options="iconCls:'icon-save',closed:true,"   style="width:400px;height:350px;" class="easyui-dialog " id = "codeeditbz">
                    <div style="width:400px;height:300px;" class="easyui-tabs" id = "tt" >


                    </div>
                    <div>
                        <button class="easyui-linkbutton" iconCls="icon-save" onclick="codeeditbz2()" style="width: 90px;text-align:center" >保存</button>
                        <button class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#codeeditbz').dialog('close')" style="width: 90px" >取消</button>
                    </div>
                </div>
                <div id="typedetail-more" style="position:absolute;z-index: 1001;background-color: white;display: none;border:solid 1px #CCC; height: 100px;">
                </div>
                <div id="caidan" title="彩蛋" hidden="hidden" class="easyui-tabs" style="width:400px;height:300px;">

                </div>
                <table>
                    <tr>
                        <td>
                            <a  id="codeapply_add" style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"   iconCls="icon-add" onclick="AddCodeApply()" plain="true">新建</a>
                        </td>
                        <td>
                            <a id="codeapply_delete" style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"   iconCls="icon-delete" onclick="DeleteCodeApply()" plain="true">删除</a>&nbsp&nbsp
                        </td>
                        <td>
                            <a id="codeapply_edit" style="width:100px "  href="javascript:void(0)"  class="easyui-linkbutton"   iconCls="icon-edit" onclick="EditCodeApply()" plain="true">修改</a>&nbsp&nbsp
                        </td>
                        <td>
                            <a  style="width:100px " href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="$('#bz').window('open')" plain="true">导入</a>&nbsp&nbsp
                        </td>
                        <td>
                            <a  style="width:100px " href="#"  class="easyui-linkbutton" iconCls="icon-help" onclick="javascript:exportexcel()"  runat="server" plain="true">导出</a>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div id="codeapplybz-message" class="easyui-dialog" title="提示信息" data-options="iconCls:'icon-save',closed:true," style="width:700px;height:400px;padding:10px">

            <table title="校验信息" id="codeapplybz-messagegrid"  class="easyui-datagrid"  style="height: 300px;width: 650px" data-options="fitColumns: true,singleSelect:true" >

            </table>
        </div>
        <!-- End of toolbar -->
        <div id="bz" class="easyui-window" title="导入" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:300px;height:200px;padding:10px;">
            <form id="bz-questionTypesManage" method="post" enctype="multipart/form-data" action="/PlanProductController/import">
                <p align="center">选择文件：<input id="bz-uploadExcel" name="bz-uploadExcel"  class="easyui-filebox" style="width:200px" data-options="prompt:'请选择文件...'"></p>
                <input id="bz-plantvalue" name="bz-plantvalue" hidden="hidden">
            </form>　<p align="center">　<a href="#" class="easyui-linkbutton" style="width:122px" onclick="uploadExcel()" >导入</a></p>
        </div>
        <%--<table id="codemanagegrid" class="easyui-treegrid"  data-options="fitColumns: true, idField: 'id',treeField: 'typeno',singleSelect:true" style="height: 100%;width: 100%">--%>
        <table title="主数据创建" id="codeapplygrid"  class="easyui-datagrid"  data-options="
        editor:'text',onClickRow:psd_fromOnClickRow,singleSelect:true,onClickCell:onClickCell" style="height: 45%;width: 99%">
        </table>
        <div style="padding-top: 5px">
            <table id="yyyyy" title="批注列表" class="easyui-datagrid"
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
            $.extend($.fn.datagrid.methods, {
                editCell: function(jq,param){
                    return jq.each(function(){
                        var opts = $(this).datagrid('options');
                        var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
                        for(var i=0; i<fields.length; i++){
                            var col = $(this).datagrid('getColumnOption', fields[i]);
                            col.editor1 = col.editor;
                            if (fields[i] != param.field){
                                col.editor = null;
                            }
                        }
                        $(this).datagrid('beginEdit', param.index);
                        for(var i=0; i<fields.length; i++){
                            var col = $(this).datagrid('getColumnOption', fields[i]);
                            col.editor = col.editor1;
                        }
                    });
                }
            });

            var editIndex = undefined;
            function endEditing(){
                if (editIndex == undefined){return true}
                if ($('#codeapplygrid').datagrid('validateRow', editIndex)){
                    $('#codeapplygrid').datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }

            function psd_fromOnClickRow(index) {
//        $('#codeapplygrid').datagrid('selectRow', index)
//            .datagrid('beginEdit', index);//开启编辑，index为开启编辑的行号
            }

        </script>

    </div>

</div>

<script type="text/javascript">
    var bjattrs;
    var re;
    var itemno ;
    var editrow;
    var editrowindex;
    var codeapplygrid = $('#codeapplygrid');
    var tttttt = 500;
    var applyno;
    var typedetailid;
    var applystate;
    var typeno;
    jQuery.ajax({
        type:"POST",   //post提交方式默认是get
        url:"${ctxPath }/codeappl/getCodeApplByTaskId.action",
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
            $("#codeapplbz-applyno").val(results.applyno);
            applyno = results.applyno;
            typedetailid = results.typedetailid;
            $("#codeapplbz-inputman").val(results.inputman);
            $("#codeapplbz-typename").val(results.typedetail);
            $("#codeapplbz-typeno").val(results.typeno);
            $("#codeapplbz-inputdate").val(results.inputdate);
            $("#codeapplbz-state").val(results.applystate);
            applystate = results.applystate;
            typeno = results.typeno;
            if(applystate=="创建"){
                $("#codeapply_refuse").hide()

            }else{
                $("#codeapply_edit").hide();
                $("#codeapply_add").hide();
                $("#codeapply_delete").hide();
            }
        }
    });
    jQuery.ajax({
        type:"POST",   //post提交方式默认是get
        url:"${ctxPath }/codeappl/getMaxItemno.action",
        dataType:"json",
        async: false,
        data:{
            applyno:applyno,//$('#typename').val(),
        },
        error:function(request) {
            $.messager.progress('close');
            $("#showMsg").html(request);
        },
        success:function(results) {
            itemno =  parseInt(results.itemno)+10+"";
        }
    });
    var FirstColumns=new Array();
    var SecondColumns=new Array();
    var FirstFrozenColumns=new Array();
    var SecondFrozenColumns=new Array();
    FirstColumns.splice(0,FirstColumns.length);
    SecondColumns.splice(0,SecondColumns.length);
    FirstFrozenColumns.splice(0,FirstFrozenColumns.length);
    SecondFrozenColumns.splice(0,SecondFrozenColumns.length);

    jQuery.ajax({
        type:"POST",   //post提交方式默认是get
        url:"${ctxPath }/codeappl/codeApplySTcolumn.action",
        dataType:"json",
        async: false,
        data:{
            typedetailid:typedetailid,//$('#typename').val(),
            applystate:applystate,
            typeno:typeno,
        },
        error:function(request) {
            $.messager.progress('close');
            $("#showMsg").html(request);
        },
        success:function(results) {
            bjattrs = results.bjattrs;
            for(var i=0;i<results.views.length;i++){
                var column={};
                for(var key in results.views[i]){
                    column[key]=results.views[i][key];
                }
                FirstColumns.push(column);
            }

            for(var i=0;i<results.attrDefines.length;i++){
                var column2={};
                for(var key in results.attrDefines[i]){
                    column2[key]=results.attrDefines[i][key];
                }
                SecondColumns.push(column2);
            }
            for(var i=0;i<results.FirstFrozenColumns.length;i++){
                var column={};
                for(var key in results.FirstFrozenColumns[i]){
                    column[key]=results.FirstFrozenColumns[i][key];
                }
                FirstFrozenColumns.push(column);
            }


            for(var i=0;i<results.SecondFrozenColumns.length;i++){
                var column={};
                for(var key in results.SecondFrozenColumns[i]){
                    column[key]=results.SecondFrozenColumns[i][key];
                }
                SecondFrozenColumns.push(column);
            }
        }
    });

    jQuery.ajax({
        type: "POST",   //post提交方式默认是get
        url: "${ctxPath }/codeappl/select.action",
        dataType: "json",
        data: {
            applyno: applyno
        },
//                data:$("#login").val(),   //序列化
        error: function (request) {
            $.messager.progress('close');
            $("#showMsg").html(request);  //登录错误提示信息

        },
        success: function (results) {
            codeapplygrid=$('#codeapplygrid').datagrid({
                data:results,
//                    fit: true, //自动适屏功能
                autoRowWidth: true,
                showFooter:true,
                fitColumns:false,//宽度自适应
                singleSelect:false,
                rownumbers:true,
                width:'auto',
                method:'get',
                checkOnSelect:false,
                selectOnCheck: true,
                remoteSort:false,
                frozenColumns:[ FirstFrozenColumns,SecondFrozenColumns],
                columns: [
                    FirstColumns,
                    SecondColumns
                ]
            });

        }
    })




    jQuery.ajax({
        type: "POST",   //post提交方式默认是get
        url: "${ctxPath }/codeappl/selectkj.action",
        dataType: "json",
        async: false,
        data: {

            typedetailid:typedetailid,
        },
        error: function (request) {      // 设置表单提交出错
            $.messager.progress('close');
            $.messager.alert('信息提示', '出错了！', 'info');
        },
        success: function (results) {
            re = results;
            for(var i = 0;i < results.total;i++)
            {
                var a =  document.getElementById("caidan");
                var div2 = document.createElement("div");
                div2.setAttribute('id', results.views[i].viewcode);
                div2.setAttribute('title', results.views[i].viewname);
                div2.setAttribute('closable', 'false');  //设置文本为只读类型
                a.appendChild(div2);
                var view  =  document.getElementById(results.views[i].viewcode);
                for(var j = 0;j < results.views[i].size;j++){
//                        alert( results.views[i].attrdefines[j].attrdefinename);
                    var attrdefinelablediv = document.createElement("div");
                    view.appendChild(attrdefinelablediv);
                    var attrdefinelable = document.createElement("label");
                    var attrdefinelabletext =document.createTextNode( results.views[i].attrdefines[j].attrdefinename);
                    attrdefinelable.appendChild(attrdefinelabletext);
                    var attrdefinewidgettype = results.views[i].attrdefines[j].widgettype;
                    var attrdefinewidget;
                    if(attrdefinewidgettype == 1){
                        attrdefinewidget  = document.createElement("input");
                        attrdefinewidget.setAttribute("id",results.views[i].viewcode+"_"+results.views[i].attrdefines[j].attrdefino);
                        attrdefinewidget.setAttribute("class","text");
                    }else if(attrdefinewidgettype == 2){
                        attrdefinewidget  = document.createElement("input");
                        attrdefinewidget.setAttribute("id",results.views[i].viewcode+"_"+results.views[i].attrdefines[j].attrdefino);
                        attrdefinewidget.setAttribute("class","easyui-numberspinner");
                    }else if(attrdefinewidgettype == 5){
                        attrdefinewidget  = document.createElement("select");
                        attrdefinewidget.setAttribute("id",results.views[i].viewcode+"_"+results.views[i].attrdefines[j].attrdefino);
                        attrdefinewidget.setAttribute("class","easyui-combobox");
                        attrdefinewidget.setAttribute("data-options","width:135,height:24,editable:false,panelHeight:'auto'");

                        jQuery.ajax({
                            type: "POST",   //post提交方式默认是get
                            url: "${ctxPath }/codeappl/attrdataselect2.action",
                            dataType: "json",
                            async: false,
                            data: {
                                attrDefineno:results.views[i].attrdefines[j].attrdefino,

                            },
                            error: function (request) {      // 设置表单提交出错
                                $.messager.progress('close');
                                $.messager.alert('信息提示', '出错了！', 'info');
                            },
                            success: function (results) {
                                for(var i = 0 ;i<results.length;i++){
                                    var new_opt = new Option(results[i].id2, results[i].id2);
                                    attrdefinewidget.options.add(new_opt);
                                }
                            }
                        })
                    }else if(attrdefinewidgettype == 7){
                        attrdefinewidget  = document.createElement("input");
                        attrdefinewidget.setAttribute("id",results.views[i].viewcode+"_"+results.views[i].attrdefines[j].attrdefino);
                        attrdefinewidget.setAttribute("type","checkbox");

                    }

                    attrdefinelablediv.appendChild(attrdefinelable);
                    attrdefinelablediv.appendChild(attrdefinewidget);

                }
            }


        }
    });



    function onClickCell(index, field){

        if (applystate=="创建"){
            var coltype =  $('#codeapplygrid').datagrid('getColumnOption', field);

            $('#codeapplygrid').datagrid('selectRow', index)
                .datagrid('editCell', {index:index,field:field});
            editIndex = index;
        }
    }

    function DeleteCodeApply(){
        var ids = "";
        var rows  = $('#codeapplygrid').datagrid("getSelections");
        var obj = rows[0];
        var editid = obj.id;
        if(editid!=undefined){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: "${ctxPath }/codeappl/deletecodeappldetail.action",
                dataType: "json",
                async: false,
                data:{
                    id:editid
                },
                error: function (request) {      // 设置表单提交出错
                    $.messager.progress('close');
                    $.messager.alert('信息提示', '出错了！', 'info');
                },
                success: function (results) {


                }
            })
        }
        for(var i=0; i<rows.length; i++){
            var data=rows[i];
            var index=$('#codeapplygrid').datagrid('getRowIndex',data);
            $('#codeapplygrid').datagrid('deleteRow',index);

        }



    }

    function EditCodeApply(){
        editrow  = $('#codeapplygrid').datagrid("getSelections");
        editrowindex =$('#codeapplygrid').datagrid('getRowIndex',editrow);
        $('#codeapplygrid').datagrid('endEdit', editrowindex+1);
        var obj = editrow[0];
        for(var r = 0;r < re.total;r++)
        {
            for(var s = 0;s < re.views[r].size;s++){
                var bbb ="#"+ re.views[r].viewcode+"_"+re.views[r].attrdefines[s].attrdefino+"";
                var yyy = re.views[r].viewcode+"_"+re.views[r].attrdefines[s].attrdefino;
                if(obj[yyy]){
                    if(re.views[r].attrdefines[s].widgettype==7){
                        if(obj[yyy] == "√"){

                            $(bbb).attr("checked",true);
                        }
                    }
                    if(re.views[r].attrdefines[s].widgettype==2){

                        $(bbb).numberbox("setValue",parseInt(obj[yyy]));
                    }
                    if(re.views[r].attrdefines[s].widgettype==5){
                        $(bbb).combobox("setValue",obj[yyy]);

                    }
                    if(re.views[r].attrdefines[s].widgettype==1){
                        $(bbb).val(obj[yyy]);
                    }
                }


            }

        }

        $("#caidan").dialog({

            buttons : [
                {
                    text : '确定',
                    iconCls: "icon-save",
                    handler : function() {

                        codeapplyedit();
                        $('#caidan').dialog('close');

                    }
                },
                {
                    text: "取消",
                    iconCls: "icon-redo",
                    handler:function(){
                        $('#caidan').dialog('close');


                    }
                }
            ]
        })







    }
    function codeapplyedit() {
        var obj = editrow[0];
        var editid = obj.id;


        var rows  =  codeapplygrid.datagrid("getSelections");
        for(var i=0; i<rows.length; i++){
            var data=rows[i];
            var index= codeapplygrid.datagrid('getRowIndex',data);
            codeapplygrid.datagrid('selectRow', parent.editrowindex+1)
                .datagrid('beginEdit',index);

            var str1='{"codeno":"",'+'"codename":"",'+'"itemno":'+obj['itemno']+','+'"id":'+obj['id']+',';

            for(var r = 0;r < re.total;r++)
            {
                for(var s = 0;s < re.views[r].size;s++){
                    var bbb ="#"+ re.views[r].viewcode+"_"+re.views[r].attrdefines[s].attrdefino+"";
                    var yyy = re.views[r].viewcode+"_"+re.views[r].attrdefines[s].attrdefino;
                    if(re.views[r].attrdefines[s].widgettype==7){
                        if($(bbb).attr("checked")){
                            str1=str1+'"'+yyy+'":"'+"√"+'",';

                        }else{
                            str1=str1+'"'+yyy+'":"'+""+'",';
                        }
                    }else {
                        str1=str1+'"'+yyy+'":"'+$(bbb).val()+'",';
                    }


                }

            }


            str1 = str1.substr(0,str1.length-1);
            str1=str1+'}';

            var ob = eval('(' + str1 + ')');
            codeapplygrid.datagrid('updateRow',{
                index: index,
                row: ob
            });
            codeapplygrid.datagrid('endEdit', index);

        }
        if(editid!=""){

            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: "${ctxPath }/codeappl/editcodeappldetail.action",
                dataType: "json",
                async: false,
                data:ob,
                error: function (request) {      // 设置表单提交出错
                    $.messager.progress('close');
                    $.messager.alert('信息提示', '出错了！', 'info');
                },
                success: function (results) {


                }
            })
        }


    }
    function submit(state){

        var rows = $('#codeapplygrid').datagrid('getRows');
        for(var i=0; i<rows.length; i++){
            var data=rows[i];
            var index=$('#codeapplygrid').datagrid('getRowIndex',data);
            var flag = $('#codeapplygrid').datagrid('validateRow', index);
            if(!flag){
                $.messager.alert('提示', '请输入完整数据!');
                return false;
            }
            $('#codeapplygrid').datagrid('endEdit', index);


        }
        var entities = "";
        for(i = 0;i < rows.length;i++)
        {
            entities = entities  + JSON.stringify(rows[i])+"、";
        }
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${ctxPath }/codeappl/pass.action",
            dataType:"json",
            data:{
                state:state,
                comment:$("#exp_comment").val(),
                UserId:localStorage.getItem("User"),
                GroupId:localStorage.getItem("actGroup"),
                taskId:${param.taskId},
                entities: entities,
                typeno:typeno,
                applyno:applyno,
                bjattrs: bjattrs,
                applystate:applystate
            },

            error:function(request) {

                $("#showMsg").html(request);  //登录错误提示信息

            },
            success:function(results) {
                if(results.success){
                    $.messager.alert("系统系统","提交成功！");
                    window.parent.closeTab("办理任务");
                    window.parent.query();

                }else{
                    if(results.mess!=undefined){
                        $('#codeapplybz-message').dialog('open');
                        $('#codeapplybz-messagegrid').datagrid({
                            data:results.mess,
                            fit: false, //自动适屏功能
                            autoRowWidth: true,
                            showFooter:true,
                            fitColumns:true,//宽度自适应
                            singleSelect:true,
                            rownumbers:true,
                            width:'auto',
                            method:'get',
                            columns: [[
                                {field:'ZOBJE',title:'物料编码',width:'200px'},
                                {field:'ZISOK',title:'传输状态',width:'100px',halign: 'center'},
                                {field:'ZMESS',title:'信息',width:'350px',halign: 'center'},
                            ]],

                        });
                    }else {
                        $.messager.alert("系统系统",results.message);

                    }

                }

            }
        });
    }


    function AddCodeApply(){
        var data=$('#codeapplygrid').datagrid('getData');
        var totalNum=data.total;
        var str1='{"id":'+'"undefined"'+','+'"itemno":'+itemno+',';
        for(var i=2;i<SecondColumns.length;i++){
            str1=str1+'"'+SecondColumns[i]['field']+'":"",';
        }
        str1 = str1.substr(0,str1.length-1);
        str1=str1+'}';
        var obj = eval('(' + str1 + ')');
        $('#codeapplygrid').datagrid('appendRow',obj);
        itemno = parseInt(itemno)+10+"";

    }











    function getRowIndex(target){
        var tr = $(target).closest('tr.datagrid-row');

        return parseInt(tr.attr('datagrid-row-index'));
    }


    function codeManageDelete() {
        var ids = "";
        var rows  = $('#codemanagegrid').datagrid("getSelections");
        for(var i=0; i<rows.length; i++){
            ids = ids + rows[i].id+",";
        }
        if(ids==''){
            $.messager.alert('提示', '请选择删除数据!');
        }else{
            jQuery.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${ctxPath }/codemanage/codeManageDelete.action",
                dataType:"json",
                data:{
                    ids:ids
                },
                error:function(request) {
                    $.messager.alert('提示', '删除数据失败!');
                },
                success:function(results) {
                    if (results.num > 0) {
                        $.messager.alert('提示', '删除成功!');
                        codeManageDetail();
                    }else{
                        $.messager.alert('提示', '删除失败!');
                    }
                }
            });
        }
    }


</script>
</body>



</html>



