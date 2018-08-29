package com.dhchain.config.datasource;

import java.util.ArrayList;
import java.util.List;

/**
 * 一个线程内的所有数据源保存在此处
 * 不考虑并发，因为该类由一个线程持有
 * @author created by LiXing on 2017/04/06
 * */
public class DataSourceQuene {
	private List<String> queue = new ArrayList<>(5);	//默认支持5层嵌套
	
	/**
	 * 将最新层次的数据源放入最后
	 * */
	public void putDataSource(String dataSourceName){
		queue.add(dataSourceName);
	}
	
	/**
	 * 最后的就是要使用的数据源
	 * */
	public String getDataSource(){
		return queue.get(queue.size()-1);
	}
	
	/**
	 * 移除当前层的数据源
	 * */
	public void removeDataSource(){
		queue.remove(queue.size()-1);
	}
	
	/**
	 * 获取数据源队列当前层次
	 * */
	public int getDataSourceSize(){
		return queue.size();
	}
}
