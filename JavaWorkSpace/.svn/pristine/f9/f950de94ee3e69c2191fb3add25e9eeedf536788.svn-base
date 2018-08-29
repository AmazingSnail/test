package com.dhchain.business.Tractor.service;

import com.dhchain.business.Tractor.vo.TBasetyre;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface TBasetyreService extends IService<TBasetyre> {
    List<TBasetyre> getQL(TBasetyre reocrd);//获取前轮数据
    List<TBasetyre> getZJ(TBasetyre reocrd);//获取轴距或者轨距
    List<TBasetyre> getZJ1(TBasetyre reocrd);//获取轴距或者轨距
    List<TBasetyre> getTireSpect(TBasetyre reocrd);//获取履带
    List<TBasetyre> getTireSpect1(TBasetyre reocrd);//获取履带
    List<TBasetyre> getHL(TBasetyre reocrd);//获取后轮数据
    List<TBasetyre> getsprect(TBasetyre reocrd);//后轮轮胎规格数据
    List<TBasetyre> getsprect1(TBasetyre reocrd);//qian 轮轮胎规格数据
    String importExcelInfo1(InputStream in, MultipartFile file, String User, String time)throws Exception;//导入
}
