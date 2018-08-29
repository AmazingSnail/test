package com.dhchain.config.datasource;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/** 
 * MySQL动态数据源
 * @author created by LiXing on 2017/02/17
 */
public class MultiDataSource extends AbstractRoutingDataSource{

	@Override
	protected Object determineCurrentLookupKey(){
		return DataSourceHolder.getDataSourceName();
	}
	
}
