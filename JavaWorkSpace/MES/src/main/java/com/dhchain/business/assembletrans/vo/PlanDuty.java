package com.dhchain.business.assembletrans.vo;

import com.dhchain.config.vo.BaseQuery;

/**
 * Created by xieyj on 2017-8-16.
 */
public class PlanDuty extends BaseQuery {
    String plant;
    String workdepart;
    String workgroup;
    String groupstate;
    String worklead;
    String worker;
    String IC;
    int id;

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }

    public String getWorkdepart() {
        return workdepart;
    }

    public void setWorkdepart(String workdepart) {
        this.workdepart = workdepart;
    }

    public String getWorkgroup() {
        return workgroup;
    }

    public void setWorkgroup(String workgroup) {
        this.workgroup = workgroup;
    }

    public String getGroupstate() {
        return groupstate;
    }

    public void setGroupstate(String groupstate) {
        this.groupstate = groupstate;
    }

    public String getWorklead() {
        return worklead;
    }

    public void setWorklead(String worklead) {
        this.worklead = worklead;
    }

    public String getWorker() {
        return worker;
    }

    public void setWorker(String worker) {
        this.worker = worker;
    }

    public String getIC() {
        return IC;
    }

    public void setIC(String IC) {
        this.IC = IC;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
