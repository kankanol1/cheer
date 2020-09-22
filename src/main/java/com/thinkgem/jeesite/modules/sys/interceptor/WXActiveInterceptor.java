/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.interceptor;

import com.thinkgem.jeesite.common.service.BaseService;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 手机微信导航active拦截器
 * @author ThinkGem
 * @version 2014-9-1
 */
public class WXActiveInterceptor extends BaseService implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (modelAndView != null){
			// 如果是微信浏览器。
			String userAgent = request.getHeader("user-agent").toLowerCase();
			if(userAgent.indexOf("micromessenger")>-1) {//微信客户端
                if(modelAndView.getViewName().indexOf("wx/home")!=-1){
                    request.setAttribute("active",0);
                }else  if(modelAndView.getViewName().indexOf("wx/issue")!=-1){
                    request.setAttribute("active",1);
                }else if(modelAndView.getViewName().indexOf("wx/me")!=-1){
                    request.setAttribute("active",2);
                }
			}
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
		
	}

}
