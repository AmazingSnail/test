package com.dhchain.config.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * 数据源切换标志注解，带有该注解的spring方法会触发数据源切换
 * @author created by LiXing on 2017/04/06
 */
@Inherited
@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DataSource {
	Type value() default Type.SQL_MDM;	//默认是MySQL读数据库
}
