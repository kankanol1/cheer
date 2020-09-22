<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--    <div style=" position: absolute;right: 25px;bottom: 200px;z-index: 99">
       <a href="#" onclick="javascript :history.back(-1);" > <img src="${ctxStatic}/wx/img/fanhui.png" style="width: 50px;height: 50px"/></a>
    </div>--%>

    <div class="weui-tabbar footer">
        <a href="${ctx}" class="weui-tabbar__item" id="home">
            <div class="weui-tabbar__icon">
                <img src="${ctxStatic}/wx/img/home.png" alt="">
            </div>
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${ctx}/issue" class="weui-tabbar__item" id="issue">
            <div class="weui-tabbar__icon">
                <img src="${ctxStatic}/wx/img/icon_bg_bm.png" alt="">
            </div>
            <p class="weui-tabbar__label">发布</p>
        </a>
        <a href="${ctx}/me/index" class="weui-tabbar__item" id = "me">
            <div class="weui-tabbar__icon">
                <img src="${ctxStatic}/wx/img/icon_bg_hd.png" alt="">
            </div>
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
<script>
    $(document).ready(function(){
       var active = '${active}';
       if(active==0){
           $("#home").addClass("weui-bar__item--on")
       }else if(active==1){
           $("#issue").addClass("weui-bar__item--on")
       }else if(active==2){
           $("#me").addClass("weui-bar__item--on")
       }

    })
</script>
