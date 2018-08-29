package com.dhchain.config.datasource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import com.dhchain.config.annotation.DataSource;

/**
 * 动态数据源切换AOP
 * @author created by LiXing on 2017/04/06
 * */
@Aspect
@Component
public class DynamicDataSourceAspert {
	
	@Around("execution(* com.dhchain..*Service*.*(..)) && @annotation(ds)")
	public Object dataSourceConvert(ProceedingJoinPoint point,DataSource ds) throws Throwable{
		try {
			DataSourceHolder.setDataSourceName(ds.value().getName());
			return point.proceed();							//执行方法
		} finally{
			DataSourceHolder.clearDataSourceName();			//执行完成清理一次
		}
	}
}
