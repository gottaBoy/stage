package com.smt.entity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang.xwork.StringUtils;

/**
 * TAppTask entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_task", catalog = "no1stage")
public class TAppTask implements java.io.Serializable {

	// Fields

	private Integer id;
	private String mobile;
	private String price;
	private Integer userId;
	private String title;
	
	private String provice;
	private String city;
	
	private String place;
	private String creatTime;
	private String content;
	private String active;
	private String status;
	private String startDate;
	private String endDate;
	private Integer personCount;
	private Timestamp applyStartDate;
	private Timestamp applyEndDate;
	private String fromWeb;
	private String email;
	private String phone;
	private String qq;
	
	private Date createDate;
	private Date updateDate;
	
	
	private Set<TAppTaskRole> TAppTaskRoles = new HashSet<TAppTaskRole>(0);

	// Constructors

	/** default constructor */
	public TAppTask() {
	}

	/** full constructor */
	public TAppTask(String mobile, String price, Integer userId, String title,
			String place, String creatTime, String content, String active,
			String status, String startDate, String endDate,
			Integer personCount, Timestamp applyStartDate,
			Timestamp applyEndDate, Set<TAppTaskRole> TAppTaskRoles) {
		this.mobile = mobile;
		this.price = price;
		this.userId = userId;
		this.title = title;
		this.place = place;
		this.creatTime = creatTime;
		this.content = content;
		this.active = active;
		this.status = status;
		this.startDate = startDate;
		this.endDate = endDate;
		this.personCount = personCount;
		this.applyStartDate = applyStartDate;
		this.applyEndDate = applyEndDate;
		this.TAppTaskRoles = TAppTaskRoles;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "Mobile", length = 100)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "Price", length = 32)
	public String getPrice() {
		return this.price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@Column(name = "UserId")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "title", length = 100)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "Place", length = 100)
	public String getPlace() {
		return this.place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	@Column(name = "content", length = 1000)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "active", length = 32)
	public String getActive() {
		return this.active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	@Column(name = "status", length = 32)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "StartDate", length = 100)
	public String getStartDate() {
		return this.startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	@Column(name = "EndDate", length = 100)
	public String getEndDate() {
		return this.endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Column(name = "personCount")
	public Integer getPersonCount() {
		return this.personCount;
	}

	public void setPersonCount(Integer personCount) {
		this.personCount = personCount;
	}

	@Column(name = "ApplyStartDate", length = 19)
	public Timestamp getApplyStartDate() {
		return this.applyStartDate;
	}

	public void setApplyStartDate(Timestamp applyStartDate) {
		this.applyStartDate = applyStartDate;
	}

	@Column(name = "ApplyEndDate", length = 19)
	public Timestamp getApplyEndDate() {
		return this.applyEndDate;
	}

	public void setApplyEndDate(Timestamp applyEndDate) {
		this.applyEndDate = applyEndDate;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TAppTask")
	public Set<TAppTaskRole> getTAppTaskRoles() {
		return this.TAppTaskRoles;
	}

	public void setTAppTaskRoles(Set<TAppTaskRole> TAppTaskRoles) {
		this.TAppTaskRoles = TAppTaskRoles;
	}

	@Column(name = "provice", length = 50)
	public String getProvice() {
		return StringUtils.defaultIfEmpty(provice, "");
	}

	public void setProvice(String provice) {
		this.provice = provice;
	}
	
	@Column(name = "city", length = 50)
	public String getCity() {
		return StringUtils.defaultIfEmpty(city, "");
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "fromWeb", length = 50)
	public String getFromWeb() {
		return fromWeb;
	}

	public void setFromWeb(String fromWeb) {
		this.fromWeb = fromWeb;
	}

	@Column(name = "email", length = 50)	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "phone", length = 50)	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "qq", length = 50)
	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	@Column(name = "createDate", length = 19)
	public Date getCreateDate() {
		return createDate;
	}

	@Column(name = "updateDate", length = 19)
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	
	
	

	
	
}