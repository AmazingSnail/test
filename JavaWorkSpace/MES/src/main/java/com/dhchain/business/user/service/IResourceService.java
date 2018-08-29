package com.dhchain.business.user.service;




import com.dhchain.business.user.vo.Resource;
import com.dhchain.config.result.Tree;
import com.dhchain.config.shiro.ShiroUser;

import java.util.List;

/**
 *
 * Resource 表数据服务层接口
 *
 */
public interface IResourceService {

    List<Resource> selectAll();

    List<Tree> selectAllMenu();

    List<Tree> selectAllTree();

    List<Tree> selectTree(ShiroUser shiroUser);

    boolean insert(Resource resource);

    boolean  deleteById(Long id);

    Resource selectById(Long id);

    boolean updateById(Resource resource);

}