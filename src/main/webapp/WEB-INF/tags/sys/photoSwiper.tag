<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ attribute name="id" type="java.lang.String" required="true"%>
<%@ attribute name="fileList" type="java.util.List" required="true"%>
<%@ attribute name="file" type="java.lang.String" required="true"%>
<%@ attribute name="time" type="java.lang.String" required="false"%>
<style>
    .weui-photo-browser-modal.weui-photo-browser-modal-visible{
        z-index: 9999;
    }
</style>

<div class="swiper-container" id="${id}">
    <div class="swiper-wrapper">
        <c:forEach items="${fileList}" var="img" varStatus="ind">
            <div class="swiper-slide"><a href="javascript:void(0)"  onclick="img_open(${ind.index})">
                <img src="${img}" alt="" style="width: 100%"></a></div>
        </c:forEach>
    </div>
    <div class="swiper-pagination"></div>
</div>
<script>
    var time = '${time}'==''?3000:'${time}'
    $(document).ready(function(){
        var mySwiper = new Swiper ('#${id}',{
            speed:2000,
            loop : true,
            preventClicks : true,
            loopAdditionalSlides : 3,
            autoplay: {
                delay: time,//?秒切换一次
            },
            pagination: {
                el: '.swiper-pagination',
            }
        })
    })

    var img = '${file}'
    var imgs = img.split("|")
    function img_open(index) {
        pb = $.photoBrowser({
            items:imgs,
            initIndex:index
        })
        pb.open()
    }
</script>