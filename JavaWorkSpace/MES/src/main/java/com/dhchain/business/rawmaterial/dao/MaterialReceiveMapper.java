package com.dhchain.business.rawmaterial.dao;

import com.dhchain.business.base.dao.BaseDao;
import com.dhchain.business.rawmaterial.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by ASUS on 2018/8/3.
 */
/**
 * 材料接受后台dao接口
 *
 * @author ct
 * @date 2018-08-06
 */
public interface MaterialReceiveMapper extends BaseDao<MMaterialreceive> {
    List<MMaterialreceive> getSerialno (MMaterialreceive record);//获取最大编号
    List<BaseSupplier> getSupplier (BaseSupplier record);//获取供应商
    List<Materialreceive> getReceviceInAll (Materialreceive record);// 获取接收汇总数据
    List<Materialsend> getReceviceOutAll (Materialsend record);// 获取发出汇总数据
    List<MMaterialreceive> getDay (MMaterialreceive record);//当天数据
    List<Base> getPlantIn(@Param("plant") String plant);
    List<Base> getLGORTIn(@Param("plant") String plant,
                          @Param("UserName") String UserName);
}
