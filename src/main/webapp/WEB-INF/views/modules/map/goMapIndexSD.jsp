<%--
  Created by IntelliJ IDEA.
  User: HY
  Date: 2020/6/22
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>山东传媒职业学院60周年校庆邀您助威</title>
    <link rel="stylesheet" href="${ctxStatic}/map/index/css/index.css">
    <link rel="stylesheet" href="${ctxStatic}/map/index/fonts/icomoon.css">
   <link rel="shortcut icon" href="http://eways.gl-data.com/a/xxlogo.png">

    <style>
        .monitor .col:nth-child(1){
            width: 11rem;
        }
        .col{
            font-size: 0.7rem;
        }
        .monitor .tabs a:first-child{
            border-right:0px
        }
        .monitor .marquee-view{
            top:2.2rem
        }
    </style>
</head>

<body style="overflow:hidden">

<div class="viewport">
    <div class="column" style="flex: 2">
        <!--概览-->
        <div class="overview panel">
            <div class="inner">
                <div class="item">
                    <h4><a href="${ctxf}/goMap" style="color: #ffffff">${sum}</a></h4>
                    <span>
                            <i class="icon-dot" style="color: #006cff"></i>
                            山东助威数
                        </span>
                </div>
                <div class="item">
                    <h4>${group}</h4>
                    <span>
                            <i class="icon-dot" style="color: #6acca3"></i>
                            参与人分布城市数
                        </span>
                </div>
            </div>
        </div>
        <!--监控-->
        <div class="monitor panel" style="height: 28rem">
            <div class="inner">
                <div class="tabs">
                    <a href="javascript:">山东各市助威人数</a>
                </div>
                <div class="content" style="display: block;">
                    <div class="head">
                        <span class="col">城市名称</span>
                        <span class="col">助威数</span>
                    </div>
                    <div class="marquee-view">
                        <div class="marquee" >
                            <c:forEach items="${list}" var="item">
                                <div class="row">
                                    <span class="col">${fns:abbr(item.city, 9)}</span>
                                    <span class="col">${item.cou}</span>
                                    <span class="icon-dot"></span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="column" style="flex: 8">
        <!-- 地图 -->
        <div class="map" style="height: 32rem">

            <div class="chart">

                <jsp:include page="/WEB-INF/views/modules/map/goMapSD.jsp"/>

            </div>
        </div>
    </div>

</div>
</body>
<script src="${ctxStatic}/map/index/js/index.js"></script>
<script src="${ctxStatic}/map/index/js/china.js"></script>


</html>
