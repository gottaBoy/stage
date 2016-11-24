package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppInformation entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_information", catalog = "no1stage")
public class TAppInformation implements java.io.Serializable {

	// Fields

	private Integer id;
	private String content;
	private String menuCode;
	private String menuName;
	private Integer parentId;
	private String title;
	private Integer orderNo;
	private Integer userId;
	private String status;
	private String creatTime;

	private String daiyu;
	private String xueli;
	private String workYears;
	private String workAddress;
	private String zige;
	
	// Constructors

	/** default constructor */
	public TAppInformation() {
	}

	/** full constructor */
	public TAppInformation(String content, String menuCode, String menuName,
			Integer parentId, String title, Integer orderNo, Integer userId,
			String status, String creatTime) {
		this.content = content;
		this.menuCode = menuCode;
		this.menuName = menuName;
		this.parentId = parentId;
		this.title = title;
		this.orderNo = orderNo;
		this.userId = userId;
		this.status = status;
		this.creatTime = creatTime;
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

	@Column(name = "content", length = 65535)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "menuCode", length = 100)
	public String getMenuCode() {
		return this.menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	@Column(name = "menuName", length = 200)
	public String getMenuName() {
		return this.menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	@Column(name = "parentId")
	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Column(name = "title", length = 200)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "orderNo")
	public Integer getOrderNo() {
		return this.orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	@Column(name = "userId")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "status", length = 32)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "CreatTime", length = 50)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	@Column(name = "daiyu", length = 200)
	public String getDaiyu() {
		return daiyu;
	}

	public void setDaiyu(String daiyu) {
		this.daiyu = daiyu;
	}

	@Column(name = "xueli", length = 200)
	public String getXueli() {
		return xueli;
	}

	public void setXueli(String xueli) {
		this.xueli = xueli;
	}

	@Column(name = "workYears", length = 200)
	public String getWorkYears() {
		return workYears;
	}

	public void setWorkYears(String workYears) {
		this.workYears = workYears;
	}

	@Column(name = "workAddress", length = 200)
	public String getWorkAddress() {
		return workAddress;
	}

	public void setWorkAddress(String workAddress) {
		this.workAddress = workAddress;
	}

	@Column(name = "zige", length = 2000)
	public String getZige() {
		return zige;
	}

	public void setZige(String zige) {
		this.zige = zige;
	}

	
	
	
}