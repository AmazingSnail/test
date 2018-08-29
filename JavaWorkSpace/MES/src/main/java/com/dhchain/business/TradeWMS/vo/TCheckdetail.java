package com.dhchain.business.TradeWMS.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

public class TCheckdetail implements Serializable {
    /**
     * 主键
     */
    @Id
    @Column(name = "Id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String packhalfid;

    private Integer qmid;

    private String checkman;

    private Date checkdate;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPackhalfid() {
        return packhalfid;
    }

    public void setPackhalfid(String packhalfid) {
        this.packhalfid = packhalfid == null ? null : packhalfid.trim();
    }

    public Integer getQmid() {
        return qmid;
    }

    public void setQmid(Integer qmid) {
        this.qmid = qmid;
    }

    public String getCheckman() {
        return checkman;
    }

    public void setCheckman(String checkman) {
        this.checkman = checkman == null ? null : checkman.trim();
    }

    public Date getCheckdate() {
        return checkdate;
    }

    public void setCheckdate(Date checkdate) {
        this.checkdate = checkdate;
    }
}