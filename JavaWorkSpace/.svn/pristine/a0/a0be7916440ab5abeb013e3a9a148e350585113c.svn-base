package com.dhchain.business.rout.service.impl;

import com.dhchain.business.rout.dao.RoutDetailMapper;
import com.dhchain.business.rout.service.RoutDetailService;
import com.dhchain.business.rout.vo.RoutDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-30.
 */
@Service("routDetailService")
public class RoutDetailServiceImpl implements RoutDetailService {
    @Autowired
    private RoutDetailMapper routDetailMapper;

    @Override
    public int add(RoutDetail routDetail) {
        int n = routDetailMapper.insert(routDetail);
        return n;
    }

    @Override
    public int selectNewId() {
        return routDetailMapper.selectNewId();
    }

    @Override
    public RoutDetail selectById(int id) {
        return routDetailMapper.selectById(id);
    }

    @Override
    public int edit(RoutDetail routDetail) {
        int n = routDetailMapper.update(routDetail);
        return n;
    }

    @Override
    public List<RoutDetail> selectByApplyno(String applyno) {
        return routDetailMapper.selectByApplyno(applyno);
    }
}
