
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户首页</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body>
<div class="container" style="margin-top: 60px;background-color: #fff19c;border-radius: 30px;">
    <div class="row">
        <form name="myform" method="post">
            <div class="col-sm-4 col-sm-offset-4 form-box">
                <div class="form-top">
                    <div class="form-top-left">
                        <span class="h3">Login to our User</span>
                        <img src="/image/mcuser.png">
                        <h5>输入你的用户名和密码：</h5>
                    </div>
                    <div class="form-top-right">
                        <i class="fa fa-lock"></i>
                    </div>
                </div>
                <div class="form-bottom">
                    <div class="form-group">
                        <label class="sr-only" for="name">Username</label>
                        <input type="text" placeholder="Username..." required autofocus
                               class="form-control" id="name" name="loginname">
                    </div>
                    <div class="form-group">
                        <label class="sr-only" for="adminpassword">Password</label>
                        <input type="password" placeholder="Password..."
                               class="form-control" id="adminpassword" name="password">
                    </div>
                    <button type="submit" class="btn btn-success col-sm-6 col-lg-6" onclick="login()" style="margin-bottom: 10px">
                        登录
                    </button>
                    <button type="submit" class="btn btn-primary col-sm-6 col-lg-6" onclick="register()" style="margin-bottom: 10px">
                        注册
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function login() {
        document.myform.action="/user/login";
        document.myform.submit();
    }
    function register() {
        document.myform.action="/user/register";
        document.myform.submit();
        // window.location.replace("/user/register");
    }
</script>
</body>
</html>
