package com.dhchain.business.attr.vo;

import java.util.Date;

/**
 * Created by zhenglb on 2017-11-02.
 */
public class AttrDefine {
    private int id;
    private String attrdefineno;
    private String attrdefinename;
    private int databaseid;
    private int attrid;
    private int factoryid;
    //数据源类型 1.基础数据源 2.物料数据源 3.工厂数据源
    private int databasetype;
    //数据类型 1.字符串 2.整形 3.浮点型 4.日期 5.日期时间
    private int datatype;
    private int datelength;
    private int precision;
    //控件类型 1.文本输入框 2.数字输入框  5.下拉选择框  6.复选框 7.勾选框 8.树
    private int widgettype;
    private int iscode;
    private int codelength;
    private int islocked;
    private String remark;
    private String inputman;
    private Date inputdate;
    private String modifyman;
    private Date modifydate;
    private int typeid;
    private int isdelete;
    private int isrequired;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAttrdefineno() {
        return attrdefineno;
    }

    public void setAttrdefineno(String attrdefineno) {
        this.attrdefineno = attrdefineno;
    }

    public String getAttrdefinename() {
        return attrdefinename;
    }

    public void setAttrdefinename(String attrdefinename) {
        this.attrdefinename = attrdefinename;
    }

    public int getDatabaseid() {
        return databaseid;
    }

    public void setDatabaseid(int databaseid) {
        this.databaseid = databaseid;
    }

    public int getAttrid() {
        return attrid;
    }

    public void setAttrid(int attrid) {
        this.attrid = attrid;
    }

    public int getDatatype() {
        return datatype;
    }

    public void setDatatype(int datatype) {
        this.datatype = datatype;
    }

    public int getDatelength() {
        return datelength;
    }

    public void setDatelength(int datelength) {
        this.datelength = datelength;
    }

    public int getPrecision() {
        return precision;
    }

    public void setPrecision(int precision) {
        this.precision = precision;
    }

    public int getWidgettype() {
        return widgettype;
    }

    public void setWidgettype(int widgettype) {
        this.widgettype = widgettype;
    }

    public int getIscode() {
        return iscode;
    }

    public void setIscode(int iscode) {
        this.iscode = iscode;
    }

    public int getCodelength() {
        return codelength;
    }

    public void setCodelength(int codelength) {
        this.codelength = codelength;
    }

    public int getIslocked() {
        return islocked;
    }

    public void setIslocked(int islocked) {
        this.islocked = islocked;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman;
    }

    public Date getInputdate() {
        return inputdate;
    }

    public void setInputdate(Date inputdate) {
        this.inputdate = inputdate;
    }

    public String getModifyman() {
        return modifyman;
    }

    public void setModifyman(String modifyman) {
        this.modifyman = modifyman;
    }

    public Date getModifydate() {
        return modifydate;
    }

    public void setModifydate(Date modifydate) {
        this.modifydate = modifydate;
    }

    public int getTypeid() {
        return typeid;
    }

    public void setTypeid(int typeid) {
        this.typeid = typeid;
    }

    public int getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(int isdelete) {
        this.isdelete = isdelete;
    }

    public int getIsrequired() {
        return isrequired;
    }

    public void setIsrequired(int isrequired) {
        this.isrequired = isrequired;
    }

    public int getFactoryid() {
        return factoryid;
    }

    public void setFactoryid(int factoryid) {
        this.factoryid = factoryid;
    }

    public int getDatabasetype() {
        return databasetype;
    }

    public void setDatabasetype(int databasetype) {
        this.databasetype = databasetype;
    }
}
