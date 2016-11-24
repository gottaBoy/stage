package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppGrowth entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_growth", catalog = "no1stage")
public class TAppGrowth implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private String endDate;
	private String startDate;
	private String title;
	private String content;
	private String creatTime;
	private String bulletinImg;
	private String price;
	private String unit;

	// Constructors

	/** default constructor */
	public TAppGrowth() {
	}

	/** minimal constructor */
	public TAppGrowth(Integer userId) {
		this.userId = userId;
	}

	/** full constructor */
	public TAppGrowth(Integer userId, String endDate, String startDate,
			String titile, String content, String creatTime) {
		this.userId = userId;
		this.endDate = endDate;
		this.startDate = startDate;
		this.content = content;
		this.creatTime = creatTime;
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

	@Column(name = "endDate", length = 100)
	public String getEndDate() {
		return this.endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Column(name = "startDate", length = 100)
	public String getStartDate() {
		return this.startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	@Column(name = "Title", length = 100)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "Content", length = 100)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}
	@Column(name = "bulletinImg", length = 200)
	public String getBulletinImg() {
		return bulletinImg;
	}

	public void setBulletinImg(String bulletinImg) {
		this.bulletinImg = bulletinImg;
	}
	@Column(name = "price")
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	@Column(name = "unit", length = 50)
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

}