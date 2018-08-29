package com.dhchain.business.TradeWMS.vo;

import java.io.Serializable;
import java.util.Date;

public class TPackgoodallot implements Serializable {
    private Integer id;

    private Integer packgoodid;

    private String oldlocation;

    private String newlocation;

    private String transman;

    private Date transdate;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPackgoodid() {
        return packgoodid;
    }

    public void setPackgoodid(Integer packgoodid) {
        this.packgoodid = packgoodid;
    }

    public String getOldlocation() {
        return oldlocation;
    }

    public void setOldlocation(String oldlocation) {
        this.oldlocation = oldlocation == null ? null : oldlocation.trim();
    }

    public String getNewlocation() {
        return newlocation;
    }

    public void setNewlocation(String newlocation) {
        this.newlocation = newlocation == null ? null : newlocation.trim();
    }

    public String getTransman() {
        return transman;
    }

    public void setTransman(String transman) {
        this.transman = transman == null ? null : transman.trim();
    }

    public Date getTransdate() {
        return transdate;
    }

    public void setTransdate(Date transdate) {
        this.transdate = transdate;
    }
}