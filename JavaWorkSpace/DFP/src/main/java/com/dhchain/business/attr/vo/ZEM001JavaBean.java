package com.dhchain.business.attr.vo;

/**
 * Created by wangq on 2018/1/4.
 */
public class ZEM001JavaBean {
    private String WGSBSYR;// 设备使用人


    public ZEM001JavaBean(String WGSBSYR)
    {
        this.WGSBSYR = WGSBSYR;//设备使用人

    }
    public String getWGSBSYR() {
        return WGSBSYR;
    }

    public void setWGSBSYR(String WGSBSYR) {
        this.WGSBSYR = WGSBSYR;
    }


//    private String f1;
//    private String PERSONCODE;
//    public ZEM001JavaBean(String f1,String PERSONCODE)
//    {
//        this.f1 = f1;//设备使用人
//        this.PERSONCODE=PERSONCODE;
//    }
//    public String getF1() {
//        return f1;
//    }
//    public void setF1(String f1) {
//        this.f1 = f1;
//    }
//
//    public String getPERSONCODE() {
//        return PERSONCODE;
//    }
//    public void setPERSONCODE(String PERSONCODE) {
//        this.PERSONCODE = PERSONCODE;
//    }



}
