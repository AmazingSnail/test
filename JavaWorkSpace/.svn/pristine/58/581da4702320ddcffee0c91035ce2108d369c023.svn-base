<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-12
  Time: 10:57----质量管理
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


    .qa{
        width:85%;
        height:75%;
    }

    .qc{
        width:20%;
        height:75%;
    }
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .w2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="质量管理" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
                <div id="test1"><input  id ="qadb2" style="width:110px" class="easyui-text" hidden="hidden"></div>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="monp_uploadForm()" plain="true">导入</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="monp_export1()" plain="true">导出</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="SaveMould()" plain="true">接收模具</a>--%>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="OutMould()" plain="true">发出模具</a>--%>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label><span class="w3">事业部</span>：</label>
                            <select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="qaPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:100px">
                            </select></td>
                        <td><label>起始时间：</label><input  id ="qadb1" style="width:110px" class="easyui-datebox"></td>
                        <td><label>设备编号：</label><select class="easyui-combobox" style="width:100px" name="MonthPlan-Plant" datatype="text" id="qa-EquipID" panelHeight="auto" data-options="
                                valueField:'EquipID',
                                textField:'EquipID',
                                panelHeight:'250'"
                                                        style="width:100px">
                        </select></td>
                        <td><label>送检类型：</label><select class="easyui-combobox" name="Pkgin-FnameStr" datatype="text" id="qa-CheakTypes" panelHeight="auto" style="width:100px">
                            <option value=""> </option>
                            <option value="自检">自检</option>
                            <option value="送检">送检</option>
                        </select> </td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="qaquery()" style="width: 100px" data-options="iconCls:'icon-search'">查询</a></td>
                    </tr>
                    <tr>
                        <td><label><span class="w2">部门</span>：</label>
                            <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="qadepartment" panelHeight="auto" data-options="
                                valueField:'DepartMent',
                                textField:'DepartMent',
                                panelHeight:'250'"
                                    style="width:100px">
                            </select></td>
                        <td><label>结束时间：</label><input  id ="qadb" style="width:110px" class="easyui-datebox"></td>
                        <td> <label>送检单号：</label><input id="qa-CheakID" class="easyui-textbox" style="width:100px"></td>
                        <td> <label>任务编号：</label><input id="qa-PlanID" class="easyui-textbox" style="width:100px"></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="qa" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'">
                        <table id="qa" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
            <div class="qc"  data-options="region:'east',split:true">
                <table class="easyui-datagrid" id="qaid"   style="white-space: nowrap;height: 100%" data-options="singleSelect:true,editor:'text'" ></table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $("#test1" ).css("display", "none");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#qadb1').val(year+"-"+month+"-"+day);
        $('#qadb').val(year+"-"+month+"-"+day);
        $('#qadb2').val(year+"-"+month+"-"+day);
        var db = $('#qadb2');
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
                $('#qaPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MouldManage/Query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息
            },
            success: function (data) {
                $('#qadepartment').combobox('loadData', data);
            }
        });


    });
        $('#qadepartment').combobox({
            onChange: function (newValue, oldValue) {
                $('#qa-EquipID').combobox('clear');
                var department = newValue;
                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url:'${ctxPath }/QualityAssurance/EquipID.action',
                    dataType: "json",
                    data: {
                        plant: localStorage.getItem("Department"),
                        department:department
                    },
//                data:$("#login").val(),   //序列化
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息
                    },
                    success: function (data) {
                        $('#qa-EquipID').combobox('loadData', data);
                    }
                });
            }
        });

    function qaquery() {
        var plant = $('#qaPlant').combobox('getText');
        var deparment = $('#qadepartment').combobox('getText');
        var CheakTypes = $('#qa-CheakTypes').combobox('getText');
        var starttime = $('#qadb1').datebox('getValue');
        var endtime = $('#qadb').datebox('getValue');
        var EquipID = $('#qa-EquipID').combobox('getText');
        var CheakID = $('#qa-CheakID').val();
        var PlanID = $('#qa-PlanID').val();
        var fdata;

        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/QualityAssurance/Query.action",//要发送的后台地址
            data: {
                plant:plant,
                deparment:deparment,
                CheakTypes:CheakTypes,
                starttime:starttime,
                endtime:endtime,
                EquipID:EquipID,
                CheakID:CheakID,
                PlanID:PlanID,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#qa").datagrid({
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
                        {field:'id',title:'序号',width: '30px',align:'center',halign: 'center',hidden:'hidden'},
                        {field:'cheakID',title:'送检单号',width: '90px',align:'left',halign:'center'},
                        {field:'equipID',title:'设备编号',width: '60px',align:'center',halign:'center'},
                        {field:'planID',title:'任务编号',width: '80px',align:'right',halign:'center'},
                        {field:'cheakTypes',title:'检验类型',width: '70px',align:'center',halign: 'center'},
                        {field:'randomTime',title:'送检时间',width:'170px',align:'right',halign: 'center'},
                        {field:'randomMan',title:'送检人',width: '55px',align:'center',halign: 'center'},
                        {field:'randomNum',title:'检验数量',width: '80px',align:'right',halign: 'center'},
                        {field:'cheakMan',title:'检验人员',width: '55px',align:'center',halign: 'center'},
                        {field:'cheakTime',title:'检验时间',width: '170px',align:'right',halign: 'center'},
                        {field:'nQualNum',title:'不合格数',width: '55px',align:'right',halign: 'center'},
                        {field:'qualRatio',title:'合格率',width: '55px',align:'center',halign: 'center'},
                        {field:'department',title:'部门',width: '70px',align:'center',halign: 'center'},
                        {field:'plant',title:'事业部',width: '80px',align:'center',halign: 'center'},

                    ]],
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

        $('#qa').datagrid('loadData',{total:0,rows:[]});
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
    $("#qa").datagrid({
        //双击事件
        onClickRow : function (index, row) {  //easyui封装好的事件（被单机行的索引，被单击行的值）
            var cheakID = row.cheakID;
            $.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${ctxPath}/QualityAssurance/jilian.action",
                dataType:"json",
                data: {
                    cheakID:cheakID,
                },
                success:function(data) {
                    fdata = data;
                    $('#qaid').datagrid({
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
                        //fitColumns:true,
                        //fit:true,
                        method:'get',
                        data:fdata,
                        columns: [[
                            {field:'cheakID',title:'送检单号',width:'70px',align:'right',halign:"center"},
                            {field:'partDrawing',title:'规格',width:'70px',editor:'text',align:'center'},
                            {field:'holeHD',title:'孔心距',width:'70px',editor:'text',align:'center'},
                            {field:'aperture',title:'孔径',width:'70px',editor:'text',align:'center'},
                            {field:'holeSite',title:'空位置度',width:'70px',editor:'text',align:'center'},
                            {field:'thickness',title:'厚度',width:'70px',editor:'text',align:'center'},
                            {field:'facade',title:'外观',width:'70px',editor:'text',align:'center'},
                            {field:'height',title:'链板高度',width:'70px',editor:'text',align:'center'},
                            {field:'leuchtfeld',title:'光亮带',width:'70px',editor:'text',align:'center'},
                        ]]
                    })
                    $('#ptid').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);

                },

            })
            $('#ptid').datagrid('loadData',{total:0,rows:[]});
        }
    });
</script>
