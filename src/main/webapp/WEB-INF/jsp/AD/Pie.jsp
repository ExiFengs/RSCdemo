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
            <li class="active"><a href="/admin/pie/1">派件表</a></li>
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
        <button class="btn btn-info col-lg-1 pull-right" data-toggle="modal" data-target="#addsentpiece">新增派件</button>
        <table class="table col-lg-10">
            <thead>
            <tr class="active">
                <th>派件编号</th>
                <th>派件名称</th>
                <th>派件起点</th>
                <th>派件邮客/号码</th>
                <th>派件时间</th>
                <th>派件邮差/号码</th>
                <th>派件终点</th>
                <th>派件完成时间</th>
                <th>派件状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${allsentpieces}" var="sentpiece">
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
                    <td>${sentpiece.sestateadress.woarea}&nbsp;${sentpiece.sestateadress.wotown}</td>
                    <td>${sentpiece.semailcustomername}/${sentpiece.sephone}</td>
                    <td>${sentpiece.secreatedate}</td>
                    <td>${sentpiece.sepost.poname}/${sentpiece.sepost.pophone}</td>
                    <td>${sentpiece.seendadress}</td>
                    <td>${seendtime}</td>
                    <td>${sestate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal" id="addsentpiece">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h4 class="modal-title">你好，管理员！请输入派件信息</h4>

            </div>
            <div class="modal-body">
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="sename" class="col-lg-3 text-right control-label">快件名称</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" id="sename">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="seusername" class="col-lg-3 text-right control-label">快件人</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" id="seusername">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="sephone" class="col-lg-3 text-right control-label">联系方式</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" id="sephone">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="adress" class="col-lg-3 text-right control-label">所在地址</label>
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
                                <textarea id="adress" class="form-control text-left" rows="3" name="textarea" style="resize: none;"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button class="btn btn-success" onclick="addsentpiece()">确定</button>
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
        $.get("/admin/town/" + area, function (data, status) {
            $('#wotown').empty();
            $.each(data, function (key, value) {
                $('#wotown').append("<option value='" + value.woid + "'>" + value.wotown + "</option>");
            });
            $('#wotown').attr("disabled", false);
        });
    }
    function addsentpiece() {
        var sename = $("#sename").val();
        var seusername = $("#seusername").val();
        var sephone = $("#sephone").val();
        var seworea = $("#wotown").val();
        var seaddress = $("#adress").val();
        if (sename==""||sephone==""||sephone==""||seworea==""||seaddress==""){
            alert("请完善派件信息！");
            return;
        }
        $.post("/admin/addsentpiece",{
            seename : sename,
            seephone : sephone,
            seeusername : seusername,
            seeworea : seworea,
            seeadress : seaddress
        },function (data) {
            alert(data);
            window.location.reload();
        })
    }
</script>
</body>
</html>
