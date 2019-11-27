<%@ page import="rscdemo.pojo.Mailcustomer" %>
<%@ page import="rscdemo.pojo.Role" %>
<%@ page import="java.util.List" %>
<%@ page import="rscdemo.pojo.Workingarea" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Mailcustomer mailcustomer = (Mailcustomer) request.getSession().getAttribute("mailcustomer");
    Role marole = mailcustomer.getMarole();
    List<String> woareas = (List<String>) request.getAttribute("woareas");
    List<Workingarea> workingareas = (List<Workingarea>) request.getAttribute("workingareas");
%>

<html>
<head>
    <title>Mail</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body>

<div class="container center-block">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">完善注册信息</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="name" class="col-lg-4 text-right control-label">真实姓名：</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" id="name" name="name" minlength="2" required <%if (mailcustomer.getManame()!=null){%>value="<%=mailcustomer.getManame()%>" disabled="disabled"<%}%>>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-lg-4 text-right control-label">手机号码：</label>
                            <div class="col-lg-8">
                                <input type="tel" class="form-control text-left" id="phone" name="phone" minlength="11" required
                                    <%if(mailcustomer.getMaphone()!=null){%>value="<%=mailcustomer.getMaphone()%>"<% }%>>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-offset-4">
                                <button type="button" class="btn btn-success col-lg-4" onclick="upinfo()">提交</button>
                                <button type="button" class="btn btn-danger col-lg-4 col-lg-offset-1">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    function upinfo() {

        var username = $("#name").val();
        var phone = $("#phone").val();
        $.post("/user/upinfo",{
            username:username,
            phone:phone,
        },function (result) {
            alert(result)
            window.location.replace("/user/SuccessRegister");

        })
    }

</script>
</body>
</html>
