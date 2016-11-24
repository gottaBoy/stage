package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppImagesInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_images_info", catalog = "no1stage")
public class TAppImagesInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer parentId;
	private String remark;
	private String title;
	private String url;

	// Constructors

	/** default constructor */
	public TAppImagesInfo() {
	}

	/** full constructor */
	public TAppImagesInfo(Integer parentId, String remark, String url) {
		this.parentId = parentId;
		this.remark = remark;
		this.url = url;
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

	@Column(name = "parentID",nullable = false)
	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Column(name = "remark", length = 2000)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "url", length = 200)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "title", length = 200)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}