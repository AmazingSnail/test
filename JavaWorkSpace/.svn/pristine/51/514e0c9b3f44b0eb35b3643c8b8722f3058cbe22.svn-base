<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .cz{
        width:100%;
        height:100%;
    }
    .B{
        width: 10%;
        height: 96%;
    }
    .w2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2em; /*同上*/
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
    body{
        padding: 0px;
        margin: 0px;
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <iframe id="proxy2" style="display:none"></iframe>
        <div class="easyui-panel " title="收发报表" data-options="fit:true">
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 78px;">
                <div class="wu-toolbar-button" >
<shiro:hasPermission name="/trt/export">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="trt_export()" plain="true">导出</a>
</shiro:hasPermission>
                    <shiro:hasPermission name="/mti/Print">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="trt_Print()" plain="true">打印</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/pto/back">
                        <button id="pto_back" class="easyui-linkbutton" onclick="trt_back()">退回<<</button>
                    </shiro:hasPermission>

                    <shiro:hasPermission name="/trt/SapTakeIn">
                        <a href="#" class="easyui-linkbutton"  onclick="trt_SapTakeIn()" data-options="iconCls:'icon-search'">SAP入库</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/trt/SapTakeInBack">
                        <a href="#" class="easyui-linkbutton"  onclick="trt_SapTakeInBack()" data-options="iconCls:'icon-search'">SAP入库冲销</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/trt/SapTakeOut">
                        <a href="#" class="easyui-linkbutton"  onclick="trt_SapTakeOut()" data-options="iconCls:'icon-search'">SAP出库</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/trt/SapTakeOutBack">
                        <a href="#" class="easyui-linkbutton"  onclick="trt_SapTakeOutBack()" data-options="iconCls:'icon-search'">SAP出库冲销</a>
                    </shiro:hasPermission>
                </div>
                <div class="wu-toolbar-search" >

                    <div style="white-space:nowrap">
                        <label>起始时间：</label><input  id ="trt_db1" style="width:110px" class="easyui-datebox">&nbsp
                        <label>结束时间：</label><input  id ="trt_db2" style="width:110px" class="easyui-datebox">&nbsp
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="trt_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>物料编码：</label><input id="trt_fno" class="easyui-textbox" style="width:100px" >&nbsp
                        <label>物料描述：</label><input id="trt_fname" class="easyui-textbox" style="width:100px" >&nbsp
                        <label>出库地点：</label><input id="trt_outadd" class="easyui-textbox" style="width:100px" >&nbsp
                        <a href="#" class="easyui-menubutton" data-options="menu:'#trt_mm1',iconCls:'icon-search'">查询</a>
                        <div id="trt_mm1" style="width:150px;">
                            <div data-options="iconCls:'icon-search'" onclick='trt_forGetInDate()'>接收查询</div>
                            <div data-options="iconCls:'icon-search'" onclick='trt_forGetOutDate()'>发出查询</div>
                        </div>
                        <a href="#" class="easyui-linkbutton"  onclick="trt_showMore()" data-options="iconCls:'icon-search'">更多</a>
                        <%--<a href="#" class="easyui-linkbutton"  onclick="trt_forGetSumDate()" data-options="iconCls:'icon-search'">入库汇总查询</a>--%>

                    </div>
                    <%--<div id="trt_mm" style="width:150px;">--%>
                    <%--<div iconCls="icon-search" onclick="trt_forGetDate()">串装入库查询</div>--%>
                    <%--<div iconCls="icon-search">入库汇总查询</div>--%>
                    <%--</div>--%>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white" id="trt_More">
                        <%--<div>--%>
                            <%--<label>规&nbsp&nbsp&nbsp&nbsp格：</label><input id="trt_PartDrawing" class="wu-text" style="width:95px">&nbsp--%>

                            <%--<label>编号：</label><input id="trt_serialno" class="wu-text" style="width:100px">&nbsp--%>

                        <%--</div>--%>
                        <div style="margin-top: 5px">
                            <label class="labelstyle"><input type="radio" name="ColdCheck" value="3" />全部查询</label>
                            <label class="labelstyle"><input type="radio" name="ColdCheck" value="1" />冷卷料</label>
                            <label class="labelstyle"><input type="radio" name="ColdCheck" value="2" />剪成品</label>
                            采购订单: <input id="trt_cgvbelncx" class="wu-text" style="width:100px" >
                            <%--<label class="labelstyle"><input type="radio" name="MDMCZRkuCheck" value="4" />已确认</label>--%>
                            <%--<label class="labelstyle"><input type="radio" name="MDMCZRkuCheck" value="5" />已入库</label>--%>
                        </div>
                    </div>
                    <!--class="easyui-datebox"-->

                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div id="trt_dd" class="easyui-layout cz"  data-options="fit:true">
                    <div style="width: 100%;height:100%" data-options="region:'center'">
                        <table id="trt_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="收发报表" data-options="singleSelect:true,onClickRow:onClickRow"></table>
                    </div>
                </div>
            </div>
            <div id="trt_SapOutDivZ03" class="easyui-dialog" title="移动物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:270px;height:300px;padding:10px">
                <from>
                    <table cellpadding="5" width="auto" style="white-space:nowrap" >
                        <td>
                            <%--<tr>--%>
                                <%--<td>移动物料:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z03FormFno" id="trt_Z03FormFno" disabled= "true"  style="width:150px" ></input></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td>移动数量:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z03FormTakeNumber" id="trt_Z03FormTakeNumber" disabled= "true"  style="width:150px" ></input></td>--%>
                            <%--</tr>--%>
                            <tr>
                                <td>采购订单:</td>
                                <td><input class="easyui-textbox" type="text" name="Z03FormPoNo" id="trt_Z03FormPoNo"    style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td>行项目:</td>
                                <td><input class="easyui-textbox" type="text" name="Z03FormPoitem" id="trt_Z03FormPoitem"  style="width:150px"  ></input></td>
                            </tr>
                            <%--<tr>--%>
                                <%--<td>出库地点:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z003FormLgort" id="trt_Z003FormLgort" disabled= "true" style="width:150px"  ></input></td>--%>
                            <%--</tr>--%>
                            <tr>
                                <td>交货单:</td>
                                <td><input class="easyui-textbox" type="text" name="Z003FormJiaoHuo" id="trt_Z003FormJiaoHuo" disabled= "true" style="width:150px"  ></input></td>
                            </tr>
                            <%--<tr>--%>
                                <%--<td>交货单行项目:</td>--%>
                                <%--<td><input class="easyui-textbox" type="text" name="Z003FormJiaoHuoItem" id="trt_Z003FormJiaoHuoItem" disabled= "true" style="width:150px"  ></input></td>--%>
                            <%--</tr>--%>

                            <table>
                                <tr >
                                    <td><a class="easyui-linkbutton" type="text" style="width: 75px" name="Move" onclick="trt_Z03FormCreate()" id="trt_Z03FormCreate" data-options="iconCls:'icon-save'" >创建</a></td>
                                    <td><a class="easyui-linkbutton" type="text" style="width: 75px" name="Move" onclick="trt_Z03FormSave()" id="trt_Z03FormSave" data-options="iconCls:'icon-save'" >过账</a></td>

                                    <td><a class="easyui-linkbutton" type="text" style="width: 75px" name="Save" onclick="trt_Z03FormBack()" id="trt_Z03FormBack" data-options="iconCls:'icon-save'" >取消</a></td>

                                </tr>
                            </table>
                        </td>
                    </table>
                </from>
            </div>
            <div id="trt_SapOutBack" class="easyui-dialog" title="移动物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:240px;height:250px;padding:10px">
                <from>
                    <table cellpadding="5" width="auto" style="white-space:nowrap" >
                        <td>
                            <tr>
                                <td>移动物料:</td>
                                <td><input class="easyui-textbox" type="text" name="FormFno" id="trt_FormFno" disabled= "true"  style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td>移动数量:</td>
                                <td><input class="easyui-textbox" type="text" name="FormTakeNumber" id="trt_FormTakeNumber" disabled= "true"  style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td>发货地点:</td>
                                <td><input class="easyui-textbox" type="text" name="FormOutPlace" id="trt_FormOutPlace"  disabled= "true"  style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td>收货地点:</td>
                                <td><input class="easyui-textbox" type="text" name="FormTakePlace" id="trt_FormTakePlace" disabled= "true" style="width:150px"  ></input></td>
                            </tr>
                            <tr>
                                <td>移动类型:</td>
                                <td><input class="easyui-textbox" type="text" name="FormMoveType" id="trt_FormMoveType" disabled= "true" style="width:150px"  ></input></td>
                                <input class="easyui-textbox" type="hidden" name="FormMoveTypeReal" id="trt_FormMoveTypeReal" disabled= "true"  ></input>
                            </tr>


                            <table>
                                <tr >
                                    <td><a class="easyui-linkbutton" type="text" style="width: 100px" name="Move" onclick="trt_FormMove()" id="trt_FormMove" data-options="iconCls:'icon-save'" >移库</a></td>
                                    <td><a class="easyui-linkbutton" type="text" style="width: 100px" name="Save" onclick="trt_FormNotMove()" id="trt_FormBack" data-options="iconCls:'icon-save'" >取消</a></td>

                                </tr>
                            </table>
                        </td>
                    </table>
                </from>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var SelectState = 0;
    var sapinput = false;
    var sapoutput = false;
    var sapaginst = false;
    var sapoutputagainst = false;
    $(function () {

        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#trt_db1').val(year+"-"+month+"-"+day);
        //$('#trt_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#trt_db2').val(year+"-"+month+"-"+day);
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/Syb/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#trt_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#trt_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#trt_KCardMan').combobox('clear');
                    $('#trt_CZMan').combobox('clear');
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "${ctxPath }/Syb/KMan.action",
                        dataType: "json",
                        data: {
                            plant: plant,
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $('#trt_KCardMan').combobox('loadData', data);

                        }
                    });
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "${ctxPath }/Syb/CMan.action",
                        dataType: "json",
                        data: {
                            plant: plant,
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $('#trt_CZMan').combobox('loadData', data);

                        }
                    });
                }

            }
        })
        $("input[name='ColdCheck']").eq(0).attr("checked","checked");
        $("#trt_More").hide();
        $("#trt_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#trt_More").hide();

        });

//        $("#trt_toolbar").blur(function(){
//            $("#trt_More").toggle();
//        })
    });

    function trt_back() {
        if (SelectState!=2){
            $.messager.alert('温馨提示', '请先进行出库查询!');
        }else {
            var row = $('#trt_dgm').datagrid("getSelected");
            //alert(row.id);
            if (row === null) {
                $.messager.alert('温馨提示', '请选择有效的行项目!');
            } else {
                $.messager.confirm('温馨提示', '你确定要退回吗?', function (r) {
                    if (r) {
                        if (row.id === undefined) {
                            if (editIndex == undefined) {
                                return
                            }
                            $('#trt_dgm').datagrid('cancelEdit', editIndex)
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
                                        trt_forGetOutDate();
                                    }
                                }
                            });
                        }
                    }
                })
            }
        }
    }
    function trt_showMore() {
        $("#trt_More").toggle();
    }

    function trt_Z03FormCreate(){
        var row = $("#trt_dgm").datagrid("getSelected");
        var selrows = $("#trt_dgm").datagrid("getChecked");
        var entities = "";
        if($("#trt_Z003FormJiaoHuo").val() !==null && $("#trt_Z003FormJiaoHuo").val().trim() !==""){
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
                        $("#trt_Z003FormJiaoHuo").textbox("setValue",result.VBELN);
                        trt_forGetOutDate();
                       // window.location.reload();
////                        $("#trt_Z003FormJiaoHuoItem").textbox("setValue",result.POSNR);
//                        jQuery.ajax({
//                            type: "POST",   //post提交方式默认是get
//                            url: '/TakeReport/updateOutMsg.action',
//                            dataType: "json",
//                            data: {
////                                id:row.id,
//                                vbeln:result.VBELN,
//                                entities:entities
////                                posnr:result.POSNR,
////                                cgvbeln:$("#trt_Z03FormPoNo").val(),
////                                cgposnr:$("#trt_Z03FormPoitem").val()
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

    function trt_Z03FormSave() {
        if($("#trt_Z003FormJiaoHuo").val() ===null ||$("#trt_Z003FormJiaoHuo").val() ===""){
            $.messager.alert('温馨提示', '还未创建交货单，不能进行过账操作！！！！');
        }else{
            var selrows = $("#trt_dgm").datagrid("getChecked");
            var entities = "";
            var row = $("#trt_dgm").datagrid("getSelected");
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
//                                        var rowIndex = $("#trt_dgm").datagrid('getRowIndex',row.id);
//                                        var data =  $("#trt_dgm").datagrid('getData').rows[rowIndex];
//                                        data.ismove = 0;
//                                        data.moveok = 0;
//                                        $('#trt_dgm').datagrid('refreshRow',rowIndex);
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
                                var outfreshrowIndex = $("#trt_dgm").datagrid('getRowIndex',selrows[n].id);
                                var data =  $("#trt_dgm").datagrid('getData').rows[outfreshrowIndex];
                                data.ismove = true;
                                data.moveok = false;
                                $('#trt_dgm').datagrid('refreshRow',outfreshrowIndex);
                            }



                            $.messager.alert('温馨提示', '过账成功！！！');
                            $("#trt_SapOutDivZ03").dialog('close');
                        }else{
                            $.messager.alert('温馨提示', '过账失败！！！');
                        }
                    },
                    error:function(){
                        $.messager.alert('温馨提示', '出错了！！！');
                    }
                })
            }

        }

    }

    function trt_Z03FormBack(){
        $("#trt_SapOutDivZ03").dialog('close');
    }
    function trt_SapTakeIn() {
        if (SelectState!=1){
            $.messager.alert('温馨提示', '请先进行入库查询!');
        }else {
            var row = $("#trt_dgm").datagrid("getSelected");
            if(row === null){
                $.messager.alert('温馨提示', '请先选择有效的行项目!');
            }else{
                sapaginst = false;

                var fno = row.fno;
                var TakeNumber = row.number;
                var HalfPartFormMoveType = "311";
                var HalfPartFormMoveTypeReal = "311";
                var HalfPartFormOutPlace = "2510";
                var HalfPartFormTakePlace = "2501";
                $('#trt_FormFno').textbox('setValue',fno);
                $('#trt_FormTakeNumber').textbox('setValue',TakeNumber);
                $('#trt_FormOutPlace').textbox('setValue',HalfPartFormOutPlace);
                $('#trt_FormTakePlace').textbox('setValue',HalfPartFormTakePlace);
                $('#trt_FormMoveType').textbox('setValue',HalfPartFormMoveType);
                $('#trt_FormMoveTypeReal').textbox('setValue',HalfPartFormMoveTypeReal);
                $("#trt_SapOutBack").dialog('open');
            }
        }
    }

    function trt_SapTakeOut() {
        if (SelectState!=2){
            $.messager.alert('温馨提示', '请先进行出库查询!');
        }else {
            var row = $("#trt_dgm").datagrid("getSelected");
            var selrows = $("#trt_dgm").datagrid("getChecked");
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
                    $('#trt_FormFno').textbox('setValue',fno);
                    $('#trt_FormTakeNumber').textbox('setValue',TakeNumber);
                    $('#trt_FormOutPlace').textbox('setValue',HalfPartFormOutPlace);
                    $('#trt_FormTakePlace').textbox('setValue',HalfPartFormTakePlace);
                    $('#trt_FormMoveType').textbox('setValue',HalfPartFormMoveType);
                    $('#trt_FormMoveTypeReal').textbox('setValue',HalfPartFormMoveTypeReal);
                    $("#trt_SapOutBack").dialog('open');
                }else {
                    var entities = "";

                    for (var i = 1; i < selrows.length; i++) {
                        rowone = selrows[i];
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
                        $('#trt_Z003FormJiaoHuo').textbox('setValue',jhvbelnfirst);
                        $('#trt_Z003FormJiaoHuoItem').textbox('setValue',posnrAll);
                        $('#trt_Z03FormPoNo').textbox('setValue',vbelnfirst);
                        $('#trt_Z03FormPoitem').textbox('setValue',cgposnrAll);
                        $("#trt_SapOutDivZ03").dialog('open');
                    }
                }

            }
        }
    }

    function trt_SapTakeInBack() {
        if (SelectState!=1){
            $.messager.alert('温馨提示', '请先进行入库查询!');
        }else {
            var row = $("#trt_dgm").datagrid("getSelected");
            if(row === null){
                $.messager.alert('温馨提示', '请先选择有效的行项目!');
            }else{
                sapaginst = true;
                var fno = row.fno;
                var TakeNumber = row.number;
                var HalfPartFormMoveType = "312";
                var HalfPartFormMoveTypeReal = "311";
                var HalfPartFormOutPlace = "2510";
                var HalfPartFormTakePlace = "2501";
                $('#trt_FormFno').textbox('setValue',fno);
                $('#trt_FormTakeNumber').textbox('setValue',TakeNumber);
                $('#trt_FormOutPlace').textbox('setValue',HalfPartFormOutPlace);
                $('#trt_FormTakePlace').textbox('setValue',HalfPartFormTakePlace);
                $('#trt_FormMoveType').textbox('setValue',HalfPartFormMoveType);
                $('#trt_FormMoveTypeReal').textbox('setValue',HalfPartFormMoveTypeReal);
                $("#trt_SapOutBack").dialog('open');
            }
        }
    }

    function trt_SapTakeOutBack() {
        if (SelectState!=2){
            $.messager.alert('温馨提示', '请先进行出库查询!');
        }else {
            var row = $("#trt_dgm").datagrid("getSelected");
            if(row === null){
                $.messager.alert('温馨提示', '请先选择有效的行项目!');
            }else{
                var fdStart = row.outadd.indexOf("2");
                sapoutputagainst = true;
                if(fdStart === 0) {
                    var fno = row.fno;
                    var TakeNumber = row.outnumber;
                    var HalfPartFormMoveType = "302";
                    var HalfPartFormMoveTypeReal = "301";
                    var HalfPartFormOutPlace = "2501";
                    var HalfPartFormTakePlace = row.outadd;
                    $('#trt_FormFno').textbox('setValue',fno);
                    $('#trt_FormTakeNumber').textbox('setValue',TakeNumber);
                    $('#trt_FormOutPlace').textbox('setValue',HalfPartFormOutPlace);
                    $('#trt_FormTakePlace').textbox('setValue',HalfPartFormTakePlace);
                    $('#trt_FormMoveType').textbox('setValue',HalfPartFormMoveType);
                    $('#trt_FormMoveTypeReal').textbox('setValue',HalfPartFormMoveTypeReal);
                    $("#trt_SapOutBack").dialog('open');
                }else{
                    $.messager.alert('温馨提示', '暂不支持Z03交货冲销！！！!');
                }
            }
        }
    }
    function trt_FormMove() {
        var row = $("#trt_dgm").datagrid("getSelected");
        if(sapinput === true){
            if(sapaginst ===false){
                if(row.ismove === true){
                    $.messager.alert('温馨提示', '此记录已经完成了SAP入库！！！!');
                }else{
                    $.messager.confirm('温馨提示', '你确定要移库吗?', function (r) {
                        if (r) {
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/ColdSapRFC/ColdTakeInSap.action',
                                dataType: "json",
                                data: {
                                    p_MATNR:$('#trt_FormFno').val(),
                                    FromAdd:$('#trt_FormOutPlace').val(),
                                    ToAdd:$('#trt_FormTakePlace').val(),
                                    MoveType:$('#trt_FormMoveTypeReal').val(),
                                    PPNum:$('#trt_FormTakeNumber').val(),
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
                                                TakeNumber:row.number,
                                                UserName:localStorage.getItem("User"),
                                                plant:"材料零件",
                                                TakeMan:row.inputman,
                                                TakeDate:row.inputdate,
                                                fname:row.fname,
                                                state:1,
                                                againstkind:"原材料库SAP入库",
                                            },
                                            success: function (Numdata) {
                                                if(Numdata.Num ===1){
                                                    var rowIndex = $("#trt_dgm").datagrid('getRowIndex',row.id);
                                                    var data =  $("#trt_dgm").datagrid('getData').rows[rowIndex];
                                                    data.ismove = true;
                                                    data.moveok = false;
                                                    data.moveman = localStorage.getItem("User");
                                                    $('#trt_dgm').datagrid('refreshRow',rowIndex);
                                                    $.messager.alert('温馨提示',"移库成功");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }else{
                                                    $.messager.alert('温馨提示',"请联系管理员！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }
                                            }
                                        });
//                            $.messager.alert('温馨提示',result.result);
                                    }else{
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: '${ctxPath }/ColdSapRFC/insertSapMessFail.action',
                                            dataType: "json",
                                            data: {
                                                id:row.id,
                                                UserName:localStorage.getItem("User"),
                                            },
                                            success: function (NumdataFail) {
                                                var rowIndex = $("#trt_dgm").datagrid('getRowIndex',row.id);
                                                var data =  $("#trt_dgm").datagrid('getData').rows[rowIndex];
                                                data.ismove = false;
                                                data.moveok = true;
                                                $('#trt_dgm').datagrid('refreshRow',rowIndex);
                                                $.messager.alert('温馨提示',"移库失败");
                                            }
                                        });
                                    }

                                }
                            });
                        }
                    });
                }

            }else{
                if(row.ismove === false){
                    $.messager.alert('温馨提示', '此记录不需要冲销！！！!');
                }else{
                    $.messager.confirm('温馨提示', '你确定要冲销吗?', function (r) {
                        if (r) {
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/ColdSapRFC/ColdTakeInSap.action',
                                dataType: "json",
                                data: {
                                    p_MATNR:$('#trt_FormFno').val(),
                                    FromAdd:$('#trt_FormOutPlace').val(),
                                    ToAdd:$('#trt_FormTakePlace').val(),
                                    MoveType:$('#trt_FormMoveTypeReal').val(),
                                    PPNum:$('#trt_FormTakeNumber').val(),
                                    MDW:"KG",
                                    isback:"true"
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
                                                TakeNumber:row.number,
                                                UserName:localStorage.getItem("User"),
                                                plant:"材料零件",
                                                TakeMan:row.inputman,
                                                TakeDate:row.inputdate,
                                                fname:row.fname,
                                                state:2,
                                                againstkind:"原材料库SAP入库冲销",
                                            },
                                            success: function (Numdata) {
                                                if(Numdata.Num ===1){
                                                    var rowIndex = $("#trt_dgm").datagrid('getRowIndex',row.id);
                                                    var data =  $("#trt_dgm").datagrid('getData').rows[rowIndex];
                                                    data.ismove = false;
                                                    data.moveok = false;
                                                    $('#trt_dgm').datagrid('refreshRow',rowIndex);
                                                    $.messager.alert('温馨提示',"冲销成功！！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }else{
                                                    $.messager.alert('温馨提示',"请联系管理员！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }
                                            }
                                        });
                                    }else{
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: '${ctxPath }/ColdSapRFC/insertSapMessFail.action',
                                            dataType: "json",
                                            data: {
                                                id:row.id,
                                                UserName:localStorage.getItem("User"),
                                            },
                                            success: function (NumdataFail) {
                                                $.messager.alert('温馨提示',"移库失败");
                                            }
                                        });
                                    }

                                }
                            });
                        }
                    });
                }

            }
        }else if(sapoutput === true) {
            if(sapoutputagainst ===false){
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
                                    p_MATNR:$('#trt_FormFno').val(),
                                    FromAdd:$('#trt_FormOutPlace').val(),
                                    ToAdd:$('#trt_FormTakePlace').val(),
                                    MoveType:$('#trt_FormMoveTypeReal').val(),
                                    PPNum:$('#trt_FormTakeNumber').val(),
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
                                                    var rowIndex = $("#trt_dgm").datagrid('getRowIndex',row.id);
                                                    var data =  $("#trt_dgm").datagrid('getData').rows[rowIndex];
                                                    data.ismove = true;
                                                    data.moveok = false;
                                                    data.moveman = localStorage.getItem("User");
                                                    $('#trt_dgm').datagrid('refreshRow',rowIndex);
                                                    $.messager.alert('温馨提示',"移库成功！！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }else{
                                                    $.messager.alert('温馨提示',"请联系管理员！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }
                                            }

                                        });

//                            $.messager.alert('温馨提示',result.result);
                                    }else{
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: '${ctxPath }/ColdSapRFC/insertSapMessOutFail.action',
                                            dataType: "json",
                                            data: {
                                                id:row.id,
                                                UserName:localStorage.getItem("User"),
                                            },
                                            success: function (NumdataFail) {
                                                $.messager.alert('温馨提示',result.result);
                                                $("#trt_SapOutBack").dialog('close');
                                                Out();
                                            }
                                        });
                                    }

                                }
                            });
                        }
                    });
                }

            }else{
                if(row.ismove === false){
                    $.messager.alert('温馨提示', '此记录不需要冲销！！！!');
                }else{
                    $.messager.confirm('温馨提示', '你确定要冲销吗?', function (r) {
                        if (r) {
                            jQuery.ajax({
                                type: "POST",   //post提交方式默认是get
                                url:'${ctxPath }/ColdSapRFC/ColdTakeInSap.action',
                                dataType: "json",
                                data: {
                                    p_MATNR:$('#trt_FormFno').val(),
                                    FromAdd:$('#trt_FormOutPlace').val(),
                                    ToAdd:$('#trt_FormTakePlace').val(),
                                    MoveType:$('#trt_FormMoveTypeReal').val(),
                                    PPNum:$('#trt_FormTakeNumber').val(),
                                    MDW:"KG",
                                    isback:"true"
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
                                                uyear:row.year,
                                                umonth:row.month,
                                                TakeNumber:row.outnumber,
                                                UserName:localStorage.getItem("User"),
                                                plant:"材料零件",
                                                OutPutMan:row.outputman,
                                                OutPutDate:row.outputdate,
                                                OutAdd:row.outadd,
                                                fname:row.fname,
                                                state:4,
                                                againstkind:"原材料库SAP发出冲销",
                                            },
                                            success: function (Numdata) {
                                                if(Numdata.Num ===1){
                                                    var rowIndex = $("#trt_dgm").datagrid('getRowIndex',row.id);
                                                    var data =  $("#trt_dgm").datagrid('getData').rows[rowIndex];
                                                    data.ismove = false;
                                                    data.moveok = false;
                                                    $('#trt_dgm').datagrid('refreshRow',rowIndex);
                                                    $.messager.alert('温馨提示',"冲销成功！！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }else{
                                                    $.messager.alert('温馨提示',"请联系管理员！");
                                                    $("#trt_SapOutBack").dialog('close');
                                                }
                                            }
                                        });
                                        Out();
//                            $.messager.alert('温馨提示',result.result);
                                    }else{
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: '${ctxPath }/ColdSapRFC/insertSapMessOutFail.action',
                                            dataType: "json",
                                            data: {
                                                id:row.id,
                                                UserName:localStorage.getItem("User"),
                                            },
                                            success: function (NumdataFail) {
                                                $.messager.alert('温馨提示',result.result);
                                                Out();
                                            }
                                        });
                                    }

                                }
                            });
                        }
                    });
                }

            }
        }
    }
    function trt_FormNotMove() {
        $("#trt_SapOutBack").dialog('close');
    }
    function trt_forGetInDate(){
        sapinput = true;
        sapoutput = false;
        $('#trt_dgm').datagrid('loadData', { total: 0, rows: [] });
        var state = $('input[name="ColdCheck"]:checked').val();
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/TakeReport/selectColdmaterlinBydate.action",//要发送的后台地址
            data: {
                plant:$('#trt_Plant').combobox('getText'),
                UserName:localStorage.getItem('User'),
                fno:$('#trt_fno').val(),
                fname:$('#trt_fname').val(),
                begindate:$('#trt_db1').val(),
                enddate:$('#trt_db2').val(),
                state:state
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $("#trt_dgm").datagrid({
                    idField:'id',
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,

                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    loadFilter:trt_pagerFilter,
                    columns:[[
                        {field:'id',title:'序号',width:50,sortable: true},
                        {field:'serialno',title:'编号',width:70,sortable: true},
                        {field:'pono',title:'采购订单号',width:100,sortable: true},
                        {field:'poitem',title:'采购订单行项目',width:100,sortable: true},
                        {field:'fno',title:'物料编码',width:100,sortable: true},
                        {field:'fname',title:'物料描述',width:300,sortable: true},
                        {field:'number',title:'收货数量',width:100,sortable: true},
                        {field:'batchno',title:'炉批号',width:100,sortable: true},
                        {field:'ponumber',title:'订单数量',width:100,sortable: true},
                        {field:'takenumber',title:'已收数量',width:100,sortable: true},
                        {field:'leftnumber',title:'剩余数量',width:100,sortable: true},
                        {field:'isok',title:'确认收货',width:100,sortable: true},
                        {field:'lgort',title:'收货地点',width:110,sortable: true},
                        {field:'unit',title:'单位',width:50,sortable: true},
                        {field:'inputman',title:'录入人',width:100,sortable: true},
                        {field:'inputdate',title:'录入时间',width:150,sortable: true},
                        {field:'ismove',title:'SAP移库',width:80, sortable: true},
                        {field:'moveman',title:'SAP移库人',width:80, sortable: true},
                        {field:'movedate',title:'SAP移库时间',width:160,sortable: true},
                        {field:'plant',title:'事业部',width:100, sortable: true},
                        {field:'uplimit',title:'过量限度',width:130,sortable: true},
                        {field:'downlimit',title:'不足限度',width:80, sortable: true},
                        {field:'isdone',title:'收货完成',width:160, sortable: true},
                        {field:'uyear',title:'年度',width:80,hidden:true, sortable: true},
                        {field:'umonth',title:'月度',width:60,hidden:true,sortable: true},
                        {field:'supportno',title:'供应商编码',width:100,sortable: true},
                        {field:'supportname',title:'供应商名称',width:130,sortable: true},
                        {field:'ekorg',title:'采购组织',width:100,sortable: true},
                        {field:'ekorgname',title:'采购组织描述',width:130,sortable: true},
                        {field:'ekgrp',title:'采购组',width:100,sortable: true},
                        {field:'ekgrpname',title:'采购组描述',width:100,sortable: true},
                        {field:'pocreattime',title:'采购订单创建时间',width:100,sortable: true},
                        {field:'bukrs',title:'公司代码',width:100,sortable: true},
                        {field:'moveok',title:'移库失败',width:100,sortable: true},
                        {field:'returnok',title:'退货失败',width:100,sortable: true},
                        {field:'stocktype',title:'库存状态',width:100,sortable: true},
                        {field:'materialdoc',title:'物料凭证',width:100,sortable: true},
                        {field:'materialdocyear',title:'凭证年度',width:100,sortable: true},
                        {field:'materialdocitem',title:'凭证行',width:100,sortable: true},

                        {field:'istrans',title:'质检至非限制',width:100,sortable: true},
                        {field:'transman',title:'质检转换人',width:100,sortable: true},
                        {field:'transdate',title:'质检转换时间',width:100,sortable: true},
                        {field:'moneystate',title:'估价标示',width:100,sortable: true},
                        {field:'netpr',title:'净价',width:100,sortable: true},
                        {field:'peinh',title:'价格单位',width:100,sortable: true},
                        {field:'zsum',title:'总金额',width:100,sortable: true},
                        {field:'location',title:'库位',width:100,sortable: true}
                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',
                });
                $('#trt_dgm').datagrid({
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
        SelectState = 1;
    }

    function trt_forGetOutDate() {
        sapinput = false;
        sapoutput = true;
        $('#trt_dgm').datagrid('loadData', { total: 0, rows: [] });
        var state = $('input[name="ColdCheck"]:checked').val();
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/TakeReport/selectColdOutBydate.action",//要发送的后台地址
            data: {
                plant:$('#trt_Plant').combobox('getText'),
                UserName:localStorage.getItem('User'),
                fno:$('#trt_fno').val(),
                outadd:$('#trt_outadd').val(),
                begindate:$('#trt_db1').val(),
                enddate:$('#trt_db2').val(),
                vbeln:$("#trt_cgvbelncx").val(),
                state:state
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $("#trt_dgm").datagrid({
                    idField:'id',
                    rownumbers:true,
                    singleSelect:true,
                    multiSort:true,
                    remoteSort:false,
                    pagination:true,
                    checkOnSelect:true,
                    selectOnCheck:false,
                    autoRowWidth: true,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    loadFilter:trt_pagerFilter,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'ck',checkbox:'true'},
                        {field:'id',title:'序号',width:50},

                        {field:'serialno',title:'编号',width:70},
                        {field:'fno',title:'物料编码',editor:'text',width:100, sortable: true},


                        {field:'fname',title:'物料名称',width:300},
                        {field:'outnumber',title:'出库数量',editor:'text',width:100,sortable: true},
                        {field:'plant',title:'事业部',width:100,},

                        {field:'outadd',title:'出库地点',width:100,editor:'text', sortable: true},
                        {field:'outaddname',title:'出库地点',width:100,},
                        {field:'outputman',title:'出库人',width:100},
                        {field:'outputdate',title:'出库时间',width:100,editor:'text',sortable: true},
                        {field:'ismove',title:'SAP移库',width:100},
                        {field:'moveman',title:'移库人',width:100},
                        {field:'movedate',title:'移库时间',width:100},
                        {field:'year',title:'年份',hidden:true,width:100},
                        {field:'month',title:'月份',hidden:true,width:100},

                        {field:'moveok',title:'移库失败',width:100},
                        {field:'moveback',title:'移库冲销',width:100},
                        {field:'movebackman',title:'冲销人',hidden:true,width:100},
                        {field:'movebackdate',title:'冲销时间',hidden:true,width:100},
                        {field:'istake',title:'接收',width:100},
                        {field:'takeman',title:'接收人',hidden:true,width:100},
                        {field:'takedate',title:'接收时间',hidden:true,width:100},

                        {field:'location',title:'出库库位',width:100},
                        {field:'isapp',title:'手机出库',hidden:true,width:100},
                        {field:'vbeln',title:'交货单',width:100},
                        {field:'posnr',title:'行号',width:100},
                        {field:'cgvbeln',title:'采购订单单',width:100},
                        {field:'cgposnr',title:'采购行号',width:100},
                        {field:'isdelete',title:'删除标识',hidden:true,width:100},

                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',
                });
                $('#trt_dgm').datagrid({
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
        SelectState = 2;
    }
    function trt_export() {
        if(SelectState === 0){
            $.messager.alert('温馨提示', '请先进行查询操作!');
        }else{
            var plant=$('#trt_Plant').combobox('getText');
            var UserName=localStorage.getItem('User');
            var   fno=$('#trt_fno').val();
            var   fname=$('#trt_fname').val();
            var  begindate=$('#trt_db1').val();
            var  enddate=$('#trt_db2').val();
            var url = "${ctxPath }/TakeReport/trcexport.action?plant=" + plant + "&fno=" + fno + "&fname="+ fname +"&begindate="+ begindate +"&enddate=" + enddate +"&SelectState="+SelectState+"";
            window.location.href = url;
        }
    }
    var editIndex = undefined;
    function onClickRow(index){
        if (editIndex != index){
            var row = $("#trt_dgm").datagrid("getSelected");
            $('#trt_ff').form('load',{
                id:row.id,
                fno:row.fno,
                inputnum:row.inputnum,
                takenum:row.takenum,
                inputNumKG:row.inputNumKG,
                unit:row.unit,
                ReportMan:row.ReportMan,
                AssScanNum:row.AssScanNum,
                SplitF3:row.SplitF3,
                equipment:row.equipment,
                ConnectZore:row.ConnectZore,
                isok:row.isok,
                ismix:row.ismix,
                PartDrawing:row.PartDrawing,
                itemno:row.itemno,
                SAPSDOrder:row.SAPSDOrder,
                inputman:row.inputman,
                inputdate:row.inputdate,
                F3:row.F3,
                Descrip:row.Descrip,
                TempInfo:row.TempInfo,
                fname:row.fname,
                dhorderno:row.dhorderno,
                OrderTime:row.OrderTime,
                surenum:row.surenum,
                takeman:row.takeman,
                takedate:row.takedate,
                dutyman:row.dutyman,
                plant:row.plant,
                planid:row.planid,
                Color:row.Color
            });
            $.ajax({
                type: "get",
                url: "${ctxPath }/KCard/queryCZG.action?plant=" + $('#trt_Plant').combobox('getText') + "&&worklead=" + row.dutyman + "",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    $('#trt_ReportMan').combobox('loadData', data);
                }
            });

            editIndex = index;
        }
    }
    function trt_pagerFilter(data){
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
            showRefresh:false,
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
    function trt_Print() {
        if(SelectState !=1){
            $.messager.alert('温馨提示', '请先进行入库查询!');
        }else {
            var row = $("#trt_dgm").datagrid("getSelected");
//        row.IsPrint = '1';
//        $.ajax({
//            type: "post",//数据发送的方式（post 或者 get）
//            url: "/KCard/updateDY.action",//要发送的后台地址
//            data: {
//                id:row.id,
//                IsPrint:row.IsPrint
//            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//            }
//        });
//        $('#kc').datagrid('refreshRow', editIndex);
            var tarValue = "[{reportlet:'/SD/CGRKDY.cpt',id:'"+row.id+"'}]";
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
    }
</script>