package com.dhchain.business.user.service;




import com.dhchain.business.user.vo.Role;
import com.dhchain.config.result.PageInfo;


import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * Role 表数据服务层接口
 *
 */
public interface IRoleService {

    List<Role> selectDataGrid(PageInfo pageInfo);

    Object selectTree();

    List<Long> selectResourceIdListByRoleId(Long id);

    List<Long> findRoleIdListByUserId(Long id);

    void updateRoleResource(Long id, String resourceIds);

    Map<String, Set<String>> selectResourceMapByUserId(Long userId);

    boolean insert(Role role);

    boolean  deleteById(Long id);

    Role selectById(Long id);

    boolean updateById(Role organization);

}