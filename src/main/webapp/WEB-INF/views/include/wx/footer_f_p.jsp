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
<c:choose>
    <c:when test="${empty audit}">
        <div class="weui-tabbar footer">
              <a href="${ctx}/" class="weui-tabbar__item" id="home">
                  <div class="weui-tabbar__icon">
                      <img src="${ctxStatic}/wx/img/home.png" alt="">
                  </div>
                  <p class="weui-tabbar__label">首页</p>
              </a>
              <a href="javascript:void(0)" onclick="zf()" class="weui-tabbar__item"  style="padding: 0;background: #99CC66">
                  <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                      <i class="iconfont iconicon-" style="font-size: 18px">转发</i>

                  </div>
              </a>
            <a href="" onclick="$(this).attr('href','tel:'+$('#tel').val())" class="weui-tabbar__item"  style="padding: 0;background: #FF6666">
                <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                    <i class="iconfont icondianhua" style="font-size: 18px">电话</i>

                </div>
            </a>
            <shiro:hasPermission name="htinfo:htInfo:audit">
            <a href="${ctx}/htinfo/htInfo/formAudit?id=${entity.id}" class="weui-tabbar__item"  style="padding: 0;background: #FFB800">
                <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                    <i class="iconfont iconshenhe" style="font-size: 18px">审核</i>
                </div>
            </a>
            </shiro:hasPermission>
        </div>
    </c:when>
    <c:otherwise>
        <div class="weui-tabbar footer">
            <a href="${ctx}/" class="weui-tabbar__item">
                <div class="weui-tabbar__icon">
                    <img src="${ctxStatic}/wx/img/home.png" alt="">
                </div>
                <p class="weui-tabbar__label">发布人</p>
            </a>
            <a href="${ctx}/htinfo/htInfo/pass?id=${entity.id}" class="weui-tabbar__item"  style="padding: 0;background: #99CC66">
                <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                    <i class="iconfont iconicon-" style="font-size: 18px">通过</i>

                </div>
            </a>
            <a href="javascript:void(0)" onclick="reject('${entity.id}')" class="weui-tabbar__item"  style="padding: 0;background: #FF6666">
                <div class="" style="height: 50px;line-height: 50px;text-align: center;color: #ffffff">
                    <i class="iconfont icondianhua" style="font-size: 18px">驳回</i>

                </div>
            </a>
        </div>


        <script>
            function reject(id) {

                $.prompt({
                    title: '驳回',
                    input: '',
                    empty: false, // 是否允许为空
                    onOK: function (input) {
                        window.location.href ="${ctx}/htinfo/htInfo/reject?id="+id+"&auditInfo="+input
                    },
                    onCancel: function () {
                        //点击取消
                    }
                });
                var info = '<datalist id="reject_info">' +
                    '<option value="信息包含诱导分享">信息包含诱导分享</option>' +
                    '<option value="信息与信息分类不匹配">信息与信息分类不匹配</option>' +
                    '</datalist>'
                $("#weui-prompt-input").attr("list","reject_info").after(info)
                $("#weui-prompt-input").val('${entity.auditInfo}')
            }

        </script>
    </c:otherwise>
</c:choose>
<!--分享引导框开始-->
<div id="guide_box" style="display: none" >
    <img src="${ctxStatic}/wx/img/fxImg/548763-20181029142331381-145297350.png"  class="img-responsive img-rounded" width="200px">
    <img src="${ctxStatic}/wx/img/fxImg/548763-20181029142348249-1446544485.png"  class="img-responsive img-rounded" width="200px" onclick="layer.closeAll();">
</div>
<!--分享引导框结束-->
<script>
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
</script>
