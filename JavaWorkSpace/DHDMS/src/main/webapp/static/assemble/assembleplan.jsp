<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true"  style="width: 100%">
    <div  data-options="region:'center' ,border:false" style="height:70%;" >
        <!-- Begin of toolbar -->
        <div class="easyui-panel" title="操作栏">
            <div id="monplan-toolbar">
                <div class="wu-toolbar-button">

                  <shiro:hasPermission name="/PlanProductController/import">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="uploadForm()" plain="true">导入</a>
                  </shiro:hasPermission>
                    <!--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="openAdd()" plain="true">打印</a>-->
                  <shiro:hasPermission name="/PlanProductController/export">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="export1()" plain="true">导出</a>
                  </shiro:hasPermission>
                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                    <span class="radioSpan">
                        <input class="easyui-validatebox"  type="radio" name="adminFlag" value="0">追加及更新</input>
                        <input class="easyui-validatebox" type="radio" name="adminFlag"  value="1">重新导入</input>
                    </span>
                </div>
                <div class="wu-toolbar-search">
                    <form id="loginForm" method="post">
                        <label>年月：</label><input id="MonPlandb" />&nbsp
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="monplanPlant" panelHeight="auto" data-options="

				method:'get',
				valueField:'remark',
				textField:'Fname',
				panelHeight:'auto'"
                                style="width:100px">
                        </select>&nbsp
                        <label>厂编及行号：</label><input id="MonPlanDHorder" type="text" name="MonPlanDHorder" class="wu-text" style="width:100px">&nbsp
                        <label>规格：</label><input id="MonPlanDes" name="MonPlanDes" class="wu-text" style="width:100px">&nbsp
                        <label>物料描述：</label><input id="MonPlanFname" name="MonPlanFname" class="wu-text" style="width:100px">&nbsp
<shiro:hasPermission name="/resource/edit">
                        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="Query()" data-options="iconCls:'icon-search'">查询</a>
</shiro:hasPermission>
                    </form>
                </div>
            </div>
        </div>
        <!-- End of toolbar -->
        <table title="月度计划        1.绿色表示：累计入库>=计划入库 且按时完成 2.蓝色表示：累计入库>=计划入库 且未按时完成 3.红色表示：开卡数>=计划串装数 4.黄色表示：累计串装>=计划串装" id="MonPlandatagrid"
               class="easyui-datagrid"  data-options="onClickRow: dgappend,editor:'text',singleSelect:true" style="height: 84%;width: 99%"></table>
    </div>
    <div title="详细信息" class="easyui-panel" data-options="region:'south',split:false" style="height:24%;">
        <table id="MonPlandg1"  data-options="editor:'text',singleSelect:true" >
            <tr>
                <td>厂编合同号:</td>
                <td><input class="easyui-textbox" data-options="required:true,editor:'text'" type="text" id="dhorderno" ></input></td>
                <td>责任班长</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="MONDutyman" ></input></td>
                <td>本月计划|计划串装数:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="ConnectPlan" ></input></td>
                <td>累计串装:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="SumDayNum" ></input></td>
                <td>接单:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="TakeOrder" ></input></td>
            </tr>
            <tr>
                <td>合同号及行号:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="OrderLine" ></input></td>
                <td>月度</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="MONUmouth" ></input></td>
                <td>本月计划|本月开卡数:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="CLNumber" ></input></td>
                <td>期初补卡:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="beginConnect" ></input></td>
                <td>交货期:</td>
                <td><input class="easyui-datebox" data-options="required:true" type="text" id="OrderTime" ></input></td>
            </tr>
            <tr>
                <td>物料编码</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="MONfno" ></input></td>
                <td>SAP订单号:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="text" id="SAPSDOrder" ></input></td>
                <td>本月计划|计划入库数:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="number" ></input></td>
                <td>累计入库:</td>
                <td><input class="easyui-textbox" data-options="required:true" type="number" id="SumDayInput" ></input></td>
                <td>完成:</td>
                <td><input class="easyui-datebox" data-options="required:true" type="text" id="CompleteOrder" ></input></td>
            </tr>
            <tr>
                <td>描述/打印标记</td>
                <td><input class="easyui-textbox"  data-options="required:true" type="text" id="MONDescrip" ></input></td>
                <td>工程兴化:</td>
                <td><input class="checkbox" data-options="required:true" type="checkbox" id="GCXH"  ></input></td>
                <td>是否验货:</td>
                <td><input class="checkbox" data-options="required:true" type="checkbox" id="IsCheck" ></input></td>
                <!--<td>是否验货:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="WorkPart" ></input></td>-->
                <!--<td>是否组合件:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="dutyman" ></input></td>-->
                <!--<td>责任人|配料责任人:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="MaterialDutyman" ></input></td>-->
                <!--<td>Bom状态:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="submitstate" ></input></td>-->
                <!--<td>累计入库:</td>-->
                <!--<td><input class="easyui-validatebox" data-options="required:true" type="text" id="planid" ></input></td>-->

            </tr>
            <tr>
                <!--<td>单节重差:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="SingleWeightOK" ></input></td>-->
                <!--<td>计划串装产值:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="ConnectValue" ></input></td>-->
                <!--<td>累计串装产值:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="DayNumValue" ></input></td>-->
                <!--<td>计划入库产值:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="NumberValue" ></input></td>-->
                <!--<td>兴化工程链:</td>-->
                <!--<td><input class="easyui-input" data-options="required:true" type="text" id="GCXH" ></input></td>-->
                <!--<td>   </td>-->

<shiro:hasPermission name="/PlanProductController/YDJHupdata">
                <td><button class="easyui-linkbutton" iconCls="icon-save" onclick="MONSaveRow()" style="width: 90px" id="save">保存</button></td>
                <td><button class="easyui-linkbutton" iconCls="icon-delete" onclick="aplandelete()" style="width: 90px" id="apdelete">删除</button></td>
</shiro:hasPermission>
            </tr>
        </table>
    </div>
</div>
<script type="text/javascript">
    $(function () {
//        $("input[name='adminFlag']").attr('checked', true);
        $("input[name='adminFlag'][value='0']").attr("checked",true);
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        $('#MonPlandb').val(year+"-"+month);
        //初始加载，表格宽度自适应
        $(document).ready(function(){
            fitCoulms();
        });
        //浏览器窗口大小变化后，表格宽度自适应
        $(window).resize(function(){
            fitCoulms();
        });
        var db = $('#MonPlandb');
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
//        alert(localStorage.getItem('Department'));
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            dataType:"json",
            url:'/PlanProductController/Plantquery',
            data:{
                Department: localStorage.getItem('Department'),
            },
            error:function(request) {      // 设置表单提交出错
                $.messager.alert('信息提示','出错了！','info');
            },
            success:function(results) {
                $('#monplanPlant').combobox('loadData', results);
            }
        });
    });
    //表格宽度自适应，这里的#dg是datagrid表格生成的div标签
    function fitCoulms(){
        $('#MonPlandatagrid').datagrid({
            fitColumns:true
        });
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
    var editindex ="";
    function dgappend(index) {
//         $('#MonPlandg1').datagrid('loadData', { total: 0, rows: [] });
        var row  = $('#MonPlandatagrid').datagrid("getSelected");
        var SumDayNum =row.SumDayNum;
        var beginConnect =row.beginConnect;
        var DayNum =row.DayNum;
        var number =row.number;
        var DayInput =row.DayInput;
        $("#MONDutyman").textbox("setValue",row.Dutyman);
        $("#MONUmouth").textbox("setValue",row.Umouth);
        $("#MONfno").textbox("setValue",row.fno);
        $("#MONDescrip").textbox("setValue",row.Descrip);
        $("#dhorderno").textbox("setValue",row.Dhorderno);
        $("#SAPSDOrder").textbox("setValue",row.SAPSDOrder);
        $("#TakeOrder").textbox("setValue",row.TakeOrder);
        $("#CompleteOrder").datebox('setValue', row.CompleteOrder);
        $("#OrderTime").datebox('setValue', row.OrderTime);
        $("#CLNumber").textbox("setValue",row.CLNumber);
        $("#ConnectPlan").textbox("setValue",row.ConnectPlan);
        $("#SumDayNum").textbox("setValue",row.SumDayNum);
        $("#beginConnect").textbox("setValue",row.beginConnect);
        $("#number").textbox("setValue",row.number);
        $("#SumDayInput").textbox("setValue",row.SumDayInput);
        $("#OrderLine").textbox("setValue",row.OrderLine);
        if(row.IsCheck =='1'){
            $("#IsCheck").attr('checked', true);
        }else{
            $("#IsCheck").attr('checked', false);
        }
        if(row.GCXH =='1'){
            $("#GCXH").attr('checked', true);
        }else{
            $("#GCXH").attr('checked', false);
        }

        editindex=index;
    }
    function export1(){
        var plant =$('#monplanPlant').combobox('getText');
        var NY =$('#MonPlandb').datebox('getValue');
        var DHorder=$("#MonPlanDHorder").val();
        var Des=$("#MonPlanDes").val();
        var  fname=$("#MonPlanFname").val();
        var url = "../PlanProductController/export?Plant="+plant+"&NY="+NY+"&DHorder="+DHorder+"&Des="+Des+"&fname="+fname+"";
        window.location.href = url;
    }
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

    function Query() {
        $("#MONDutyman").textbox("setValue",'');
        $("#MONUmouth").textbox("setValue",'');
        $("#MONfno").textbox("setValue",'');
        $("#MONDescrip").textbox("setValue",'');
        $("#dhorderno").textbox("setValue",'');
        $("#SAPSDOrder").textbox("setValue",'');
        $("#TakeOrder").textbox("setValue",'');
        $("#CompleteOrder").datebox('setValue','');
        $("#OrderTime").datebox('setValue','');
        $("#CLNumber").textbox("setValue",'');
        $("#ConnectPlan").textbox("setValue",'');
        $("#SumDayNum").textbox("setValue",'');
        $("#beginConnect").textbox("setValue",'');
        $("#number").textbox("setValue",'');
        $("#SumDayInput").textbox("setValue",'');
        $("#OrderLine").textbox("setValue",'');
        $("#IsCheck").attr('checked', false);
        $("#GCXH").attr('checked', false);
        $.messager.progress({
            title:'请稍后',
            msg:'页面加载中...'
        })
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"/PlanProductController/YDJHquery.action",
            dataType:"json",
            data:{
                NY: $('#MonPlandb').datebox('getValue'),
                Plant:$('#monplanPlant').combobox('getText'),
                DHorder:$("#MonPlanDHorder").val(),
                Des:$("#MonPlanDes").val(),
                fname:$("#MonPlanFname").val()
            },
            error:function(request) {      // 设置表单提交出错
                $.messager.progress('close');
                $.messager.alert('信息提示','出错了！','info');
            },
            success:function(results) {
                $.messager.progress('close');
                $('#MonPlandatagrid').datagrid({
                    rowStyler:function(index,row){
                        var CompleteOrder =row.CompleteOrder;
                        if( CompleteOrder !== "" && row.CompleteOrder !== null ){
                            if ((row.SumDayInput > row.DayNum||parseInt(row.SumDayInput) == parseInt(row.DayNum ))&& (row.CompleteOrder < row.OrderTime||row.CompleteOrder === row.OrderTime)){
                                return 'color:green;font-weight:bold;';
                            }
                            if ((row.SumDayInput > row.number||parseInt(row.SumDayInput) == parseInt(row.number) ) && row.CompleteOrder > row.OrderTime){
                                return 'color:blue;font-weight:bold;';
                            }
                        }
                        if(parseInt(row.SumDayNum)>parseInt(row.ConnectPlan)||parseInt(row.SumDayNum) == parseInt(row.ConnectPlan)){
                            return 'color:#FFD700;font-weight:bold;';
                        }
                        if(row.CLNumber>row.ConnectPlan||parseInt(row.CLNumber) == parseInt(row.ConnectPlan)){
                            return 'color:red;font-weight:bold;';
                        }
                    },
                    data:results,
                    fit: false, //自动适屏功能
                    autoRowWidth: true,
                    loadMsg: '正在加载中，请稍等... ',
                    fitColumns:true,//宽度自适应
                    singleSelect:true,
                    remoteSort:false,
                    width:'auto',
                    method:'get',
                    columns:[[
                        {field:'id',title:'ID',width:'50px',editor:'text',sortable:true,remoteSort:false},
                        {field:'Dhorderno',title:'厂编合同号',width:'180px',editor:'text',sortable:true,remoteSort:false},
                        {field:'SAPSDOrder',title:'SAP订单号',width:'100px',editor:'text',hidden:'true'},
                        {field:'TakeOrder',title:'接单',width:'50px',editor:'text',hidden:'true'},
                        {field:'CompleteOrder',title:'完成',width:'50px',editor:'datebox',hidden:'true'},
                        {field:'OrderTime',title:'交货期',width:'150px',editor:'datebox',sortable:true,remoteSort:false},
                        {field:'PartDrawing',title:'规格',width:'70px',editor:'text'},
                        {field:'F3',title:'节数',width:'50px',editor:'text'},
                        {field:'Color',title:'颜色',width:'50px'},
                        {field:'Descrip',title:'描述（打印标记等）',width:'250px',editor:'text'},
                        {field:'CLNumber',title:'本月计划|本月开卡数',width:'50px',editor:'text',hidden:true},
                        {field:'ConnectPlan',title:'本月计划|计划串装数',width:'50px',editor:'text',hidden:true},
                        {field:'DayNum',title:'本日串装',width:'50px',editor:'text'},
                        {field:'SumDayNum',title:'累计串装',width:'4%',editor:'text',hidden:true},
                        {field:'beginConnect',title:'期初补卡',width:'4%',editor:'text',hidden:true},
                        {field:'number',title:'本月计划|计划入库数',width:'4%',editor:'text',hidden:true},
                        {field:'DayInput',title:'本日入库',width:'50px',editor:'text'},
                        {field:'SumDayInput',title:'累计入库',width:'4%',editor:'text',hidden:true},
                        {field:'IsCheck',title:'是否验货',width:'4%',editor:'text',hidden:true},
                        {field:'IsCl',title:'是否组合件',width:'60px',editor:'text'},
                        {field:'Ismix',title:'配组合件',width:'50px',editor:'text'},
                        {field:'nwx',title:'内外销',width:'50px',editor:'text'},
                        {field:'MillionF3',title:'万节产值',width:'50px',editor:'text'},
                        {field:'WorkPart',title:'工段',width:'4%',editor:'text',hidden:'true'},
                        {field:'SendMouth',title:'交货月',width:'4%',editor:'text',hidden:'true'},
                        {field:'MillionWight',title:'万节重量',width:'4%',editor:'text',hidden:'true'},
                        {field:'fno',title:'物料编码',width:'80px',editor:'text'},
                        {field:'Fname',title:'物料描述',width:'250px',editor:'text'},
                        {field:'Meins',title:'单位',width:'2%',editor:'text',hidden:'true'},
                        {field:'OrderLine',title:'合同号及行号',width:'150px',editor:'text'},
                        {field:'Dutyman',title:'责任人|责任班长',width:'80px'},
                        {field:'MaterialDutyman',title:'责任人|配料责任人',width:'4%',hidden:'true'},
                        {field:'Plant',title:'事业部',width:'4%',editor:'text',hidden:'true'},
                        {field:'submitstate',title:'Bom状态',width:'4%',hidden:'true'},
                        {field:'SingleWeightOK',title:'单节重差',width:'5%',editor:'text'},
                        {field:'period',title:'生产周期',width:'4%',editor:'text',hidden:'true'},
                        {field:'MachineKind',title:'机器大类',width:'7%',editor:'text',hidden:'true'},
                        {field:'Uyear',title:'年度',width:'4%',hidden:'true'},
                        {field:'Umouth',title:'月度',width:'2%',hidden:'true',hidden:'true'},
                        {field:'OutputValue',title:'物料产值',width:'4%',hidden:'true'},
                        {field:'GCXH',title:'工程兴化',width:'4%',hidden:'true'},
                        {field:'ConnectValue',title:'计划串装产值',hidden:'true',hidden:'true'},
                        {field:'DayNumValue',title:'累计串装产值',hidden:'true',hidden:'true'},
                        {field:'NumberValue',title:'计划入库产值',hidden:'true',hidden:'true'},
                        {field:'DayInputValue',title:'累计入库产值',hidden:'true',hidden:'true'},
                        {field:'PoNo',title:'采购订单',width:'6%',hidden:'true'},
                        {field:'PoItem',title:'采购订单行项目',width:'6%',hidden:'true'},
                    ]],
                    pagination:true,
                    sortName:'id',
                    sortName:'Dhorderno',
                    sortName:'OrderTime',
                    pageList: [25, 50,100],
                    sortOrder:'asc'
                });
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
    function columnWidthAutoResize(){
        var cls=arguments[0];//需要自适应的列的名称
        $('#MonPlandatagrid').datagrid({
            onLoadSuccess:function(data){
                var rows=data.rows;//得到行数据
                var columnMaxCharacter=new Array();//该列最大字符数
                //遍历所有行数据,获得该列数据的最大字符数
                for(var i=0;i<rows.length;i++){
                    for(var j=0;j<cls.length;j++){//遍历需要设置的列
                        var s=eval("rows["+i+"]."+cls[j]);
                        //屏蔽html标签
                        s=s.replace("<center>","");
                        s=s.replace("</center>","");
                        if((typeof columnMaxCharacter[cls[j]])=='undefined'){
                            columnMaxCharacter[cls[j]]=0;
                        }
                        if(s.length>columnMaxCharacter[cls[j]]){
                            columnMaxCharacter[cls[j]]=s.length;
                        }
                    }
                }
                //设置列宽度和字体
                for(var j=0;j<cls.length;j++){
                    //得到该列的字体
                    //    alert($("td[field='"+cls[j]+"'] div").get(0).currentStyle);
                    // var fontSize=$("td[field='"+cls[j]+"'] div").get(0).currentStyle.fontSize;//获得字体大小
                    //  fontSize= fontSize.replace("px","");//去掉px方便运算
                    var fontSize=12;
                    var w=fontSize*(columnMaxCharacter[cls[j]]+1);//求出宽度
                    //设定该列的宽度
                    $("td[field='"+cls[j]+"'] div").width(w);
                }
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
        var item = $('#MonPlandatagrid').datagrid('getSelected');
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
                    $('#wu-form').form('load', data);
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
    var editIndex = undefined;
    function endEditing(){
        if (editIndex == undefined){return true}
        if ($('#MonPlandg1').datagrid('validateRow', editIndex)){
            var ed = $('#MonPlandg1').datagrid('getEditor', {index:editIndex,field:'productid'});
            $('#MonPlandg1').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }

    function MONSaveRow(index){
        var row  = $('#MonPlandatagrid').datagrid("getSelected");
        var GCXH="";
        var IsCheck="";
        if($("#GCXH").is(':checked')){
            GCXH= 1;
        }else{
            GCXH= 0;
        }
        if($("#IsCheck").is(':checked')){
            IsCheck= 1;
        }else{
            IsCheck= 0;
        }
        var checkfno="";
        if(parseInt(row.CLNumber) === 0 && row.fno !=  $("#MONfno").val()){
            checkfno="1";
        }
        if(parseInt(row.CLNumber) > 0 && row.fno !=  $("#MONfno").val()){
            $.messager.alert('提示','已存在开卡不允许修改物料编码！','info');
            $("#MONfno").textbox("setValue",row.fno);
        }
        else {
            $.ajax({
                type: "get",//数据发送的方式（post 或者 get）
                url: "/PlanProductController/YDJHupdata.action",//要发送的后台地址
                data: {
                    checkfno:checkfno,
                    Dutyman:$("#MONDutyman").val(),
                    Umouth:$("#MONUmouth").val(),
                    Descrip: $("#MONDescrip").val(),
                    dhorderno:$("#dhorderno").val(),
                    SAPSDOrder:$("#SAPSDOrder").val(),
                    TakeOrder:$("#TakeOrder").val(),
                    CompleteOrder:$("#CompleteOrder").val(),
                    OrderTime:$("#OrderTime").val(),
                    OrderLine: $("#OrderLine").val(),
                    CLNumber:$("#CLNumber").val(),
                    ConnectPlan:$("#ConnectPlan").val(),
                    SumDayNum:$("#SumDayNum").val(),
                    beginConnect:$("#beginConnect").val(),
                    number:$("#number").val(),
                    SumDayInput:$("#SumDayInput").val(),
                    ischeck:IsCheck,
                    GCXH:GCXH,
                    Fno: $("#MONfno").val(),
                    id:row.id,
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if(data.Fnocheck ==="NO"){
                        $.messager.alert('提示','物料编码不存在！','info');
                    }
                    if(data.num>0){
//                    alert(row.Dhorderno);
                        if(row.Umouth !== $("#MONUmouth").val()){
                            $('#MonPlandatagrid').datagrid("deleteRow",editindex);
                        }else{
                            row.Fname = data.Fname;
                            row.fno= $("#MONfno").val(),
                                row.Dutyman=$("#MONDutyman").val(),
                                row.Umouth=$("#MONUmouth").val(),
                                row.Descrip= $("#MONDescrip").val(),
                                row.Dhorderno=$("#dhorderno").val();
                            row.SAPSDOrder=$("#SAPSDOrder").val();
                            row.TakeOrder=$("#TakeOrder").val();
                            row.CompleteOrder=$("#CompleteOrder").val();
                            row.OrderTime=$("#OrderTime").val();
                            row.CLNumber=$("#CLNumber").val();
                            row.ConnectPlan=$("#ConnectPlan").val();
                            row.SumDayNum=$("#SumDayNum").val();
                            row.beginConnect=$("#beginConnect").val();
                            row.number=$("#number").val();
                            row.SumDayInput=$("#SumDayInput").val();
                            row.IsCheck=IsCheck;
                            row.OrderLine=$("#OrderLine").val();
                            row.GCXH=GCXH;
                            $('#MonPlandatagrid').datagrid('refreshRow', editindex);
                        }
                        $.messager.alert('提示','修改完成！','info');
                        $("#MONDutyman").textbox("setValue",'');
                        $("#MONUmouth").textbox("setValue",'');
                        $("#MONfno").textbox("setValue",'');
                        $("#MONDescrip").textbox("setValue",'');
                        $("#dhorderno").textbox("setValue",'');
                        $("#SAPSDOrder").textbox("setValue",'');
                        $("#TakeOrder").textbox("setValue",'');
                        $("#CompleteOrder").datebox('setValue','');
                        $("#OrderTime").datebox('setValue','');
                        $("#CLNumber").textbox("setValue",'');
                        $("#ConnectPlan").textbox("setValue",'');
                        $("#SumDayNum").textbox("setValue",'');
                        $("#beginConnect").textbox("setValue",'');
                        $("#number").textbox("setValue",'');
                        $("#SumDayInput").textbox("setValue",'');
                        $("#OrderLine").textbox("setValue",'');
                        $("#IsCheck").attr('checked', false);
                        $("#GCXH").attr('checked', false);
                    }
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    $.messager.alert('提示','发生错误！','info');
                }
            });
        }

    }
    /**
     * Name 载入数据
     */
    $('#MonPlandatagrid').datagrid({
        loadFilter:pagerFilter,
        rownumbers:true,
        singleSelect:false,
        pageSize:20,
        pagination:true,
        multiSort:true,
        //fitColumns:true,
        //fit:true,
    });
    function uploadForm(){
        var upload = new Ext.form.FormPanel({
            frame:true,
            labelWidth:100,
            labelAlign:'right',
            fileUpload:true,
            border:true,
            defaults : {
                width : 200,
                allowBlank : false,
                blankText : '该项不能为空！'
            },
            items:[{
                xtype:'displayfield',
                value:'上传文件为[*.xls]&nbsp;&nbsp;&nbsp;&nbsp;' +
                '<a href="javascript:;" onclick="download_log();" style="color: green;">模版下载</a>'
            },{
                id:'formFile',
                fieldLabel:"导入文件",
                name:'uploadFile',
                params:{
                    "umouth":$('#MonPlandb').val(),
                    "User":localStorage.getItem("User"),
                    "Plant":$('#monplanPlant').combobox('getText'),
                    "mpupinst":$('input[name="adminFlag"]:checked').val()
                },
                xtype:'textfield',
                fileUpload:true,
                inputType: 'file',
                listeners:{
                    render:function(){
                        Ext.get('formFile').on("change",function(){
                            var file = this.getValue();
                            var fs = file.split('.');
                            if(fs[fs.length-1].toLowerCase()=='xls'){
                                Ext.MessageBox.show({
                                    title:'信息',
                                    msg:'<font color="green">确定要上传文件:'+file+'？</font>',
                                    params:{
                                        "umouth":$('#MonPlandb').val(),
                                        "User":localStorage.getItem("User"),
                                        "Plant":$('#monplanPlant').combobox('getText'),
                                        "mpupinst":$('input[name="adminFlag"]:checked').val()
                                    },
                                    width:300,
                                    buttons:{'ok':'确定','no':'取消'},
                                    icon:Ext.MessageBox.WARNING,
                                    closable:false,
                                    fn:function(e){
                                        if(e == 'ok'){
                                            if (upload.form.isValid()) {
                                                upload.getForm().submit({

                                                    url :'/PlanProductController/import.action',
                                                    method :'POST',
                                                    params:{
                                                        "umouth":$('#MonPlandb').val(),
                                                        "User":localStorage.getItem("User"),
                                                        "Plant":$('#monplanPlant').combobox('getText'),
                                                        "mpupinst":$('input[name="adminFlag"]:checked').val()
                                                    },
                                                    waitTitle :'系统提示',
                                                    waitMsg :'正在上传,请稍后...',
                                                    success : function(form,action) {
                                                        console.log(action);
                                                        var msg = action.result.message;
                                                        Ext.MessageBox.show({
                                                            title:'信息',
                                                            width:250,
                                                            msg:msg,
                                                            buttons:{'ok':'确定','no':'取消'},
                                                            icon:Ext.MessageBox.INFO,
                                                            closable:false,
                                                            fn:function(e){
                                                                if(e=='ok'){
                                                                    win.close();
                                                                    Query();
                                                                } else {
                                                                    Ext.getCmp('formFile').setValue('');
                                                                }
                                                            }
                                                        });
                                                    }
                                                });
                                            }
                                            else {
                                                Ext.MessageBox.show({
                                                    title:'信息',
                                                    width:200,
                                                    msg:'请填写完成再提交!',
//                                            animEl:'insert.win.info',
                                                    buttons:{'ok':'确定'},
                                                    icon:Ext.MessageBox.ERROR,
                                                    closable:false
                                                });
                                            }
                                        }
                                    }
                                });
                            }else{
                                Ext.MessageBox.show({
                                    title:'信息',
                                    width:200,
                                    msg:'上传文件格式不对,请重新选择!',
                                    buttons:{'ok':'确定'},
                                    icon:Ext.MessageBox.ERROR,
                                    closable:false,
                                    fn:function(e){
                                        if(e=='ok'){
                                            Ext.getCmp('formFile').setValue('');
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            }]
        });
        var win = new Ext.Window({
            title:'上传',
            width:400,
            height:150,
            layout:'fit',
            modal:true,
            items:[upload],
            bbar:['->',{
//    		id:'insert.win.info',
//    		text:'上传',
//    		handler:function(){
//
//    		}
//    	},{
                text:'关闭',
                handler:function(){
                    win.close();
                }
            }]
        }).show();
    }

    /**
     * 下载模版
     */
    function download_log(){
        if (!Ext.fly('test')) {
            var frm = document.createElement('form');
            frm.id

                = 'test';
            frm.name

                = id;
            frm.style.display = 'none';
            document.body.appendChild(frm);
        }
        Ext.Ajax.request({
            url: '/PlanProductController/download.action',
            form: Ext.fly('test'),
            method: 'POST',
            isUpload: true
        });
    }
    function aplandelete() {
        var row  = $('#MonPlandatagrid').datagrid("getSelected");
        $.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "/PlanProductController/APdelete.action",//要发送的后台地址
            data: {
                Umouth:row.Umouth,
                Uyear:row.Uyear,
                OrderLine: row.OrderLine,
                Plant:row.Plant,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                if(data.OK ==="NO"){
                    $.messager.alert('提示','删除失败！','info');
                }
                else{
                    $('#MonPlandatagrid').datagrid("deleteRow",editindex);
                    $.messager.alert('提示','删除成功！','info');
                    $("#MONDutyman").textbox("setValue",'');
                    $("#MONUmouth").textbox("setValue",'');
                    $("#MONfno").textbox("setValue",'');
                    $("#MONDescrip").textbox("setValue",'');
                    $("#dhorderno").textbox("setValue",'');
                    $("#SAPSDOrder").textbox("setValue",'');
                    $("#TakeOrder").textbox("setValue",'');
                    $("#CompleteOrder").datebox('setValue','');
                    $("#OrderTime").datebox('setValue','');
                    $("#CLNumber").textbox("setValue",'');
                    $("#ConnectPlan").textbox("setValue",'');
                    $("#SumDayNum").textbox("setValue",'');
                    $("#beginConnect").textbox("setValue",'');
                    $("#number").textbox("setValue",'');
                    $("#SumDayInput").textbox("setValue",'');
                    $("#OrderLine").textbox("setValue",'');
                    $("#IsCheck").attr('checked', false);
                    $("#GCXH").attr('checked', false);
                }
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.alert('提示','发生错误！','info');
            }
        });
    }

</script>