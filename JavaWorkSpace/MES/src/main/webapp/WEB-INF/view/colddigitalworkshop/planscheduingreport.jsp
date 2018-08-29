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
        <%--<iframe id="proxy2" style="display:none"></iframe>--%>
        <div class="easyui-panel " title="排产报表" data-options="fit:true">
            <div id="psr_toolbar"  style="overflow:auto;width:100%;height: 78px;">
                <div class="wu-toolbar-button" >
                    <shiro:hasPermission name="/psr/delete">
                        <a href="#" class="easyui-linkbutton"  onclick="psr_delete()" data-options="iconCls:'icon-delete'" plain="true">删除计划</a>
                    </shiro:hasPermission>
                    <span>丨</span>
                    <%--<shiro:hasPermission name="/psr/Print">--%>
                    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="psr_Print()" plain="true">补卡打印</a>--%>
                    <%--</shiro:hasPermission>--%>

                </div>
                <div class="wu-toolbar-search" >

                    <div style="white-space:nowrap">
                        <label>起始时间：</label><input  id ="psr_db1" style="width:110px" class="easyui-datebox">&nbsp
                        <label>结束时间：</label><input  id ="psr_db2" style="width:110px" class="easyui-datebox">&nbsp
                        <input type="checkbox" id="mti_bzflag" name="psr_bzflag"  value="3"/>&nbsp <label>计划开始日期</label>
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="psr_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>炉批号：</label><input id="psr_reelnums" class="easyui-textbox" style="width:100px">&nbsp
                        <a href="#" class="easyui-linkbutton" id = "aaa" onclick="psr_forGetDate()" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" class="easyui-linkbutton"  onclick="psr_showMore()" data-options="iconCls:'icon-search'">更多</a>

                    </div>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white" id="psr_More">
                    </div>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div id="psr_dd" class="easyui-layout cz"  data-options="fit:true">
                    <div style="width: 100%;height:75%" data-options="region:'center'">
                        <table id="psr_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="排产报表" data-options="singleSelect:true,onClickRow:psr_onClickRow"></table>
                    </div>
                </div>
            </div>
            <div id="psr_updateDiv" class="easyui-dialog" title="分剪修改" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:460px;height:250px;padding:10px">
                <from id="psr_updatefrom">
                    <table cellpadding="5" width="auto" style="white-space:nowrap" >
                        <td>
                            <tr>
                                <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="psr_updatefno"  style="width:350px" disabled=true"></input></td>
                            </tr>
                            <tr>
                                <td>物料描述:<input class="easyui-textbox" type="text" name="name" id="psr_updatename" style="width:350px"disabled=true"></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">原重量</span>:<input class="easyui-textbox" type="text" name="weightold" id="psr_updateweightold"  style="width:350px" disabled=true"></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">新重量</span>:<input class="easyui-textbox" type="number" name="weightnew" id="psr_updateweightnew" style="width:350px" data-options="required:'true'"></input></td>
                            </tr>
                            <input class="easyui-textbox" type="hidden" name="id" id="psr_updateid"  />
                            <tr >
                                <td width="260px"><a class="easyui-linkbutton" type="text" style="width: 280px" name="Save" onclick="psr_updateSave()" id="spm_parentAddbutton" data-options="iconCls:'icon-save'" >保存</a></td>
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
    var temID="";
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#psr_db1').val(year+"-"+month+"-"+day);
        //$('#psr_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#psr_db2').val(year+"-"+month+"-"+day);
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
                $('#psr_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#psr_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#psr_KCardMan').combobox('clear');
                    $('#psr_CZMan').combobox('clear');
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
                            $('#psr_KCardMan').combobox('loadData', data);

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
                            $('#psr_CZMan').combobox('loadData', data);

                        }
                    });
                }

            }
        })
//        $("input[name='MDMCZRkuCheck']").eq(0).attr("checked","checked");
        $("#psr_More").hide();
        $("#psr_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#psr_More").hide();

        });
        SelectState = 1;

//        $("#psr_toolbar").blur(function(){
//            $("#psr_More").toggle();
//        })
    });
    function psr_showMore() {
        $("#psr_More").toggle();
    }

    function psr_forGetDate(){
        var a = null;
        SelectState = 0;
        var b = null;

        var type = $('input[name="psr_bzflag"]:checked').val();
        //alert(type);
        psr_getDailyPrint(type);
        SelectState = 1;
    }
    function psr_getDailyPrint(type) {
        $('#psr_dgm').datagrid('loadData', {total: 0, rows: []});
        var startTime = $('#psr_db1').val();
        var endTime = $('#psr_db2').val() + " 23:59:59";
        var reelnums = $('#psr_reelnums').val();
        $.messager.progress({
            title: '请稍等',
            msg: '页面加载中...'
        });
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/PlanScheduling/selectDailyPlanReport.action",//要发送的后台地址
            data: {
                startTime:startTime,
                endTime:endTime,
                reelnums:reelnums,
                type:type
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                $("#psr_dgm").datagrid({
                    idField: 'id',
                    rownumbers: true,
                    pagination: true,
                    multiSort: true,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    singleSelect: false, //允许选择多行
                    remoteSort: false,
                    loadMsg: "正在加载数据.....",
                    data: data,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns: [[
                        {field:'ck', checkbox: true, width: '30' },  //复选框
                        {field:'id',title:'序号',width:50},
                        {field:'serialno',title:'编号',editor:'text',width:100},
                        {field:'fno',title:'物料编码',width:100, sortable: true},


                        {field:'fname',title:'物料描述',width:200},
                        {field:'fnofather',title:'毛料物料编码',width:100, sortable: true},

                        {field:'fnamefather',title:'毛料物料描述',width:200, sortable: true},
                        {field:'reelnum',title:'炉批号',width:100, sortable: true},

                        {field:'takeman',title:'排产人员',width:100},
                        {field:'takedate',title:'排产时间',width:150},
                        {field:'planstartdate',title:'计划开始时间',width:150},
                        {field:'year',title:'年份',width:100},
                        {field:'month',title:'月份',width:100},
                        {field:'fid',title:'上级编号',width:100},
                        {field:'fparentidandnum',title:'上级二级编号',width:100},
                        {field:'isdelete',title:'删除标识',hidden:true,width:100},
                        {field:'plant',title:'事业部',width:100, sortable: true},
                        {field:'fparentlocaton',title:'上级物料库位',width:100},
                        {field:'steelworks',title:'钢厂',width:100},
                        {field:'materialtype',title:'材料分类',width:100}


                    ]],
//                    pagination:true,
//                        pageList: [25, 50, 100],
                    sortOrder: 'asc'
                });
                $('#psr_dgm').datagrid({
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
//                    $('#psr_dgm').datagrid({loadFilter: psr_pagerFilter}).datagrid('loadData', data);

                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                return false;
            }
        });
    }

    function psr_delete() {
        var selRow = $('#psr_dgm').datagrid('getSelections');
        var reelnum = "";
        if(selRow.length ==0){
                $.messager.alert('信息提示', '请选择有效行项目！');
            }else{
                //批量获取选中行的ID和炉批号
            for (var i = 0; i < selRow.length;i++) {
                if (temID =="") {
                    temID = selRow[i].id;
                    reelnum = selRow[i].reelnum;
                } else {
                    temID = selRow[i].id + "," + temID;
                    reelnum = selRow[i].reelnum + "," + reelnum;
                }
            }

            $.messager.confirm('提示', '是否删除选中数据?', function (r) {

                if (!r) {
                    return;
                }
                jQuery.ajax({
                        type: "POST",   //post提交方式默认是get
                        url: "${ctxPath }/PlanScheduling/selectcoldCutByReelnum.action",
                        dataType: "json",
                        data: {
                            reelnum: reelnum
                        },
                        error: function (request) {      // 设置表单提交出错
                            $.messager.progress('close');
                            $.messager.alert('信息提示', '出错了！', 'info');
                        },
                        success: function (results) {
                            if (results.num > 0) {
                                $.messager.confirm('温馨提示', '此炉批号已经进行实物排产，你确定要退回吗?', function (r) {
                                    if (r) {
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: "${ctxPath }/PlanScheduling/deleteDailyPlan.action",
                                            dataType: "json",
                                            data: {
                                                id:temID,

                                            },
                                            error: function (request) {      // 设置表单提交出错
                                                $.messager.progress('close');
                                                $.messager.alert('信息提示', '出错了！', 'info');
                                            },
                                            success: function (results) {
                                                if (results.num > 0) {
                                                    $.messager.alert('信息提示', '删除成功！！！');
                                                    psr_forGetDate();
                                                } else {
                                                    $.messager.alert('信息提示', '删除失败！！！');
                                                }
                                            }
                                        })
                                    }
                                })
                            } else {
                                $.messager.confirm('温馨提示', '你确定要退回吗?', function (r) {
                                    if (r) {
                                        jQuery.ajax({
                                            type: "POST",   //post提交方式默认是get
                                            url: "${ctxPath }/PlanScheduling/deleteDailyPlan.action",
                                            dataType: "json",
                                            data: {
                                                id:temID,
                                            },
                                            error: function (request) {      // 设置表单提交出错
                                                $.messager.progress('close');
                                                $.messager.alert('信息提示', '出错了！', 'info');
                                            },
                                            success: function (results) {
                                                if (results.num > 0) {
                                                    $.messager.alert('信息提示', '删除成功！！！');
                                                    psr_forGetDate();
                                                } else {
                                                    $.messager.alert('信息提示', '删除失败！！！');
                                                }
                                            }
                                        })
                                    }
                                })
                            }
                        }
                    });



            })
            }
    }
    function psr_updateSave() {
        var row = $("#psr_dgm").datagrid("getSelected");
        var weightnew = $("#psr_updateweightnew").val();
        var id = $("#psr_updateid").val();
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
                        $('#psr_dgm').datagrid('refreshRow', editIndex);
                        $('#psr_updateDiv').dialog('close');
                        $.messager.alert('温馨提示', '修改成功！！！');
                    }else{
                        $.messager.alert('温馨提示', '修改失败！！！');
                    }
                }
            });

        }
    }
    var editIndex = undefined;
    function psr_onClickRow(index){


        editIndex = index;
    }
    function psr_pagerFilter(data){
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
    function psr_Print() {
        if(SelectState ===1){
            $.messager.alert('温馨提示', '请先进行串装入库查询!');
        }else {
            var row = $("#psr_dgm").datagrid("getSelected");
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