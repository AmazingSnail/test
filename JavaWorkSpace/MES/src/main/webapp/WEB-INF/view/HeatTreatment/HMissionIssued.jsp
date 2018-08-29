<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/5
  Time: 9:21 --- 工单管理
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }


    .N{
        width:50%;
        height:75%;
    }

    .M{
        width:10%;
        height:75%;
    }
    .x3{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .z2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.9em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="工单管理" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label><span class="z2">年月：</span></label><input  id ="pmidb1" style="width:90px" class="easyui-datebox">&nbsp&nbsp&nbsp</td>
                        <td><label>物料编码：</label><input id="mi_fno" class="easyui-textbox" style="width:145px">&nbsp&nbsp&nbsp</td>
                        <td> <label>节点工序：</label><select class="easyui-combobox" name="takekind" datatype="text" id="mi_ProcessNode"  panelHeight="auto" style="width:90px">
                            <option value="热处" selected="selected">热处</option>
                            <option value="表处">表处</option>
                        </select>&nbsp&nbsp&nbsp</td>
                        <td rowspan="2"><a href="#" class="easyui-linkbutton"  onclick="pmi_query()" data-options="iconCls:'icon-search'" style="width:60px;height: 50px">查询</a></td>
                    </tr>
                    <tr>
                        <td> <label><span class="x3">事业部：</span></label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="hmiPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select>&nbsp&nbsp&nbsp</td>
                        <td><label>物料描述：</label><input id="mi_fname" class="easyui-textbox" style="width:80px">
                            <select class="easyui-combobox" name="mmPlant" style="width:60px" datatype="text" id="mi_AxleNum3" panelHeight="auto" data-options="
                                valueField:'Statusname',
                                textField:'Statusname',
                                panelHeight:'250'"
                                    style="width:60px">
                            </select>&nbsp&nbsp&nbsp
                        </td>
                        <td><label>打印标记：</label><input  id ="mi_WorkCentre" style="width:90px" class="easyui-textbox">&nbsp&nbsp&nbsp
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="easyui-layout haorooms"   >
            <!--开卡信息-->
            <div class="N" data-options="region:'west',split:true" >
                <table id="PMI-Data" class="easyui-datagrid" style="white-space: nowrap;height: 100%"title="工单管理"   data-options="singleSelect:true"></table>
            </div>
            <!--收发按钮-->
            <div class="" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
                        <button id="PMI-go" onclick="PMI_go()"  class="easyui-linkbutton" style="margin-top: 80px">下达>></button>
                    </div>
                    <div style="">
                        <button id="MI-back" class="easyui-linkbutton" onclick="PMI_back()">删除<<</button>
                    </div>
            </div>
            <!--接收明细-->
            <div class="N"  data-options="region:'east',split:true">
                <table class="easyui-datagrid" id="PMI-Input"  style="white-space: nowrap;height: 100%"title="本日任务下达信息(绿色背景：计划已完成；浅绿色背景：生产中)"  data-options="singleSelect:true,editor:'text'" ></table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var i;
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#pmidb1').val(year+"-"+month+"-"+day);
//        $('#ptdb').val(year+"-"+month+"-"+day);
        var db = $('#pmidb1');
        db.datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                span.trigger('click'); //触发click事件弹出月份层
                //fix 1.3.x不选择日期点击其他地方隐藏在弹出日期框显示日期面板
                if (p.find('div.calendar-menu').is(':hidden')) p.find('div.calendar-menu').show();
                if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                    tds = p.find('div.calendar-menu-month-inner td');
                    tds.click(function (e) {
                        e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                        var year = /\d{4}/.exec(span.html())[0]//得到年份
                            , month = parseInt($(this).attr('abbr'), 10); //月份，这里不需要+1
                        db.datebox('hidePanel')//隐藏日期对象
                            .datebox('setValue', year + '-' + month); //设置日期的值
                    });
                }, 0);
                yearIpt.unbind();//解绑年份输入框中任何事件
            },
            parser: function (s) {
                if (!s) return new Date();
                var arr = s.split('-');
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
            },
            formatter: function (d) { return d.getFullYear() + '-' + (d.getMonth() + 1);/*getMonth返回的是0开始的，忘记了。。已修正*/ }
        });
        var p = db.datebox('panel'), //日期选择对象
            tds = false, //日期选择对象中月份
            aToday = p.find('a.datebox-current'),
            yearIpt = p.find('input.calendar-menu-year'),//年份输入框
            //显示月份层的触发控件
            span = aToday.length ? p.find('div.calendar-title span') ://1.3.x版本
                p.find('span.calendar-text'); //1.4.x版本
        if (aToday.length) {//1.3.x版本，取消Today按钮的click事件，重新绑定新事件设置日期框为今天，防止弹出日期选择面板

            aToday.unbind('click').click(function () {
                var now=new Date();
                db.datebox('hidePanel').datebox('setValue', now.getFullYear() + '-' + (now.getMonth() + 1));
            });
        }

//        $("#ptPlant").combobox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptstoretake();
//            }
//        });
//        $("#ptdb").datebox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptcolor();
//            }
//        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MonthPlan/FindFname.action',
            dataType: "json",
            data: {

            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#mi_AxleNum3').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MonthPlan/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#hmiPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
    });

    function pmi_query() {
        var fno = $('#mi_fno').val();
        var fname = $('#mi_fname').val();
        var ProcessNode = $('#mi_ProcessNode').combobox('getValue');
        var AxleNum3 = $('#mi_AxleNum3').combobox('getValue');
        var hmiPlant = $('#hmiPlant').combobox('getText');
        var WorkCentre = $('#mi_WorkCentre').val();
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var time = year+"-"+month+"-"+day;
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/PlanningManagement/queryDay.action",//要发送的后台地址
            data: {
                fno:fno,
                fname:fname,
                ProcessNode:ProcessNode,
                AxleNum3:AxleNum3,
                Plant:hmiPlant,
                WorkCentre:WorkCentre
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#PMI-Data").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    fit: false, //自动适屏功能
                    nowrap:false,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'id',width: '55px',align:'left',halign: 'center',hidden:'hidden'},
                        {field:'fno',title:'物料编码',width: '100px',align:'center',halign: 'center'},
                        {field:'fname',title:'物料描述',width: '250px',align:'left',halign:'center'},
                        {field:'workcentre',title:'打印标记',width:'150px',align:'left',halign: 'center'},
                        {field:'processnode',title:'节点工序',width: '60px',align:'center',halign: 'center'},
                        {field:'plant',title:'事业部',width: '80px',align:'center',halign: 'center'},
                    ]],
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $.ajax({//当天任务
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/PMissionIssued/query.action",//要发送的后台地址
            data: {
                time:time,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#PMI-Input").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    fit: false, //自动适屏功能
                    nowrap:false,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'id',width: '100px',align:'left',halign: 'center',hidden:'hidden'},
                         {field:'planid',title:'计划ID',width: '90px',align:'center',halign: 'center'},
                         {field:'fname',title:'物料描述',width: '200px',align:'left',halign: 'center'},
                         {field:'equipid',title:'设备编号',editor:{
                            type: 'combobox',
                            options:
                                {
                                    valueField:'equipID',
                                    textField:'equipID',
                                    method:'get',
                                    required:true,
                                    onChange: function (oldVal,newVal) {
                                        var rowkc = $('#PMI-Input').datagrid('getRows');
                                        var rowData = rowkc[editIndex];
                                        /*
                                         获取冲制工
                                         */
                                        $.ajax({
                                            type: "post",
                                            url: "${ctxPath}/MissionIssued/GetproductMan.action",
                                            data: {
                                                equipID:oldVal,
                                            },
                                            dataType: "json",//后台处理后返回的数据格式
                                            success: function (data) {//ajax请求成功后触发的方法
                                                var ed = $('#PMI-Input').datagrid('getEditor', {index: editIndex, field: 'productman'});
                                                $(ed.target).combobox('loadData', data);

                                            }
                                        });

                                    }
                                }
                        },width: '60px',align:'center',halign:'center'},
                        {field:'productman',title:'冲制工',
                            editor:{
                                type:'combobox',
                                options:
                                    {
                                        valueField:'productMan',
                                        textField:'productMan',
                                        method:'get',
                                        required:true,
                                    }
                            },width:'60px',align:'center',halign: 'center'},
                        {field:'productnum',title:'下达数量',
                            editor:{
                                type:'validatebox',
                                options:{
                                    required:true
                                }
                            },width:60,align:'right',halign: 'center',required: true},
                         {field:'fno',title:'物料编码',width: '100px',align:'center',halign: 'center'},
                         {field:'inputman',title:'下达人',width: '80px',align:'center',halign: 'center'},
                         {field:'inputdate',title:'下达时间',width: '200px',align:'right',halign: 'center'},
                         {field:'status',title:'生产状态',width: '80px',align:'center',halign: 'center'},
                         {field:'plant',title:'事业部',width: '80px',align:'center',halign: 'center'},
                    ]],
                    pagination:true,
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#PMI-Input').datagrid({
            rowStyler: function (index, row) {
                var over = row.process;
                if (over=='生产中') {
                    return 'background-color:red;color:white';
                }else if(over=='已完成' ){
                    return 'background-color:green ;color:white;';
                }
            }
        });
        $('#PMI-Data').datagrid('loadData',{total:0,rows:[]});
        $('#PMI-Input').datagrid('loadData',{total:0,rows:[]});


    }
    function pagerFilter(data){
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

    function PMI_go() {
        var one =1;
        var plant=  $('#hmiPlant').combobox('getText');//委托事业部
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umonth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time = uyear+"-"+umonth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var username = localStorage.getItem("User");
        var row  = $('#PMI-Data').datagrid("getSelected");
        var plant1 = localStorage.getItem("Department");
            if (endEditing()) {
                $('#PMI-Input').datagrid('appendRow', {
                    fno:row.fno,
                    fname:row.fname,
                });
                editIndex = $('#PMI-Input').datagrid('getRows').length - 1;
                /*
                 获取设备编号
                 */
                $.ajax({
                    type: "post",
                    url: "${ctxPath}/MissionIssued/GetEquipID.action",
                    data: {
                        plant : row.plant,
                        departMent:row.department,
                    },
                    dataType: "json",//后台处理后返回的数据格式
                    success: function (data) {//ajax请求成功后触发的方法
                        console.log(data);
                        var ed = $('#PMI-Input').datagrid('getEditor', {index: editIndex, field: 'equipid'});
                        $(ed.target).combobox('loadData', data);

                    }
                });
                $('#PMI-Input').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
                $("input.datagrid-editable-input").keydown(function (e) {
                    var code = e.keyCode || e.which;
                    if (code === 13) {
                        var daty = new Date();
                        var NowHour = daty.getHours();
                        var NowMinute = daty.getMinutes();
                        var NowSecond = daty.getSeconds();
                        var mc = (NowHour * 3600) + (NowMinute * 60) + NowSecond;
//                            if ((mc - $('#time12').val()) > 3)//600只是一个时间值，就是5分钟内禁止重复提交
//                            {
                        var einput = $('#PMI-Input').datagrid('getEditor', {
                            index: editIndex,
                            field: 'productnum'
                        });
                        if ($(einput.target).val() === '0.0' || parseFloat($(einput.target).val()) === 0.0) {
                            $.messager.alert('温馨提示', '请完善好数据再保存!')
                        } else {
                            $('#PMI-Input').datagrid('endEdit', editIndex);
                            var rowkc = $('#PMI-Input').datagrid('getRows');
                            var rowData = rowkc[editIndex];
                            $.messager.confirm('温馨提示', '你确定要保存吗?', function (r) {
                                if (r) {
                                        $.ajax({
                                            type: "post",//数据发送的方式（post 或者 get）
                                            url: "${ctxPath}/PMissionIssued/insertTake.action",//要发送的后台地址
                                            data: {
                                                fno: row.fno,
                                                equipid:rowData.equipid,
                                                productman:rowData.productman,
                                                productnum:rowData.productnum,
                                                fname:rowData.fname,
                                                plant:row.plant,//加工事业部
                                                department:plant,
                                                inputdate: time,
                                                beginman: localStorage.getItem("User"),
                                                uyear: uyear,
                                                umonth: umonth,
                                                WorkCentre:row.workcentre,
                                                Material:row.material,
                                                ProcessNode:row.processnode,
                                            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                                            dataType: "json",//后台处理后返回的数据格式
                                            success: function (data1) {//ajax请求成功后触发的方法
                                                console.log(data1);
                                                if (data1.num > 0) {
                                                    $.messager.alert('温馨提示', '保存成功!');
                                                    pmi_query();
                                                }

                                            },

                                            error: function (msg) {//ajax请求失败后触发的方法
                                                alert(msg);//弹出错误信息
                                            }
                                        });
                                }
                            });
                        }
                    }


                });
            }
            else{
                $.messager.alert('温馨提示', '存在未编辑完数据!');

            }






    }
    var editIndex = undefined;
    var ydIndex = undefined;
    function endEditing(){
        //alert(editIndex);
        if (editIndex == undefined){return true}
        if ($('#PMI-Input').datagrid('validateRow', editIndex)){
            //alert(2222);
//            var editor = $('#kc').datagrid('getEditor',{index:editIndex,field:"itemno"});
//            var productname = $(editor.target).val();
//
//
//
//
//            $('#kc').datagrid('getRows')[editIndex]['productname'] = productname;
            $('#PMI-Input').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function  PMI_back() {
        var row  = $("#PMI-Input").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
                if (r) {
                    if (row.id === undefined) {
                        if (editIndex == undefined) {
                            return
                        }
                        $('#PMI-Input').datagrid('cancelEdit', editIndex)
                            .datagrid('deleteRow', editIndex);
                        editIndex = undefined;
                        $('#PMI-Data').datagrid('loadData',{total:0,rows:[]});
                        $('#PMI-Input').datagrid('loadData',{total:0,rows:[]});
                        pmi_query();
                    }else{
                        jQuery.ajax({
                            type: "POST",   //post提交方式默认是get
                            url: "${ctxPath}/PMissionIssued/deleteTake.action",
                            dataType: "json",
                            data: {
                                id : row.id,
                            },
                            error: function (request) {      // 设置表单提交出错
                                $.messager.progress('close');
                                $.messager.alert('信息提示', '出错了！', 'info');
                            },
                            success: function (data) {
                                console.log(data);
                                if(data.num>0){
                                    $.messager.alert('信息提示', '删除成功！！！');
                                    pmi_query();
                                    $('#PMI-Data').datagrid('loadData',{total:0,rows:[]});
                                    $('#PMI-Input').datagrid('loadData',{total:0,rows:[]});
                                }else{
                                    $.messager.alert('信息提示', '删除失败！！！');
                                    $('#PMI-Data').datagrid('loadData',{total:0,rows:[]});
                                    $('#PMI-Input').datagrid('loadData',{total:0,rows:[]});
                                }
                            }
                        })
                    }
                }
            })
        }



    }
</script>
