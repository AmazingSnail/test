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
</style>
<div class="easyui-layout" data-options="fit:true">

    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <iframe id="proxy2" style="display:none"></iframe>
        <div class="easyui-panel" title="串装入库" data-options="fit:true">
            <div id="CZRku_toolbar"  style="overflow:auto;width:100%;height: 90px">
                <div class="wu-toolbar-button">
                    <!--   <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="openAdd()" plain="true">添加</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="openEdit()" plain="true">修改</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="remove()" plain="true">删除</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()" plain="true">取消</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reload()" plain="true">刷新</a>-->
<shiro:hasPermission name="/RuKu/CZ">
                    <a href="#" class="easyui-linkbutton"  onclick="forCZOK()" data-options="iconCls:'icon-ok'" plain="true">串装确认</a>
                    <a href="#" class="easyui-linkbutton"  onclick="forCZCX()" data-options="iconCls:'icon-undo'" plain="true">串装冲销</a>
</shiro:hasPermission>
<shiro:hasPermission name="/RuKu/RK">
                    <a href="#" class="easyui-linkbutton"  onclick="forRKOK()" data-options="iconCls:'icon-ok'" plain="true">装配入库</a>
                    <a href="#" class="easyui-linkbutton"  onclick="forRKCX()" data-options="iconCls:'icon-undo'" plain="true">装配冲销</a>
</shiro:hasPermission>
                    <span>丨</span>
<shiro:hasPermission name="/RuKu/Change">
                    <a href="#" class="easyui-linkbutton"  onclick="assemblyshowEdit()" data-options="iconCls:'icon-edit'" plain="true">修改数据</a>
                    <a href="#" class="easyui-linkbutton"  onclick="assemblyshowDelete()" data-options="iconCls:'icon-delete'" plain="true">删除卡</a>
</shiro:hasPermission>
<shiro:hasPermission name="/RuKu/Print">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="CZRku_Print()" plain="true">补卡打印</a>
</shiro:hasPermission>
                    <!--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>-->
                    <!--     <a href="#" class="easyui-linkbutton" iconCls="icon-undo" onclick="remove()" plain="true">撤销</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-redo" onclick="cancel()" plain="true">重做</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-sum" onclick="reload()" plain="true">总计</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-back" onclick="reload()" plain="true">返回</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-tip" onclick="reload()" plain="true">提示</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="reload()" plain="true">保存</a>
                       <a href="#" class="easyui-linkbutton" iconCls="icon-cut" onclick="reload()" plain="true">剪切</a>-->
                </div>
                <div class="wu-toolbar-search" >

                    <div style="white-space:nowrap">
                        <label>起始时间：</label><input  id ="CZRku_db1" style="width:110px" class="easyui-datebox">&nbsp
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="CZRku_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>开卡人：</label>
                        <select class="easyui-combobox" name="KCardMan" datatype="text" id="CZRku_KCardMan" panelHeight="auto" data-options="
                            url:'/Syb/KMan.action',
                            method:'post',
                            valueField:'inputman',
                            textField:'inputman',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>物料编码：</label><input id="CZRku_fno" class="wu-text" style="width:100px">&nbsp

                        <label>厂编合同：</label><input id="CZRku_dhorderno" class="wu-text" style="width:100px">&nbsp

                        <label>编号：</label><input id="CZRku_serialno" class="wu-text" style="width:100px">&nbsp

                    </div>
                    <div style="white-space:nowrap">
                        <label>结束时间：</label><input  id ="CZRku_db2" style="width:110px" class="easyui-datebox">&nbsp
                        <label>规&nbsp&nbsp&nbsp&nbsp格：</label><input id="CZRku_PartDrawing" class="wu-text" style="width:95px">&nbsp

                        <label>串装工：</label>
                        <select class="easyui-combobox" name="CZMan" datatype="text" id="CZRku_CZMan" panelHeight="auto" data-options="
                            url:'/Syb/CMan.action',
                            method:'get',
                            valueField:'ReportMan',
                            textField:'ReportMan',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>物料描述：</label><input id="CZRku_fname" class="wu-text" style="width:100px">&nbsp
                        <label><input type="radio" name="MDMCZRkuCheck" value="3" />全部查询</label>
                        <label><input type="radio" name="MDMCZRkuCheck" value="1" />未确认</label>
                        <label><input type="radio" name="MDMCZRkuCheck" value="2" />未入库</label>
                        <label><input type="radio" name="MDMCZRkuCheck" value="4" />已确认</label>
                        <label><input type="radio" name="MDMCZRkuCheck" value="5" />已入库</label>
                        <a href="#" class="easyui-linkbutton"  onclick="forGetDate()" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" class="easyui-linkbutton"  onclick="showMore()" data-options="iconCls:'icon-search'">更多</a>
                    </div>
                    <div style="position:absolute;z-index:1001;background-color: white;display: none" id="CZRku_More">
                        <label>物料编码：</label><input  class="wu-text" style="width:100px">&nbsp

                        <label>厂编合同：</label><input  class="wu-text" style="width:100px">&nbsp
                    </div>




                    <!--class="easyui-datebox"-->

                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <div class="easyui-layout" data-options="fit:true" >
                <div class="cz" >
                    <!-- <table class="easyui-datagrid" title="Basic DataGrid" style="white-space: nowrap; "
                            data-options="singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'">
                         <thead>
                         <tr>
                             <th data-options="field:'itemid',width:80">Item ID</th>
                             <th data-options="field:'productid',width:90">Product</th>
                             <th data-options="field:'listprice',width:80,align:'right'">List Price</th>
                             <th data-options="field:'unitcost',width:80,align:'right'">Unit Cost</th>
                             <th data-options="field:'status',width:60,align:'center'">Status</th>
                             <th data-options="field:'listprice',width:80,align:'right'">List Price</th>
                             <th data-options="field:'unitcost',width:80,align:'right'">Unit Cost</th>
                             <th data-options="field:'status',width:60,align:'center'">Status</th>
                         </tr>
                         </thead>
                     </table>-->
                    <table id="CZRku_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 63%" title="串装入库  (绿字代表：已确认未入库。绿背景代表：已确认入库)" data-options="singleSelect:true,onClickRow:onClickRow"></table>
                    <div id="assemblyshowedit" class="easyui-dialog" title="修改数据" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:260px;height:250px;padding:10px">
                        <from>
                            <table cellpadding="5" width="auto" style="white-space:nowrap" >
                                <td>
                                    <tr>
                                        <td>合同及行号:</td>
                                        <td><input class="easyui-textbox" type="text" name="FormItemno" id="assemblyshowFormItemno"  style="width:150px" disabled=true></input></td>
                                    </tr>
                                    <tr>
                                        <td>串装工:</td>
                                        <td><input class="easyui-textbox" type="text" name="FormReportMan" id="assemblyshowFormReportMan" style="width:150px" ></input></td>
                                    </tr>
                                    <tr>
                                        <td>原开卡数:</td>
                                        <td><input class="easyui-textbox" type="text" name="FormInputnum" id="assemblyshowFormInputnum" style="width:150px" disabled=true></input></td>
                                    </tr>
                                    <tr>
                                        <td>修改开卡数:</td>
                                        <td><input class="easyui-textbox" type="text" name="FormInputnumN" id="assemblyshowFormInputnumN" style="width:150px"  ></input></td>
                                    </tr>
                                    <tr>
                                        <td>装配交货期:</td>
                                        <td><input class="easyui-textbox" type="text" name="FormOrderTime" id="assemblyshowFormOrderTime" style="width:150px"  ></input></td>
                                    </tr>

                                    <tr >
                                        <td><input class="easyui-textbox" type="hidden" name="id" id="assemblyshowFormId"  style="width:0px" ></input></td>
                                        <td ><a class="easyui-linkbutton" type="text" style="width: 100px" name="Save" onclick="assemblyshowUpdate()" id="FormSave" data-options="iconCls:'icon-save'" >保存</a></td>

                                    </tr>
                                </td>
                            </table>
                        </from>
                    </div>
                    <div style="overflow:auto;width:100%;height:25%" title="详细信息" class="easyui-panel"   >
                        <form id="CZRku_ff" method="post">
                            <table cellpadding="5" width="auto" style="white-space:nowrap">
                                <tr>
                                    <td>编号:</td>
                                    <td><input class="easyui-textbox" type="text" name="id" data-options="required:true" disabled=true></input></td>
                                    <td>实际节数:</td>
                                    <td><input class="easyui-textbox" type="text" name="AssScanNum" data-options="required:true" disabled=true></input></td>
                                    <td>开卡数:</td>
                                    <td><input class="easyui-textbox" type="text" name="inputnum" data-options="required:true" disabled=true></input></td>
                                    <td>入库补卡数:</td>
                                    <td><input class="easyui-textbox" type="text" name="takenum" data-options="required:true" disabled=true></input></td>
                                    <td>开卡公斤数:</td>
                                    <td><input class="easyui-textbox" type="text" name="inputNumKG" data-options="required:true" disabled=true></input></td>

                                    <td>串装工:</td>
                                    <td>
                                        <input class="easyui-combobox" type="text" name="ReportMan" id="CZRku_ReportMan" data-options="required:true,
                                            valueField:'worker',
                                            textField:'worker'" disabled=true>
                                        </input>
                                    </td>
                                    <td>交货期:</td>
                                    <td><input class="easyui-textbox" type="text" name="OrderTime" data-options="required:true" disabled=true></input></td>

                                </tr>
                                <tr>
                                    <td>物料编码:</td>
                                    <td><input class="easyui-textbox" type="text" name="fno" data-options="required:true" disabled=true></input></td>

                                    <td>拆分节数:</td>
                                    <td><input class="easyui-textbox" type="text" name="SplitF3" data-options="required:true" disabled=true></input></td>
                                    <td>计划ID:</td>
                                    <td><input class="easyui-textbox" type="text" name="planid" data-options="required:true" disabled=true></input></td>
                                    <td>设备规格:</td>
                                    <td><input class="easyui-textbox" type="text" name="equipment" data-options="required:false" disabled=true></input></td>
                                    <td>串零:</td>
                                    <td><input class="easyui-textbox" type="text" name="ConnectZore" data-options="required:true" disabled=true></input></td>
                                    <!--<td>开卡确认:</td>-->
                                    <!--<td><input class="easyui-textbox" type="text" name="isok" data-options="required:true" disabled=true></input></td>-->
                                    <td>单位:</td>
                                    <td><input class="easyui-textbox" type="text" name="unit" data-options="required:true" disabled=true></input></td>
                                    <td>配组合件:</td>
                                    <td><input class="easyui-textbox" type="text" name="ismix" data-options="required:true" disabled=true></input></td>


                                </tr>
                                <tr>
                                    <td>合同及行号:</td>
                                    <td><input class="easyui-textbox" type="text" name="itemno" data-options="required:true" disabled=true></input></td>
                                    <td>销售订单号:</td>
                                    <td><input class="easyui-textbox" type="text" name="SAPSDOrder" data-options="required:true" disabled=true></input></td>
                                    <td>开卡人:</td>
                                    <td><input class="easyui-textbox" type="text" name="inputman" data-options="required:true" disabled=true></input></td>
                                    <td>开卡时间:</td>
                                    <td><input class="easyui-textbox" type="text" name="inputdate" data-options="required:true" disabled=true></input></td>
                                    <td>节数:</td>
                                    <td><input class="easyui-textbox" type="text" name="F3" data-options="required:true" disabled=true></input></td>
                                    <td>描述:</td>
                                    <td><input class="easyui-textbox" type="text" name="Descrip" data-options="required:true" disabled=true ></input></td>
                                    <td>颜色:</td>
                                    <td><input class="easyui-textbox" type="text" name="Color" data-options="required:true" disabled=true ></input></td>
                                </tr>
                                <tr>
                                    <td>厂编合同号:</td>
                                    <td><input class="easyui-textbox" name="dhorderno" data-options="required:true" disabled=true></input></td>
                                    <td>交货期:</td>
                                    <td><input class="easyui-textbox" name="OrderTime" data-options="required:true" disabled=true></input></td>
                                    <td>确认串装数:</td>
                                    <td><input class="easyui-textbox" name="surenum" data-options="required:true" disabled=true></input></td>
                                    <!--<td>包装接受人:</td>-->
                                    <!--<td><input class="easyui-textbox" name="takeman" data-options="required:false" disabled=true></input></td>-->
                                    <!--<td>包装接受时间:</td>-->
                                    <!--<td><input class="easyui-textbox" name="takedate" data-options="required:false" disabled=true></input></td>-->
                                    <td>责任人:</td>
                                    <td><input class="easyui-textbox" name="dutyman" data-options="required:true" disabled=true></input></td>
                                    <td>事业部:</td>
                                    <td><input class="easyui-textbox" name="plant" data-options="required:true" disabled=true></input></td>
                                    <td>物料描述:</td>
                                    <td><input class="easyui-textbox" type="text" name="fname" data-options="required:true" disabled=true></input></td>
                                    <td>规格:</td>
                                    <td><input class="easyui-textbox" type="text" name="PartDrawing" data-options="required:true" disabled=true></input></td>
                                </tr>
                                <!--<tr>-->
                                <!--<td><button class="easyui-linkbutton" style="width:100px">保存</button></td>-->
                                <!--</tr>-->
                            </table>
                        </form>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#CZRku_db1').val(year+"-"+month+"-01");
        //$('#CZRku_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#CZRku_db2').val(year+"-"+month+"-"+day);
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'/Syb/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#CZRku_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#CZRku_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#CZRku_KCardMan').combobox('clear');
                    $('#CZRku_CZMan').combobox('clear');
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "/Syb/KMan.action",
                        dataType: "json",
                        data: {
                            plant: plant,
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $('#CZRku_KCardMan').combobox('loadData', data);

                        }
                    });
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "/Syb/CMan.action",
                        dataType: "json",
                        data: {
                            plant: plant,
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $('#CZRku_CZMan').combobox('loadData', data);

                        }
                    });
                }

            }
        })
        $("input[name='MDMCZRkuCheck']").eq(0).attr("checked","checked");
        $("#CZRku_More").hide();
        $("#CZRku_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#CZRku_More").hide();

        });
//        $("#CZRku_toolbar").blur(function(){
//            $("#CZRku_More").toggle();
//        })
    });
    function showMore() {
        $("#CZRku_More").toggle();
    }
    function assemblyshowEdit() {
        var row = $("#CZRku_dgm").datagrid("getSelected");
        if(row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else{
            var itemno = row.itemno;
            var ReportMan = row.ReportMan;
            var inputnum = row.inputnum;
            var OrderTime = row.OrderTime;
            var id = row.id;
            $('#assemblyshowFormItemno').textbox('setValue',itemno);
            $('#assemblyshowFormReportMan').textbox('setValue',ReportMan);
            $('#assemblyshowFormInputnum').textbox('setValue',inputnum);
            $('#assemblyshowFormOrderTime').textbox('setValue',OrderTime);
            $('#assemblyshowFormInputnumN').textbox('setValue',"");
            $('#assemblyshowFormId').textbox('setValue',id);
            $('#assemblyshowedit').dialog('open');
        }
    }
    function assemblyshowUpdate(){
        var FormInputnumN = $("#assemblyshowFormInputnumN").val();
        var FormItemno = $("#assemblyshowFormItemno").val();
        var FormReportMan = $("#assemblyshowFormReportMan").val();
        var FormOrderTime = $("#assemblyshowFormOrderTime").val();
        var id = $('#assemblyshowFormId').val();
        var UpdateIndex = $('#CZRku_dgm').datagrid('getRowIndex',id);
        var UpdateData = $('#CZRku_dgm').datagrid('getData').rows[UpdateIndex];
        var OldInputnum = UpdateData.inputnum;
        var OldItemno = UpdateData.itemno;
        var OldReportMan = UpdateData.ReportMan;
        var OldOrderTime = UpdateData.OrderTime;
        var Oldplanid = UpdateData.planid;
        if(FormInputnumN===""||FormInputnumN===null||FormInputnumN===0){
            $.messager.alert('温馨提示', '修改开卡数不能为空或0！');
        }else if(FormItemno===""||FormReportMan===""|FormOrderTime===""){
            $.messager.alert('温馨提示', '修改数据不能为空！');
        }else{
            $.ajax({
                type: "POST",   //post提交方式默认是get
                url: "/KCard/updateCZRK.action",
                dataType: "json",
                data: {
                    id :id,
                    itemno: FormItemno,
                    inputnum: FormInputnumN,
                    ReportMan: FormReportMan,
                    OrderTime: FormOrderTime
                },
                error: function (request) {      // 设置表单提交出错
                    $.messager.alert('温馨提示', '系统异常请联系管理员!');

                },
                success: function (data) {
                    if(data.num>0){
                        $.ajax({
                            type: "POST",   //post提交方式默认是get
                            url: "/Mplan/updateCZRK.action",
                            dataType: "json",
                            data: {
                                id: Oldplanid,
                                FormInputnumN: FormInputnumN,
                                OldInputnum: OldInputnum
                            },
                            error: function (request) {      // 设置表单提交出错
                                $.ajax({
                                    type: "POST",   //post提交方式默认是get
                                    url: "/KCard/updateCZRK.action",
                                    dataType: "json",
                                    data: {
                                        id :id,
                                        itemno: OldItemno,
                                        inputnum: OldInputnum,
                                        ReportMan: OldReportMan,
                                        OrderTime: OldOrderTime
                                    }
                                });
                                $.messager.alert('温馨提示', '系统异常请联系管理员!');

                            },
                            success: function (YDdata) {
                                if(YDdata.num>0){
                                    $('#assemblyshowedit').dialog('close');
                                    UpdateData.inputnum = FormInputnumN;
                                    $('#CZRku_dgm').datagrid('refreshRow', UpdateIndex);
                                    $.messager.alert('温馨提示', '修改成功!');
                                }else{
                                    $.ajax({
                                        type: "POST",   //post提交方式默认是get
                                        url: "/KCard/updateCZRK.action",
                                        dataType: "json",
                                        data: {
                                            id :id,
                                            itemno: OldItemno,
                                            inputnum: OldInputnum,
                                            ReportMan: OldReportMan,
                                            OrderTime: OldOrderTime
                                        },
                                        error: function (request) {      // 设置表单提交出错
                                            $.messager.alert('温馨提示', '系统异常请联系管理员!');

                                        },
                                        success: function (OldData) {

                                        }
                                    });
                                    $.messager.alert('温馨提示', '月度修改失败!');
                                }
                            }
                        });
                    }else{
                        $.messager.alert('温馨提示', '修改失败!');
                    }
                }
            });
        }
    }
    function assemblyshowDelete() {
        var row = $("#CZRku_dgm").datagrid("getSelected");
        if(row===undefined|| row===null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else {
            var id = row.id;
            var planid = row.planid;
            var issure = row.issure;
            var IsTake = row.IsTake;
            var inputnum = row.inputnum;
            //alert(issure+"---------------------------------------------------------"+IsTake);
            $.ajax({
                type: "post",
                data: {
                    id: id
                },
                url: "/KCard/delete.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        $.ajax({
                            type: "get",//数据发送的方式（post 或者 get）
                            url: "/Mplan/updatekcth.action",//要发送的后台地址
                            data: {
                                id: planid,
                                CLNumber: parseInt(inputnum)
                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                            dataType: "json",//后台处理后返回的数据格式
//                            success: function (data) {//ajax请求成功后触发的方法
//                                if (data.num > 0) {
//
//                                }
//                            }
                        });
                        if(issure==='1'){
                            //alert(1);
                            $.ajax({
                                type: "get",
                                data:{
                                    id:planid,
                                    SumDayNum:inputnum,
                                    num:"2"
                                },
                                url:"/Mplan/updatecz.action",
                                dataType: "json"//后台处理后返回的数据格式
//                                success: function (data) {//ajax请求成功后触发的方法
//                                    if (data.num > 0) {
//                                        $.messager.alert('温馨提示', '串装冲销成功!');
//                                    }
//                                }
                            })
                        }
                        if(IsTake==="1"){
                            //alert(2);
                            $.ajax({
                                type: "get",
                                data:{
                                    id:planid,
                                    SumDayInput:inputnum,
                                    num:"2"
                                },
                                url:"/Mplan/updateruku.action",
                                dataType: "json"//后台处理后返回的数据格式
//                                success: function (data) {//ajax请求成功后触发的方法
//                                    if (data.num > 0) {
//                                        $.messager.alert('温馨提示', '装配冲销成功!');
//                                    }
//                                }
                            })
                        }
                        forGetDate();
                        $.messager.alert('温馨提示', '删除成功!');
                    }
                }
            })
        }
    }
    function forGetDate(){
        var a = null;

        var b = null;

        var type = $('input[name="MDMCZRkuCheck"]:checked').val();
        //alert(type);
        if(type ==='1'){
            a = 1;
        }
        if(type ==='2'){
            b = 1;
        }
        if(type ==='4'){
            a = 0;
        }
        if(type ==='5'){
            b = 0;
        }
        getKCardCZRK(a,b);
    }
    function getKCardCZRK(a,b) {
        var startTime = $('#CZRku_db1').val();
        var endTime = $('#CZRku_db2').val()+" 23:59:59";
        //var   plant= $('#plant').

        var dhorderno = $('#CZRku_dhorderno').val();
        var PartDrawing = $('#CZRku_PartDrawing').val();
        var fname = $('#CZRku_fname').val();
        var fno = $('#CZRku_fno').val();
        var serialno = $('#CZRku_serialno').val();
        var fdata;
        $.messager.progress({
            title:'请稍等',
            msg:'页面加载中...'
        });
        jQuery.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "/KCard/queryCZRK.action",//要发送的后台地址
            data: {
                startTime: startTime,
                endTime: endTime,
                plant: $('#CZRku_Plant').combobox('getText'),
                inputman:$('#CZRku_KCardMan').combobox('getText'),
                ReportMan:$('#CZRku_CZMan').combobox('getText'),
                dhorderno: dhorderno,
                PartDrawing: PartDrawing,
                fname: fname,
                fno: fno,
                serialno: serialno,
                issure:a,
                IsTake:b
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                fdata = data;
                $("#CZRku_dgm").datagrid({
                    idField:'id',
                    rownumbers: true,
                    singleSelect: true,
                    pageSize: 20,
                    pagination: true,
                    multiSort: true,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    remoteSort:false,
                    method: 'get',
                    loadMsg: "正在加载数据.....",
                    data: fdata,
                    id: 'kcard',
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    frozenColumns:[[
                        {field: 'serialno', title: '编号', width: 70, sortable: true},
                        {field: 'itemno', title: '合同及行号', width: 150,sortable: true},
                        {field: 'fno', title: '物料编码', width: 100, sortable: true},
                        {field: 'inputnum', title: '开卡数', editor: 'text', width: 60,sortable: true},
                    ]],
                    columns: [[
                        {field: 'id', title: '编号', width: 70,hidden:'true', sortable: true},

                        {field: 'takenum', title: '入库补卡数',hidden:'true', width: 60,sortable: true},
                        {field: 'inputNumKG', title: '开卡公斤数',hidden:'true', editor: 'text', width: 100},

                        {field: 'unit', title: '单位', width: 60},
                        {
                            field: 'ReportMan', title: '串装工', id: 'CZG', editor: {
                            type: 'combobox',
                            options: {
                                valueField: 'worker',
                                textField: 'worker',
                                method: 'get',
                                required: true
                            }
                        }, width: 60,sortable: true
                        },
                        {field: 'AssScanNum', title: '实际节数',hidden:'true', width: 100},
                        {field: 'SplitF3', title: '拆分节数',hidden:'true', width: 100},
                        {field: 'equipment', title: '设备规格',hidden:'true', width: 100},
                        {field: 'ConnectZore', title: '串零',hidden:'true', width: 100},

                        {field: 'isok', title: '开卡确认', formatter:function(value,row,index) {
                            if (value === '1') {
                                return "YES";
                            } else {
                                return "NO";
                            }
                        },hidden:'true',width: 100},
                        {field: 'ismix', title: '配组合件',hidden:'true', width: 100},
                        {field: 'PartDrawing', title: '规格', width: 150},
                        {field: 'fname', title: '物料描述', width: 150},

                        {field: 'inputman', title: '开卡人', width: 100,sortable: true},
                        {field: 'inputdate', title: '开卡时间', width: 100,sortable: true},
                        {field: 'F3', title: '节数', width: 60},
                        {field: 'OrderTime', title: '交货期',hidden:'true', width: 100},
                        {field: 'dhorderno', title: '厂编合同号', width: 100,sortable: true},
                        {field: 'Descrip', title: '描述', width: 200},
                        {field: 'TempInfo', title: '备注',hidden:'true', width: 100},
                        {field: 'SAPSDOrder', title: '销售订单号', width: 100},
                        {field: 'inputValue', title: '开卡产值', width: 100},
                        {field: 'sureValue', title: '串装确认产值', width: 100},
                        {field: 'takeValue', title: '串装入库产值', width: 100},




                        {field: 'surenum', title: '确认串装数',hidden:'true', width: 100},
                        {field: 'IsCL', title: '无需入库', formatter:function(value,row,index) {
                            if (value === '1') {
                                return "YES";
                            } else if(value==='0'){
                                return "NO";
                            }else{
                                return "";
                            }
                        }, width: 100},
                        {field: 'takeman', title: '包装接受人',hidden:'true', width: 100},
                        {field: 'takedate', title: '包装接受时间',hidden:'true',width: 100},
                        {field: 'dutyman', title: '责任人', width: 100},
                        {field: 'plant', title: '事业部',hidden:'true', width: 100},
                        {field: 'meins', title: '单位', width: 100},
                        {field: 'planid', title: '计划ID',hidden:'true', width: 100},
                        {field: 'umouth', title: '月度',hidden:'true', width: 100},
                        {field: 'uyear', title: '年度',hidden:'true', width: 100},
                        {field: 'serialno_hide', title: 'serialno_hide', hidden:'true', width: 100},


                        {field: 'IsPrint', title: '已打印' ,formatter:function(value,row,index){
                            if(value==='1'){
                                return "YES";
                            }else if(value==='0'){
                                return "NO";
                            }else{
                                return "";
                            }
                        }, width: 100},
                        {field: 'issure', title: '串装确认',formatter:function(value,row,index){
                            if(value==='1'){
                                return "YES";
                            }else if(value==='0'){
                                return "NO";
                            }else{
                                return "";
                            }
                        },width: 100},
                        {field: 'IsTake', title: '装配入库',formatter:function(value,row,index){
                            if(value==='1'){
                                return "YES";
                            }else if(value==='0'){
                                return "NO";
                            }else{
                                return "";
                            }
                        }, width: 100},
                        {field: 'Ftemp10', title: '转换关系',hidden:'true', width: 100},
                        {field: 'GCXH', title: '工程兴化', hidden:'true',width: 100},
                        {field: 'equipmentSerial', title: '设备编号',hidden:'true', width: 100},
                        {field: 'equipmentkind', title: '设备类型',hidden:'true', width: 100}
                    ]],
//                    pagination:true,
                    pageList: [25, 50,100],
                    sortOrder:'asc'
                });
                $('#CZRku_dgm').datagrid({
                    rowStyler: function (index, row) {
                        var issure = row.issure;
                        var IsTake = row.IsTake;
                        //alert(11);
                        if (issure !== '1') {
                            return 'color:black;';
                        }
                        else if(IsTake !== '1'&&issure === '1'){
                            return 'color:Green;font-weight:bold;';
                        }
                        return 'background-color:Green;color:LightYellow;font-weight:bold;';
                    }
                });
                $('#CZRku_dgm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });
    }

    function forCZOK(){
        var row = $("#CZRku_dgm").datagrid("getSelected");
        var id = row.id;
        var inputnum = row.inputnum;
        var planid = row.planid;
        if(row.issure === '1'){
            $.messager.alert('温馨提示', '此行项目已完成串装确认!');
        }else{
            $.ajax({
                type: "get",
                data:{
                    id:id,
                    issure:'1',
                    sureman:localStorage.getItem("User"),
                    surenum:row.inputnum
                },
                url:"/KCard/updateCZ.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if(data.num>0){
                        row.issure = '1';
                        $('#CZRku_dgm').datagrid('refreshRow', editIndex);
                        $.ajax({
                            type: "get",
                            data:{
                                id:planid,
                                SumDayNum:inputnum,
                                num:"1"
                            },
                            url:"/Mplan/updatecz.action",
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                //alert(data.num);
                                if (data.num > 0) {
                                    $.messager.alert('温馨提示', '串装确认成功!');
                                }
                            }
                        })
                    }
                }
            });
        }
    }
    function forCZCX(){
        var row = $("#CZRku_dgm").datagrid("getSelected");
        var id = row.id;
        var planid = row.planid;
        var inputnum = row.inputnum;
        if(row.issure === '0'){
            $.messager.alert('温馨提示', '此行项目不需要冲销!');
        }else if(row.IsTake === '1'){
            $.messager.alert('温馨提示', '此行项目已入库无法冲销!');
        }else{
            $.ajax({
                type: "get",
                data: {
                    id: id,
                    issure: '0',
                    sureman:"",
                    surenum:0
                },
                url: "/KCard/updateCZ.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        row.issure = '0';
                        $('#CZRku_dgm').datagrid('refreshRow', editIndex);
                        $.ajax({
                            type: "get",
                            data:{
                                id:planid,
                                SumDayNum:inputnum,
                                num:"2"
                            },
                            url:"/Mplan/updatecz.action",
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    $.messager.alert('温馨提示', '串装冲销成功!');
                                }
                            }
                        })


                    }
                }
            });
        }
    }
    function forRKOK(){
        var row = $("#CZRku_dgm").datagrid("getSelected");
        var id = row.id;
        var planid = row.planid;
        var inputnum = row.inputnum;
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var time = year+"-"+month+"-"+day;
        if(row.IsTake === '1'&&row.issure === '1'){
            $.messager.alert('温馨提示', '此行项目已完成入库!');
        }else if(row.issure === '0'){
            $.messager.alert('温馨提示', '此行项目还未完成串装确认!');
        }else {
            $.ajax({
                type: "get",
                data: {
                    id: id,
                    IsTake: '1',
                    takeman:localStorage.getItem("User"),
                    takenum:inputnum
                },
                url: "/KCard/updateRK.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        row.IsTake = '1';
                        $('#CZRku_dgm').datagrid('refreshRow', editIndex);
                        $.ajax({
                            type: "get",
                            data:{
                                id:planid,
                                SumDayInput:inputnum,
                                num:"1"
                            },
                            url:"/Mplan/updateruku.action",
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    $.ajax({
                                        type: "get",
                                        data:{
                                            id:planid,
                                            SumDayInput:inputnum,
                                            num:"3"
                                        },
                                        url:"/Mplan/updateruku.action",
                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (data) {//ajax请求成功后触发的方法
                                        }
                                    })
                                    $.messager.alert('温馨提示', '装配入库成功!');
                                }
                            }
                        })

                    }
                }
            });
        }
    }
    function forRKCX(){
        var row = $("#CZRku_dgm").datagrid("getSelected");
        var id = row.id;
        var planid = row.planid;
        var inputnum = row.inputnum;
        if(row.IsTake === '0'){
            $.messager.alert('温馨提示', '此行项目不需要冲销!');
        }else {
            $.ajax({
                type: "get",
                data: {
                    id: id,
                    IsTake: '0',
                    takeman:"",
                    takenum:0
                },
                url: "/KCard/updateRK.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if (data.num > 0) {
                        row.IsTake = '0';
                        $('#CZRku_dgm').datagrid('refreshRow', editIndex);
                        $.ajax({
                            type: "get",
                            data:{
                                id:planid,
                                SumDayInput:inputnum,
                                num:"2"
                            },
                            url:"/Mplan/updateruku.action",
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    $.ajax({
                                        type: "get",
                                        data:{
                                            id:planid,
                                            SumDayInput:inputnum,
                                            num:"4"
                                        },
                                        url:"/Mplan/updateruku.action",
                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (data) {//ajax请求成功后触发的方法
                                        }
                                    });
                                    $.messager.alert('温馨提示', '装配冲销成功!');
                                }
                            }
                        })

                    }
                }
            });
        }
    }
    var editIndex = undefined;
    function onClickRow(index){
        if (editIndex != index){
            var row = $("#CZRku_dgm").datagrid("getSelected");
            $('#CZRku_ff').form('load',{
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
                url: "/KCard/queryCZG.action?plant=" + $('#CZRku_Plant').combobox('getText') + "&&worklead=" + row.dutyman + "",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    $('#CZRku_ReportMan').combobox('loadData', data);
                }
            });

            editIndex = index;
        }
    }
    function CZRK_pagerFilter(data){
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
    function CZRku_Print() {
        var row = $("#CZRku_dgm").datagrid("getSelected");
        var tarValue = "[{reportlet:'/SD/ZPJJKC.cpt',id:'"+row.id+"'}]";
////设置url地址，加上Date().getTime()防止缓存
        var url = "http://172.16.0.57:8090/WebReport/proxy2.html?_=" + new Date().getTime()
            + "&tarValue=" + tarValue;
////添加一个新的iframe，并为该iframe添加一个src，用来打开proxy.html，让其执行跨域打印的js代码

        var iframe = document.getElementById('proxy2');
        if (!iframe) {
            // 如果iframe还没有加进去，则加进去
            iframe = document.createElement('iframe');
            document.getElementsByTagName('head')[0].appendChild(iframe);
            iframe.setAttribute('name','proxy2');
            iframe.setAttribute('id','proxy2');
        }
        iframe.setAttribute('src', url);
//        var url = "http://localhost:8075/WebReport/proxy2.html";

    }
</script>