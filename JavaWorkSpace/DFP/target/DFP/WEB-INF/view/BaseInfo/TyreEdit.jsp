<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-06-16
  Time: 13:09//轮胎参数
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script type="text/javascript" src="${ctxPath }/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctxPath }/static/css/1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctxPath }/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>
<style>
    .easyui-panel {
        width: 100%;
        height: 66%;
    }


    .A{
        width:100%;
        height:75%;
    }
    .divmore{
        margin-left: -5px;
        padding: 10px 10px 10px 10px;
        /*border: 1px solid red;*/
        border-right: 1px solid #E0EEEE;
        border-bottom: 1px solid #E0EEEE;
    }
    .datagrid-row-selected {

        color: #1A1A1A;
        font-weight:bold;
        font-size: 300%;
    }
    .C{
        width:44%;
        height:75%;
    }
    .ti9{
        letter-spacing:0.17em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-0.13em; /*同上*/
    }
    .ti10{
        letter-spacing:0.4em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-0.1em; /*同上*/
    }
    .ti3{
        letter-spacing:1.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        /*margin-ttright:-1.25em; !*同上*!*/
    }
    .ti2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-ttright:-2em; /*同上*/
    }
    .ti5{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.1em; /*同上*/
    }
    .ti6{
        letter-spacing:0.85em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-0.1em; /*同上*/
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<html>
<body class="easyui-layout">
<div class="easyui-layout" data-options="fit:true">
    <div class="easyui-panel"title="添加/修改发动机数据" data-options="fit:true">
        <div id="pttoolbar" style="overflow:auto;width:100%;height:100%">
            <div class="wu-toolbar-button">
                <div id="test5"><input  id ="qadb" style="width:110px" class="easyui-text" hidden="hidden"></div>
            </div>
            <div class="wu-toolbar-search" style="white-space:nowrap;margin-top: 1%;text-align: left">
                <table style="border-collapse:separate; border-spacing:10px 20px; font-size: 15px;text-align: center" >
                    <tr>
                        <td><span class="bi1">厂内机型</span>：<input name="Infname" id="ZMACH4" class="easyui-textbox" style="width: 150px;height: 25px"  /></td>
                    </tr>
                    <tr>
                        <td><span class="bi1">轮胎位置</span>：<input name="Inlocation"  id="Tyresize" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                    </tr>
                    <tr>
                        <td><span class="bi1">轮胎型号</span>：<input name="Inlocation"  id="TireSpect" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                    </tr>
                    <tr>
                        <td><span class="bi2">轮距</span>：<input name="Inlocation"  id="Wheelsize" class="easyui-textbox" style="width: 150px;height: 25px"    /></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#test5" ).css("display", "none");
    var ids = '';
    $(function () {
        var db = $('#qadb');
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
        getplant2();
        $("#treepmb").tree({
            url: '${pageContext.request.contextPath}/Tractor/query2.action',
            animate:true,
            lines:true,
            onClick: function (node) {
                //右侧跳转到指定页面
//                addTab(node.text,node.menuUrl);
                i = node.text;
            },
            loadFilter:function(data){
                console.log(data);
                if(data.text){
                    return data.text ;
                }else{
                    return data ;
                }
            }
        });
    })
    $("#treepmb").tree({
        onClick:function(node){
            i = node.text;
            Query();
        }
    });
    function getplant2() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                getplant();
                if(window.parent.idm!=''){
                    ids = window.parent.idm;
                    $('#ZMACH4').textbox("setValue",window.parent.ZMACH);
                    $('#Tyresize').textbox("setValue",window.parent.Tyresize);
                    $('#Wheelsize').textbox("setValue",window.parent.Wheelsize);
                    $('#TireSpect').textbox("setValue",window.parent.TireSpect);
                }else {
                    $('#ZMACH4').textbox("setValue",'');
                    $('#Tyresize').textbox("setValue",'');
                    $('#Wheelsize').textbox("setValue",'');
                    $('#TireSpect').textbox("setValue",'');
                }
            }
        });
    }

    function TyreEdit() {
        j = 3;
        parent.$.modalDialog.handler.dialog('close');
    }
    function Save2() {
        var  ZMACH = $('#ZMACH4').val();
        var  Tyresize = $('#Tyresize').val();
        var  Wheelsize = $('#Wheelsize').val();
        var  TireSpect = $('#TireSpect').val();
        if(ZMACH!=''||Tyresize!=''||Wheelsize!=''||TireSpect!=''){
            jQuery.ajax({
                type: "POST",   //post提交方式默认是get
                url:'${pageContext.request.contextPath}/Tractor/Insert3.action',
                dataType: "json",
                data: {
                    time:time,
                    name:name,
                    ZMACH:ZMACH,
                    Tyresize:Tyresize,
                    Wheelsize:Wheelsize,
                    plant: localStorage.getItem("Department"),
                    TireSpect:TireSpect,
                    i:i,
                    id:ids,
                },
//                data:$("#login").val(),   //序列化
                error: function (request) {      // 设置表单提交出错
                    $("#showMsg").html(request);  //登录错误提示信息

                },
                success: function (data) {
                    if(data.num>0){
                        $.messager.alert('温馨提示', '保存成功!!!');
                        ids = '';
                        idm = '';
                        Query();
                        TyreEdit();
                        var node = $('#treepmb').tree('find', j);//找到id为”tt“这个树的节点id为”1“的对象
                        $('#treepmb').tree('select', node.target);//设置选中该节点
                    }


                }
            });
        }else {
            $.messager.alert("温馨提示","数据不能为空!");
        }
    }
    function getplant() {
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${pageContext.request.contextPath}/Tractor/query.action',
            dataType: "json",
            data: {
                plant: localStorage.getItem("Department")
            },
//                data:$("#login").val(),   //序列化
            error: function (request) {      // 设置表单提交出错
                $("#showMsg").html(request);  //登录错误提示信息

            },
            success: function (data) {
                $('#BWERKS').combobox('loadData', data);

            }
        });
    }
</script>
</body>
</html>