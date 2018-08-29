package com.dhchain.business.colddigitalworkshop.vo;

import java.io.Serializable;

public class ColdOut implements Serializable {
    private Integer id;

    private String serialno;

    private String fno;

    private String fname;

    private Double outnumber;

    private String plant;

    private String outadd;

    private String outaddname;

    private String outputman;

    private String outputdate;

    private Boolean ismove;

    private String moveman;

    private String movedate;

    private Integer year;

    private Integer month;

    private Boolean moveok;

    private Boolean moveback;

    private String movebackman;

    private String movebackdate;

    private Boolean istake;

    private String takeman;

    private String takedate;

    private String location;

    private Boolean isapp;

    private Boolean isdelete;

    private String begindate;

    private String enddate;

    private String vbeln;

    private String posnr;
    private String cgvbeln;
    private String cgposnr;

    private static final long serialVersionUID = 1L;

    public String getCgvbeln() {
        return cgvbeln;
    }

    public void setCgvbeln(String cgvbeln) {
        this.cgvbeln = cgvbeln;
    }

    public String getCgposnr() {
        return cgposnr;
    }

    public void setCgposnr(String cgposnr) {
        this.cgposnr = cgposnr;
    }

    public String getVbeln() {
        return vbeln;
    }

    public void setVbeln(String vbeln) {
        this.vbeln = vbeln;
    }

    public String getPosnr() {
        return posnr;
    }

    public void setPosnr(String posnr) {
        this.posnr = posnr;
    }

    public String getBegindate() {
        return begindate;
    }

    public void setBegindate(String begindate) {
        this.begindate = begindate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSerialno() {
        return serialno;
    }

    public void setSerialno(String serialno) {
        this.serialno = serialno == null ? null : serialno.trim();
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

    public Double getOutnumber() {
        return outnumber;
    }

    public void setOutnumber(Double outnumber) {
        this.outnumber = outnumber;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant == null ? null : plant.trim();
    }

    public String getOutadd() {
        return outadd;
    }

    public void setOutadd(String outadd) {
        this.outadd = outadd == null ? null : outadd.trim();
    }

    public String getOutputman() {
        return outputman;
    }

    public void setOutputman(String outputman) {
        this.outputman = outputman == null ? null : outputman.trim();
    }

    public String getOutputdate() {
        return outputdate;
    }

    public void setOutputdate(String outputdate) {
        this.outputdate = outputdate;
    }

    public Boolean getIsmove() {
        return ismove;
    }

    public void setIsmove(Boolean ismove) {
        this.ismove = ismove;
    }

    public String getMoveman() {
        return moveman;
    }

    public void setMoveman(String moveman) {
        this.moveman = moveman == null ? null : moveman.trim();
    }

    public String getMovedate() {
        return movedate;
    }

    public void setMovedate(String movedate) {
        this.movedate = movedate;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public Boolean getMoveok() {
        return moveok;
    }

    public void setMoveok(Boolean moveok) {
        this.moveok = moveok;
    }

    public Boolean getMoveback() {
        return moveback;
    }

    public void setMoveback(Boolean moveback) {
        this.moveback = moveback;
    }

    public String getMovebackman() {
        return movebackman;
    }

    public void setMovebackman(String movebackman) {
        this.movebackman = movebackman == null ? null : movebackman.trim();
    }

    public String getMovebackdate() {
        return movebackdate;
    }

    public void setMovebackdate(String movebackdate) {
        this.movebackdate = movebackdate;
    }

    public Boolean getIstake() {
        return istake;
    }

    public void setIstake(Boolean istake) {
        this.istake = istake;
    }

    public String getTakeman() {
        return takeman;
    }

    public void setTakeman(String takeman) {
        this.takeman = takeman == null ? null : takeman.trim();
    }

    public String getTakedate() {
        return takedate;
    }

    public void setTakedate(String takedate) {
        this.takedate = takedate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public Boolean getIsapp() {
        return isapp;
    }

    public void setIsapp(Boolean isapp) {
        this.isapp = isapp;
    }

    public Boolean getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(Boolean isdelete) {
        this.isdelete = isdelete;
    }

    public String getOutaddname() {
        return outaddname;
    }

    public void setOutaddname(String outaddname) {
        this.outaddname = outaddname;
    }
}