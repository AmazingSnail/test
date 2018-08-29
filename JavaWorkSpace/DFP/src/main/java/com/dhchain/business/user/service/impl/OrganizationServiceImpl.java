package com.dhchain.business.user.service.impl;



import com.dhchain.business.user.dao.OrganizationMapper;
import com.dhchain.business.user.service.IOrganizationService;
import com.dhchain.business.user.vo.Organization;

import com.dhchain.config.result.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * Organization 表数据服务层接口实现类
 *
 */
@Service
public class OrganizationServiceImpl implements IOrganizationService {

    @Autowired
    private OrganizationMapper organizationMapper;
    
    @Override
    public List<Organization> selectTree() {
        List<Organization> organizationList = organizationMapper.query();


        return organizationList;
    }

    @Override
    public boolean insert(Organization organization) {
        try {
            int c=organizationMapper.insert(organization);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean  deleteById(Long id) {

        try {
            int c = organizationMapper.deleteById(id);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public Organization selectById(Long id) {
        return organizationMapper.selectById(id);
    }

    @Override
    public boolean updateById(Organization organization) {
        try {
            int c = organizationMapper.update(organization);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

//    @Override
//    public List<Organization> selectTreeGrid() {
//        EntityWrapper<Organization> wrapper = new EntityWrapper<Organization>();
//        wrapper.orderBy("seq");
//        return organizationMapper.selectList(wrapper);
//    }


}