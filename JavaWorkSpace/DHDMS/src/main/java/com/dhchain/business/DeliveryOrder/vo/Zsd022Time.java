package com.dhchain.business.DeliveryOrder.vo;

import java.io.Serializable;

/**
 * Created by lar on 2018-07-13.
 */
public class Zsd022Time{
    private Integer ID;
    private String fhxtbh;
    private String FIELD30;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getFHXTBH() {
        return fhxtbh;
    }

    public void setFHXTBH(String fhxtbh) {this.fhxtbh = fhxtbh;}

    public String getFIELD30() {return FIELD30;}

    public void setFIELD30(String FIELD30) {
        this.FIELD30 = FIELD30 == null ? null : FIELD30.trim();
    }


}
