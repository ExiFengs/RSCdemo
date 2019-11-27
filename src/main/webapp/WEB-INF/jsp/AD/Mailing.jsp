
<%@ page import="rscdemo.pojo.Management" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="if" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Management management = (Management) request.getSession().getAttribute("admin");
%>
<html>
<head>
    <title>工作人员表</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <link rel="stylesheet" type="text/css" href="/css/icheck-bootstrap.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
    <script type="text/javascript" src="/js/echarts.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark" style="background-color: #f0fcff">
    <div class="container-fluid">
        <div class="navbar-header">
            <img src="/image/SF.png" alt=""
                 style="margin-left:10px;margin-right:10px;width: 60px;height: 50px;border-radius: 30px;">
        </div>
        <ul class="nav navbar-nav">
            <li><a href="/admin/user/1">邮客表</a></li>
            <li><a href="/admin/work/1">邮差表</a></li>
            <li><a href="/admin/pie/1">派件表</a></li>
            <li class="active"><a href="/admin/Mailing/1">收件表</a></li>
        </ul>
        <!--向导航条里添加表单时，要添加类为 导航里的表单“navbar-form” -->
        <div class="navbar-form navbar-right">
            <img src="/image/user.png" style="width: 30px;height: 30px;">
            <span class="h5">欢迎！管理员:<%=management.getMaloginname()%></span>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table col-lg-10">
            <thead>
            <tr class="active">
                <th>编号</th>
                <th>寄件名称</th>
                <th>寄件收件人/号码</th>
                <th>寄件发出时间</th>
                <th>寄件目的地</th>
                <th>寄件送达时间</th>
                <th>寄件当前状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${recipientes}" var="recipients">
                <c:if test="${recipients.restate.stid == 0}">
                    <c:set var="restate" scope="request" value="寄件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="无效时间"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${recipients.restate.stid == 1}">
                    <c:set var="restate" scope="request" value="准备寄件"></c:set>
                    <c:set var="reendtime" scope="request" value="请稍等....."></c:set>
                    <c:set var="state" scope="request" value="1"></c:set>
                    <tr class="warning">
                </c:if>
                <c:if test="${recipients.restate.stid == 2}">
                    <c:set var="restate" scope="request" value="正在寄件"></c:set>
                    <c:set var="reendtime" scope="request" value="等待到达"></c:set>
                    <c:set var="state" scope="request" value="2"></c:set>
                    <tr class="info">
                </c:if>
                <c:if test="${recipients.restate.stid == 3}">
                    <c:set var="restate" scope="request" value="寄件完成"></c:set>
                    <c:set var="reendtime" scope="request" value="${recipients.reenddate}"></c:set>
                    <c:set var="state" scope="request" value="3"></c:set>
                    <tr class="success">
                </c:if>
                <c:if test="${recipients.restate.stid == 4}">
                    <c:set var="restate" scope="request" value="寄件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="邮客号码出错"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${recipients.restate.stid == 5}">
                    <c:set var="restate" scope="request" value="派件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="邮客地址出错"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${recipients.restate.stid == 6}">
                    <c:set var="restate" scope="request" value="派件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="其他"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <td>${recipients.reid}</td>
                <td>${recipients.rename}</td>
                <td>${recipients.remailcustomer.maname}/${recipients.rephone}</td>
                <td>${recipients.recreaterdate}</td>
                <td>${recipients.restateadress}</td>
                <td>${reendtime}</td>
                <td>${restate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
