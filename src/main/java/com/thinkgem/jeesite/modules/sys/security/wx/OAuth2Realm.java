package com.thinkgem.jeesite.modules.sys.security.wx;


import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.security.MyRealm;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.LogUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wx.service.WeixinService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;

import java.util.Collection;
import java.util.List;

/**
 * <p>User: Zhang Kaitao
 * <p>Date: 14-2-18
 * <p>Version: 1.0
 */
public class OAuth2Realm extends MyRealm {

/*    private String clientId;
    private String clientSecret;
    private String accessTokenUrl;
    private String userInfoUrl;
    private String redirectUrl;*/

    private SystemService systemService;
    private WxMpService wxMpService;

/*    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }

    public void setAccessTokenUrl(String accessTokenUrl) {
        this.accessTokenUrl = accessTokenUrl;
    }

    public void setUserInfoUrl(String userInfoUrl) {
        this.userInfoUrl = userInfoUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }*/

    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof OAuth2Token;//表示此Realm只支持OAuth2Token类型
    }

    /**
     * 获取权限授权信息，如果缓存中存在，则直接从缓存中获取，否则就重新获取， 登录成功后调用
     */
    @Override
    protected AuthorizationInfo getAuthorizationInfo(PrincipalCollection principals) {
        if (principals == null) {
            return null;
        }

        AuthorizationInfo info = null;

        info = (AuthorizationInfo) UserUtils.getCache(UserUtils.CACHE_AUTH_INFO);

        if (info == null) {
            info = doGetAuthorizationInfo(principals);
            if (info != null) {
                UserUtils.putCache(UserUtils.CACHE_AUTH_INFO, info);
            }
        }

        return info;
    }

    /**
     * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
     Principal principal = (Principal) getAvailablePrincipal(principals);

        // 获取当前已登录的用户
        if (!Global.TRUE.equals(Global.getConfig("user.multiAccountLogin"))){
            Collection<Session> sessions = getSystemService().getSessionDao().getActiveSessions(true, principal, UserUtils.getSession());
            if (sessions.size() > 0){
                // 如果是登录进来的，则踢出已在线用户
                if (UserUtils.getSubject().isAuthenticated()){
                    for (Session session : sessions){
                        getSystemService().getSessionDao().delete(session);
                    }
                }
                // 记住我进来的，并且当前用户已登录，则退出当前用户提示信息。
                else{
                    UserUtils.getSubject().logout();
                    throw new AuthenticationException("msg:账号已在其它地方登录，请重新登录。");
                }
            }
        }
        User user = getSystemService().getUserByLoginName(principal.getLoginName());
        if (user != null) {
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            List<Menu> list = UserUtils.getMenuList();
            for (Menu menu : list){
                if (StringUtils.isNotBlank(menu.getPermission())){
                    // 添加基于Permission的权限信息
                    for (String permission : StringUtils.split(menu.getPermission(),",")){
                        info.addStringPermission(permission);
                    }
                }
            }
            // 添加用户权限
            info.addStringPermission("user");
            // 添加用户角色信息
            for (Role role : user.getRoleList()){
                info.addRole(role.getEnname());
            }
            // 更新登录IP和时间
            getSystemService().updateUserLoginInfo(user);
            // 记录登录日志
            LogUtils.saveLog(Servlets.getRequest(), "系统登录");
            return info;
        } else {
            return null;
        }
    }
    public SystemService getSystemService() {
        if (systemService == null){
            systemService = SpringContextHolder.getBean(SystemService.class);
        }
        return systemService;
    }
    public WxMpService getWxMpService() {
        if (wxMpService == null){
            wxMpService = SpringContextHolder.getBean(WeixinService.class);
        }
        return wxMpService;
    }


    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        OAuth2Token oAuth2Token = (OAuth2Token) token;
        String code = oAuth2Token.getAuthCode();
        System.out.println("----------------------oauth2.0----------------------------");
        WxMpOAuth2AccessToken wxMpOAuth2AccessToken = getWxMpOAuth2AccessToken(code);
        String openId = getOpenId(wxMpOAuth2AccessToken);
         User user = new User();
        if(openId!=null) {
            user.setOpenId(openId);
            user = getSystemService().getUserByOpenId(user);

            if (user == null) {
                //改微信用户第一次登陆，创建用户
                WxMpUser wxMpUser = null;
                try {
                    wxMpUser = wxMpService.oauth2getUserInfo(wxMpOAuth2AccessToken, null);
                } catch (WxErrorException e) {
                    e.printStackTrace();
                }
                user = new User(wxMpUser);
                user.setOffice(new Office("2"));
                Role role = getSystemService().getRole("6");
                user.getRoleList().add(role);
                getSystemService().saveUser(user);
            } else if (user != null && !"1".equals(user.getLoginFlag())) {
                //todo 拉黑用户禁止登陆导航页  在shiro failureUrl配置路径
                throw new AuthenticationException("msg:该已帐号禁止登录");
            }
        }else {
            user =null;
        }

        SimpleAuthenticationInfo authenticationInfo =
                new SimpleAuthenticationInfo(new Principal(user,false), code, getName());
        return authenticationInfo;
    }

    private String getOpenId(WxMpOAuth2AccessToken wxMpOAuth2AccessToken){
        return  wxMpOAuth2AccessToken.getOpenId();
    }

    private WxMpOAuth2AccessToken getWxMpOAuth2AccessToken(String code){

        WxMpOAuth2AccessToken wxMpOAuth2AccessToken=null;
        try {
            wxMpOAuth2AccessToken = getWxMpService().oauth2getAccessToken(code);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return wxMpOAuth2AccessToken;
    }

}
