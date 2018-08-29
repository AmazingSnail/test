package com.dhchain.business.exp.service.impl;

import com.dhchain.business.exp.dao.ExpDetailMapper;
import com.dhchain.business.exp.service.ExpDetailService;
import com.dhchain.business.exp.vo.ExpDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-24.
 */
@Service("expDetailService")
public class ExpDetailServiceImpl implements ExpDetailService {
    @Autowired
    private ExpDetailMapper expDetailMapper;
    @Override
    public int add(ExpDetail expDetail) {
        int n = expDetailMapper.insert(expDetail);
        return n;
    }

    @Override
    public int selectNewId() {
        return expDetailMapper.selectNewId();
    }

    @Override
    public ExpDetail selectById(int id) {
        return expDetailMapper.selectById(id);
    }

    @Override
    public int edit(ExpDetail expDetail) {
        int n = expDetailMapper.update(expDetail);
        return n;
    }

    @Override
    public List<ExpDetail> selectByApplyno(String applyno) {
        return expDetailMapper.selectByApplyno(applyno);
    }
}
