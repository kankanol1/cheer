package com.thinkgem.jeesite.modules.wx.web;/**
 * Created by HY on 2019/11/22.
 */

import com.thinkgem.jeesite.modules.wx.service.WeixinService;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @program: htwsq
 * @description:
 * @author: Mr.Wang
 * @create: 2019-11-22 22:47
 **/
@Controller
@RequestMapping(value = "${frontPath}/wx/jsapi")
public class JsapiTicketController {
    @Autowired
    private WeixinService weixinService;

    @RequestMapping(value = {"aa"})
    @ResponseBody
    public WxJsapiSignature aa(String url){
        System.out.println(url);
        WxJsapiSignature jsapiSignature = null;
        try {
             jsapiSignature = weixinService.createJsapiSignature(url);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return jsapiSignature;
    }
}
