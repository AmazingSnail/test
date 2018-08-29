package com.dhchain.business.exp.service.impl;

import com.dhchain.business.attr.dao.AttrDefineMapper;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.exp.dao.ExptypeMapper;
import com.dhchain.business.exp.dao.ViewMapper;
import com.dhchain.business.exp.service.ExptypeService;
import com.dhchain.business.exp.vo.Exptype;
import com.dhchain.business.exp.vo.ExptypeParm;
import com.dhchain.business.exp.vo.ExptypeView;
import com.dhchain.business.exp.vo.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Service("exptypeService")
public class ExptypeServiceImpl implements ExptypeService {
    @Autowired
    private ExptypeMapper exptypeMapper;
    @Autowired
    private ViewMapper viewMapper;
    @Autowired
    private AttrDefineMapper attrDefineMapper;
    @Override
    public List<Exptype> selectByTypeid(int typeid) {
        return exptypeMapper.selectByTypeid(typeid);
    }

    @Override
    public List<Exptype> select(Exptype exptype) {
        return exptypeMapper.select(exptype);
    }

    @Override
    public int add(Exptype exptype) {
        int n = exptypeMapper.insert(exptype);
        return n;
    }

    @Override
    public int edit(Exptype exptype) {
        int n = exptypeMapper.update(exptype);
        return n;
    }

    @Override
    public int savesequence(ExptypeView exptypeView) {
        int n = exptypeMapper.savesequence(exptypeView);
        return n;
    }

    @Override
    public Exptype selectById(String id) {
        Exptype exptype = exptypeMapper.selectById(Integer.parseInt(id));
        return exptype;
    }

    @Override
    public Exptype selectByTypedetailid(int typedetailid) {
        return exptypeMapper.selectByTypedetailid(typedetailid);
    }



    @Override
    public int deleteExpTypes(String[] ids) {
        int n = exptypeMapper.delete(ids);
        return n;
    }

    @Override
    public boolean iscontainView(int id) {
        boolean flag = false;
        List<ExptypeView> list = exptypeMapper.idcontainView(id);
        if(list.size()>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public List<View> selectViews(int exptypeid) {
        List<View> views = new ArrayList<View>() ;
        List<Integer> list = exptypeMapper.selectViews(exptypeid);
        View view;
        for(Integer i:list){
            view = viewMapper.selectById(i);
            views.add(view);
        }
        return views;
    }

    @Override
    public boolean distribute(int exptypeid, String ids) {
        exptypeMapper.deleteExptypeView(exptypeid);
        if(!ids.equals("")){
            String[] idArr = ids.split(",");
            for (String id:idArr){
                ExptypeView exptypeView = new ExptypeView();
                exptypeView.setExptypeid(exptypeid);
                exptypeView.setViewid(Integer.parseInt(id));
                exptypeMapper.distribute(exptypeView);
            }

        }

        return true;
    }

    @Override
    public Map isRepeatAttr(String[] ids) {
        Map map  = new HashMap();
        boolean flag = true;
        String message = "";
        List<Integer > attrids = new ArrayList<Integer>();
        List<AttrDefine> attrDefines = new ArrayList<AttrDefine>();
            for (String id:ids){
                List<Integer> newattrids = new ArrayList<Integer>();
                List<Integer> retain = new ArrayList<Integer>();
                retain = attrids;
                View view = viewMapper.selectById(Integer.parseInt(id));
                List<Integer> list = viewMapper.selectAttrDefines(view.getId());
                for (Integer attrid:list){
                    newattrids.add(attrid);
                }
                retain.retainAll(newattrids);
                if(retain.size()==0){
                    attrids.addAll(newattrids);
                }else {
                    message = "属性：";
                    for (Integer re:retain){
                        AttrDefine attrDefine = attrDefineMapper.selectById(re);
                        attrDefines.add(attrDefine);
                        message+=attrDefine.getAttrdefinename()+"、";
                    }
                    message = message.substring(0,message.length()-1);
                    message+="在不同试图内分配;不符合要求";
                    flag = false;
                    break;
                }


            }
            map.put("flag",flag);
            map.put("message",message);


        return map;
    }

    @Override
    public ExptypeView selectExptypeView(int exptypeid, int viewid) {
        return exptypeMapper.selectExptypeView(exptypeid,viewid);
    }

    @Override
    public int selectNewId() {
        return exptypeMapper.selectNewId();
    }

    @Override
    public List<AttrDefine> selectParms(int exptypeid) {
        return exptypeMapper.selectParms(exptypeid);
    }

    @Override
    public boolean distributeparms(int exptypeid, String[] ids) {
        exptypeMapper.deleteParms(exptypeid);

        for (String id:ids){
            if(!id.equals("")){
                ExptypeParm exptypeParm = new ExptypeParm();
                exptypeParm.setAttrdefineid(Integer.parseInt(id));
                exptypeParm.setExptypeid(exptypeid);
                exptypeMapper.distributeparm(exptypeParm);
            }

        }



        return true;
    }
}
