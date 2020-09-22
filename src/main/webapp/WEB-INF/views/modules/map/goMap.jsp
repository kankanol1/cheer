<%--
  Created by IntelliJ IDEA.
  User: HY
  Date: 2020/6/18
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
</head>

<body style="position:relative">
<!--Step:1 Prepare a dom for ECharts which (must) has size (width & hight)-->
<!--Step:1 为ECharts准备一个具备大小（宽高）的Dom-->
  <img
  src="${ctxStatic}/images/xxlogo.png"
  style="width: 220px;position:absolute;top:-10px;left:-10px"
  />
<div id="mainMap" style="height:90%;width:100%;box-sizing: border-box;padding:10px;">

</div>

<!--Step:2 Import echarts.js-->
<!--Step:2 引入echarts.js-->

<script type="text/javascript" src="${ctxStatic}/map/js/jquery-1.8.0.js"></script>
<script src="${ctxStatic}/map/js/echarts.js" charset="UTF-8"></script>

<script type="text/javascript">

    $('#document').ready(function () {
        var data = getData()

        getEcharts(data);
    });

    function getData() {
        var data = []
        $.ajax({
            type: "get",
            async: false,
            url: "${ctxf}/getData1",
            data: {},
            success: function (ref) {
                if (ref.ok == "ok") {
                    data[0] = ref.dataList
                    data[1] = ref.top
                }
            }
        })
        return data
    }
</script>

<script type="text/javascript">
    function getEcharts(ref) {
        console.log(ref)
        var data = ref[0]
        var top = ref[1]
        var allLocat = {
            '山东省': [117.000923, 36.675807],
            '河北省': [115.48333, 38.03333],
            '吉林省': [125.35000, 43.88333],
            '黑龙江省': [127.63333, 47.75000],
            '辽宁省': [123.38333, 41.80000],
            '内蒙古自治区': [111.670801, 41.818311],
            '新疆维吾尔自治区': [87.68333, 43.76667],
            '甘肃省': [103.73333, 36.03333],
            '宁夏回族自治区': [106.26667, 37.46667],
            '山西省': [112.53333, 37.86667],
            '陕西省': [108.95000, 34.26667],
            '河南省': [113.65000, 34.76667],
            '安徽省': [117.283042, 31.86119],
            '江苏省': [119.78333, 32.05000],
            '浙江省': [120.20000, 30.26667],
            '福建省': [118.30000, 26.08333],
            '广东省': [113.23333, 23.16667],
            '江西省': [115.90000, 28.68333],
            '海南省': [110.35000, 20.01667],
            '广西壮族自治区': [108.320004, 22.82402],
            '贵州省': [106.71667, 26.56667],
            '湖南省': [113.00000, 28.21667],
            '湖北省': [114.298572, 30.584355],
            '四川省': [104.06667, 30.66667],
            '云南省': [102.73333, 25.05000],
            '西藏自治区': [91.00000, 30.60000],
            '青海省': [96.75000, 36.56667],
            '天津市': [117.20000, 39.13333],
            '上海市': [121.55333, 31.20000],
            '重庆市': [106.45000, 29.56667],
            '北京市': [116.41667, 39.91667],
            '台湾省': [121.30, 25.03],
            '香港特别行政区': [114.10000, 22.20000],
            '澳门特别行政区': [113.50000, 22.20000]
        }
        var quan1 = []
        var quan = []
        var jiantou = []
        var top_quan = []

        for (var i = 0; i < data.length; i++) {
            allLocat[data[i].id] = [data[i].lng, data[i].lat]
            quan1.push({name: data[i].id, value: data[i].jl})
            quan.push({name: data[i].id, value: data[i].jl})
            //jiantou.push([{name:data[i].area},{name:data[0].area,value:data[i].cheer}])

            // xs.push({name:data[i].area,value:data[i].cheer})
        }

        for (var i = 0; i < top.length; i++) {
            jiantou.push([{name: top[i].link}, {name: '山东省', value: i * 10}])
            top_quan.push({name: top[i].link, value: top[i].counts})
        }


        // Step:3 conifg ECharts's path, link to echarts.js from current page.
        // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
        require.config({
            paths: {
                echarts: '${ctxStatic}/map/js'
            }
        });

        // Step:4 require echarts and use it in the callback.
        // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
        require(
            [
                'echarts',
                'echarts/chart/map'
            ],
            function (ec) {
                // --- 地图 ---
                var optionMap = {
                    dataRange: {
                        show: false,
                        min: 0,
                        max: 100,
                        calculable: true,
                        color: ['#ff3333', 'orange', 'yellow', 'lime', 'aqua'],
                        textStyle: {
                            color: '#fff'
                        }
                    },

                    series: [
                        {
                            name: '全国',
                            type: 'map',
                            roam: false,
                            hoverable: false,
                            mapType: 'china',
                            // selectedMode:'single',
                            itemStyle: {
                                normal: {
                                    borderColor: '#61a8ff',
                                    borderWidth: 0.5,
                                    areaStyle: {
                                        color: '#142957'
                                    }
                                }
                            },
                            data: [],
                            geoCoord: allLocat,
                            markPoint: {
                                clickable: false,
                                symbol: 'emptyCircle',
                                symbolSize: function (v) {  //光电大小
                                    return 0.5
                                },
                                effect: {
                                    show: true,
                                    type: 'scale',
                                    shadowBlur: 0
                                },
                                itemStyle: {

                                    normal: {
                                        label: {show: false}
                                    },
                                    emphasis: {
                                        label: {
                                            show: false
                                        }
                                    }
                                },
                                data: quan
                            }

                        }

                        ,
                        {
                            name: '北京 Top10',
                            type: 'map',
                            mapType: 'china',
                            data: [],
                            markLine: {
                                smooth: true,
                                effect: {
                                    show: true,
                                    scaleSize: 2
                                    /* period: 30,
                                     color: '#fff',
                                     shadowBlur: 10*/
                                },
                                itemStyle: {
                                    normal: {
                                        label: {show: false},
                                        borderWidth: 1,
                                        lineStyle: {
                                            type: 'solid',
                                            shadowBlur: 10
                                        }
                                    }
                                },
                                data: jiantou
                            },
                            markPoint: {
                                /*   symbol:'emptyCircle',
                                   symbolSize : function (v){  //光电大小
                                       return 8
                                   },*/
                                symbol: 'image://${ctxStatic}/images/xxlogon.png',
                                symbolSize: function (v) {  //光电大小
                                    return [28.8, 20.7]
                                },
                                effect: {
                                    show: true,
                                    type: 'scale',
                                    shadowBlur: 0,
                                    period: 30
                                },
                                itemStyle: {
                                    normal: {
                                        label: {
                                            show: true,
                                            position: 'top'
                                        }
                                    },
                                    emphasis: {
                                        label: {position: 'top'}
                                    }
                                },
                                data: top_quan
                            }
                        }
                    ],
                }
                var mapbox = document.getElementById('mainMap');
                var myChart2 = ec.init(mapbox);
                myChart2.setOption(optionMap);

            });
    }

</script>
</body>
</html>
