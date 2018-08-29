package com.dhchain.business.TradeWMS.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

public class TPackagestore extends TPackagestoreKey implements Serializable {
    /**
     * 主键
     */
    @Id
    @Column(name = "Id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer serialno;

    private String fname;

    private String f3;

    private String f5;

    private Double beginstore;

    private Double inputstore;

    private Double outputstore;

    private Double sapstore;

    private String workcentre2;

    private String inputman;

    private Date inputdate;

    private String outputman;

    private Date outputdate;

    private String beginman;

    private Date begindate;

    private Integer uyear;

    private Integer umonth;

    private String temple;

    private String sapsdorder;

    private String nwx;

    private Boolean gcxh;

    private Double pcvalue;

    private Double pcallvalue;

    private String pono;

    private String poitem;

    private Double ponumber;

    private String sap;

    private Boolean wsap;

    private Boolean ishangup;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSerialno() {
        return serialno;
    }

    public void setSerialno(Integer serialno) {
        this.serialno = serialno;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname == null ? null : fname.trim();
    }

    public String getF3() {
        return f3;
    }

    public void setF3(String f3) {
        this.f3 = f3 == null ? null : f3.trim();
    }

    public String getF5() {
        return f5;
    }

    public void setF5(String f5) {
        this.f5 = f5 == null ? null : f5.trim();
    }

    public Double getBeginstore() {
        return beginstore;
    }

    public void setBeginstore(Double beginstore) {
        this.beginstore = beginstore;
    }

    public Double getInputstore() {
        return inputstore;
    }

    public void setInputstore(Double inputstore) {
        this.inputstore = inputstore;
    }

    public Double getOutputstore() {
        return outputstore;
    }

    public void setOutputstore(Double outputstore) {
        this.outputstore = outputstore;
    }

    public Double getSapstore() {
        return sapstore;
    }

    public void setSapstore(Double sapstore) {
        this.sapstore = sapstore;
    }

    public String getWorkcentre2() {
        return workcentre2;
    }

    public void setWorkcentre2(String workcentre2) {
        this.workcentre2 = workcentre2 == null ? null : workcentre2.trim();
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman == null ? null : inputman.trim();
    }

    public Date getInputdate() {
        return inputdate;
    }

    public void setInputdate(Date inputdate) {
        this.inputdate = inputdate;
    }

    public String getOutputman() {
        return outputman;
    }

    public void setOutputman(String outputman) {
        this.outputman = outputman == null ? null : outputman.trim();
    }

    public Date getOutputdate() {
        return outputdate;
    }

    public void setOutputdate(Date outputdate) {
        this.outputdate = outputdate;
    }

    public String getBeginman() {
        return beginman;
    }

    public void setBeginman(String beginman) {
        this.beginman = beginman == null ? null : beginman.trim();
    }

    public Date getBegindate() {
        return begindate;
    }

    public void setBegindate(Date begindate) {
        this.begindate = begindate;
    }

    public Integer getUyear() {
        return uyear;
    }

    public void setUyear(Integer uyear) {
        this.uyear = uyear;
    }

    public Integer getUmonth() {
        return umonth;
    }

    public void setUmonth(Integer umonth) {
        this.umonth = umonth;
    }

    public String getTemple() {
        return temple;
    }

    public void setTemple(String temple) {
        this.temple = temple == null ? null : temple.trim();
    }

    public String getSapsdorder() {
        return sapsdorder;
    }

    public void setSapsdorder(String sapsdorder) {
        this.sapsdorder = sapsdorder == null ? null : sapsdorder.trim();
    }

    public String getNwx() {
        return nwx;
    }

    public void setNwx(String nwx) {
        this.nwx = nwx == null ? null : nwx.trim();
    }

    public Boolean getGcxh() {
        return gcxh;
    }

    public void setGcxh(Boolean gcxh) {
        this.gcxh = gcxh;
    }

    public Double getPcvalue() {
        return pcvalue;
    }

    public void setPcvalue(Double pcvalue) {
        this.pcvalue = pcvalue;
    }

    public Double getPcallvalue() {
        return pcallvalue;
    }

    public void setPcallvalue(Double pcallvalue) {
        this.pcallvalue = pcallvalue;
    }

    public String getPono() {
        return pono;
    }

    public void setPono(String pono) {
        this.pono = pono == null ? null : pono.trim();
    }

    public String getPoitem() {
        return poitem;
    }

    public void setPoitem(String poitem) {
        this.poitem = poitem == null ? null : poitem.trim();
    }

    public Double getPonumber() {
        return ponumber;
    }

    public void setPonumber(Double ponumber) {
        this.ponumber = ponumber;
    }

    public String getSap() {
        return sap;
    }

    public void setSap(String sap) {
        this.sap = sap == null ? null : sap.trim();
    }

    public Boolean getWsap() {
        return wsap;
    }

    public void setWsap(Boolean wsap) {
        this.wsap = wsap;
    }

    public Boolean getIshangup() {
        return ishangup;
    }

    public void setIshangup(Boolean ishangup) {
        this.ishangup = ishangup;
    }
}