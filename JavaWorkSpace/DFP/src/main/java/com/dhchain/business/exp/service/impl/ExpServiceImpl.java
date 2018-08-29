package com.dhchain.business.exp.service.impl;

import com.dhchain.business.exp.dao.ExpMapper;
import com.dhchain.business.exp.service.ExpService;
import com.dhchain.business.exp.vo.Exp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhenglb on 2017-10-25.
 */
@Service("expService")
public class ExpServiceImpl implements ExpService {
    @Autowired
    private ExpMapper expMapper;

    @Override
    public int insert(Exp exp) {
        return expMapper.insert(exp);
    }
}
