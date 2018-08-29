<%--
  Created by IntelliJ IDEA.
  User: liuar
  Date: 2018-07-03
  Time: 10:00 交货单
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=G3Ge2qGYlrycIhipp8nC1LwQBd5aTxQY"></script>
<style>
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .DA{
        width:70%;
        height:75%;
    }
    .divmore{
        margin-left: -5px;
        padding: 10px 10px 10px 10px;
        /*border: 1px solid red;*/
        border-right: 1px solid #E0EEEE;
        border-bottom: 1px solid #E0EEEE;
    }
    .DC{
        width:44%;
        height:75%;
    }
    .haorooms{
        height: calc(100% - 80px);
    }
    .iw_poi_title
    {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content
    {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
    body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="交货单" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 80px">
            <div class="wu-toolbar-button">
                    <td><a href="#" class="easyui-linkbutton" plain="true" onclick="di_export()" data-options="iconCls:'icon-table-go'">导出</a></td>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-print"   plain="true">打印</a>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td>发货编号：<input id="Z1" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label>起始时间：</label><input id ="Z2" style="width:80px" class="easyui-datebox"></td>
                        <%--<td><label>结束时间：</label><input id="Z21" style="width:80px" class="easyui-datebox"></td>--%>
                            <td><a href="#" class="easyui-linkbutton"  onclick="goods_query()" data-options="iconCls:'icon-search'">查询</a></td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="goods_showMore()" data-options="iconCls:'icon-search'">更多</a></td>
                    </tr>
                </table>
                <div class = "divmore" style="position: absolute;z-index:1001;background-color: white" id="goods_Show">
                    <table>
                        <tr>
                                <td><label>业务员：</label><input id="Z3" class="easyui-textbox" style="width:80px"></td>
                                <td><label>客户单位名称：</label><input id="Z4" class="easyui-textbox" style="width:80px"></td>
                                <td><label>收货单位名称：</label><input id="Z5" class="easyui-textbox" style="width:80px"></td>
                                <td><label>运输方式：</label><input id="Z6" class="easyui-textbox" style="width:80px"></input></td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td><label>总金额：</label><input id="Z7" class="easyui-textbox" style="width:80px"></td>
                            <td><label>客户联系电话：</label><input id="Z8" class="easyui-textbox" style="width:80px"></td>
                            <td><label><span>收货详细地址：</span></label><input id="Z9" class="easyui-textbox" style="width:80px">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="easyui-layout haorooms">
                <div class="DA" data-options="region:'west',split:true,border:true" >
                    <table id="ShowGoods" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                </div>
                    <div class="DC" data-options="region:'center',split:true,border:true" >
                        <div class="easyui-layout" data-options="fit:true">
                            <%--表头--%>
                            <table id="ShowGoods1" class="easyui-datagrid" style="white-space: nowrap;height: 5%;width: 100%"  data-options="singleSelect:true,editor:'text,region:'north'">
                                <tr class="easyui-datagrid-north">
                                    <td>
                                        <ul id="northmenu">
                                            <li>
                                                商品物流详细信息
                                            </li>
                                        </ul></td>
                                </tr>
                            </table>
                                <%--地图--%>
                            <table  class="easyui-datagrid" style="white-space: nowrap;height: 40%;width: 100%;"  data-options="singleSelect:true,region:'center'">
                                    <tr><td>
                                            <div style="width:100%;height:300px;border:#ccc solid 1px;" id="allmap"></div>
                                    </td></tr>
                            </table>

                            <%--信息--%>
                            <table id="LogisticsTime"  class="TimeInformation"></table>

                        </div>
                    </div>
        </div>
    </div>
</div>

<%--详细商品页面--%>
<div id="DMSDetailed" class="easyui-dialog easyui-layout"  title="商品详细" style="width: 100%; height: 100%;" closed="true">
    <form id="DetailedForm" method="post">
            <div class="DA" data-options="region:'center',split:true,border:true" >
                <table id="ShowSearch" class="DetailedText" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
            </div>
    </form>
</div>
<%--详细商品结束--%>

<%--确认收货页面--%>
<div id="DMSEvaluation" class="easyui-dialog "  title="商品详细" style="width: 100%; height: 100%;" closed="true">
     <div class="easyui-datagrid easyui-layout" data-options="region:'north'" style="height: 80px">
        <table class="DMSEvaluationTitle">
            <tr>
                <td>产品描述：06B-2滚子链\喷丸\160L</td>
                <td>物料编码：C000004387</td>
            </tr>
        </table>
     </div>
    <div class="easyui-datagrid easyui-layout"style="height: 314px">
            <ul class="DMSEvaluationComments">
                <li id="CommentsBottom">评价内容</li>
                <li><textarea style="width: 400px;height: 230px" placeholder="请输入评价"></textarea></li>
            </ul>
            <ul class="DMSEvaluationComments1">
                <li>
                    <h2>产品质量</h2>
                    <ul class="stars">
                        <li>★</li>
                        <li>★</li>
                        <li>★</li>
                        <li>★</li>
                        <li>★</li>
                    </ul>
                </li>
                <li>
                    <h2>业务员服务</h2>
                    <ul class="stars1">
                        <li>★</li>
                        <li>★</li>
                        <li>★</li>
                        <li>★</li>
                        <li>★</li>
                    </ul>
                </li>
            </ul>
        <button class="ConmmentsButton">立即评价</button>
    </div>
</div>
<%--确认收货结束--%>
<script type="text/javascript">
    $("#goods_Show").hide();
    function goods_showMore() {
        $("#goods_Show").toggle();
    }

    //查询按钮开始
    function goods_query() {
        $("#goods_Show").hide();
          var fdata;
          var Z1  = $('#Z1').val();//发货编号
          var Z2 = $('#Z2').val();//创建订单时间
          var Z3 = $('#Z3').val();//业务员
          var Z4 = $('#Z4').val();//客户单位名称
          var Z5 = $('#Z5').val();//收货单位名称
          var Z6 = $('#Z6').val();//运输方式
          var Z7 = $('#Z7').val();//总金额
          var Z8 = $('#Z8').val();//客户联系电话
          var Z9 = $('#Z9').val();//收货详细地址
          var Z10;
          var Z11;
          var s=$.trim(Z1);
          var s1=Z2.split("-");

          if (s1[1]<10){
              s1[1]='-0'+s1[1];
              Z2=s1[0]+s1[1];
          }
          if (s.length<=11 && s.length>=0){
              $.messager.progress({
                  title:'请稍后',
                  msg:'页面加载中...'
              });
              $.ajax({
              type: "post",//数据发送的方式（post 或者 get）
              url: "${pageContext.request.contextPath}/Inventory/Judge.action",//要发送的后台地址
              data: {
              },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
              dataType: "json",//后台处理后返回的数据格式
              error:function(data) {
                  $.messager.progress('close');
              },
              success: function (data){
                  if(data.num>0){
                      $.ajax({
                          type: "post",//数据发送的方式（post 或者 get）
                          url: "${pageContext.request.contextPath}/DeliveryOrderController/Serach.action",//要发送的后台地址
                          data: {
                              Z1:Z1,
                              Z2:Z2,
                              Z3:Z3,
                              Z4:Z4,
                              Z5:Z5,
                              Z6:Z6,
                              Z7:Z7,
                              Z8:Z8,
                              Z9:Z9,
                          },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                          dataType: "json",//后台处理后返回的数据格式
                          success: function (data) {//ajax请求成功后触发的方法
                              if(data.total>0) {
                                  $.messager.progress('close');
                                  console.log(data);
                                  fdata = data;
                                  $("#ShowGoods").datagrid({
                                      idField: 'id',
                                      loadFilter: pagerFilter,
                                      rownumbers: true,
                                      singleSelect: true,
                                      pageList: [100, 200, 500],//分页列表
                                      pagination: true,
                                      multiSort: true,
                                      remoteSort: false,
                                      fit: false, //自动适屏功能
                                      nowrap: false,
                                      width: 'auto',
                                      //fitColumns:true,
                                      //fit:true,
                                      method: 'get',
                                      data: fdata,
                                      columns: [[
                                          {
                                              field: 'fhxtbh',
                                              title: '发货编号',
                                              width: '120',
                                              align: 'left',
                                              halign: 'center',
                                          },
                                          {
                                              field: 'fcodeid',//关联字段查询表用
                                              title: '详细条件',
                                              width: '250',
                                              align: 'left',
                                              halign: 'center',
                                              hidden:'true'//隐藏
                                          },
                                          {
                                              field: 'fhkhmc',
                                              title: '客户单位名称',
                                              width: '200',
                                              align: 'left',
                                              halign: 'center',
                                          },
                                          {
                                              field: 'fhywy',
                                              title: '业务员',
                                              width: '60',
                                              align: 'left',
                                              halign: 'center',
                                          },
                                          {
                                              field: 'field30',
                                              title: '发货时间',
                                              width: '150',
                                              align: 'left',
                                              halign: 'center'
                                          },
                                          {
                                              field: 'fhbbje',
                                              title: '总金额',
                                              width: '100',
                                              align: 'center',
                                              halign: 'center'
                                          },
                                          {
                                              field: 'fhysfs',
                                              title: '运输方式',
                                              width: '160px',
                                              align: 'center',
                                              halign: 'center'
                                          },
                                          {
                                              field: 'field20',
                                              title: '收货单位名称',
                                              width: '160',
                                              align: 'right',
                                              halign: 'center'
                                          },
                                          {
                                              field: 'fhxxdz',
                                              title: '收货详细地址',
                                              width: '260',
                                              align: 'left',
                                              halign: 'center'
                                          },
                                          {
                                              field: 'fhkhdh',
                                              title: '客户联系电话',
                                              width: '120',
                                              align: 'center',
                                              halign: 'center'
                                          },
                                          {
                                              field: 'Z10',
                                              title: '收货管理',
                                              width: '100',
                                              align: 'center',
                                              halign: 'center',
                                              formatter: function (value, rec) {
                                                  var btn = '<a class="editcls" onclick="GoodsComments()" href="javascript:void(0)">确认收货</a>';
                                                  return btn;
                                              }
                                          },
                                          {
                                              field: 'Z11',
                                              title: '商品详细',
                                              width: '100px',
                                              align: 'center',
                                              halign: 'center',
                                              formatter: function (value, rec) {
                                                  var btn = '<a class="editcls" onclick="DetailedInformation()" href="javascript:void(0)">详细信息</a>';
                                                  return btn;
                                              }
                                          },
                                      ]],
                                  });
                              }
                          },
                          error: function (msg) {//ajax请求失败后触发的方法
                              alert(msg);//弹出错误信息
                          }
                      });
                  }
              },
          });
          }else {

              $.messager.alert('信息提示', '该商品不存在!!!');
          }
    }
    //查询按钮结束

   //查询物流时间开始

    //地图开始
    var map = new BMap.Map("allmap");
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 12);
//    var output;
    var searchComplete = function (results){
        if (transit.getStatus() != BMAP_STATUS_SUCCESS){
            return ;
        }
        var plan = results.getPlan(0);
//        output += plan.getDuration(true) + "\n";//获取时间
//        output += "总路程为：" ;
//        output += plan.getDistance(true) + "\n";             //获取距离
                $("#LogisticsTime").find('#Dtime').text(plan.getDuration(true));
                $("#LogisticsTime").find('#DDtime').text(plan.getDistance(true));
        var today = new Date;
        var TotalTime = plan.getDuration(true);

    }
    var transit = new BMap.DrivingRoute(map, {renderOptions: {map: map},
        onSearchComplete: searchComplete,
        onPolylinesSet: function(){
            setTimeout(function(){alert(output)},"1000");
        }});
    //地图结束


    $("#ShowGoods").datagrid({
        //双击事件

        onClickRow : function (index, row) {//easyui封装好的事件（被单机行的索引，被单击行的值）

            var fhxtbh = row.fhxtbh;
            var field30 = row.field30;
            var fhxxdz = row.fhxxdz;

//            $.messager.alert('信息提示', fhxxdz);
            transit.search("杭州东华链条集团有限公司(昌达路)",fhxxdz);

            $("#LogisticsTime").html('<tr><td>销售订单号:</td><td>'+fhxtbh+'</td></tr>'+'<tr><td>发货时间:</td><td>'+field30+'</td></tr>'
                +'<tr><td>共需要:</td><td id="Dtime"></td></tr>'+'<tr><td>距离:</td><td id="DDtime"></td></tr>');

            <%--$.ajax({--%>
<%--//                processData: false,--%>
<%--//                contentType : false,--%>
                <%--type:"POST",   //post提交方式默认是get--%>
                <%--url:"${pageContext.request.contextPath}/DeliveryOrderController/TSerach.action",--%>
                <%--data: {--%>
                    <%--fhxtbh:fhxtbh--%>
                <%--},--%>
                <%--dataType:"json",--%>
                <%--success:function(data) {--%>
                    <%--$("#LogisticsTime").html('<tr><td>销售订单号:</td><td>'+fhxtbh+'</td></tr>'+'<tr><td>发货时间:</td><td>'+field30+'</td></tr>');--%>
                <%--},--%>
                <%--error: function (msg) {//ajax请求失败后触发的方法--%>
                    <%--alert(msg);//弹出错误信息--%>
                <%--}--%>
            <%--})--%>
//            $('#LogisticsTime').datagrid('loadData',{total:0,rows:[]});
        }
    });
    //查询物流时间结束


    //详细物品开始
    function DetailedInformation() {

        //弹出页面
        $("#DMSDetailed").dialog({
            title: '详细商品页面',
            width: 850,
            height:480,
            modal: true,
        });
        $("#DMSDetailed").dialog("open");
        var row = $('#ShowGoods').datagrid('getSelected');
//        alert(typeof(row.fcodeid));
        //查询数据
        var D1;
        var D2;
        var D3;
        var D4;
        var D5;
        var D6;
            $.ajax({
                type: "post",//数据发送的方式（post 或者 get）
                url: "${pageContext.request.contextPath}/DeliveryOrderController/DSerach.action",
                data:{
                    D1:"D1",
                    D2:"D2",
                    D3:"D3",
                    D4:"D4",
                    D5:"D5",
                    D6:"D6",
                    fcodeid:row.fcodeid,
                },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                dataType: "json",//后台处理后返回的数据格式
                success: function (data) {//ajax请求成功后触发的方法
                    if(data.total>0) {
//                        alert('成功');
                        $.messager.progress('close');
                        console.log(data);
                        fdata = data;
                        $("#ShowSearch").datagrid({
                            idField: 'id',
                            loadFilter:pagerFilter,
                            rownumbers: true,
                            singleSelect: true,
                            pageList: [100, 200, 500],//分页列表
                            pagination: true,
                            multiSort: true,
                            remoteSort: false,
                            fit: false, //自动适屏功能
                            nowrap: false,
                            width: 'auto',
                            //fitColumns:true,
                            //fit:true,
                            method: 'get',
                            data: fdata,
                            height: '445px',
                            striped: true,
                            border: true,
                            collapsible:false,//是否可折叠的
                            columns: [[
                                {
                                    field: 'fhfno',
                                    title: '物料编码',
                                    width: '120px',
                                    align: 'left',
                                    halign: 'center',
                                },
                                {
                                    field: 'fhfname',
                                    title: '物料描述',
                                    width: '214px',
                                    align: 'left',
                                    halign: 'center',

                                },
                                {
                                    field: 'field2',
                                    title: '订单数量',
                                    width: '60px',
                                    align: 'left',
                                    halign: 'center',
                                },
                                {
                                    field: 'fhfhsl',
                                    title: '发货数量',
                                    width: '150px',
                                    align: 'left',
                                    halign: 'center'
                                },
                                {
                                    field: 'field7',
                                    title: '发货金额',
                                    width: '100px',
                                    align: 'center',
                                    halign: 'center'
                                },
                                {
                                    field: 'fhzpfs',
                                    title: '装备方式',
                                    width: '160px',
                                    align: 'center',
                                    halign: 'center'
                                },
                                {
                                    field: 'fcodeid',//利用关联字段查询条件
                                    title: '查询条件',
                                    width: '250px',
                                    align: 'center',
                                    halign: 'center',
                                    hidden:'true'
                                },
                            ]],
                        });
                    }else
                        {$.messager.progress('close');}
                },
                error: function (msg) {//ajax请求失败后触发的方法
                    alert(123);//弹出错误信息
                }
            });
        $('#ShowSearch').datagrid('loadData',{total:0,rows:[]});
    }
    //详细物品结束


    //打印
    function di_export() {
        var matnr  = $('#MATNR').val();//物料编码
        var maktx = $('#MAKTX').val();//物料描述
        var url = "../${pageContext.request.contextPath}/Inventory/Export?matnr="+matnr+"&maktx="+maktx+"";
        window.location.href = url;
    }
    //打印结束

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
    function CZRK_pagerFilter(data){
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

//    2018-07-03 by:lar
//日期开始
    $(function () {
        var date=new Date();
//        var year = date.getFullYear();
//        var month = date.getMonth()+1;
//        var day = date.getDate();
//        $('#Z2').val(year+"-"+month+"-"+day);

        var db = $('#Z2');
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
//日期结束




        //地图开始
        $('#Fno').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#WorkProcedure').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#PartName').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#PartDrawing').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
        $('#Fname').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    if (event.keyCode === 13) {
                        mpquery();
                    }
                }
            })
        });
    });
//日期结束



    //星星事件
    $(function() {
        //为星星设置hover效果
        var isClicked = false;
        var beforeClickedIndex = -1;
        var clickNum = 0; //点击同一颗星次数
        $('.stars li').hover(
            function() {
                if(!isClicked) {
                    $(this).css('color', '#F0AD4E');
                    var index = $(this).index();
                    for(var i = 0; i <= index; i++) {
                        $('.stars li:nth-child(' + i + ')').css('color', '#F0AD4E');
                    }
                }
            },
            function() {
                if(!isClicked) {
                    $('.stars li').css('color', '#ADADAD');
                }
            }
        );
        //星星点击事件
        $('.stars li').click(function() {
            $('.stars li').css('color', '#ADADAD');
            isClicked = true;
            var index = $(this).index();
            for(var i = 1; i <= index+1; i++) {
                $('.stars li:nth-child(' + i + ')').css('color', '#F0AD4E');
            }
            if(index == beforeClickedIndex) { //两次点击同一颗星星 该星星颜色变化
                clickNum++;
                if(clickNum % 2 == 1) {
                    $('.stars li:nth-child(' + (index + 1) + ')').css('color', '#FFED97');
                } else {
                    $('.stars li:nth-child(' + (index + 1) + ')').css('color', '#FFED97');
                }
            } else {
                clickNum = 0;
                beforeClickedIndex = index;
            }
        });
    });
    $(function() {
        //为星星设置hover效果
        var isClicked = false;
        var beforeClickedIndex = -1;
        var clickNum = 0; //点击同一颗星次数
        $('.stars1 li').hover(
            function() {
                if(!isClicked) {
                    $(this).css('color', '#F0AD4E');
                    var index = $(this).index();
                    for(var i = 0; i <= index; i++) {
                        $('.stars1 li:nth-child(' + i + ')').css('color', '#F0AD4E');
                    }
                }
            },
            function() {
                if(!isClicked) {
                    $('.stars1 li').css('color', '#ADADAD');
                }
            }
        );
        //星星点击事件
        $('.stars1 li').click(function() {
            $('.stars1 li').css('color', '#ADADAD');
            isClicked = true;
            var index = $(this).index();
            for(var i = 1; i <= index+1; i++) {
                $('.stars1 li:nth-child(' + i + ')').css('color', '#F0AD4E');
            }
            if(index == beforeClickedIndex) { //两次点击同一颗星星 该星星颜色变化
                clickNum++;
                if(clickNum % 2 == 1) {
                    $('.stars1 li:nth-child(' + (index + 1) + ')').css('color', '#FFED97');
                } else {
                    $('.stars1 li:nth-child(' + (index + 1) + ')').css('color', '#FFED97');
                }
            } else {
                clickNum = 0;
                beforeClickedIndex = index;
            }
        });
    });
    //星星结束

    //打开确认收货页面
    function GoodsComments() {
        $("#DMSEvaluation").dialog({
            title: '商品评论',
            width: 1300,
            height:430,
            modal: true,
        });
        $("#DMSEvaluation").dialog("open");
    }
    //打开确认收货页面结束

</script>












