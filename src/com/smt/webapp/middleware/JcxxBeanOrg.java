package com.smt.webapp.middleware;

public class JcxxBeanOrg implements BeanBoss{
	private Integer id;
	private String nickName;
	private String name;
	private String birthday;
	private String mobile;
	private String provice;
	private String city;
	private String modifyTime;
	private String telPhone;
	private String introduction;
	private Integer mobileRadio;//1、不公开2、公开3、仅好友可见
	private Integer qqRadio;
	public Integer getMobileRadio() {
		return mobileRadio;
	}
	public void setMobileRadio(Integer mobileRadio) {
		this.mobileRadio = mobileRadio;
	}
	public Integer getQqRadio() {
		return qqRadio;
	}
	public void setQqRadio(Integer qqRadio) {
		this.qqRadio = qqRadio;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getProvice() {
		return provice;
	}
	public void setProvice(String provice) {
		this.provice = provice;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}
	
	public String getTelPhone() {
		return telPhone;
	}
	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	private String qq;
}
