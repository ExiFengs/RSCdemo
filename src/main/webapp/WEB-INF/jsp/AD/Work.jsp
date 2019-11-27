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
            <li class="active"><a href="/admin/work/1">邮差表</a></li>
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
        <button class="btn btn-info col-lg-1 pull-right" data-toggle="modal" data-target="#addpost">新增邮差</button>
        <table class="table col-lg-10">
            <thead>
            <tr class="active">
                <th>邮差编号</th>
                <th>邮差姓名</th>
                <th>手机号码</th>
                <th>工作状态</th>
                <th>工作区域</th>
                <th>编辑邮差</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${works}" var="work">
                <c:if test="${work.powork==false}"><tr style="background-color: #fffcac"></c:if>
                <c:if test="${work.powork==true}"><tr style="background-color: #c1fdff"></c:if>
                <td>${work.poid}</td>
                <td>${work.poname}</td>
                <td>${work.pophone}</td>
                <c:if test="${work.powork==true}">
                    <td>工作中</td>
                </c:if>
                <c:if test="${work.powork==false}">
                    <td>休息中</td>
                </c:if>
                <td>${work.poworkarea.woarea}&nbsp;${work.poworkarea.wotown}</td>
                <td>
                    <c:if test="${user.marole.roid!=1}">
                        <a href="" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#xiugai"
                           data-name="${work.poname}" data-id="${work.poid}" data-phone="${work.pophone}"
                           data-work="${work.powork}" data-password="${work.popassword}">
                            <span class="glyphicon glyphicon-edit"></span>修改信息
                        </a>
                        <a href="" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#date"
                           data-id="${work.poid}" data-name="${work.poname}">
                            <span class="glyphicon glyphicon-info-sign"></span>工作状况
                        </a>
                    </c:if>
                </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div id="main" style="width: 600px;height:400px;" class="col-lg-offset-3"></div>
    </div>
</div>
<div class="modal fade" id="xiugai" tabindex="-1" role="dialog" aria-labelledby="xiugaiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="xiugaiLabel">
                    修改邮差编号:<span class="postid"></span>,姓名:<span class="postname"></span>
                </h4>
            </div>
            <div class="modal-body" id="contentlose">
                <form class="form">

                    <div class="form-group">
                        <label for="phone" class="control-label">手机号码:</label>
                        <input type="text" value="shou" id="phone" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="password" class="control-label">用户密码:</label>
                        <input type="text" value="shou" id="password" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="adress" class="control-label">修改工作区域：</label>
                        <div class="control-group" id="adress">
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
                    </div>
                    <div class="form-horizontal">
                        <span>
                            <input type="radio" value="0" id="a" name="work"/>
                            <label for="a">休息</label>
                        </span>
                        <span>
                            <input type="radio" value="1" id="b" name="work"/>
                            <label for="b">工作</label>
                        </span>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="changepost();">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="chakan" tabindex="-1" role="dialog" aria-labelledby="chakanLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="chakanLabel">
                    请输入该工作者工作的年月
                </h4>
            </div>
            <div class="modal-body" id="contentchakan">

            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addpost" tabindex="-1" role="dialog" aria-labelledby="addpostLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="loseLabel">
                    添加邮差
                </h4>
            </div>
            <div class="modal-body" id="contentaddpost">
                <form class="form">
                    <div class="form-group">
                        <label for="addpost" class="control-label">邮差姓名:</label>
                        <input type="text" id="addpostname" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addpostpassword" class="control-label">用户密码:</label>
                        <input type="password" id="addpostpassword" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addpostphone" class="control-label">手机号码:</label>
                        <input type="text" id="addpostphone" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="addpostworkarea" class="control-label">邮差工作区域：</label>
                        <div class="control-group" id="addpostworkarea">
                            <div class="controls">
                                <label>所在区：</label>
                                <select class="input-xlarge" id="addpostwoareas" onchange="addtown();">
                                    <option value="-1">请选择</option>
                                    <c:forEach items="${woareas}" var="woarea">
                                        <option>${woarea}</option>
                                    </c:forEach>
                                </select>
                                <label>所在镇：</label>
                                <select class="input-xlarge" id="addpostwotown" name="woid" disabled="disabled">
                                    <option value="-1">请选择</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-horizontal">
                        <span>
                            <input type="radio" value="0" id="adda" name="addwork"/>
                            <label for="adda">休息</label>
                        </span>
                        <span>
                            <input type="radio" value="1" id="addb" name="addwork"/>
                            <label for="addb">工作</label>
                        </span>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="addpost();">
                    提交保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="modal fade" id="date" tabindex="-1" role="dialog" aria-labelledby="dateLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4>请选择某个时间段，该邮差的工作情况</h4>
            </div>
            <form action="/admin/worksituation" method="post">
            <div class="modal-body">
                    <input type="hidden" name="poid" id="postid"/>
                    <input type="hidden" name="poname" id="postname"/>
                    <div class="form-group">
                        <label for="start">开始时间</label>
                        <input type="date" class="form-control" name="start" id="start">
                    </div>
                    <div class="form-group">
                        <label for="end">结束时间</label>
                        <input type="date" class="form-control" name="end" id="end">
                    </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="submit" class="btn btn-primary">
                    提交更改
                </button>
            </div>
            </form>
        </div>
    </div>
</div>

<script>
    function addpost() {
        var addpostname = $("#addpostname").val();
        var addpostpassword = $("#addpostpassword").val();
        var addpostphone = $("#addpostphone").val();
        var addpostwotown = $('#addpostwotown').val();
        var addpostwork = $("input[name='addwork']:checked").val();
        if (addpostpassword == null || addpostname == null || addpostphone == null || addpostwotown == null || addpostwork == null) {
            alert("你必须完善好邮差的相关信息！");
            return;
        }
        $.post("/admin/addpost", {
            postname: addpostname,
            postpassword: addpostpassword,
            postphone: addpostphone,
            postwotown: addpostwotown,
            postwork: addpostwork
        }, function (data) {
            alert(data);
            window.location.reload();
        })

    }

    $('#date').on('show.bs.modal', function (e) {
        var mo = $(e.relatedTarget);
        var poid = mo.data('id');
        var poname = mo.data('name');
        var modal = $(this);
        modal.find("#postid").val(poid);
        modal.find("#postname").val(poname);
    });

//    function showdate() {
//        var start = $("#start").val();
//        var end = $("#end").val();
//        var poid = $(".postid").text();
//        $.post("/admin/worksituation",{
//            poid : poid,
//            start : start,
//            end : end
//        })


//    }

    $('#xiugai').on('show.bs.modal', function (e) {
        var mo = $(e.relatedTarget);
        var poid = mo.data('id');
        var poname = mo.data('name');
        var pophone = mo.data('phone');
        var popassword = mo.data('password');
        var powork = mo.data('work') == true ? 1 : 0;
        var modal = $(this);
        modal.find('.postid').text(poid);
        modal.find('.postname').text(poname);
        modal.find('#phone').val(pophone);
        modal.find('#password').val(popassword);
        modal.find("input[name='work'][value=" + powork + "]").attr("checked", 'checked');
    });
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
    function addtown() {
        var area = $("#addpostwoareas").val();
        if (area == -1) {
            alert("请选择正确所在区！");
            $('#addpostwotown').empty();
            $('#addpostwotown').append("<option value=-1>请选择</option>").attr("disabled", true);
            return;
        }
        $.get("/admin/town/" + area, function (data, status) {
            $('#addpostwotown').empty();
            $.each(data, function (key, value) {
                $('#addpostwotown').append("<option value='" + value.woid + "'>" + value.wotown + "</option>");
            });
            $('#addpostwotown').attr("disabled", false);
        });
    }
    function changepost() {
        var chpoid = $(".postid").text();
        var chpopassword = $("#password").val();
        var chpophone = $("#phone").val();
        var chwork = $("input[name='work']:checked").val();
        var chworkarea = $("#wotown").val();
        if (chworkarea == -1) {
            alert("请工作人员的工作区域！");
            return;
        }
        $.post("/admin/changepost", {
            poid: chpoid,
            popassword: chpopassword,
            pophone: chpophone,
            work: chwork,
            woid: chworkarea
        }, function (data) {
            alert(data);
            window.location.reload();
        })
    }

    var postname = new Array();
    var postnum = new Array();
    <c:forEach items="${postworkloads}" var="workload">
    postnum.push(${workload*100+200});
    </c:forEach>
    <c:forEach items="${postnames}" var="name">
    postname.push("${name}");
    </c:forEach>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '各员工的工作量'
        },
        tooltip: {},
        legend: {
            data: ['12月工资']
        },
        xAxis: {
            data: postname
        },
        yAxis: {},
        series: [{
            name: '12月工资',
            type: 'bar',
            data: postnum
        }]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>
</html>
