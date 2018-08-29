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
                            <td><label>厂编合同：</label><input id="packGoodselect_horderno" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <label>箱号：</label><input id="packGoodselect_boxnum" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="ptquery()" data-options="iconCls:'icon-search'">查询</a></td>
                        </tr>
                        <tr>
                            <td><label>装箱单号：</label><input id="packGoodselect_serialno" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <label>库位：</label><input id="packGoodselect_location" class="easyui-textbox" style="width:100px">&nbsp</td>


                        </tr>
                    </table>
                </div>

            </div>

            <div class="easyui-layout haorooms" style="width:100%;height:85%"  >
                <div class="A" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:70%">
                        <div style="width: 100%;height:53%" data-options="region:'center'">
                            <table id="packGoodselect_ptyd" class="easyui-treegrid" style="white-space: nowrap;height: 100%" title="包装库存" data-options="singleSelect:true,idField: 'id',onClickRow:onClickRow,
                                    treeField: 'serialno'"></table>
                        </div>
                    </div>
                </div>

                <div class="C"  data-options="region:'center',split:true">


                    <table class="easyui-datagrid" id="packGoodselect_pttakegrid" title="调拨记录" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,onClickRow:onClickRow2,editor:'text'" ></table>
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
    $("#packGoodselect_ptyd").treegrid({
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

    $("#packGoodselect_pttakegrid").datagrid({

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

        columns:[[
            {field:'PackGoodID',title:'成品箱编号',width:'200px'},
            {field:'OldLocation',title:'调出库位',width:'200px'},
            {field:'NewLocation',title:'调入库位',width:'200px'},
            {field:'TransMan',title:'调拨人',width:'200px'},
            {field:'TransDate',title:'调拨时间',width:'200px'},
        ]],
        pagination:true,
//                    sortName:'id',
        sortName:'serialno',
//                    sortName:'f3',
        pageList: [100, 300,500],
        sortOrder:'asc'
    });

    function onClickRow(index) {
        var row  = $('#packGoodselect_ptyd').treegrid("getSelected");
        var packgoodid = row.id;
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/PackGoodAllotQuery",//要发送的后台地址
            data: {
                packgoodid:packgoodid
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');

                $("#packGoodselect_pttakegrid").datagrid({
                    data:data,
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

                    columns:[[
                        {field:'packgoodid',title:'成品箱编号',width:'200px'},
                        {field:'oldlocation',title:'调出库位',width:'200px'},
                        {field:'newlocation',title:'调入库位',width:'200px'},
                        {field:'transman',title:'调拨人',width:'200px'},
                        {field:'transdate',title:'调拨时间',width:'200px',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        }  },
                    ]],
                    pagination:true,
//                    sortName:'id',
                    sortName:'serialno',
//                    sortName:'f3',
                    pageList: [100, 300,500],
                    sortOrder:'asc'
                });

            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
            }
        });
    }
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
            url: "${pageContext.request.contextPath}/PackageCheck/packageCheckQuery",//要发送的后台地址
            data: {
                dhorderno:$('#packGoodselect_horderno').val(),
                boxnum:$('#packGoodselect_boxnum').val(),
                serialno:$('#packGoodselect_serialno').val(),
                location:$('#packGoodselect_location').val(),
//                page:page,
//                rows:pageSize

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packGoodselect_ptyd").treegrid({
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
                    sortOrder:'asc'
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
            }
        });
    }
    function ptstoretake() {
        $.messager.progress({
            title:'请稍后',
            msg:'页面加载中...'
        })
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth = myDate.getMonth()+1;
        var uday = myDate.getDate();
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "/packGoodselectTakeController/ptstoretake.action",//要发送的后台地址
            data: {
                date:uyear+"-"+umouth+"-"+uday,
                plant:localStorage.getItem('Department'),
                User:localStorage.getItem('User'),
                type:'0'

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packGoodselect_pttakegrid").datagrid({
                    rowStyler:function(index,row){
                        if(row.moveok == true){
                            return 'background-color:#FFB90F;';
                        }
                        if(row.ismove == true){
                            return 'background-color:green;';
                        }
                        if(row.id != null){// row.id != undefined||
                            return 'color:red;';
                        }
                    },
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
                    data:data,
                    loadFilter:pagerFilter,
                    id:'id',
                    frozenColumns:[[
                        {field:'id',title:'ID',width:'50px',sortable:true,remoteSort:false,hidden:true},
                        {field:'serialno',title:'编号',width:'75px',sortable:true,remoteSort:false},
                        {field:'fno',title:'物料编码',width:'110px'},
                        {field:'takenumber',title:'接收数量',width:'90px',editor:'text'},
                    ]],
                    columns:[[
                        {field:'ismix',title:'配组合件',width:'60px'},
                        {field:'isok',title:'确认交接',width:'50px'},
                        {field:'descrip',title:'描述（打印标记等）',width:'250px'},
                        {field:'orderline',title:'厂编合同及行号',width:'140px'},
                        {field:'nwx',title:'内外销',width:'50px'},
                        {field:'gcxh',title:'工程兴化',width:'50px'},
                        {field:'sapsdorder',title:'SAP订单',width:'90px'},
                        {field:'f3',title:'节数',width:'70px',sortable:true,remoteSort:false},
                        {field:'isback',title:'其他入库',width:'90px'},
                        {field:'ismove',title:'已移库',width:'90px'},
                        {field:'moveok',title:'移库失败',width:'80px'},
                        {field:'plant',title:'事业部',width:'90px'},
                        {field:'takeman',title:'包装接受人',width:'90px'},
                        {field:'takedate',title:'包装接受时间',width:'90px'},
                        {field:'uyear',title:'年度',width:'90px'},
                        {field:'umonth',title:'月度',width:'90px'},
                        {field:'takepart',title:'接收部门',width:'90px'},
                        {field:'takekind',title:'接收类型',width:'90px'},
                        {field:'number',title:'装配数量',width:'70px'},
                        {field:'fname',title:'物料描述',width:'135px'},
                        {field:'dutyman',title:'责任班长',width:'90px'},
                        {field:'assserialno',title:'装配编号',width:'90px'},
                        {field:'line',title:'行号',width:'30px'},
                        {field:'assretrun',title:'包装退库',width:'90px'},
                        {field:'onlyscan',title:'串装未确认',width:'90px'},
                        {field:'pcvalue',title:'单条产值',width:'90px',hidde:true},
                        {field:'returnid',title:'退货ID',width:'90px',hidde:true},
                        {field:'heatid',title:'heatid',width:'90px',hidde:true},

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
                    $('#packGoodselect_pttakegrid').datagrid('selectRow',editIndex);
                }
                return true;
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.progress('close');
                $.messager.alert('提示',msg,'info');
                return false;
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
//        if ($('#packGoodselect_pttakegrid').datagrid('validateRow', editIndex)){
//            $('#packGoodselect_pttakegrid').datagrid('endEdit', editIndex);
//            editIndex = undefined;
//            return true;
//        }
        else {
            return false;
        }
    }

    function onClickRow2(index){
        if (editIndex !== index){

            var data = $('#packGoodselect_pttakegrid').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#packGoodselect_pttakegrid').datagrid('selectRow', editIndex);
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
    function Print() {
        var row = $("#packGoodselect_pttakegrid").datagrid("getSelected");
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
            $('#packGoodselect_pttakegrid').datagrid('refreshRow', editIndex);
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
