<%@ page import="rscdemo.pojo.Mailcustomer" %>
<%@ page import="rscdemo.pojo.Role" %>
<%@ page import="java.util.List" %>
<%@ page import="rscdemo.pojo.Sentpieces" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Mailcustomer mailcustomer = (Mailcustomer) request.getSession().getAttribute("mailcustomer");
    Role marole = mailcustomer.getMarole();
    List<Sentpieces> sentpieces = (List<Sentpieces>) request.getAttribute("sentpieces");
    String info = (String) request.getAttribute("info");
%>
<html>
<head>
    <title>Home</title>
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
                <c:if test="${info!=null}">
                    <span class='navbar-link'></span>
                </c:if>
                <span class='navbar-link'>用户：<%=mailcustomer.getMaloginname()%>，你当前的权限为：<%=marole.getRoname()%></span>
            </p>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table col-lg-10">
            <thead>
            <tr class="active">
                <th>编号</th>
                <th>快件名称</th>
                <th>快件起点</th>
                <th>快件派送人</th>
                <th>快件派送时间</th>
                <th>快件状态</th>
                <th>快件送达时间</th>
                <th>快件终点</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sentpieces}" var="sentpiece">
                <c:if test="${sentpiece.sestate.stid == 0}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="无效时间"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 1}">
                    <c:set var="sestate" scope="request" value="准备派件"></c:set>
                    <c:set var="seendtime" scope="request" value="请稍等....."></c:set>
                    <tr class="warning">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 2}">
                    <c:set var="sestate" scope="request" value="正在派件"></c:set>
                    <c:set var="seendtime" scope="request" value="等待到达"></c:set>
                    <tr class="info">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 3}">
                    <c:set var="sestate" scope="request" value="派件完成"></c:set>
                    <c:set var="seendtime" scope="request" value="${sentpiece.seenddate}"></c:set>
                    <tr class="success">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 4}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="邮客号码出错"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 5}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="邮客地址出错"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 6}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="其他"></c:set>
                    <tr class="danger">
                </c:if>
                <td>${sentpiece.seid}</td>
                <td>${sentpiece.sename}</td>
                <td>${sentpiece.sestateadress.woarea}&nbsp;${sentpiece.sestateadress.wotown}</td>
                <td>${sentpiece.sepost.poname}(${sentpiece.sepost.pophone})</td>
                <td>${sentpiece.secreatedate}</td>
                <td>${sestate}</td>
                <td>${seendtime}</td>
                <td>${sentpiece.seendadress}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
