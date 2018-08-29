package com.dhchain.business.Tractor.service;

import com.dhchain.business.Tractor.vo.TBaseengine;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface TBaseengineService extends IService<TBaseengine> {
    List<TBaseengine> getDHJ (TBaseengine record);//获取发动机型号
    List<TBaseengine> getDL (TBaseengine record);//获取功率
    String importExcelInfo1(InputStream in, MultipartFile file, String User, String time)throws Exception;//导入
}
