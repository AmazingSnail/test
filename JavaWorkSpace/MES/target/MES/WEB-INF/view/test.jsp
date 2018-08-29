<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
    <%--&lt;%&ndash;<meta charset="utf-8">&ndash;%&gt;--%>
    <%--&lt;%&ndash;<title>ECharts</title>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<!-- 引入 echarts.js -->&ndash;%&gt;--%>
    <%--&lt;%&ndash;<script src="echarts.common.min.js"></script>&ndash;%&gt;--%>
<%--</head>--%>
<%--<body>--%>
<%--<!-- 为ECharts准备一个具备大小（宽高）的Dom -->--%>
<%--<div id="main2" style="width: 600px;height:500px;"></div>--%>
<%--<script type="text/javascript">--%>
    <%--// 基于准备好的dom，初始化echarts实例--%>
    <%--var myChart = echarts.init(document.getElementById('main2'));--%>
    <%--jQuery.ajax({--%>
        <%--type:"POST",   //post提交方式默认是get--%>
        <%--url:"${ctxPath }/code/selectEcharts.action",--%>
        <%--dataType:"json",--%>

<%--//                data:$("#login").val(),   //序列化--%>
        <%--error:function(request) {      // 设置表单提交出错--%>
            <%--alert(request);--%>
        <%--},--%>
        <%--success:function(data) {--%>
            <%--var items = data.rows;--%>
            <%--console.log(items);--%>
            <%--var itemnamse = [];--%>
            <%--for(var i = 0 ; i<data.rows.length;i++) {--%>
                <%--itemnamse.push(data.rows[i].name);--%>
            <%--}--%>
            <%--console.log(itemnamse);--%>

            <%--// 指定图表的配置项和数据--%>
            <%--var option = {--%>
                <%--title : {--%>
                    <%--text: '主数据创建类型分布图',--%>
                    <%--x:'center'--%>
                <%--},--%>

                <%--tooltip : {--%>
                    <%--trigger: 'item',--%>
                    <%--formatter: "{a} <br/>{b} : {c} ({d}%)"--%>
                <%--},--%>
                <%--legend: {--%>
                    <%--orient: 'vertical',--%>
                    <%--x: 'right',--%>
                    <%--y:'middle',--%>
                    <%--data: itemnamse--%>
                <%--},--%>
                <%--series : [--%>
                    <%--{--%>
                        <%--name: '主数据类型',--%>
                        <%--type: 'pie',--%>
                        <%--radius : '60%',--%>
                        <%--center: ['50%', '50%'],--%>
                        <%--data:items,--%>
                        <%--label: {--%>

                            <%--normal: {--%>
                                <%--show: false--%>
                            <%--}--%>
                        <%--},--%>
                        <%--labelLine: {--%>
                            <%--normal: {--%>
                                <%--show: false--%>
                            <%--}--%>
                        <%--},--%>
                        <%--itemStyle: {--%>
                            <%--emphasis: {--%>
                                <%--shadowBlur: 10,--%>
                                <%--shadowOffsetX: 0,--%>
                                <%--shadowColor: 'rgba(0, 0, 0,    0.5)'--%>
                            <%--}--%>
                        <%--}--%>
                    <%--}--%>
                <%--]--%>
            <%--};--%>

            <%--// 使用刚指定的配置项和数据显示图表。--%>
            <%--myChart.setOption(option);--%>
        <%--}--%>
    <%--});--%>

<%--</script>--%>
<%--</body>--%>
<%--</html>--%>