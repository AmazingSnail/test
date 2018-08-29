package com.dhchain.business.exp.service.impl;

import com.dhchain.business.attr.dao.AttrDefineMapper;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.attr.vo.ViewAttr;
import com.dhchain.business.exp.dao.ExptypeMapper;
import com.dhchain.business.exp.dao.ViewMapper;
import com.dhchain.business.exp.service.ViewService;
import com.dhchain.business.exp.vo.ExptypeView;
import com.dhchain.business.exp.vo.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhenglb on 2017-11-03.
 */
@Service("viewService")
public class ViewServiceImpl implements ViewService {
    @Autowired
    private ViewMapper viewMapper;
    @Autowired
    private AttrDefineMapper attrDefineMapper;
    @Autowired
    private ExptypeMapper exptypeMapper;
    @Override
    public List<View> select(View view) {
        return viewMapper.select(view);
    }

    @Override
    public List<View> selectByExptypeid(int exptypeid) {
        List<View> list = new ArrayList<View>();
        List<ExptypeView> exptypeViews = exptypeMapper.idcontainView(exptypeid);
        for (ExptypeView exptypeView:exptypeViews){
            View view = viewMapper.selectById(exptypeView.getViewid()) ;
            list.add(view);
        }
        return list;
    }

    @Override
    public int add(View view) {
        int n = viewMapper.insert(view);
        return n;
    }

    @Override
    public int edit(View view) {
        int n = viewMapper.update(view);
        return n;
    }

    @Override
    public int delete(String[] ids) {
        int n = viewMapper.delete(ids);
        return n;
    }

    @Override
    public int savedefault(ViewAttr viewAttr) {
        return viewMapper.savedefault(viewAttr);
    }

    @Override
    public boolean distribute(int viewid, String[] ids) {
        viewMapper.deleteViewAttr(viewid);

            for (String id:ids){
                if(!id.equals("")){
                    ViewAttr viewAttr = new ViewAttr();
                    viewAttr.setViewid(viewid);
                    viewAttr.setAttrdefineid(Integer.parseInt(id));
                    viewMapper.distribute(viewAttr);
                }

            }



        return true;
    }

    @Override
    public boolean isdistribute(int viewid) {
        boolean flag = true;
        List<ExptypeView> exptypeViews = exptypeMapper.isdistribute(viewid);
        if(exptypeViews!=null&&exptypeViews.size()>0){
            flag = false;
        }
        return flag;
    }

    @Override
    public ViewAttr selectViewAttr(int viewid, int attrid) {
        return viewMapper.selectViewAttr(viewid, attrid);
    }

    @Override
    public View selectById(int id) {
        return viewMapper.selectById(id);
    }

    @Override
    public List<AttrDefine> selectAttrDefines(int viewid) {
        List<AttrDefine> attrDefines = new ArrayList<AttrDefine>() ;
        List<Integer> list = viewMapper.selectAttrDefines(viewid);
        AttrDefine attrDefine;
        for(Integer i:list){
            attrDefine = attrDefineMapper.selectById(i);
            attrDefines.add(attrDefine);
        }
        return attrDefines;
    }
}
