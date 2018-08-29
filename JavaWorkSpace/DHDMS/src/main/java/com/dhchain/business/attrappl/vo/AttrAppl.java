package com.dhchain.business.attrappl.vo;

import java.util.Date;

/**
 * Created by zhenglb on 2017-10-10.
 */
public class AttrAppl {
    private int id;
    private String applyno;
    private String applytype;
    private String applyreasons;
    private String applystate;
    private String inputman;
    private Date inputdate;
    private int attrid;
    private String processInstanceId;
    private int rank;

    public String getProcessInstanceId() {
        return processInstanceId;
    }

    public void setProcessInstanceId(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAttrid() {
        return attrid;
    }

    public void setAttrid(int attrid) {
        this.attrid = attrid;
    }

    public String getApplyno() {
        return applyno;
    }

    public void setApplyno(String applyno) {
        this.applyno = applyno;
    }

    public String getApplytype() {
        return applytype;
    }

    public void setApplytype(String applytype) {
        this.applytype = applytype;
    }

    public String getApplyreasons() {
        return applyreasons;
    }

    public void setApplyreasons(String applyreasons) {
        this.applyreasons = applyreasons;
    }

    public String getApplystate() {
        return applystate;
    }

    public void setApplystate(String applystate) {
        this.applystate = applystate;
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

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
