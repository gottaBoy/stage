package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import freemarker.cache.StrongCacheStorage;

/**
 * TAppBusinessInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_company_info", catalog = "no1stage")
public class TAppCompanyInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private int businessId;
	private int yrUserId ;//艺人Id
	private int type;//1为本周之星，2为新人推荐，3为最活跃艺人，4为艺人预约
	private String starContent;//本周之星推荐理由
	private String contentOfPictrue2;
	private String linkOfPictrue2;
	private String contentOfPictrue3;
	private String linkOfPictrue3;

	// Constructors

	/** default constructor */
	public TAppCompanyInfo() {
	}

	/** minimal constructor */
	public TAppCompanyInfo(Integer businessId) {
		this.businessId = businessId;
		
	}
	/** full constructor */
	public TAppCompanyInfo(Integer businessId, Integer yrUserId,Integer type,String starContent,String contentOfPictrue2
							,String linkOfPictrue2,String contentOfPictrue3,String linkOfPictrue3) {
		this.businessId = businessId;
		this.yrUserId = yrUserId;
		this.type=type;
		this.contentOfPictrue2=contentOfPictrue2;
		this.linkOfPictrue2=linkOfPictrue2;
		this.starContent=starContent;
		this.contentOfPictrue3=contentOfPictrue3;
		this.linkOfPictrue3=linkOfPictrue3;
		
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
	@Column(name = "businessId")
	public int getBusinessId() {
		return businessId;
	}

	public void setBusinessId(int businessId) {
		this.businessId = businessId;
	}
	@Column(name = "yrUserId")
	public int getYrUserId() {
		return yrUserId;
	}

	public void setYrUserId(int yrUserId) {
		this.yrUserId = yrUserId;
	}
	@Column(name = "type")
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	@Column(name = "starContent")
	public String getStarContent() {
		return starContent;
	}

	public void setStarContent(String starContent) {
		this.starContent = starContent;
	}
	@Column(name = "contentOfPictrue2")
	public String getContentOfPictrue2() {
		return contentOfPictrue2;
	}

	public void setContentOfPictrue2(String contentOfPictrue2) {
		this.contentOfPictrue2 = contentOfPictrue2;
	}
	@Column(name = "linkOfPictrue2")
	public String getLinkOfPictrue2() {
		return linkOfPictrue2;
	}

	public void setLinkOfPictrue2(String linkOfPictrue2) {
		this.linkOfPictrue2 = linkOfPictrue2;
	}
	@Column(name = "contentOfPictrue3")
	public String getContentOfPictrue3() {
		return contentOfPictrue3;
	}

	public void setContentOfPictrue3(String contentOfPictrue3) {
		this.contentOfPictrue3 = contentOfPictrue3;
	}
	@Column(name = "linkOfPictrue3")
	public String getLinkOfPictrue3() {
		return linkOfPictrue3;
	}

	public void setLinkOfPictrue3(String linkOfPictrue3) {
		this.linkOfPictrue3 = linkOfPictrue3;
	}

	
}