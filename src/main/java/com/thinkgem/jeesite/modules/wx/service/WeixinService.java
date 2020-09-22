package com.thinkgem.jeesite.modules.wx.service;


import com.thinkgem.jeesite.common.config.WxMpConfig;
import me.chanjar.weixin.common.api.WxConsts;

import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.impl.WxMpServiceImpl;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.config.impl.WxMpDefaultConfigImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;


/**
 * 
 * @author hy
 *
 */
@Service
public class WeixinService extends WxMpServiceImpl {
  @Autowired
  private WxMpConfig wxConfig;



  private WxMpMessageRouter router;

  @PostConstruct
  public void init() {
    final WxMpDefaultConfigImpl config = new WxMpDefaultConfigImpl();
    // 设置微信公众号的appid
    config.setAppId(this.wxConfig.getAppid());
    // 设置微信公众号的app corpSecret
    config.setSecret(this.wxConfig.getAppsecret());
    // 设置微信公众号的token
    config.setToken(this.wxConfig.getToken());
    // 设置消息加解密密钥
    config.setAesKey(this.wxConfig.getAesKey());
    super.setWxMpConfigStorage(config);

    this.refreshRouter();
  }

  private void refreshRouter() {
    final WxMpMessageRouter newRouter = new WxMpMessageRouter(this);
 /*   newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
            .event(WxConsts.EventType.TEMPLATE_SEND_JOB_FINISH).handler(this.msgHandler).end();


    newRouter.rule().async(false).msgType(WxConsts.XmlMsgType.EVENT)
            .event(WxConsts.EventType.SUBSCRIBE).handler(this.gzHandler)
            .end();
    // 默认
    newRouter.rule().async(false).handler(this.msgHandler).end();*/

    this.router = newRouter;
  }

  public WxMpXmlOutMessage route(WxMpXmlMessage message) {
    try {
      return this.router.route(message);
    } catch (Exception e) {
      e.printStackTrace();
    }

    return null;
  }
}
