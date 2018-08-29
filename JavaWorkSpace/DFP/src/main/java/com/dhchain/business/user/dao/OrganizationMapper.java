package com.dhchain.business.user.dao;



import com.dhchain.business.user.vo.Organization;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *
 * Organization 表数据库控制层接口
 *
 */
@Repository
public interface OrganizationMapper {
    List<Organization> query();
    int insert(Organization organization);
    int deleteById(Long id);
    Organization selectById(Long id);
    int  update(Organization organization);

}