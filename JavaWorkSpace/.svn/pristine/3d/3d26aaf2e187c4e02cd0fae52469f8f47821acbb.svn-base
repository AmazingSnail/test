package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.InfoMapper;
import com.dhchain.business.partpunchingworkshop.service.InfoService;
import com.dhchain.business.partpunchingworkshop.vo.BaseStatus;
import com.dhchain.business.partpunchingworkshop.vo.ReModbusOrder;
import com.dhchain.business.partpunchingworkshop.vo.WrModbusOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("InfoService")
public class InfoServiceImpl implements InfoService {
    @Autowired
    private InfoMapper infoMapper;
    @Override
    public List<BaseStatus> getStauts() {
        return infoMapper.getStatus();
    }

    @Override
    public List<ReModbusOrder> getList() {
        return infoMapper.getList();
    }

    @Override
    public List<WrModbusOrder> getList1() {
        return infoMapper.getList1();
    }

    @Override
    public List<BaseStatus> getList2() {
        return infoMapper.getList2();
    }

    @Override
    public int insert(ReModbusOrder record) {
        return infoMapper.insert(record);
    }

    @Override
    public int delete(ReModbusOrder record) {
        return infoMapper.delete(record);
    }

    @Override
    public int insert1(WrModbusOrder record) {
        return infoMapper.insert1(record);
    }

    @Override
    public int delete1(WrModbusOrder record) {
        return infoMapper.delete1(record);
    }

    @Override
    public int delete2(BaseStatus record) {
        return infoMapper.delete2(record);
    }

    @Override
    public int insert2(BaseStatus record) {
        return infoMapper.insert2(record);
    }

    @Override
    public int update(ReModbusOrder record) {
        return infoMapper.update(record);
    }

    @Override
    public int update1(WrModbusOrder record) {
        return infoMapper.update1(record);
    }

    @Override
    public int update2(BaseStatus record) {
        return infoMapper.update2(record);
    }
}
