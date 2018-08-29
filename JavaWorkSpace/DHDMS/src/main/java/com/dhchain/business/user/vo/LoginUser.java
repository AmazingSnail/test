package com.dhchain.business.user.vo;

import com.dhchain.util.JsonUtils;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhenglb on 2017/8/16.
 */

public class LoginUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long id;

    /** 登陆名 */
    private String loginName;

    /** 用户名 */
    private String name;

    /** 密码 */
    private String password;

    /** 密码加密盐 */
    private String salt;

    /** 性别 */
    private Integer sex;

    /** 年龄 */
    private Integer age;

    /** 手机号 */
    private String phone;

    /** 用户类别 */
    private Integer userType;

    /** 用户状态 */
    private Integer status;

    /** 所属机构 */
    private Integer organizationId;

    /** 确认人 */
    private boolean isqrr;

    /** 审核人 */
    private boolean isshr;

    /** 创建时间 */
    private Date createTime;

    private boolean actstate;

    public boolean isIsqrr() {
        return isqrr;
    }

    public void setIsqrr(boolean isqrr) {
        this.isqrr = isqrr;
    }

    public boolean isIsshr() {
        return isshr;
    }

    public void setIsshr(boolean isshr) {
        this.isshr = isshr;
    }

    public boolean isActstate() {
        return actstate;
    }

    public void setActstate(boolean actstate) {
        this.actstate = actstate;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }


    public Integer getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Integer organizationId) {
        this.organizationId = organizationId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    @Override
    public String toString() {
        return JsonUtils.toJson(this);
    }
}

