package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.MaterialCoding;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

public interface BasicDataService extends IService<MaterialCoding> {
    List<MaterialCoding > selectSame1(MaterialCoding record);
    List<MaterialCoding > getJudge();//判断是否抽取数据
    HSSFWorkbook exportExce(String maktx, String matnr);//数据导出
    List<MaterialCoding > getF2();//获取部件特征
    List<MaterialCoding > getF4();//获取套筒
    List<MaterialCoding > getF5();//表面处理
    List<MaterialCoding > getF6();//打印方式
    List<MaterialCoding > getF9();//连接装配方式
    List<MaterialCoding > getF10();//铆头方式
    List<MaterialCoding > getF11();//部件特征二
}
