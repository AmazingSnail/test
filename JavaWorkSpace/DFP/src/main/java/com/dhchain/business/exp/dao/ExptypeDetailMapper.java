package com.dhchain.business.exp.dao;

import com.dhchain.business.exp.vo.ExptypeDetail;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-14.
 */
@Repository
public interface ExptypeDetailMapper {
    List<ExptypeDetail> selectByExptypeId(ExptypeDetail exptypeDetail);
    List<ExptypeDetail> selectST();
    int insert(ExptypeDetail exptypeDetail);
    int update(ExptypeDetail exptypeDetail);
    int delete(String[] ids);
    ExptypeDetail selectById(int id);
}
