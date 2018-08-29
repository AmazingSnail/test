package com.dhchain.business.Tractor.service;


import com.dhchain.business.Tractor.vo.TBasedate;
import com.dhchain.business.Tractor.vo.TBasestatus;
import com.dhchain.business.Tractor.vo.Uuser;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface TBasedateService extends  IService<TBasedate> {
    List<TBasedate> getZJ (TBasedate record);//获取轴距;
    List<TBasedate> getZJType (TBasedate record);//获取轴距;
    List<TBasedate> getSize (TBasedate record);//尺寸
    List<TBasedate> getUse (TBasedate record);//最小使用质量
    List<TBasedate> getForce (TBasedate record);//牵引力
    List<TBasedate> getBZ (TBasedate record);//标准
    List<TBasestatus> getStauts ( );//数据集
    List<Uuser> getUser( Uuser record);//得到登录人姓名
    String importExcelInfo1(InputStream in, MultipartFile file, String User,String time)throws Exception;//导入
}
