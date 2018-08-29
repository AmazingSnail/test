package com.dhchain.business.DeliveryOrder.mapper;

import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import com.dhchain.business.DeliveryOrder.vo.Zsd022Time;
import com.dhchain.util.MyMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by LAR on 2018-07-13.
 */
@Repository
public interface Zsd022TimeMapper extends MyMapper<Zsd022Time> {
    List<Zsd022Time>selectSame4(Zsd022Time record);
}
