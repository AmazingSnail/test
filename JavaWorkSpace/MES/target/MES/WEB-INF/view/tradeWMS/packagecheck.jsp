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
        width:75%;
        height:75%;
    }
    .B{
        width: 10%;
        height: 75%;
    }
    .C{
        width:25%;
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
    <div id="rcmenu" class="easyui-menu" style="">
        <div iconCls="icon-ok" onclick="sendOk()">发送</div>
    </div>
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
                                <td><label>起始日期：</label></td>
                                <td>
                                    <input id="package_start"   class="easyui-datebox"   style="width:100px">
                                </td>
                                <td><label>厂编合同：</label></td>
                                <td>
                                    <input id="package_horderno" class="easyui-textbox"   style="width:100px">
                                </td>
                                <td><label>箱号：</label></td>
                                <td>
                                    <input id="package_boxnum" class="easyui-textbox"  style="width:100px">
                                </td>
                                <td>
                                    <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="packagecheckquery()" data-options="iconCls:'icon-search'">查询</a>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><label>结束日期：</label></td>
                                <td>
                                    <input id="package_end"   class="easyui-datebox"   style="width:100px">
                                </td>
                                <td><label>箱单号：</label></td>
                                <td>
                                    <input id="package_serialno" class="easyui-textbox"  style="width:100px">
                                </td>
                                <td><label>库位：</label></td>
                                <td >
                                    <input id="package_location" class="easyui-textbox"  style="width:100px">
                                </td>
                                <td></td>
                            </tr>
                        </table>
                </div>

            </div>

            <div class="easyui-layout haorooms" style="width:100%;height:85%" >
                <div class="A" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:70%">
                        <div style="width: 100%;height:53%" data-options="region:'center'">
                            <table id="packagecheck_ptyd" class="easyui-treegrid" style="white-space: nowrap;height: 100%" title="包装库存" data-options="singleSelect:true,idField: 'id',onClickRow:onClickRow,
                                    treeField: 'serialno',onContextMenu: onContextMenuxq,"></table>
                        </div>
                    </div>
                </div>

                <div class="C"  data-options="region:'center',split:true" >
                    <table  style="width:99%;height:100%" >
                        <tr style="height: 95%">
                            <td>
                                <table class="easyui-datagrid" id="packagecheck_pttakegrid" title="检验问题" style="white-space: nowrap;height: 100%" data-options="singleSelect:false,onClickRow:onClickRow2,editor:'text'" ></table>
                            </td>
                        </tr>
                        <tr>
                            <td style="float: right;">
                                    <div class="wu-toolbar-button">
                                        <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="checkdetailSubmit()" data-options="iconCls:'icon-search'">提交</a>
                                        <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="packagecheckquery()" data-options="iconCls:'icon-search'">重置</a>
                                    </div>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var serialno;
    var packhalfid;
    var indexrow;
   //$('#package_start').datebox('setValue', getCurentDateStr());
    // $('#planRunDt').datebox('calendar').calendar({
    //     validator : function(date){
    //         var now = new Date();
    //         var d1 = new Date(now.getFullYear(),now.getMonth(),now.getDate());
    //         return date <= d1;
    //     }
    // });

    function getCurentDateStr()
    {
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var clock = year + "-";
        if(month < 10) clock += "0";
        clock += month + "-";
        if(day < 10) clock += "0";
        clock += day;
        return clock;
    }
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
    var editIndex;
    //详情树网格右击事件
    function onContextMenuxq(e,row){
        e.preventDefault();
        $('#packagecheck_ptyd').treegrid('select', row.id);
        indexrow = row;
            $('#rcmenu').menu('show',{
            left: e.pageX,
            top: e.pageY
        });
    }
    function sendOk() {
        if(indexrow.boxnumfid!=0){
            $.messager.alert('信息提示', '请选择父节点！', 'info');
        }else{
            jQuery.ajax({
                type:"POST",   //post提交方式默认是get
                url:"${pageContext.request.contextPath}/PackageCheck/sendOk",
                dataType:"json",

                data:{
                    id:indexrow.id,
                    user: localStorage.getItem("User"),


                },
                error:function(request) {
                    $.messager.alert('提示', '提交问题失败!');
                },
                success:function(results) {

                    if (results.succsess == true) {
                        $.messager.alert('提示', results.message);

                    }else{
                        $.messager.alert('提示', results.message);
                    }


                }
            });
        }

    }
        $("#packagecheck_ptyd").treegrid({
        fit: false, //自动适屏功能
        autoRowWidth: true,
        showFooter: true,
        loadMsg: '正在加载中，请稍等... ',
        fitColumns:true,//宽度自适应
        singleSelect:true,
        remoteSort:false,
        width:'auto',
        method:'get',
        id:'id',
        nowrap:false,
        frozenColumns:[[
            {field:'id',title:'ID',width:'50px',sortable:true,remoteSort:false,hidden:true},
            {field:'serialno',title:'箱单号',width:'60px',editor:'text'},
            {field:'boxnum',title:'箱号',width:'60px',editor:'text'},
            {field:'boxnumfid',title:'父箱号',width:'60px',editor:'text'},
            {field:'dhorderno',title:'厂编合同',width:'130px',editor:'text'},
        ]],
        columns:[[
            {field:'fno',title:'物料编码',width:'95px'},
            {field:'fname',title:'物料描述',width:'200px'},
            {field:'numberweight',title:'应装数量',width:'100px'},
            {field:'erpSysno',title:'SAP订单号',width:'100px'},
            {field:'lineid',title:'SAP订单行号',width:'100px'},
            {field:'plant',title:'事业部',width:'100px'},
            {field:'location',title:'库位号',width:'100px'},
            {field:'sapSdf',title:'售达方',width:'100px'},
            {field:'sapSdfdesc',title:'售达方描述',width:'100px'},
            {field:'sapXsbm',title:'销售部门',width:'100px'},
            {field:'sapXsbmdesc',title:'销售部门描述',width:'100px'},
            {field:'actualnum',title:'实装数量',width:'100px',editor:'text'},
            {field:'packman',title:'装箱员',width:'100px',editor:'text'},
            {field:'packdate',title:'最新装箱时间',width:'90px',editor:'text'},
            {field:'iscomplete',title:'完箱标识',width:'100px',editor:'text'},
            {field:'checkman',title:'检验员',width:'90px',editor:'text'},
            {field:'checknum',title:'检验数量',width:'90px',editor:'text'},
            {field:'checkresult',title:'检验结果',width:'90px',editor:'text'},
            {field:'checkdate',title:'检验日期',width:'90px',editor:'text'},
            {field:'headweight',title:'盖重',width:'90px',editor:'text'},
            {field:'boxweight',title:'箱重',width:'90px',editor:'text'},
            {field:'actualweight',title:'实际重量',width:'80px',editor:'text'},
            {field:'weightinputman',title:'称重人',width:'90px',editor:'text'},
            {field:'weightinputdate',title:'称重时间',width:'90px',editor:'text'},
            {field:'weightway',title:'称重方式',width:'100px',editor:'text'},
            {field:'packagelistid',title:'装箱单ID',width:'80px'},
        ]],
        sortName:'serialno',
        sortOrder:'asc',
    });

    $("#packagecheck_pttakegrid").datagrid({
        fit: false, //自动适屏功能
        autoRowWidth: true,
        pagination : false,
        showFooter: true,
        loadMsg: '正在加载中，请稍等... ',
        fitColumns:true,//宽度自适应
        singleSelect:false,
        remoteSort:false,
        width:'auto',
        method:'get',
        id:'id',
        columns:[[
            { field:'ck',width:'4%',title:'编号',halign: 'center', sortable: true,checkbox: true},
            {field:'id',title:'id',width:'4%',halign: 'center',hidden:true},
            {field:'serialno',title:'箱单号',width:'150px'},
            {field:'checkname',title:'检验问题',width:'200px'},
        ]],
        sortName:'serialno',
        pageList: [100, 300,500],
        sortOrder:'asc'
    });

    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }

    function onClickRow(index) {
        var row  = $('#packagecheck_ptyd').treegrid("getSelected");
        serialno = row.serialno;
        packhalfid = row.id;
        console.log(row);
        if(row.dhorderno!="")
        {
            $('#packagecheck_pttakegrid').datagrid('loadData', { total: 0, rows: [] });
        }
        else
        {
            jQuery.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${pageContext.request.contextPath}/PackageCheck/checkdetailQuery",//要发送的后台地址
                data: {
                    serialno:serialno,
                    packhalfid:packhalfid
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    console.log(data);
                    $.messager.progress('close');
                    $("#packagecheck_pttakegrid").datagrid({
                        fit: false, //自动适屏功能
                        autoRowWidth: true,
                        showFooter: true,
                        pagination : false,
                        loadMsg: '正在加载中，请稍等... ',
                        fitColumns:true,//宽度自适应
                        singleSelect:false,
                        remoteSort:false,
                        width:'auto',
                        method:'get',
                        data:data,
                        id:'id',
                        nowrap:false,
                        columns:[[
                            {field:'ck',width:'4%',title:'编号',halign: 'center', sortable: true,checkbox: true},
                            {field:'id',title:'id',width:'4%',halign: 'center',hidden:true},
                            {field:'serialno',title:'箱单号',width:'200px'},
                            {field:'checkname',title:'检验问题',width:'200px'},
                        ]],
                        sortName:'serialno',
                        pageList: [25],
                        sortOrder:'asc',
                        onLoadSuccess:function(data){
                            if(data){
                                $.each(data.rows, function(index, item){
                                    if(item.checked){
                                        $('#packagecheck_pttakegrid').datagrid('checkRow', index);
                                    }
                                });
                            }
                        }
                    });
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    $.messager.progress('close');
                    $.messager.alert('提示',msg,'info');
                }
            });
        }
    }
    function checkdetailSubmit(){
        var ids = "";
        var rows  = $('#packagecheck_pttakegrid').datagrid("getSelections");
        for(var i=0; i<rows.length; i++){
            ids = ids + rows[i].id+",";
        }
        $.messager.confirm('询问', '确定提交问题?', function(b) {
            if(b){
                jQuery.ajax({
                    type:"POST",   //post提交方式默认是get
                    url:"${pageContext.request.contextPath}/PackageCheck/checkdetailSubmit",
                    dataType:"json",
                    data:{
                        ids:ids,
                        packhalfid:packhalfid
                    },
                    error:function(request) {
                        $.messager.alert('提示', '提交问题失败!');
                    },
                    success:function(results) {

                        if (results.succsess == true) {
                            $.messager.alert('提示', results.message);

                        }else{
                            $.messager.alert('提示', results.message);
                        }
                    }
                });
            }
        })
    }

    /**
     * Name 搜索按钮事件
     */
    function packagecheckquery() {
        $.messager.progress({
            title:'请稍后',
            msg:'页面加载中...'
        })
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/packageCheckQuery",//要发送的后台地址
            data: {
                dhorderno:$('#package_horderno').val(),
                boxnum:$('#package_boxnum').val(),
                serialno: $('#package_serialno').val(),
                location:$('#package_location').val(),
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packagecheck_ptyd").treegrid({
                    fit: false, //自动适屏功能
                    autoRowWidth: true,
                    showFooter: true,
                    loadMsg: '正在加载中，请稍等... ',
                    fitColumns:true,//宽度自适应
                    singleSelect:true,
                    remoteSort:false,
                    width:'auto',
                    method:'get',
                    data:data,
                    id:'id',
                    nowrap:false,
                    frozenColumns:[[
                        {field:'id',title:'ID',width:'50px',sortable:true,remoteSort:false,hidden:true},
                        {field:'serialno',title:'箱单号',width:'150px',editor:'text'},
                        {field:'boxnum',title:'箱号',width:'60px',editor:'text'},
                        {field:'boxnumfid',title:'父箱号',width:'60px',editor:'text'},
                        {field:'dhorderno',title:'厂编合同',width:'130px',editor:'text'},
                    ]],
                    columns:[[
                        {field:'fno',title:'物料编码',width:'95px'},
                        {field:'fname',title:'物料描述',width:'200px'},
                        {field:'numberweight',title:'应装数量',width:'100px'},
                        {field:'erpSysno',title:'SAP订单号',width:'100px'},
                        {field:'lineid',title:'SAP订单行号',width:'100px'},
                        {field:'plant',title:'事业部',width:'100px'},
                        {field:'location',title:'库位号',width:'100px'},
                        {field:'sapSdf',title:'售达方',width:'100px'},
                        {field:'sapSdfdesc',title:'售达方描述',width:'100px'},
                        {field:'sapXsbm',title:'销售部门',width:'100px'},
                        {field:'sapXsbmdesc',title:'销售部门描述',width:'100px'},
                        {field:'actualnum',title:'实装数量',width:'100px',editor:'text'},
                        {field:'packman',title:'装箱员',width:'100px',editor:'text'},
                        {field:'packdate',title:'最新装箱时间',width:'90px',editor:'text',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        }  },
                        {field:'iscomplete',title:'完箱标识',width:'100px',editor:'text'},
                        {field:'checkman',title:'检验员',width:'90px',editor:'text'},
                        {field:'checknum',title:'检验数量',width:'90px',editor:'text'},
                        {field:'checkresult',title:'检验结果',width:'90px',editor:'text'},
                        {field:'checkdate',title:'检验日期',width:'90px',editor:'text',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));
                        }  },
                        {field:'headweight',title:'盖重',width:'90px',editor:'text'},
                        {field:'boxweight',title:'箱重',width:'90px',editor:'text'},
                        {field:'actualweight',title:'实际重量',width:'80px',editor:'text'},
                        {field:'weightinputman',title:'称重人',width:'90px',editor:'text'},
                        {field:'weightinputdate',title:'称重时间',width:'90px',editor:'text',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        }  },
                        {field:'weightway',title:'称重方式',width:'100px',editor:'text'},
                        {field:'packagelistid',title:'装箱单ID',width:'80px'},

                    ]],
                    sortOrder:'asc'
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
            }
        });
//        ptcolor();
    }

    function onRowContextMenu(e, rowIndex, rowData){
        e.preventDefault();
        var selected=$("#packagecheck_ptyd").datagrid('getRows'); //获取所有行集合对象
        selected[rowIndex].id; //index为当前右键行的索引，指向当前行对象
        $('#mm').menu('show', {
            left:e.pageX,
            top:e.pageY
        });
    }

    /**
     * Name 结束编辑方法
     */
    var editIndex = undefined;
    var ydIndex = undefined;
    function endEditing(){
        if (editIndex == undefined)
        {
            return true
        }
        else
        {
            return false;
        }
    }

    function onClickRow2(index){
        if (editIndex !== index){

            var data = $('#packagecheck_pttakegrid').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#packagecheck_pttakegrid').datagrid('selectRow', editIndex);
                }
            }
            
            editIndex = index;
        }
    }
    function Print() {
        var row = $("#packagecheck_pttakegrid").datagrid("getSelected");
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
            $('#packagecheck_pttakegrid').datagrid('refreshRow', editIndex);
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
