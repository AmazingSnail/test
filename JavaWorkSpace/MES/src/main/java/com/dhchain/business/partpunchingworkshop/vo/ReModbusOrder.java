package com.dhchain.business.partpunchingworkshop.vo;

public class ReModbusOrder {
    private  int ID;
    private  String IP;
    private String ReOrder;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getIP() {
        return IP;
    }

    public void setIP(String IP) {
        this.IP = IP;
    }

    public String getReOrder() {
        return ReOrder;
    }

    public void setReOrder(String reOrder) {
        ReOrder = reOrder;
    }
}
