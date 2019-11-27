
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>邮差首页</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body>
<div class="container" style="margin-top: 60px;background-color: #c1e2b3;border-radius: 30px;">
    <div class="row">
        <div class="col-sm-4 col-sm-offset-4 form-box">
            <div class="form-top">
                <div class="form-top-left">
                    <span class="h3">Login to our Post</span>
                    <img src="/image/word.png">
                    <h5>请输入你的用户名和密码：</h5>
                </div>
                <div class="form-top-right">
                    <i class="fa fa-lock"></i>
                </div>
            </div>
            <div class="form-bottom">
                <div class="form-group">
                    <label class="sr-only" for="postname">Username</label>
                    <input type="text" placeholder="Username..."
                           class="form-control" id="postname">
                </div>
                <div class="form-group">
                    <label class="sr-only" for="postpassword">Password</label>
                    <input type="password" placeholder="Password..."
                           class="form-control" id="postpassword">
                </div>
                <button class="btn btn-success col-sm-12 col-lg-12" onclick="ispost()" style="margin-bottom: 10px">登录
                </button>
            </div>
        </div>
    </div>
</div>
<script>
    function ispost() {
        var poname = $("#postname").val();
        var popassword = $("#postpassword").val();
        $.post("/post/login", {
            name: poname,
            password: popassword
        }, function (result) {
            if (result == 1) {
                alert("登录成功！")
                window.location.replace("/post/sendpieces/1");
            } else {
                alert("登录失败，请查看密码或是用户名出错！");
            }
        });
    }
</script>
</body>
</html>
