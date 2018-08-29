package com.dhchain.business.DeliveryOrder.service.Impl;

import com.dhchain.business.DeliveryOrder.mapper.DeliveryOrderMapper;
import com.dhchain.business.DeliveryOrder.service.DeliveryOrderService;
import com.dhchain.business.DeliveryOrder.service.Zsd022TimeService;
import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import com.dhchain.business.DeliveryOrder.vo.Zsd022Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lar on 2018-07-11.
 */
@Service("DeliveryOrderService")
public class DeliveryOrderServiceImpl extends BaseService<Zsd022> implements DeliveryOrderService {
    @Autowired
    private DeliveryOrderMapper deliveryOrderMapper;

    @Override
    public List<Zsd022>selectSame3(Zsd022 record) {
        List<Zsd022> newZsd022 = deliveryOrderMapper.selectSame3(record);
        return newZsd022;
    }
}
