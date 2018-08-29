package com.dhchain.business.attr.dao;

import com.dhchain.business.attr.vo.Attr;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-10.
 */
@Repository
public interface AttrMapper {
    List<Attr> select(Attr attr);
    int insert(Attr attr);
    int selectNewId();
    Attr selectById(@Param("id") int id);
    Attr selectByNo(@Param("attrno") String attrno);
    Attr selectByNoAndFid(@Param("attrno") String attrno,@Param("fid")int fid);
    Attr selectByNameAndFid(@Param("attrname") String attrno,@Param("fid")int fid);
    int  update(Attr attr);
    List<Attr> selectByFlag(@Param("flag") String flag);
    List<Attr> selectChildById(@Param("fid") int fid);
    int  deleteById(int id);
}
