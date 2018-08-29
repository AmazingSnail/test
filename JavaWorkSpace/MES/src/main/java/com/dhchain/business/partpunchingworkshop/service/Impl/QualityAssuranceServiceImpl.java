package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.QualityAssuranceMapper;
import com.dhchain.business.partpunchingworkshop.service.QualityAssuranceService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("QualityAssuranceService")
public class QualityAssuranceServiceImpl implements QualityAssuranceService {
    @Autowired
    private QualityAssuranceMapper qualityAssuranceMapper;
    @Override
    public List<CHKResult> search(CHKResult record) {
        return qualityAssuranceMapper.search(record);
    }

    @Override
    public List<CHKDetail> getbycheckID(CHKDetail record) {
        return qualityAssuranceMapper.getbycheckID(record);
    }

    @Override
    public List<BaseEquip> getEquipID(BaseEquip record) {
        return qualityAssuranceMapper.getEquipID(record);
    }

    @Override
    public List<PTPlan> getAll(PTPlan record) {
        return qualityAssuranceMapper.getAll(record);
    }
    @Override
    public List<PTPlan> getMatial() {
        return qualityAssuranceMapper.getMatial();
    }

    @Override
    public List<PTFinish> getFinish() {
        return qualityAssuranceMapper.getFinish();
    }

    @Override
    public List<PTFinish> getAll1(PTFinish record) {
        return qualityAssuranceMapper.getAll1(record);
    }

    @Override
    public List<BaseUser> getUser() {
        return qualityAssuranceMapper.getUser();
    }

    @Override
    public List<EQPStatus> getStatus(EQPStatus record) {
        return qualityAssuranceMapper.getStatus(record);
    }

    @Override
    public List<EQPFault> getFault(EQPFault record) {
        return qualityAssuranceMapper.getFault(record);
    }
}
