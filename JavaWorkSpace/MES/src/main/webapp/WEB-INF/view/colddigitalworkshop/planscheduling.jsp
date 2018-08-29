<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .A{
        width:65%;
        height:75%;
    }
    .B{
        width: 10%;
        height: 75%;
    }
    .C{
        width:35%;
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
        <div class="easyui-panel" title="开流转卡" data-options="fit:true">
            <div id="psd_toolbar" style="overflow:auto;width:100%;height: 78px">
                <div class="wu-toolbar-button">
                    <%--<shiro:hasPermission name="/KCard/Print">--%>
                        <%--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="Print()" plain="true">打印</a>--%>
                    <%--</shiro:hasPermission>--%>
                    <span>丨</span>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>--%>
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <table class="APtableborder">
                        <tr>
                        <td>查询年月：</td><td><input  id ="psd_dbk" style="width:100px" ><td>
                        <!--class="easyui-datebox"-->
                        <td><label>冷卷物料代码：</label></td><td><input id="psd_fno" name="fno"
                                                                  class="easyui-textbox"       style="width:100px" onkeypress="psd_getKey()"></td>
                        <td><label>冷卷物料描述：</label></td><td><input class="easyui-textbox" id="psd_fname" name="fname" style="width:100px" onkeypress="psd_getKey()"></td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="psd_forGetDate()" data-options="iconCls:'icon-search'">查询</a><td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="psd_showMore()" data-options="iconCls:'icon-search'">更多</a><td>
                        </tr>
                    </table>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white;display: none" id="psd_More">

                    </div>
                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <iframe id="proxy" hidden style="display: none;"></iframe>
            <div id="psd_GoDiv" class="easyui-dialog" title="编辑日计划" data-options="iconCls:'icon-save',closed:true,onClose:psd_onClose" style="text-align: center;width:500px;height:400px;padding:10px">
                    <%--<table id="psd_GoTable"  class ="easyui-datagrid" title="grid" cellpadding="5" width="auto" style="white-space:nowrap" >--%>
                        <%--<td id="psd_GoTd">--%>
                            <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="spm_parentUpdatefno"  style="width:150px" data-options="required:'true'"></input></td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>

                        <%--</td>--%>
                    <%--</table>--%>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="A" data-options="region:'west',split:true" >
                    <div id="psd_cc" class="easyui-layout" data-options="fit:true" style="width:100%;height:100%">
                        <div style="width: 100%;height:20%" data-options="region:'center'">
                            <table id="psd_yd" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="月度计划(毛料)" data-options="singleSelect:true,onClickRow:psd_OnClickRow">
                            </table>
                        </div>
                        <div style="height: 58%" title="详细信息" data-options="region:'south',split:false" class="easyui-panel" >
                            <table id="psd_ydmx" class="easyui-treegrid" style="white-space: nowrap;height: 100%" title="月度计划(毛料)" data-options="singleSelect:true,onClickRow:psd_OnClickRow2,idField: 'fno',
                   treeField: 'fno'">
                            </table>
                        </div>
                    </div>
                </div>

                <div class="B" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
<shiro:hasPermission name="/psd/openGo">
                            <button id="psd_openGo" onclick="psd_openGo()"  class="easyui-linkbutton" style="margin-top: 100px">开卡>></button>
</shiro:hasPermission>
                    </div>
                    <div style="">
<shiro:hasPermission name="/psd/Back">
                            <button id="psd_Back" class="easyui-linkbutton" onclick="psd_Back()">删除<<</button>
</shiro:hasPermission>
                    </div>
                </div>
                <div class="C"  data-options="region:'east',split:true">
                    <table class="easyui-datagrid" id="psd_dailyplan" title="本日开卡信息 (红字表示：已打印行项目)" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,onClickRow:psd_OnClickRow2,editor:'text'" ></table>
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
        $('#psd_dbk').val(year+"-"+month);
        var db = $('#psd_dbk');
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
//    getMplan();
//    getKCard();
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
                $('#psd_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#psd_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#psd_BMan').combobox('clear');
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "${ctxPath }/Syb/BMan.action",
                        dataType: "json",
                        data: {
                            plant: plant
                        },
//                data:$("#login").val(),   //序列化
                        error: function (request) {      // 设置表单提交出错
                            $("#showMsg").html(request);  //登录错误提示信息

                        },
                        success: function (data) {
                            $('#psd_BMan').combobox('loadData', data);

                        }
                    });
                    var uyear = $('#psd_dbk').val().substr(0,4);
                    var umouth = $('#psd_dbk').val().substr(5);


                    //var   plant= $('#plant').combobox('getText');
                    var   color = $('#psd_color').val();
                    var F3 = $('#psd_F3').val();
                    var nwx = $('#psd_Nwx').val();
                    var   dhorderno=$('#psd_dhorderno').val();
                    var   PartDrawing=$('#psd_PartDrawing').val();
                    var   fname=$('#psd_fname').val();
                    jQuery.ajax({
                        type: "get",//数据发送的方式（post 或者 get）
                        url: "${ctxPath }/KCard/queryYS.action",//要发送的后台地址
                        data: {
                            uyear: uyear,
                            umouth: umouth,
                            plant: $('#psd_Plant').combobox('getText'),
                            Dutyman: $('#psd_BMan').combobox('getText'),
                            dhorderno: dhorderno,
                            PartDrawing: PartDrawing,
                            fname: fname,
                            F3: F3,
                            nwx: nwx
                        },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                        dataType: "json",//后台处理后返回的数据格式
                        success: function (data) {//ajax请求成功后触发的方法
                            $('#psd_color').combobox('loadData', data);
                        }
                    })
                }

            }
        });
        $("input[name='MDMKCardCheck']").eq(0).attr("checked","checked");
        $("#psd_More").hide();
        $("#psd_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#psd_More").hide();

        });
    });

    function psd_getKey() {
        if(event.keyCode==13){
            psd_forGetDate();
        }
    }
    function psd_showMore() {
        $("#psd_More").toggle();
    }
    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }
    var resultsState ;
    var rowindex;
    function psd_openGo() {
        var row  = $("#psd_yd").datagrid("getSelected");
        var year = $('#psd_dbk').val().substr(0,4);
        var month = $('#psd_dbk').val().substr(5);
        if(row==null){
            $.messager.alert('温馨提示', '请选择有效的行项目!');
        }else{
            if (Number(row.takeweidgt)<Number(row.planweidgt)){
                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url: "${ctxPath }/PlanScheduling/selectOnlyChilds.action",
                    dataType: "json",
                    data: {
                        id:row.id,
                        year:year,
                        month:month
                    },
                    error: function (request) {      // 设置表单提交出错
                        $.messager.progress('close');
                        $.messager.alert('信息提示', '出错了！', 'info');
                    },
                    success: function (results) {
                        resultsState = results;
                        parent.$.modalDialog({
                            title:"开流转卡",
                            width:500,
                            height:400,
                            href:'colddigitalworkshop/planschedulingdiv.jsp',
                            onLoad:function(){
                                $('#psd_GoDivDiv').append('<label><span>库位选择</span>：</label><select class="easyui-combobox" name="location" datatype="text" id="psd_location" panelHeight="auto" data-options="valueField:\'batchno\',textField:\'location\',required:\'true\'" style="width:100px"/><input id="psd_BatchNo" name="BatchNo" class="easyui-textbox" style="width:100px" disabled=true><label>开始时间：</label><input id="psd_planstartdate" name="planstartdate" data-options="required:\'true\'" class="easyui-datebox" style="width:100px" >');
                                $('#psd_GoDivDiv').append('<table class="easyui-datagrid" title="aaaaa" id="psd_Datagrid" style="width:450px;height:250px" data-options="singleSelect:true,onClickRow:psd_fromOnClickRow,collapsible:true,method:\'post\'"><thead><tr><th data-options="field:\'fno\',width:80">物料编码</th><th data-options="field:\'fname\',width:80">物料描述</th><th data-options="field:\'takenum\',width:100,editor:{type:\'text\',options:{required:\'true\'}}">排产条数（条）</th><th data-options="field:\'planweidgt\',width:80,align:\'right\'">计划重量</th><th data-options="field:\'leavenum\',width:80,align:\'right\'">剩余重量</th><th data-options="field:\'fnoname\',width:80,align:\'right\'">名称</th></tr></thead></table>');
                                $.parser.parse($("#psd_GoDivDiv"));
                                for(var i = 0;i<results.rows.length;i++){
//                        $("#psd_GoTd").append('<tr><td><span>'+results.rows[i].fno+'</span>:<input class="easyui-textbox" type="text" name="'+results.rows[i].fno+'"   style="width:70px" data-options="required:true"/><span>计划余量：'+results.rows[i].plannum+'</spam></td></tr>');
//                        $.parser.parse($("#psd_GoTd"));
                                    $('#psd_Datagrid').datagrid('appendRow',{fno:results.rows[i].fno,fname:results.rows[i].fname,takenum:0,planweidgt:results.rows[i].planweidgt,leavenum:Number(results.rows[i].planweidgt)-Number(results.rows[i].takeweidgt),fnoname:results.rows[i].fnoname});
//                        editIndex = $('#psd_Datagrid').datagrid('getRows').length-1;
//                        $('#psd_Datagrid')
//                            .datagrid('beginEdit', editIndex);
                                }
//                                $('#psd_GoDivDiv').append('<td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="psd_parentlistUpdate()" id="psd_parentUpdatebutton" data-options="iconCls:\'icon-save\'" >排产</a></td>');
//                                $.parser.parse($("#psd_GoDivDiv"));
                                jQuery.ajax({
                                    type: "POST",   //post提交方式默认是get
                                    url: "${ctxPath }/PlanScheduling/selectmaoliaoLocation.action",
                                    dataType: "json",
                                    data: {
                                        fno: row.fno,
                                    },
                                    error: function (request) {      // 设置表单提交出错
                                        $.messager.progress('close');
                                        $.messager.alert('信息提示', '出错了！', 'info');
                                    },
                                    success: function (data) {
                                        $('#psd_location').combobox('loadData', data);
                                        $('#psd_location').combobox({
                                            onChange:function(){
                                                $("#psd_BatchNo").textbox('setValue',$('#psd_location').combobox("getValue"));
                                            }
                                        })
                                    }
                                });
                            },
                            buttons:[
                                {
                                    text:'排产',
                                    iconCls:"icon-save",
                                    handler:function(){
                                        var BatchNo = $('#psd_BatchNo').val();
                                        var planstartdate = $('#psd_planstartdate').val();
                                        if(BatchNo ==="" ||BatchNo ===null){
                                            $.messager.alert('信息提示', '排产库位不能为空！');
                                        }else if(planstartdate===""||planstartdate===null){
                                            $.messager.alert('信息提示', '计划开始时间为必填项！');
                                        }else{
                                            psd_parentlistUpdate();
                                        }

                                    }
                                },
                                {
                                    text:'取消',
                                    iconCls:"icon-save",
                                    handler:function(){
                                        parent.$.modalDialog.handler.dialog('close');
                                    }
                                }
                            ]
                        })
//                        $('#psd_GoDiv').append('<label><span>库位选择</span>：</label><select class="easyui-combobox" name="location" datatype="text" id="psd_location" panelHeight="auto" data-options="valueField:\'batchno\',textField:\'location\',required:\'true\'" style="width:100px"><label>炉批号：</label><input id="psd_BatchNo" name="BatchNo" class="easyui-textbox" style="width:100px" disabled=true>');
//                        $('#psd_GoDiv').append('<table class="easyui-datagrid" title="Basic DataGrid" id="psd_Datagrid" style="width:450px;height:250px" data-options="singleSelect:true,onClickRow:psd_fromOnClickRow,collapsible:true,method:\'post\'"><thead><tr><th data-options="field:\'fno\',width:80">物料编码</th><th data-options="field:\'fname\',width:80">物料描述</th><th data-options="field:\'takenum\',width:100,editor:{type:\'text\',options:{required:\'true\'}}">排产条数（条）</th><th data-options="field:\'planweidgt\',width:80,align:\'right\'">计划重量</th><th data-options="field:\'leavenum\',width:80,align:\'right\'">剩余重量</th></tr></thead></table>');
//                        $.parser.parse($("#psd_GoDiv"));
//                        for(var i = 0;i<results.rows.length;i++){
////                        $("#psd_GoTd").append('<tr><td><span>'+results.rows[i].fno+'</span>:<input class="easyui-textbox" type="text" name="'+results.rows[i].fno+'"   style="width:70px" data-options="required:true"/><span>计划余量：'+results.rows[i].plannum+'</spam></td></tr>');
////                        $.parser.parse($("#psd_GoTd"));
//                            $('#psd_Datagrid').datagrid('appendRow',{fno:results.rows[i].fno,fname:results.rows[i].fname,takenum:0,planweidgt:results.rows[i].planweidgt,leavenum:Number(results.rows[i].planweidgt)-Number(results.rows[i].takeweidgt)});
////                        editIndex = $('#psd_Datagrid').datagrid('getRows').length-1;
////                        $('#psd_Datagrid')
////                            .datagrid('beginEdit', editIndex);
//                        }
//                        $('#psd_GoDiv').append('<td width="260px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="psd_parentlistUpdate()" id="psd_parentUpdatebutton" data-options="iconCls:\'icon-save\'" >排产</a></td>');
//                        $.parser.parse($("#psd_GoDiv"));
//                        jQuery.ajax({
//                            type: "POST",   //post提交方式默认是get
//                            url: "/PlanScheduling/selectmaoliaoLocation.action",
//                            dataType: "json",
//                            data: {
//                                fno: row.fno,
//                            },
//                            error: function (request) {      // 设置表单提交出错
//                                $.messager.progress('close');
//                                $.messager.alert('信息提示', '出错了！', 'info');
//                            },
//                            success: function (data) {
//                                $('#psd_location').combobox('loadData', data);
//                                $('#psd_location').combobox({
//                                    onChange:function(){
//                                        $("#psd_BatchNo").textbox('setValue',$('#psd_location').combobox("getValue"));
//                                    }
//                                })
//                            }
//                        });
//                        $('#psd_GoDiv').dialog('open');

                    }
                })
            }else{
                $.messager.alert('信息提示', '此计划已完成排产！');
            }
        }
    }

    /**
     * Name 退回按钮
     */
    function psd_Back() {
        var row  = $("#psd_dailyplan").datagrid("getSelected");
        if(row ===null){
            $.messager.alert('信息提示', '请选择有效行项目！');
        }else{
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: "${ctxPath }/PlanScheduling/selectcoldCutByReelnum.action",
                dataType: "json",
                data: {
                    reelnum: row.reelnum
                },
                error: function (request) {      // 设置表单提交出错
                    $.messager.progress('close');
                    $.messager.alert('信息提示', '出错了！', 'info');
                },
                success: function (results) {
                    if(results.num>0){
                        $.messager.confirm('温馨提示', '此炉批号已经进行实物排产，你确定要退回吗?', function (r) {
                            if (r) {
                                jQuery.ajax({
                                    type: "POST",   //post提交方式默认是get
                                    url: "${ctxPath }/PlanScheduling/deleteDailyPlan.action",
                                    dataType: "json",
                                    data: {
                                        id: row.id,
                                        fno:row.fno,
                                        year:row.year,
                                        month:row.month,
                                        fnofather:row.fnofather,
                                        plant:row.plant,
                                        fid:row.fid,
                                        fparentidandnum:row.fparentidandnum,
                                        reelnum:row.reelnum
                                    },
                                    error: function (request) {      // 设置表单提交出错
                                        $.messager.progress('close');
                                        $.messager.alert('信息提示', '出错了！', 'info');
                                    },
                                    success: function (results) {
                                        if(results.num>0){
                                            $.messager.alert('信息提示', '删除成功！！！');
                                            psd_getDailyPlan();
                                            psd_getMplan();
                                        }else{
                                            $.messager.alert('信息提示', '删除失败！！！');
                                        }
                                    }
                                })
                            }
                        })
                    }else{
                        $.messager.confirm('温馨提示', '你确定要退回吗?', function (r) {
                            if (r) {
                                jQuery.ajax({
                                    type: "POST",   //post提交方式默认是get
                                    url: "${ctxPath }/PlanScheduling/deleteDailyPlan.action",
                                    dataType: "json",
                                    data: {
                                        id: row.id,
                                        fno:row.fno,
                                        year:row.year,
                                        month:row.month,
                                        fnofather:row.fnofather,
                                        plant:row.plant,
                                        fid:row.fid,
                                        fparentidandnum:row.fparentidandnum,
                                        reelnum:row.reelnum
                                    },
                                    error: function (request) {      // 设置表单提交出错
                                        $.messager.progress('close');
                                        $.messager.alert('信息提示', '出错了！', 'info');
                                    },
                                    success: function (results) {
                                        if(results.num>0){
                                            $.messager.alert('信息提示', '删除成功！！！');
                                            psd_getDailyPlan();
                                            psd_getMplan();
                                        }else{
                                            $.messager.alert('信息提示', '删除失败！！！');
                                        }
                                    }
                                })
                            }
                        })
                    }
                }
            });

        }
    }
    function psd_onClose() {
        $('#psd_GoDiv').empty();//销毁
    }
    /**
     * Name 搜索按钮事件
     */
    function psd_forGetDate() {
        var state = $('input[name="MDMKCardCheck"]:checked').val();
        psd_getMplan(state);
        psd_getDailyPlan();
    }
    function psd_parentlistUpdate() {
        var err = "";
        $('#psd_Datagrid').datagrid('endEdit', fromIndex);
        var row  = $("#psd_yd").datagrid("getSelected");
        var rows = $('#psd_Datagrid').datagrid('getRows');

        var entities = "";
        for(i = 0;i < rows.length;i++)
        {
            if (Number(rows[i].leavenum)<Number(rows[i].takenum)){
                var m = i+1;
                err = err +"第"+m+"行，排产数量大于剩余数量"
            }else{
                entities = entities  + JSON.stringify(rows[i]);
            }
        }
        if (err!==""){
            $.messager.alert('信息提示',err);
        }else{
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url: "${ctxPath }/PlanScheduling/insertFrom.action",
                dataType: "json",
                data: {
                    entities: entities,
                    username:localStorage.getItem("User"),
                    fnofather:row.fno,
                    fnamefather:row.fname,
                    yearfather:row.year,
                    monthfather:row.month,
                    plantfather:row.plant,
                    fid:row.id,
                    planstartdate:$("#psd_planstartdate").val(),
                    fparentlocation:$("#psd_location").combobox("getText"),
                    reelnum:$("#psd_location").combobox("getValue")
                },
                error: function (request) {      // 设置表单提交出错
                    $.messager.progress('close');
                    $.messager.alert('信息提示', '出错了！', 'info');
                },
                success: function (results) {
                    $.messager.alert('信息提示', '成功排产：'+results.isOk+'条，失败：'+results.isNo+'条');
                    psd_getDailyPlan();
                    psd_getMplan();
                    jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "${ctxPath }/PlanScheduling/selectmaoliaoLocation.action",
                        dataType: "json",
                        data: {
                            fno: row.fno,
                        },
                        error: function (request) {      // 设置表单提交出错
                            $.messager.progress('close');
                            $.messager.alert('信息提示', '出错了！', 'info');
                        },
                        success: function (data) {
                            $('#psd_location').combobox('loadData', data);
                            $('#psd_location').combobox({
                                onChange:function(){
                                    $("#psd_BatchNo").textbox('setValue',$('#psd_location').combobox("getValue"));
                                }
                            })
                        }
                    });


                    $('#psd_GoDiv').dialog('close');
                }
            })
        }
    }
    /**
     * Name 获取开卡数据表
     */
    var SBdata;
    function psd_getDailyPlan() {
        $('#psd_dailyplan').datagrid('loadData', { total: 0, rows: [] });
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/PlanScheduling/selectDailyPlan.action",//要发送的后台地址
            data: {
                takeman:localStorage.getItem('User')
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $("#psd_dailyplan").datagrid({
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    loadFilter:psd_pagerFilter,
                    //fitColumns:true,
                    //fit:true,
                    method:'post',
                    data:data,
                    columns:[[
                        {field:'id',title:'序号',width:35},
                        {field:'serialno',title:'编号',editor:'text',width:100},
                        {field:'fno',title:'物料编码',width:100, sortable: true},


                        {field:'fname',title:'物料描述',width:300},
                        {field:'fweight',title:'重量',width:100},
                        {field:'fnofather',title:'毛料物料编码',width:100, sortable: true},

                        {field:'fnamefather',title:'毛料物料描述',width:100, sortable: true},
                        {field:'reelnum',title:'卷号',width:100, sortable: true},
                        {field:'plant',title:'事业部',width:100, sortable: true},
                        {field:'takeman',title:'排产人员',width:100},
                        {field:'takedate',title:'排产时间',width:100},
                        {field:'year',title:'年份',width:100},
                        {field:'month',title:'月份',width:100},
                        {field:'fid',title:'上级编号',width:100},
                        {field:'fparentidandnum',title:'上级二级编号',width:100},
                        {field:'isdelete',title:'删除标识',width:100},
                        {field:'fparentlocaton',title:'上级物料库位',width:100},
                        {field:'planstartdate',title:'计划开始时间',width:100},
                        {field:'materialtype',title:'材料分类',width:100},
                        {field:'steelworks',title:'钢厂',width:100},
                        {field:'fnoname',title:'名称',width:100}


                    ]],
                    pageList: [25, 50,100,10000],
                    sortOrder:'asc',
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
    function psd_getMplan() {
        $('#psd_yd').datagrid('loadData', { total: 0, rows: [] });
        $('#psd_ydmx').treegrid('loadData', { total: 0, rows: [] });
        var planyear = $("#psd_dbk").val().substring(0,4);
        var planmonth = $("#psd_dbk").val().substring(5,7);
        $.messager.progress({
            title: '请稍后',
            msg: '页面加载中...'
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "${ctxPath }/PlanScheduling/selectOnlyParent.action",
            dataType: "json",
            data: {
                fno:$("#psd_fno").val(),
                fname:$("#psd_fname").val(),
                year:planyear,
                month:planmonth
            },
            error: function (request) {      // 设置表单提交出错
                $.messager.progress('close');
                $.messager.alert('信息提示', '出错了！', 'info');
            },
            success: function (results) {
                $.messager.progress('close');
                console.log(results);
                $('#psd_yd').datagrid({

                    data: results,
//                    nowrap:false,
                    autoRowWidth: true,
                    showFooter: true,
                    loadMsg: '正在加载中，请稍等... ',
                    singleSelect: true,
                    remoteSort: false,
                    method: 'post',
                    columns: [[
                        {
                            field: 'id',
                            title: '编号',
                            width: '35px',
                            editor: 'text',
                            sortable: true,
                            remoteSort: false
                        },
                        {field: 'fno', title: '物料编码', width: '100px', editor: 'text'},
                        {field: 'fname', title: '物料描述', width: '300px', editor: 'text'},
                        {
                            field: 'takeweidgt',
                            title: '已排数量',
                            width: '50px',
                            editor: 'text'
                        },
                        {
                            field: 'planweidgt',
                            title: '计划重量',
                            width: '100px',
                            editor: 'text',
                            sortable: true,
                            remoteSort: false
                        },
                        {field: 'planman', title: '计划人员', width: '50px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'plandate', title: '计划时间', width: '140px', editor: 'text'},
                        {field: 'progress', title: '完成进度', width: '210px',formatter:Progress,style:'50%'}
                        ,
                        {field: 'year', title: '年份', width: '50px', editor: 'text'},
                        {field: 'month', title: '月份', width: '50px'},
                        {field: 'plant', title: '事业部', width: '50px'},
                        {field: 'fparentid', title: '上级物料', width: '150px'},
                        {field: 'isdelete', title: '删除标识', width: '250px', editor: 'text'}
                    ]],

                    pagination: true,
                    pageList: [25, 50, 100],
                    sortOrder: 'asc'
                });
                $('#psd_yd').datagrid({
                    rowStyler: function (index, row) {
                        var planweidgt =parseFloat(row.planweidgt);
                        var takeweidgt =parseFloat(row.takeweidgt);
                        //alert(11);
                        if (takeweidgt < planweidgt) {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
                        }

                    }
                });
                $('#psd_yd').datagrid("selectRow", ydIndex);
            }
        });

    }

    function Progress(value){
        if (value){
            var Pcolor="#FF0000";
            if(Number(value)>50&&Number(value)<100){
                Pcolor="#EEB422";
            }else if(Number(value)==100||Number(value)>100){
                Pcolor="#32CD32";
            }

            var s = '<div style="width:100%;border:1px solid #ccc" class="easyui-progressbar \n' +
                'progressbar">' +
                '<div style="width:' + value + '%;background:'+Pcolor+';color: #000000;">' + value + '%' + '</div>'
            '</div>';
            return s;
        } else {
            return '0';
        }
    }
    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var ydIndex = 0;
    function endEditing(){
        if (editIndex == undefined){return true}
        if ($('#kc').datagrid('validateRow', editIndex)){
            //alert(2222);
//            var editor = $('#kc').datagrid('getEditor',{index:editIndex,field:"itemno"});
//            var productname = $(editor.target).val();
//
//
//
//
//            $('#kc').datagrid('getRows')[editIndex]['productname'] = productname;
            $('#kc').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function psd_endEditing(){
        if (fromIndex == undefined){return true}
        if ($('#psd_Datagrid').datagrid('validateRow', fromIndex)){
            //alert(2222);
//            var editor = $('#kc').datagrid('getEditor',{index:editIndex,field:"itemno"});
//            var productname = $(editor.target).val();
//
//
//
//
//            $('#kc').datagrid('getRows')[editIndex]['productname'] = productname;
            $('#psd_Datagrid').datagrid('endEdit', fromIndex);
            fromIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function psd_OnClickRow(index){
        var row  = $("#psd_yd").datagrid("getSelected");
        var year = $('#psd_dbk').val().substr(0,4);
        var month = $('#psd_dbk').val().substr(5);
        rowindex = index;
        $.messager.progress({
            title: '请稍后',
            msg: '页面加载中...'
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "${ctxPath }/PlanScheduling/selectOnlyOneParentAndChilds.action",
            dataType: "json",
            data: {
                id:row.id,
                year:year,
                month:month
            },
            error: function (request) {      // 设置表单提交出错
                $.messager.progress('close');
                $.messager.alert('信息提示', '出错了！', 'info');
            },
            success: function (results) {
                $.messager.progress('close');
                console.log(results);
                $('#psd_ydmx').treegrid({

                    data: results,
//                    nowrap:false,
                    autoRowWidth: true,
                    showFooter: true,
                    loadMsg: '正在加载中，请稍等... ',
                    singleSelect: true,
                    remoteSort: false,
                    method: 'post',
                    columns: [[
                        {
                            field: 'id',
                            title: '编号',
                            width: '35px',
                            editor: 'text',
                            sortable: true,
                            remoteSort: false
                        },
                        {field: 'fno', title: '物料编码', width: '100px', editor: 'text'},
                        {field: 'fname', title: '物料描述', width: '300px', editor: 'text'},
                        {
                            field: 'takeweidgt',
                            title: '已排数量',
                            width: '50px',
                            editor: 'text'
                        },
                        {
                            field: 'planweidgt',
                            title: '计划重量',
                            width: '100px',
                            editor: 'text',
                            sortable: true,
                            remoteSort: false
                        },
                        {field: 'planman', title: '计划人员', width: '50px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'plandate', title: '计划时间', width: '140px', editor: 'text'},
                        {field: 'year', title: '年份', width: '50px', editor: 'text'},
                        {field: 'month', title: '月份', width: '50px'},
                        {field: 'fparentid', title: '上级物料', width: '150px'},
                        {field: 'fnoname', title: '名称', width: 100},
                        {field: 'isdelete', title: '删除标识',hidden:true, width: '250px', editor: 'text'}
                    ]],
                    rowStyler:function(row){
                        var fparentid =row.fparentid;
                        if( fparentid === null ){
                            return 'background-color:#A4D3EE;font-weight:bold;';
                        }
                    },
                    pagination: true,
                    pageList: [25, 50, 100],
                    sortOrder: 'asc'
                });
                $('#psd_ydmx').datagrid({
                    rowStyler: function (index, row) {
                        var plannum =parseFloat(row.plannum);
                        var takenum =parseFloat(row.takenum);
                        //alert(11);
                        if (takenum < plannum) {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
                        }

                    }
                });
            }
        });
            ydIndex  =index;

    }
    function psd_OnClickRow2(index){
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
    var fromIndex = undefined;
    function psd_fromOnClickRow(index) {
            if (psd_endEditing()){
                $('#psd_Datagrid').datagrid('selectRow', index)
                    .datagrid('beginEdit', index);
                fromIndex = index;
            } else {
                $('#psd_Datagrid').datagrid('selectRow', index);
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





    function psd_pagerFilter(data){
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
