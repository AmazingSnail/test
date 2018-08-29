<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    .w3{
        letter-spacing:0.5em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.5em; /*同上*/
    }
    .w2{
        letter-spacing:2em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-2em; /*同上*/
    }
</style>
<div class="easyui-layout" data-options="fit:true" style="width: 100%">
    <div data-options="region:'center'" style="height:76%; width: 100%">
        <!-- Begin of toolbar -->
        <div class="easyui-panel" title="操作栏" style="height: 100px">
            <div id="monplan-toolbar">
                <div class="wu-toolbar-button">
<shiro:hasPermission name="/monp/uploadForm">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-table-add" onclick="monp_uploadForm()"
                           plain="true">导入</a>
</shiro:hasPermission>
                    <!--<a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="openAdd()" plain="true">打印</a>-->
<shiro:hasPermission name="/monp/export1">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-table-go" onclick="monp_export1()" plain="true">导出</a>
</shiro:hasPermission>
                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                    <span class="radioSpan">
                        <input class="easyui-validatebox" type="radio" name="adminFlag" value="0">追加及更新</input>
                        <input class="easyui-validatebox" type="radio" name="adminFlag" value="1">重新导入</input>
                    </span>
                </div>
                <div class="wu-toolbar-search">
                    <form id="loginForm" method="post">
                        <table class="APtableborder">
                            <tr>
                                <td><label>计划日期：</label></td><td><input id="monp_db" style="width:100px"/></td>
                                <%--<td><label>事业部：</label>--%>
                                    <%--<select class="easyui-combobox" name="Plant" datatype="text" id="monplanPlant"--%>
                                            <%--panelHeight="auto" data-options="--%>
                                            <%--method:'get',--%>
                                            <%--valueField:'remark',--%>
                                            <%--textField:'Fname',--%>
                                            <%--panelHeight:'auto'"--%>
                                            <%--style="width:100px">--%>
                                    <%--</select></td>--%>
                                <td><label>冷卷物料代码：</label></td><td><input id="monp_fno" name="fno"
                                                                          class="easyui-textbox"    style="width:100px" onkeypress="monp_getKey()"></td>
                                <td><label>冷卷物料描述：</label></td><td><input id="monp_fname" class="easyui-textbox" name="fname" style="width:100px" onkeypress="monp_getKey()"></td>
                                <td width="20px"></td>
                                <td><a href="#" class="easyui-linkbutton"  onclick="monp_forGetDate()" data-options="iconCls:'icon-search'">查询</a></td>
                                <%--<td><a href="#" class="easyui-linkbutton"  onclick="monp_showMore()" data-options="iconCls:'icon-search'">更多</a></td>--%>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>

        </div>
        <!-- End of toolbar -->
        <div style="height: calc(100% - 100px)">
            <table title="月度计划"
                   id="monp_treegrid"
                   class="easyui-treegrid" data-options="singleSelect:true,
                   fitColumns: true,
                    rownumbers: true,
                   idField: 'fnohiddon',
                   treeField: 'fno',
                   onContextMenu:monp_onContextMenu,
                    "
                   style="height:100%" toolbar="#monp_tb">
            </table>
        </div>
        <div id="monp_tb">
            <div>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="monp_collapseAll()">全部收起</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="monp_expandAll()">全部展开</a>
            </div>
        </div>
        <div id="monp_mm" class="easyui-menu" style="width:120px;">
<shiro:hasPermission name="/monp/append">
            <div onclick="monp_append()" data-options="iconCls:'icon-add'">添加下级</div>
</shiro:hasPermission>
<shiro:hasPermission name="/monp/removeit">
            <div onclick="monp_removeit()" data-options="iconCls:'icon-remove'">删除</div>
</shiro:hasPermission>
            <div class="menu-sep"></div>
<shiro:hasPermission name="/monp/update">
            <div onclick="monp_update()">修改</div>
</shiro:hasPermission>
        </div>
        <div id="monp_listadd" class="easyui-dialog" title="添加下级物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:500px;height:350px;padding:10px">
            <from id="monp_listaddfrom">
                <table cellpadding="5" width="auto" style="white-space:nowrap" >
                    <td>
                        <tr>
                            <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="monp_fromfno"  style="width:150px" data-options="required:'true'"></input></td>
                            <td>物料描述:<input class="easyui-textbox" type="text" name="fname" id="monp_fromfname" style="width:150px" data-options="required:'true'"></input></td>
                        </tr>
                        <tr>
                            <td>计划重量:<input class="easyui-textbox" type="text" name="fromplanweidgt" id="monp_fromplanweidgt" style="width:150px" data-options="required:'true'"></input></td>
                            <td>上级编码:<input class="easyui-textbox" type="text" name="fparentid" id="monp_fparentid" style="width:150px" disabled=true ></input></td>
                        </tr>
                        <tr>
                            <td><span class="w3">输送链</span>:<input class="easyui-textbox" type="text" name="ssl" id="monp_fromssl" style="width:150px"></input></td>
                            <td><span class="w3">汽车链</span>:<input class="easyui-textbox" type="text" name="qcl" id="monp_fromqcl" style="width:150px" ></input></td>
                        </tr>
                        <tr>
                            <td><span class="w3">农机链</span>:<input class="easyui-textbox" type="text" name="njl" id="monp_fromnjl" style="width:150px" ></input></td>
                            <td><span class="w3">传动链</span>:<input class="easyui-textbox" type="text" name="cdl" id="monp_fromcdl" style="width:150px" ></input></td>
                        </tr>
                        <tr>
                            <td>工程总部:<input class="easyui-textbox" type="text" name="gclzb" id="monp_fromgclzb" style="width:150px" ></input></td>
                            <td><span class="w3">板式链</span>:<input class="easyui-textbox" type="text" name="bsl" id="monp_frombsl" style="width:150px"  ></input></td>
                        </tr>
                        <tr>
                            <td><span class="w3">扶梯链</span>:<input class="easyui-textbox" type="text" name="ftl" id="monp_fromftl" style="width:150px" ></input></td>
                            <td>工程兴化:<input class="easyui-textbox" type="text" name="gclxh" id="monp_fromgclxh" style="width:150px"  ></input></td>
                        </tr>
                        <tr>
                            <td>摩托车链:<input class="easyui-textbox" type="text" name="mtcl" id="monp_frommtcl" style="width:150px" ></input></td>
                            <td><span class="w3">项目部</span>:<input class="easyui-textbox" type="text" name="xmb" id="monp_fromxmb" style="width:150px" ></input></td>
                        </tr>
                        <tr>
                            <td><span class="w2">盾牌</span>:<input class="easyui-textbox" type="text" name="dp" id="monp_fromdp" style="width:150px" ></input></td>
                        </tr>
                        <table>
                        <tr>
                            <td width="500px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="monp_listAdd()" id="monp_listAddbutton" data-options="iconCls:'icon-save'" >保存</a></td>
                        </tr>
                        </table>
                    </td>
                </table>
            </from>
        </div>
        <div id="monp_listupdate" class="easyui-dialog" title="修改下级物料" data-options="iconCls:'icon-save',closed:true," style="text-align: center;width:500px;height:350px;padding:10px">
            <from id="monp_listupdatefrom">
                <table cellpadding="5" width="auto" style="white-space:nowrap" >
                    <td>
                        <tr>
                            <tr>
                                <td><span>物料编码</span>:<input class="easyui-textbox" type="text" name="fno" id="monp_updatefno"  style="width:150px" disabled=true></input></td>
                                <td>物料描述:<input class="easyui-textbox" type="text" name="fname" id="monp_updatename" style="width:150px" disabled=true></input></td>
                            </tr>
                            <tr>
                                <td>计划重量:<input class="easyui-textbox" type="text" name="planweidgt" id="monp_updatefromplanweidgt" style="width:150px" data-options="required:'true'"></input></td>
                                <td>上级编码:<input class="easyui-textbox" type="text" name="fparentid" id="monp_updatefparentid" style="width:150px" disabled=true ></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">输送链</span>:<input class="easyui-textbox" type="text" name="ssl" id="monp_updatefromssl" style="width:150px"></input></td>
                                <td><span class="w3">汽车链</span>:<input class="easyui-textbox" type="text" name="qcl" id="monp_updateqcl" style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">农机链</span>:<input class="easyui-textbox" type="text" name="njl" id="monp_updatenjl" style="width:150px" ></input></td>
                                <td><span class="w3">传动链</span>:<input class="easyui-textbox" type="text" name="cdl" id="monp_updatecdl" style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td>工程总部:<input class="easyui-textbox" type="text" name="gclzb" id="monp_updategclzb" style="width:150px" ></input></td>
                                <td><span class="w3">板式链</span>:<input class="easyui-textbox" type="text" name="bsl" id="monp_updatebsl" style="width:150px"  ></input></td>
                            </tr>
                            <tr>
                                <td><span class="w3">扶梯链</span>:<input class="easyui-textbox" type="text" name="ftl" id="monp_updateftl" style="width:150px" ></input></td>
                                <td>工程兴化:<input class="easyui-textbox" type="text" name="gclxh" id="monp_updategclxh" style="width:150px"  ></input></td>
                            </tr>
                            <tr>
                                <td>摩托车链:<input class="easyui-textbox" type="text" name="mtcl" id="monp_updatemtcl" style="width:150px" ></input></td>
                                <td><span class="w3">项目部</span>:<input class="easyui-textbox" type="text" name="xmb" id="monp_updatexmb" style="width:150px" ></input></td>
                            </tr>
                            <tr>
                                <td><span class="w2">盾牌</span>:<input class="easyui-textbox" type="text" name="dp" id="monp_updatedp" style="width:150px" ></input></td>
                            </tr>
                            <input class="easyui-textbox" type="hidden" name="id" id="monp_updateid"  />
                        </tr>
                        <table>
                        <tr >
                            <td width="500px"><a class="easyui-linkbutton" type="text" style="width: 130px" name="Save" onclick="monp_listUpdate()" id="spm_listupdatebutton" data-options="iconCls:'icon-save'" >修改</a></td>
                        </tr>
                        </table>
                    </td>
                </table>
            </from>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
//        $("input[name='adminFlag']").attr('checked', true);
        $("input[name='adminFlag'][value='0']").attr("checked", true);
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        $('#monp_db').val(year + "-" + month);
        //初始加载，表格宽度自适应
        $(document).ready(function () {
            fitCoulms();
        });
        //浏览器窗口大小变化后，表格宽度自适应
        $(window).resize(function () {
            fitCoulms();
        });
        var db = $('#monp_db');
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
            formatter: function (d) {
                return d.getFullYear() + '-' + (d.getMonth() + 1);
                /*getMonth返回的是0开始的，忘记了。。已修正*/
            }
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
                var now = new Date();
                db.datebox('hidePanel').datebox('setValue', now.getFullYear() + '-' + (now.getMonth() + 1));
            });
        }

        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            dataType: "json",
            url: '${ctxPath }/PlanProductController/Plantquery',
            data: {
                Department: localStorage.getItem('Department'),
            },
            error: function (request) {      // 设置表单提交出错
                alert("252 cuowu 1111")
                $.messager.alert('信息提示', '出错了！', 'info');
            },
            success: function (results) {
                $('#monplanPlant').combobox('loadData', results);
            }
        });
    });

    function monp_getKey() {
        if(event.keyCode==13){
            monp_forGetDate();
        }
    }
    function fitCoulms() {
        $('#MonPlandatagrid').datagrid({
            fitColumns: true
        });
    }

    /**
     * Name 载入菜单树
     */
    $('#wu-category-tree').tree({
        url: '',
        onClick: function (node) {
            alert(node.text);
        }
    });
    var editindex = "";

    function monp_export1() {
        var planyear = $("#monp_db").val().substring(0,4);
        var planmonth = $("#monp_db").val().substring(5,7);
        var fno=$("#monp_fno").val();
        var fname=$("#monp_fname").val();
        var url = "${ctxPath }/ColdMonthPlan/export.action?year=" + planyear + "&month=" + planmonth + "&fno=" + fno + "&fname=" + fname + "";
        window.location.href = url;
    }

    function monp_update(){
        var row = $("#monp_treegrid").treegrid("getSelected");
        if(row.fparentid!==null){
            $('#monp_listupdatefrom').form("clear");
            $('#monp_listupdatefrom').form('load',{
                id:row.id,
                fno:row.fno,
                fname:row.fname,
                plannum:row.plannum,
                planweidgt:row.planweidgt,
                fparentid:row.fparentid,
                ssl:row.ssl,
                qcl:row.qcl,
                njl:row.njl,
                cdl:row.cdl,
                gclzb:row.gclzb,
                bsl:row.bsl,
                ftl:row.ftl,
                gclxh:row.gclxh,
                mtcl:row.mtcl,
                xmb:row.xmb,
                dp:row.dp
            });
            $('#monp_listupdate').dialog('open');
        }else{
            $('#monp_listupdatefrom').form("clear");
            $('#monp_listupdatefrom').form('load',{
                id:row.id,
                fno:row.fno,
                fname:row.fname,
                plannum:row.plannum,
                planweidgt:row.planweidgt,
                fparentid:row.fparentid,
                ssl:row.ssl,
                qcl:row.qcl,
                njl:row.njl,
                cdl:row.cdl,
                gclzb:row.gclzb,
                bsl:row.bsl,
                ftl:row.ftl,
                gclxh:row.gclxh,
                mtcl:row.mtcl,
                xmb:row.xmb,
                dp:row.dp
            });
            $('#monp_listupdate').dialog('open');
        }
    }

    function monp_listUpdate(){
        var id = $("#monp_updateid").val();
        var planweidgt =  $("#monp_updatefromplanweidgt").val();
        var   ssl=$("#monp_updatefromssl").val();
        var   qcl=$("#monp_updateqcl").val();
        var   njl=$("#monp_updatenjl").val();
        var   cdl=$("#monp_updatecdl").val();
        var   gclzb=$("#monp_updategclzb").val();
        var   bsl=$("#monp_updatebsl").val();
        var  ftl=$("#monp_updateftl").val();
        var   gclxh=$("#monp_updategclxh").val();
        var   mtcl=$("#monp_updatemtcl").val();
        var   xmb=$("#monp_updatexmb").val();
        var   dp=$("#monp_updatedp").val();
        $.ajax({
            type: "post",
            data: {
                id:id,
                planweidgt: planweidgt,
                ssl:ssl,
                qcl:qcl,
                njl:njl,
                cdl:cdl,
                gclzb:gclzb,
                bsl:bsl,
                ftl:ftl,
                gclxh:gclxh,
                mtcl:mtcl,
                xmb:xmb,
                dp:dp
            },
            url: "${ctxPath }/ColdMonthPlan/update.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '修改成功!');

                    monp_forGetDate();

                    $('#monp_listupdate').dialog('close');
                }
            }
        })
    }
    function monp_forGetDate() {
        var planyear = $("#monp_db").val().substring(0,4);
        var planmonth = $("#monp_db").val().substring(5,7);
        $.messager.progress({
            title: '请稍后',
            msg: '页面加载中...'
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url: "${ctxPath }/ColdMonthPlan/selectColdMonthPlan.action",
            dataType: "json",
            data: {
                fno:$("#monp_fno").val(),
                fname:$("#monp_fname").val(),
                year:planyear,
                month:planmonth
            },
            error: function (request) {      // 设置表单提交出错
                alert("404 cuowu 2222")
                $.messager.progress('close');
                $.messager.alert('信息提示', '出错了！', 'info');
            },
            success: function (results) {
                $.messager.progress('close');
                console.log(results);
                $('#monp_treegrid').treegrid({

                    data: results,
//                    nowrap:false,
                    fit: false, //自动适屏功能
                    autoRowWidth: true,
                    showFooter: true,
                    loadMsg: '正在加载中，请稍等... ',
                    fitColumns: true,//宽度自适应
                    singleSelect: true,
                    remoteSort: false,
                    width: 'auto',
                    nowrap:false,
                    method: 'post',
                    columns: [[
                        {
                            field: 'id',
                            title: '编号',
                            width: '50px',
                            editor: 'text',
                            sortable: true,
                            remoteSort: false
                        },
                        {field: 'fno', title: '物料编码', width: '150px', editor: 'text'},
                        {field: 'fnohiddon', title: '物料编码', width: '150px', hidden:'true',editor: 'text'},
                        {field: 'fname', title: '物料描述', width: '240px', editor: 'text'},
                        {field: 'fnoname', title: '物料名称', width: '110px', editor: 'text'},
                        {
                            field: 'takeweidgt',
                            title: '已排重量',
                            width: '60px',
                            editor: 'text'
                        },
                        {
                            field: 'planweidgt',
                            title: '计划重量',
                            width: '100px',
                            editor: 'text',
                            sortable: true,
                            remoteSort: false
                        },
                        {field: 'progress', title: '完成进度', width: '210px',formatter:Progress,style:'50%'},
                        {field: 'ssl', title: '输送链', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'qcl', title: '汽车链', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'njl', title: '农机链', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'cdl', title: '传动链', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'gclzb', title: '工程链总部', width: '65px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'bsl', title: '板式链', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'ftl', title: '扶梯链', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'gclxh', title: '工程链兴化', width: '70px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'mtcl', title: '摩托车链', width: '65px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'xmb', title: '项目部', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'dp', title: '盾牌', width: '50px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'planman', title: '计划人员', width: '60px', editor: 'text', sortable: true, remoteSort: false},
                        {field: 'plandate', title: '计划时间', width: '140px', editor: 'text'},
                        {field: 'year', title: '年份', width: '50px', editor: 'text'},
                        {field: 'month', title: '月份', width: '50px'},
                        {field: 'plant', title: '事业部', width: '60px'},
                        {field: 'fparentid', title: '上级物料', width: '150px'},
                        {field: 'isdelete', title: '删除标识', width: '250px', editor: 'text'}
                    ]],
                    rowStyler:function(row){
                        var fparentid =row.fparentid;
                        if( fparentid === null ){
                            return 'background-color:#A4D3EE;font-weight:bold;';
                        }
                    },
                    pagination: true,
                    pageList: [10,25, 50, 100],
                    sortOrder: 'asc'
                });
            }
        });

    }
    function Progress(value){
        if (value){
            var Pcolor="#FF0000";
            if(Number(value)>50&&Number(value)<100){
                Pcolor="#EEB422";
            }else if(Number(value)==100||Number(value)>100){
                Pcolor="#32CD32";
            }

            var s = '<div style="width:100%;border:1px solid #ccc" class="easyui-progressbar \n' +
                'progressbar">' +
                '<div style="width:' + value + '%;background:'+Pcolor+';color: #000000;">' + value + '%' + '</div>'
            '</div>';
            return s;
        } else {
            return '0';
        }
    }
    function monp_collapseAll(){
        $('#monp_treegrid').treegrid('collapseAll');
    }
    function monp_expandAll(){
        $('#monp_treegrid').treegrid('expandAll');
    }

    function monp_append(){
        var row = $("#monp_treegrid").treegrid("getSelected");
        var fno= row.fno;
        $('#monp_listaddfrom').form("clear");
        $('#monp_listaddfrom').form('load',{
            fparentid:fno,
        });
        $('#monp_listadd').dialog('open');
    }
    function monp_removeit(){
        var row = $("#monp_treegrid").treegrid("getSelected");
        if(row.fparentid!==null){
            $.messager.confirm('温馨提示', '确定要删除'+row.fno+'物料吗？', function (r) {
                if (r) {
                    if (row.takenum>0){
                        $.messager.alert('温馨提示', '此计划已排产，不允许删除!');
                    }else{
                        jQuery.ajax({
                            type: "post",//数据发送的方式（post 或者 get）
                            url: "${ctxPath }/ColdMonthPlan/deleteChild.action",//要发送的后台地址
                            data: {
                                id : row.id
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    $.messager.alert('温馨提示', '删除成功!');

                                    monp_forGetDate();
                                }
                            }
                        })
                    }

                }
            })
        }else{
            $.messager.confirm('温馨提示', '即将删除整个毛料计划,请慎重考虑!', function (r) {
                if (r) {
                    if (row.takenum>0){
                        $.messager.alert('温馨提示', '此计划已排产，不允许删除!');
                    }else {
                        jQuery.ajax({
                            type: "post",//数据发送的方式（post 或者 get）
                            url: "${ctxPath }/ColdMonthPlan/deleteParent.action",//要发送的后台地址
                            data: {
                                id: row.id
                            },
                            dataType: "json",//后台处理后返回的数据格式
                            success: function (data) {//ajax请求成功后触发的方法
                                if (data.num > 0) {
                                    $.messager.alert('温馨提示', '删除成功!');
                                    monp_forGetDate();
                                }
                            }
                        })
                    }
                }
            })
        }
    }

    function monp_onContextMenu(e,row){
        e.preventDefault();
        $(this).treegrid('select', row.fno);
        $('#monp_mm').menu('show',{
            left: e.pageX,
            top: e.pageY
        });
    }

    function monp_listAdd() {
        //alert(111111);
        var fno = $("#monp_fromfno").val();
        var fname = $("#monp_fromfname").val();
        var fromplanweidgt = $("#monp_fromplanweidgt").val();
        var fparentid = $("#monp_fparentid").val();
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth = myDate.getMonth()+1;
        var UserName = localStorage.getItem("User");
        var   ssl=$("#monp_fromssl").val();
        var   qcl=$("#monp_fromqcl").val();
        var   njl=$("#monp_fromnjl").val();
        var   cdl=$("#monp_fromcdl").val();
        var   gclzb=$("#monp_fromgclzb").val();
        var   bsl=$("#monp_frombsl").val();
        var  ftl=$("#monp_fromftl").val();
        var   gclxh=$("#monp_fromgclxh").val();
        var   mtcl=$("#monp_frommtcl").val();
        var   xmb=$("#monp_fromxmb").val();
        var   dp=$("#monp_fromdp").val();
        $.ajax({
            type: "post",
            data: {
                fno: fno,
                fname: fname,
                planweidgt: fromplanweidgt,
                fparentid: fparentid,
                year:uyear,
                month:umouth,
                planman:UserName,
                ssl:ssl,
                qcl:qcl,
                njl:njl,
                cdl:cdl,
                gclzb:gclzb,
                bsl:bsl,
                ftl:ftl,
                gclxh:gclxh,
                mtcl:mtcl,
                xmb:xmb,
                dp:dp
            },
            url: "${ctxPath }/ColdMonthPlan/insertChild.action",
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                //alert(data.num);
                if (data.num > 0) {
                    $.messager.alert('温馨提示', '新增成功!');

                    monp_forGetDate();

                    $('#monp_listadd').dialog('close');
                }
            }
        })
    }


    /**
     * Name 分页过滤器
     */
    function pagerFilter(data) {
        if (typeof data.length == 'number' && typeof data.splice == 'function') {// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            showRefresh: false,
            onSelectPage: function (pageNum, pageSize) {
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh', {pageNumber: pageNum, pageSize: pageSize});
                dg.datagrid('loadData', data);
            }
        });
        if (!data.originalRows) {
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }

    var editIndex = undefined;

    function endEditing() {
        if (editIndex == undefined) {
            return true
        }
        if ($('#MonPlandg1').datagrid('validateRow', editIndex)) {
            var ed = $('#MonPlandg1').datagrid('getEditor', {index: editIndex, field: 'productid'});
            $('#MonPlandg1').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }


    /**
     * Name 载入数据
     */
    $('#MonPlandatagrid').datagrid({
        loadFilter: pagerFilter,
        rownumbers: true,
        singleSelect: false,
        pageSize: 20,
        pagination: true,
        multiSort: true,
        //fitColumns:true,
        //fit:true,
    });

    function monp_uploadForm() {
        var planyear = $("#monp_db").val().substring(0,4);
        var planmonth = $("#monp_db").val().substring(5,7);
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
                    "umouth": $("#monp_db").val().substring(5,7),
                    "User": localStorage.getItem("User"),
                    "mpupinst": $('input[name="adminFlag"]:checked').val()
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
                                        "mpupinst": $('input[name="adminFlag"]:checked').val()
                                    },
                                    width: 300,
                                    buttons: {'ok': '确定', 'no': '取消'},
                                    icon: Ext.MessageBox.WARNING,
                                    closable: false,
                                    fn: function (e) {
                                        if (e == 'ok') {
                                            if (upload.form.isValid()) {
                                                upload.getForm().submit({

                                                    url: '${ctxPath }/ColdMonthPlan/import.action',
                                                    method: 'POST',
                                                    params: {
                                                        "year": planyear,
                                                        "month":planmonth,
                                                        "User": localStorage.getItem("User"),
                                                        "mpupinst": $('input[name="adminFlag"]:checked').val()
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
                                                                    Query();
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

    /**
     * 下载模版
     */
    function monp_download_log() {
        if (!Ext.fly('test')) {
            var frm = document.createElement('form');
            frm.id

                = 'test';
            frm.name

                = id;
            frm.style.display = 'none';
            document.body.appendChild(frm);
        }
        Ext.Ajax.request({
            url: '${ctxPath }/PlanProductController/download.action',
            form: Ext.fly('test'),
            method: 'POST',
            isUpload: true
        });
    }

    function aplandelete() {
        var row = $('#MonPlandatagrid').datagrid("getSelected");
        $.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "${ctxPath }/PlanProductController/APdelete.action",//要发送的后台地址
            data: {
                Umouth: row.Umouth,
                Uyear: row.Uyear,
                OrderLine: row.OrderLine,
                Plant: row.Plant,
            },//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "json",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
                if (data.OK === "NO") {
                    $.messager.alert('提示', '删除失败！', 'info');
                }
                else {
                    $('#MonPlandatagrid').datagrid("deleteRow", editindex);
                    $.messager.alert('提示', '删除成功！', 'info');
                    $("#MONDutyman").textbox("setValue", '');
                    $("#MONUmouth").textbox("setValue", '');
                    $("#MONfno").textbox("setValue", '');
                    $("#MONDescrip").textbox("setValue", '');
                    $("#dhorderno").textbox("setValue", '');
                    $("#SAPSDOrder").textbox("setValue", '');
                    $("#TakeOrder").textbox("setValue", '');
                    $("#CompleteOrder").datebox('setValue', '');
                    $("#OrderTime").datebox('setValue', '');
                    $("#CLNumber").textbox("setValue", '');
                    $("#ConnectPlan").textbox("setValue", '');
                    $("#SumDayNum").textbox("setValue", '');
                    $("#beginConnect").textbox("setValue", '');
                    $("#number").textbox("setValue", '');
                    $("#SumDayInput").textbox("setValue", '');
                    $("#OrderLine").textbox("setValue", '');
                    $("#IsCheck").attr('checked', false);
                    $("#GCXH").attr('checked', false);
                }
            },
            error: function (msg) {//ajax请求失败后触发的方法
                $.messager.alert('提示', '发生错误！', 'info');
            }
        });
    }

</script>