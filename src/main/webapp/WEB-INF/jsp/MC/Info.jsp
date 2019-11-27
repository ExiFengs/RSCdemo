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
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" style="padding-top: 0" href="#">
                <img src="/image/SF.png" alt="RSC" class="img-circle" style="width: 52px;height: 52px;">
            </a>
        </div>
        <ul class="nav navbar-nav">
            <li role="presentation"><a href="/user/pagesent/1">查件</a></li>
            <li role="presentation"><a href="/user/mail/1">寄件</a></li>
            <li role="presentation" class="active"><a href="/user/info">我的</a></li>
            <li role="presentation"><a href="#">退出系统</a></li>
            <p class='navbar-text pull-right'>
                <span class='navbar-link'>用户：<%=mailcustomer.getMaloginname()%>，你当前的权限为：<%=marole.getRoname()%></span>
            </p>
        </ul>
    </div>
</nav>
<div class="container center-block">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">个人信息</h4>
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
                            <label for="adress" class="col-lg-4 text-right control-label">常用地址：</label>
                            <div class="col-lg-8">
                                <div class="control-group">
                                    <div class="controls">
                                        <label>所在区：</label>
                                        <select class="input-xlarge" id="woareas" onchange="town();">
                                            <option value="-1">请选择</option>
                                            <c:forEach items="${woareas}" var="woarea">
                                                <option>${woarea}</option>
                                            </c:forEach>
                                        </select>
                                        <label>所在镇：</label>
                                        <select class="input-xlarge" id="wotown" name="woid" disabled="disabled">
                                            <option value="-1">请选择</option>
                                        </select>
                                    </div>

                                </div>
                                <textarea id="adress" class="form-control text-left" rows="3" name="textarea" style="resize: none;"><%=mailcustomer.getMaadress()%></textarea>
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
    function town() {
        var area = $("#woareas").val();
        if (area == -1) {
            alert("请选择正确所在区！");
            $('#wotown').empty();
            $('#wotown').append("<option value=-1>请选择</option>").attr("disabled", true);
            return;
        }
        $.get("/user/town/" + area, function (data, status) {
            $('#wotown').empty();
            $.each(data, function (key, value) {
                $('#wotown').append("<option value='" + value.woid + "'>" + value.wotown + "</option>");
            });
            $('#wotown').attr("disabled", false);
        });
    }
    function upinfo() {
        var woid = $("#wotown").val();
        if (woid==-1){
            alert("请选择具体所在镇！");
            return;
        }
        var username = $("#name").val();
        var phone = $("#phone").val();
        var address = $("#adress").val();
        $.post("/user/upinfo",{
            username:username,
            phone:phone,
            woid:woid,
            address:address
        },function (result) {
            alert(result);
            window.location.reload();
        })
    }
</script>
</body>
</html>
