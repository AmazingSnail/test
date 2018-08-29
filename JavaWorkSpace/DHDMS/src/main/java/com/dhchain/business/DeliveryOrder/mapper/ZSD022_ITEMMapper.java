package com.dhchain.business.DeliveryOrder.mapper;

import com.dhchain.business.DeliveryOrder.vo.ZSD022_ITEM;
import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import com.dhchain.util.MyMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2018-07-16.
 */
@Repository
public interface ZSD022_ITEMMapper extends MyMapper<ZSD022_ITEM> {
    List<ZSD022_ITEM>selectSame5(ZSD022_ITEM record);
}
