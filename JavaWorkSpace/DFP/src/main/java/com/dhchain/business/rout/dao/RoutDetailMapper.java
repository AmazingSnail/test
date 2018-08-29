package com.dhchain.business.rout.dao;

import com.dhchain.business.rout.vo.RoutDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-30.
 */
@Repository
public interface RoutDetailMapper {
    int insert(RoutDetail routDetail);
    int selectNewId();
    RoutDetail selectById(@Param("id")int id);
    int update(RoutDetail routDetail);
    List<RoutDetail> selectByApplyno(String applyno);
}
