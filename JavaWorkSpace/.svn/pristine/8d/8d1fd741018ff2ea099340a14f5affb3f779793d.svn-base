<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-08
  Time: 13:55----零件完成明细---
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 100%;
        height: 66%;
    }


    .N{
        width:100%;
        height:75%;
    }


    .c3{
        letter-spacing:0.4em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.6em; /*同上*/
    }
    .c2{
        letter-spacing:1.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-1.3em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 100px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="报表查询" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
            <div class="wu-toolbar-button">
                <div id="test4"><input  id ="eddb" style="width:110px" class="easyui-text" hidden="hidden"></div>
<shiro:hasPermission name="/ElementDetail/edexport">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="edexport()" plain="true">导出</a>
</shiro:hasPermission>
<shiro:hasPermission name="/ElementDetail/updatenumber">
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="updatenumber()" plain="true">修改</a>
</shiro:hasPermission>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td> <label><span class="c3">事业部：</span></label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="edPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select></td>
                        <td><label>起始时间：</label><input  id ="eddb1" style="width:110px" class="easyui-datebox">&nbsp</td>
                        <td><label>冲制工：</label><input id="ed-ProductMan" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>零件编码：</label><input id="cd-Fno" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>零件规格：</label><input id="ed-PartDrawing" class="easyui-textbox" style="width:90px">&nbsp</td>

                    </tr>
                    <tr>
                        <td><label>计划编号：</label><input id="cd-PlanID" class="easyui-textbox" style="width:94px">&nbsp</td>
                        <td><label>结束时间：</label><input  id ="eddb2" style="width:110px" class="easyui-datebox">&nbsp</td>
                        <td><label>炉批号：</label><input id="cd-reelnum" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>设备编号：</label><select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="ed-EquipID" panelHeight="auto" data-options="
                                valueField:'EquipID',
                                textField:'EquipID',
                                panelHeight:'250'"
                                                                                                                            style="width:100px">
                        </select></td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="edquery()" data-options="iconCls:'icon-search'" style="width:150px">查询</a></td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="easyui-layout haorooms"  >
            <div class="N" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'">
                        <table id="ed" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlged" class="easyui-dialog"  title="添加/修改" style="width:350px; height: 370px;  padding: 10px;"
     closed="true" buttons="#dlged-buttons">
    <div class="ftitle" align="center" style="font-size: 15px">
        数量修改
    </div>
    <form id="fmed" method="post">
        <div class="fitem" align="center"  >
            <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px" >
                <tr>
                    <td>计划编号：<input name="Infname" id="planid" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" readonly /></td>
                </tr>
                <tr>
                    <td>开卡编号：<input name="Infname" id="serialno" class="easyui-textbox" style="width: 150px;height: 25px" readonly align="left" /></td>
                </tr>
                <tr>
                    <td>修改重量：<input name="Infname" id="number" class="easyui-textbox" style="width: 150px;height: 25px"  align="left" /></td>
                </tr>
                <tr>
                    <td>零件编码：<input name="Inlocation"  id="fno" class="easyui-textbox" style="width: 150px;height: 25px"   readonly /></td>
                </tr>
            </table>

        </div>

    </form>
</div>
<div id="dlged-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="SaveNumber()" iconcls="icon-save">确认</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="Canceldate1()" iconcls="icon-cancel">取消</a>
</div>

<script type="text/javascript">
    var id;
    $("#test4" ).css("display", "none");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
//        var hour = date.getHours();
//        var min = date.getMinutes();
//        var sec = date.getSeconds();
        $('#eddb').val(year+"-"+month);
        $('#eddb1').val(year+"-"+month+"-"+day );
       $('#eddb2').val(year+"-"+month+"-"+day);
        var db = $('#eddb');
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
            url:'${ctxPath }/PersonnelMaintenance/selectDevice2.action',
            dataType: "json",
            data: {
            plant: localStorage.getItem("Department")
        },
//                data:$("#login").val(),   //序列化
        error: function (request) {      // 设置表单提交出错
            $("#showMsg").html(request);  //登录错误提示信息
        },
        success: function (data) {
            console.log(data);
            $('#ed-EquipID').combobox('loadData', data);
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
                $('#edPlant').combobox('loadData', data);
                //alert(11111);

            }
        });



    });
    function updatenumber () {
        var row = $("#ed").datagrid("getSelected");
        id = row.id;
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            $('#planid').textbox("setValue",row.planID);
            $('#serialno').textbox("setValue",row.serialno);
            $('#fno').textbox("setValue",row.fno);
            $('#number').textbox("setValue",row.weightNum);
            $("#dlged").dialog("open");
        }
    }
    function SaveNumber () {
        var number = $('#number').val();//数量
        if(number!=""){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/ElementDetail/updatenum.action',
                dataType: "json",
                data: {
                    id:id,
                    number:number,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    $.messager.alert('温馨提示', '修改成功!!!');
                    $("#fmed").form('clear');
                    $("#dlged").dialog("close");
                    id = '';
                    edquery();

                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }
    }
    function Canceldate1() {
        $("#fmed").form('clear');
        $("#dlged").dialog("close");
    }
    function edquery() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var plant = $('#edPlant').combobox('getText');
        var state = $('input[name="edCheck"]:checked').val();
        var planID = $('#cd-PlanID').val();
        var fno = $('#cd-Fno').val();
        var reelnum = $('#cd-reelnum').val();
        var equipID = $('#ed-EquipID').combobox('getText');
        var partDrawing = $('#ed-PartDrawing').val();
        var productMan = $('#ed-ProductMan').val();
        var starttime = $('#eddb1').datebox('getValue');
        var endtime = $('#eddb2').datebox('getValue');
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/ElementDetail/Serach.action",//要发送的后台地址
            data: {
            uyear:uyear,
                umouth:umouth,
                plant:plant,
                state:state,
                planID:planID,
                fno:fno,
                reelnum:reelnum,
                equipID:equipID,
                partDrawing:partDrawing,
                productMan:productMan,
                starttime:starttime,
                endtime:endtime,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#ed").datagrid({
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
                    showFooter: true,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'planID',title:'计划编号',width: '100px',align:'left',halign:'center'},
                        {field:'serialno',title:'开卡编号',width: '70px',align:'right',halign:'center'},
                        {field:'partDrawing',title:'零件规格',width: '70px',align:'left',halign: 'center'},
                        {field:'weightNum',title:'重量',width: '70px',align:'center',halign: 'center'},
                        {field:'fno',title:'零件编码',width: '100px',align:'left',halign: 'center'},
                        {field:'fname',title:'零件描述',width:'200px',align:'left',halign: 'center'},
                        {field:'equipID',title:'设备编号',width: '65px',align:'center',halign: 'center'},
                        {field:'fatherfno',title:'原料编码',width: '100px',align:'left',halign: 'center'},
                        {field:'fatherfname',title:'原料描述',width: '200px',align:'left',halign: 'center'},
                        {field:'reelnum',title:'炉批号',width: '100px',align:'left',halign: 'center'},
                        {field:'productMan',title:'冲制工',width: '70px',align:'center',halign: 'center'},
                        {field:'productTime',title:'冲制时间',width: '150px',align:'right',halign: 'center'},
                        {field:'weighMan',title:'称重人',width: '80px',align:'center',halign: 'center'},
                        {field:'weighTime',title:'称重时间',width: '150px',align:'right',halign: 'center'},
                        {field:'jobFno',title:'报工编码',width: '150px',align:'right',halign: 'center'},
                        {field:'jobFname',title:'物料描述',width: '150px',align:'right',halign: 'center'},
                        {field:'uyear',title:'年度',width: '70px',align:'center',halign: 'center'},
                        {field:'umouth',title:'月度',width: '70px',align:'center',halign: 'center'},
                        {field:'plant',title:'事业部',width: '70px',align:'center',halign: 'center'},
                    ]],
                    pagination:true,
                });
//                $('#HalfPartOut-Data').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
//                $('#HalfPartOut-Data').datagrid({
//                    rowStyler: function (index, row) {
//                        var CLNumber =parseFloat(row.CLNumber);
//                        var ConnectPlan =parseFloat(row.ConnectPlan);
//                        //alert(11);
//                        if (CLNumber !== ConnectPlan) {
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

        $('#mp').datagrid('loadData',{total:0,rows:[]});


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

function edexport() {
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var plant = $('#edPlant').combobox('getText');
    var state = $('input[name="edCheck"]:checked').val();
    var planID = $('#cd-PlanID').val();
    var fno = $('#cd-Fno').val();
    var reelnum = $('#cd-reelnum').val();
    var equipID =  $('#ed-EquipID').combobox('getText');
    var partDrawing = $('#ed-PartDrawing').val();
    var productMan = $('#ed-ProductMan').val();
    var starttime = $('#eddb1').datebox('getValue');
    var endtime = $('#eddb2').datebox('getValue');
    var url = "../${ctxPath}/Export/Export?uyear="+uyear+"&umouth="+umouth+"&plant="+plant+"&planID="+planID+"&fno="+fno+"&reelnum="+reelnum+"&state="+state+"&equipID="+equipID+"&partDrawing=+"
        +partDrawing+"&productMan=+"+productMan+"&starttime=+"+starttime+"&endtime=+"+endtime+"";
    window.location.href = url;
}
</script>
