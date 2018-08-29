package com.dhchain.business.TradeWMS.dao;

import com.dhchain.business.TradeWMS.vo.TPacktranslist;
import com.dhchain.business.base.dao.BaseDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface TPacktranslistMapper  extends BaseDao<TPacktranslist> {
    List<Map> packageOutLeftquery(TPacktranslist tPacktranslist);
    void  ptoutgo(int id);

}