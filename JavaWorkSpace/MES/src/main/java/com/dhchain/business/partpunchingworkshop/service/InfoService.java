package com.dhchain.business.partpunchingworkshop.service;


import com.dhchain.business.partpunchingworkshop.vo.BaseChkStd;
import com.dhchain.business.partpunchingworkshop.vo.BaseStatus;
import com.dhchain.business.partpunchingworkshop.vo.ReModbusOrder;
import com.dhchain.business.partpunchingworkshop.vo.WrModbusOrder;

import java.util.List;

public interface InfoService {
    List<BaseStatus> getStauts();//查询基础资料
    List<ReModbusOrder>getList();//查询发出指令
    List<WrModbusOrder>getList1();//查询写入指令
    List<BaseStatus>getList2();//查询基础信息
    int insert(ReModbusOrder record);//插入记录
    int delete(ReModbusOrder record);//删除记录
    int insert1(WrModbusOrder record);//插入记录
    int delete1(WrModbusOrder record);//删除记录
    int delete2(BaseStatus record);//删除记录
    int insert2(BaseStatus record);//插入记录
    int update(ReModbusOrder record);//更新记录
    int update1(WrModbusOrder record);//更新记录
    int update2(BaseStatus record);//更新记录
}
