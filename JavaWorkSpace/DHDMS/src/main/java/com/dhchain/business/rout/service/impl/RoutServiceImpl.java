package com.dhchain.business.rout.service.impl;

import com.dhchain.business.rout.dao.RoutMapper;
import com.dhchain.business.rout.service.RoutService;
import com.dhchain.business.rout.vo.Rout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhenglb on 2017-10-31.
 */
@Service("routService")
public class RoutServiceImpl implements RoutService {
    @Autowired
    private RoutMapper routMapper;
    @Override
    public int insert(Rout rout) {
        return routMapper.insert(rout);
    }
}
