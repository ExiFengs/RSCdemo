<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="if" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="rscdemo.pojo.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="rscdemo.pojo.Sentpieces" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Post post = (Post) request.getSession().getAttribute("post");
%>
<html>
<head>
    <title>我的派件</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <link rel="stylesheet" type="text/css" href="/css/icheck-bootstrap.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark" style="background-color: #f0fcff">
    <div class="container-fluid">
        <div class="navbar-header">
            <img src="/image/SF.png" alt=""
                 style="margin-left:10px;margin-right:10px;width: 60px;height: 50px;border-radius: 30px;">
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/post/sendpieces/1">我的派件</a></li>
            <li><a href="/post/receipt/1">我的收件</a></li>
            <li><a href="#">我的业绩</a></li>
            <li><a href="#">退出系统</a></li>
        </ul>
        <!--向导航条里添加表单时，要添加类为 导航里的表单“navbar-form” -->
        <div class="navbar-form navbar-right">
            <img src="/image/user.png" style="width: 30px;height: 30px;">
            <span class="h5">欢迎！<%=post.getPoname()%>，你当前为<c:if
                    test="${post.powork==true}">工作状态,工作区域为<%=post.getPoworkarea().getWoarea()%><%=post.getPoworkarea().getWotown()%>
            </c:if><c:if
                    test="${post.powork==false}">休息状态</c:if></span>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table col-lg-10">
            <thead>
            <tr class="active">
                <th>编号</th>
                <th>快件名称</th>
                <th>快件收件人/号码</th>
                <th>快件派送时间</th>
                <th>快件终点</th>
                <th>快件送达时间</th>
                <th>快件当前状态</th>
                <th>快件可修改状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${postsentpieces}" var="sentpiece">
                <c:if test="${sentpiece.sestate.stid == 0}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="无效时间"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 1}">
                    <c:set var="sestate" scope="request" value="准备派件"></c:set>
                    <c:set var="seendtime" scope="request" value="请稍等....."></c:set>
                    <c:set var="state" scope="request" value="1"></c:set>
                    <tr class="warning">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 2}">
                    <c:set var="sestate" scope="request" value="正在派件"></c:set>
                    <c:set var="seendtime" scope="request" value="等待到达"></c:set>
                    <c:set var="state" scope="request" value="2"></c:set>
                    <tr class="info">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 3}">
                    <c:set var="sestate" scope="request" value="派件完成"></c:set>
                    <c:set var="seendtime" scope="request" value="${sentpiece.seenddate}"></c:set>
                    <c:set var="state" scope="request" value="3"></c:set>
                    <tr class="success">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 4}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="邮客号码出错"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 5}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="邮客地址出错"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${sentpiece.sestate.stid == 6}">
                    <c:set var="sestate" scope="request" value="派件失败"></c:set>
                    <c:set var="seendtime" scope="request" value="其他"></c:set>
                    <c:set var="state" scope="request" value="0"></c:set>
                    <tr class="danger">
                </c:if>
                <td>${sentpiece.seid}</td>
                <td>${sentpiece.sename}</td>
                <td>${sentpiece.semailcustomername}/${sentpiece.sephone}</td>
                <td>${sentpiece.secreatedate}</td>
                <td>${sentpiece.seendadress}</td>
                <td>${seendtime}</td>
                <td>${sestate}</td>
                <td>
                    <c:if test="${post.powork==false}">
                        <a href="" class="btn btn-danger btn-xs" disabled="true">
                            <span class="glyphicon glyphicon-remove"></span>当前为休息状态
                        </a>
                    </c:if>
                    <c:if test="${post.powork==true}">
                        <c:if test="${state=='0'}">
                            <a href="" class="btn btn-danger btn-xs" disabled="true">
                                <span class="glyphicon glyphicon-remove"></span>该操作无效
                            </a>
                        </c:if>
                        <c:if test="${state=='1'}">
                            <a href="" class="btn btn-primary btn-xs" onclick="operation(2,${sentpiece.seid})">
                                <span class="glyphicon glyphicon-info-sign"></span>正在派件
                            </a>
                            <a href="" class="btn btn-danger btn-xs" data-id="${sentpiece.seid}" data-toggle="modal"
                               data-target="#lose">
                                <span class="glyphicon glyphicon-remove"></span>派件失败
                            </a>
                        </c:if>
                        <c:if test="${state=='2'}">
                            <a href="" class="btn btn-info btn-xs" onclick="operation(3,${sentpiece.seid})">
                                <span class="glyphicon glyphicon-edit"></span>派件完成
                            </a>
                            <a href="" class="btn btn-danger btn-xs" data-id="${sentpiece.seid}" data-toggle="modal"
                               data-target="#lose">
                                <span class="glyphicon glyphicon-remove"></span>派件失败
                            </a>
                        </c:if>
                        <c:if test="${state=='3'}">
                            <a href="" class="btn btn-info btn-xs" disabled="ture">
                                <span class="glyphicon glyphicon-edit"></span>派件已结束
                            </a>
                        </c:if>
                    </c:if>
                </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal fade" id="lose" tabindex="-1" role="dialog" aria-labelledby="loseLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    请选择派件<span class="seloseid" id="seloseid"></span>失败原因
                </h4>
            </div>
            <div class="modal-body" id="contentlose">
                <c:forEach items="${lose}" var="lo">
                    <div class="radio icheck-alizarin">
                        <input type="radio" value="${lo.stid}" id="${lo.stid}" name="lose"/>
                        <label for="${lo.stid}">${lo.stname}</label>
                    </div>
                </c:forEach>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="getloseid()">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
    function operation(type, id) {
        $.post("/post/operation", {
            type: type,
            id: id
        }, function (result) {
            alert(result);
            window.location.reload();
        });
    }

    $('#lose').on('show.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var id = button.data('id');
        var modal = $(this)
        modal.find('.seloseid').text(id);
    });
    function getloseid() {
        var stid = $("input[name='lose']:checked").val();
        var seid = $("#seloseid").text();
//        alert(stid+" "+seid);
        operation(stid, seid);
    }
    //    function getlose() {
    //        $.get("/post/lose",function (date,state) {
    //            $.each(date, function (key, value) {
    //                alert(value.stid);
    //                alert("hello");
    //            });
    //        })
    //    }
</script>
</body>
</html>
