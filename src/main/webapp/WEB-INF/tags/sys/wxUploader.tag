<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ attribute name="sizeId" type="java.lang.String" required="true"%>
<%@ attribute name="size" type="java.lang.String" required="true"%>
<%@ attribute name="fileList" type="java.util.List" required="true"%>
<%@ attribute name="url" type="java.lang.String" required="true"%>
<%@ attribute name="max" type="java.lang.String" required="false"%>
<%@ attribute name="gallery" type="java.lang.String" required="false"%>
<%@ attribute name="galleryImg" type="java.lang.String" required="false"%>
<%@ attribute name="uploader" type="java.lang.String" required="false"%>
<%@ attribute name="uploaderFiles" type="java.lang.String" required="false"%>
<%@ attribute name="old_url" type="java.lang.String" required="false"%>
<%@ attribute name="photoUrl" type="java.lang.String" required="false"%>
<%-----------------------------------------------------图片上传-------------------------------------------------------%>
<input  type="hidden" name="${photoUrl?photoUrl:'photoUrl'}" id="${photoUrl?photoUrl:'photoUrl'}" />
<%--图片预览--%>
<div class="weui-gallery" id="${gallery? gallery:'gallery'}">
    <span class="weui-gallery__img" id="${galleryImg?galleryImg:'galleryImg'}"></span>
    <div class="weui-gallery__opr">
        <a href="javascript:" class="weui-gallery__del">
            <i class="weui-icon-delete weui-icon_gallery-delete"></i>
        </a>
    </div>
</div>
<%--图片上传--%>
<div class="weui-cell" id="${uploader?uploader:'uploader'}">
    <div class="weui-cell__bd">
        <div class="weui-uploader">
            <div class="weui-uploader__hd">
                <p class="weui-uploader__title">图片上传</p>
                <div class="weui-uploader__info"><span id="${sizeId}">${size}</span>/${max?max:5}</div>
            </div>
            <div class="weui-uploader__bd">
                <ul class="weui-uploader__files" id="${uploaderFiles?uploaderFiles:'uploaderFiles'}">
                    <c:forEach items="${fileList}" var="photo" varStatus="ind">
                        <li class="weui-uploader__file ${old_url?old_url:'old_url'}" data-id="" style="background-image: url(${photo});" value="${photo}"> </li>
                    </c:forEach>
                </ul>
                <div class="weui-uploader__input-box ">
                    <input class="weui-uploader__input" type="file" accept="image/jpg,image/jpeg,image/png" multiple=""/>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    $(function(){
        var uploadCount = parseInt($("#${sizeId}").html());
        var uploadCustomFileList = [];
        var countA= [];
        var countInfo= [];
        weui.uploader('#${uploader?uploader:'uploader'}', {
          //  url: '${ctx}/wx/nav/uploadFile',
            url:'${url}',
            auto: false,
            type: 'file',
            fileVal: 'fileVal',
            compress: {
                width: 1600,
                height: 1600,
                quality: .8
            },
            onBeforeQueued: function(files) {
                // `this` 是轮询到的文件, `files` 是所有文件
                countA=[];
                if(["image/jpg", "image/jpeg", "image/png"].indexOf(this.type) < 0){
                    weui.alert('请上传正确的图片类型（jpg/jpeg/png）');
                    return false; // 阻止文件添加
                }
                if(this.size > 20 * 1024 * 1024){
                    weui.alert('请上传不超过20M的图片');
                    return false;
                }
                if (files.length > ${max?max:5}) { // 防止一下子选择过多文件
                    weui.alert('一次只能上传${max?max:5}张图片，请重新选择');
                    return false;
                }
                if (uploadCount + 1 > ${max?max:5}) {
                    weui.alert('最多只能上传${max?max:5}张图片');
                    return false;
                }

                ++uploadCount;
                $("#${sizeId}").html(uploadCount)
                // return true; // 阻止默认行为，不插入预览图的框架
            },
            onQueued: function(){
                uploadCustomFileList.push(this);

            },
            onBeforeSend: function(data, headers){

            },
            onProgress: function(procent){

            },
            onSuccess: function (ret) {
                if(ret.flag==0){
                    countInfo.push(ret.info)
                    countA.push("")
                }else {
                    countA.push(ret.src)
                }
                // countA.push(ret.src)
                // return true; // 阻止默认行为，不使用默认的成功态
            },
            onError: function(err){
                // return true; // 阻止默认行为，不使用默认的失败态
            }
        });

        var $gallery = $("#${gallery? gallery:'gallery'}"), $galleryImg = $("#${galleryImg?galleryImg:'galleryImg'}"),
            $uploaderFiles = $("#${uploaderFiles?uploaderFiles:'uploaderFiles'}");
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
        $(".weui-gallery__del").click(function(e) {
            var target = e.target;
            var id = target.getAttribute('data-id');
            for (var i = 0, len = uploadCustomFileList.length; i < len; ++i) {
                var file = uploadCustomFileList[i];
                if (file.id == id) {
                    index = i;
                    break;
                }
            }
            uploadCustomFileList.splice(index, 1);
            $uploaderFiles.find("li").eq(index).remove();
            uploadCount = uploadCount-1
            $("#${sizeId}").html(uploadCount)
        });
        //点击提交事件
        var flag = true;

        //弹出式提示
        var $toast = $('#toast');
        var $toastContent = $('.weui-toast__content');

            uploadCustomFileList.forEach(function (file) {
                file.upload();
            });
            //拿取照片事件
            var oldPhotoUrl = [];
            $(".${old_url?old_url:'old_url'}").each(function () {
                oldPhotoUrl.push($(this).attr("value"))
            })
            var photoUrl = oldPhotoUrl?oldPhotoUrl.join('|')+'|'+countA.join('|'):countA.join('|')
            $("#${photoUrl?photoUrl:'photoUrl'}").val(photoUrl)
           /* var photoInfo = countInfo.join(",")
            $("#photoInfo").val(photoInfo)*/




    });

</script>

<%-----------------------------------------------------图片上传end-------------------------------------------------------%>