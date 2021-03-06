<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-05-14
  Time: 10:34//设备点检
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


    .A{
        width:100%;
        height:75%;
    }
    .datagrid-row-selected {

        color: #1A1A1A;
        font-weight:bold;
        font-size: 300%;
    }
    #triangle {
        height: 0;
        width: 0;
        border-right: 10px solid transparent;
        border-bottom: 10px solid darkgoldenrod;
        border-left: 10px solid transparent;
    }
    #circle {
        width: 15px;
        height: 15px;
        background: green;
        -moz-border-radius: 50px;
        -webkit-border-radius: 50px;
        border-radius: 50px;
        margin-left: 3px;
    }

    #square {
        width: 15px;
        height: 15px;
        background: red;
        margin-left: 3px;
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
        height: calc(100% - 60px);
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>

<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="设备点检" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height: 60px">
            <div class="wu-toolbar-button">

            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap">
                <table>
                    <tr><td> <label>年月：</label><input  id ="eqmdb1" style="width:100px" class="easyui-datebox">&nbsp</td>
                        <td>事业部： <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="epmPlant" panelHeight="auto" data-options="
                                valueField:'Fname',
                                textField:'Fremark',
                                panelHeight:'250'"
                                         style="width:100px">
                        </select></td>
                        <td><label>设备ID：</label><select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="qmEquipID" panelHeight="auto" data-options="
                                valueField:'EquipID',
                                textField:'EquipID',
                                panelHeight:'250'"
                                                       style="width:100px">
                        </select>&nbsp</td>
                        <td><a href="#" class="easyui-linkbutton"  onclick="qm_query()" data-options="iconCls:'icon-search'">查询</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="easyui-layout haorooms"  >
            <div class="A" data-options="region:'west',split:true" >
                <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                    <div style="width: 100%;height:53%" data-options="region:'center'" title="设备点检(  绿圆表示完好、黄三角表示检修中、红框表示异常)">
                        <div style="margin-top: 1%"></div>
                        <div id="ZT" style="height: 30px;width: auto;text-align:justify;">
                            <label style="font-size: 0.15rem;vertical-align:middle;display:inline-block;">部门：</label><span id="department"style="width: auto;vertical-align:middle;height: 100px;font-size: 0.16rem"></span>
                            <input style="width: 8%;border: 0px;" readonly>
                            <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">设备编号：</label><span id="EquipmentID" style="width: auto;height: 100px;vertical-align:middle;font-size:0.16rem"></span>
                            <input style="width: 8%;border: 0px;" readonly>
                            <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">设备名称：</label><span id="EquipmentName" style="width: auto;height: 100px;vertical-align:middle;font-size: 0.16rem"></span>
                            <input style="width: 8%;border: 0px;" readonly>
                            <label style="font-size:  0.15rem;;vertical-align:middle;display:inline-block;">设备型号：</label><span id="EquipmentSize" style="width: auto;height: 100px;vertical-align:middle;font-size:0.16rem"></span>
                            <input style="width: 8%;border: 0px;" readonly>
                            <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">设备员：</label><span id="Equipmentpersonnel" style="width: auto;height: 100px;vertical-align:middle;font-size: 0.16rem"></span>
                        </div>
                        <table id="eqm" class="easyui-datagrid" style="white-space: nowrap;height: 91%"  data-options="singleSelect:true"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    (function(doc, win) {
        var docEl = doc.documentElement,
            resizeEvt = 'orientationchange' in window ? 'orientationchange': 'resize',
            recalc = function() {
                var clientWidth = docEl.clientWidth;
                if (!clientWidth) return;
                docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
            };


        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);//定义rem
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        $('#eqmdb1').val(year+"-"+month);
        var db = $('#eqmdb1');
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

        $("#epmPlant").combobox({
            //相当于html >> select >> onChange事件
            onChange: function () {
                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url:'${ctxPath }/PersonnelMaintenance/selectDevice1.action',
                    dataType: "json",
                    data: {
                        plant:  $('#epmPlant').combobox('getValue')
                    },
//                data:$("#login").val(),   //序列化
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息
                    },
                    success: function (data) {
                        console.log(data);
                        $('#qmEquipID').combobox('loadData', data);
                    }
                });
            }
        });
//        $("#ptdb").datebox({
//            //相当于html >> select >> onChange事件
//            onChange: function () {
//                ptcolor();
//            }
//        });

        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/PersonnelMaintenance/query1.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#epmPlant').combobox('loadData', data);
                //alert(11111);

            }
        });

    });

        function qm_query() {
            var a = 0;
            var b = 0;
            var c = 0;
            var d = 0;
            var e = 0;
        var uyear = $('#eqmdb1').val().substr(0,4);;
        var umouth  = $('#eqmdb1').val().substr(5);
        var EquipID = $('#qmEquipID').combobox('getValue');
        var fdata;
         if(EquipID!=""){
             $.ajax({
                 type: "post",//数据发送的方式（post 或者 get）
                 url: "${ctxPath}/PersonnelMaintenance/Info.action",//要发送的后台地址
                 data: {
                     umouth:umouth,
                     EquipID:EquipID,
                     uyear:uyear
                 },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
                 dataType: "json",//后台处理后返回的数据格式
                 success: function (data) {//ajax请求成功后触发的方法
                     $.messager.progress('close');
                     console.log(data);
                     fdata = data;
                     a = data.department;
                     b = data.EquipID;
                     c = data.EquipName;
                     d = data.EquipType;
                     e = data.EquipMan;
                     $("#eqm").datagrid({
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
                             {field:'size',title:'点检项目',width: '420px',align:'left',halign: 'center',
                                 formatter: function(value) {
                                     if (value =="XM01") {
                                         return "<span style='font-size: 15px'>1、各操作系统动作是否灵敏、可靠</span>";
                                     } else if (value =="XM02") {
                                         return "<span style='font-size: 15px'>2、防护装置是否齐全、有效</span>";
                                     }
                                     else if (value =="XM03") {
                                         return "<span style='font-size: 15px'>3、传动部位运转是否正常，声音是否异常</span>";
                                     }
                                     else if (value =="XM04") {
                                         return "<span style='font-size: 15px'>4、滑动部位运转是否正常，有无拉、研、碰伤</span>";
                                     }
                                     else if (value =="XM05") {
                                         return "<span style='font-size: 15px'>5、润滑系统油路是否通畅,油标是否显示缺油，润滑是否良好</span>";
                                     }
                                     else if (value =="XM06") {
                                         return "<span style='font-size: 15px'>6、电器装置是否齐全，动作是否可靠，有无断线、断接</span>";
                                     }
                                     else if (value =="XM07") {
                                         return "<span style='font-size: 15px'>7、设备内外清洁度如何，有否进行清扫</span>";
                                     }else {
                                         return "";
                                     }
                                 }},
                             {field:'one',title:'1',width: '30px',align:'center',halign: 'center',
                                                    formatter: function(value) {
                                if (value=="0") {
                                    return "";
                                } else if (value=="1"){
                                    return "<div id='circle' style='text-align: center'></div>";
                                } else if (value=="2"){
                                    return "<div id='triangle' style='text-align: center'></div>";
                                } else if (value=="3"){
                                    return "<div id='square' style='text-align: center'></div>";
                                }
                            }},
                             {field:'two',title:'2',width: '30px',align:'center',halign:'center',
                                 formatter: function(value) {
                                     if (value=="0") {
                                         return "";
                                     } else if (value=="1"){
                                         return "<div id='circle' style='text-align: center'></div>";
                                     } else if (value=="2"){
                                         return "<div id='triangle' style='text-align: center'></div>";
                                     } else if (value=="3"){
                                         return "<div id='square' style='text-align: center'></div>";
                                     }
                                 }},
                             {field:'three',title:'3',width: '30px',align:'center',halign:'center',
                                 formatter: function(value) {
                                     if (value=="0") {
                                         return "";
                                     } else if (value=="1"){
                                         return "<div id='circle' style='text-align: center'></div>";
                                     } else if (value=="2"){
                                         return "<div id='triangle' style='text-align: center'></div>";
                                     } else if (value=="3"){
                                         return "<div id='square' style='text-align: center'></div>";
                                     }
                                 }},
                             {field:'four',title:'4',width: '30px',align:'center',halign: 'center',
                                 formatter: function(value) {
                                     if (value=="0") {
                                         return "";
                                     } else if (value=="1"){
                                         return "<div id='circle' style='text-align: center'></div>";
                                     } else if (value=="2"){
                                         return "<div id='triangle' style='text-align: center'></div>";
                                     } else if (value=="3"){
                                         return "<div id='square' style='text-align: center'></div>";
                                     }
                                 }},
                             {field:'five',title:'5',width: '30px',align:'center',halign: 'center',
                                 formatter: function(value) {
                                     if (value=="0") {
                                         return "";
                                     } else if (value=="1"){
                                         return "<div id='circle' style='text-align: center'></div>";
                                     } else if (value=="2"){
                                         return "<div id='triangle' style='text-align: center'></div>";
                                     } else if (value=="3"){
                                         return "<div id='square' style='text-align: center'></div>";
                                     }
                                 }},
                             {field:'six',title:'6',width: '30px',align:'center',halign: 'center',
                                 formatter: function(value) {
                                     if (value=="0") {
                                         return "";
                                     } else if (value=="1"){
                                         return "<div id='circle' style='text-align: center'></div>";
                                     } else if (value=="2"){
                                         return "<div id='triangle' style='text-align: center'></div>";
                                     } else if (value=="3"){
                                         return "<div id='square' style='text-align: center'></div>";
                                     }
                                 }},
                             {field:'seven',title:'7',width: '30px',align:'center',halign: 'center',
                                 formatter: function(value) {
                                     if (value=="0") {
                                         return "";
                                     } else if (value=="1"){
                                         return "<div id='circle' style='text-align: center'></div>";
                                     } else if (value=="2"){
                                         return "<div id='triangle' style='text-align: center'></div>";
                                     } else if (value=="3"){
                                         return "<div id='square' style='text-align: center'></div>";
                                     }
                                 }},
                             {field:'eight',title:'8',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'nine',title:'9',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'ten',title:'10',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'eleven',title:'11',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twelve',title:'12',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'thirteen',title:'13',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'fourteen',title:'14',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'fifteen',title:'15',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'sixteen',title:'16',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'seventeen',title:'17',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'eighteen',title:'18',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'nineteen',title:'19',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twenty',title:'20',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentyone',title:'21',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentytwo',title:'22',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentythree',title:'23',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentyfour',title:'24',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentyfive',title:'25',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentysix',title:'26',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentyseven',title:'27',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentyeight',title:'28',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'twentynine',title:'29',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'thirty',title:'30',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                             {field:'thirtyone',title:'31',width: '30px',align:'center',halign: 'center', formatter: function(value) {
                                 if (value=="0") {
                                     return "";
                                 } else if (value=="1"){
                                     return "<div id='circle' style='text-align: center'></div>";
                                 } else if (value=="2"){
                                     return "<div id='triangle' style='text-align: center'></div>";
                                 } else if (value=="3"){
                                     return "<div id='square' style='text-align: center'></div>";
                                 }
                             }},
                         ]],
                     });
                     $('#eqm').datagrid({loadFilter: CZRK_pagerFilter}).datagrid('loadData', fdata);
                     document.getElementById("department").innerHTML = a;
                     document.getElementById("EquipmentID").innerHTML = b;
                     document.getElementById("EquipmentName").innerHTML = c;
                     document.getElementById("EquipmentSize").innerHTML = d;
                     document.getElementById("Equipmentpersonnel").innerHTML = e;
                 },
                 error: function (msg) {//ajax请求失败后触发的方法
                     alert(msg);//弹出错误信息
                 }

             });


             $('#eqm').datagrid('loadData',{total:0,rows:[]});
         }  else {
             $.messager.alert("温馨提示", "请选择设备ID!!!");
         }


//        $('#Mmid').datagrid('loadData',{total:0,rows:[]});

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
    $('#eqm').datagrid({
        onClickCell: function(index,field,value){
            var count =field;
            var uyear = $('#eqmdb1').val().substr(0,4);;
            var umouth  = $('#eqmdb1').val().substr(5);
            var EquipID = $('#qmEquipID').combobox('getValue');
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${ctxPath }/PersonnelMaintenance/select.action',
                dataType: "json",
                data: {
                    count:count,
                    uyear:uyear,
                    umouth:umouth,
                    EquipID:EquipID
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                     var q = " <label style=\"font-size: 15px;vertical-align:middle;display:inline-block;\">点检人：" +
                         "</label><span style=\"width: auto;vertical-align:middle;height: 100px;font-size: 20px\">"+ data.Man+"</span>"+"<br>"+"<hr>" +" <label style=\"font-size: 15px;vertical-align:middle;display:inline-block;\">点检时间：</label>" +
                         "<span style=\"width: auto;vertical-align:middle;height: 100px;font-size: 20px\">"+ data.date+"</span>";

                     if(data.Man!=""&&data.date!=""){
                         $.messager.show({
                             width: 450,
                             height: 140,
                             title:'点检明细',
                             msg: q,
                             timeout:5000,
                             showType:null,
                             style:{
                             }
                         });
                     }else {
                         $.messager.show({
                             width: 300,
                             height: 100,
                             title:'点检明细',
                             msg: '未进行设备点检',
                             timeout:5000,
                             showType:null,
                             style:{
                             }
                         });
                     }


                }
            });
        }
    });
</script>





