package com.dhchain.config.web;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 将一些必要的信息在应用启动时放入上下文
 */
public class MyContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent event) {
		ServletContext context = event.getServletContext();
		
		/**将上下文放入context中，方便页面获取**/
		context.setAttribute("ctxPath", "/MES");
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		//TODO ignore 销毁上下文做一些数据保存任务
	}

}
