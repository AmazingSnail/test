package com.dhchain.business.colddigitalworkshop.vo;

import java.io.Serializable;

public class Smaintenance implements Serializable {
    private Integer id;

    private String fno;

    private String name;

    private String matec;

    private String fnoname;

    private String fparentid;

    private String _parentId;

    private Float width;

    private String fnohiddon;

    public String getFnohiddon() {
        if (fparentid==null){
            return fno+"";
        }else{
            return fno+""+fparentid;
        }
    }

    public void setFnohiddon(String fnohiddon) {
        this.fnohiddon = fnohiddon;
    }

    public Float getWidth() {
        return width;
    }

    public void setWidth(Float width) {
        this.width = width;
    }

    public String get_parentId() {
        return fparentid;
    }

    public void set_parentId(String _parentId) {
        this._parentId = _parentId;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getMatec() {
        return matec;
    }

    public void setMatec(String matec) {
        this.matec = matec == null ? null : matec.trim();
    }

    public String getFnoname() {
        return fnoname;
    }

    public void setFnoname(String fnoname) {
        this.fnoname = fnoname == null ? null : fnoname.trim();
    }

    public String getFparentid() {
        return fparentid;
    }

    public void setFparentid(String fparentid) {
        this.fparentid = fparentid;
    }
}