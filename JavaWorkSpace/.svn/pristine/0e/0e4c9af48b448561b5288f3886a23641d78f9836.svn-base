package com.dhchain.config.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhchain.business.index.vo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 统一的登录验证拦截器，对所有请求进行拦截
 * */
public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO ignore
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO ignore
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {

		
		/**
		 * 在此处做登录验证，如果验证不通过则跳转到登录界面，否则放行
		 * true表示放行
		 * false表示终止继续访问
		 *
		 * */
		return true;
	}
}
