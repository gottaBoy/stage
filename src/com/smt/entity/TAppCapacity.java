package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppCapacity entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_capacity", catalog = "no1stage")
public class TAppCapacity implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private Integer pjUserId;
	private String pjType;
	private String point;
	private String creatTime;

	// Constructors

	/** default constructor */
	public TAppCapacity() {
	}

	/** minimal constructor */
	public TAppCapacity(Integer userId, Integer pjUserId) {
		this.userId = userId;
		this.pjUserId = pjUserId;
	}

	/** full constructor */
	public TAppCapacity(Integer userId, Integer pjUserId, String pjType,
			String point, String creatTime) {
		this.userId = userId;
		this.pjUserId = pjUserId;
		this.pjType = pjType;
		this.point = point;
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

	@Column(name = "Pj_userId", nullable = false)
	public Integer getPjUserId() {
		return this.pjUserId;
	}

	public void setPjUserId(Integer pjUserId) {
		this.pjUserId = pjUserId;
	}

	@Column(name = "Pj_type", length = 100)
	public String getPjType() {
		return this.pjType;
	}

	public void setPjType(String pjType) {
		this.pjType = pjType;
	}

	@Column(name = "Point", length = 100)
	public String getPoint() {
		return this.point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

}