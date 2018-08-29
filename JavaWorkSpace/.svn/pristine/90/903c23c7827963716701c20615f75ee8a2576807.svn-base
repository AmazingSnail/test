package com.dhchain.business.HeatTreatment.service.impl;

import com.dhchain.business.HeatTreatment.dao.ProductionProcessMapper;
import com.dhchain.business.HeatTreatment.service.ProductionProcessService;
import com.dhchain.business.HeatTreatment.vo.MCraftmould;
import com.dhchain.business.HeatTreatment.vo.ProductionProcess;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ASUS on 2018/7/6.
 */
@Service("ProductionProcessService")
public class ProductionProcessServiceImpl extends  BaseService<MCraftmould> implements ProductionProcessService {
    @Autowired
    private ProductionProcessMapper productionProcessMapper;
    @Override
    public List<ProductionProcess> getData(ProductionProcess reocrd) {
        return productionProcessMapper.getData(reocrd);
    }

    @Override
    public List<MCraftmould> getTempletname(MCraftmould record) {
        return productionProcessMapper.getTempletname(record);
    }
    @Override
    public List<MCraftmould> getTempletnum(MCraftmould record) {
        return productionProcessMapper.getTempletnum(record);
    }

    @Override
    public List<MCraftmould> getMaxMBid(MCraftmould reocrd) {
        return productionProcessMapper.getMaxMBid(reocrd);
    }
}
