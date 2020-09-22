<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/wx/wxHead.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <script src="https://www.jq22.com/jquery/echarts-4.2.1.min.js"></script>
    <script src="${ctxStatic}/xk/js/china.js"></script>
    <script src="${ctxStatic}/xk/js/jquery.warpdrive.js"></script>
    <title>山东传媒职业学院60周年校庆邀您助威</title>
</head>
<body style="overflow: hidden">

<div class="jq22-content" style="position: absolute;z-index: -1">
    <div id='holder'></div>
</div>
<div id="mainMap" style="height:100%;width:100%;margin-top: -50px">
</div>

<script>
    $( document ).ready( function() {

        //------------------------------------------------------------------------

        //Settings - params for WarpDrive
        var settings = {

            width: 480,
            height: 480,
            autoResize: false,
            autoResizeMinWidth: null,
            autoResizeMaxWidth: null,
            autoResizeMinHeight: null,
            autoResizeMaxHeight: null,
            addMouseControls: true,
            addTouchControls: true,
            hideContextMenu: true,
            starCount: 6666,
            starBgCount: 2222,
            starBgColor: { r:255, g:255, b:255 },
            starBgColorRangeMin: 10,
            starBgColorRangeMax: 40,
            starColor: { r:255, g:255, b:255 },
            starColorRangeMin: 10,
            starColorRangeMax: 100,
            starfieldBackgroundColor: { r:0, g:0, b:0 },
            starDirection: 1,
            starSpeed: 20,
            starSpeedMax: 200,
            starSpeedAnimationDuration: 2,
            starFov: 300,
            starFovMin: 200,
            starFovAnimationDuration: 2,
            starRotationPermission: true,
            starRotationDirection: 1,
            starRotationSpeed: 0.0,
            starRotationSpeedMax: 1.0,
            starRotationAnimationDuration: 2,
            starWarpLineLength: 2.0,
            starWarpTunnelDiameter: 100,
            starFollowMouseSensitivity: 0.025,
            starFollowMouseXAxis: true,
            starFollowMouseYAxis: true

        };

        //------------------------------------------------------------------------

        //standalone

        //init

        var warpdrive = new WarpDrive( document.getElementById( 'holder' ) );
        //var warpdrive = new WarpDrive( document.getElementById( 'holder' ), settings );

        //------------------------------------------------------------------------

        //jQuery

        //init

        //$( '#holder' ).warpDrive();
        //$( '#holder' ).warpDrive( settings );

        //------------------------------------------------------------------------

    } );
</script>

<script>
    var sh={'山东省':[117.000923, 36.675807],
        '河北省':[115.48333,38.03333],
        '吉林省':[125.35000,43.88333],
        '黑龙江省':[127.63333,47.75000],
        '辽宁省':[123.38333,41.80000],
        '内蒙古自治区':[111.670801, 41.818311],
        '新疆维吾尔自治区':[87.68333,43.76667],
        '甘肃省':[103.73333,36.03333],
        '宁夏回族自治区':[106.26667,37.46667],
        '山西省':[112.53333,37.86667],
        '陕西省':[108.95000,34.26667],
        '河南省':[113.65000,34.76667],
        '安徽省':[117.283042, 31.86119],
        '江苏省':[119.78333,32.05000],
        '浙江省':[120.20000,30.26667],
        '福建省':[118.30000,26.08333],
        '广东省':[113.23333,23.16667],
        '江西省':[115.90000,28.68333],
        '海南省':[110.35000,20.01667],
        '广西壮族自治区':[108.320004, 22.82402],
        '贵州省':[106.71667,26.56667],
        '湖南省':[113.00000,28.21667],
        '湖北省':[114.298572, 30.584355],
        '四川省':[104.06667,30.66667],
        '云南省':[102.73333,25.05000],
        '西藏自治区':[91.00000,30.60000],
        '青海省':[96.75000,36.56667],
        '天津市':[117.20000,39.13333],
        '上海市':[121.55333,31.20000],
        '重庆市':[106.45000, 29.56667],
        '北京市': [116.41667,39.91667],
        '台湾省': [121.30, 25.03],
        '香港特别行政区': [114.10000,22.20000],
        '澳门特别行政区': [113.50000,22.20000]}
    var option = {
        backgroundColor:'rgba(0,0,0,0)',
        series : [ {
            name : '',
            type : 'map',
            mapType : 'mymap', // 自定义扩展图表类型
            geoCoord:sh,
            itemStyle : {
                normal: {
                    borderWidth:0.5,
                    borderColor:'#61a8ff',
                    areaColor:'#142957',
                    label: {
                        show: false
                    }
                },
                color:"#61a8ff"
            },
            data : [],
        }

        ]

    };
    //series里定义的mymap,地图js文件里定义的testJson
    echarts.registerMap('mymap', qg);

    var chart = echarts.init(document.getElementById('mainMap'));

    chart.setOption(option);
</script>

</body>
</html>
