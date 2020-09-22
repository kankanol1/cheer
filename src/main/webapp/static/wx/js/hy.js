var submitFlag = 0;

(function () {
    hy={
        repetition:function () {

            if(submitFlag!=0){
                $.toptip("请勿重复提交表单", 'error');
                return false
            }else {
                return true
            }
        },

        jssdk:function () {
            console.log(location.href.split('#')[0]);
            $.ajax({
                url :ctxf+"/wx/jsapi/aa",
                type : 'post',
                dataType : 'json',
                contentType : "application/x-www-form-urlencoded; charset=utf-8",
                data : {
                    'url' : location.href.split('#')[0]
                },
                success : function(data) {
                    wx.config({
                        debug : false,
                        appId : data.appId,
                        timestamp :data.timestamp,
                        nonceStr : data.nonceStr,
                        signature : data.signature,
                        jsApiList : [ 'checkJsApi', 'onMenuShareTimeline',
                            'onMenuShareAppMessage', 'onMenuShareQQ',
                            'onMenuShareWeibo', 'hideMenuItems',
                            'showMenuItems', 'hideAllNonBaseMenuItem',
                            'showAllNonBaseMenuItem', 'translateVoice',
                            'startRecord', 'stopRecord', 'onRecordEnd',
                            'playVoice', 'pauseVoice', 'stopVoice',
                            'uploadVoice', 'downloadVoice', 'chooseImage',
                            'previewImage', 'uploadImage', 'downloadImage',
                            'getNetworkType', 'openLocation', 'getLocation',
                            'hideOptionMenu', 'showOptionMenu', 'closeWindow',
                            'scanQRCode', 'chooseWXPay',
                            'openProductSpecificView', 'addCard', 'chooseCard',
                            'openCard','updateAppMessageShareData','updateTimelineShareData' ]
                    });
                }
            });
        }

    }

})(jQuery)