package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.partpunchingworkshop.vo.ColdDailyPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTFinish;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ElementDetailMapper {
    int updatenum(PTFinish record);//更新数量
    List<PTFinish> selectbyall(PTFinish record);
    List<ColdDailyPlan> selectByReelnum(ColdDailyPlan record);//根据reelnum查询数据在ColdDailyPlan
    List<PTFinish> selectbycoldid(PTFinish record);//查询PTfinish表通过coldid
}
