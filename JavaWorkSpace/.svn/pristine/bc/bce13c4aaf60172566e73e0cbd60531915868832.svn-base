package com.dhchain.business.TradeWMS.service.impl;

import com.dhchain.business.TradeWMS.dao.TPacktranslistMapper;
import com.dhchain.business.TradeWMS.service.TPacktranslistService;
import com.dhchain.business.TradeWMS.vo.TPacktranslist;
import com.dhchain.business.base.service.impl.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2018-04-12.
 */
@Service("tPacktranslistService")
public class TPacktranslistServiceImpl  extends BaseService<TPacktranslist> implements TPacktranslistService {
    @Autowired
    private TPacktranslistMapper tPacktranslistMapper;

    public TPacktranslistServiceImpl() {
    }

    @Override
    public  List<Map> packageOutLeftquery(TPacktranslist tPacktranslist) {
        return tPacktranslistMapper.packageOutLeftquery(tPacktranslist);
    }

    @Override
    public void ptoutgo(int id) {
        tPacktranslistMapper.ptoutgo(id);
    }
}
