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
        <div class="easyui-panel " title="串装入库" data-options="fit:true">
            <div id="itc_toolbar"  style="overflow:auto;width:100%;height: 78px;">
                <div class="wu-toolbar-button" >
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="itc_Yexport()" plain="true">原材料库存导出</a>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="itc_Cexport()" plain="true">成品库存导出</a>
                </div>
                <div class="wu-toolbar-search" >

                    <div style="white-space:nowrap">
                        <label>事业部：</label>
                        <select class="easyui-combobox" name="Plant" datatype="text" id="itc_Plant" panelHeight="auto" data-options="
                            valueField:'Fremark',
                            textField:'Fname',
                            panelHeight:'250'"
                                style="width:100px">
                        </select>&nbsp
                        <label>物料编码：</label><input id="itc_fno" class="easyui-textbox" style="width:100px" onkeypress="itc_getKey()">&nbsp
                        <label>物料描述：</label><input id="itc_fname" class="easyui-textbox" style="width:100px" onkeypress="itc_getKey()">&nbsp
                        <input type="checkbox" id="itce_bzflag" name="itc_bzflag" checked="1" value="3"/>&nbsp <label>排除零库存</label>
                        <label class="labelstyle"><input type="radio" name="itc_allStore" value="3" />全部查询</label>
                        <label class="labelstyle"><input type="radio" name="itc_allStore" value="1" />原材料库存</label>
                        <label class="labelstyle"><input type="radio" name="itc_allStore" value="2" />成品库存</label>
                        <%--<a href="#" class="easyui-splitbutton" menu="#itc_mm" iconCls="icon-search">查询</a>--%>
                        <a href="#" class="easyui-linkbutton" id="aaa"  onclick="itc_forGetDate()" data-options="iconCls:'icon-search'">库存查询查询</a>
                        <%--<a href="#" class="easyui-linkbutton"  onclick="itc_forGetSumDate()" data-options="iconCls:'icon-search'">入库汇总查询</a>--%>
                        <a href="#" class="easyui-linkbutton"  onclick="itc_showMore()" data-options="iconCls:'icon-search'">更多</a>

                    </div>
                    <%--<div id="itc_mm" style="width:150px;">--%>
                    <%--<div iconCls="icon-search" onclick="itc_forGetDate()">串装入库查询</div>--%>
                    <%--<div iconCls="icon-search">入库汇总查询</div>--%>
                    <%--</div>--%>
                    <div class = "divmore" style="position: absolute;z-index:1001;background-color: white" id="itc_More">

                    </div>
                    <!--class="easyui-datebox"-->

                    <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>-->
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div id="itc_dd" class="easyui-layout cz"  data-options="fit:true">
                    <div style="width: 50%;height:100%" data-options="region:'west'">

                        <table id="itc_dgm" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="库存管理" data-options="singleSelect:true,onClickRow:itc_onClickRow"></table>
                    </div>
                    <div style="width:50%;height:100%"  data-options="region:'east',split:false" class="easyui-panel"   >
                        <table id="itc_dgmmx" class="easyui-datagrid" title="库位库存" style="white-space: nowrap;height: 100%" data-options="singleSelect:true"></table>

                    </div>
                </div>
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
        $('#itc_db1').val(year+"-"+month+"-01");
        //$('#itc_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
        $('#itc_db2').val(year+"-"+month+"-"+day);
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
                $('#itc_Plant').combobox('loadData', data);
                //alert(11111);

            }
        });
        $("#itc_Plant").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var plant = $(this).combobox('getText');
                //alert(plant);
                //ajax异步提交
                if(plant!==null){
                    $('#itc_KCardMan').combobox('clear');
                    $('#itc_CZMan').combobox('clear');
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
                            $('#itc_KCardMan').combobox('loadData', data);

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
                            $('#itc_CZMan').combobox('loadData', data);

                        }
                    });
                }

            }
        })
        $("input[name='itc_allStore']").eq(0).attr("checked","checked");
        $("#itc_More").hide();
        $("#itc_toolbar").click(function(event){
            event=event||window.event;
            event.stopPropagation();
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#itc_More").hide();

        });
        SelectState = 1;

//        $("#itc_toolbar").blur(function(){
//            $("#itc_More").toggle();
//        })
    });

    function itc_Yexport() {
        var url = "${ctxPath }/Inventory/itcexport.action?SelectState=1";
        window.location.href = url;
    }

    function itc_Cexport() {
        var url = "${ctxPath }/Inventory/itcexport.action?SelectState=2";
        window.location.href = url;
    }

    function itc_getKey() {
        if(event.keyCode==13){
            itc_forGetDate();
        }
    }
    function itc_showMore() {
        $("#itc_More").toggle();
    }

    function itc_forGetDate(){
        var a = null;
        SelectState = 0;
        var b = null;

        var type = $('input[name="itc_bzflag"]:checked').val();
        var state = $('input[name="itc_allStore"]:checked').val();
        //alert(type);

        itc_getInventory(type,state);
    }
    function itc_getInventory(type,state) {
            $('#itc_dgm').datagrid('loadData', {total: 0, rows: []});
            var fname = $('#itc_fname').val();
            var fno = $('#itc_fno').val();
            var plant = $('#itc_Plant').combobox("getText");
            $.messager.progress({
                title: '请稍等',
                msg: '页面加载中...'
            });
            jQuery.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${ctxPath }/Inventory/selectColdStore.action",//要发送的后台地址
                data: {
                    username: localStorage.getItem("User"),
                    plant:plant,
                    fname: fname,
                    fno: fno,
                    sapstore:type,
                    state:state
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    $.messager.progress('close');
                    console.log(data);
                    $("#itc_dgm").datagrid({
                        idField: 'id',
                        rownumbers: true,
                        singleSelect: true,
                        pagination: true,
                        multiSort: true,
                        showFooter: true,
                        //fitColumns:true,
                        //fit:true,
                        remoteSort: false,
                        loadFilter: itc_pagerFilter,
                        method: 'post',
                        loadMsg: "正在加载数据.....",
                        data: data,
                        //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                        columns: [[
                            {field: 'id', title: '序号', width: 50, sortable: true},
                            {field: 'fno', title: '物料编码', width: 100, sortable: true},
                            {field: 'fname', title: '物料描述', width: 250, sortable: true},
                            {field: 'sapstore', title: '现库存',  width: 100},
                            {field: 'beginstore', title: '开始库存',  width: 60, sortable: true},

                            {field: 'inputstore', title: '接收库存', width: 70, sortable: true},

                            {field: 'outputstore', title: '发出库存', width: 60, sortable: true},


                            {field: 'inputman', title: '初始入库人',hidden:true, width: 100},
                            {field: 'inputdate', title: '初始入库时间', hidden:true, width: 150, sortable: true},
                            {field: 'plant', title: '事业部', width: 150, sortable: true},

                            {field: 'beginman', title: '库存开始人', width: 100,hidden:true,  sortable: true},
                            {field: 'begindate', title: '库存开始时间', width: 100,hidden:true,  sortable: true},

                        ]],
//                    pagination:true,
                        pageList: [25, 50, 100],
                        sortOrder: 'asc'
                    });
//                    $('#itc_dgm').datagrid({
//                        rowStyler: function (index, row) {
//                            var issure = row.issure;
//                            var IsTake = row.IsTake;
//                            //alert(11);
//                            if (issure !== '1') {
//                                return 'color:black;';
//                            }
//                            else if (IsTake !== '1' && issure === '1') {
//                                return 'color:Green;font-weight:bold;';
//                            }
//                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
//                        }
//                    });

                    return true;
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    return false;
                }
            });
    }
    var editIndex = undefined;
    function itc_onClickRow(index){
            $('#itc_dgmmx').datagrid('loadData', {total: 0, rows: []});
            var row = $("#itc_dgm").datagrid("getSelected");
            $.ajax({
                type: "post",
                url: "${ctxPath }/Inventory/selectColdStoreLocation.action",
                data: {
                    fno: row.fno,
                    plant: row.plant,
                    fname: row.fname,
                    leaveNumber:$('input[name="itc_bzflag"]:checked').val()
                },
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    console.log(data);
                    $("#itc_dgmmx").datagrid({
                        rownumbers: true,
                        singleSelect: true,
                        pagination: true,
                        multiSort: true,
                        showFooter: true,
                        //fitColumns:true,
                        //fit:true,
                        remoteSort: false,
                        loadFilter: itc_pagerFilter,
                        method: 'post',
                        loadMsg: "正在加载数据.....",
                        data: data,
                        //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                        columns: [[
                            {field: 'fno', title: '物料编码', width: 100, sortable: true},
                            {field: 'leavenumber', title: '库位库存', width: 100, sortable: true},
                            {field: 'location', title: '库位', editor: 'text', width: 60, sortable: true},

                            {field: 'plant', title: '事业部', width: 70, sortable: true},

                            {field: 'fname', title: '物料描述', width: 300, sortable: true},
                            {field: 'sapstore', title: '现库存', editor: 'text', width: 100}

                        ]],
//                    pagination:true,
                        pageList: [25, 50, 100],
                        sortOrder: 'asc'
                    });
                }
            });
            editIndex = index;
    }
    function itc_pagerFilter(data){
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
    function itc_Print() {
        if(SelectState ===1){
            $.messager.alert('温馨提示', '请先进行串装入库查询!');
        }else {
            var row = $("#itc_dgm").datagrid("getSelected");
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
