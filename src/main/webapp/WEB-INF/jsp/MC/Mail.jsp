<%@ page import="rscdemo.pojo.Mailcustomer" %>
<%@ page import="rscdemo.pojo.Role" %>
<%@ page import="java.util.List" %>
<%@ page import="rscdemo.pojo.Recipient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Mailcustomer mailcustomer = (Mailcustomer) request.getSession().getAttribute("mailcustomer");
    Role marole = mailcustomer.getMarole();
    List<String> woareas = (List<String>) request.getAttribute("woareas");
    List<Recipient> recipients = (List<Recipient>) request.getAttribute("recipients");
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
                <img src="/image/SF.png" alt="RSC" class="img-circle"  style="width: 52px;height: 52px;">
            </a>
        </div>
        <ul class="nav navbar-nav">
            <li role="presentation"><a href="/user/pagesent/1">查件</a></li>
            <li role="presentation" class="active"><a href="/user/mail/1">寄件</a></li>
            <li role="presentation"><a href="/user/info">我的</a></li>
            <li role="presentation"><a href="#">退出系统</a></li>
            <p class='navbar-text pull-right'>
                <span class='navbar-link'>用户：<%=mailcustomer.getMaloginname()%>，你当前的权限为：<%=marole.getRoname()%></span>
            </p>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
                <c:if test="<%=marole.getRoid()==1%>">
                    <button class="btn btn-info col-lg-1 pull-right" data-toggle="modal" data-target="#mymodal">新增寄件</button>
                </c:if>
                <c:if test="<%=marole.getRoid()>1%>">
                    <button class="btn btn-info col-lg-1 pull-right" data-toggle="modal" data-target="#mymoda2">新增寄件</button>
                </c:if>
        <table class="table col-lg-10">
            <thead>
            <tr class="active">
                <th>编号</th>
                <th>快件名称/费用</th>
                <th>快件起点</th>
                <th>快件派送人</th>
                <th>快件派送时间</th>
                <th>快件状态</th>
                <th>快件送达时间</th>
                <th>快件终点</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${recipients}" var="recipient">
                <c:if test="${recipient.restate.stid == 0}">
                    <c:set var="restate" scope="request" value="寄件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="无效时间"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${recipient.restate.stid == 1}">
                    <c:set var="restate" scope="request" value="准备寄件"></c:set>
                    <c:set var="reendtime" scope="request" value="请稍等....."></c:set>
                    <tr class="warning">
                </c:if>
                <c:if test="${recipient.restate.stid == 2}">
                    <c:set var="restate" scope="request" value="正在寄件"></c:set>
                    <c:set var="reendtime" scope="request" value="等待到达"></c:set>
                    <tr class="info">
                </c:if>
                <c:if test="${recipient.restate.stid ==3}">
                    <c:set var="restate" scope="request" value="寄件完成"></c:set>
                    <c:set var="reendtime" scope="request" value="${recipient.reenddate}"></c:set>
                    <tr class="success">
                </c:if>
                <c:if test="${recipient.restate.stid == 4}">
                    <c:set var="restate" scope="request" value="寄件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="邮客号码出错"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${recipient.restate.stid == 5}">
                    <c:set var="restate" scope="request" value="寄件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="邮客地址出错"></c:set>
                    <tr class="danger">
                </c:if>
                <c:if test="${recipient.restate.stid == 6}">
                    <c:set var="restate" scope="request" value="寄件失败"></c:set>
                    <c:set var="reendtime" scope="request" value="其他"></c:set>
                    <tr class="danger">
                </c:if>
                <td>${recipient.reid}</td>
                <td>${recipient.rename}/${recipient.recount}</td>
                <td>${recipient.restateadress}</td>
                <td>${recipient.repost.poname}(${recipient.repost.pophone})</td>
                <td>${recipient.recreaterdate}</td>
                <td>${restate}</td>
                <td>${reendtime}</td>
                <td>${recipient.reendadress.woarea}&nbsp;${recipient.reendadress.wotown}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal" id="mymodal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h4 class="modal-title">不好意思，你当前权限不足</h4>

            </div>
            <div class="modal-body">
                <p>是否进行个人信息完善，提高权限？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <a class="btn btn-success"href="/user/info">确定</a>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="mymoda2">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h4 class="modal-title">你好，用户:${mailcustomer.maname},您可以享受<%=marole.getRodiscount()%>折优惠</h4>

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
                            <label for="sephone" class="col-lg-3 text-right control-label">联系方式</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" id="sephone" value="<%=mailcustomer.getMaphone()%>">
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
                                <textarea id="adress" class="form-control text-left" rows="3" name="textarea" style="resize: none;"><% if (mailcustomer.getMaadress() != null) {out.print(mailcustomer.getMaadress());}%></textarea>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button class="btn btn-success" onclick="upsend()">确定</button>
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
    function upsend() {
        var woid = $("#wotown").val();
        if (woid==-1){
            alert("请选择具体所在镇！");
            return;
        }
        var sename = $("#sename").val();
        var sephone = $("#sephone").val();
        var address = $("#adress").val();
        $.post("/user/upsend",{
            usname:sename,
            usphone:sephone,
            woid:woid,
            readress:address
        },function (result) {
            alert(result);
            window.location.reload();
        })

    }
</script>
</body>
</html>
