<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ attribute name="name" type="java.lang.String" required="true"%>
<%@ attribute name="title" type="java.lang.String" required="false"%>
<%@ attribute name="fileList" type="java.util.List" required="false"%>
<%@ attribute name="onephoto" type="java.lang.String" required="false"%>
<%@ attribute name="max" type="java.lang.String" required="false"%>
<%@ attribute name="storageLong" type="java.lang.Boolean" required="false"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="是否查看模式"%>
<style>
   .weui-uploader__file {
        width: 24%!important;margin-right: 1%!important;margin-bottom: 1%!important;padding: 0!important
    }
</style>
<%-----------------------------------------------------图片上传-------------------------------------------------------%>
<input type="hidden" name="${name}" id="${name}"/>
<div class="weui-cells weui-cells_form">
    <%--预览--%>
    <div class="weui-gallery" id="gallery${name}">
        <span class="weui-gallery__img" id="galleryImg${name}"></span>
        <c:if test="${!readonly}">
        <div class="weui-gallery__opr">
            <a href="javascript:" class="weui-gallery__del weui-gallery__del${name}">
                <i class="weui-icon-delete weui-icon_gallery-delete"></i>
            </a>
        </div>
        </c:if>
    </div>
    <!--图片上传-->
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <div class="weui-uploader">
                <div class="weui-uploader__hd">
                    <p class="weui-uploader__title">${empty title?'上传照片':title}</p>
                    <div class="weui-uploader__info"><span id="tp${name}">0</span>/${empty max?"9":max}</div>
                </div>
                <div class="weui-uploader__bd" style="margin-right: -1%">
                    <ul class="weui-uploader__files" id="uploaderFiles${name}">
                        <c:if test="${not empty fileList}">
                          <c:forEach items="${fileList}" var="photo" varStatus="ind">
                              <li class="weui-uploader__file weui-uploader__file${name} old_url" data-id="" style="background-image: url(${photo});" value="${photo}"> </li>
                          </c:forEach>
                        </c:if>
                        <c:if test="${not empty onephoto}">
                            <li class="weui-uploader__file weui-uploader__file${name} old_url" data-id="" style="background-image: url(${onephoto});" value="${onephoto}"> </li>
                        </c:if>

                    </ul>
                    <c:if test="${!readonly}">
                    <div class="weui-uploader__input-box box${name}" style="width: 21%!important">
                        <button id="uploaderInput${name}" class="weui-uploader__input zjxfjs_file" type="button"  <%--type="file" accept="image/*" multiple=""--%>/>
                    </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">


    $(function(){

        var max ='${max}'

        if(!max){
            max = 9
        }
        var name = '${name}'

        var now2 = $(".weui-uploader__file"+name).length

        $("#uploaderInput${name}").on("click",function(){
            var now = $(".weui-uploader__file"+name).length
            if((max*1-now*1)>0) {
                wx.chooseImage({
                    count: max*1-now*1, // 可选图片张数，默认9
                    sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有
                    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
                    success: function (res) {
                        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
                        var serverIdArr = new Array();
                        $.showLoading("上传中");
                        for (let i = 0; i < localIds.length; i++) {
                            wx.uploadImage({//根据本地ID获得微信服务器ID
                                localId: localIds[i].toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
                                isShowProgressTips: 1, // 默认为1，显示进度提示
                                success: function (res) {
                                    var serverId = res.serverId; // 返回图片的服务器端ID
                                    serverIdArr.push(serverId);
                                    if (localIds.length == i + 1) {
                                        downloadImg(serverIdArr);//下载微信服务器下的图片
                                    }
                                }
                            });
                        }
                    }
                });
            }else{
                $.toptip('图片数量超限制，点击已上传图片，删除', 'error');
            }
        });


        var $gallery = $("#gallery${name}"), $galleryImg = $("#galleryImg${name}"),
            $uploaderFiles = $("#uploaderFiles${name}");
        var index; //第几张图片
        $uploaderFiles.on("click", "li", function(){
            index = $(this).index();
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });

        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });
        //删除图片
        $(".weui-gallery__del${name}").click(function(e) {
            $uploaderFiles.find("li").eq(index).remove();
            joinUrl()
        });

        function downloadImg(serverIdArr){//下载微信服务器下的图片到本地
            $.ajax({
                type:"POST",
                url:"${ctx}/wxDown",
                dataType:"json",
                data:{
                    "ids":serverIdArr.join(","),
                    "storageLong":'${storageLong}'?true:false
                },
                success:function(result){
                    $.hideLoading();
                    if(result.flag==1){
                        for(let i=0;i<result.list.length;i++) {
                            $("#uploaderFiles${name}").append(' <li class="weui-uploader__file weui-uploader__file${name} old_url" data-id="'+result.list[i]+'" style="background-image: url(' + result.list[i] + ')"> </li>')
                        }
                        $.toptip("上传成功",1000,'success');
                        joinUrl()
                    }
                }
            });
        }

        function joinUrl() {
            var joinUrl=[]
            now =$(".weui-uploader__file${name}").length
            $("#tp${name}").html(now)
            $(".weui-uploader__file${name}").each(function () {
                joinUrl.push($(this).attr("data-id"))
            })
            if('${max}'==1){
                $("#${name}").val(joinUrl[0])
            }else{
                $("#${name}").val(joinUrl.join("|"))
            }
        }

    });
</script>
<%-----------------------------------------------------图片上传end-------------------------------------------------------%>