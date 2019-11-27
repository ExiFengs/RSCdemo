<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>邮差工作情况</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-theme.css">
    <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
    <script type="text/javascript" src="/js/echarts.js"></script>
</head>
<body>
<div class="container">
    <h1 class="text-center">邮差${pooname},在时间段${poostart}到${pooend}的工作情况</h1>
    <div class="row">
        <div id="re" style="width: 50%;height:400px;" class="col-lg-6"></div>
        <div id="se" style="width: 50%;height:400px;" class="col-lg-6"></div>
        <div class="h3 text-center">该邮差这段时间的派件情况：</div>
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
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${postidsentpiecesList}" var="sentpiece">
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
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="h3 text-center">该邮差这段时间的寄件情况：</div>
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
            <c:forEach items="${postidrecipient}" var="recipients">
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
<script>

    var recount = 0;
    // 基于准备好的dom，初始化echarts实例
    var myChartre = echarts.init(document.getElementById('re'));

    optionre = {
        backgroundColor: '#b0fdff',

        title: {
            text: '收件情况',
            left: 'center',
            top: 20,
            textStyle: {
                color: '#970aff'
            }
        },

        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },

        visualMap: {
            show: false,
            min: 0,
            max: 1000,
            inRange: {
                colorLightness: [0, 1]
            }
        },
        series: [
            {
                name: '数量',
                type: 'pie',
                radius: '65%',
                center: ['50%', '50%'],
                data: [
                    <c:forEach items="${workres}" var="workres">
                    <c:forEach items="${workres}" varStatus="index" var="workre">
                    <c:if test="${index.count==1}">
                    {
                        value:${workre},
                        <c:set var="recount" value="${workre}" scope="request"></c:set>
                        </c:if>
                        <c:if test="${index.count==2}">
                        name: '${workre}'
                    },
                    </c:if>
                    <c:if test="${index.count==3}">
                    <c:if test="${workre==3}">
                    <c:set var="recountOK" value="${recount}" scope="request"></c:set>
                    </c:if>
                    </c:if>

                    </c:forEach>
                    </c:forEach>
                ].sort(function (a, b) {
                    return a.value - b.value;
                }),
                roseType: 'radius',
                label: {
                    normal: {
                        textStyle: {
                            color: 'rgba(0, 0, 0, 1)'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        lineStyle: {
                            color: 'rgba(0, 0, 0, 0.3)'
                        },
                        smooth: 0.2,
                        length: 10,
                        length2: 20
                    }
                },
                itemStyle: {
                    normal: {
                        color: '#0aff68',
                        shadowBlur: 200,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                },

                animationType: 'scale',
                animationEasing: 'elasticOut',
                animationDelay: function (idx) {
                    return Math.random() * 200;
                }
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChartre.setOption(optionre);// 基于准备好的dom，初始化echarts实例

    var myChartse = echarts.init(document.getElementById('se'));

    optionse = {
        backgroundColor: '#d4ff9e',

        title: {
            text: '派件情况',
            left: 'center',
            top: 20,
            textStyle: {
                color: '#0c6eff'
            }
        },

        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },

        visualMap: {
            show: false,
            min: 0,
            max: 1000,
            inRange: {
                colorLightness: [0, 1]
            }
        },
        series: [
            {
                name: '数量',
                type: 'pie',
                radius: '65%',
                center: ['50%', '50%'],
                data: [
                    <c:forEach items="${workses}" var="workses">
                    <c:forEach items="${workses}" varStatus="index" var="workse">
                    <c:if test="${index.count==1}">
                    {
                        value:${workse},
                        <c:set var="secount" value="${workse}" scope="request"></c:set>
                        </c:if>
                        <c:if test="${index.count==2}">
                        name: '${workse}'
                    },
                    </c:if>
                    <c:if test="${index.count==3}">
                    <c:if test="${workse==3}">
                    <c:set var="secountOK" value="${secount}" scope="request"></c:set>
                    </c:if>
                    </c:if>
                    </c:forEach>
                    </c:forEach>
                ].sort(function (a, b) {
                    return a.value - b.value;
                }),
                roseType: 'radius',
                label: {
                    normal: {
                        textStyle: {
                            color: 'rgba(0, 0, 0, 1)'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        lineStyle: {
                            color: 'rgba(0, 0, 0, 0.3)'
                        },
                        smooth: 0.2,
                        length: 10,
                        length2: 20
                    }
                },
                itemStyle: {
                    normal: {
                        color: '#4d2bff',
                        shadowBlur: 200,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                },

                animationType: 'scale',
                animationEasing: 'elasticOut',
                animationDelay: function (idx) {
                    return Math.random() * 200;
                }
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChartse.setOption(optionse);
</script>
<h3>派件成功数为：${recountOK},所获金额为：${recountOK*100}块</h3>
<h3>寄件成功数为：${secountOK},所获金额为：${secountOK*100}块</h3>
</body>
</html>
