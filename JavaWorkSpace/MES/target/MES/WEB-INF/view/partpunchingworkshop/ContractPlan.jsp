<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-06
  Time: 14:42  ---  合同计划
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    .easyui-panel {
        width: 100%;
        height: 66%;
    }


    .N{
        width:100%;
        height:75%;
    }


    .l3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .l2{
        letter-spacing:1.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-1.1em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 100px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="合同计划" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 100px">
            <div class="wu-toolbar-button">
<shiro:hasPermission name="/ContractPlan/add">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="cpmonp_add()" plain="true">计划导入</a>
</shiro:hasPermission>
<shiro:hasPermission name="/ContractPlan/export">
                <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="cpmonp_export()" plain="true">计划导出</a>
</shiro:hasPermission>
<shiro:hasPermission name="/ContractPlan/delete">
                <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="cpmonp_delete()" plain="true">计划删除</a>
</shiro:hasPermission>

            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr>
                        <td><label> <span class="l2">年月：</span></label><input  id ="cpdb1" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td><label>厂编合同：</label><input id="cp_OrderLine" class="easyui-textbox" style="width:100px"></td>
                        <td><label>零件描述：</label><input id="cp_Fname" class="easyui-textbox" style="width:100px"></td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="cpquery()" data-options="iconCls:'icon-search'" style="width:150px">查询</a></td>

                    </tr>
                    <tr>
                        <td> <label><span class="l3">事业部：</span></label>
                            <select class="easyui-combobox" name="cp-Plant" style="width:100px" datatype="text" id="cp-Plant" panelHeight="auto" data-options="
                                valueField:'Fremark',
                                textField:'Fname',
                                panelHeight:'250'"
                                    style="width:100px">
                            </select></td>
                        <td><label>零件编码：</label><input  id ="cp_Fno" style="width:100px" class="easyui-textbox"></td>
                        <td><label>打印标记：</label><input id="cp_WorkCentre" class="easyui-textbox" style="width:100px">&nbsp</td>
                        <td><label class="labelstyle"><input type="radio" name="cp_ColdCheck" value="3" checked/>全部</label>
                            <label class="labelstyle"><input type="radio" name="cp_ColdCheck" value="1" />已完成</label>
                            <label class="labelstyle"><input type="radio" name="cp_ColdCheck" value="2" />未完成</label></td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="easyui-layout haorooms"  >
            <div class="N" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'">
                        <table id="cp" class="easyui-datagrid" style="white-space: nowrap;height: 100%"  data-options="singleSelect:true"></table>
                    </div>
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
        var day = date.getDate();
        $('#cpdb1').val(year+"-"+month);
//        $('#ptdb').val(year+"-"+month+"-"+day);
        var db = $('#cpdb1');
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
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/MonthPlan/query.action',
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
                $('#cp-Plant').combobox('loadData', data);
            }
        });



    });
   function cpmonp_delete () {
       var row = $("#cp").datagrid("getSelected");
       var ids = row.id;
       $.messager.confirm('温馨提示', '你确定要删除吗?', function (r) {
           if (r) {
               $.ajax({
                   type:"post",
                   url: "${ctxPath}/MonthPlan/delete.action",//要发送的后台地址
                   data:{
                       ids:ids,
                   },
                   dataType: "json",//后台处理后返回的数据格式
                   success: function (data1) {//ajax请求成功后触发的方法
                       console.log(data1);
                       if (data1.num !=-1) {
                           $.messager.alert('温馨提示', '删除成功！！！');
                           cpquery();
                       }else {
                           $.messager.alert('温馨提示', '删除失败');
                           cpquery();
                       }

                   },
               })
           }})
   }
    function cpquery() {
        var uyear = $('#cpdb1').val().substr(0,4)
        var umonth  = $('#cpdb1').val().substr(5);
        var plant = $('#cp-Plant').combobox('getText');
        var fname = $('#cp_Fname').val();
        var WorkCentre = $('#cp_WorkCentre').val();
        var OrderLine = $('#cp_OrderLine').val();
        var fno = $('#cp_Fno').val();
        var state = $('input[name="cp_ColdCheck"]:checked').val();
        var fdata;
        $.ajax({
            type: "post",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/MonthPlan/Serach2.action",//要发送的后台地址
            data: {
                uyear:uyear,
                umonth:umonth,
                plant:plant,
                fname:fname,
                state:state,
                name:name,
                WorkCentre:WorkCentre,
                fno:fno,
                OrderLine:OrderLine,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                $.messager.progress('close');
                console.log(data);
                fdata = data;
                $("#cp").datagrid({
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
                    width:'auto',
                    //fitColumns:true,
                    //fit:true,
                    method:'get',
                    data:fdata,
                    //url:"/Mplan/query.action?uyear="+uyear+"&&umouth="+umouth+"&&plant="+plant+"&&dhorderno="+dhorderno+"&&PartDrawing="+PartDrawing+"&&fname="+fname+"",
                    columns:[[
                        {field:'id',title:'编码',width: '55px',align:'left',halign: 'center',hidden:'true'},
                        {field:'orderLine',title:'厂编合同号',width: '150px',align:'left',halign:'center'},
                        {field:'partDrawing',title:'规格',width: '110px',align:'left',halign:'center'},
                        {field:'fno',title:'零件编码',width: '100px',align:'center',halign: 'center'},
                        {field:'fname',title:'零件描述',width: '220px',align:'left',halign: 'center'},
                        {field:'workCentre',title:'打印标记',width:'70px',align:'center',halign: 'center'},
                        {field:'planNum',title:'计划数量',width: '70px',align:'right',halign: 'center'},
                        {field:'orderTime',title:'交货期',width: '90px',align:'right',halign: 'center'},
                        {field:'over',title:'完成情况',width: '55px',align:'center',halign: 'center'},
                        {field:'workprocedure',title:'工序',width: '160px',align:'center',halign: 'center'},
                        {field:'uyear',title:'年度',width: '55px',align:'center',halign: 'center'},
                        {field:'umouth',title:'月度',width: '55px',align:'center',halign: 'center'},
                        {field:'plant',title:'事业部',width: '70px',align:'center',halign: 'center'},
                    ]],
                    pagination:true,
                });
                $('#cp').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
            },
            error: function (msg) {//ajax请求失败后触发的方法
                alert(msg);//弹出错误信息
            }

        });
        $('#cp').datagrid({
            rowStyler: function (index, row) {
                var over = row.over;
                if (over=='完成') {
                    return 'background-color:#008B45;color:white';
                }else if(over=='Yes' ){
                    return 'background-color:#808000 ;color:white;';
                }
            }
        });
        $('#cp').datagrid('loadData',{total:0,rows:[]});


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
      function cpmonp_add() {
          var date=new Date();
          var myDate = new Date();
          var uyear = myDate.getFullYear();
          var umouth  = myDate.getMonth()+1;
          var uday = myDate.getDate();
          var uhour = myDate.getHours();
          var umin = myDate.getMinutes();
          var ums = myDate.getSeconds();
          var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
          var plant = localStorage.getItem("Department");
          var planyear = date.getFullYear();
          var planmonth = date.getMonth()+1;
//          var planyear = $("#monp_db").val().substring(0,4);
//          var planmonth = $("#monp_db").val().substring(5,7);
          var upload = new Ext.form.FormPanel({
              frame: true,
              labelWidth: 100,
              labelAlign: 'right',
              fileUpload: true,
              border: true,
              defaults: {
                  width: 200,
                  allowBlank: false,
                  blankText: '该项不能为空！'
              },
              items: [{
                  xtype: 'displayfield',
                  value: '上传文件为[*.xls]&nbsp;&nbsp;&nbsp;&nbsp;'
//                '<a href="javascript:;" onclick="monp_download_log();" style="color: green;">模版下载</a>'
              }, {
                  id: 'formFile',
                  fieldLabel: "导入文件",
                  name: 'uploadFile',
                  params: {
                      "umouth": planmonth,
                      "User": localStorage.getItem("User"),
                  },
                  xtype: 'textfield',
                  fileUpload: true,
                  inputType: 'file',
                  listeners: {
                      render: function () {
                          Ext.get('formFile').on("change", function () {
                              var file = this.getValue();
                              var fs = file.split('.');
                              if (fs[fs.length - 1].toLowerCase() == 'xls') {
                                  Ext.MessageBox.show({
                                      title: '信息',
                                      msg: '<font color="green">确定要上传文件:' + file + '？</font>',
                                      params: {
                                          "year": planyear,
                                          "month":planmonth,
                                          "User": localStorage.getItem("User"),
                                          plant:plant,
                                          time:time,
//                                          "mpupinst": $('input[name="adminFlag"]:checked').val()
                                      },
                                      width: 300,
                                      buttons: {'ok': '确定', 'no': '取消'},
                                      icon: Ext.MessageBox.WARNING,
                                      closable: false,
                                      fn: function (e) {
                                          if (e == 'ok') {
                                              if (upload.form.isValid()) {
                                                  upload.getForm().submit({

                                                      url: '${ctxPath}/ContractPlan/import.action',
                                                      method: 'POST',
                                                      params: {
                                                          "year": planyear,
                                                          "month":planmonth,
                                                          "User": localStorage.getItem("User"),
                                                           plant:plant,
                                                          time:time,
                                                      },
                                                      waitTitle: '系统提示',
                                                      waitMsg: '正在上传,请稍后...',
                                                      success: function (form, action) {
                                                          console.log(action);
                                                          var msg = action.result.message;
                                                          Ext.MessageBox.show({
                                                              title: '信息',
                                                              width: 250,
                                                              msg: msg,
                                                              buttons: {'ok': '确定', 'no': '取消'},
                                                              icon: Ext.MessageBox.INFO,
                                                              closable: false,
                                                              fn: function (e) {
                                                                  if (e == 'ok') {
                                                                      win.close();
                                                                      cpquery();
                                                                  } else {
                                                                      Ext.getCmp('formFile').setValue('');
                                                                  }
                                                              }
                                                          });
                                                      }
                                                  });
                                              }
                                              else {
                                                  Ext.MessageBox.show({
                                                      title: '信息',
                                                      width: 200,
                                                      msg: '请填写完成再提交!',
//                                            animEl:'insert.win.info',
                                                      buttons: {'ok': '确定'},
                                                      icon: Ext.MessageBox.ERROR,
                                                      closable: false
                                                  });
                                              }
                                          }
                                      }
                                  });
                              } else {
                                  Ext.MessageBox.show({
                                      title: '信息',
                                      width: 200,
                                      msg: '上传文件格式不对,请重新选择!',
                                      buttons: {'ok': '确定'},
                                      icon: Ext.MessageBox.ERROR,
                                      closable: false,
                                      fn: function (e) {
                                          if (e == 'ok') {
                                              Ext.getCmp('formFile').setValue('');
                                          }
                                      }
                                  });
                              }
                          });
                      }
                  }
              }]
          });
          var win = new Ext.Window({
              title: '上传',
              width: 400,
              height: 150,
              layout: 'fit',
              modal: true,
              items: [upload],
              bbar: ['->', {
//    		id:'insert.win.info',
//    		text:'上传',
//    		handler:function(){
//
//    		}
//    	},{
                  text: '关闭',
                  handler: function () {
                      win.close();
                  }
              }]
          }).show();
      }
      function cpmonp_export() {
          var myDate = new Date();
          var uyear = $('#cpdb1').val().substr(0,4)
          var umonth  = $('#cpdb1').val().substr(5);
          var plant = $('#cp-Plant').combobox('getText');
          var fname = $('#cp_Fname').val();
          var WorkCentre = $('#cp_WorkCentre').val();
          var OrderLine = $('#cp_OrderLine').val();
          var fno = $('#cp_Fno').val();
          var state = $('input[name="cp_ColdCheck"]:checked').val();
          var url = "../${ctxPath}/Export/CpmonpExport?uyear="+uyear+"&umonth="+umonth+"&plant="+plant+"&WorkCentre="+WorkCentre+"&OrderLine="+OrderLine+"&fno="+fno+"&state="+state+"&fname="+fname+"";
          window.location.href = url;
      }

</script>


