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

    <title>山东传媒职业学院建校60周年</title>
       <link rel="shortcut icon" href="http://eways.gl-data.com/a/xxlogo.png">

    <link rel="stylesheet" href="${ctxStatic}/map/index/css/index.css">
    <link rel="stylesheet" href="${ctxStatic}/map/index/fonts/icomoon.css">
    <script type="text/javascript" src="${ctxStatic}/map/js/jquery-1.8.0.js"></script>

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

        @keyframes rotate {
            0% {
                transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(0);
            }
            100% {
                transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(-360deg);
            }
        }
        .stars {
            transform: perspective(500px);
            transform-style: preserve-3d;
            position: absolute;
            bottom: 0;
            perspective-origin: 50% 100%;
            left: 50%;
            animation: rotate 90s infinite linear;
        }

        .star {
            width: 2px;
            height: 2px;
            background: #F7F7B6;
            position: absolute;
            top: 0;
            left: 0;
            transform-origin: 0 0 0;
            transform: translate3d(0, 0, -300px);
            backface-visibility: hidden;
        }
        ::-webkit-scrollbar {width:5px;height:5px;position:absolute}
        ::-webkit-scrollbar-thumb {background-color:#5bc0de}
        ::-webkit-scrollbar-track {background-color:#ddd}
    </style>
    <script>
        $(document).ready(function(){
            TableMarquee().tableScroll('tableId', 200, 60, 3);
            var stars=800;
            var $stars=$(".stars");
            var r=800;
            for(var i=0;i<stars;i++){
                var $star=$("<div/>").addClass("star");
                $stars.append($star);
            }
            $(".star").each(function(){
                var cur=$(this);
                var s=0.2+(Math.random()*1);
                var curR=r+(Math.random()*300);
                cur.css({
                    transformOrigin:"0 0 "+curR+"px",
                    transform:" translate3d(0,0,-"+curR+"px) rotateY("+(Math.random()*360)+"deg) rotateX("+(Math.random()*-50)+"deg) scale("+s+","+s+")"

                })
            })
        })


        var TableMarquee=function(){
            var MyMarhq;
            return {
                tableScroll:function (tableid, hei, speed, len) {
                    clearTimeout(MyMarhq);
                    $('#' + tableid).parent().find('.tableid_').remove()
                    $('#' + tableid).parent().prepend(
                        '<table class="tableid_"><thead>' + $('#' + tableid + ' thead').html() + '</thead></table>'
                    ).css({
                        'position': 'relative',
                        'overflow': 'hidden'
                        // 'height': hei + 'px'
                    })
                    $(".tableid_").find('th').each(function(i) {
                        $(this).css('width', $('#' + tableid).find('th:eq(' + i + ')').width());
                    });
                    $(".tableid_").css({
                        'position': 'absolute',
                        'top': 0,
                        'left': 0,
                        'z-index': 9,
                        'width': '100%',
                    })
                    $('#' + tableid).css({
                        'position': 'absolute',
                        'top': -2,
                        'left': 0,
                        'z-index': 1
                    })
                    $(".tableid_").addClass("info-table");

                    if ($('#' + tableid).find('tbody tr').length > len) {
                        $('#' + tableid).find('tbody').html($('#' + tableid).find('tbody').html() + $('#' + tableid).find('tbody').html());
                        $(".tableid_").css('top', -2);
                        $('#' + tableid).css('top', 0);
                        var tblTop = 0;
                        var outerHeight = $('#' + tableid).find('tbody').find("tr").outerHeight();

                        function Marqueehq() {
                            if (tblTop <= -outerHeight * $('#' + tableid).find('tbody').find("tr").length) {
                                tblTop = 0;
                            } else {
                                tblTop -= 1;
                            }
                            $('#' + tableid).css('margin-top', tblTop + 'px');
                            clearTimeout(MyMarhq);
                            MyMarhq = setTimeout(function() {
                                Marqueehq()
                            }, speed);
                        }

                        MyMarhq = setTimeout(Marqueehq, speed);
                        $('#' + tableid).find('tbody').hover(function() {
                            clearTimeout(MyMarhq);
                        }, function() {
                            clearTimeout(MyMarhq);
                            if ($('#' + tableid).find('tbody tr').length > len) {
                                MyMarhq = setTimeout(Marqueehq, speed);
                            }
                        })
                    }
                }
            }
        };
    </script>
</head>

<body style="overflow: hidden">
<div class="stars"></div>
<div class="viewport">
    <div class="column" style="flex: 2">
        <!--概览-->
        <div class="overview panel">
            <div class="inner">
                <div class="item">
                    <h4 ><a href="${ctxf}/goMap?type=sd" style="color: #ffffff">${sum}</a></h4>
                    <span>
                            <i class="icon-dot" style="color: #006cff"></i>
                        全国助威数
                        </span>
                </div>
                <div class="item">
                    <h4>${group}</h4>
                    <span>
                            <i class="icon-dot" style="color: #6acca3"></i>
                            参与人分布省市数
                        </span>
                </div>
            </div>
        </div>
        <!--监控-->
        <div class="monitor panel" style="height: 28rem">
            <div class="inner">
                <div class="tabs">
                    <a href="javascript:">全国各省市助威人数</a>
                </div>
                <div class="content" style="display: block;">
                    <div class="head">
                        <span class="col">省市名称</span>
                        <span class="col">助威数</span>
                    </div>
                    <div class="marquee-view">
                        <div class="marquee" >
                            <c:forEach items="${list}" var="item">
                            <div class="row">
                                <span class="col">${fns:abbr(item.province, 9)}</span>
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
        <div class="map" style="height: 100%;height: 100%">
            <div class="chart">
                <jsp:include page="/WEB-INF/views/modules/map/goMap.jsp"/>
            </div>
        </div>

    </div>

</div>
</body>

<script src="${ctxStatic}/map/index/js/index.js"></script>

<script src="${ctxStatic}/map/index/js/china.js"></script>
<%--<script src="${ctxStatic}/map/index/js/mymap.js"></script>--%>

</html>
