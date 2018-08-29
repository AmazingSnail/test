package com.dhchain.system.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Table(name = "u_user")
public class User implements Serializable {
	@Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String loginName;

	private String name;

	private String password;

	private String salt;

	private Byte sex;

	private Byte age;

	private String phone;

	private Byte userType;

	private Byte status;

	private Integer organizationId;

	private Date createTime;

	private Boolean actState;

	private Boolean isShr;

	private Boolean isQrr;
    private  String year;
    private  String monat;
    private  String nwx;
    private  String L;
    private  String X;
    private  String Y;
    private  String Z;
    private  String P;
    private  String M;

	private  String B;
	private  String C;
	private  String G;
	private  String H;
	private  String I;
	private  String J;
	private  String K;
	private  String L1;

	public String getL() {
		return L;
	}

	public void setL(String l) {
		L = l;
	}

	public String getX() {
		return X;
	}

	public void setX(String x) {
		X = x;
	}

	public String getY() {
		return Y;
	}

	public void setY(String y) {
		Y = y;
	}

	public String getZ() {
		return Z;
	}

	public void setZ(String z) {
		Z = z;
	}

	public String getP() {
		return P;
	}

	public void setP(String p) {
		P = p;
	}

	public String getM() {
		return M;
	}

	public void setM(String m) {
		M = m;
	}



	public String getB() {
		return B;
	}

	public void setB(String b) {
		B = b;
	}

	public String getC() {
		return C;
	}

	public void setC(String c) {
		C = c;
	}

	public String getG() {
		return G;
	}

	public void setG(String g) {
		G = g;
	}

	public String getH() {
		return H;
	}

	public void setH(String h) {
		H = h;
	}

	public String getI() {
		return I;
	}

	public void setI(String i) {
		I = i;
	}

	public String getJ() {
		return J;
	}

	public void setJ(String j) {
		J = j;
	}

	public String getK() {
		return K;
	}

	public void setK(String k) {
		K = k;
	}

	public String getL1() {
		return L1;
	}

	public void setL1(String l1) {
		L1 = l1;
	}



	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonat() {
		return monat;
	}

	public void setMonat(String monat) {
		this.monat = monat;
	}

	public String getNwx() {
		return nwx;
	}

	public void setNwx(String nwx) {
		this.nwx = nwx;
	}

	private static final long serialVersionUID = 1L;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public Byte getSex() {
		return sex;
	}

	public void setSex(Byte sex) {
		this.sex = sex;
	}

	public Byte getAge() {
		return age;
	}

	public void setAge(Byte age) {
		this.age = age;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Byte getUserType() {
		return userType;
	}

	public void setUserType(Byte userType) {
		this.userType = userType;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public Integer getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Integer organizationId) {
		this.organizationId = organizationId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Boolean getActState() {
		return actState;
	}

	public void setActState(Boolean actState) {
		this.actState = actState;
	}

	public Boolean getShr() {
		return isShr;
	}

	public void setShr(Boolean shr) {
		isShr = shr;
	}

	public Boolean getQrr() {
		return isQrr;
	}

	public void setQrr(Boolean qrr) {
		isQrr = qrr;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
}
