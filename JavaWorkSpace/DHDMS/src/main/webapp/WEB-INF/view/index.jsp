

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <title>东华链条集团经销商管理系统</title>
    <meta charset="utf-8">
    <meta name="keywords" content="HMDM主数据管理系统,企业主数据管理,物料主数据,ERP主数据,SAP主数据" />
    <meta name="description" content="HMDM主数据管理系统,辅助企业实现物料、供应商等主数据的管理管控,为一物一图一码原则保驾护航." />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" sizes="any" mask href="${ctxPath }/static/imgages/dhlogo.png">
    <!-- 移动设备 viewport -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui">
    <meta name="author" content="admui.com">
    <!-- 360浏览器默认使用Webkit内核 -->
    <meta name="renderer" content="webkit">
    <!-- 禁止百度SiteAPP转码 -->
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <!-- Chrome浏览器添加桌面快捷方式（安卓） -->
    <link rel="icon" type="image/png" href="/DMS/static/login/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <!-- Safari浏览器添加到主屏幕（IOS） -->
    <link rel="icon" sizes="192x192" href="/DMS/static/login/apple-touch-icon.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="HMDM">
    <!-- Win8标题栏及ICON图标 -->
    <link rel="apple-touch-icon-precomposed" href="/DMS/static/login/apple-touch-icon.png">
    <meta name="msapplication-TileImage" content="/DMS/static/login/favicon.png">
    <meta name="msapplication-TileColor" content="#62a8ea">
    <!-- 样式 -->
    <link rel="stylesheet" href="/DMS/static/login/bootstrap.css">
    <link rel="stylesheet" href="/DMS/static/login/site.css" id="siteStyle">

    <!--[if lte IE 9]>
    <meta http-equiv="refresh" content="0; url='http://www.admui.com/ie/'" />
    <![endif]-->
    <!--[if lt IE 10]>
    <!--<script src="http://cdn.admui.com/demo/pjax/1.2.0/vendor/media-match/media.match.min.js"></script>-->
    <!--<script src="http://cdn.admui.com/demo/pjax/1.2.0/vendor/respond/respond.min.js"></script>-->
    <![endif]-->




    <!-- 自定义 -->
    <link rel="stylesheet" href="/DMS/static/login/login.css">
    <!-- 插件 -->
    <link rel="stylesheet" href="/DMS/static/login/animsition.css">
    <!-- 图标 -->
    <link rel="stylesheet" href="/DMS/static/login/web-icons.css">
    <link rel="stylesheet" href="/DMS/static/login/images/login.jpg">
    <link rel="stylesheet" href="/DMS/static/login/font-awesome.css">
    <!-- 插件 -->
    <link rel="stylesheet" href="/DMS/static/login/bootstrap-select.css">
    <link rel="stylesheet" href="/DMS/static/login/formValidation.css">
    <script type="text/javascript" src="/DMS/static/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="/DMS/static/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="/DMS/static/js/jquery.form.js"></script>
    <script type="text/javascript" src="/DMS/static/js/extJs.js"></script>
    <script type="text/javascript" src="/DMS/static/js/ext/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="/DMS/static/js/ext/ext-all.js"></script>
    <script type="text/javascript" src="/DMS/static/css/1.5.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/DMS/static/css/1.5.2/locale/easyui-lang-zh_CN.js"></script>
    <!-- 百度统计 -->
    <script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?c9dd85291ea88dcf64671a7dfa65e0ef";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>

    <!-- 客服组件 -->
    <%--<script src="/DMS/static/login/main.js  "  charset="UTF-8" id="kf5-provide-supportBox" kf5-domain="admui.kf5.com"></script>--%>
</head>

<body class="page-login layout-full page-dark" >

<div class="page height-full">
    <div class="page-content height-full">
        <div class="page-brand-info vertical-align animation-slide-left hidden-xs">
            <div class="page-brand vertical-align-middle">
                <div class="brand">

                </div>
                <h2 class="hidden-sm">东华链条集团经销商管理系统</h2>
                <ul class="list-icons hidden-sm">
                    <li>
                        <i class="wb-check" aria-hidden="true"></i> 以企业的销售渠道建设为重点，对整条供应链中的信息流进行系统规划、全面实施和过程监控。
                    </li>
                    <li>
                        <i class="wb-check" aria-hidden="true"></i> 是一套势在加强企业与经销商之间业务的紧密合作，通过规范经销商内部的业务流程以提高其对资源管理的能力。
                    </li>
                    <li><i class="wb-check" aria-hidden="true"></i> 对外向客户提供全方位的销售体验和全程服务关怀的商业模式。
                    </li>
                </ul>

            </div>
        </div>
        <div class="page-login-main animation-fade">

            <div class="vertical-align">
                <div class="vertical-align-middle">
                    <div class="brand visible-xs text-center">
                        <img class="brand-img" src="http://cdn.admui.com/demo/pjax/1.2.0/images/logo.svg" height="50" alt="HMDM">
                    </div>
                    <h3 class="hidden-xs">
                       欢迎登录东华链条集团DHDMS

                    </h3>
                    <p class="hidden-xs">DHDMS 经销商管理系统</p>

                    <form class="login-form" method="post" id="loginForm">
                        <div class="form-group">

                                <label class="sr-only" for="identity">选择部门</label>
                                <%--<select class="form-control"  id="identity">--%>

                                <%--</select>--%>
                            <input type="text" class="form-control" id="identity" name="loginName" placeholder="请输入经销商代码">
                        </div>

                        <div class="form-group">

                                <label class="sr-only" for="username">用户名</label>
                                <%--<select  type="text" class="form-control" id="username" name="loginName" placeholder="请输入用户名">--%>
                                <%--</select>--%>
                                <input type="text" class="form-control" id="username" name="loginName" placeholder="请输入手机号">

                        </div>

                        <div class="form-group">

                                <label class="sr-only" for="password">密码</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">

                        </div>


                        <div >
                            <div class="checkbox-custom checkbox-inline checkbox-primary pull-left">
                                <input type="checkbox" id="remember" name="remember">
                                <label for="remember">自动登录</label>
                            </div>
                            <div class="pull-right">

                            </div>
                        </div>
                        <div class="collapse" id="forgetPassword" aria-expanded="true">
                            <div class="alert alert-warning alert-dismissible" role="alert">
                                请返回官网点击登录按钮找回密码
                            </div>
                        </div>
                        <button  onclick="login();return false;" type="submit" class="btn btn-primary btn-block margin-top-30">立即登录</button>
                    </form>
                </div>
            </div>
            <footer class="page-copyright">
                <p>东华链条 &copy;
                    <a href="http://www.dhchain.com/" target="_blank">dhchain.com</a>
                </p>
            </footer>
        </div>
    </div>
</div>
<script>


    var basePath = "/DMS";
        var department = document.getElementById('identity');
        var username = document.getElementById('username');
        jQuery.ajax({
            type:"POST",   //post提交方式默认是get
            url:basePath+"/selectDepartment.action",
            dataType:"json",

//                data:$("#login").val(),   //序列化
            error:function(request) {      // 设置表单提交出错
                alert(request);


            },
            success:function(data) {


                var option1 = new Option('请选择部门', '');
                department.options.add(option1);
                for(var i = 0 ; i<data.rows.length;i++){
                    var option = new Option(data.rows[i].department, data.rows[i].department);
                    department.options.add(option);

                }
            }
        });
        department.addEventListener("change",onchange);


    function onchange(){
        var  departmentValue = department.value;
        if(departmentValue!=''){
            jQuery.ajax({
                type:"POST",   //post提交方式默认是get
                url:basePath+"/select.action",
                dataType:"json",
                data:{
                    department: departmentValue,

                },
//                data:$("#login").val(),   //序列化
                error:function(request) {      // 设置表单提交出错
                    alert('经销商代码错误');
                    $(" #identity").val("");
                },
                success:function(data) {
                    username.innerHTML="";
                    for(var i = 0 ; i<data.rows.length;i++){
                        for(var i = 0 ; i<data.rows.length;i++){
                            var option = new Option(data.rows[i].name, data.rows[i].name);
                            username.options.add(option);

                        }
                    }
                }
            });
        }else {
            alert('请输入经销商代码 ');
        }

    }
    function login(){
        var department = document.getElementById("identity").value;
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        var rememberMe = document.getElementById("remember").value;
        if(department == ""){
            alert("请输入经销商代码");

        }else if(username == ""){
            alert("请输入手机号");
//            $('#login').textbox().next('span').find('input').focus();
        }else if(password == "")
        {
            alert("请输入密码");
//            $('#password').textbox().next('span').find('input').focus();
        }
        else{

            //ajax异步提交
            jQuery.ajax({
                type:"POST",   //post提交方式默认是get
                url:basePath+"/login.action",
                dataType:"json",
                data:{
                    username: username,
                    password:password,
                    rememberMe:rememberMe
                },
//                data:$("#login").val(),   //序列化
                error:function(results) {      // 设置表单提交出错
                    console.log(results);
                },
                success:function(results) {
                    console.log(results);
                    if (results.IsOK=="N"){alert(results.ErrMes);return;}
                    localStorage.setItem("Department",department);
                    localStorage.setItem("MDM",results.MDM);
                    localStorage.setItem("User",results.User);
                    localStorage.setItem("actGroup",results.actGroup);
                    window.location.href = '/DMS/main';
                }
            });
        }
    }
</script>
<!-- JS -->

<script src="/DHDMS/static/login/jquery.js"></script>
<script src="/DHDMS/static/login/bootstrap.js"></script>
<script src="/DHDMS/static/login/bootstrap-select.min.js"></script>
<script src="/DHDMS/static/login/formValidation.min.js" data-name="formValidation"></script>
<script src="/DHDMS/static/login/bootstrap.min.js" data-deps="formValidation"></script>

</body>

</html>
