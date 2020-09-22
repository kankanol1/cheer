package com.thinkgem.jeesite.modules.sys.security;/**
 * Created by HY on 2018/12/26.
 */

import org.apache.shiro.ShiroException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.pam.ModularRealmAuthenticator;
import org.apache.shiro.authc.pam.UnsupportedTokenException;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.Map;

/**
 * @program: jndx
 * @description: 自定义auth
 * @author: Mr.Han
 * @create: 2018-12-26 09:07
 **/

public class DefaultModularRealm extends ModularRealmAuthenticator {
    private Map<String, Object> definedRealms;

    /**
     * 多个realm实现
     */
    @Override
    protected AuthenticationInfo doMultiRealmAuthentication(Collection<Realm> realms, AuthenticationToken token) {
        return super.doMultiRealmAuthentication(realms, token);
    }

    /**
     * 调用单个realm执行操作
     */
    @Override
    protected AuthenticationInfo doSingleRealmAuthentication(Realm realm,
                                                             AuthenticationToken token) {

        // 如果该realms不支持(不能验证)当前token
        if (!realm.supports(token)) {
            String msg = "Realm [" + realm + "] does not support authentication token [" +
                    token + "].  Please ensure that the appropriate Realm implementation is " +
                    "configured correctly or that the realm accepts AuthenticationTokens of this type.";
            throw new UnsupportedTokenException(msg);
        }
        AuthenticationInfo info = null;

            info = realm.getAuthenticationInfo(token);

            if (info == null) {
                String msg = "Realm [" + realm + "] was unable to find account data for the " +
                        "submitted AuthenticationToken [" + token + "].";
                throw new UnknownAccountException(msg);
            }

        return info;
    }

    /**
     * 判断登录类型执行操作
     */
    @Override
    protected AuthenticationInfo doAuthenticate(
            AuthenticationToken authenticationToken)
            throws AuthenticationException {
        this.assertRealmsConfigured();

        Realm realm = null;

        /*DefaultUsernamepasswordToken token = (DefaultUsernamepasswordToken) authenticationToken;
        if (token.getLoginType().equals("huimai")) {
            realm = (Realm) this.definedRealms.get("defaultJdbcRealm");
        }
        if (token.getLoginType().equals("shiro")) {
            realm = (Realm) this.definedRealms.get("shiroDbRealm");
        }*/
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String userAgent = request.getHeader("user-agent").toLowerCase();
        if(userAgent.indexOf("micromessenger")>-1){//微信客户端
            realm = (Realm)this.definedRealms.get("oAuth2Realm");
        }else {
            realm = (Realm)this.definedRealms.get("systemAuthorizingRealm");
        }
        if (realm == null) {
            return null;
        }
        return this.doSingleRealmAuthentication(realm, authenticationToken);
    }

/*    @Override
    protected AuthenticationInfo doAuthenticate(AuthenticationToken authenticationToken) throws AuthenticationException {
        return super.doAuthenticate(authenticationToken);
    }*/

    /**
     * 判断realm是否为空
     */
    @Override
    protected void assertRealmsConfigured() throws IllegalStateException {
        this.definedRealms = this.getDefinedRealms();
        if (CollectionUtils.isEmpty(this.definedRealms)) {
            throw new ShiroException("值传递错误!");
        }
    }

    public Map<String, Object> getDefinedRealms() {
        return this.definedRealms;
    }

    public void setDefinedRealms(Map<String, Object> definedRealms) {
        this.definedRealms = definedRealms;
    }
}
