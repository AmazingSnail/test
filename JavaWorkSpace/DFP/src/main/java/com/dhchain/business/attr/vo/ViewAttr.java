package com.dhchain.business.attr.vo;

/**
 * Created by zhenglb on 2017-11-04.
 */
public class ViewAttr {
    private int id;
    private int attrdefineid;
    private int viewid;
    private String attrdefault;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAttrdefineid() {
        return attrdefineid;
    }

    public void setAttrdefineid(int attrdefineid) {
        this.attrdefineid = attrdefineid;
    }

    public int getViewid() {
        return viewid;
    }

    public void setViewid(int viewid) {
        this.viewid = viewid;
    }

    public String getAttrdefault() {
        return attrdefault;
    }

    public void setAttrdefault(String attrdefault) {
        this.attrdefault = attrdefault;
    }
}
