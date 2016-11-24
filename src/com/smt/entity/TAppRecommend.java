package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppRecommend entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_recommend", catalog = "no1stage")
public class TAppRecommend implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private Integer categoryId;

	// Constructors

	/** default constructor */
	public TAppRecommend() {
	}

	/** full constructor */
	public TAppRecommend(Integer userId, Integer categoryId) {
		this.userId = userId;
		this.categoryId = categoryId;
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

	@Column(name = "userId")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "categoryId")
	public Integer getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

}