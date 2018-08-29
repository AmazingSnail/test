package com.dhchain.business.code.vo;

import java.util.Date;

/**
 * Created by zhenglb on 2017-10-06.
 */
public class CodeManageType {
    private int id;
    private String ftypeno;
    private String ftypename;
    private String typeno;
    private String typename;
    private int codelength;
    private String codeway;
    private String codenameway;
    private String codebegin;
    private String codeend;
    private int isdelete;
    private int fcodeid;
    private int isunique;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFtypeno() {
        return ftypeno;
    }

    public void setFtypeno(String ftypeno) {
        this.ftypeno = ftypeno;
    }

    public String getFtypename() {
        return ftypename;
    }

    public void setFtypename(String ftypename) {
        this.ftypename = ftypename;
    }

    public String getTypeno() {
        return typeno;
    }

    public void setTypeno(String typeno) {
        this.typeno = typeno;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }



    public String getCodeway() {
        return codeway;
    }

    public void setCodeway(String codeway) {
        this.codeway = codeway;
    }

    public String getCodenameway() {
        return codenameway;
    }

    public void setCodenameway(String codenameway) {
        this.codenameway = codenameway;
    }

    public String getCodebegin() {
        return codebegin;
    }

    public void setCodebegin(String codebegin) {
        this.codebegin = codebegin;
    }

    public String getCodeend() {
        return codeend;
    }

    public void setCodeend(String codeend) {
        this.codeend = codeend;
    }

    public int getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(int isdelete) {
        this.isdelete = isdelete;
    }

    public int getFcodeid() {
        return fcodeid;
    }

    public void setFcodeid(int fcodeid) {
        this.fcodeid = fcodeid;
    }

    public int getCodelength() {
        return codelength;
    }

    public void setCodelength(int codelength) {
        this.codelength = codelength;
    }

    public int getIsunique() {
        return isunique;
    }

    public void setIsunique(int isunique) {
        this.isunique = isunique;
    }
}
