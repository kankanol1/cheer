<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/wx/wxHead.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
  <%--<script src="${ctxStatic}/xk/js/echarts.js" charset="UTF-8"></script>--%>
  <script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
  <%-- <script src="${ctxStatic}/xk/js/china.js"></script>--%>
  <script src="${ctxStatic}/xk/js/jquery.warpdrive.js"></script>
  <title>山东传媒职业学院60周年校庆邀您助威</title>
  <style>
    .title-style {
      text-align: center;
      z-index: 999;
      padding-left: 20px;
      color: #fff;
      position: absolute;
      top: 5%;
      font-size: 20px;
    }
  </style>
</head>
<body style="overflow: hidden">
<div class="title-style"><p>助威人数：<span id="num">0</span></p></div>

<div class="jq22-content" style="position: absolute;z-index: -1">
  <div id='holder'></div>
</div>
<div id="mainMap" style="height:100%;width:100%;margin-top: -100px">
</div>

<div style="position: absolute;bottom: 25%;width: 100%">
  <div style="text-align: center;position:relative">
    <span style="display: block;font-size: 20px;margin-bottom: 15px;color: #ffffff"><i style="font-size: 20px"
                                                                                       class="iconfont iconlocation"></i><span
            style="padding-left: 10px" id="dddw">${empty user.exp.city?'等待定位':user.exp.city}</span></span>

    <c:choose>
      <c:when test="${empty user.exp.city}">
        <a style="width: 135px;height: 45px;border: 1px solid #6495ed;border-radius: 10px;letter-spacing:5px;display: block;margin: 0 auto;line-height: 45px;font-size: 22px;color: #ffffff"
           href="javascript:void(0)" onclick="cheer()" id="cheer">点亮地图</a>
      </c:when>
      <c:otherwise>
        <a style="width: 135px;height: 45px;border: 1px solid #6495ed;border-radius: 10px;letter-spacing:5px;display: block;margin: 0 auto;line-height: 45px;font-size: 22px;color: #ffffff"
           href="javascript:void(0)" onclick="xxcy()">感谢助威</a>
      </c:otherwise>
    </c:choose>
  </div>
</div>
<div style="position:absolute;width: 100%;text-align:center;bottom: 18%;font-size:18px"><a style="color:blue" href="http://xq.sdcmc.net/">助力详情登陆学院校庆官方网站查看</a></div>

<div style="position: absolute;bottom: 5%;width: 100%;text-align: center">
  <img src="${ctxStatic}/images/xxlogo.png" style="width: 50px"/>
  <span style="font-size:20px;color:#eee;vertical-align:middle">山东传媒职业学院</span>
</div>

<script>
  var nums = 0;
  $(document).ready(function () {
   getNum();
    hy.jssdk();
    var warpdrive = new WarpDrive(document.getElementById('holder'));
  });

  function xxcy() {
    $.alert("地图已点亮，感谢您的助威");
  }



  function getNum() {
    $.ajax({
      type: "post",
      url: "${ctx}/sys/user/num",
      data: {},
      success: function (date) {
        if (date.data == "success") {
          //$.toast("点亮成功");
          $("#num").html(date.num)
          nums = date.num;
        }
      }
    })
  }

  function cheer() {
    var word = ""
    wx.getLocation({
      type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
      success: function (res) {
        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
        var speed = res.speed; // 速度，以米/每秒计
        var accuracy = res.accuracy; // 位置精度

        var address = "";
        var city = '';
        var province = "";
        var nation = "";

        var data = {
          location: latitude + ',' + longitude,
          /*换成自己申请的key*/
          key: "SJ2BZ-NLICP-FZJDP-LA2F3-E5TBV-JUFOU",
          get_poi: 0
        }
        var url = "http://apis.map.qq.com/ws/geocoder/v1/?";
        data.output = "jsonp";
        $.ajax({
          type: "get",
          dataType: 'jsonp',
          data: data,
          jsonp: "callback",
          jsonpCallback: "QQmap",
          url: url,
          success: function (json) {

            address = json.result.address
            city = json.result.address_component.city
            province = json.result.address_component.province
            nation = json.result.address_component.nation
            $("#dddw").html(city)
            $.ajax({
              type: "post",
              url: "${ctx}/sys/user/cheer",
              data: {
                "lng": longitude,
                "lat": latitude,
                "nation": nation,
                "province": province,
                "city": city,
                "cheer": word,
                "address": address,
                "area": 'area',
              },
              success: function (date) {
                if (date.ok == "ok") {
                  //$.toast("点亮成功");
                  $.alert("您是第" + (nums + 1) + "位点亮者，感谢您的助威");
                  $("#cheer").html("感谢助威").attr("onclick", "xxcy()")

                  var add = {
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
                    markPoint: {
                      clickable: false,
                      // symbol:'emptyCircle',
                      symbol: 'image://${user.photo}',
                      symbolSize: function (v) {  //光电大小
                        return [10, 10]
                      },
                      effect: {
                        show: true,
                        type: 'scale',
                        shadowBlur: 0,
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
                      data: [{name: date.user.id, value: 30}]
                    }

                  }

                  optionMap.series[0].geoCoord[date.user.id] = [longitude, latitude]
                  optionMap.series.push(add)
                  myChart2.setOption(optionMap);
                  getNum();


                } else if (date.ok == "no") {
                  $.toast("您已点亮", "text");
                } else {
                  $.toast("网络错误", "text");
                  $('.sp').addClass('hidden');
                }


              }
            })
          },
          error: function (err) {
            alert("服务端错误，请刷新浏览器后重试")
          }

        })
      },
      cancel: function (res) {
        alert("未获取位置")
      }
    });
  }
</script>

<script type="text/javascript">
  /*var sh={'山东省':[117.000923, 36.675807],
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
      '澳门特别行政区': [113.50000,22.20000]
  }*/
  var myChart2 = echarts.init(document.getElementById('mainMap'));
  var optionMap = {}
  var allLocat = {}
  var quan = []

  function getEcharts(ref) {
    var data = ref[0]
    var user = ref[1]
    for (var i = 0; i < data.length; i++) {
      allLocat[data[i].id] = [data[i].lng, data[i].lat]
      quan.push({name: data[i].id, value: data[i].jl})
    }
    optionMap = {
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
            // symbol:'image://${ctxStatic}/images/xxlogo.png',
            symbolSize: function (v) {  //光电大小
              return 1
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
      ]
    }

    if (user.exp && user.exp.id) {
      var add = {
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
        markPoint: {
          clickable: false,
          // symbol:'emptyCircle',
          symbol: 'image://' + user.photo,
          symbolSize: function (v) {  //光电大小
            return [10, 10]
          },
          effect: {
            show: true,
            type: 'scale',
            shadowBlur: 0,
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
          data: [{name: user.id, value: 30}]
        }

      }
      optionMap.series.push(add)

    }
    myChart2.setOption(optionMap);
  }

  $('#document').ready(function () {
    var data = getData()
    getEcharts(data);
  });

  function getData() {
    var data = []
    $.ajax({
      type: "get",
      async: false,
      url: "${ctxf}/getData",
      data: {},
      success: function (ref) {
        if (ref.ok == "ok") {
var lists = ref.dataList;
        if(ref.user.id && ref.user.exp && ref.user.exp.id){
        var s = {
        area: "area",
        cheer: "",
        id: ref.user.exp.id,
        jl: "11",
        lat: ref.user.exp.lat,
        lng: ref.user.exp.lng,
        name: ref.user.name,
        };
        lists.push(s);
        }


          data[0] = lists
          data[1] = ref.user
        }
      }
    })
    return data
  }
</script>
<script>
  wx.ready(function () {   //需在用户可能点击分享按钮前就先调用
    wx.updateAppMessageShareData({
      title: "山东传媒职业学院60年校庆邀您助威", // 分享标题
      desc: '山东传媒诚邀您的参加', // 分享描述
      link: location.href, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
      imgUrl: location.protocol + location.host + '${ctxStatic}/wx/img/cheer/xxlogo.png', // 分享图标
      success: function () {
        // 设置成功
      }
    })
  });
  wx.ready(function () {      //需在用户可能点击分享按钮前就先调用
    wx.updateTimelineShareData({
      title: '山东传媒职业学院60年校庆邀您助威', // 分享标题
      link: location.href, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
      imgUrl: location.protocol + location.host + '${ctxStatic}/wx/img/cheer/xxlogo.png', // 分享图标
      success: function () {
        // 设置成功
      }
    })
  });


</script>
</body>
</html>
