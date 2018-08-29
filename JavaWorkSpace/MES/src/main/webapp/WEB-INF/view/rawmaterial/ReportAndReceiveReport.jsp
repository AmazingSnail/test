<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2018/8/6
  Time: 9:16 收发报表
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .rr{
        width:100%;
        height:100%;
    }
    .rr3{
        letter-spacing:0.34em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
    }
    .haorooms1{
        height: calc(100% - 99px);
    }
</style>
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel" title="原材料接收" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 99px">
            <div class="wu-toolbar-button">
                <div id="testr"><input  id ="rrdb" style="width:110px" class="easyui-text" hidden="hidden"></div>
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="rr_check()" plain="true">检验</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="rr_export()" plain="true">导出</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="rr_update()" plain="true">修改</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="rr_print()" plain="true">打印</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="rr_delete()" plain="true">删除</a>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td> <label><span class="rr3">事业部：</span></label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="rrPlant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select>&nbsp&nbsp&nbsp</td>
                        <td><label>起始时间：</label><input  id ="rrdb1" style="width:110px" class="easyui-datebox">&nbsp&nbsp&nbsp</td>
                        <td><label>物料编码：</label><input id="rr_fno" class="easyui-textbox" style="width:100px">&nbsp&nbsp&nbsp</td>
                        <td><label><span class="rr3" >炉批号</span>：</label><input id="HeatNo" class="easyui-textbox" style="width:100px">&nbsp&nbsp&nbsp
                        </td>
                        <td><a href="#" class="easyui-menubutton" menu="#rrIn" iconCls="icon-search" style="width: 100px">接收操作</a></td>
                    </tr>
                    <tr>
                        <td><label><span class="rr3">供货商：</span></label>
                            <select class="easyui-combobox" name="mmPlant" style="width:90px" datatype="text" id="supporname" panelHeight="auto" data-options="
                                valueField:'supporname',
                                textField:'supporname',
                                panelHeight:'250'"
                                    style="width:90px">
                            </select>&nbsp&nbsp&nbsp</td>
                        <td><label>结束时间：</label><input  id ="rrdb2" style="width:110px" class="easyui-datebox">&nbsp&nbsp&nbsp</td>
                        <td><label>物料描述：</label><input id="rr_fname" class="easyui-textbox" style="width:100px">&nbsp&nbsp&nbsp
                        </td>
                        <td><label>检验结果：</label><select class="easyui-combobox" name="takekind" datatype="text" id="result"  panelHeight="auto" style="width:100px">
                            <option value="" selected="selected">全部</option>
                            <option value="合格">合格</option>
                            <option value="不合格" >不合格</option>
                            <option value="未检验" >未检验</option>
                        </select>&nbsp&nbsp&nbsp</td>
                       <td>
                           <a href="#" class="easyui-menubutton" menu="#rrOut" iconCls="icon-search" style="width: 100px">发出操作</a>
                       </td>
                    </tr>
                </table>
            </div>
              <div id="rrIn" style="width: 100px">
                  <div><a href="#" class="easyui-linkbutton" id="ReceviceIn"  onclick="ReceviceIn()" iconCls="icon-search"  >接收明细查询</a></div>
                  <div><a href="#" class="easyui-linkbutton" id="ReceviceInAll" onclick="ReceviceInAll()" iconCls="icon-search">接收汇总查询</a></div>
              </div>
            <div id="rrOut" style="width: 100px">
                <div><a href="#" class="easyui-linkbutton" id="ReceviceOut"  onclick="ReceviceOut()" iconCls="icon-search">发出明细查询</a></div>
                <div><a href="#" class="easyui-linkbutton" id="ReceviceOutAll" onclick="ReceviceOutAll()" iconCls="icon-search">发出汇总查询</a></div>
            </div>
        </div>
        <div class="easyui-layout haorooms1"   >
            <div class="easyui-layout rr"  data-options="fit:true">
                <div style="width: 100%;height:100%" data-options="region:'center'">
                    <table id="rrid" class="easyui-datagrid" style="white-space: nowrap;height: 100%" data-options=""></table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#testr" ).css("display", "none");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
//        var hour = date.getHours();
//        var min = date.getMinutes();
//        var sec = date.getSeconds();
        $('#rrdb').val(year+"-"+month);
        $('#rrdb1').val(year+"-"+month+"-"+day );
        $('#rrdb2').val(year+"-"+month+"-"+day);
        var db = $('#rrdb');
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
        /*
         获取供应商
         */
        $.ajax({
            type: "post",
            url: "${ctxPath}/MaterialReceive/FindSp.action",
            data: {
                plant :localStorage.getItem("Department"),
            },
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                $('#supporname').combobox('loadData', data);
                $("#supporname").combobox('select',data[0].supporname);
            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/BasicData/getDepartMent.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                console.log(data);
                $('#rrPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
    });
    function ReceviceIn() {
        var plant = $('#rrPlant').combobox("getText");
        var result = $('#result').combobox("getValue");
        var supporname = $('#supporname').combobox("getText");
        var starttime = $("#rrdb1").datebox("getValue");
        var endtime = $("#rrdb2").datebox("getValue");
        var fno = $("#rr_fno").val();
        var fname = $("#rr_fname").val();
        var HeatNo = $("#HeatNo").val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MaterialReceive/ReceviceIn.action",//要发送的后台地址
            data: {
                plant:plant,
                result:result,
                supporname:supporname,
                endtime:endtime,
                starttime:starttime,
                fno:fno,
                fname:fname,
                HeatNo:HeatNo,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                fdata = data;
                $("#rrid").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    showFooter: true,//汇总
                    fit: false, //自动适屏功能
                    nowrap:false,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'pono',title:'采购订单',width: '100px',align:'left',halign:'center'},
                        {field:'fname',title:'物料描述',width: '200px',align:'left',halign:'center'},
                        {field:'fno',title:'物料编码',width: '100px',align:'left',halign: 'center'},
                        {field:'heatno',title:'炉批号',width: '70px',align:'center',halign: 'center'},
                        {field:'supporname',title:'供货商',width: '100px',align:'center',halign: 'center'},
                        {field:'receivenum',title:'收货重量',width:'80px',align:'right',halign: 'center'},
                        {field:'leavenum',title:'剩余数量',width: '80px',align:'right',halign: 'center'},
                        {field:'receivetime',title:'入库日期',width: '150px',align:'left',halign: 'center'},
                        {field:'ischeck',title:'是否合格',width: '80px',align:'center',halign: 'center'},
                        {field:'checkman',title:'检验员',width: '80px',align:'center',halign: 'center'},
                        {field:'checktime',title:'检验时间',width: '150px',align:'left',halign: 'center'},
                        {field:'receiveman',title:'收货人',width: '80px',align:'center',halign: 'center'},
                        {field:'receivetime',title:'收货时间',width: '150px',align:'left',halign: 'center'},
                        {field:'modifyman',title:'修改人',width: '80px',align:'center',halign: 'center'},
                        {field:'modifytime',title:'修改时间',width: '150px',align:'left',halign: 'center'},
                    ]]
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });

        $('#rrid').datagrid('loadData',{total:0,rows:[]});

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
    function ReceviceInAll() {
        var plant = $('#rrPlant').combobox("getText");
        var result = $('#result').combobox("getValue");
        var supporname = $('#supporname').combobox("getText");
        var starttime = $("#rrdb1").datebox("getValue");
        var endtime = $("#rrdb2").datebox("getValue");
        var fno = $("#rr_fno").val();
        var fname = $("#rr_fname").val();
        var HeatNo = $("#HeatNo").val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MaterialReceive/ReceviceInAll.action",//要发送的后台地址
            data: {
                plant:plant,
                result:result,
                supporname:supporname,
                endtime:endtime,
                starttime:starttime,
                fno:fno,
                fname:fname,
                HeatNo:HeatNo,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                fdata = data;
                $("#rrid").datagrid({
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
                    showFooter: true,//汇总
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'pono',title:'采购订单',width: '100px',align:'left',halign:'center'},
                        {field:'fname',title:'物料描述',width: '200px',align:'left',halign:'center'},
                        {field:'fno',title:'物料编码',width: '100px',align:'left',halign: 'center'},
                        {field:'heatno',title:'炉批号',width: '70px',align:'center',halign: 'center'},
                        {field:'supporname',title:'供货商',width: '100px',align:'center',halign: 'center'},
                        {field:'receivenum',title:'收货重量',width:'80px',align:'right',halign: 'center'},
                        {field:'receiveman',title:'收货人',width: '80px',align:'center',halign: 'center'},
                    ]]
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });

        $('#rrid').datagrid('loadData',{total:0,rows:[]});
    }
    function ReceviceOut() {
        var plant = $('#rrPlant').combobox("getText");
        var result = $('#result').combobox("getValue");
        var supporname = $('#supporname').combobox("getText");
        var starttime = $("#rrdb1").datebox("getValue");
        var endtime = $("#rrdb2").datebox("getValue");
        var fno = $("#rr_fno").val();
        var fname = $("#rr_fname").val();
        var HeatNo = $("#HeatNo").val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MaterialReceive/ReceviceOut.action",//要发送的后台地址
            data: {
                plant:plant,
                result:result,
                supporname:supporname,
                endtime:endtime,
                starttime:starttime,
                fno:fno,
                fname:fname,
                HeatNo:HeatNo,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                fdata = data;
                $("#rrid").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    showFooter: true,//汇总
                    fit: false, //自动适屏功能
                    nowrap:false,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'pono',title:'采购订单',width: '100px',align:'left',halign:'center'},
                        {field:'fname',title:'物料描述',width: '200px',align:'left',halign:'center'},
                        {field:'fno',title:'物料编码',width: '100px',align:'left',halign: 'center'},
                        {field:'outputnum',title:'出库数量',width:'80px',align:'right',halign: 'center'},
                        {field:'heatno',title:'炉批号',width: '70px',align:'center',halign: 'center'},
                        {field:'deliveryplant',title:'发货部门',width: '70px',align:'center',halign: 'center'},
                        {field:'supporname',title:'供货商',width: '100px',align:'center',halign: 'center'},
                        {field:'receivetime',title:'入库日期',width: '180px',align:'left',halign: 'center'},
                        {field:'outputman',title:'发货人',width: '80px',align:'center',halign: 'center'},
                        {field:'outputtime',title:'出库时间',width: '180px',align:'left',halign: 'center'},
                    ]]
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#rrid').datagrid('loadData',{total:0,rows:[]});
    }
    function ReceviceOutAll() {
        var plant = $('#rrPlant').combobox("getText");
        var result = $('#result').combobox("getValue");
        var supporname = $('#supporname').combobox("getText");
        var starttime = $("#rrdb1").datebox("getValue");
        var endtime = $("#rrdb2").datebox("getValue");
        var fno = $("#rr_fno").val();
        var fname = $("#rr_fname").val();
        var HeatNo = $("#HeatNo").val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath}/MaterialReceive/ReceviceOutAll.action",//要发送的后台地址
            data: {
                plant:plant,
                result:result,
                supporname:supporname,
                endtime:endtime,
                starttime:starttime,
                fno:fno,
                fname:fname,
                HeatNo:HeatNo,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                console.log(data);
                fdata = data;
                $("#rrid").datagrid({
                    idField:'id',
                    loadFilter:pagerFilter,
                    rownumbers:true,
                    singleSelect:true,
                    pageList:[25,50,100],//分页列表
                    pagination:true,
                    multiSort:true,
                    remoteSort:false,
                    showFooter: true,//汇总
                    fit: false, //自动适屏功能
                    nowrap:false,
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'fname',title:'物料描述',width: '200px',align:'left',halign:'center'},
                        {field:'fno',title:'物料编码',width: '100px',align:'left',halign: 'center'},
                        {field:'outputnum',title:'出库数量',width:'80px',align:'right',halign: 'center'},
                        {field:'deliveryplant',title:'发货部门',width: '70px',align:'center',halign: 'center'},
                        {field:'supporname',title:'供货商',width: '100px',align:'center',halign: 'center'},
                        {field:'outputman',title:'发货人',width: '80px',align:'center',halign: 'center'},
                    ]]
                });
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#rrid').datagrid('loadData',{total:0,rows:[]});
    }
</script>
