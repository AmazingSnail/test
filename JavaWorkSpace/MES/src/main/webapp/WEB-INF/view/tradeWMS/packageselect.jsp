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
                    <span>丨</span>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="$('#packageselect_bz').window('open')" plain="true">期初导入</a>
                    <span>丨</span>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="sapMoveIn()" plain="true">SAP移入</a>
                </div>
                <div class="wu-toolbar-search" style="white-space:nowrap">
                    <table>
                        <tr>
                            <td><label>厂编合同：</label><input id="packageselect_horderno" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <label>箱号：</label><input id="packageselect_boxnum" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td ><label>装箱状态：</label></td>
                            <td style="text-align:left">
                                <span class="radioSpan">
                                    <input type="radio" name="packageselect_IsComplete" value="" checked="checked">全部</input>
                                    <input type="radio" name="packageselect_IsComplete" value="0">半箱</input>
                                    <input type="radio" name="packageselect_IsComplete" value="1">全箱</input>
                                </span>
                            </td>
                            <td> <a href="#" class="easyui-linkbutton" style="width: 120px"  onclick="packageselectquery()" data-options="iconCls:'icon-search'">查询</a></td>
                        </tr>
                        <tr>
                            <td><label>装箱单号：</label><input id="packageselect_serialno" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td> <label>库位：</label><input id="packageselect_location" class="easyui-textbox" style="width:100px">&nbsp</td>
                            <td ><label>入库状态：</label></td>
                            <td style="text-align:left">
                                <span class="radioSpan">
                                    <input type="radio" name="packageselect_IsSAP" value="" checked="checked">全部</input>
                                    <input type="radio" name="packageselect_IsSAP" value="0">入库</input>
                                    <input type="radio" name="packageselect_IsSAP" value="1">未入库</input>
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>

            <div class="easyui-layout haorooms"  style="width:100%;height:85%">
                <div class="A" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" >
                        <div style="width: 100%;height:53%" data-options="region:'center'">
                            <table id="packageselect_ptyd" class="easyui-treegrid" style="white-space: nowrap;height: 100%" title="包装库存" data-options="singleSelect:true,idField: 'id',onClickRow:onClickRow,
                                    treeField: 'serialno'"></table>
                        </div>
                    </div>
                </div>

                <div class="C"  data-options="region:'center',split:true">


                    <table class="easyui-datagrid" id="packageselect_pttakegrid" title="装箱记录" style="white-space: nowrap;height: 100%" data-options="singleSelect:true,onClickRow:onClickRow2,editor:'text'" ></table>
                </div>
            </div>
            <!-- End of toolbar -->
            <div id="packageselect_bz" class="easyui-window" title="导入" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:300px;height:200px;padding:10px;">
                <a href="#" style="width:122px;color: green;margin-bottom: 20px" onclick="download_log()" >下载模板</a>
                <form id="questionTypesManage" method="post" enctype="multipart/form-data" >
                    <p align="center">选择文件：<input id="packageselect-uploadExcel" name="bz-uploadExcel"  class="easyui-filebox" style="width:200px" data-options="prompt:'请选择文件...'"></p>
                    <input id="packageselect-plantvalue" name="packageselect-plantvalue" hidden="hidden">
                </form>　<p align="center">　<a href="#" class="easyui-linkbutton" style="width:122px" onclick="uploadExcel()" >导入</a></p>
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
    $("#packageselect_ptyd").treegrid({
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

    $("#packageselect_pttakegrid").datagrid({

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
            {field:'PackHalfID',title:'所属箱号',width:'100px'},
            {field:'Location',title:'库位号',width:'100px'},
            {field:'SumNum',title:'累计装量',width:'100px'},
            {field:'OnecNum',title:'本次装量',width:'100px'},
            {field:'PackMan',title:'装箱员',width:'100px'},
            {field:'PackDate',title:'装箱日期',width:'100px'}

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
     * 下载模版
     */
    function download_log(){
        var url = "${pageContext.request.contextPath}/PackageCheck/download";
        window.location.href = url;


    }
    function sapMoveIn(){
        var row  = $('#packageselect_ptyd').treegrid("getSelected");
        console.log(row);
        if(row==undefined){
            $.messager.alert('提示', "请先选择数据");
        }else {
            if(row.boxnumfid!=0){
                $.messager.alert('提示', "请选择父层");
            }else{
                $.messager.confirm('询问', '确定sap移交?', function(b) {
                    if(b){
                        jQuery.ajax({
                            type:"POST",   //post提交方式默认是get
                            url:"${pageContext.request.contextPath}/PackageCheck/sapMoveIn",
                            dataType:"json",
                            data:{
                                id:row.id,
                            },
                            error:function(request) {
                                $.messager.alert('提示', '提交问题失败!');
                            },
                            success:function(results) {
                                $.messager.alert('提示', results.message);
                            }
                        });
                    }

                })
            }

        }

    }

    function onClickRow(index) {
        var row  = $('#packageselect_ptyd').treegrid("getSelected");
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/tPackhalfstoreQuery",//要发送的后台地址
            data: {
                id:row.id,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packageselect_pttakegrid").datagrid({
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
                        {field:'packhalfid',title:'所属箱号',width:'100px'},
                        {field:'location',title:'库位号',width:'100px'},
                        {field:'sumnum',title:'累计装量',width:'100px'},
                        {field:'onecnum',title:'本次装量',width:'100px'},
                        {field:'packman',title:'装箱员',width:'100px'},
                        {field:'packdate',title:'装箱日期',width:'100px',formatter: function (date) {
                            return getTime((date.time+"").substring(0,10));

                        } }

                    ]],
                    pagination:true,
//                    sortName:'id',
//                    sortName:'serialno',
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

    /**
     * Name 搜索按钮事件
     */

    function packageselectquery() {
        alert($("input[name='packageselect_IsComplete']:checked").val());
        $.messager.progress({
            title:'请稍后',
            msg:'页面加载中...'
        })
        jQuery.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${pageContext.request.contextPath}/PackageCheck/packageselectQuery",//要发送的后台地址
            data: {
                dhorderno:$('#packageselect_horderno').val(),
                boxnum:$('#packageselect_boxnum').val(),
                iscomplete:$("input[name='packageselect_IsComplete']:checked").val(),
                issap:$("input[name='packageselect_IsSAP']:checked").val(),
                serialno:$('#packageselect_serialno').val(),
                location:$('#packageselect_location').val(),
//                page:page,
//                rows:pageSize

            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $.messager.progress('close');
                $("#packageselect_ptyd").treegrid({

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
            url: "/packageselectTakeController/ptstoretake.action",//要发送的后台地址
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
                $("#packageselect_pttakegrid").datagrid({
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
                    $('#packageselect_pttakegrid').datagrid('selectRow',editIndex);
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
     * Name 获取月度计划表
     */
    function getMplan(selectState) {
        //alert(11111);
        var uyear = $('#ptdb').val().substr(0,4);
        var umouth = $('#ptdb').val().substr(5);


        //var   plant= $('#plant').combobox('getText');
        var   color = $('#ptcolor').combobox('getText');
        var  IsCl = $('#KCard_IsCl').combobox('getValue');
        var F3 = $('#ptF3').val();
        var nwx = $('#ptNwx').val();
        var   dhorderno=$('#KCard_dhorderno').val();
        var   PartDrawing=$('#ptPartDrawing').val();
        var   fname=$('#ptfname').val();
        var   fdata;
        //alert(plant+"===="+dhorderno+"===="+PartDrawing+"===="+fname);
        $.messager.progress({
            title:'请稍等',
            msg:'页面加载中...'
        });
        jQuery.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "/Mplan/query.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umouth:umouth,
                plant:$('#ptPlant').combobox('getText'),
                Dutyman:$('#ptBMan').combobox('getText'),
                dhorderno:dhorderno,
                PartDrawing:PartDrawing,
                selectState:selectState,
                fname:fname,
                Color:color,
                F3:F3,
                nwx:nwx,
                IsCl:IsCl
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#packageselect_ptyd").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    showFooter: true,
                    //fitColumns:true,
                    //fit:true,
                    method:'get',      data:fdata,

                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'beginConnect',title:'期初补卡',hidden:'true',width:100},
                        {field:'SumDayNum',title:'累计串装',hidden:'true',width:100},

                        {field:'number',title:'本月计划|计划入库数',hidden:'true',width:100},
                        {field:'CompleteOrder',title:'完成',hidden:'true',width:100},
                        {field:'DayInput',title:'本日入库',hidden:'true',width:100},
                        {field:'DayNum',title:'本日串装',hidden:'true',width:100},
                        {field:'MillionF3',title:'产值万节',hidden:'true',width:100},
                        {field:'nwx',title:'内外销',hidden:'true',width:100},
                        {field:'WorkPart',title:'工段',hidden:'true',width:100},
                        {field:'MillionWight',title:'万节重量',hidden:'true',width:100},
                        {field:'TakeOrder',title:'接单',hidden:'true',width:100},


                        {field:'dhorderno',title:'厂编合同号',width:110,sortable: true},
                        {field:'PartDrawing',title:'规格',width:150,sortable: true},
                        {field:'F3',title:'节数',width:40,sortable: true},
                        {field:'Color',title:'颜色',width:50,sortable: true},
                        {field:'CLNumber',title:'本月开卡数',width:80, sortable: true},
                        {field:'ConnectPlan',title:'计划串装数',width:80, sortable: true},
                        {field:'Descrip',title:'描述',width:160,sortable: true},
                        {field:'OrderTime',title:'交货期',width:100, sortable: true},


                        {field:'OrderLine',title:'合同加行号',hidden:'true',width:130},
                        {field:'fno',title:'物料编码',width:80, sortable: true},
                        {field:'fname',title:'物料描述',width:160, sortable: true},


                        {field:'Dutyman',title:'责任班长',width:80, sortable: true},


                        {field:'id',title:'序号',width:60},
                        {field:'IsCl',title:'是否入库',width:100},
                        {field:'MaterialDutyman',title:'责任人|配料责任人',hidden:'true',width:100},
                        {field:'plant',title:'事业部',hidden:'true',width:100},
                        {field:'submitstate',title:'Bom状态',hidden:'true',width:100},
                        {field:'singleWeightOK',title:'单节重差',hidden:'true',width:100},
                        {field:'period',title:'生产周期',hidden:'true',width:100},
                        {field:'MachineKind',title:'机器大类',hidden:'true',width:100},
                        {field:'uyear',title:'年度',hidden:'true',width:100},
                        {field:'umouth',title:'月度',hidden:'true',width:100},
                        {field:'SAPSDOrder',title:'SAP订单号',hidden:'true',width:100},
                        {field:'GCXH',title:'工程兴化',hidden:'true',width:100},
                        {field:'ismix',title:'配组合件',hidden:'true',width:100},
                        {field:'SumDayInput',title:'累计入库',hidden:'true',width:100},
                        {field:'ischeck',title:'是否验货',hidden:'true',width:100},
                        {field:'meins',title:'单位',hidden:'true',width:100},
                        {field:'OutputValue',title:'物料产值',hidden:'true',width:100},
                        {field:'Ftemp10',title:'转换关系',hidden:'true',width:100},
                        {field:'ConnectValue',title:'计划串装产值',hidden:'true',width:100},
                        {field:'DayNumValue',title:'累计串装产值',hidden:'true',width:100},
                        {field:'NumberValue',title:'计划入库产值',hidden:'true',width:100},
                        {field:'DayInputValue',title:'累计入库产值',hidden:'true',width:100},
                        {field:'PoNo',title:'采购订单', hidden:'true',width:100},
                        {field:'PoItem',title:'采购订单行项目',hidden:'true',width:100}
                    ]],
                    pageList: [25, 50,100],
                    sortOrder:'asc',
                });
                $('#packageselect_ptyd').datagrid({
                    rowStyler: function (index, row) {
                        var CLNumber =parseFloat(row.CLNumber);
                        var ConnectPlan =parseFloat(row.ConnectPlan);
                        //alert(11);
                        if (CLNumber < ConnectPlan) {
                            return 'color:black;';
                        }
                        else {
//                            return 'color:Green;font-weight:bold;';
                            return 'background-color:Green;color:LightYellow;font-weight:bold;';
                        }

                    }
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
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
//        if ($('#packageselect_pttakegrid').datagrid('validateRow', editIndex)){
//            $('#packageselect_pttakegrid').datagrid('endEdit', editIndex);
//            editIndex = undefined;
//            return true;
//        }
        else {
            return false;
        }
    }
    function asblycardOnClickRow(index){
        if (ydIndex != index){
            var row = $("#packageselect_ptyd").datagrid("getSelected");
            var CompleteOrder = row.CompleteOrder;
            if(CompleteOrder === '1900-01-01 00:00:00.0'){
                CompleteOrder = "";
            }
            $('#dgmx').form('load',{
                id:row.id,
                dhorderno:row.dhorderno,
                SAPSDOrder:row.SAPSDOrder,
                TakeOrder:row.TakeOrder,
                CompleteOrder:CompleteOrder,
                OrderTime:row.OrderTime,
                Color:row.Color,
                Descrip:row.Descrip,
                ConnectPlan:row.ConnectPlan,
                DayNum:row.DayNum,
                SumDayNum:row.SumDayNum,
                beginConnect:row.beginConnect,
                number:row.number,
                DayInput:row.DayInput,
                SumDayInput:row.SumDayInput,
                ischeck:row.ischeck,
                IsCl:row.IsCl,
                ismix:row.ismix,
                nwx:row.nwx,
                singleWeightOK:row.singleWeightOK,
                GCXH:row.GCXH
            });
//        $.ajax({
//            type: "get",
//            url: "/KCard/queryCZG.action?plant=" + $('#Plant').combobox('getText') + "&&worklead=" + row.dutyman + "",
//            dataType: "json",//后台处理后返回的数据格式
//            success: function (data) {//ajax请求成功后触发的方法
//                $('#ReportMan1').combobox('loadData', data);
//            }
//        });
            ydIndex  =index;
        }
    }
    function onClickRow2(index){
        if (editIndex !== index){

            var data = $('#packageselect_pttakegrid').datagrid('getData').rows[editIndex];
            //alert("editIndex:"+editIndex+"..index:"+index);
            if(editIndex!==undefined){
                if(data.id === undefined){
                    $.messager.alert('温馨提示', '存在未保存的数据!');
                    index = editIndex;
                    $('#packageselect_pttakegrid').datagrid('selectRow', editIndex);
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
        var row = $("#packageselect_pttakegrid").datagrid("getSelected");
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
            $('#packageselect_pttakegrid').datagrid('refreshRow', editIndex);
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
