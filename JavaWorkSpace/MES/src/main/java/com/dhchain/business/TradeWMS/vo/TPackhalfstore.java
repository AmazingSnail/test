package com.dhchain.business.TradeWMS.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

public class TPackhalfstore implements Serializable {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer packhalfid;

    private String location;

    private Double sumnum;

    private Double onecnum;

    private String packman;

    private Date packdate;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPackhalfid() {
        return packhalfid;
    }

    public void setPackhalfid(Integer packhalfid) {
        this.packhalfid = packhalfid;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public Double getSumnum() {
        return sumnum;
    }

    public void setSumnum(Double sumnum) {
        this.sumnum = sumnum;
    }

    public Double getOnecnum() {
        return onecnum;
    }

    public void setOnecnum(Double onecnum) {
        this.onecnum = onecnum;
    }

    public String getPackman() {
        return packman;
    }

    public void setPackman(String packman) {
        this.packman = packman == null ? null : packman.trim();
    }

    public Date getPackdate() {
        return packdate;
    }

    public void setPackdate(Date packdate) {
        this.packdate = packdate;
    }
}