package com.dhchain.config.vo;

/**
 * 非分页的结果返回
 * */
public class BaseResult<T> {
	private int status = 200;	//状态(200:正常  )
	private String message;	    //提示信息
	private String jumpUrl;     //跳转信息
	
	private T result;		    //数据

	public BaseResult(){}
	
	public BaseResult(int status,String message){
		this.status = status;
		this.message = message;
	}

	public int getStatus() {
		return status;
	}

	/**
	 * 重新设置状态码
	 * @param	status	状态码
	 * @return  BaseResult<T>
	 * */
	public BaseResult<T> setStatus(int status) {
		this.status = status;
		return this;
	}

	public String getMessage() {
		return message;
	}

	/**
	 * 设置提示信息
	 * @param	message		消息
	 * @return  BaseResult<T>
	 * */
	public BaseResult<T> setMessage(String message) {
		this.message = message;
		return this;
	}

	public String getJumpUrl() {
		return jumpUrl;
	}

	public void setJumpUrl(String jumpUrl) {
		this.jumpUrl = jumpUrl;
	}

	public T getResult() {
		return result;
	}

	/**
	 * 设置结果集
	 * @param	message		消息
	 * @return  BaseResult<T>
	 * */
	public BaseResult<T> setResult(T result) {
		this.result = result;
		return this;
	}
}
