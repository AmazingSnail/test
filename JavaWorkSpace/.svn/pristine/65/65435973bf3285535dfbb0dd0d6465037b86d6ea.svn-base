package com.dhchain.business.attrappl.service.impl;

import com.dhchain.business.attrappl.dao.AttrApplDetailMapper;
import com.dhchain.business.attrappl.service.AttrApplDetailService;
import com.dhchain.business.attrappl.vo.AttrApplDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-11.
 */
@Service("attrApplDetailService")
public class AttrApplDetailServiceImpl implements AttrApplDetailService {
    @Autowired
    private AttrApplDetailMapper attrApplDetailMapper;
    @Override
    public int add(List<AttrApplDetail> list) {
        int i = 0;
        for(AttrApplDetail attrApplDetail:list){
            int m = attrApplDetailMapper.insert(attrApplDetail);
            i+=m;
        }
        return i;
    }

    @Override
    public int insert(AttrApplDetail attrApplDetail) {
        return attrApplDetailMapper.insert(attrApplDetail);
    }

    @Override
    public int selectNewId() {
        return attrApplDetailMapper.selectNewId();
    }

    @Override
    public int edit(AttrApplDetail attrApplDetail) {
        return attrApplDetailMapper.update(attrApplDetail);
    }

    @Override
    public AttrApplDetail selectById(int id) {
        return attrApplDetailMapper.selectById(id);
    }

    @Override
    public List<AttrApplDetail> selectByApplyno(String applyno) {
        return attrApplDetailMapper.selectByApplyno(applyno);
    }
}
