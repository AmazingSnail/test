package com.dhchain.business.DeliveryOrder.service.Impl;

import com.dhchain.business.DeliveryOrder.mapper.DeliveryOrderMapper;
import com.dhchain.business.DeliveryOrder.mapper.Zsd022TimeMapper;
import com.dhchain.business.DeliveryOrder.service.Zsd022TimeService;
import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import com.dhchain.business.DeliveryOrder.vo.Zsd022Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * Created by LAR on 2018-07-13.
 */
@Service("Zsd022TimeService")
public class Zsd022TimeServiceImpl extends BaseService<Zsd022Time> implements Zsd022TimeService {
    @Autowired
    private Zsd022TimeMapper zsd022TimeMapper;

    @Override
    public List<Zsd022Time>selectSame4(Zsd022Time record) {
        List<Zsd022Time> newZsd022Time = zsd022TimeMapper.selectSame4(record);
        return newZsd022Time;
    }

}
