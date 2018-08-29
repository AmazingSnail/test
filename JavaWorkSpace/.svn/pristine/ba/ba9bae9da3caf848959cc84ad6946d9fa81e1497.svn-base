<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
    <style>
        .wu-header { height:55px; position:relative; z-index:0; overflow:hidden; border-bottom:1px #95b8e7 solid;; background-size:cover;}
        /*background:url(img/bg_header.jpg) bottom repeat-x;*/
        .datagrid-row-selected {
            background: #CAE1FF;
            color: black;
        }
        .tree-node-selected{
            background-color: #CAE1FF;color:black}

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
        <div class="easyui-panel " title="串装入库" data-options="fit:true">
            <div id="cgs_toolbar"  style="overflow:auto;width:100%;height: 78px;">
                <div class="wu-toolbar-button" >
                    <shiro:hasPermission name="/cgs/forFJRK">
                        <a href="#" class="easyui-linkbutton"  onclick="cgs_forFJRK()" data-options="iconCls:'icon-ok'" plain="true">分剪入库</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/cgs/forFJCX">
                        <a href="#" class="easyui-linkbutton"  onclick="cgs_forFJCX()" data-options="iconCls:'icon-undo'" plain="true">分剪冲销</a>
                    </shiro:hasPermission>
                    <span>丨</span>
                    <shiro:hasPermission name="/cgs/delete">
                        <%--<a href="#" class="easyui-linkbutton"  onclick="cgs_delete()" data-options="iconCls:'icon-delete'" plain="true">删除卡</a>--%>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/cgs/update">
                        <a href="#" class="easyui-linkbutton"  onclick="cgs_update()" data-options="iconCls:'icon-edit'" plain="true">分剪修改</a>
                    </shiro:hasPermission>
                    <%--<shiro:hasPermission name="/cgs/Print">--%>
                        <%--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="cgs_Print()" plain="true">补卡打印</a>--%>
                    <%--</shiro:hasPermission>--%>

                </div>
                <div class="wu-toolbar-search" >

                    <div style="white-space:nowrap">
                        <label>起始时间：</label><input  id ="cgs_db1" style="width:110px" class="easyui-datebox">&nbsp
                        <label>结束时间：</label><input  id ="cgs_db2" style="width:110px" class="easyui-datebox">&nbsp
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="cgs_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>打印人：</label>
                        <select class="easyui-combobox" name="printman" datatype="text" id="cgs_printman" panelHeight="auto" data-options="
                            url:'${ctxPath }/CuttingSure/selectPrintman.action',
                            method:'post',
                            valueField:'printman',
                            textField:'printman',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>炉批号：</label><input id="cgs_reelnums" class="easyui-textbox" style="width:100px">&nbsp
                        <a href="#" class="easyui-linkbutton" id = "aaa" onclick="cgs_forGetDate()" data-options="iconCls:'icon-search'">明细查询</a>
                        <a href="#" class="easyui-linkbutton"  onclick="cgs_showMore()" data-options="iconCls:'icon-search'">更多</a>
                        <a href="#" class="easyui-linkbutton" id = "SumData" onclick="cgs_forGetDateSum()" data-options="iconCls:'icon-search'">汇总查询</a>

                    </div>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white" id="cgs_More">
                    </div>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div id="cgs_dd" class="easyui-layout cz"  data-options="fit:true">
                    <div style="width: 100%;height:75%" data-options="region:'center'">
                        <table id="cgs_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="分剪确认" data-options="singleSelect:true,onClickRow:cgs_onClickRow"></table>
                    </div>
                </div>
            </div>
            <div id="cgs_updateDiv" class="easyui-dialog" title="分剪修改" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:460px;height:250px;padding:10px">
                <from id="cgs_updatefrom">
                    <table cellpadding="5" width="auto" style="white-space:nowrap" >
                        <td>
                            <tr>
                                <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="cgs_updatefno"  style="width:350px" disabled=true"></input></td>
                            </tr>
                            <tr>
                                <td>物料描述:<input class="easyui-textbox" type="text" name="name" id="cgs_updatename" style="width:350px"disabled=true"></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">原重量</span>:<input class="easyui-textbox" type="text" name="weightold" id="cgs_updateweightold"  style="width:350px" disabled=true"></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">新重量</span>:<input class="easyui-textbox" type="number" name="weightnew" id="cgs_updateweightnew" style="width:350px" data-options="required:'true'"></input></td>
                            </tr>
                            <input class="easyui-textbox" type="hidden" name="id" id="cgs_updateid"  />
                            <tr >
                                <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 280px" name="Save" onclick="cgs_updateSave()" id="spm_parentAddbutton" data-options="iconCls:'icon-save'" >保存</a></td>
                            </tr>
                        </td>
                    </table>
                </from>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var SelectState = null;
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#cgs_db1').val(year+"-"+month+"-"+day);
        //$('#cgs_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#cgs_db2').val(year+"-"+month+"-"+day);
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
                $('#cgs_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#cgs_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#cgs_KCardMan').combobox('clear');
                    $('#cgs_CZMan').combobox('clear');
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
                            $('#cgs_KCardMan').combobox('loadData', data);

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
                            $('#cgs_CZMan').combobox('loadData', data);

                        }
                    });
                }

            }
        })
//        $("input[name='MDMCZRkuCheck']").eq(0).attr("checked","checked");
        $("#cgs_More").hide();
        $("#cgs_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#cgs_More").hide();

        });
        SelectState = 1;

//        $("#cgs_toolbar").blur(function(){
//            $("#cgs_More").toggle();
//        })
    });
    function cgs_showMore() {
        $("#cgs_More").toggle();
    }

    function cgs_forGetDateSum(){
        cgs_etDailyPrintSum();
        SelectState = 2;
    }
    function cgs_forGetDate(){
        var a = null;
        SelectState = 0;
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
        var c = 0;
        cgs_getDailyPrint(a,b,c);
        SelectState = 1;
    }
    function cgs_etDailyPrintSum(){
        $('#cgs_dgm').datagrid('loadData', {total: 0, rows: []});
        var startTime = $('#cgs_db1').val();
        var endTime = $('#cgs_db2').val() + " 23:59:59";
        var   plant= $('#cgs_Plant').combobox("getText");
        var reelnums = $('#cgs_reelnums').val();
        $.messager.progress({
            title: '请稍等',
            msg: '页面加载中...'
        });
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/CuttingSure/selectColdDailyPrintSum.action",//要发送的后台地址
            data: {
                startTime:startTime,
                endTime:endTime,
                plant:plant,
                reelnums:reelnums
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                $("#cgs_dgm").datagrid({
                    idField: 'id',
                    rownumbers: true,
                    singleSelect: true,
                    pagination: true,
                    multiSort: true,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    remoteSort: false,
                    loadMsg: "正在加载数据.....",
                    data: data,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns: [[
                        {field: 'id', title: '序号', width: 70, hidden:'true',sortable: true},
                        {field: 'serialno', title: '编号', width: 70, hidden:'true',sortable: true},
                        {field: 'fno', title: '物料编码', width: 100, sortable: true},
                        {field: 'fname', title: '物料描述',  width: 200, sortable: true},

                        {field: 'reelnums', title: '炉批号们', width: 70, sortable: true},
                        {field: 'weight', title: '全部重量', width: 70, sortable: true},
                        {field: 'weightOk', title: '确认重量', width: 70, sortable: true},
                        {field: 'weightNo', title: '未确认重量', width: 70, sortable: true},
                        {field: 'plant', title: '事业部', width: 60, sortable: true},
                        {field: 'printman', title: '打印人', hidden:'true',  width: 100},

                        {field: 'printdate', title: '打印时间', hidden:'true', width: 150},
                        {field: 'isdelete', title: '删除标识', hidden:'true', width: 100},
                        {field: 'year', title: '年份', hidden: 'true', width: 100},
                        {field: 'month', title: '月份', hidden: 'true', width: 100},
                        {field: 'fids', title: '月度计划ids', hidden: 'true', width: 100},
                        {field: 'istake', title: '分剪确认', hidden:'true', width: 100},

                        {field: 'takeman', title: '确认人',  hidden:'true',width: 100},
                        {field: 'takedate', title: '确认时间',  hidden:'true',width: 150, sortable: true},

                    ]],
//                    pagination:true,
//                    pageList: [25, 50, 100],
                    sortOrder: 'asc'
                });
//                $('#cgs_dgm').datagrid({loadFilter: cgs_pagerFilter}).datagrid('loadData', data);

                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });
    }
    function cgs_getDailyPrint(a,b,c) {
            $('#cgs_dgm').datagrid('loadData', {total: 0, rows: []});
            var startTime = $('#cgs_db1').val();
            var endTime = $('#cgs_db2').val() + " 23:59:59";
            var   plant= $('#cgs_Plant').combobox("getText");
            var printman = $('#cgs_printman').combobox("getText");
            var reelnums = $('#cgs_reelnums').val();
            $.messager.progress({
                title: '请稍等',
                msg: '页面加载中...'
            });
            jQuery.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${ctxPath }/CuttingSure/selectColdDailyPrint.action",//要发送的后台地址
                data: {
                    startTime:startTime,
                    endTime:endTime,
                    plant:plant,
                    printman:printman,
                    reelnums:reelnums
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    $.messager.progress('close');
                    console.log(data);
                    $("#cgs_dgm").datagrid({
                        idField: 'id',
                        rownumbers: true,
                        singleSelect: true,
                        pagination: true,
                        multiSort: true,
                        showFooter: true,
                        //fitColumns:true,
                        //fit:true,
                        remoteSort: false,
                        loadMsg: "正在加载数据.....",
                        data: data,
                        //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                        columns: [[
                            {field: 'id', title: '序号', width: 70, sortable: true},
                            {field: 'serialno', title: '编号', width: 70, sortable: true},
                            {field: 'fno', title: '物料编码', width: 100, sortable: true},
                            {field: 'fname', title: '物料描述',  width: 200, sortable: true},

                            {field: 'reelnums', title: '炉批号们', width: 70, sortable: true},
                            {field: 'weight', title: '重量', width: 70, sortable: true},

                            {field: 'plant', title: '事业部', width: 60, sortable: true},
                            {field: 'printman', title: '打印人',  width: 100},

                            {field: 'printdate', title: '打印时间', width: 150},
                            {field: 'isdelete', title: '删除标识', hidden:'true', width: 100},
                            {field: 'year', title: '年份', hidden: 'true', width: 100},
                            {field: 'month', title: '月份', hidden: 'true', width: 100},
                            {field: 'fids', title: '月度计划ids', hidden: 'true', width: 100},
                            {field: 'istake', title: '分剪确认',
                                formatter:function(value,row,index) {
                                    if (value === true) {
                                        return "已确认";
                                    }  else {
                                        return "未确认";
                                    }
                                },width: 100},

                            {field: 'takeman', title: '确认人', width: 100},
                            {field: 'takedate', title: '确认时间', width: 150, sortable: true},

                        ]],
//                    pagination:true,
//                        pageList: [25, 50, 100],
                        sortOrder: 'asc'
                    });
                    $('#cgs_dgm').datagrid({
                        rowStyler: function (index, row) {
                            var istake =row.istake;
                            //alert(11);
                            if (istake !== true) {
                                return 'color:black;';
                            }
                            else {
//                            return 'color:Green;font-weight:bold;';
                                return 'color:red';
                            }

                        }
                    });
//                    $('#cgs_dgm').datagrid({loadFilter: cgs_pagerFilter}).datagrid('loadData', data);

                    return true;
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    return false;
                }
            });
    }

    function cgs_forFJRK(){
            var row = $("#cgs_dgm").datagrid("getSelected");
            if(row ===null){
                $.messager.alert('温馨提示', '请选择有效的行！！！');
            }else{
                if(SelectState===1){
                    var id = row.id;
                    if (row.istake === true) {
                        $.messager.alert('温馨提示', '此记录已经完成分剪确认操作!');
                    } else {
                        $.ajax({
                            type: "post",
                            data: {
                                id: id,
                                fno:row.fno,
                                weight:row.weight,
                                istake: true,
                                takeman: localStorage.getItem("User"),
                                fids:row.fids
                            },
                            url: "${ctxPath }/CuttingSure/update.action",
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    row.istake = true;
                                    $('#cgs_dgm').datagrid('refreshRow', editIndex);
                                    $.ajax({
                                        type: "post",
                                        data: {
                                            id: id
                                        },
                                        url: "${ctxPath }/CuttingSure/updateStoreIn.action",
                                        dataType: "json",//后台处理后返回的数据格式
                                        success: function (data) {//ajax请求成功后触发的方法
                                            //alert(data.num);
                                            if (data.num > 0) {
                                                $.messager.alert('温馨提示', '分剪成功！！！');
                                            }
                                        }
                                    })
                                }
                            }
                        });
                    }
                }else if(SelectState ===2){
                    var startTime = $('#cgs_db1').val();
                    var endTime = $('#cgs_db2').val() + " 23:59:59";
                    var   plant= $('#cgs_Plant').combobox("getText");
                    var reelnums = $('#cgs_reelnums').val();
                    var fno = row.fno;
                    var istake= true;
                    var takeman = localStorage.getItem("User");
                    $.ajax({
                        type: "post",
                        data: {
                            startTime:startTime,
                            endTime:endTime,
                            plant:plant,
                            reelnums:reelnums,
                            istake: istake,
                            fno:fno,
                            takeman: takeman
                        },
                        url: "${ctxPath }/CuttingSure/updateSum.action",
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                                $.messager.alert('温馨提示', '成功'+data.num+'条！！！');
                        }
                    });

                }else{
                    $.messager.alert('温馨提示', '请先进行查询！！！');
                }

            }

    }
    function cgs_forFJCX(){
            var row = $("#cgs_dgm").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('温馨提示', '请选择有效的行！！！');
        }else {
            if(SelectState ===1){
                var id = row.id;
                if (row.istake === false) {
                    $.messager.alert('温馨提示', '此记录无需冲销!');
                } else {
                    $.ajax({
                        type: "post",
                        data: {
                            id: id,
                            istake: false,
                            fno: row.fno,
                            weight: -1 * row.weight,
                            fids: row.fids,
                            takeman: ""
                        },
                        url: "${ctxPath }/CuttingSure/update.action",
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            if (data.num > 0) {
                                row.istake = false;
                                $('#cgs_dgm').datagrid('refreshRow', editIndex);
                                $.ajax({
                                    type: "post",
                                    data: {
                                        cuttingid: id,
                                    },
                                    url: "${ctxPath }/CuttingSure/deleteStoreIn.action",
                                    dataType: "json",//后台处理后返回的数据格式
                                    success: function (data) {//ajax请求成功后触发的方法
                                        if (data.num > 0) {
                                            $.messager.alert('温馨提示', '分剪冲销成功!');
                                        }
                                    }
                                })


                            }
                        }
                    });
                }
            }else{
                $.messager.alert('温馨提示', '请先进行明细查询!');
            }

        }
    }
    function cgs_update(){
        var row = $("#cgs_dgm").datagrid("getSelected");
        if(SelectState===1) {
            if (row === null) {
                $.messager.alert('温馨提示', '请选择有效的行！！！');
            } else {
                if(row.istake===true){
                    $.messager.alert('温馨提示', '选择的记录已分剪确认，请先分剪冲销！！！');
                }else{
                    $('#cgs_updatefrom').form("clear");
                    $('#cgs_updatefrom').form('load', {
                        id: row.id,
                        fno: row.fno,
                        name: row.fname,
                        weightold: row.weight
                    });
                    $('#cgs_updateDiv').dialog('open');
                }


            }
        }else{
            $.messager.alert('温馨提示', '请先进行明细查询!');
        }
    }
    function cgs_updateSave() {
        var row = $("#cgs_dgm").datagrid("getSelected");
        var weightnew = $("#cgs_updateweightnew").val();
        var id = $("#cgs_updateid").val();
        if(weightnew===null || weightnew===''){
            $.messager.alert('温馨提示', '重量不能为空！！！');
        }else{
            $.ajax({
                type: "post",
                data: {
                    id: id,
                    weightnew: weightnew,
                },
                url: "${ctxPath }/CuttingSure/updateweight.action",
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if(data.num>0){
                        row.weight = weightnew;
                        $('#cgs_dgm').datagrid('refreshRow', editIndex);
                        $('#cgs_updateDiv').dialog('close');
                        $.messager.alert('温馨提示', '修改成功！！！');
                    }else{
                        $.messager.alert('温馨提示', '修改失败！！！');
                    }
                }
            });

        }
    }
    var editIndex = undefined;
    function cgs_onClickRow(index){


            editIndex = index;
    }
    function cgs_pagerFilter(data){
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
    function cgs_Print() {
        if(SelectState ===1){
            $.messager.alert('温馨提示', '请先进行串装入库查询!');
        }else {
            var row = $("#cgs_dgm").datagrid("getSelected");
            var tarValue = "[{reportlet:'/SD/ZPJJKC.cpt',id:'" + row.id + "'}]";
////设置url地址，加上Date().getTime()防止缓存
            var url = "http://172.16.0.57:8090/WebReport/proxy2.html?_=" + new Date().getTime()
                + "&tarValue=" + tarValue;
////添加一个新的iframe，并为该iframe添加一个src，用来打开proxy.html，让其执行跨域打印的js代码

            var iframe = document.getElementById('proxy2');
            if (!iframe) {
                // 如果iframe还没有加进去，则加进去
                iframe = document.createElement('iframe');
                document.getElementsByTagName('head')[0].appendChild(iframe);
                iframe.setAttribute('name', 'proxy2');
                iframe.setAttribute('id', 'proxy2');
            }
            iframe.setAttribute('src', url);
//        var url = "http://localhost:8075/WebReport/proxy2.html";
        }
    }
</script>