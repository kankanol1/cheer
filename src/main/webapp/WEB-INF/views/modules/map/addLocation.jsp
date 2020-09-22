<%--
  Created by IntelliJ IDEA.
  User: HY
  Date: 2020/6/23
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>地图</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        html,body{
            width:100%;
            height:100%;
        }
        *{
            margin:0px;
            padding:0px;
        }
        body, button, input, select, textarea {
            font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
        }
        p{
            width:603px;
            padding-top:3px;
            overflow:hidden;
        }
        .btn{
            width:142px;
        }
        #container{
            width:100%;
            height:100%;
        }
    </style>

    <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>

    <script charset="utf-8" src="https://map.qq.com/api/js?v=2.exp&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77"></script>
    <script>

        window.onload = function(){

//直接加载地图


            //初始化地图函数  自定义函数名init
            function init() {
                //定义map变量 调用 qq.maps.Map() 构造函数   获取地图显示容器
                var map = new qq.maps.Map(document.getElementById("container"), {
                    center: new qq.maps.LatLng(36.63757008123925,117.037353515625),      // 地图的中心地理坐标。
                    zoom:8                                                 // 地图的中心地理坐标。
                });

                //绑定单击事件添加参数
                qq.maps.event.addListener(map, 'click', function(event) {
                    var lat = event.latLng.getLat()
                    var lng = event.latLng.getLng()
                    var data={
                        location:lat+','+lng,
                        /*换成自己申请的key*/
                        key:"WR3BZ-PPNWS-32YOI-6EOWO-EDKXH-DPBQQ",
                        get_poi:0
                    }
                    var url="http://apis.map.qq.com/ws/geocoder/v1/?";
                    data.output="jsonp";
                    $.ajax({
                        type:"get",
                        dataType:'jsonp',
                        data:data,
                        jsonp:"callback",
                        jsonpCallback:"QQmap",
                        url:url,
                        success:function(json){
                            console.log(json)
                            address = json.result.address
                            city = json.result.address_component.city
                            province = json.result.address_component.province
                            nation = json.result.address_component.nation
                            $.ajax({
                                type: "post",
                                url: "${ctx}/sys/user/manualCheer",
                                data:{"lng":lng,"lat":lat,"nation":nation,"province":province,"city":city},
                                success:function (date) {
                                    if(date.ok=="ok"){
                                        alert("添加成功");
                                    }else {
                                        alert("添加失败");
                                    }
                                }
                            })
                        },
                        error : function(err){alert("服务端错误，请刷新浏览器后重试")}

                    })

                });
            }

            //调用初始化函数地图
            init();


        }
    </script>
</head>
<body>
<!--   定义地图显示容器   -->
<div id="container"></div>
</body>
</html>
