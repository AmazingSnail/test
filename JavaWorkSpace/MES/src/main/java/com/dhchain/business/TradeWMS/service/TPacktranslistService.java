package com.dhchain.business.TradeWMS.service;

import com.dhchain.business.TradeWMS.vo.TPacktranslist;
import com.dhchain.business.base.service.IService;


import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2018-04-12.
 */
public interface TPacktranslistService extends IService<TPacktranslist> {
    List<Map> packageOutLeftquery(TPacktranslist tPacktranslist);

    void ptoutgo(int id);
}
