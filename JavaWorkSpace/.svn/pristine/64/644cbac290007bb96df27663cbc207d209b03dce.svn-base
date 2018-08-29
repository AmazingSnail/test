package com.dhchain.util.druid;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = "com.dhchain.system.dao.mdm", sqlSessionTemplateRef = "mdmSqlSessionTemplate")
public class MdmDataSourceConfig {
    @Bean(name = "mdmDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.mdm")
    public DataSource setDataSource() {
        return new DruidDataSource();
    }

    @Bean(name = "mdmTransactionManager")
    public DataSourceTransactionManager setTransactionManager(@Qualifier("mdmDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean(name = "mdmSqlSessionFactory")
    public SqlSessionFactory setSqlSessionFactory(@Qualifier("mdmDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);
//        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/zentao/*.xml"));
        return bean.getObject();
    }

    @Bean(name = "mdmSqlSessionTemplate")
    public SqlSessionTemplate setSqlSessionTemplate(@Qualifier("mdmSqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}