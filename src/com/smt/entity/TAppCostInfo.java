package com.smt.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * TAppCostInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_cost_info", catalog = "no1stage")
public class TAppCostInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private Integer profession;
	private Integer eprice;
	private Integer bprice;
	private String creatTime;
	private Integer orderNo;
	private String keywords;
	private String unit;
	private String isConsult;
	private String detail;
	private String bigImage;

	// Constructors

	private TAppTalentCategory category;
	@ManyToOne(cascade={CascadeType.PERSIST,CascadeType.MERGE})
	@JoinColumn(name="profession", insertable = false, updatable = false)   
	public TAppTalentCategory getCategory() {
		return category;
	}

	public void setCategory(TAppTalentCategory category) {
		this.category = category;
	}

	/** default constructor */
	public TAppCostInfo() {
	}

	/** full constructor */
	public TAppCostInfo(Integer userId, Integer profession, Integer eprice,
			Integer bprice, String creatTime, Integer orderNo, String keywords,
			String unit, String isConsult) {
		this.userId = userId;
		this.profession = profession;
		this.eprice = eprice;
		this.bprice = bprice;
		this.creatTime = creatTime;
		this.orderNo = orderNo;
		this.keywords = keywords;
		this.unit = unit;
		this.isConsult = isConsult;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "UserId")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "Profession", length = 32)
	public Integer getProfession() {
		return this.profession;
	}

	public void setProfession(Integer profession) {
		this.profession = profession;
	}

	@Column(name = "ePrice", length = 32)
	public Integer getEprice() {
		return this.eprice;
	}

	public void setEprice(Integer eprice) {
		this.eprice = eprice;
	}

	@Column(name = "bPrice", length = 32)
	public Integer getBprice() {
		return this.bprice;
	}

	public void setBprice(Integer bprice) {
		this.bprice = bprice;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	@Column(name = "orderNo")
	public Integer getOrderNo() {
		return this.orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	@Column(name = "keywords", length = 100)
	public String getKeywords() {
		return this.keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	@Column(name = "unit", length = 100)
	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Column(name = "isConsult", length = 32)
	public String getIsConsult() {
		return this.isConsult;
	}

	public void setIsConsult(String isConsult) {
		this.isConsult = isConsult;
	}
	
	@Column(name = "detail", length = 2000)
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	@Column(name = "bigImage", length = 500)
	public String getBigImage() {
		return bigImage;
	}

	public void setBigImage(String bigImage) {
		this.bigImage = bigImage;
	}

}