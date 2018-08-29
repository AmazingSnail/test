package com.dhchain.business.TradeWMS.service.impl;

import com.dhchain.business.TradeWMS.dao.TPackhalfMapper;
import com.dhchain.business.TradeWMS.service.PackageCheckService;
import com.dhchain.business.TradeWMS.vo.TPackhalf;
import com.dhchain.business.base.service.impl.BaseService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import java.util.List;

/**
 * Created by zhenglb on 2018-03-31.
 */
@Service("packageCheckService")
public class PackageCheckServiceImpl extends BaseService<TPackhalf> implements PackageCheckService {
    @Autowired
    private TPackhalfMapper tPackhalfMapper;
    @Override
    public List<TPackhalf> selectByPackHalf(TPackhalf TPackhalf, int page, int rows) {
        Example example = new Example(TPackhalf.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(TPackhalf.getDhorderno())) {
            criteria.andLike("dhorderno", "%" + TPackhalf.getDhorderno() + "%");
        }
        if (StringUtil.isNotEmpty(TPackhalf.getBoxnum())) {
            criteria.andLike("boxnum", "%" + TPackhalf.getBoxnum() + "%");
        }
        if (TPackhalf.getPackagelistid()!=null) {
            criteria.andEqualTo("packagelistid", TPackhalf.getPackagelistid());
        }
        if (StringUtil.isNotEmpty(TPackhalf.getLocation())) {
            criteria.andLike("location", "%" + TPackhalf.getLocation() + "%");
        }

        //分页查询
        PageHelper.startPage(page, rows);
        return selectByExample(example);
    }

    @Override
    public void packagein(int id) {
        tPackhalfMapper.packagein(id);
    }

    @Override
    public void ptback(int id) {
        tPackhalfMapper.ptback(id);
    }
}
