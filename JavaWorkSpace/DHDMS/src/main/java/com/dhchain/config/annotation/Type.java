package com.dhchain.config.annotation;
/**
 * 数据源类型,name与配置中的数据源名称一致
 * */
public enum Type {
	/*SQL_MDM数据库*/
	SQL_MDM("SQL_MDM",1),
	/*SQL_EPPRD数据库*/
	SQL_EPPRD("SQL_EPPRD",2),
	/*SQL_DHBI数据库*/
	SQL_DHBI("SQL_DHBI",3);
	private String name;
	private int code;
	Type(String name,int code){
		this.code = code;
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
}
