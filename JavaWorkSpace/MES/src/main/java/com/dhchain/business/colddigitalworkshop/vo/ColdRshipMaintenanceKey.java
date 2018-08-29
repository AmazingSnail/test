package com.dhchain.business.colddigitalworkshop.vo;

import java.io.Serializable;

public class ColdRshipMaintenanceKey implements Serializable {
    private Integer id;

    private String reelnum;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getReelnum() {
        return reelnum;
    }

    public void setReelnum(String reelnum) {
        this.reelnum = reelnum == null ? null : reelnum.trim();
    }
}