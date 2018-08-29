<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .datagrid-row-selected {
        background: #CAE1FF;
        color: black;
        font-weight:bold;
    }
    .A{
        width:30%;
        height:75%;
    }
    .B{
        width: 10%;
        height: 75%;
    }
    .C{
        width:70%;
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
        <div class="easyui-panel" data-options="fit:true">
            <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
                <div class="wu-toolbar-button">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="Print()" plain="true">打印</a>
                    <span>丨</span>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">导出</a>
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <table>
                        <tr>
                            <td><label>发运单号：</label><input id="packageOut_doxtbh" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <%--<td><label>起始要求发出日期：</label><input id="packageOut_startouttime"   class="easyui-datebox"   style="width:100px"></input>&nbsp</td>--%>
                            <%--<td><label>起始要求发出日期：</label><input id="packageOut_endouttime"   class="easyui-datebox"   style="width:100px"></input>&nbsp</td>--%>

                            <td> <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="ptquery()" data-options="iconCls:'icon-search'">查询</a></td>
                            <td> <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="ptoutgo()" data-options="iconCls:'icon-package-go'">发出</a></td>
                        </tr>

                    </table>
                </div>

            </div>

            <div class="easyui-layout haorooms"  style="width:100%;height:80%">
                <div class="A" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" >
                        <div style="width: 100%;height:53%" data-options="region:'center'">
                            <table id="packageOut_ptyd" class="easyui-datagrid" style="white-space: nowrap;height: 100%" title="成品出库" data-options="singleSelect:true,onClickRow:onClickRow"></table>
                        </div>
                    </div>
                </div>

                <%--<div class="B" data-options="region:'center',split:true">--%>
                    <%--&lt;%&ndash;<div style="height: 50%;"  >&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<button  onclick="ptoutgo()"  class="easyui-linkbutton" style="margin-top: 100px">发出>></button>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>

                <%--</div>--%>
                <div class="C"  data-options="region:'center',split:true">


                    <table class="easyui-datagrid" id="packageOut_pttakegrid" title="成品出库记录" style="white-space: nowrap;height: 100%" data-options="singleSelect:false,onClickRow:onClickRow2,editor:'text'" ></table>
                </div>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
    var editIndex;
    function getTime(/** timestamp=0 **/) {
        var ts = arguments[0] || 0;
        var t, y, m, d, h, i, s;
        t = ts ? new Date(ts * 1000) : new Date();
        y = t.getFullYear();
        m = t.getMonth() + 1;
        d = t.getDate();
        h = t.getHours();
        i = t.getMinutes();
        s = t.getSeconds();
        // 可根据需要在这里定义时间格式
        return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
    }
    $("#packageOut_ptyd").datagrid({
//                    rownumbers:true,
        fit: false, //自动适屏功能
        autoRowWidth: true,
        showFooter: true,
        loadMsg: '正在加载中，请稍等... ',
        fitColumns:true,//宽度自适应
        singleSelect:true,
        remoteSort:false,
        width:'auto',
        method:'get',
        loadFilter:pagerFilter,
        id:'id',
        nowrap:false,
        columns:[[
            {field:'DOXTBH',title:'发运单号',width:'200px',editor:'text'},
            {field:'OutTime',title:'要求发出时间',width:'200px',editor:'text'},

        ]],
     ation:true,
//                    sortName:'id',
        sortName:'serialno',
//                    sortName:'f3',
        pageList: [25, 50,100],
        sortOrder:'asc'
    });


    $("#packageOut_pttakegrid").datagrid({

//                    rownumbers:true,
        fit: false, //自动适屏功能
        autoRowWidth: true,
        showFooter: true,
        loadMsg: '正在加载中，请稍等... ',
        fitColumns:true,//宽度自适应
        singleSelect:false,
        remoteSort:false,
        width:'auto',
        method:'get',
        loadFilter:pagerFilter,
        id:'id',
        frozenColumns:[[
            {field:'id',title:'ID',width:'50px',sortable: true,checkbox: true},
            {field:'PackageListID',title:'装箱单抬头ID',width:'150px',editor:'text'},
            {field:'serialno',title:'箱单号',width:'150px',editor:'text'},
            {field:'dhorderno',title:'SAP订单号',width:'60px',editor:'text'},
            {field:'Location',title:'成品库位',width:'60px',editor:'text'},

        ]],
        columns:[[
            {field:'DOXTBH',title:'发运单号',width:'60px',editor:'text'},
            {field:'DoNo',title:'交货单号',width:'200px'},
            {field:'DoItem',title:'交货单行',width:'200px'},
            {field:'IsSAP',title:'SAP移库',width:'200px'},
            {field:'MoveOK',title:'移库成功',width:'200px'},
            {field:'SAPMan',title:'移库人',width:'200px'},
            {field:'SAPDate',title:'移库时间',width:'200px'},
            {field:'IsOut',title:'已发出',width:'200px'},
            {field:'OutTime',title:'要求发出时间',width:'200px'},
        ]],
        pagination:true,
//                    sortName:'id',
        sortName:'serialno',
//                    sortName:'f3',
        pageList: [100, 300,500],
        sortOrder:'asc'
    });


    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }




    /**
     * Name 搜索按钮事件
     */

    function ptquery() {
//        $("#packageOut_ptyd").datagrid('loadData', { total: 0, rows: [] });
//        $.messager.progress({
//            title:'请稍后',
//            msg:'页面加载中...'
//        })
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/packageOutLeftquery.action",//要发送的后台地址
            data: {
                doxtbh:$('#packageOut_doxtbh').val(),
//                start:$('#packageOut_startouttime').val(),
//                end:$('#packageOut_endouttime').val(),

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packageOut_ptyd").datagrid({
//                    rownumbers:true,
                    data:data,
                    fit: false, //自动适屏功能
                    autoRowWidth: true,
                    showFooter: true,
                    loadMsg: '正在加载中，请稍等... ',
                    fitColumns:true,//宽度自适应
                    singleSelect:true,
                    remoteSort:false,
                    width:'auto',
                    method:'get',
                    loadFilter:pagerFilter,
                    id:'id',
                    nowrap:false,
                    columns:[[
                        {field:'doxtbh',title:'发运单号',width:'200px',editor:'text'},
                        {field:'OutTime',title:'要求发出时间',width:'200px',editor:'text',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        } },

                    ]],
                    ation:true,
//                    sortName:'id',
                    sortName:'serialno',
//                    sortName:'f3',
                    pageList: [25, 50,100],
                    sortOrder:'asc'
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
            }
        });

    }


    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var ydIndex = undefined;
    function endEditing(){
        if (editIndex == undefined){return true}

        else {
            return false;
        }
    }

    function onClickRow2(index){
        if (editIndex !== index){

            var data = $('#packageOut_pttakegrid').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#packageOut_pttakegrid').datagrid('selectRow', editIndex);
                }
            }
            editIndex = index;
        }
    }

    function packageOutRightquery( doxtbh){
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/packageOutRightquery.action",//要发送的后台地址
            data: {
                doxtbh:doxtbh

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
//                $.messager.progress('close');

                $("#packageOut_pttakegrid").datagrid({

//                    rownumbers:true,
                    data:data,
                    fit: false, //自动适屏功能
                    autoRowWidth: true,
                    showFooter: true,
                    loadMsg: '正在加载中，请稍等... ',
                    fitColumns:true,//宽度自适应
                    singleSelect:false,
                    remoteSort:false,
                    width:'auto',
                    method:'get',
                    loadFilter:pagerFilter,
                    id:'id',
                    frozenColumns:[[
                        {field:'id',title:'ID',width:'50px',sortable: true,checkbox: true},
                        {field:'packagelistid',title:'装箱单抬头ID',width:'150px',editor:'text'},
                        {field:'serialno',title:'箱单号',width:'150px',editor:'text'},
                        {field:'dhorderno',title:'SAP订单号',width:'60px',editor:'text'},
                        {field:'location',title:'成品库位',width:'60px',editor:'text'},

                    ]],
                    columns:[[
                        {field:'doxtbh',title:'发运单号',width:'60px',editor:'text'},
                        {field:'dono',title:'交货单号',width:'200px'},
                        {field:'doitem',title:'交货单行',width:'200px'},
                        {field:'issap',title:'SAP移库',width:'200px'},
                        {field:'moveok',title:'移库成功',width:'200px'},
                        {field:'sapman',title:'移库人',width:'200px'},
                        {field:'sapdate',title:'移库时间',width:'200px',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        }},
                        {field:'isout',title:'已发出',width:'200px'},
                        {field:'outtime',title:'要求发出时间',width:'200px',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        } },
                    ]],
                    pagination:true,
//                    sortName:'id',
                    sortName:'serialno',
//                    sortName:'f3',
                    pageList: [100, 300,500],
                    sortOrder:'asc'
                });

//                alert(editIndex);
                if(editIndex != 'undefined'){
                    $('#packageOut_pttakegrid').datagrid('selectRow',editIndex);
                }
                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
//                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
                return false;
            }
        });
    }
    function  onClickRow(){
        var row  = $('#packageOut_ptyd').treegrid("getSelected");
        indexrow = row;
        packageOutRightquery(row.doxtbh);
        <%--jQuery.ajax({--%>
            <%--type: "post",//数据发送的方式（post 或者 get）--%>
            <%--url: "${pageContext.request.contextPath}/PackageCheck/packageOutRightquery.action",//要发送的后台地址--%>
            <%--data: {--%>
                <%--doxtbh:row.doxtbh--%>

            <%--},//要发送的数据（参数）格式为{'val1':"1","val2":"2"}--%>
            <%--dataType: "json",//后台处理后返回的数据格式--%>
            <%--success: function (data) {//ajax请求成功后触发的方法--%>
                <%--console.log(data);--%>
                <%--$.messager.progress('close');--%>

                <%--$("#packageOut_pttakegrid").datagrid({--%>

<%--//                    rownumbers:true,--%>
                    <%--data:data,--%>
                    <%--fit: false, //自动适屏功能--%>
                    <%--autoRowWidth: true,--%>
                    <%--showFooter: true,--%>
                    <%--loadMsg: '正在加载中，请稍等... ',--%>
                    <%--fitColumns:true,//宽度自适应--%>
                    <%--singleSelect:false,--%>
                    <%--remoteSort:false,--%>
                    <%--width:'auto',--%>
                    <%--method:'get',--%>
                    <%--loadFilter:pagerFilter,--%>
                    <%--id:'id',--%>
                    <%--frozenColumns:[[--%>
                        <%--{field:'id',title:'ID',width:'50px',sortable: true,checkbox: true},--%>
                        <%--{field:'packagelistid',title:'装箱单抬头ID',width:'150px',editor:'text'},--%>
                        <%--{field:'serialno',title:'箱单号',width:'150px',editor:'text'},--%>
                        <%--{field:'dhorderno',title:'SAP订单号',width:'60px',editor:'text'},--%>
                        <%--{field:'location',title:'成品库位',width:'60px',editor:'text'},--%>

                    <%--]],--%>
                    <%--columns:[[--%>
                        <%--{field:'doxtbh',title:'发运单号',width:'60px',editor:'text'},--%>
                        <%--{field:'dono',title:'交货单号',width:'200px'},--%>
                        <%--{field:'doitem',title:'交货单行',width:'200px'},--%>
                        <%--{field:'issap',title:'SAP移库',width:'200px'},--%>
                        <%--{field:'moveok',title:'移库成功',width:'200px'},--%>
                        <%--{field:'sapman',title:'移库人',width:'200px'},--%>
                        <%--{field:'sapdate',title:'移库时间',width:'200px',formatter: function (date) {--%>
                            <%--return getTime((date.time+"").substring(0,10));--%>

                        <%--}},--%>
                        <%--{field:'isout',title:'已发出',width:'200px'},--%>
                        <%--{field:'outtime',title:'要求发出时间',width:'200px',formatter: function (date) {--%>
                            <%--return getTime((date.time+"").substring(0,10));--%>

                            <%--} },--%>
                    <%--]],--%>
                    <%--pagination:true,--%>
<%--//                    sortName:'id',--%>
                    <%--sortName:'serialno',--%>
<%--//                    sortName:'f3',--%>
                    <%--pageList: [100, 300,500],--%>
                    <%--sortOrder:'asc'--%>
                <%--});--%>

<%--//                alert(editIndex);--%>
                <%--if(editIndex != 'undefined'){--%>
                    <%--$('#packageOut_pttakegrid').datagrid('selectRow',editIndex);--%>
                <%--}--%>
                <%--return true;--%>
            <%--},--%>
            <%--error: function (msg) {//ajax请求失败后触发的方法--%>
                <%--$.messager.progress('close');--%>
                <%--$.messager.alert('提示',msg,'info');--%>
                <%--return false;--%>
            <%--}--%>
        <%--});--%>
    }
    function ptoutgo(){
        var row  = $('#packageOut_ptyd').treegrid("getSelected");
        var doxtbh = row.doxtbh;
        var ids = "";
        var rows  = $('#packageOut_pttakegrid').datagrid("getSelections");
        for(var i=0; i<rows.length; i++){
            ids = ids + rows[i].id+",";
        }
        $.messager.confirm('询问', '确定发出吗?', function(b) {
            if(b){
                jQuery.ajax({
                    type:"POST",   //post提交方式默认是get
                    url:"${pageContext.request.contextPath}/PackageCheck/ptoutgo",
                    dataType:"json",

                    data:{
                        ids:ids,
                    },
                    error:function(request) {
                        $.messager.alert('提示', '发出失败!');
                    },
                    success:function(results) {

                        if (results.succsess == true) {
                            $.messager.alert('提示', results.message);
                            ptquery();
                            packageOutRightquery(doxtbh);

                        }else{
                            $.messager.alert('提示', results.message);
                        }


                    }
                });
            }

        })
    }
    function Print() {
        var row = $("#packageOut_pttakegrid").datagrid("getSelected");
        if(row!==null){
            row.IsPrint = '1';
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "/KCard/updateDY.action",//要发送的后台地址
                data: {
                    id:row.id,
                    IsPrint:row.IsPrint
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                }
            });
            $('#packageOut_pttakegrid').datagrid('refreshRow', editIndex);
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
        else{
            $.messager.alert('温馨提示', '请选择有效行项目！！');
        }


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

    /**
     * Name 删除记录
     */
    function remove(){
        $.messager.confirm('信息提示','确定要删除该记录？', function(result){
            if(result){
                var items = $('#wu-datagrid').datagrid('getSelections');
                var ids = [];
                $(items).each(function(){
                    ids.push(this.productid);
                });
                //alert(ids);return;
                $.ajax({
                    url:'',
                    data:'',
                    success:function(data){
                        if(data){
                            $.messager.alert('信息提示','删除成功！','info');
                        }
                        else
                        {
                            $.messager.alert('信息提示','删除失败！','info');
                        }
                    }
                });
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
        var item = $('#wu-datagrid').datagrid('getSelected');
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
                    $('#wu-form').form('load', data)
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
