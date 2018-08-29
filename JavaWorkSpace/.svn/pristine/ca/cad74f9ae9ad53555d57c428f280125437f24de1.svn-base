package com.dhchain.business.DeliveryOrder.service.Impl;

import com.dhchain.business.DeliveryOrder.mapper.ZSD022_ITEMMapper;
import com.dhchain.business.DeliveryOrder.service.ZSD022_ITEMService;
import com.dhchain.business.DeliveryOrder.vo.ZSD022_ITEM;
import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lar on 2018-07-16.
 */
@Service("ZSD022_ITEMService")
public class ZSD022_ITEMServiceImpl extends BaseService<ZSD022_ITEM> implements ZSD022_ITEMService {
    @Autowired
    private ZSD022_ITEMMapper zsd022_ItemMapper;

    @Override
    public List<ZSD022_ITEM> selectSame5(ZSD022_ITEM record) {
        List<ZSD022_ITEM> newZSD022_ITEM = zsd022_ItemMapper.selectSame5(record);
        return newZSD022_ITEM;
    }
}
