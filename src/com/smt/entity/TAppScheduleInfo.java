package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppScheduleInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_schedule_info", catalog = "no1stage")
public class TAppScheduleInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private String startDate;
	private String endDate;
	private String address;
	private String title;
	private String content;
	private String creatTime;

	// Constructors

	/** default constructor */
	public TAppScheduleInfo() {
	}

	/** minimal constructor */
	public TAppScheduleInfo(Integer userId) {
		this.userId = userId;
	}

	/** full constructor */
	public TAppScheduleInfo( Integer userId, String startDate,
			String endDate, String address, String title, String content,
			String creatTime) {
		this.userId = userId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.address = address;
		this.title = title;
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

	@Column(name = "UserId", nullable = false)
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
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

	@Column(name = "Address", length = 100)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
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

}