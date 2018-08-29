package com.dhchain.business.assembletrans.service.impl;

import com.dhchain.business.assembletrans.dao.MplanMapper;
import com.dhchain.business.assembletrans.service.MplanService;
import com.dhchain.business.assembletrans.vo.Mplan;
import com.dhchain.business.assembletrans.vo.PlanDuty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by tongc on 2017-7-20.
 */
@Service("MplanService")
public class MplanServiceImpl implements MplanService {

    @Autowired
    private MplanMapper mplanMapper;

    @Override
    public List<Mplan> queryAsList(Mplan mplan) {
        List<Mplan> list= mplanMapper.getMplan(mplan);
        return list;
    }
     public List<PlanDuty> getman(PlanDuty record) {
        List<PlanDuty> list= mplanMapper.getman(record);
        return list;
    }

    @Override
    public List<Mplan> queryNum(Mplan mplan) {
        List<Mplan> list= mplanMapper.getNum(mplan);
        return list;
    }

    @Override
    public List<Mplan> queryYS(Mplan mplan) {
        List<Mplan> list= mplanMapper.queryYS(mplan);
        return list;
    }

    @Override
    public int update(Mplan mplan) {
        int n = mplanMapper.update(mplan);
        return n;
    }

    @Override
    public int updateth(Mplan mplan) {
        int n = mplanMapper.updateth(mplan);
        return n;
    }

    @Override
    public int updatecz(Mplan mplan) {
        int n = mplanMapper.updatecz(mplan);
        return n;
    }

    @Override
    public int updateczqx(Mplan mplan) {
        int n = mplanMapper.updateczqx(mplan);
        return n;
    }

    @Override
    public int updateruku(Mplan mplan) {
        int n = mplanMapper.updateruku(mplan);
        return n;
    }

    @Override
    public int updaterukuqx(Mplan mplan) {
        int n = mplanMapper.updaterukuqx(mplan);
        return n;
    }

    @Override
    public int updatetime(Mplan mplan) {
        int n = mplanMapper.updatetime(mplan);
        return n;
    }

    @Override
    public int updateCZRK(int id, double changenum) {
        int n = mplanMapper.updateCZRK(id ,changenum);
        return n;
    }

    @Override
    public Mplan selectByPrimaryKey(Integer id) {
        return mplanMapper.selectByPrimaryKey(id);
    }
}
