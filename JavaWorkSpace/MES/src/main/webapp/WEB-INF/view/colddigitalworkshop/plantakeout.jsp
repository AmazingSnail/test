<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .A{
        width:50%;
        height:75%;
    }
    .B{
        width: 10%;
        height: 75%;
    }
    .C{
        width:50%;
        height:75%;
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 78px);
    }
    .divmore{
        margin-left: -5px;
        padding: 10px 10px 10px 10px;
        /*border: 1px solid red;*/
        border-right: 1px solid #E0EEEE;
        border-bottom: 1px solid #E0EEEE;
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <div class="easyui-panel" title="计划发出" data-options="fit:true">
            <div id="pto_toolbar" style="overflow:auto;width:100%;height: 78px">
                <div class="wu-toolbar-button">
                    <%--<shiro:hasPermission name="/KCard/Print">--%>
                        <%--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="Print()" plain="true">打印</a>--%>
                    <%--</shiro:hasPermission>--%>
                    <span>丨</span>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>--%>
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <div>
                        <label>物料编码：</label><input id="pto_fno" class="easyui-textbox" style="width:100px" onkeypress="pto_getKey()">&nbsp
                        <label>物料描述：</label><input id="pto_fname" class="easyui-textbox" style="width:100px" onkeypress="pto_getKey()">&nbsp
                        <a href="#" class="easyui-linkbutton"  onclick="pto_forGetDate()" data-options="iconCls:'icon-search'">库存查询</a>
                        <a href="#" class="easyui-linkbutton"  onclick="pto_showMore()" data-options="iconCls:'icon-search'">更多</a>
                    </div>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white;display: none" id="pto_More">
                        <div>
                        </div>
                        <div style="margin-top: 5px">
                            <%--<label class="labelstyle"><input type="radio" name="MDMKCardCheck" value="1" />全部查询</label>--%>
                            <%--<label class="labelstyle"><input type="radio" name="MDMKCardCheck" value="2" />排除开卡完成</label>--%>
                            <%--<label class="labelstyle"><input type="radio" name="MDMKCardCheck" value="3" />排除串装完成</label>--%>
                            <%--<label class="labelstyle"><input type="radio" name="MDMKCardCheck" value="4" />排除入库完成</label>--%>
                        </div>
                    </div>
                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <iframe id="proxy" hidden style="display: none;"></iframe>
            <div class="easyui-layout haorooms"  >
                <div class="A" data-options="region:'west',split:true" >
                    <div id="pto_cc" class="easyui-layout" data-options="fit:true" style="width:100%;height:auto">
                        <div style="width: 100%;height:43%" data-options="region:'center'">
                            <table id="pto_storegrid" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="库存信息" data-options="singleSelect:true,onClickRow:pto_OnClickRow"></table>
                        </div>
                        <div style="height: 35%" title="库位库存" data-options="region:'south',split:false" class="easyui-panel" >
                            <table id="pto_storegridLocation" class="easyui-datagrid" style="white-space: nowrap;height: 100%" data-options="singleSelect:true"></table>
                        </div>
                    </div>
                </div>

                <div class="B" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
<shiro:hasPermission name="/pto/out">
                            <button id="pto_out" onclick="pto_out()"  class="easyui-linkbutton" style="margin-top: 100px">出库>></button>
</shiro:hasPermission>
                    </div>
                    <div style="">
<shiro:hasPermission name="/pto/back">
                            <button id="pto_back" class="easyui-linkbutton" onclick="pto_back()">退回<<</button>
</shiro:hasPermission>
                    </div>
                </div>
                <div class="C"  data-options="region:'east',split:true">
                    <table class="easyui-datagrid" id="pto_outgrid" title="本日出库信息" style="white-space: nowrap;height: 100%" toolbar="#pto_tb" data-options="singleSelect:true,onClickRow:onClickRow2,editor:'text'" ></table>
                </div>
                <div id="pto_SapOutDivZ03" class="easyui-dialog" title="移动物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:270px;height:300px;padding:10px">
                    <from id="fm1" method="post">
                        <table cellpadding="5" width="auto" style="white-space:nowrap" >
                            <td>
                                <%--<tr>--%>
                                <%--<td>移动物料:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z03FormFno" id="pto_Z03FormFno" disabled= "true"  style="width:150px" ></input></td>--%>
                                <%--</tr>--%>
                                <%--<tr>--%>
                                <%--<td>移动数量:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z03FormTakeNumber" id="pto_Z03FormTakeNumber" disabled= "true"  style="width:150px" ></input></td>--%>
                                <%--</tr>--%>
                                <tr>
                                    <td>采购订单:</td>
                                    <td><input class="easyui-textbox" type="text" name="Z03FormPoNo" id="pto_Z03FormPoNo"    style="width:150px" ></input></td>
                                </tr>
                                <tr>
                                    <td>行项目:</td>
                                    <td><input class="easyui-textbox" type="text" name="Z03FormPoitem" id="pto_Z03FormPoitem"  style="width:150px"  ></input></td>
                                </tr>
                                <%--<tr>--%>
                                <%--<td>出库地点:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z003FormLgort" id="pto_Z003FormLgort" disabled= "true" style="width:150px"  ></input></td>--%>
                                <%--</tr>--%>
                                <tr>
                                    <td>交货单:</td>
                                    <td><input class="easyui-textbox" type="text" name="Z003FormJiaoHuo" id="pto_Z003FormJiaoHuo" disabled= "true" style="width:150px"  ></input></td>
                                </tr>
                                <%--<tr>--%>
                                <%--<td>交货单行项目:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z003FormJiaoHuoItem" id="pto_Z003FormJiaoHuoItem" disabled= "true" style="width:150px"  ></input></td>--%>
                                <%--</tr>--%>

                                <table>
                                    <tr >
                                        <td><a class="easyui-linkbutton" type="text" style="width: 75px" name="Move" onclick="pto_Z03FormCreate()" id="pto_Z03FormCreate" data-options="iconCls:'icon-save'" >创建</a></td>
                                        <td><a class="easyui-linkbutton" type="text" style="width: 75px" name="Move" onclick="pto_Z03FormSave()" id="pto_Z03FormSave" data-options="iconCls:'icon-save'" >过账</a></td>

                                        <td><a class="easyui-linkbutton" type="text" style="width: 75px" name="Save" onclick="pto_Z03FormBack()" id="pto_Z03FormBack" data-options="iconCls:'icon-save'" >取消</a></td>

                                    </tr>
                                </table>
                            </td>
                        </table>
                    </from>
                </div>
                <div id="pto_SapOutBack" class="easyui-dialog" title="移动物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:240px;height:250px;padding:10px">
                    <from id="fm2" method="post">
                        <table cellpadding="5" width="auto" style="white-space:nowrap" >
                            <td>
                                <tr>
                                    <td>移动物料:</td>
                                    <td><input class="easyui-textbox" type="text" name="FormFno" id="pto_FormFno" disabled= "true"  style="width:150px" ></input></td>
                                </tr>
                                <tr>
                                    <td>移动数量:</td>
                                    <td><input class="easyui-textbox" type="text" name="FormTakeNumber" id="pto_FormTakeNumber" disabled= "true"  style="width:150px" ></input></td>
                                </tr>
                                <tr>
                                    <td>发货地点:</td>
                                    <td><input class="easyui-textbox" type="text" name="FormOutPlace" id="pto_FormOutPlace"  disabled= "true"  style="width:150px" ></input></td>
                                </tr>
                                <tr>
                                    <td>收货地点:</td>
                                    <td><input class="easyui-textbox" type="text" name="FormTakePlace" id="pto_FormTakePlace" disabled= "true" style="width:150px"  ></input></td>
                                </tr>
                                <tr>
                                    <td>移动类型:</td>
                                    <td><input class="easyui-textbox" type="text" name="FormMoveType" id="pto_FormMoveType" disabled= "true" style="width:150px"  ></input></td>
                                    <input class="easyui-textbox" type="hidden" name="FormMoveTypeReal" id="pto_FormMoveTypeReal" disabled= "true"  ></input>
                                </tr>


                                <table>
                                    <tr >
                                        <td><a class="easyui-linkbutton" type="text" style="width: 100px" name="Move" onclick="pto_FormMove()" id="pto_FormMove" data-options="iconCls:'icon-save'" >移库</a></td>
                                        <td><a class="easyui-linkbutton" type="text" style="width: 100px" name="Save" onclick="pto_FormNotMove()" id="pto_FormBack" data-options="iconCls:'icon-save'" >取消</a></td>

                                    </tr>
                                </table>
                            </td>
                        </table>
                    </from>
                </div>
                <div id="pto_tb" style="padding:5px;height:auto">
                    <div style="margin-bottom:5px">
                        采购订单: <input id="pto_cgvbelncx" class="wu-text" style="width:100px" >
                        <a href="#" class="easyui-linkbutton"  onclick="pto_getOut()" iconCls="icon-search">查询</a>
                        <a href="#" class="easyui-linkbutton"  onclick="pto_SapTakeOut()" iconCls="icon-search">SAP出库</a>
                    </div>
                    <%--<div>--%>
                        <%--Date From: <input class="easyui-datebox" style="width:80px">--%>
                        <%--To: <input class="easyui-datebox" style="width:80px">--%>
                        <%--Language:--%>
                        <%--<select class="easyui-combobox" panelHeight="auto" style="width:100px">--%>
                            <%--<option value="java">Java</option>--%>
                            <%--<option value="c">C</option>--%>
                            <%--<option value="basic">Basic</option>--%>
                            <%--<option value="perl">Perl</option>--%>
                            <%--<option value="python">Python</option>--%>
                        <%--</select>--%>
                        <%--<a href="#" class="easyui-linkbutton" iconCls="icon-search">Search</a>--%>
                    <%--</div>--%>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(function () {
        $("input[name='MDMKCardCheck']").eq(0).attr("checked","checked");
        $("#pto_More").hide();
        $("#pto_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#pto_More").hide();

        });
    });

    function pto_getKey() {
        if(event.keyCode==13){
            pto_forGetDate();
        }
    }
    function pto_showMore() {
        $("#pto_More").toggle();
    }
    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }
    function pto_Z03FormCreate(){
        var row = $("#pto_outgrid").datagrid("getSelected");
        var selrows = $("#pto_outgrid").datagrid("getChecked");
        var entities = "";
        if($("#pto_Z003FormJiaoHuo").val() !==null && $("#pto_Z003FormJiaoHuo").val().trim() !==""){
            $.messager.alert('温馨提示', '已经创建交货单，无需重新创建！！！！');
        }else{
            for(i = 0;i < selrows.length;i++)
            {
                entities = entities  + JSON.stringify(selrows[i]);
            }
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: '${ctxPath }/ColdSapRFC/ColdTakeOutCreateSap.action',
                dataType: "json",
                data: {
                    entities:entities
                },
                success: function (result) {
                    if(result.returns === 'S'){
                        $("#pto_Z003FormJiaoHuo").textbox("setValue",result.VBELN);
                        pto_getOut();
////                        $("#pto_Z003FormJiaoHuoItem").textbox("setValue",result.POSNR);
//                        jQuery.ajax({
//                            type: "POST",   //post提交方式默认是get
//                            url: '/TakeReport/updateOutMsg.action',
//                            dataType: "json",
//                            data: {
////                                id:row.id,
//                                vbeln:result.VBELN,
//                                entities:entities
////                                posnr:result.POSNR,
////                                cgvbeln:$("#pto_Z03FormPoNo").val(),
////                                cgposnr:$("#pto_Z03FormPoitem").val()
//                            }
//                        })
                        $.messager.alert('温馨提示', '创建成功！！！');
                    }else{
                        $.messager.alert('温馨提示', '创建失败！！！');
                    }

                },
                error:function(){
                    $.messager.alert('温馨提示', '出错了！！！');
                }
            })
        }

    }

    function pto_Z03FormSave() {
        if($("#pto_Z003FormJiaoHuo").val() ===null ||$("#pto_Z003FormJiaoHuo").val() ===""){
            $.messager.alert('温馨提示', '还未创建交货单，不能进行过账操作！！！！');
        }else{
            var selrows = $("#pto_outgrid").datagrid("getChecked");
            var entities = "";
            var row = $("#pto_outgrid").datagrid("getSelected");
            for(i = 0;i < selrows.length;i++)
            {
                entities = entities  + JSON.stringify(selrows[i]);
            }
            if(row.ismove === true){
                $.messager.alert('温馨提示', '过账已确认，无需再次过账！！！！');
            }else{
                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url: '${ctxPath }/ColdSapRFC/ColdTakeOutSaveSap.action',
                    dataType: "json",
                    data: {
                        User:localStorage.getItem("User"),
                        entities:entities
                    },
                    success: function (result) {
                        if(result.returns === 'S'){
//                            jQuery.ajax({
//                                type: "POST",   //post提交方式默认是get
//                                url: '/ColdSapRFC/insertSapMess.action',
//                                dataType: "json",
//                                data: {
//                                    fno: row.fno,
//                                    id:row.id,
//                                    serialno:row.serialno,
//                                    uyear:row.uyear,
//                                    umonth:row.umonth,
//                                    TakeNumber:row.outnumber,
//                                    UserName:localStorage.getItem("User"),
//                                    plant:"材料零件",
//                                    OutPutMan:row.outputman,
//                                    OutPutDate:row.outputdate,
//                                    OutAdd:row.outadd,
//
//                                    fname:row.fname,
//                                    state:3,
//                                    againstkind:"原材料库SAP发出",
//                                },
//                                success: function (Numdata) {
////                                    alert(Numdata.Num);
//                                    if(Numdata.Num ===1){
//                                        var rowIndex = $("#pto_outgrid").datagrid('getRowIndex',row.id);
//                                        var data =  $("#pto_outgrid").datagrid('getData').rows[rowIndex];
//                                        data.ismove = 0;
//                                        data.moveok = 0;
//                                        $('#pto_outgrid').datagrid('refreshRow',rowIndex);
//                                        $.messager.alert('温馨提示',"移库成功！！");
//                                        $("#HalfPartSapOutBack").dialog('close');
//                                    }else{
//                                        $.messager.alert('温馨提示',"请联系管理员！");
//                                        $("#HalfPartSapOutBack").dialog('close');
//                                    }
//                                }
//
//                            });

                            for( n = 0;n < selrows.length;n++)
                            {
//                                alert(selrows[n].id);
                                var outfreshrowIndex = $("#pto_outgrid").datagrid('getRowIndex',selrows[n].id);
                                var data =  $("#pto_outgrid").datagrid('getData').rows[outfreshrowIndex];
                                data.ismove = true;
                                data.moveok = false;
                                $('#pto_outgrid').datagrid('refreshRow',outfreshrowIndex);
                                $('#pto_outgrid').datagrid('clearSelections');
                            }



                            $.messager.alert('温馨提示', '过账成功！！！');
                            $("#pto_SapOutDivZ03").dialog('close');
                            $('#fm1').form('clear');
                            pto_forGetDate();
                        }else{
                            $.messager.alert('温馨提示', '过账失败！！！');
                        }
                    },
                    error:function(result){
                        $.messager.alert('温馨提示', result);
                    }
                })
            }

        }

    }

    function pto_Z03FormBack(){
        $("#pto_SapOutDivZ03").dialog('close');
        $('#fm1').form('clear');
    }
    function pto_FormMove() {
        var row = $("#pto_outgrid").datagrid("getSelected");
                if(row.ismove === true){
                    $.messager.alert('温馨提示', '此记录已经完成了SAP出库！！！!');
                }else{
                    $.messager.confirm('温馨提示', '你确定要移库吗?', function (r) {
                        if (r) {
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/ColdSapRFC/ColdTakeInSap.action',
                                dataType: "json",
                                data: {
                                    p_MATNR:$('#pto_FormFno').val(),
                                    FromAdd:$('#pto_FormOutPlace').val(),
                                    ToAdd:$('#pto_FormTakePlace').val(),
                                    MoveType:$('#pto_FormMoveTypeReal').val(),
                                    PPNum:$('#pto_FormTakeNumber').val(),
                                    MDW:"KG",
                                    isback:"false"
                                },
                                success: function (result) {
                                    if(result.result ==="成功"){
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: '${ctxPath }/ColdSapRFC/insertSapMess.action',
                                            dataType: "json",
                                            data: {
                                                fno: row.fno,
                                                id:row.id,
                                                serialno:row.serialno,
                                                uyear:row.uyear,
                                                umonth:row.umonth,
                                                TakeNumber:row.outnumber,
                                                UserName:localStorage.getItem("User"),
                                                plant:"材料零件",
                                                OutPutMan:row.outputman,
                                                OutPutDate:row.outputdate,
                                                OutAdd:row.outadd,

                                                fname:row.fname,
                                                state:3,
                                                againstkind:"原材料库SAP发出",
                                            },
                                            success: function (Numdata) {
//                                                alert(Numdata.Num);
                                                if(Numdata.Num ===1){
                                                    var rowIndex = $("#pto_outgrid").datagrid('getRowIndex',row.id);
                                                    var data =  $("#pto_outgrid").datagrid('getData').rows[rowIndex];
                                                    data.ismove = true;
                                                    data.moveok = false;
                                                    data.moveman = localStorage.getItem("User");
                                                    $('#pto_outgrid').datagrid('refreshRow',rowIndex);
                                                    $.messager.alert('温馨提示',"移库成功！！");
                                                    $("#pto_SapOutBack").dialog('close');
                                                }else{
                                                    $.messager.alert('温馨提示',"请联系管理员！");
                                                    $("#pto_SapOutBack").dialog('close');
                                                }
                                            }

                                        });

//                            $.messager.alert('温馨提示',result.result);
                                    }else{
//                                        jQuery.ajax({
//                                            type: "POST",   //post提交方式默认是get
//                                            url: '/ColdSapRFC/insertSapMessOutFail.action',
//                                            dataType: "json",
//                                            data: {
//                                                id:row.id,
//                                                UserName:localStorage.getItem("User"),
//                                            },
//                                            success: function (NumdataFail) {
//
//
//                                            }
//                                        });
                                        $.messager.alert('温馨提示',result.result);
                                        $("#pto_SapOutBack").dialog('close');
                                                $('#fm2').form('clear');
                                                Out();
                                    }

                                }
                            });
                        }
                    });
                }
    }
    function pto_FormNotMove() {
        $("#pto_SapOutBack").dialog('close');
        $('#fm2').form('clear');
    }
    function pto_out() {
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth()+1;
        var row = $('#pto_storegrid').datagrid("getSelected");
        var rowlocation = $("#pto_storegridLocation").datagrid("getSelected");
        if (rowlocation===null || row ===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else{
            if(pto_endEditing()){
                $('#pto_outgrid').datagrid('appendRow', {
                    fno:row.fno,
                    fname:row.fname,
                    outnumber:row.outnumber,
                    plant:row.plant,
                    outadd:row.outadd,
                    outputman:localStorage.getItem("User"),
                    ismove:0,
                    year:year,
                    month:month,
                    istake:0,
                    location:rowlocation.location,
                    isapp:0,
                    isdelete:0,
                    vbeln:""
                });
                editIndex = $('#pto_outgrid').datagrid('getRows').length - 1;
                $.ajax({
                    type: "post",
                    url: "${ctxPath }/DeliverGoods/selectPlantLgortAll.action",
                    data: {

                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        console.log(data);
                        var ed = $('#pto_outgrid').datagrid('getEditor', {index: editIndex, field: 'outadd'});
                        $(ed.target).combobox('loadData', data);
                    }
                });
                $('#pto_outgrid').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
                $('.datagrid-editable .textbox,.datagrid-editable .datagrid-editable-input,.datagrid-editable .textbox-text').keydown(function (e) {
                    var code = e.keyCode || e.which;
                    if (code === 13) {
                        var edn = $('#pto_outgrid').datagrid('getEditor', {index: editIndex, field: 'outadd'});
                        var outaddn = $(edn.target).combobox('getValue');
                        var outaddname = $(edn.target).combobox('getText');
                        //alert(outaddname);
                        $('#pto_outgrid').datagrid('endEdit', editIndex);
                        var rowkc = $('#pto_outgrid').datagrid('getRows');
                        var rowData = rowkc[editIndex];
                        $.messager.confirm('温馨提示', '你确定要保存吗?', function (r) {
                            if (r) {
                                if (parseInt(rowData.outnumber) > parseInt(row.sapstore)) {
                                    $.messager.alert('温馨提示', '出库数量大于库存数量！！');
                                    $('#pto_outgrid').datagrid('cancelEdit', editIndex)
                                        .datagrid('deleteRow', editIndex);
                                    pto_out();
                                }else if(rowData.outadd.indexOf("25") === 0){
                                    $.messager.alert('温馨提示', '到货库存地点不能选择自己事业部！！');
                                    $('#pto_outgrid').datagrid('cancelEdit', editIndex)
                                        .datagrid('deleteRow', editIndex);
                                } else if((outaddn.indexOf("1")===0||outaddn.indexOf("3")===0)&& (rowData.cgvbeln===''||rowData.cgposnr==='')){
                                    $.messager.alert('温馨提示', '跨公司业务，请输入采购订单号以及行号！！');
//                                    $.ajax({
//                                        type: "post",
//                                        url: "/DeliverGoods/selectPlantLgortAll.action",
//                                        data: {
//
//                                        },
//                                        dataType: "json",//后台处理后返回的数据格式
//                                        success: function (data) {//ajax请求成功后触发的方法
//                                            console.log(data);
//                                            var ed = $('#pto_outgrid').datagrid('getEditor', {index: editIndex, field: 'outadd'});
//                                            $(ed.target).combobox('loadData', data);
//                                        }
//                                    });
//                                    $('#pto_outgrid').datagrid('selectRow', editIndex)
//                                        .datagrid('beginEdit', editIndex);
                                    $('#pto_outgrid').datagrid('cancelEdit', editIndex)
                                        .datagrid('deleteRow', editIndex);
                                    pto_out();
                                } else{
                                    $.ajax({
                                        type: "post",//数据发送的方式（post 或者 get）
                                        url: "${ctxPath }/DeliverGoods/insertColdOut.action",//要发送的后台地址
                                        data: {
                                            fno: rowData.fno,
                                            fname: rowData.fname,
                                            outnumber: rowData.outnumber,
                                            plant: rowData.plant,
                                            outadd: outaddn,
                                            outaddname : outaddname,
                                            outputman: rowData.outputman,
                                            ismove: rowData.ismove,
                                            year: rowData.year,
                                            month: rowData.month,
                                            istake: rowData.istake,
                                            location: rowData.location,
                                            isapp: rowData.isapp,
                                            isdelete: rowData.isdelete,
                                            cgvbeln: rowData.cgvbeln,
                                            cgposnr: rowData.cgposnr,
                                        },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}

                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (data) {//ajax请求成功后触发的方法
                                            if (data.num > 0) {
                                                $('#pto_outgrid').datagrid('clearSelections');
                                                pto_getStore();
                                                pto_getStoreLocation();
                                                pto_getOut();

                                            }
                                        },
                                        error: function (msg) {//ajax请求失败后触发的方法
                                            alert(msg);//弹出错误信息
                                        }
                                    });
                                }

                            }else{
                                $('#pto_outgrid').datagrid('cancelEdit', editIndex)
                                    .datagrid('deleteRow', editIndex);
                            }
                        });

                    }
                })
            }else{
                $.messager.alert('温馨提示', '存在未保存数据行项目！！！!');
            }

        }

    }
    function pto_back() {
        var row  = $('#pto_outgrid').datagrid("getSelected");
        //alert(row.id);
        if(row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else {
            $.messager.confirm('温馨提示', '你确定要退回吗?', function (r) {
                if (r) {
                    if (row.id === undefined) {
                        if (editIndex == undefined) {
                            return
                        }
                        $('#pto_outgrid').datagrid('cancelEdit', editIndex)
                            .datagrid('deleteRow', editIndex);
                        editIndex = undefined;
                    } else {
                        $.ajax({
                            type: "post",
                            url: "${ctxPath }/DeliverGoods/deleteColdOut.action",
                            data: {
                                id: row.id
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    pto_getOut();
                                    pto_getStore();
                                    pto_getStoreLocation();
                                }
                            }
                        });
                    }
                }
            })
        }
    }
    function pto_SapTakeOut() {

            var row = $("#pto_outgrid").datagrid("getSelected");
            var selrows = $("#pto_outgrid").datagrid("getChecked");
            if(selrows.length ===0){
                $.messager.alert('温馨提示', '请先选择有效的行项目!');
            }else{
                var same = 0;
                var samejh = 0;
                var lgortDf = 0;
                var cgposnrAll = "";
                var posnrAll = "";
                var rowone;
                sapoutputagainst = false;
                var vbelnfirst = selrows[0].cgvbeln;
                var jhvbelnfirst = selrows[0].vbeln;
                cgposnrAll = cgposnrAll+selrows[0].cgposnr;
                posnrAll = posnrAll+selrows[0].posnr;
                if (selrows[0].outadd.indexOf("2") === 0) {
                    lgortDf++;
                }

                var fdStart = row.outadd.indexOf("2");
                if(fdStart === 0){
                    var fno = row.fno;
                    var TakeNumber = row.outnumber;
                    var HalfPartFormMoveType = "301";
                    var HalfPartFormMoveTypeReal = "301";
                    var HalfPartFormOutPlace = "2501";
                    var HalfPartFormTakePlace = row.outadd;
                    $('#pto_FormFno').textbox('setValue',fno);
                    $('#pto_FormTakeNumber').textbox('setValue',TakeNumber);
                    $('#pto_FormOutPlace').textbox('setValue',HalfPartFormOutPlace);
                    $('#pto_FormTakePlace').textbox('setValue',HalfPartFormTakePlace);
                    $('#pto_FormMoveType').textbox('setValue',HalfPartFormMoveType);
                    $('#pto_FormMoveTypeReal').textbox('setValue',HalfPartFormMoveTypeReal);
                    $("#pto_SapOutBack").dialog('open');
                }else {
                    var entities = "";

                    for (var i = 1; i < selrows.length; i++) {
                        rowone = selrows[i];
                        //alert(rowone.vbeln);
//                        alert(vbelnfirst+"===-=-=-=-"+rowone.cgvbeln);
                        if (vbelnfirst !== rowone.cgvbeln) {
                            same++;
                        }
                        if (jhvbelnfirst !== rowone.vbeln) {
                            samejh++;
                        }
                        if (rowone.outadd.indexOf("2") === 0) {
                            lgortDf++;
                        }
                    }

                    if (same > 0) {
                        $.messager.alert('温馨提示', '勾选的行项目存在多个采购订单，请选择同一个采购订单！！!');
                    } else if(samejh>0){

                        $.messager.alert('温馨提示', '勾选的行项目存在已创建交货单的记录，或者存在多个交货单！！!');
                    }else if(lgortDf>0){
                        $.messager.alert('温馨提示', '勾选的行项目存在公司内调拨，无法生成Z03交货单！！!');
                    }
                    else{
                        console.log(selrows);
                        for (var i = 1; i < selrows.length; i++) {

                            rowone = selrows[i];
//                        alert(vbelnfirst+"===-=-=-=-"+rowone.cgvbeln);
                            cgposnrAll = cgposnrAll+"/"+rowone.cgposnr;
                            if(rowone.posnr!=null && rowone.posnr!=""){
                                posnrAll = posnrAll+"/"+rowone.posnr;
                            }

                        }
                        $('#pto_Z003FormJiaoHuo').textbox('setValue',jhvbelnfirst);
                        $('#pto_Z003FormJiaoHuoItem').textbox('setValue',posnrAll);
                        $('#pto_Z03FormPoNo').textbox('setValue',vbelnfirst);
                        $('#pto_Z03FormPoitem').textbox('setValue',cgposnrAll);
                        $("#pto_SapOutDivZ03").dialog('open');
                    }
                }

            }

    }
    function pto_forGetDate() {
        var state = $('input[name="MDMKCardCheck"]:checked').val();
        pto_getStore(state);
        pto_getOut();
    }
    /**
     * Name 获取开卡数据表
     */
    var SBdata;
    function pto_getOut() {
        $('#pto_outgrid').datagrid('loadData', { total: 0, rows: [] });
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/DeliverGoods/selectColdOutToday.action",//要发送的后台地址
            data: {
                vbeln:$("#pto_cgvbelncx").val(),
                outputman:localStorage.getItem('User')
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $("#pto_outgrid").datagrid({
                    idField:'id',
                    rownumbers:true,
                    singleSelect:false,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    loadFilter:pto_pagerFilter,
                    checkOnSelect:true,
                    selectOnCheck:true,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'ck',checkbox:'true'},
                        {field:'fno',title:'物料编码',width:100, sortable: true},


                        {field:'fname',title:'物料名称',width:250},
                        {field:'outadd',title:'出库地点',width:100,editor:{
                            type:'combobox',
                            options:{
                                required:true,
                                valueField:'lgort',
                                textField:'plant',
                            }
                        }, sortable: true},
                        {field:'outaddname',title:'出库地点名称',width:120,hidden:true},
                        {field:'outnumber',title:'出库数量',editor:{
                            type:'textbox',
                            options:{
                                required:true
                            }
                        },width:100},
                        {field:'cgvbeln',title:'采购订单单',editor: {
                            type: 'textbox'
                        },width:100},
                        {field:'cgposnr',title:'采购行号',editor: {
                            type: 'textbox'
                        },width:100},
                        {field:'vbeln',title:'交货单号',width:100 },
                        {field:'posnr',title:'交货行号',width:100},
                        {field:'id',title:'序号',width:100},

                        {field:'serialno',title:'编号',width:100},


                        {field:'plant',title:'事业部',width:100, sortable: true},


                        {field:'outputman',title:'出库人',width:100, sortable: true},
                        {field:'outputdate',title:'出库时间',width:100},
                        {field:'ismove',title:'SAP移库',width:100},
                        {field:'moveman',title:'移库人',width:100},
                        {field:'movedate',title:'移库时间',width:100},
                        {field:'year',title:'年份',width:100},
                        {field:'month',title:'月份',width:100},

                        {field:'moveok',title:'移库成功',width:100},
                        {field:'moveback',title:'移库冲销',width:100},
                        {field:'movebackman',title:'冲销人',width:100},
                        {field:'movebackdate',title:'冲销时间',width:100},
                        {field:'istake',title:'接收',width:100},
                        {field:'takeman',title:'接收人',width:100},
                        {field:'takedate',title:'接收时间',width:100},

                        {field:'location',title:'出库库位',width:100},
                        {field:'isapp',title:'手机出库',width:100},



                        {field:'isdelete',title:'删除标识',width:100},

                    ]],
                    pageList: [50,100,200],
                    sortOrder:'asc',
                });

                $('#pto_outgrid').datagrid({
                    rowStyler: function (index, row) {
                        var ismove =row.ismove;
                        //alert(11);
                        if (ismove !== true) {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'color:red';
                        }

                    }
                });
                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });




    }
    /**
     * Name 获取月度计划表
     */
    function pto_getStore(selectState) {
        //alert(11111);
        $('#pto_storegrid').datagrid('loadData', { total: 0, rows: [] });
        var   fname=$('#pto_fname').val();
        var   fno=$('#pto_fno').val();
        //alert(plant+"===="+dhorderno+"===="+PartDrawing+"===="+fname);
        $.messager.progress({
            title:'请稍等',
            msg:'页面加载中...'
        });
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/Inventory/selectColdStore.action",//要发送的后台地址
            data: {
                fname:fname,
                fno:fno,
                sapstore:1,
                state:2
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                $("#pto_storegrid").datagrid({
                    idField:'id',
                    loadFilter:pto_pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[

                        {field: 'id', title: '序号', width: 50, sortable: true},
                        {field: 'fno', title: '物料编码', width: 100, sortable: true},
                        {field: 'fname', title: '物料描述', width: 300, sortable: true},
                        {field: 'sapstore', title: '现库存', editor: 'text', width: 100},
                        {field: 'beginstore', title: '开始库存', editor: 'text', width: 60, sortable: true},

                        {field: 'inputstore', title: '接收库存', width: 70, sortable: true},

                        {field: 'outputstore', title: '发出库存', width: 60, sortable: true},


                        {field: 'inputman', title: '初始入库人', width: 100},
                        {field: 'inputdate', title: '初始入库时间', width: 150, sortable: true},
                        {field: 'plant', title: '事业部', width: 150, sortable: true},

                        {field: 'beginman', title: '库存开始人', width: 100, sortable: true},
                        {field: 'begindate', title: '库存开始时间', width: 100, sortable: true}
                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',
                });
//                $('#yd').datagrid({
//                    rowStyler: function (index, row) {
//                        var CLNumber =parseFloat(row.CLNumber);
//                        var ConnectPlan =parseFloat(row.ConnectPlan);
//                        //alert(11);
//                        if (CLNumber < ConnectPlan) {
//                            return 'color:black;';
//                        }
//                        else {
////                            return 'color:Green;font-weight:bold;';
//                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
//                        }
//
//                    }
//                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }
        });

    }

    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var ydIndex = undefined;
    function pto_endEditing(){
        if (editIndex == undefined){return true}
        if ($('#pto_outgrid').datagrid('validateRow', editIndex)){
            $('#pto_outgrid').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function pto_getStoreLocation(){
        $('#pto_storegridLocation').datagrid('loadData', {total: 0, rows: []});
        var row = $("#pto_storegrid").datagrid("getSelected");
        $.ajax({
            type: "post",
            url: "${ctxPath }/Inventory/selectColdStoreLocation.action",
            data: {
                fno: row.fno,
                plant: row.plant,
                fname: row.fname
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $("#pto_storegridLocation").datagrid({
                    rownumbers: true,
                    singleSelect: true,
                    pagination: true,
                    multiSort: true,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    remoteSort: false,
                    loadFilter: pto_pagerFilter,
                    method: 'post',
                    loadMsg: "正在加载数据.....",
                    data: data,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns: [[
                        {field: 'fno', title: '物料编码', width: 100, sortable: true},
                        {field: 'leavenumber', title: '库位库存', width: 100, sortable: true},
                        {field: 'location', title: '库位', editor: 'text', width: 60, sortable: true},

                        {field: 'plant', title: '事业部', width: 70, sortable: true},

                        {field: 'fname', title: '物料描述', width: 300, sortable: true},
                        {field: 'sapstore', title: '现库存', editor: 'text', width: 100}

                    ]],
//                    pagination:true,
                    pageList: [25, 50, 100],
                    sortOrder: 'asc'
                });
                $('#pto_storegridLocation').datagrid("selectRow", 0);
            }
        });
    }
    function pto_OnClickRow(index){
        pto_getStoreLocation();
        editIndex = index;
    }
    function onClickRow2(index){
        if (editIndex !== index){

            var data = $('#kc').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#kc').datagrid('selectRow', editIndex);
                }
            }

//        $.ajax({
//            type: "get",
//            url: "/KCard/queryCZG.action?plant=" + $('#Plant').combobox('getText') + "&&worklead=" + row.dutyman + "",
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//                $('#ReportMan1').combobox('loadData', data);
//            }
//        });
            editIndex = index;
        }
    }
    function Print() {
        var row = $("#kc").datagrid("getSelected");
        row.IsPrint = '1';
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/KCard/updateDY.action",//要发送的后台地址
            data: {
                id:row.id,
                IsPrint:row.IsPrint
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
            }
        });
        $('#kc').datagrid('refreshRow', editIndex);
        var tarValue = "[{reportlet:'/SD/ZPJJKC.cpt',id:'"+row.id+"'}]";
//设置url地址，加上Date().getTime()防止缓存
        var url = "http://172.16.0.57:8090/WebReport/proxy2.html?_=" + new Date().getTime()
            + "&tarValue=" + tarValue;
//添加一个新的iframe，并为该iframe添加一个src，用来打开proxy.html，让其执行跨域打印的js代码
        var iframe = document.getElementById('proxy');
        if (!iframe) {
            // 如果iframe还没有加进去，则加进去
            iframe = document.createElement('iframe');
            document.getElementsByTagName('head')[0].appendChild(iframe);
            iframe.setAttribute('name','proxy');
            iframe.setAttribute('id','proxy');
        }
        iframe.setAttribute('src', url);


    }


    /**
     * Name 载入菜单树
     */
    $('#wu-category-tree').tree({
        url:'',
        onClick:function(node){
            alert(node.text);
        }
    });
    /**
     * Name 添加记录
     */
    function add(){
        $('#wu-form').form('submit', {
            url:'',
            success:function(data){
                if(data){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog').dialog('close');
                }
                else
                {
                    $.messager.alert('信息提示','提交失败！','info');
                }
            }
        });
    }

    /**
     * Name 修改记录
     */
    function edit(){
        $('#wu-form').form('submit', {
            url:'',
            success:function(data){
                if(data){
                    $.messager.alert('信息提示','提交成功！','info');
                    $('#wu-dialog').dialog('close');
                }
                else
                {
                    $.messager.alert('信息提示','提交失败！','info');
                }
            }
        });
    }

    /**
     * Name 删除记录
     */
    function remove(){
        $.messager.confirm('信息提示','确定要删除该记录？', function(result){
            if(result){
                var items = $('#wu-datagrid').datagrid('getSelections');
                var ids = [];
                $(items).each(function(){
                    ids.push(this.productid);
                });
                //alert(ids);return;
                $.ajax({
                    url:'',
                    data:'',
                    success:function(data){
                        if(data){
                            $.messager.alert('信息提示','删除成功！','info');
                        }
                        else
                        {
                            $.messager.alert('信息提示','删除失败！','info');
                        }
                    }
                });
            }
        });
    }

    /**
     * Name 打开添加窗口
     */
    function openAdd(){
        $('#wu-form').form('clear');
        $('#wu-dialog').dialog({
            closed: false,
            modal:true,
            title: "添加信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#wu-dialog').dialog('close');
                }
            }]
        });
    }

    /**
     * Name 打开修改窗口
     */
    function openEdit(){
        $('#wu-form').form('clear');
        var item = $('#wu-datagrid').datagrid('getSelected');
        //alert(item.productid);return;
        $.ajax({
            url:'',
            data:'',
            success:function(data){
                if(data){
                    $('#wu-dialog').dialog('close');
                }
                else{
                    //绑定值
                    $('#wu-form').form('load', data)
                }
            }
        });
        $('#wu-dialog').dialog({
            closed: false,
            modal:true,
            title: "修改信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: edit
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#wu-dialog').dialog('close');
                }
            }]
        });
    }

    /**
     * Name 分页过滤器
     */

    function pto_pagerFilter(data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }


</script>
