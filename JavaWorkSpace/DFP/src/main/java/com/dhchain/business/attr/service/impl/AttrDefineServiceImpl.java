package com.dhchain.business.attr.service.impl;

import com.dhchain.business.attr.dao.AttrDefineMapper;
import com.dhchain.business.attr.service.AttrDefineService;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.attr.vo.ViewAttr;
import com.dhchain.business.exp.dao.ViewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-02.
 */
@Service("attrDefineService")
public class AttrDefineServiceImpl implements AttrDefineService {
    @Autowired
    private AttrDefineMapper attrDefineMapper;
    @Autowired
    private ViewMapper viewMapper;
    @Override
    public List<AttrDefine> select(AttrDefine attrDefine) {
        return attrDefineMapper.select(attrDefine);
    }

    @Override
    public AttrDefine selectById(String id) {
        AttrDefine attrDefine = attrDefineMapper.selectById(Integer.parseInt(id));
        return attrDefine;
    }

    @Override
    public AttrDefine selectByNo(String attrDefineno) {
        return attrDefineMapper.selectByNo(attrDefineno);
    }

    @Override
    public AttrDefine selectByBaseid(int baseid) {
        return attrDefineMapper.selectByBaseid(baseid);
    }

    @Override
    public int add(AttrDefine attrDefine) {
        return attrDefineMapper.insert(attrDefine);
    }

    @Override
    public int edit(AttrDefine attrDefine) {
        int n = attrDefineMapper.update(attrDefine);
        return n;
    }

    @Override
    public int delete(String[] ids) {
        int n = attrDefineMapper.delete(ids);
        return n;
    }

    @Override
    public boolean isexistAttrdefineno(String attrdefineno) {
        boolean flag = false;
        AttrDefine attrDefine = new AttrDefine();
        attrDefine.setAttrdefineno(attrdefineno);
        List<AttrDefine > attrDefineList = attrDefineMapper.select(attrDefine);
        if(attrDefineList==null||attrDefineList.size()==0){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean isdistribute(int attrid) {
        boolean flag = true;
        List<ViewAttr> viewAttrs = viewMapper.isdistribute(attrid);
        if(viewAttrs!=null&&viewAttrs.size()>0){
            flag = false;
        }
        return flag;
    }
}
