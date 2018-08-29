package com.dhchain.business.colddigitalworkshop.vo;

import java.io.Serializable;

public class ColdLocation implements Serializable {
    private String location;

    private Integer id;

    private String fno;

    private String fname;

    private static final long serialVersionUID = 1L;

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFno() {
        return fno;
    }

    public void setFno(String fno) {
        this.fno = fno == null ? null : fno.trim();
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname == null ? null : fname.trim();
    }
}