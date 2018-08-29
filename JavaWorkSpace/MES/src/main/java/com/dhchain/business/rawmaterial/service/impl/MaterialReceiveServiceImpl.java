package com.dhchain.business.rawmaterial.service.impl;

import com.dhchain.business.rawmaterial.dao.MaterialReceiveMapper;
import com.dhchain.business.rawmaterial.service.MaterialReceiveService;
import com.dhchain.business.rawmaterial.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ASUS on 2018/8/3.
 */
/**
 * 材料接受后台service接口实现
 *
 * @author ct
 * @date 2018-08-06
 */
@Service("MaterialReceiveService")
public class MaterialReceiveServiceImpl extends BaseService<MMaterialreceive> implements MaterialReceiveService {
    @Autowired
    private MaterialReceiveMapper materialReceiveMapper;
    @Override
    public List<MMaterialreceive> getSerialno(MMaterialreceive record) {
        return materialReceiveMapper.getSerialno(record);
    }

    @Override
    public List<MMaterialreceive> getDay(MMaterialreceive record) {
        return materialReceiveMapper.getDay(record);
    }
    @Override
    public List<Materialreceive> getReceviceInAll(Materialreceive record) {
        return materialReceiveMapper.getReceviceInAll(record);
    }

    @Override
    public List<Materialsend> getReceviceOutAll(Materialsend record) {
        return materialReceiveMapper.getReceviceOutAll(record);
    }

    @Override
    public List<BaseSupplier> getSupplier(BaseSupplier record) {
        return materialReceiveMapper.getSupplier(record);
    }

    @Override
    public String getPlantIn(String plant) {
        Base base = new Base();
        List<Base> list= materialReceiveMapper.getPlantIn(plant);
        base.setFno("");
        if (list.size()>0){
            base = list.get(0);
        }
        return base.getFno();
    }
    @Override
    public String getLGORTIn(String plant,String UserName) {
        Base Rbase = new Base();
        List<Base> list= materialReceiveMapper.getLGORTIn(plant,UserName);
        Rbase.setFremark("");
        if (list.size()>0){
            Rbase = list.get(0);
        }
        return Rbase.getFremark();
    }
}
