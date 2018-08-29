package com.dhchain.business.exp.dao;

import com.dhchain.business.exp.vo.ExpDetail;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-24.
 */
@Repository
public interface ExpDetailMapper {
    int insert(ExpDetail expDetail);
    int selectNewId();
    ExpDetail selectById(int id);
    int update(ExpDetail expDetail);
    List<ExpDetail> selectByApplyno(String applyno);
}
