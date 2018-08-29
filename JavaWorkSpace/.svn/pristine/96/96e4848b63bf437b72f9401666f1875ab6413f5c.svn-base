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
        width:60%;
        height:75%;
    }
    .B{
        width: 10%;
        height: 75%;
    }
    .C{
        width:40%;
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
                            <td><label>厂编合同：</label><input id="packageIn_horderno" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <label>箱号：</label><input id="packageIn__boxnum" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td><label>装箱单号：</label><input id="packageIn_packagelistid" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="ptquery()" data-options="iconCls:'icon-search'">查询</a></td>
                        </tr>
                    </table>
                </div>

            </div>

            <div class="easyui-layout haorooms"  style="width:100%;height:80%" >
                <div class="A" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" >
                        <div style="width: 100%;height:53%" data-options="region:'center'">
                            <table id="packageIn_ptyd" class="easyui-treegrid" style="white-space: nowrap;height: 100%" title="包装库存" data-options="singleSelect:true,idField: 'id',onClickRow:onClickRow,
                                    treeField: 'serialno'"></table>
                        </div>
                    </div>
                </div>

                <div class="B" data-options="region:'center',split:true">
                    <div style="height: 50%;"  >
                        <button  onclick="ptgo()"  class="easyui-linkbutton" style="margin-top: 100px">接收>></button>
                    </div>
                    <div style="">
                            <button class="easyui-linkbutton" onclick="ptback()">删除<<</button>
                    </div>
                </div>
                <div class="C"  data-options="region:'east',split:true">


                    <table class="easyui-datagrid" id="packageIn_pttakegrid" title="成品入库记录" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,onClickRow:onClickRow2,editor:'text'" ></table>
                </div>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
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
    var indexrow;
    var packgoodrow;
    packgoodquery();
    $("#packageIn_ptyd").treegrid({
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
//        loadFilter:pagerFilter,
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
            {field:'fname',title:'物料描述',width:'160px'},
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
//        pagination:true,
//                    sortName:'id',
        sortName:'serialno',
//                    sortName:'f3',
//        pageList: [25, 50,100],
        sortOrder:'asc',

    });




    function getRowIndex(target){
        var tr = $(target).closest("tr.datagrid-row");
        return parseInt(tr.attr("datagrid-row-index"));
    }




    /**
     * Name 搜索按钮事件
     */

    function ptquery() {
        $.messager.progress({
            title:'请稍后',
            msg:'页面加载中...'
        })
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/packageInQuery",//要发送的后台地址
            data: {
                dhorderno:$('#packageIn_horderno').val(),
                boxnum:$('#packageIn__boxnum').val(),
                packagelistid:$('#packageIn_packagelistid').val(),

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packageIn_ptyd").treegrid({

//                    rowStyler:function(index,row){
//                        if(row.packtakereturn ==true){
//                            return 'background-color:#E066FF;';
//                        }
//                        if( row.istake ==true){
//                            return 'background-color:green;';
//                        }
//                        if( row.issure == true){
//                            return 'background-color:#FFD700;';
//                        }
//                    },
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
//                    loadFilter:pagerFilter,
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
                        {field:'fname',title:'物料描述',width:'160px'},
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
//                    pagination:true,
//                    sortName:'id',
//                    sortName:'serialno',
//                    sortName:'f3',
//                    pageList: [25],
                    sortOrder:'asc'
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
            }
        });
    }

    function ptgo(){

        $('#packageIn_ptyd').treegrid('clearSelections');
        console.log(indexrow);
        if(indexrow.boxnumfid!=0){
            $.messager.alert('信息提示', '请选择父节点！', 'info');
        }else{
            if(indexrow.isrcv==true){
                $.messager.alert('信息提示', '该数据已接收！', 'info');
            }else{

                var id = indexrow.id;
                jQuery.ajax({
                    type:"POST",   //post提交方式默认是get
                    url:"${pageContext.request.contextPath}/PackageCheck/ptgo",
                    dataType:"json",
                    data:{
                        id:id,
                    },
                    error:function(request) {
                        $.messager.alert('提示', '提交问题失败!');
                    },
                    success:function(results) {
                        $.messager.alert('提示', results.message);
                        packgoodquery();
                        ptquery();
                    }
                });
            }

        }

    }
    function ptback(){
        console.log(packgoodrow);
        var id = packgoodrow.id;
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${pageContext.request.contextPath}/PackageCheck/ptback",
            dataType:"json",
            data:{
                id:id,
            },
            error:function(request) {
                $.messager.alert('提示', '提交问题失败!');
            },
            success:function(results) {
                $.messager.alert('提示', results.message);
                packgoodquery();
                ptquery();
            }
        });
    }

    function packgoodquery(){
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${pageContext.request.contextPath}/PackageCheck/packgoodQuery",
            dataType:"json",
            error:function(request) {
                $.messager.alert('提示', '提交问题失败!');
            },
            success:function(data) {

                $("#packageIn_pttakegrid").datagrid({

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
                    frozenColumns:[[
                        {field:'id',title:'ID',width:'50px',sortable:true,remoteSort:false,hidden:true},
                        {field:'serialno',title:'箱单号',width:'100px'},
                        {field:'boxnum',title:'箱号',width:'100px'},
                        {field:'location',title:'成品库位号',width:'100px',editor:'text'},
                    ]],
                    columns:[[
                        {field:'fno',title:'物料编码',width:'100px'},
                        {field:'fname',title:'物料描述',width:'100px'},
                        {field:'numberweight',title:'应装数量',width:'100px'},
                        {field:'dhorderno',title:'厂编合同',width:'100px'},
                        {field:'erpsysno',title:'SAP订单号',width:'100px'},
                        {field:'lineid',title:'SAP订单行号',width:'100px'},
                        {field:'plant',title:'事业部',width:'100px'},
                        {field:'sapSdf',title:'售达方',width:'100px'},
                        {field:'sapSdfdesc',title:'售达方描述',width:'100px'},
                        {field:'sapXsbm',title:'销售部门',width:'100px'},
                        {field:'sapXsbmdesc',title:'销售部门描述',width:'100px'},
                        {field:'doxtbh',title:'发运单号',width:'100px'},
                        {field:'packid',title:'装箱单ID',width:'100px'},
                        {field:'inputman',title:'接收人',width:'100px'},
                        {field:'inputdate',title:'接收时间',width:'100px',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10))}}

                    ]],
                    pagination:true,
//                    sortName:'id',
                    sortName:'serialno',
//                    sortName:'f3',
                    pageList: [100, 300,500],
                    sortOrder:'asc',

                });

            }
        });
    }
    function aaaaa(){
        if (packgoodrow == undefined){

            return true;
        } else {
            return false;
        }

    }
    function viewdetail_sort(target){

            var i =getRowIndex(target);
            var aa = $(target).closest('tr.datagrid-row').find("input[name=id]");
            aa.attr("checked", true);
            var row = $('#packageIn_pttakegrid').datagrid('getRows')[i];
            $('#packageIn_pttakegrid').datagrid('beginEdit',i);
            $('.editcls').linkbutton({text:'修改排序',plain:true,iconCls:'icon-edit'});
            $('.cancel').linkbutton({text:'取消编辑',plain:true,iconCls:'icon-cancel'});
            $('.savecls').linkbutton({text:'保存',plain:true,iconCls:'icon-save'});

    }
    function cancelrow(target){
        var i =getRowIndex(target);
        var row = $('#packageIn_pttakegrid').datagrid('getRows')[i];
        row.editing = false;
        $('#packageIn_pttakegrid').datagrid('refreshRow', i);
        $('.editcls').linkbutton({text:'修改排序',plain:true,iconCls:'icon-edit'});
        $('.cancel').linkbutton({text:'取消编辑',plain:true,iconCls:'icon-cancel'});
        $('.savecls').linkbutton({text:'保存',plain:true,iconCls:'icon-save'});


    }

    function saverowsort(target){
        var i =getRowIndex(target);
        var row = $('#packageIn_pttakegrid').datagrid('getRows')[i];
        console.log(row);
        $('#packageIn_pttakegrid').datagrid('endEdit',i);
        $('.editcls').linkbutton({text:'修改排序',plain:true,iconCls:'icon-edit'});
        $('.cancel').linkbutton({text:'取消编辑',plain:true,iconCls:'icon-cancel'});
        $('.savecls').linkbutton({text:'保存',plain:true,iconCls:'icon-save'});
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:"${pageContext.request.contextPath}/PackageCheck/savelocation.action",
            dataType:"json",
            async: false,
            data:{
                id:row.id,
                location:row.location,
            },
            error:function(request) {
                $.messager.alert('提示', '保存失败!');
            },
            success:function(results) {

                    $.messager.alert('提示', '保存成功!');
                    packgoodquery();

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
//        if ($('#packageIn_pttakegrid').datagrid('validateRow', editIndex)){
//            $('#packageIn_pttakegrid').datagrid('endEdit', editIndex);
//            editIndex = undefined;
//            return true;
//        }
        else {
            return false;
        }
    }

    function onClickRow(index) {
        var row  = $('#packageIn_ptyd').treegrid("getSelected");
        indexrow = row;
    }
    function onClickRow2(index){
        packgoodrow = $('#packageIn_pttakegrid').datagrid("getSelected");
        $('#packageIn_pttakegrid').datagrid('beginEdit', index);
        var ed = $('#packageIn_pttakegrid').datagrid('getEditors', index);
        for (var i = 0; i < ed.length; i++) {
            var e = ed[i];
            $(e.target).bind('keyup', function () {
                if (window.event.keyCode == 13) {
                    $('#packageIn_pttakegrid').datagrid('endEdit', index);
                    jQuery.ajax({
                        type:"POST",   //post提交方式默认是get
                        url:"${pageContext.request.contextPath}/PackageCheck/savelocation.action",
                        dataType:"json",
                        async: false,
                        data:{
                            id:packgoodrow.id,
                            location:packgoodrow.location,
                        },
                        error:function(request) {
                            $.messager.alert('提示', '保存失败!');
                        },
                        success:function(results) {
                            $.messager.alert('提示', '保存成功!');
                            packgoodquery();

                        }
                    });
                }
            });
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
