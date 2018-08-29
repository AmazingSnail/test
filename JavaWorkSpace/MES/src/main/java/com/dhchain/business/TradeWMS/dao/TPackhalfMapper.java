package com.dhchain.business.TradeWMS.dao;

import com.dhchain.business.TradeWMS.vo.TPackhalf;
import com.dhchain.business.base.dao.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public interface TPackhalfMapper  extends BaseDao<TPackhalf> {
    void  packagein(int id);
    void  ptback(int id);
}