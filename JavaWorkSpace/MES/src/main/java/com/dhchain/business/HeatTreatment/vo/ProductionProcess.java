package com.dhchain.business.HeatTreatment.vo;

/**
 * Created by ASUS on 2018/7/19.
 */
public class ProductionProcess {
    private  int  id;
    private  String          partdrawing;
    private  String      partname;
    private  String               templetnum;
    private  String        templetname;
    private  String    quenchtemp1;
    private  String            quenchtemp1up;
    private  String      quenchtemp1low;
    private  String              quenchtemp2;
    private  String      quenchtemp2up;
    private  String           quenchtemp2low;
    private  String     quenchtemp3;
    private  String            quenchtemp3up;
    private  String     quenchtemp3low;
    private  String            quenchtemp4;
    private  String      quenchtemp4up;
    private  String            quenchtemp4low;
    private  String    quenchtemp5;
    private  String           quenchtemp5up;
    private  String     quenchtemp5low;
    private  String          quenchhard;
    private  String    quenchhardup;
    private  String            quenchhardlow;
    private  String    quenchtime;//
    private  String           carpotential;
    private  String     carpotentialup;
    private  String             carpotentiallow;
    private  String     cooltemp;
    private  String           cooltempup;
    private  String    cooltemplow;
    private  String            carbinolf;
    private  String    tempertemp;
    private  String           tempertempup;
    private  String     tempertemplow;;
    private  String           tempertime;
    private  String    temperhard;
    private  String            temperhardup;
    private  String    temperhardlow;
    private String plant ;
    private String material;
    private  String coating;

    public String getCoating() {
        return coating;
    }

    public void setCoating(String coating) {
        this.coating = coating;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPartdrawing() {
        return partdrawing;
    }

    public void setPartdrawing(String partdrawing) {
        this.partdrawing = partdrawing;
    }

    public String getPartname() {
        return partname;
    }

    public void setPartname(String partname) {
        this.partname = partname;
    }

    public String getTempletnum() {
        return templetnum;
    }

    public void setTempletnum(String templetnum) {
        this.templetnum = templetnum;
    }

    public String getTempletname() {
        return templetname;
    }

    public void setTempletname(String templetname) {
        this.templetname = templetname;
    }

    public String getQuenchtemp1() {
        return quenchtemp1;
    }

    public void setQuenchtemp1(String quenchtemp1) {
        this.quenchtemp1 = quenchtemp1;
    }

    public String getQuenchtemp1up() {
        return quenchtemp1up;
    }

    public void setQuenchtemp1up(String quenchtemp1up) {
        this.quenchtemp1up = quenchtemp1up;
    }

    public String getQuenchtemp1low() {
        return quenchtemp1low;
    }

    public void setQuenchtemp1low(String quenchtemp1low) {
        this.quenchtemp1low = quenchtemp1low;
    }

    public String getQuenchtemp2() {
        return quenchtemp2;
    }

    public void setQuenchtemp2(String quenchtemp2) {
        this.quenchtemp2 = quenchtemp2;
    }

    public String getQuenchtemp2up() {
        return quenchtemp2up;
    }

    public void setQuenchtemp2up(String quenchtemp2up) {
        this.quenchtemp2up = quenchtemp2up;
    }

    public String getQuenchtemp2low() {
        return quenchtemp2low;
    }

    public void setQuenchtemp2low(String quenchtemp2low) {
        this.quenchtemp2low = quenchtemp2low;
    }

    public String getQuenchtemp3() {
        return quenchtemp3;
    }

    public void setQuenchtemp3(String quenchtemp3) {
        this.quenchtemp3 = quenchtemp3;
    }

    public String getQuenchtemp3up() {
        return quenchtemp3up;
    }

    public void setQuenchtemp3up(String quenchtemp3up) {
        this.quenchtemp3up = quenchtemp3up;
    }

    public String getQuenchtemp3low() {
        return quenchtemp3low;
    }

    public void setQuenchtemp3low(String quenchtemp3low) {
        this.quenchtemp3low = quenchtemp3low;
    }

    public String getQuenchtemp4() {
        return quenchtemp4;
    }

    public void setQuenchtemp4(String quenchtemp4) {
        this.quenchtemp4 = quenchtemp4;
    }

    public String getQuenchtemp4up() {
        return quenchtemp4up;
    }

    public void setQuenchtemp4up(String quenchtemp4up) {
        this.quenchtemp4up = quenchtemp4up;
    }

    public String getQuenchtemp4low() {
        return quenchtemp4low;
    }

    public void setQuenchtemp4low(String quenchtemp4low) {
        this.quenchtemp4low = quenchtemp4low;
    }

    public String getQuenchtemp5() {
        return quenchtemp5;
    }

    public void setQuenchtemp5(String quenchtemp5) {
        this.quenchtemp5 = quenchtemp5;
    }

    public String getQuenchtemp5up() {
        return quenchtemp5up;
    }

    public void setQuenchtemp5up(String quenchtemp5up) {
        this.quenchtemp5up = quenchtemp5up;
    }

    public String getQuenchtemp5low() {
        return quenchtemp5low;
    }

    public void setQuenchtemp5low(String quenchtemp5low) {
        this.quenchtemp5low = quenchtemp5low;
    }

    public String getQuenchhard() {
        return quenchhard;
    }

    public void setQuenchhard(String quenchhard) {
        this.quenchhard = quenchhard;
    }

    public String getQuenchhardup() {
        return quenchhardup;
    }

    public void setQuenchhardup(String quenchhardup) {
        this.quenchhardup = quenchhardup;
    }

    public String getQuenchhardlow() {
        return quenchhardlow;
    }

    public void setQuenchhardlow(String quenchhardlow) {
        this.quenchhardlow = quenchhardlow;
    }

    public String getQuenchtime() {
        return quenchtime;
    }

    public void setQuenchtime(String quenchtime) {
        this.quenchtime = quenchtime;
    }

    public String getCarpotential() {
        return carpotential;
    }

    public void setCarpotential(String carpotential) {
        this.carpotential = carpotential;
    }

    public String getCarpotentialup() {
        return carpotentialup;
    }

    public void setCarpotentialup(String carpotentialup) {
        this.carpotentialup = carpotentialup;
    }

    public String getCarpotentiallow() {
        return carpotentiallow;
    }

    public void setCarpotentiallow(String carpotentiallow) {
        this.carpotentiallow = carpotentiallow;
    }

    public String getCooltemp() {
        return cooltemp;
    }

    public void setCooltemp(String cooltemp) {
        this.cooltemp = cooltemp;
    }

    public String getCooltempup() {
        return cooltempup;
    }

    public void setCooltempup(String cooltempup) {
        this.cooltempup = cooltempup;
    }

    public String getCooltemplow() {
        return cooltemplow;
    }

    public void setCooltemplow(String cooltemplow) {
        this.cooltemplow = cooltemplow;
    }

    public String getCarbinolf() {
        return carbinolf;
    }

    public void setCarbinolf(String carbinolf) {
        this.carbinolf = carbinolf;
    }

    public String getTempertemp() {
        return tempertemp;
    }

    public void setTempertemp(String tempertemp) {
        this.tempertemp = tempertemp;
    }

    public String getTempertempup() {
        return tempertempup;
    }

    public void setTempertempup(String tempertempup) {
        this.tempertempup = tempertempup;
    }

    public String getTempertemplow() {
        return tempertemplow;
    }

    public void setTempertemplow(String tempertemplow) {
        this.tempertemplow = tempertemplow;
    }

    public String getTempertime() {
        return tempertime;
    }

    public void setTempertime(String tempertime) {
        this.tempertime = tempertime;
    }

    public String getTemperhard() {
        return temperhard;
    }

    public void setTemperhard(String temperhard) {
        this.temperhard = temperhard;
    }

    public String getTemperhardup() {
        return temperhardup;
    }

    public void setTemperhardup(String temperhardup) {
        this.temperhardup = temperhardup;
    }

    public String getTemperhardlow() {
        return temperhardlow;
    }

    public void setTemperhardlow(String temperhardlow) {
        this.temperhardlow = temperhardlow;
    }
}
