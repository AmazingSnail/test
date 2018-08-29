package com.dhchain.business.TradeWMS.service;

import com.dhchain.business.TradeWMS.vo.TPackhalf;
import com.dhchain.business.base.service.IService;

import java.util.List;

/**
 * Created by zhenglb on 2018-03-31.
 */
public interface PackageCheckService extends IService<TPackhalf> {
    /**
     * 根据条件分页查询
     *
     * @param TPackhalf
     * @param page
     * @param rows
     * @return
     */
    List<TPackhalf> selectByPackHalf(TPackhalf TPackhalf, int page, int rows);

    void packagein(int id);

    void ptback(int id);
}
