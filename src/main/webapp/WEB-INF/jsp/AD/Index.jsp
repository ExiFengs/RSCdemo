<%--
  Created by IntelliJ IDEA.
  User: ou
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员首页</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <link rel="stylesheet" type="text/css" href="/css/signin.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body>
<div class="signin">
    <div class="signin-head"><img src="/image/admin.png" alt="" class="img-circle"></div>
    <form class="form-signin">
        <input type="text" id="name" class="form-control" placeholder="用户名" required autofocus/>
        <input type="password" id="adminpassword" class="form-control" placeholder="密码" required/>
        <button class="btn btn-lg btn-warning btn-block" type="button" onclick="admin();">登录</button>
        <label class="checkbox">
            <input type="checkbox" value="remember-me"> 记住我
        </label>
    </form>
</div>
<script>
    function admin() {
        var adminname = $('#name').val();
        var password = $('#adminpassword').val();
        $.post("/admin/login",{
            adminname:adminname,
            adminpassword:password
        },function (result) {
            if(result==0){
                alert("你的账户不存在！是否输入有错？")
            }else {
                alert("登录成功！");
                window.location.replace("/admin/user/1");
            }
        })
    }


</script>
</body>
</html>
