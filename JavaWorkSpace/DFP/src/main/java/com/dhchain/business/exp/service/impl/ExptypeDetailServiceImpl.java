package com.dhchain.business.exp.service.impl;

import com.dhchain.business.exp.dao.ExptypeDetailMapper;
import com.dhchain.business.exp.service.ExptypeDetailService;
import com.dhchain.business.exp.vo.ExptypeDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-14.
 */
@Service("exptypeDetailService")
public class ExptypeDetailServiceImpl implements ExptypeDetailService {
    @Autowired
    private ExptypeDetailMapper exptypeDetailMapper;

    @Override
    public List<ExptypeDetail> selectByExptypeId(ExptypeDetail exptypeDetail) {
        return exptypeDetailMapper.selectByExptypeId(exptypeDetail);
    }

    @Override
    public List<ExptypeDetail> selectST() {
        return exptypeDetailMapper.selectST();
    }

    @Override
    public boolean insert(ExptypeDetail exptypeDetail) {
        try {
            int c=exptypeDetailMapper.insert(exptypeDetail);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(ExptypeDetail exptypeDetail) {
        try {
            int c=exptypeDetailMapper.update(exptypeDetail);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int delete(String[] ids) {
        int n = exptypeDetailMapper.delete(ids);
        return n;
    }

    @Override
    public ExptypeDetail selectById(int id) {
        return exptypeDetailMapper.selectById(id);
    }
}
