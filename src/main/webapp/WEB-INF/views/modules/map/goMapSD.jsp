<%--  Created by IntelliJ IDEA.
  User: HY
  Date: 2020/6/18
  Time: 16:43
  To change this template use File | Settings | File Templates.
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
    <script src="${ctxStatic}/map/index/js/shandong.js"></script>
</head>

<body style="background:#1B1B1B;position:relative">
<!--Step:1 Prepare a dom for ECharts which (must) has size (width & hight)-->
<!--Step:1 为ECharts准备一个具备大小（宽高）的Dom-->
  <img
  src="${ctxStatic}/images/xxlogo.png"
  style="width: 220px;position:absolute;top:0px;left:0px"
  />
<div id="mainMap" style="height:100%;width:100%;box-sizing: border-box;padding:10px;background:#1B1B1B">

</div>

<!--Step:2 Import echarts.js-->
<!--Step:2 引入echarts.js-->

<script type="text/javascript" src="${ctxStatic}/map/js/jquery-1.8.0.js"></script>
<script src="${ctxStatic}/map/js/echarts.js" charset="UTF-8"></script>
<script type="text/javascript">

    $('#document').ready(function(){
      var data = getData()

        getEcharts(data);
    });

    function getData() {
        var data
        $.ajax({
            type: "get",
            async : false,
            url: "${ctxf}/getData",
            data:{"type":"type"},
            success:function (ref) {
                if(ref.ok=="ok"){
                    data = ref.dataList
                }
            }
        })
        return data
    }
</script>

<script type="text/javascript">
    function getEcharts(data){
        var allLocat = {}
        var quan1 = []
        var quan2 = []
        var jiantou = []
        var xs = []

        for(var i=0;i<data.length;i++){
            allLocat[data[i].id] = [data[i].lng,data[i].lat]
            quan1.push({name:data[i].id,value:data[i].jl})
            quan2.push({name:data[i].id,value:data[i].jl})
           // xs.push({name:data[i].area,value:data[i].cheer})
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
                //ec.registerMap('mymap', shandong);
                var myChart2 = ec.init(document.getElementById('mainMap'));
              var optionMap =  {
                    dataRange: {
                        show:false,
                        min : 0,
                            max : 100,
                            calculable : true,
                            color: ['#ff3333', 'orange', 'yellow','lime','aqua'],
                            textStyle:{
                            color:'#fff'
                        }
                    },
                    series : [
                        {
                            name: '全国',
                            type: 'map',
                            roam: false,
                            hoverable: false,
                            mapType: '山东',
                           // selectedMode:'single',
                            itemStyle:{
                                normal:{
                                    borderColor:'rgba(100,149,237,1)',
                                    borderWidth:0.5,
                                    areaStyle:{
                                        color: '#1b1b1b'
                                    }
                                }
                            },
                            data:[],
                    /*        markLine : {
                                smooth:true,
                                symbol: ['none', 'circle'],
                                symbolSize : 1,
                                itemStyle : {
                                    normal: {
                                        color:'#fff',
                                        borderWidth:1,
                                        borderColor:'rgba(30,144,255,0.5)'
                                    }
                                },
                                data : [
                                ],
                            },*/
                            geoCoord: allLocat,
                            markPoint : {
                                symbol:'emptyCircle',
                                symbolSize : function (v){  //光电大小
                                    return 1
                                },
                                effect : {
                                    show: true,
                                    type: 'scale',
                                    shadowBlur : 0
                                },
                                itemStyle:{

                                    normal:{
                                        label:{show:false}
                                    },
                                    emphasis: {
                                        label:{
                                            show:false
                                        }
                                    }
                                },
                                data : quan2
                            }

                        }



                        /*{
                            name: '北京 Top10',
                            type: 'map',
                            mapType: 'china',
                            data:[],
                            markLine : {
                                smooth:true,
                                effect : {
                                    show: true,
                                    scaleSize: 1,
                                    period: 30,
                                    color: '#fff',
                                    shadowBlur: 10
                                },
                                itemStyle : {
                                    normal: {
                                        label:{show:false},
                                        borderWidth:1,
                                        lineStyle: {
                                            type: 'solid',
                                            shadowBlur: 10
                                        }
                                    }
                                },
                                data : jiantou
                            },
                            markPoint : {
                                symbol:'emptyCircle',
                                symbolSize : function (v){  //光电大小
                                    return 1+v/10
                                },
                                effect : {
                                    show: true,
                                    type: 'scale',
                                    shadowBlur : 0
                                },
                                itemStyle:{
                                    normal:{
                                        label:{show:false}
                                    },
                                    emphasis: {
                                        label:{position:'top'}
                                    }
                                },
                                data : quan1
                            }
                        }*/
                    ],

                  /*tooltip : {         // Option config. Can be overwrited by series or data
                      trigger: 'axis',
                      //show: true,   //default true
                      showDelay: 0,
                      hideDelay: 50,
                      transitionDuration:0,
                      backgroundColor : 'rgba(255,0,255,0.7)',
                      borderColor : '#f50',
                      borderRadius : 8,
                      borderWidth: 2,
                      padding: 10,    // [5, 10, 15, 20]
                      position : function(p) {
                          // 位置回调
                          // console.log && console.log(p);
                          return [p[0] + 10, p[1] - 10];
                      },
                      textStyle : {
                          color: 'yellow',
                          decoration: 'none',
                          fontFamily: 'Verdana, sans-serif',
                          fontSize: 15,
                          fontStyle: 'italic',
                          fontWeight: 'bold'
                      }/!*,
                      formatter: function (params,ticket,callback) {
                          console.log(params)
                          var res = 'Function formatter : <br/>' + params[0].name;
                          for (var i = 0, l = params.length; i < l; i++) {
                              res += '<br/>' + params[i].seriesName + ' : ' + params[i].value;
                          }
                          setTimeout(function (){
                              // 仅为了模拟异步回调
                              callback(ticket, res);
                          }, 1000)
                          return 'loading';
                      }*!/
                  }*/
                }
                myChart2.setOption(optionMap);
            });
    }

</script>
</body>
</html>--%>
<%--
  Created by IntelliJ IDEA.
  User: HY
  Date: 2020/6/18
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
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
<div id="mainMap" style="height:100%;width:100%;box-sizing: border-box;padding:10px;">

</div>

<!--Step:2 Import echarts.js-->
<!--Step:2 引入echarts.js-->

<script type="text/javascript" src="${ctxStatic}/map/js/jquery-1.8.0.js"></script>
<script src="${ctxStatic}/map/js/echarts.js" charset="UTF-8"></script>
<script type="text/javascript">

    $('#document').ready(function(){
        var data = getData()

        getEcharts(data);
    });

    function getData() {
        var data=[]
        $.ajax({
            type: "get",
            async : false,
            url: "${ctxf}/getData1",
            data:{"type":"sd"},
            success:function (ref) {
                if(ref.ok=="ok"){
                    data[0] = ref.dataList
                    data[1] = ref.top
                }
            }
        })
        return data
    }
</script>

<script type="text/javascript">
    function getEcharts(ref){
        console.log(ref)
        var data = ref[0]
        var top = ref[1]
        var allLocat = {'威海市':[122.1405029296875, 37.47921744485059],
            '烟台市':[121.46484375,37.42252593456306],
            '青岛市':[120.3936767578125,36.03133177633187],
            '潍坊市':[119.1741943359375,36.66841891894786],
            '东营市':[118.6907958984375,37.39634613318923],
            '滨州市':[117.982177734375, 37.339591851359174],
            '淄博市':[118.0755615234375,36.77409249464195],
            '日照市':[119.5367431640625,35.37113502280101],
            '临沂市':[118.3721923828125,35.06597313798418],
            '德州市':[116.3726806640625,37.39634613318923],

            '聊城市':[116.004638671875,36.42570252039198],
            '济宁市':[116.597900390625, 35.380092992092145],
            '菏泽市':[115.48828125,35.20074480172401],
            '枣庄市':[117.3394775390625,34.76417891445512],
            '泰安市':[117.0977783203125,36.16448788632064],
            '济南市':[117.1307373046875,36.62875385775956]}

        var quan1 = []
        var quan = []
        var jiantou = []
        var top_quan = []

        for(var i=0;i<data.length;i++){
            allLocat[data[i].id] = [data[i].lng,data[i].lat]
            quan1.push({name:data[i].id,value:data[i].jl})
            quan.push({name:data[i].id,value:data[i].jl})
            //jiantou.push([{name:data[i].area},{name:data[0].area,value:data[i].cheer}])

            // xs.push({name:data[i].area,value:data[i].cheer})
        }

        for(var i=0;i<top.length;i++){
            jiantou.push([{name:top[i].link},{name:'济南市',value:i*10}])
            top_quan.push({name:top[i].link,value:top[i].counts})
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
                var myChart2 = ec.init(document.getElementById('mainMap'));
                var optionMap =  {
                    dataRange: {
                        show:false,
                        min : 0,
                        max : 100,
                        calculable : true,
                        color: ['#ff3333', 'orange', 'yellow','lime','aqua'],
                        textStyle:{
                            color:'#fff'
                        }
                    },

                    series : [
                        {
                            name: '全国',
                            type: 'map',
                            roam: false,
                            hoverable: false,
                            mapType: '山东',
                            // selectedMode:'single',
                            itemStyle:{
                                normal:{
                                    borderColor:'#61a8ff',
                                    borderWidth:0.5,
                                    areaStyle:{
                                        color: '#142957'
                                    }
                                }
                            },
                            data:[],
                            geoCoord: allLocat,
                            markPoint : {
                                clickable:false,
                                symbol:'emptyCircle',
                                symbolSize : function (v){  //光电大小
                                    return 0.5
                                },
                                effect : {
                                    show: true,
                                    type: 'scale',
                                    shadowBlur : 0
                                },
                                itemStyle:{

                                    normal:{
                                        label:{show:false}
                                    },
                                    emphasis: {
                                        label:{
                                            show:false
                                        }
                                    }
                                },
                                data : quan
                            }

                        }

                        ,
                        {
                            name: '北京 Top10',
                            type: 'map',
                            mapType: '山东',
                            data:[],
                            markLine : {
                                smooth:true,
                                effect : {
                                    show: true,
                                    scaleSize: 2
                                    /* period: 30,
                                     color: '#fff',
                                     shadowBlur: 10*/
                                },
                                itemStyle : {
                                    normal: {
                                        label:{show:false},
                                        borderWidth:1,
                                        lineStyle: {
                                            type: 'solid',
                                            shadowBlur: 10
                                        }
                                    }
                                },
                                data : jiantou
                            },
                            markPoint : {
                                /*   symbol:'emptyCircle',
                                   symbolSize : function (v){  //光电大小
                                       return 8
                                   },*/
                                symbol:'image://${ctxStatic}/images/xxlogo.png',
                                symbolSize : function (v){  //光电大小
                                    return [28.8,20.7]
                                },
                                effect : {
                                    show: true,
                                    type: 'scale',
                                    shadowBlur : 0,
                                    period:30
                                },
                                itemStyle:{
                                    normal:{
                                        label:{show:true,
                                            position:'top'}
                                    },
                                    emphasis: {
                                        label:{position:'top'}
                                    }
                                },
                                data : top_quan
                            }
                        }
                    ],
                }
                myChart2.setOption(optionMap);

            });
    }

</script>
</body>
</html>
