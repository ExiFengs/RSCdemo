<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="if" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="rscdemo.pojo.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Post post = (Post) request.getSession().getAttribute("post");
%>
<html>
<head>
    <title>我的收件</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/icheck-bootstrap.css">
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark" style="background-color: #f0fcff">
    <div class="container-fluid">
        <div class="navbar-header">
            <img src="/image/SF.png" alt=""
                 style="margin-left:10px;margin-right:10px;width: 60px;height: 50px;border-radius: 30px;">
        </div>
        <ul class="nav navbar-nav">
            <li><a href="/post/sendpieces/1">我的派件</a></li>
            <li class="active"><a href="/post/receipt/1">我的收件</a></li>
            <li><a href="#">我的业绩</a></li>
            <li><a href="#">退出系统</a></li>
        </ul>
        <!--向导航条里添加表单时，要添加类为 导航里的表单“navbar-form” -->
        <div class="navbar-form navbar-right">
            <img src="/image/user.png" style="width: 30px;height: 30px;">
            <span class="h5">欢迎！<%=post.getPoname()%>，你当前为<% if (post.getPowork()){%>工作状态,工作区域为<%=post.getPoworkarea().getWoarea()%>
                <%=post.getPoworkarea().getWotown()%>
                <%}else {%>休息状态<%}%>
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
                <th>寄件可修改状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${postrecipients}" var="recipients">
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
                <td>
                    <%
                        if (post.getPowork()==false){
                    %>
                    <a href="" class="btn btn-danger btn-xs" disabled="true">
                        <span class="glyphicon glyphicon-remove"></span>当前为休息状态
                    </a>
                    <%}else {%>
                    <c:if test="${state=='0'}">
                        <a href="" class="btn btn-danger btn-xs" disabled="true">
                            <span class="glyphicon glyphicon-remove"></span>该操作无效
                        </a>
                    </c:if>
                    <c:if test="${state=='1'}">
                        <a href="" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal"
                           data-id="${recipients.reid}" data-role="${recipients.remailcustomer.marole.roname}"
                           data-discount="${recipients.remailcustomer.marole.rodiscount}">
                            <span class="glyphicon glyphicon-info-sign"></span>正在寄件
                        </a>
                        <a href="" class="btn btn-danger btn-xs" data-id="${recipients.reid}" data-toggle="modal"
                           data-target="#lose">
                            <span class="glyphicon glyphicon-remove"></span>寄件失败
                        </a>
                    </c:if>
                    <c:if test="${state=='2'}">
                        <a href="" class="btn btn-info btn-xs" onclick="operation(3,${recipients.reid})">
                            <span class="glyphicon glyphicon-edit"></span>寄件完成
                        </a>
                        <a href="" class="btn btn-danger btn-xs" data-id="${recipients.reid}" data-toggle="modal"
                           data-target="#lose">
                            <span class="glyphicon glyphicon-remove"></span>寄件失败
                        </a>
                    </c:if>
                    <c:if test="${state=='3'}">
                        <a href="" class="btn btn-info btn-xs" disabled="ture">
                            <span class="glyphicon glyphicon-edit"></span>寄件已结束
                        </a>
                    </c:if>
                    <%}%>
                </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    请输入<span class="reid"></span>寄件的费用
                </h4>
                <h6>该用户为<span class="role"></span>用户，打<span class="discount"></span>折</h6>
            </div>
            <div class="modal-body">
                <table>
                    <tr>
                        <td><input class="form-control" id="many" type="number" placeholder="费用"></td>
                        <td><a class="btn btn-primary" onclick="discountmany();">确定</a></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-right">该寄件所需费用为：<span class="nowcount"></span></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="upchange();">
                    提交更改
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="lose" tabindex="-1" role="dialog" aria-labelledby="loseLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="loseLabel">
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
    $('#myModal').on('show.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var id = button.data('id');
        var role = button.data('role');
        var discount = button.data('discount')
        var modal = $(this)
        modal.find('.reid').text(id);
        modal.find('.role').text(role);
        modal.find('.discount').text(discount);
    });
    function discountmany() {
        var reid = $('.reid').text();
        var discount = $('.discount').text();
        var many = $('#many').val();
        var now = many * discount;
        $('.nowcount').text(now);
    }
    function upchange() {
        var reid = $('.reid').text();
        var discount = $('.discount').text();
        var many = $('#many').val();
        var now = many * discount;
        $.post("/post/getcount", {
            reid: reid,
            renamy: now
        }, function (result) {
            alert(result);
            $('#many').val("");
            $('.nowcount').text("");
            window.location.href='/post/receipt/1';
        });
    }

    function operation(type, id) {
        $.post("/post/operationre", {
            type: type,
            id: id
        }, function (result) {
            alert(result);
            window.location.replace("/post/receipt/1");
        });
    }

    $('#lose').on('show.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var id = button.data('id');
        var modal = $(this);
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
