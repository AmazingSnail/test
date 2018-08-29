package com.dhchain.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类
 * */
public abstract class StringUtil {
	/**
	 * 检查字符串是否为空,为空返回true
	 * @param	str		待检查字符串
	 * @return	boolean
	 * */
	public static boolean isEmpty(String str){
		return str==null || str.length()==0;
	}
	
	/**
	 * 验证是否符合制定格式
	 * @param	regex	检查规则
	 * @param	str  	需要检查的字符串
	 * @return  boolean
	 * */
	public static boolean isMatcher(String regex,String str){
		if(isEmpty(str)||isEmpty(regex)) return false;
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}
	
	/**
	 * 验证是否是邮箱
	 * @param	emial	邮箱号码
	 * @return  boolean
	 * */
	public static boolean isEmail(String email){
		String regex = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		return isMatcher(regex,email);
	}
	
	/**
	 * 验证是否是手机号
	 * @param	tel	手机号
	 * @return  boolean
	 * */
	public static boolean isMobile(String mobile){
		String regex = "^(((13[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$";
		return isMatcher(regex,mobile);
	}
	
	/**
	 * 将连续的几个字符替换为指定的一个字符
	 * */
	public static String replaceAll(String str,String oldStr,String newStr){
		return str.replaceAll(oldStr+"{1,}", newStr);
	}
	
}
