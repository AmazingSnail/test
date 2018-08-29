<%--
  Created by IntelliJ IDEA.
  User: chent
  Date: 2018-03-14
  Time: 10:13----基础资料
  To change this template use File | Settings | File Templates.
--%>
<%--
 Created by IntelliJ IDEA.
 User: chent
 Date: 2018-03-12
 Time: 13:30  ---人员维护
 To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
    table.imagetable {
        font-family: verdana,arial,sans-serif;
        font-size:11px;
        color:#333333;
        border-width: 1px;
        border-color: #999999;
        border-collapse: collapse;
    }
    table.imagetable th {
        border-width: 1px;
        padding: 8px;
        border-style: solid;
        border-color: #999999;
    }
    table.imagetable td {
        border-width: 1px;
        padding: 6px;
        border-style: solid;
        border-color: #999999;
    }
    .easyui-panel {
        width: 96%;
        height: 66%;
    }
    .H{
        width:15%;
        height:75%;
    }

    .J{
        width:90%;
        height:75%;
    }
    #yuanjiao{
        font-family: Arial;
        border: 2px solid #379082;
        border-radius: 20px;
        padding: 30px 30px;
        width: 330px;
    }
    .e2{
        letter-spacing:1em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-2）/(2-1)=2em */
        margin-right:-1em; /*同上*/
    }
    .e3{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .e4{
        letter-spacing:0.3em; /*如果需要y个字两端对齐，则为(x-y)/(y-1),这里是（4-3）/(3-1)=0.5em */
        margin-right:-0.3em; /*同上*/
    }
    .haorooms{
        height: calc(100% - 80px);
    }


    body{
        padding: 0px;
        margin: 0px;
    }
    .labelstyle{
        margin-right: 3px;
    }
</style>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',border:false">
        <!-- Begin of toolbar -->

        <!-- End of toolbar -->
        <iframe id="proxy2" style="display:none"></iframe>
        <div class="easyui-panel "  data-options="fit:true">
            <div id="trt_toolbar"  style="overflow:auto;width:100%;height: 80px;">
                <div class="wu-toolbar-button" >
                    <%--<shiro:hasPermission name="/PersonnelMaintenance/send">--%>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="sendinfo()" plain="true">提交</a>
                    <%--</shiro:hasPermission>--%>
                </div>
                <div class="wu-toolbar-search" >
                    <table>
                        <tr><td>事业部： <select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="irPlant" panelHeight="auto" data-options="
                                valueField:'Fname',
                                textField:'Fremark',
                                panelHeight:'250'"
                                             style="width:100px">
                            </select></td>
                            <td><label>设备ID：</label><select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="irEquipID" panelHeight="auto" data-options="
                                valueField:'EquipID',
                                textField:'EquipID',
                                panelHeight:'250'"
                                                            style="width:100px">
                            </select>&nbsp</td>
                            <td><label>检验员：</label><select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="Username" panelHeight="auto" data-options="
                                valueField:'username',
                                textField:'username',
                                panelHeight:'250'"
                                                            style="width:100px">
                            </select>&nbsp</td>
                            <td><label>计划编号：</label><select class="easyui-combobox" name="mmPlant" style="width:100px" datatype="text" id="Planid" panelHeight="auto" data-options="
                                valueField:'Planid',
                                textField:'Planid',
                                panelHeight:'250'"
                                                           style="width:100px">
                            </select>&nbsp</td>
                            <td><a href="#" class="easyui-linkbutton"  onclick="ir_query()" data-options="iconCls:'icon-search'">查询</a></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="easyui-layout haorooms"  >
                <div class="H" data-options="region:'west',split:true" >
                    <div  class="easyui-layout" data-options="fit:true" style="width:100%;height:65%">
                        <label>日期：</label><input  id ="irdb1" style="width:100px" class="easyui-datebox">&nbsp
                        <ul id="tree_bases" class="easyui-tree" >  </ul>
                    </div>
                </div>
                <div class="J"  data-options="region:'east',split:true">
                    <div style="margin-top: 1%"></div>
                    <div id="XX" style="height: 60px;width: auto;text-align:justify;">
                        <input style="width: 1%;border: 0px;" readonly>
                        <label style="font-size: 0.15rem;vertical-align:middle;display:inline-block;">计划编号：</label><span id="JHBH"style="width: 20%;vertical-align:middle;height: 100px;font-size: 0.16rem"></span>
                        <input style="width: 8%;border: 0px;" readonly>
                        <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">设备编号：</label><span id="EquipmentID" style="width: auto;height: 100px;vertical-align:middle;font-size:0.16rem"></span>
                        <input style="width: 8%;border: 0px;" readonly>
                        <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">检验员：</label><span id="JYY" style="width: auto;height: 100px;vertical-align:middle;font-size: 0.16rem"></span><br>
                        <input style="width: 50%;border: 0px;" readonly><br>
                        <input style="width: 1%;border: 0px;" readonly>
                        <label style="font-size:  0.15rem;;vertical-align:middle;display:inline-block;">物料编码：</label><span id="WLBM" style="width: auto;height: 100px;vertical-align:middle;font-size:0.16rem"></span>
                        <input style="width: 8%;border: 0px;" readonly>
                        <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">物料描述：</label><span id="WLMS" style="width: auto;height: 100px;vertical-align:middle;font-size: 0.16rem"></span>
                        <input style="width: 8%;border: 0px;" readonly>
                        <label style="font-size:  0.15rem;vertical-align:middle;display:inline-block;">打印标记：</label><span id="DYBJ" style="width: auto;height: 100px;vertical-align:middle;font-size: 0.16rem"></span>
                    </div>
                    <hr/>
                    <div>
                        <table border="0" class="imagetable" style="width: 80%;text-align: center">
                            <tr>
                                <td>检验项目</td> <td>孔心距</td><td>孔径</td>
                                <td>孔位置度</td> <td>厚度</td><td>外观</td>
                                <td>链板高度</td> <td>光亮带</td><td>合格</td>
                            </tr>
                            <tr>
                                <td>检验标准</td><td><span id="holeHD" style="width: 80%"></span></td><td><span  id="aperture" style="width: 80%"></span></td><td><span id="holeSite" style="width: 80%"></span></td><td><span id="thickness" style="width: 80%"></span>
                            </td><td><span id="facade" style="width: 80%"></span></td><td><span id="height" style="width: 80%"></span></td><td><span id="leuchtfeld" style="width: 80%"></span></td><td><span style="width: 80%">是否合格</span></td>
                            </tr>
                            <tr>
                                <td>零件一：</td><td><input style="width: 82%" class="easyui-textbox" id="holeHD1" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum1"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><input style="width: 82%" class="easyui-textbox" id="thickness1" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum2"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum3"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum4"  panelHeight="auto" style="width:80%">
                                <option value="0.75" selected="selected">75%</option>
                                <option value="0.8" >80%</option>
                                <option value="0.85" >85%</option>
                                <option value="0.9" >90%</option>
                                <option value="0.95" >95%</option>
                                <option value="1" >100%</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum25"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td>
                            </tr>
                            <tr>
                                <td>零件二：</td><td><input style="width: 82%" class="easyui-textbox" id="holeHD2" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum5"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum6"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><input style="width: 82%" class="easyui-textbox" id="thickness2" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum7"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum8"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum9"  panelHeight="auto" style="width:80%">
                                <option value="0.75" selected="selected">75%</option>
                                <option value="0.8" >80%</option>
                                <option value="0.85" >85%</option>
                                <option value="0.9" >90%</option>
                                <option value="0.95" >95%</option>
                                <option value="1" >100%</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum26"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td>
                            </tr>
                            <tr>
                                <td>零件三：</td><td><input style="width: 82%" class="easyui-textbox" id="holeHD3" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum10"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum11"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><input style="width: 82%" class="easyui-textbox" id="thickness3" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum12"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum13"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum14"  panelHeight="auto" style="width:80%">
                                <option value="0.75" selected="selected">75%</option>
                                <option value="0.8" >80%</option>
                                <option value="0.85" >85%</option>
                                <option value="0.9" >90%</option>
                                <option value="0.95" >95%</option>
                                <option value="1" >100%</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum27"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td>
                            </tr>
                            <tr>
                                <td>零件四：</td><td><input style="width: 82%" class="easyui-textbox" id="holeHD4" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum15"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum16"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><input style="width: 82%" class="easyui-textbox" id="thickness4" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum17"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum18"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum19"  panelHeight="auto" style="width:80%">
                                <option value="0.75" selected="selected">75%</option>
                                <option value="0.8" >80%</option>
                                <option value="0.85" >85%</option>
                                <option value="0.9" >90%</option>
                                <option value="0.95" >95%</option>
                                <option value="1" >100%</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum28"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td>
                            </tr>
                            <tr>
                                <td>零件五：</td> ><td><input style="width: 82%" class="easyui-textbox" id="holeHD5" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum20"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum21"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><input style="width: 82%" class="easyui-textbox" id="thickness5" required></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum22"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum23"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum24"  panelHeight="auto" style="width:80%">
                                <option value="0.75" selected="selected">75%</option>
                                <option value="0.8" >80%</option>
                                <option value="0.85" >85%</option>
                                <option value="0.9" >90%</option>
                                <option value="0.95" >95%</option>
                                <option value="1" >100%</option>
                                <option value="不合格">不合格</option>
                            </select></td><td><select class="easyui-combobox" name="takekind" datatype="text" id="AxleNum29"  panelHeight="auto" style="width:80%">
                                <option value="合格" selected="selected">合格</option>
                                <option value="不合格">不合格</option>
                            </select></td>
                            </tr>

                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var i='' ;
    var ids='';
    var j = '';//判断点击添加还是修改（报工）
    var n = '';//判断点击添加还是修改(外购)
    var sj = ''; //树的id
    var myDate = new Date();
    var uyear = myDate.getFullYear();
    var umouth  = myDate.getMonth()+1;
    var uday = myDate.getDate();
    var uhour = myDate.getHours();
    var umin = myDate.getMinutes();
    var ums = myDate.getSeconds();
    var time = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
    var name = localStorage.getItem("User");
    $(function () {
        var date=new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        $('#irdb1').val(year+"-"+month+"-"+day);
        //$('#trt_db2').val(year+"-"+month+"-"+day+" "+hour+":"+minute+':'+second);
//        $('#trt_db2').val(year+"-"+month+"-"+day);
        $("#irPlant").combobox({
            //相当于html >> select >> onChange事件
            onChange: function () {
                jQuery.ajax({
                    type: "POST",   //post提交方式默认是get
                    url:'${ctxPath }/PersonnelMaintenance/selectDevice1.action',
                    dataType: "json",
                    data: {
                        plant:  $('#irPlant').combobox('getValue')
                    },
//                data:$("#login").val(),   //序列化
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息
                    },
                    success: function (data) {
                        console.log(data);
                        $('#irEquipID').combobox('loadData', data);
                    }
                });
            }
        });
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
                console.log(data);
                $('#irPlant').combobox('loadData', data);
                //alert(11111);

            }
        });
        jQuery.ajax({
            type: "POST",   //post提交方式默认是get
            url:'${ctxPath }/PersonnelMaintenance/queryName.action',
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
                $('#Username').combobox('loadData', data);
                //alert(11111);

            }
        });

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
        $(document).click(function(e){

            $("#trt_More").hide();

        });

//        $("#trt_toolbar").blur(function(){
//            $("#trt_More").toggle();
//        })

//树形结构
        //加载全部节点
        $("#tree_bases").tree({
            url: '${ctxPath }/BasicData/serach1',
            animate:true,
            lines:true,
            onClick: function (node) {
                //右侧跳转到指定页面
//                addTab(node.text,node.menuUrl);
//                    alert(node.text);
                i = node.text;
                sj = node.id;

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
    });
    var mmm = '';
    $("#Username").combobox({
        //相当于html >> select >> onChange事件
        onChange: function () {
            document.getElementById("JYY").innerHTML = $('#Username').combobox('getValue');
        }
    })
    $("#irEquipID").combobox({
        //相当于html >> select >> onChange事件
        onChange: function () {
            mmm='';
            Treechange();
        }

    });
    $('#irdb1').datebox({
        onChange: function(){
            mmm='';
            Treechange();
        }
    })
   function Treechange() {
       $('#holeHD1').textbox('setValue','');
       $('#AxleNum').textbox('setValue','合格');
       $('#AxleNum1').textbox('setValue','合格');
       $('#AxleNum2').textbox('setValue','合格');
       $('#AxleNum3').textbox('setValue','合格');
       $('#AxleNum4').textbox('setValue','合格');
       $('#AxleNum25').textbox('setValue','合格');
       $('#thickness1').textbox('setValue','');
       $('#holeHD2').textbox('setValue','');
       $('#AxleNum5').textbox('setValue','合格');
       $('#AxleNum6').textbox('setValue','合格');
       $('#AxleNum7').textbox('setValue','合格');
       $('#AxleNum8').textbox('setValue','合格');
       $('#AxleNum9').textbox('setValue','合格');
       $('#AxleNum26').textbox('setValue','合格');
       $('#thickness2').textbox('setValue','');
       $('#holeHD3').textbox('setValue','');
       $('#AxleNum10').textbox('setValue','合格');
       $('#AxleNum11').textbox('setValue','合格');
       $('#AxleNum12').textbox('setValue','合格');
       $('#AxleNum13').textbox('setValue','合格');
       $('#AxleNum14').textbox('setValue','合格');
       $('#AxleNum27').textbox('setValue','合格');
       $('#thickness3').textbox('setValue','');
       $('#holeHD4').textbox('setValue','');
       $('#AxleNum15').textbox('setValue','合格');
       $('#AxleNum16').textbox('setValue','合格');
       $('#AxleNum17').textbox('setValue','合格');
       $('#AxleNum18').textbox('setValue','合格');
       $('#AxleNum19').textbox('setValue','合格');
       $('#AxleNum28').textbox('setValue','合格');
       $('#thickness4').textbox('setValue','');
       $('#holeHD5').textbox('setValue','');
       $('#AxleNum20').textbox('setValue','合格');
       $('#AxleNum21').textbox('setValue','合格');
       $('#AxleNum22').textbox('setValue','合格');
       $('#AxleNum23').textbox('setValue','合格');
       $('#AxleNum24').textbox('setValue','合格');
       $('#AxleNum29').textbox('setValue','合格');
       $('#thickness5').textbox('setValue','');
       jQuery.ajax({
           type: "POST",   //post提交方式默认是get
           url:'${ctxPath }/PersonnelMaintenance/selectPlan.action',
           dataType: "json",
           data: {
               plant: localStorage.getItem("Department"),
               EquipID:  $('#irEquipID').combobox('getValue')
           },
//                data:$("#login").val(),   //序列化
           error: function (request) {      // 设置表单提交出错
               $("#showMsg").html(request);  //登录错误提示信息
           },
           success: function (data) {
               console.log(data);
               if(data[0].num>0){
                   $('#Planid').combobox('loadData', data);
                   $("#Planid ").combobox('select',data[0].Planid);
                   a =  data[0].Planid;
                   b =data[0].SBBH;
                   c = data[0].fno;
                   d = data[0].fname;
                   e = data[0].DYBJ;
                   document.getElementById("JHBH").innerHTML = a;
                   document.getElementById("EquipmentID").innerHTML =b;
                   document.getElementById("WLBM").innerHTML = c;
                   document.getElementById("WLMS").innerHTML =d;
                   document.getElementById("DYBJ").innerHTML = e;
                   var ss = '首件检,10:00-12:30,12:30-14:30,14:30-16:30,17:00-19:00,19:00-21:00,21:00-23:00,23:00-1:00';
                   var myArray=new Array();
                   myArray = ss.split(",");
                   for(var i = 0;i<8;i++){
                       var m = myArray[i];
                       jQuery.ajax({
                           type: "POST",   //post提交方式默认是get
                           url:'${ctxPath }/PersonnelMaintenance/Juge.action',
                           dataType: "json",
                           async:false,
                           data: {
                               s:m,
                               EquipID:  $('#irEquipID').combobox('getValue'),
                               time:$('#irdb1').datebox('getValue'),//日期
                           },
                           error: function (request) {      // 设置表单提交出错
                               $("#showMsg").html(request);  //登录错误提示信息

                           },
                           success: function (data) {
                               if(data.num>0){
                                   mmm = mmm+data.s+"/";
                               }
                           }
                       });
                   }
                   $("#tree_bases").tree({
                       url: '${ctxPath }/BasicData/serach1',
                       animate:true,
                       lines:true,
                       formatter:function(node){
                           var s = '';
                           var myArray1=new Array();
                           myArray1 = mmm.split("/");
                           if(node.text==myArray1[1]||node.text==myArray1[0]||node.text==myArray1[2]||
                               node.text==myArray1[3]|| node.text==myArray1[4]|| node.text==myArray1[5]|| node.text==myArray1[6]
                               || node.text==myArray1[7]){
                               s ='<font color="red" >'+node.text+'</font>';
                           }else{
                               s ='<font >'+node.text+'</font>';
                           }


                           return s;

                       }
                   });

               }else{
                   document.getElementById("JHBH").innerHTML = '';
                   document.getElementById("EquipmentID").innerHTML ='';
                   document.getElementById("WLBM").innerHTML = '';
                   document.getElementById("WLMS").innerHTML ='';
                   document.getElementById("DYBJ").innerHTML = '';
               }

           }
       });
   }
    function ir_query () {
       var EquipID= $('#irEquipID').combobox('getValue');
       var Username= $('#Username').combobox('getValue');
       if(EquipID!=''){
                   jQuery.ajax({
                       type: "POST",   //post提交方式默认是get
                       url:'${ctxPath }/PersonnelMaintenance/selectPlan.action',
                       dataType: "json",
                       data: {
                           plant: localStorage.getItem("Department"),
                           EquipID:  $('#irEquipID').combobox('getValue')
                       },
//                data:$("#login").val(),   //序列化
                       error: function (request) {      // 设置表单提交出错
                           $("#showMsg").html(request);  //登录错误提示信息
                       },
                       success: function (data) {
                           a =  data[0].Planid;
                           b =data[0].SBBH;
                           c = data[0].fno;
                           d = data[0].fname;
                           e = data[0].DYBJ;
                           document.getElementById("JHBH").innerHTML =a;
                           document.getElementById("EquipmentID").innerHTML =b;
                           document.getElementById("WLBM").innerHTML = c;
                           document.getElementById("WLMS").innerHTML =d;
                           document.getElementById("DYBJ").innerHTML = e;
                       }
                   });
       }else {
           $.messager.alert("温馨提示","请选择设备编号!");
       }
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
    $("#tree_bases").tree({
        onClick:function(node){
            i = node.text;
            sj = node.id;
            query();
        }
    });

    var partDrawing = '';
    function query () {
        $('#holeHD1').textbox('setValue','');
        $('#AxleNum').textbox('setValue','合格');
        $('#AxleNum1').textbox('setValue','合格');
        $('#AxleNum2').textbox('setValue','合格');
        $('#AxleNum3').textbox('setValue','合格');
        $('#AxleNum4').textbox('setValue','合格');
        $('#AxleNum25').textbox('setValue','合格');
        $('#thickness1').textbox('setValue','');
        $('#holeHD2').textbox('setValue','');
        $('#AxleNum5').textbox('setValue','合格');
        $('#AxleNum6').textbox('setValue','合格');
        $('#AxleNum7').textbox('setValue','合格');
        $('#AxleNum8').textbox('setValue','合格');
        $('#AxleNum9').textbox('setValue','合格');
        $('#AxleNum26').textbox('setValue','合格');
        $('#thickness2').textbox('setValue','');
        $('#holeHD3').textbox('setValue','');
        $('#AxleNum10').textbox('setValue','合格');
        $('#AxleNum11').textbox('setValue','合格');
        $('#AxleNum12').textbox('setValue','合格');
        $('#AxleNum13').textbox('setValue','合格');
        $('#AxleNum14').textbox('setValue','合格');
        $('#AxleNum27').textbox('setValue','合格');
        $('#thickness3').textbox('setValue','');
        $('#holeHD4').textbox('setValue','');
        $('#AxleNum15').textbox('setValue','合格');
        $('#AxleNum16').textbox('setValue','合格');
        $('#AxleNum17').textbox('setValue','合格');
        $('#AxleNum18').textbox('setValue','合格');
        $('#AxleNum19').textbox('setValue','合格');
        $('#AxleNum28').textbox('setValue','合格');
        $('#thickness4').textbox('setValue','');
        $('#holeHD5').textbox('setValue','');
        $('#AxleNum20').textbox('setValue','合格');
        $('#AxleNum21').textbox('setValue','合格');
        $('#AxleNum22').textbox('setValue','合格');
        $('#AxleNum23').textbox('setValue','合格');
        $('#AxleNum24').textbox('setValue','合格');
        $('#AxleNum29').textbox('setValue','合格');
        $('#thickness5').textbox('setValue','');
         var irEquipID = $('#irEquipID').combobox('getValue');//设备
         var planid = $('#Planid').combobox('getValue');//计划id
        var fno = document.getElementById("WLBM").innerText;
         if(planid!=''&&fno!=''){
             $.ajax({
                 type: "POST",   //post提交方式默认是get
                 url:'${ctxPath }/PersonnelMaintenance/check.action',
                 dataType: "json",
                 data: {
                     plant: localStorage.getItem("Department"),
                     irEquipID:irEquipID,
                     planid:planid,
                     i:i,
                     time:$('#irdb1').datebox('getValue'),//日期
                     fno:fno,
                 },
                 error: function (request) {      // 设置表单提交出错
                     $("#showMsg").html(request);  //登录错误提示信息
                 },
                 success: function (data) {
                     console.log(data);
                     document.getElementById("holeHD").innerHTML = data.holeHD;
                     document.getElementById("aperture").innerHTML = data.aperture;
                     document.getElementById("holeSite").innerHTML = data.holeSite;
                     document.getElementById("thickness").innerHTML = data.thickness;
                     document.getElementById("facade").innerHTML = data.facade;
                     document.getElementById("height").innerHTML = data.height;
                     document.getElementById("leuchtfeld").innerHTML = data.leuchtfeld;
                     partDrawing = data.partDrawing;
                     if(data.num!=-1){
                          console.log(data);
                         $('#holeHD1').textbox('setValue',data.rows[0].holeHD);
                         $('#AxleNum').textbox('setValue',data.rows[0].aperture);
                         $('#AxleNum1').textbox('setValue',data.rows[0].holeSite);
                         $('#AxleNum2').textbox('setValue',data.rows[0].facade);
                         $('#AxleNum3').textbox('setValue',data.rows[0].height);
                         $('#AxleNum4').textbox('setValue',data.rows[0].leuchtfeld);
                         $('#AxleNum25').textbox('setValue',data.rows[0].isQualified);
                         $('#thickness1').textbox('setValue',data.rows[0].thickness);
                         $('#holeHD2').textbox('setValue',data.rows[1].holeHD);
                         $('#AxleNum5').textbox('setValue',data.rows[1].aperture);
                         $('#AxleNum6').textbox('setValue',data.rows[1].holeSite);
                         $('#AxleNum7').textbox('setValue',data.rows[1].facade);
                         $('#AxleNum8').textbox('setValue',data.rows[1].height);
                         $('#AxleNum9').textbox('setValue',data.rows[1].leuchtfeld);
                         $('#AxleNum26').textbox('setValue',data.rows[1].isQualified);
                         $('#thickness2').textbox('setValue',data.rows[1].thickness);
                         $('#holeHD3').textbox('setValue',data.rows[2].holeHD);
                         $('#AxleNum10').textbox('setValue',data.rows[2].aperture);
                         $('#AxleNum11').textbox('setValue',data.rows[2].holeSite);
                         $('#AxleNum12').textbox('setValue',data.rows[2].facade);
                         $('#AxleNum13').textbox('setValue',data.rows[2].height);
                         $('#AxleNum14').textbox('setValue',data.rows[2].leuchtfeld);
                         $('#AxleNum27').textbox('setValue',data.rows[2].isQualified);
                         $('#thickness3').textbox('setValue',data.rows[2].thickness);
                         $('#holeHD4').textbox('setValue',data.rows[3].holeHD);
                         $('#AxleNum15').textbox('setValue',data.rows[3].aperture);
                         $('#AxleNum16').textbox('setValue',data.rows[3].holeSite);
                         $('#AxleNum17').textbox('setValue',data.rows[3].facade);
                         $('#AxleNum18').textbox('setValue',data.rows[3].height);
                         $('#AxleNum19').textbox('setValue',data.rows[3].leuchtfeld);
                         $('#AxleNum28').textbox('setValue',data.rows[3].isQualified);
                         $('#thickness4').textbox('setValue',data.rows[3].thickness);
                         $('#holeHD5').textbox('setValue',data.rows[4].holeHD);
                         $('#AxleNum20').textbox('setValue',data.rows[4].aperture);
                         $('#AxleNum21').textbox('setValue',data.rows[4].holeSite);
                         $('#AxleNum22').textbox('setValue',data.rows[4].facade);
                         $('#AxleNum23').textbox('setValue',data.rows[4].height);
                         $('#AxleNum24').textbox('setValue',data.rows[4].leuchtfeld);
                         $('#AxleNum29').textbox('setValue',data.rows[4].isQualified);
                         $('#thickness5').textbox('setValue',data.rows[4].thickness);
                     }
                 }
             })
         }else {
             $.messager.alert('温馨提示','请选择计划编号!!!');
         }
    }
    function  sendinfo() {
        var myDate = new Date();
        var uyear = myDate.getFullYear();
        var umouth  = myDate.getMonth()+1;
        var uday = myDate.getDate();
        var uhour = myDate.getHours();
        var umin = myDate.getMinutes();
        var ums = myDate.getSeconds();
        var time1 = uyear+"-"+umouth+"-"+uday+" "+uhour+":"+umin+":"+ums;
        var Username = $('#irEquipID').combobox('getValue');//检验员
        if(Username!=''){
            var irEquipID = $('#irEquipID').combobox('getValue');//设备
            var planid = $('#Planid').combobox('getValue');//计划id
            var fno = document.getElementById("WLBM").innerText;
            if(planid!=''&&fno!=''){
                $.ajax({
                    type: "POST",   //post提交方式默认是get
                    url:'${ctxPath }/PersonnelMaintenance/check.action',
                    dataType: "json",
                    data: {
                        plant: localStorage.getItem("Department"),
                        irEquipID:irEquipID,
                        planid:planid,
                        i:i,
                        time:$('#irdb1').datebox('getValue'),//日期
                        fno:fno,
                    },
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息
                    },
                    success: function (data) {
                        console.log(data);
                        document.getElementById("holeHD").innerHTML = data.holeHD;
                        document.getElementById("aperture").innerHTML = data.aperture;
                        document.getElementById("holeSite").innerHTML = data.holeSite;
                        document.getElementById("thickness").innerHTML = data.thickness;
                        document.getElementById("facade").innerHTML = data.facade;
                        document.getElementById("height").innerHTML = data.height;
                        document.getElementById("leuchtfeld").innerHTML = data.leuchtfeld;
                        partDrawing = data.partDrawing;
                        if(data.num!=-1){
                            console.log(data);
                            $.messager.alert('温馨提示','不允许重复提交');
                        }else {
                            var holeHD1 = $('#holeHD1').val();
                            var holeHD2 = $('#holeHD2').val();
                            var holeHD3 = $('#holeHD3').val();
                            var holeHD4 = $('#holeHD4').val();
                            var holeHD5 = $('#holeHD5').val();
                            var thickness1 = $('#thickness1').val();
                            var thickness2 = $('#thickness2').val();
                            var thickness3 = $('#thickness3').val();
                            var thickness4 = $('#thickness4').val();
                            var thickness5 = $('#thickness5').val();
                            var AxleNum = $('#AxleNum').combobox('getValue');
                            var AxleNum1 = $('#AxleNum1').combobox('getValue');
                            var AxleNum2 = $('#AxleNum2').combobox('getValue');
                            var AxleNum3 = $('#AxleNum3').combobox('getValue');
                            var AxleNum4 = $('#AxleNum4').combobox('getValue');
                            var AxleNum5 = $('#AxleNum5').combobox('getValue');
                            var AxleNum6 = $('#AxleNum6').combobox('getValue');
                            var AxleNum7 = $('#AxleNum7').combobox('getValue');
                            var AxleNum8 = $('#AxleNum8').combobox('getValue');
                            var AxleNum9 = $('#AxleNum9').combobox('getValue');
                            var AxleNum10 = $('#AxleNum10').combobox('getValue');
                            var AxleNum11 = $('#AxleNum11').combobox('getValue');
                            var AxleNum12 = $('#AxleNum12').combobox('getValue');
                            var AxleNum13 = $('#AxleNum13').combobox('getValue');
                            var AxleNum14 = $('#AxleNum14').combobox('getValue');
                            var AxleNum15 = $('#AxleNum15').combobox('getValue');
                            var AxleNum16 = $('#AxleNum16').combobox('getValue');
                            var AxleNum17 = $('#AxleNum17').combobox('getValue');
                            var AxleNum18 = $('#AxleNum18').combobox('getValue');
                            var AxleNum19 = $('#AxleNum19').combobox('getValue');
                            var AxleNum20 = $('#AxleNum20').combobox('getValue');
                            var AxleNum21 = $('#AxleNum21').combobox('getValue');
                            var AxleNum22 = $('#AxleNum22').combobox('getValue');
                            var AxleNum23 = $('#AxleNum23').combobox('getValue');
                            var AxleNum24 = $('#AxleNum24').combobox('getValue');
                            var AxleNum25 = $('#AxleNum25').combobox('getValue');
                            var AxleNum26 = $('#AxleNum26').combobox('getValue');
                            var AxleNum27 = $('#AxleNum27').combobox('getValue');
                            var AxleNum28 = $('#AxleNum28').combobox('getValue');
                            var AxleNum29 = $('#AxleNum29').combobox('getValue');
                            var planid = $('#Planid').combobox('getValue');
                            var irEquipID = $('#irEquipID').combobox('getValue');
                            if(holeHD1!=''&&holeHD2!=''&&holeHD3!=''&&holeHD4!=''&&holeHD5!=''&&thickness1!=''
                                &&thickness2!=''&&thickness3!=''&&thickness4!=''&&thickness5!=''){
                                $.ajax({
                                    type: "POST",   //post提交方式默认是get
                                    url:'${ctxPath }/PersonnelMaintenance/Send.action',
                                    dataType: "json",
                                    data: {
                                        name:localStorage.getItem("User"),
                                        time:time1,
                                        sendtime :$('#irdb1').datebox('getValue'),//日期
                                        i :i,
                                        planid:planid,
                                        irEquipID:irEquipID,
                                        holeHD1:holeHD1,
                                        holeHD2:holeHD2,
                                        holeHD3:holeHD3,
                                        holeHD4:holeHD4,
                                        holeHD5:holeHD5,
                                        thickness1:thickness1,
                                        thickness2:thickness2,
                                        thickness3:thickness3,
                                        thickness4:thickness4,
                                        thickness5:thickness5,
                                        AxleNum:AxleNum,
                                        AxleNum1:AxleNum1,
                                        AxleNum2:AxleNum2,
                                        AxleNum3:AxleNum3,
                                        AxleNum4:AxleNum4,
                                        AxleNum5:AxleNum5,
                                        AxleNum6:AxleNum6,
                                        AxleNum7:AxleNum7,
                                        AxleNum8:AxleNum8,
                                        AxleNum9:AxleNum9,
                                        AxleNum10:AxleNum10,
                                        AxleNum11:AxleNum11,
                                        AxleNum12:AxleNum12,
                                        AxleNum13:AxleNum13,
                                        AxleNum14:AxleNum14,
                                        AxleNum15:AxleNum15,
                                        AxleNum16:AxleNum16,
                                        AxleNum17:AxleNum17,
                                        AxleNum18:AxleNum18,
                                        AxleNum19:AxleNum19,
                                        AxleNum20:AxleNum20,
                                        AxleNum21:AxleNum21,
                                        AxleNum22:AxleNum22,
                                        AxleNum23:AxleNum23,
                                        AxleNum24:AxleNum24,
                                        AxleNum25:AxleNum25,
                                        AxleNum26:AxleNum26,
                                        AxleNum27:AxleNum27,
                                        AxleNum28:AxleNum28,
                                        AxleNum29:AxleNum29,
                                        partDrawing:partDrawing,
                                    },
                                    error: function (request) {      // 设置表单提交出错
                                        $("#showMsg").html(request);  //登录错误提示信息
                                    },
                                    success: function (data) {
                                        $.messager.alert('温馨提示','提交成功！！！');
                                        mmm='';
                                        Treechange();
                                    }
                                })
                            }else {
                                $.messager.alert('温馨提示','请填写数据！！！');
                            }

                        }
                    }
                })
            }else {
                $.messager.alert('温馨提示','请选择计划编号!!!');
            }
        }else {
            $.messager.alert('温馨提示','请选择检验人员!!!')
        }
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
</script>


