<%@ page import="rscdemo.pojo.Management" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="if" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Management management = (Management) request.getSession().getAttribute("admin");
%>
<html>
<head>
    <title>用户表</title>
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
            <li class="active"><a href="/admin/user/1">邮客表</a></li>
            <li><a href="/admin/work/1">邮差表</a></li>
            <li><a href="/admin/pie/1">派件表</a></li>
            <li><a href="/admin/Mailing/1">收件表</a></li>
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
                <th>用户编号</th>
                <th>用户登录名</th>
                <th>用户真实姓名</th>
                <th>用户手机号码</th>
                <th>用户所在区域</th>
                <th>用户当前权限</th>
                <th>用户可修改权限</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${alluser}" var="user">
                <c:if test="${user.marole.roid == 1}">
                    <tr class="warning">
                </c:if>
                <c:if test="${user.marole.roid == 2}">
                    <tr class="info">
                </c:if>
                <c:if test="${user.marole.roid == 3}">
                    <tr class="success">
                </c:if>
                <c:if test="${user.marole.roid == 4}">
                    <tr style="background-color: darkorchid">
                </c:if>
                <td>${user.maid}</td>
                <td>${user.maloginname}</td>
                <td>${user.maname}</td>
                <td>${user.maphone}</td>
                <td>${user.maworkingarea.woarea}&nbsp;${user.maworkingarea.wotown}</td>
                <td>${user.marole.roname}</td>
                <td>
                <c:if test="${user.marole.roid==1}">
                    <a href="" class="btn btn-danger btn-xs" disabled="true">
                        <span class="glyphicon glyphicon-remove"></span>用户不足修改权限
                    </a>
                </c:if>
                <c:if test="${user.marole.roid!=1}">
                    <a href="" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#quan" data-name="${user.maname}"
                       data-id="${user.maid}">
                        <span class="glyphicon glyphicon-info-sign"></span>修改用户权限
                    </a>
                </c:if>
                </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal fade" id="quan" tabindex="-1" role="dialog" aria-labelledby="quanLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="quanLabel">
                    请选择编号<span class="maid"></span>用户<span class="maname" id="maname"></span>需要更改的权限
                </h4>
            </div>
            <div class="modal-body" id="contentlose">

                <div class="radio icheck-info">
                    <input type="radio" value="2" id="ROLE_COMMON" name="role"/>
                    <label for="ROLE_COMMON">ROLE_COMMON(普通用户)</label>
                </div>
                <div class="radio icheck-info">
                    <input type="radio" value="3" id="ROLE_VIP" name="role"/>
                    <label for="ROLE_VIP">ROLE_VIP(VIP用户)</label>
                </div>
                <div class="radio icheck-info">
                    <input type="radio" value="4" id="ROLE_UNION" name="role"/>
                    <label for="ROLE_UNION">ROLE_UNION(集团用户)</label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="getchangerole()">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
    $('#quan').on('show.bs.modal', function (e) {
        var mo = $(e.relatedTarget);
        var uid = mo.data('id');
        var maname = mo.data('name');
        var modal = $(this);
        modal.find('.maid').text(uid);
        modal.find('.maname').text(maname);
    });
    function getchangerole() {
        var userid = $('.maid').text();
        var roid = $("input[name='role']:checked").val();
        $.post("/admin/changeuserrole",{
            maid : userid,
            roleid : roid
        },function (data) {
            alert(data);
            window.location.reload();
        })
    }
</script>
</body>
</html>
