package com.dhchain.business.exp.dao;

import com.dhchain.business.attr.vo.ViewAttr;
import com.dhchain.business.exp.vo.View;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-03.
 */
@Repository
public interface ViewMapper {
    List<View> select(View view);
    int insert(View view);
    int update(View view);
    int delete(String[] ids);
    int deleteViewAttr(@Param("viewid")int viewid );
    int savedefault(ViewAttr viewAttr);
    int distribute(ViewAttr viewAttr);
    View selectById(@Param("id")int id);
    ViewAttr selectViewAttr(@Param("viewid")int viewid,@Param("attrdefineid") int attrdefineid);
    List<Integer> selectAttrDefines(@Param("viewid")int viewid);
    List<ViewAttr> isdistribute(@Param("attrdefineid") int attrdefineid);
}
