package com.dhchain.config.vo;

/**
 * 基本返回类
 * */
public class PageResult<T> extends BaseResult<T>{
	private int page;		//当前页
	private int totalPage;	//总页数
	private int pageSize;	//每页大小
	private long count;		//总条数
	
	public PageResult(){}
	
	public PageResult(int status,String message){
		super(status, message);
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}
	
	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

	/**
	 * 清除数据信息(在异常时清除之前设置的数据信息)
	 * @return BaseResult<T>
	 * */
	public PageResult<T> clear(){
		this.page = 0;
		this.count = 0;
		this.pageSize = 0;
		this.totalPage = 0;
		super.setResult(null);
		return this;
	}
}
