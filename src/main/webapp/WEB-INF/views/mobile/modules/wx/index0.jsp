<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/wx/wxHead.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

<%--    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">--%>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" href="${ctxStatic}/map/css/wall.css"/>
    <link rel="stylesheet" href="${ctxStatic}/wx/css/housev7.css">
    <script type="text/javascript" src="${ctxStatic}/map/js/barrageWall.js"></script>
    <style>
        .con{
            width: 100%;
        }
        .con li{
            list-style: none;
        }
        .hidden{display: none;}
        .pop-house-features .listBoxsp{
            height: 300px;
        }
        .listBoxsp ul{
            padding: 15px 15px;
        }
        .listBoxsp ul li{
            height: 30px;
            line-height: 30px;
            margin: 10px 0px;
            border-radius: 10px;
            border: 1px solid #eeeeee;
            padding-left: 10px;
        }
        #container .list{
            border: 1px solid #eeeeee;
            border-radius: 20px;
            padding: 0px 10px;
            background: #f0dfda;
            font-size: 15px;
            height: 30px;
            line-height: 30px;
        }
        #container .list img{
            margin-top: -3px;
        }
    </style>
    <title>山东传媒职业学院60周年校庆邀您助威</title>
</head>
<body style="background: #fcefed" >
<div class="weui-tab" style="overflow-y: hidden;width: 100%">
    <%--内容--%>
    <div class="weui-tab__panel" style="padding-bottom: 60px;overflow-y: hidden;overflow-x: hidden">

        <div style="height: 245px;position: relative" >
            <div style="position: absolute;top: 0;left: 0;" >
                <img src="${ctxStatic}/wx/img/cheer/yez.png" style="width: 120px">
            </div>
            <div style="width: 281px;height:110px; margin: 0 auto;padding-top: 30px">
                <img src="${ctxStatic}/wx/img/cheer/tl.png" style="width: 100%" />
            </div>
            <div style="background: #f8ddd8;width: 300px;height: 88px;margin: 0 auto;
            border-radius: 10px;border: #f0a5a4 solid 1px;margin-top: 15px;font-size: 20px;text-align:center;line-height: 40px" >

                <span>累计&nbsp;<span style="font-size: 30px" id="rc">5689</span>&nbsp;人次为</span><br/>
                <span>山东传媒职业学院60年校庆助威</span>

            </div>
        </div>
        <div style="position: relative;margin-top: 10px" id="container" class="container">


        </div>


        <div class="weui-btn-area">
            <button type="button" id="submit1" class="weui-btn weui-btn_primary"  >我要助威</button>
        </div>


        <%--助威口号--%>
        <div class="weui-cells weui-cells_form">
            <section class="pop-house-features sp hidden">
                <div class="zhezhao"></div>
                <div class="con">
                    <p class="top"><span class=""></span><span class="tit">我要助威</span><span class="certain spcertain">关闭</span></p>
                    <div class="listBoxsp">
                     <ul>
                         <li>六十年辉煌，继往开来，再创佳绩</li>
                         <li>建校六十年，桃李尽芬芳</li>
                         <li>恩深情笃共谱母校新篇</li>
                         <li>六十载风雨，造就精英无数</li>
                         <li>桃李芬芳溢四海，群星灿烂遍九州</li>
                     </ul>
                    </div>
                </div>
            </section>
        </div>
        <%--end--%>

    </div>
    <%--内容--%>

    <%--底部导航--%>
   <%-- <%@ include file="/WEB-INF/views/include/wx/footer.jsp"%>--%>
    <%--底部导航--%>
        <div>
            <img src="${ctxStatic}/wx/img/cheer/banner2.png" style="position: absolute;left: 0;bottom: 0;height: 60px;width: 100%;margin: 0 auto">
        </div>
</div>

<script>
    var n
    $(document).ready(function() {
        hy.jssdk();
        var height = $("body").height()
        var h = height-65-245-70
        n = parseInt((h-10)/38)
        $("#container").height(h);

        $(".listBoxsp ul li").click(function () {
            var word = $(this).html()
            zw(word)
        })

    })

    function zw(word) {
    //$("#submit1").click(function (){


        wx.getLocation({
            type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
            success: function (res) {
                var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                var speed = res.speed; // 速度，以米/每秒计
                var accuracy = res.accuracy; // 位置精度

                var address="";
                var city='';
                var province = "";
                var nation = "";

                var data={
                    location:latitude+','+longitude,
                    /*换成自己申请的key*/
                    key:"SJ2BZ-NLICP-FZJDP-LA2F3-E5TBV-JUFOU",
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
                        console.log("test",json);
                        address = json.result.address;
                        city = json.result.address_component.city;
                        province = json.result.address_component.province
                        nation = json.result.address_component.nation

                        $.ajax({
                            type: "post",
                            url: "${ctx}/sys/user/cheer",
                            data:{
                                "lng":longitude,
                                "lat":latitude,
                                "nation":nation,
                                "province":province,
                                "city":city,
                                "cheer":word,
                                "address":address,
                                "area":"wold",
                            },
                            success:function (date) {
                                // console.log(date)
                                if(date.ok==="ok"){
                                    $('.sp').addClass('hidden');
                                    $.toast("助威成功", "text");
                                    $("#container").children("div:last-child").html('<img src="${user.photo}" alt="">：<span style="color: red">'+word+'</span>')
                                    var rc = $("#rc").html()*1+1
                                    $("#rc").html(rc);
                                }else if(date.ok=="no"){
                                    $.toast("您已助威", "text");
                                    $('.sp').addClass('hidden');
                                }else {
                                   $.toast("网络错误", "text");
                                    $('.sp').addClass('hidden');
                                }


                            }
                        })
                    },
                    error : function(err){alert("服务端错误，请刷新浏览器后重试")}

                })
            },
            cancel: function (res) {
              alert("未获取位置")
            }
        });
    }
    //);


    $(function () {
        //////////////////////////////////////////////////////////////////////
        ////////////////// 注意：请尽量少的使用js去处理css样式！//////////////////
        ///////////////// 尤其是当用户量大时，页面的性能的尤为重要 ////////////////
        ///////////////// 所以，请将你需要的各种动效交个css去实现 ////////////////
        ////////////////////// 注意页面重绘带来的性能影响 //////////////////////
        ////////////////////////////////////////////////////////////////////

        var option={
            container:"#container",//弹幕墙的id
            barrageLen:n//弹幕的行数
        }
        barrageWall.init(option);//初始化弹幕墙

        //////////////////////////////////////////////////////////////////////
        /////// 实际调用时必须设置你的 弹幕墙id 和 弹幕的行数 并 初始化弹幕墙，///////
        // 然后调用 barrageWall.upWall("用户头像url","用户昵称","用户输入的内容")//
        /////////////////////////////////////////////////////////////////////

     /*  barrageWall.upWall("images/aq.png","我是说话人1","我说的话");//初始化弹幕墙
        barrageWall.upWall("images/aq.png","我是说话人2","我说的话");//初始化弹幕墙
        barrageWall.upWall("images/aq.png","我是说话人3","我说的话");//初始化弹幕墙
        barrageWall.upWall("images/aq.png","我是说话人4","我说的话");//初始化弹幕墙
        barrageWall.upWall("images/aq.png","我是说话人5","我说的话");//初始化弹幕墙
        barrageWall.upWall("images/aq.png","我是说话人6","我说的话");//初始化弹幕墙*/
        //////////////////////////////////////////////////////////////////////
        ////////// 以下注释掉的部分为测试弹幕效果的各种定时器，模拟用户输入 //////////
        //////////////////////////////////////////////////////////////////////

        $.ajax({
            type: "post",
            url: "${ctx}/sys/user/getCheerList",
            data:{},
            success:function (date) {
               // console.log(date)
             /*   for(var i=0;i<date.length;i=i+n){
                    for(var j=0;j<n;j++) {
                        if(i+j>=date.length){

                        }else {
                            barrageWall.upWall("images/aq.png", date[i + j].area, date[i + j].address);
                        }
                    }
                    var num=0,timer =setInterval(function(){
                        num++;
                        if(num>=n){clearInterval(timer)}
                    },3000);

                }*/

               dm(date)

            }
        })



    })

    function dm(date){
        var num=0,timer =setInterval(function(){
            num++;

            if(num>10){
                clearInterval(timer)
            dm(date)
            }
            var str = date[num]?date[num].city:'济南';
            barrageWall.upWall("${ctxStatic}/wx/img/cheer/xxlogo.png","","我在"+date[num].city+','+date[num].cheer);
        },parseInt(9000/n));

    }

    $(function () {

        //助威选项

        $('#submit1').click(function () {

            $('.sp').removeClass('hidden');
        });
        //选择
        //选择关闭
        $('.spcertain,.zhezhao').click(function () {
            $('.sp').addClass('hidden');
        });
    });

</script>
<script>
    wx.ready(function () {   //需在用户可能点击分享按钮前就先调用
        wx.updateAppMessageShareData({
            title: "山东传媒职业学院60年校庆邀您助威", // 分享标题
            desc: '这里填一些庆典活动详情', // 分享描述
            link: location.href, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            imgUrl: location.protocol+location.host+'${ctxStatic}/wx/img/cheer/xxlogo.png', // 分享图标
            success: function () {
                // 设置成功
            }
        })
    });
    wx.ready(function () {      //需在用户可能点击分享按钮前就先调用
        wx.updateTimelineShareData({
            title: '山东传媒职业学院60年校庆邀您助威', // 分享标题
            link: location.href, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            imgUrl: location.protocol+location.host+'${ctxStatic}/wx/img/cheer/xxlogo.png', // 分享图标
            success: function () {
                // 设置成功
            }
        })
    });


</script>
</body>
</html>
