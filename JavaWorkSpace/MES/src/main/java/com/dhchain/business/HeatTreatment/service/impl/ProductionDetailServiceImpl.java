package com.dhchain.business.HeatTreatment.service.impl;

import com.dhchain.business.HeatTreatment.dao.ProductionDetailMapper;
import com.dhchain.business.HeatTreatment.service.ProductionDetailService;
import com.dhchain.business.HeatTreatment.vo.MCraftfault;
import com.dhchain.business.HeatTreatment.vo.MPtheatfinish;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ASUS on 2018/7/5.
 */
@Service("ProductionDetailService")
public class ProductionDetailServiceImpl extends BaseService<MPtheatfinish> implements ProductionDetailService {
    @Autowired
    private ProductionDetailMapper productionDetailMapper;
    @Override
    public List<MPtheatfinish> getEquid(MPtheatfinish record) {
        return productionDetailMapper.getEquid(record);
    }

    @Override
    public List<MCraftfault> getType(MCraftfault record) {
        return productionDetailMapper.getType(record);
    }
}
