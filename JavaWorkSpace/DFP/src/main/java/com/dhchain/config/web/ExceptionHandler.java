package com.dhchain.config.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 * 统一异常捕获
 * 系统捕获到异常后会调用此Handler，不会直接抛到页面，可在此根据不同的异常渲染不同的页面
 * */
public class ExceptionHandler implements HandlerExceptionResolver {

	private static final Logger logger = LoggerFactory.getLogger(ExceptionHandler.class);
  
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response,Object handler, Exception ex) {
    	
    	logger.error("捕获到Controller异常，请及时处理！handler：{}",handler,ex);
    	
    	boolean isAjaxRequest = request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest");
    	if(isAjaxRequest){
    		return null;
    	}else{
	        Map<String, Object> model = new HashMap<String, Object>();  
	        model.put("ex", ex);  
	        return new ModelAndView("/error/500", model);
    	}
    }  
} 