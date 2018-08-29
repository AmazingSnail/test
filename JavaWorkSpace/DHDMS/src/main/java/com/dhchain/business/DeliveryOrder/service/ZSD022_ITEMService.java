package com.dhchain.business.DeliveryOrder.service;

import com.dhchain.business.DeliveryOrder.vo.ZSD022_ITEM;
import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import com.dhchain.business.base.service.BaseService;

import java.util.List;

/**
 * Created by zhenglb on 2018-07-16.
 */
public interface ZSD022_ITEMService extends IService<ZSD022_ITEM> {
    List<ZSD022_ITEM> selectSame5(ZSD022_ITEM record);
}
