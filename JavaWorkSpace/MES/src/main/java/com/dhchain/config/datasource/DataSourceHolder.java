package com.dhchain.config.datasource;

/**
 * 本线程数据源持有
 * (做成一个队列,避免嵌套造成数据源丢失问题,执行过程不能开新线程)
 * @author LiXing 2017/04/06
 * */
public class DataSourceHolder {
	
	// 线程本地环境
	private static final ThreadLocal<DataSourceQuene> contextHolderQueue = new ThreadLocal<DataSourceQuene>(); 
	
	// 设置数据源类型
	public static void setDataSourceName(String dataSourceName){
		DataSourceQuene queue = contextHolderQueue.get();
		if(queue==null){
			queue = new DataSourceQuene();
			contextHolderQueue.set(queue);
		}
		queue.putDataSource(dataSourceName);
	}

	// 获取数据源类型
	public static String getDataSourceName(){
		DataSourceQuene queue = contextHolderQueue.get();
		return queue==null?null:queue.getDataSource();
	}

	// 清除数据源类型
	public static void clearDataSourceName(){
		DataSourceQuene queue = contextHolderQueue.get();
		queue.removeDataSource();
		if(queue.getDataSourceSize()==0){
			contextHolderQueue.remove();
		}
	}
}
