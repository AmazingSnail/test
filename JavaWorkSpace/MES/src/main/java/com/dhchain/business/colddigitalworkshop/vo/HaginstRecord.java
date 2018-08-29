package com.dhchain.business.colddigitalworkshop.vo;

import java.io.Serializable;

public class HaginstRecord implements Serializable {
    private   Integer id;
    private  String  fno;
    private   String serialno;
    private  String    uyear;
    private  String  umonth;
    private   String   againstkind;
    private   String   againstnumber;
    private   String  againstman;
    private String againstdate;
    private   String  plant;
    private    String outadd;
    private    String  outputman;
    private   String  outputdate;
    private  String    takeman;
    private     String takedate;
    private    String  takepart;
    private  String takekind;
     private Boolean isMove;
    private   String  moveman;
    private   String movedate;
    private   String   Temple;
    private    String leadname;
    private    String fname;
    private   String f1;
    private   String  f5;
    private    String workcentre2;
    private    Boolean moveback;
    private     String movebackman;
    private   String  movebackdate;
    private  String  orderline;
    private  String  boxnum;
    private   Boolean  GCXH;
    private   String UserName;
    private   int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String userName) {
        UserName = userName;
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
        this.fno = fno;
    }

    public String getSerialno() {
        return serialno;
    }

    public void setSerialno(String serialno) {
        this.serialno = serialno;
    }

    public String getUyear() {
        return uyear;
    }

    public void setUyear(String uyear) {
        this.uyear = uyear;
    }

    public String getUmonth() {
        return umonth;
    }

    public void setUmonth(String umonth) {
        this.umonth = umonth;
    }

    public String getAgainstkind() {
        return againstkind;
    }

    public void setAgainstkind(String againstkind) {
        this.againstkind = againstkind;
    }

    public String getAgainstnumber() {
        return againstnumber;
    }

    public void setAgainstnumber(String againstnumber) {
        this.againstnumber = againstnumber;
    }

    public String getAgainstman() {
        return againstman;
    }

    public void setAgainstman(String againstman) {
        this.againstman = againstman;
    }

    public String getAgainstdate() {
        return againstdate;
    }

    public void setAgainstdate(String againstdate) {
        this.againstdate = againstdate;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }

    public String getOutadd() {
        return outadd;
    }

    public void setOutadd(String outadd) {
        this.outadd = outadd;
    }

    public String getOutputman() {
        return outputman;
    }

    public void setOutputman(String outputman) {
        this.outputman = outputman;
    }

    public String getOutputdate() {
        return outputdate;
    }

    public void setOutputdate(String outputdate) {
        this.outputdate = outputdate;
    }

    public String getTakeman() {
        return takeman;
    }

    public void setTakeman(String takeman) {
        this.takeman = takeman;
    }

    public String getTakedate() {
        return takedate;
    }

    public void setTakedate(String takedate) {
        this.takedate = takedate;
    }

    public String getTakepart() {
        return takepart;
    }

    public void setTakepart(String takepart) {
        this.takepart = takepart;
    }

    public String getTakekind() {
        return takekind;
    }

    public void setTakekind(String takekind) {
        this.takekind = takekind;
    }

    public Boolean getIsmove() {
        return isMove;
    }

    public void setIsmove(Boolean move) {
        isMove = move;
    }

    public String getMoveman() {
        return moveman;
    }

    public void setMoveman(String moveman) {
        this.moveman = moveman;
    }

    public String getMovedate() {
        return movedate;
    }

    public void setMovedate(String movedate) {
        this.movedate = movedate;
    }

    public String getTemple() {
        return Temple;
    }

    public void setTemple(String temple) {
        Temple = temple;
    }

    public String getLeadname() {
        return leadname;
    }

    public void setLeadname(String leadname) {
        this.leadname = leadname;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getF1() {
        return f1;
    }

    public void setF1(String f1) {
        this.f1 = f1;
    }

    public String getF5() {
        return f5;
    }

    public void setF5(String f5) {
        this.f5 = f5;
    }

    public String getWorkcentre2() {
        return workcentre2;
    }

    public void setWorkcentre2(String workcentre2) {
        this.workcentre2 = workcentre2;
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
        this.movebackman = movebackman;
    }

    public String getMovebackdate() {
        return movebackdate;
    }

    public void setMovebackdate(String movebackdate) {
        this.movebackdate = movebackdate;
    }

    public String getOrderline() {
        return orderline;
    }

    public void setOrderline(String orderline) {
        this.orderline = orderline;
    }

    public String getBoxnum() {
        return boxnum;
    }

    public void setBoxnum(String boxnum) {
        this.boxnum = boxnum;
    }

    public Boolean getGCXH() {
        return GCXH;
    }

    public void setGCXH(Boolean GCXH) {
        this.GCXH = GCXH;
    }
}
