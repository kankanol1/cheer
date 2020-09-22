<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .layui-m-layer-nobg{
        background-color:rgba(0,0,0,0)!important;
        float: right;
    }
    .layui-layer {
        box-shadow: 1px 1px 50px rgba(0,0,0,0);}
    #guide_box img{
        float: right;
    }
</style>

        <div class="weui-tabbar footer">
              <a href="${ctx}/" class="weui-tabbar__item" id="home">
                  <div class="weui-tabbar__icon">
                      <img src="${ctxStatic}/wx/img/home.png" alt="">
                  </div>
                  <p class="weui-tabbar__label">首页</p>
              </a>
              <a href="javascript:void(0)" onclick="openLoct()" class="weui-tabbar__item"  style="padding: 0;background: #99CC66">
                  <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                      <i class="iconfont iconicon-" style="font-size: 18px">导航</i>

                  </div>
              </a>
            <a href="javascript:void(0)" onclick="openewm()" class="weui-tabbar__item"  style="padding: 0;background: #FFB800">
                <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                    <i class="iconfont iconshenhe" style="font-size: 18px">微信</i>
                </div>
            </a>
            <a href="" onclick="$(this).attr('href','tel:'+$('#tel').val())" class="weui-tabbar__item"  style="padding: 0;background: #FF6666">
                <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                    <i class="iconfont icondianhua" style="font-size: 18px">电话</i>

                </div>
            </a>

        </div>

        <script>
            function openLoct() {
                wx.openLocation({
                    latitude: '${entity.lat}', // 纬度，浮点数，范围为90 ~ -90
                    longitude: '${entity.lng}', // 经度，浮点数，范围为180 ~ -180。
                    name: '${entity.name}', // 位置名
                    address: '${entity.location}', // 地址详情说明
                    scale: 17, // 地图缩放级别,整形值,范围从1~28。默认为最大
                    infoUrl: '' // 在查看位置界面底部显示的超链接,可点击跳转
                });
            }

            function openewm() {
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: ['auto'],
                    offset: 'auto',
                    skin: 'layui-layer-nobg', //没有背景色
                    shadeClose: true,
                    content: $('#ewm')
                });
            }

        </script>
<!--分享引导框开始-->
<div id="guide_box" style="display: none" >
    <img src="${ctxStatic}/wx/img/fxImg/548763-20181029142331381-145297350.png"  class="img-responsive img-rounded" width="200px">
    <img src="${ctxStatic}/wx/img/fxImg/548763-20181029142348249-1446544485.png"  class="img-responsive img-rounded" width="200px" onclick="layer.closeAll();">
</div>
<!--分享引导框结束-->
<script>
    var layer

    function zf() {
        layui.use('layer', function(){
            var layer = layui.layer;
         layer.open({
                type: 1,
                title: false,
                offset: 'rt',
                closeBtn: 0,
                shadeClose: true,
                skin: 'layui-m-layer-nobg',
                content: $('#guide_box')
            });
        });
    }

    layui.use('layer', function() {
        layer = layui.layer;
    })
    function closeEwm() {
        layer.closeAll()
    }

</script>
<div style="display: none;width:200px" id="ewm">
<img src="${entity.wxPhoto}" style="width: 100%;height: auto"/>
    <i class="iconfont iconguanbi" style="font-size: 40px;margin: 0 auto;width: 20px;display: block;z-index: -999" onclick="closeEwm()" ></i>
</div>

