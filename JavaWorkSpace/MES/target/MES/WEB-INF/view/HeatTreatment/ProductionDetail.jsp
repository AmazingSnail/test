<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/7/5
  Time: 13:54  生产明细
  To change this template use File | Settings | File Templates.
--%>
<meta charset="UTF-8">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }


    .PA{
        width:60%;
        height:75%;
    }
    .datagrid-row-selected {

        color: #1A1A1A;
        font-weight:bold;
        font-size: 300%;
    }
    .PC{
        width:40%;
        height:75%;
    }
    .pdd3{
        letter-spacing:0.6em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .pdd2{
        letter-spacing:0.2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
    }
    .haorooms{
        height: calc(100% - 100px);
    }


    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="生产明细" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
            <div class="wu-toolbar-button">
                <div id="pdtest"><input  id ="pd1" style="width:110px" class="easyui-text" hidden="hidden"></div>
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="pgm_export()" plain="true">导出</a>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td> <label><span class="pdd3" >事业部</span>：</label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="miPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select></td>
                        <td>开始时间：<input  id ="pd2" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td><label>操作人员：</label>&nbsp<input id="pm_name" class="easyui-textbox" style="width:90px"></td>
                        <td><label>物料编码：</label><input id="pm_fno" class="easyui-textbox" style="width:100px"></td>
                        <td rowspan="2"><a href="#" class="easyui-linkbutton"  onclick="pd_query()" data-options="iconCls:'icon-search'" style="width:60px;height: 50px">查询</a></td>
                    </tr>
                    <tr>
                        <td><label><span class="pdd2" >生产批次</span>：</label>&nbsp<input id="SCPC" class="easyui-textbox" style="width:90px"></td>
                        <td>结束时间：<input  id ="pd3" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td><label>设备编号：</label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="pm_equid" panelHeight="auto" data-options="
                                valueField:'equid',
                                textField:'equid',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select>
                        </td>
                        <td><label>物料描述：</label><input id="pm_fname" class="easyui-textbox" style="width:100px">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="PA" data-options="region:'west',split:true,border:true">
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'" >
                        <table id="pd" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
            <div class="PC" data-options="region:'center'"  >
                <div class="easyui-layout" style="width:100%;height:100%;margin:0 auto;">
                    <div data-options="region:'north',title:'温度记录',split:true" style="height:60%;">
                        <table class="easyui-datagrid" id="pdid"  style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>
                    </div>
                    <div data-options="region:'south',title:'硬度及其它检测记录',split:true" style="height:40%;">
                        <table class="easyui-datagrid" id="pdid1"  style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $("#pdtest" ).css("display", "none");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#pd2').val(year+"-"+month+"-"+day );
        $('#pd3').val(year+"-"+month+"-"+day);
        var db = $('#pd1');
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
                $('#miPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/ProductionDetail/getequid.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#pm_equid').combobox('loadData', data);
                //alert(11111);

            }
        });

    });

    function pd_query() {
        $('#pdid').datagrid('loadData',{total:0,rows:[]});
        var plant = $('#miPlant').combobox('getText');
        var plant1 = localStorage.getItem("Department");
        var pm_fname = $('#pm_fname').val();
        var pm_fno = $('#pm_fno').val();
        var SCPC = $('#SCPC').val();
        var pm_equid = $('#pm_equid').combobox('getValue');
        var starttime = $('#pd2').datebox('getValue');
        var endtime = $('#pd3').datebox('getValue');
        var name = localStorage.getItem("User");
        if(plant==plant1){
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${ctxPath}/ProductionDetail/query.action",//要发送的后台地址
                data: {
                       fname :pm_fname,
                       fno :pm_fno,
                         equid :pm_equid,
                    starttime:starttime,
                    endtime:endtime,
                    plant:plant,
                    SCPC:SCPC,
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    $.messager.progress('close');
                    console.log(data);
                    fdata = data;
                    $("#pd").datagrid({
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
                            {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                            {field:'prodnum',title:'生产编号',width: '90px',align:'center',halign:'center'},
                            {field:'batchnum',title:'热处理批次',width: '100px',align:'center',halign:'center'},
                            {field:'fno',title:'物料编码',width: '90px',align:'center',halign:'center'},
                            {field:'fname',title:'物料描述',width: '250px',align:'left',halign:'center'},
                            {field:'weightnum',title:'重量',width: '60px',align:'center',halign: 'center'},
                            {field:'equipid',title:'设备编号',width:'65px',align:'center',halign: 'center'},
                            {field:'planid',title:'计划ID',width: '90px',align:'center',halign:'center'},
                            {field:'heatno',title:'炉批号',width: '80px',align:'center',halign: 'center'},
                            {field:'supplier',title:'供货工厂',width: '70px',align:'center',halign: 'center'},
                            {field:'factorytime',title:'供货时间',width: '100px',align:'center',halign: 'center'},
                            {field:'productman',title:'操作人员',width: '80px',align:'center',halign: 'center'},
                            {field:'begintime',title:'开始时间',width: '180px',align:'right',halign: 'center'},
                            {field:'endtime',title:'结束时间',width: '180px',align:'right',halign: 'center'},
                            {field:'plant',title:'事业部',width: '70px',align:'center',halign: 'center'},
                        ]],
                    });
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    alert(msg);//弹出错误信息
                }

            });
        }else {
            $.messager.alert('温馨提示', '不能跨工厂查询!');
        }

//        $('#pd').datagrid({
//            rowStyler: function (index, row) {
//                var over = row.statusName;
//                var s = row.sure;
//                var s1 = row.process;
//                if(over=='生产中'){
//                    return 'color:red';
//                }else if(over=='已完成'){
//                    if(s=='确认'&&s1=='确认'){
//                        return 'background-color:green';
//                    }else if (s=='确认'&&s1=='未确认'){
//                        return 'background-color:#98FB98';
//                    }
//                }
//            }
//        });
        $('#pd').datagrid('loadData',{total:0,rows:[]});

//        $('#Mmid').datagrid('loadData',{total:0,rows:[]});

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
    //   function  jilian() {
    $("#pd").datagrid({
        //双击事件
        onClickRow : function (index, row) {  //easyui封装好的事件（被单机行的索引，被单击行的值）
            var equipid = row.equipid;
            var plant = row.plant;
            var begintime = row.begintime;
            var endtime = row.endtime;
            var prodnum = row.prodnum;
            $.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${ctxPath}/ProductionDetail/jilian.action",
                dataType:"json",
                data: {
                    equipid:equipid,
                    plant:plant,
                    begintime:begintime,
                    endtime:endtime,
                },
                success:function(data) {
                    fdata = data;
                    $('#pdid').datagrid({
                        data: fdata,
                        loadFilter:pagerFilter,
                        rownumbers:true,
                        singleSelect:true,
                        fit: false, //自动适屏功能
                        nowrap:false,
                        width:'auto',
                        pageList:[25,50,100],//分页列表
                        pagination:true,
                        multiSort:true,
                        remoteSort:false,
                        showFooter: true,
                        method:'get',
                        data:fdata,
                        columns: [[
                            {field:'equipid',title:'设备ID',width:'80',editor:'text',halign:"center",align:'center'},
                            {field:'quenchtemp1max',title:'淬火1区最大温度',width:'100',editor:'text',align:'center'},
                            {field:'quenchtemp1min',title:'淬火1区最小温度',width:'100',editor:'text',align:'center'},
                            {field:'quenchtemp2max',title:'淬火2区最大温度',width:'100',editor:'text',align:'center'},
                            {field:'quenchtemp2min',title:'淬火2区最小温度',width:'100',editor:'text',align:'center'},
                            {field:'quenchtemp3max',title:'淬火3区最大温度',width:'100',editor:'text',align:'center'},
                            {field: 'quenchtemp3min', title: '淬火3区最小温度', width: '100', editor: 'text',align:'center'},
                            {field: 'quenchtemp4max', title: '淬火4区最大温度', width: '100', editor: 'text',align:'center'},
                            {field: 'quenchtemp4min', title: '淬火4区最小温度', width: '100', editor: 'text',align:'center'},
                            {field: 'quenchtemp5max', title: '淬火5区最大温度', width: '100', editor: 'text',align:'center'},
                            {field: 'quenchtemp5min', title: '淬火5区最小温度', width: '100', editor: 'text',align:'center'},
                            {field: 'carpotent1max', title: '1区碳势最大值', width: '100',editor: 'text',align:'center'},
                            {field: 'carpotent1min', title: '1区碳势最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'carpotent2max', title: '2区碳势最大值', width: '100',editor: 'text',align:'center'},
                            {field: 'carpotent2min', title: '2区碳势最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'quenchtimemax', title: '淬火保温时间最大值', width: '100', editor: 'text',align:'center'},
                            {field: 'quenchtimemin', title: '淬火保温时间最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'cooltempmax', title: '油温最大值（冷却温度）', width: '100', editor: 'text',align:'center'},
                            {field: 'cooltempmin', title: '油温最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertemp1max', title: '回火1区温度最大值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertemp1min', title: '回火1区温度最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertemp2max', title: '回火2区温度最大值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertemp2min', title: '回火2区温度最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertemp3max', title: '回火3区温度最大值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertemp3min', title: '回火3区温度最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertimemax', title: '回火保温时间最大值', width: '100', editor: 'text',align:'center'},
                            {field: 'tempertimemin', title: '回火保温时间最小值', width: '100', editor: 'text',align:'center'},
                            {field: 'recordtime', title: '记录时间', width: '200',editor: 'text',align:'center'},
                        ]]
                    })
                    $('#ptid').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                },

            })
            $('#pdid').datagrid('loadData',{total:0,rows:[]});
            $.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${ctxPath}/ProductionDetail/jilianHM.action",
                dataType:"json",
                data: {
                    equipid:equipid,
                    plant:plant,
                    prodnum:prodnum,
                },
                success:function(data) {
                    fdata = data;
                    $('#pdid1').datagrid({
                        data: fdata,
                        loadFilter:pagerFilter,
                        rownumbers:true,
                        singleSelect:true,
                        fit: false, //自动适屏功能
                        nowrap:false,
                        width:'auto',
                        pageList:[25,50,100],//分页列表
                        pagination:true,
                        multiSort:true,
                        remoteSort:false,
                        showFooter: true,
                        method:'get',
                        data:fdata,
                        columns: [[
                            {field:'equipid',title:'设备ID',width:'80',editor:'text',halign:"center",align:'center'},
                            {field:'prodnum',title:'生产编号',width: '90px',align:'center',halign:'center'},
                            {field:'firetypes',title:'类型',width:'100',editor:'text',align:'center'},
                            {field:'parthard1',title:'零件1硬度',width:'100',editor:'text',align:'center'},
                            {field:'parthard2',title:'零件2硬度',width:'100',editor:'text',align:'center'},
                            {field:'parthard3',title:'零件3硬度',width:'100',editor:'text',align:'center'},
                            {field:'parthard4',title:'零件4硬度',width:'100',editor:'text',align:'center'},
                            {field: 'parthard5', title: '零件5硬度', width: '100', editor: 'text',align:'center'},
                            {field: 'carbinolflow', title: '甲醇流量', width: '100', editor: 'text',align:'center'},
                            {field: 'tenacity', title: '回火韧性', width: '100', editor: 'text',align:'center'},
                            {field: 'recordtime', title: '记录时间', width: '200', editor: 'text',align:'center'},
                        ]]
                    })
                    $('#ptid').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                },

            })
            $('#pdid1').datagrid('loadData',{total:0,rows:[]});
        }
    });
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
    function ptm_export() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var plant = $('#ptmPlant').combobox('getText');
        var state = $('input[name="ptmcheck"]:checked').val();
        var PartDrawing = $('#ptm-PartDrawing').val();
        var MouldID = $('#ptm-MouldID').val();
        var ptmStatus = $('#ptm-Status').val();
        var url = "../${ctxPath}/ProductionTask/Export?uyear="+uyear+"&umouth="+umouth+"&plant="+plant+"&MouldID="+MouldID+"&PartDrawing="+PartDrawing+"&ptmStatus="+ptmStatus+"&state="+state+"";
        window.location.href = url;
    }
</script>
