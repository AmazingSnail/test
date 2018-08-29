package com.dhchain.business.assembletrans.service.impl;

import com.dhchain.business.assembletrans.dao.SybMapper;
import com.dhchain.business.assembletrans.service.SybService;
import com.dhchain.business.assembletrans.vo.BMan;
import com.dhchain.business.assembletrans.vo.FlowLine;
import com.dhchain.business.assembletrans.vo.Syb;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by tongc on 2017-7-20.
 */
@Service("SybService")
public class SybSerViceImpl implements SybService {

    @Autowired
    private SybMapper sybMapper;
    @Override
    public List<Syb> queryAsList() {
        List<Syb> list = sybMapper.getSyb();
        return list;
    }

    @Override
    public List<BMan> queryBMan(BMan bMan) {
        List<BMan> list = sybMapper.getBMan(bMan);
        return list;
    }

    @Override
    public List<BMan> queryBManN(BMan bMan) {
        List<BMan> list = sybMapper.getBManN(bMan);
        return list;
    }
    @Override
    public List<BMan> queryBManK(BMan bMan) {
        List<BMan> list = sybMapper.getBManK(bMan);
        return list;
    }

    @Override
    public List<BMan> queryBManC(BMan bMan) {
        List<BMan> list = sybMapper.getBManC(bMan);
        return list;
    }

    @Override
    public List<FlowLine> queryFlowLine(FlowLine flowLine) {
        List<FlowLine> list = null;
        if(flowLine.getFLName()!=null&&!"".equals(flowLine.getFLName().trim())){
            list = sybMapper.getFlowLineN(flowLine);
        }else{
            list = sybMapper.getFlowLine(flowLine);
        }
        return list;
    }
}
