package com.smt.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppFriendInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_upload_file", catalog = "no1stage")
public class TAppUploadFile implements java.io.Serializable {

	// Fields

	private int id;
	private String attachName;//谁顶的
	private String suffix;//被顶的人
	private int size;
	private int orderId;
	private Date uploadDate;

	// Constructors


	/** default constructor */
	public TAppUploadFile() {
	}

	/** full constructor */
	public TAppUploadFile(int id, String attachName, String suffix, int size,
			int orderId, Date uploadDate) {
		super();
		this.id = id;
		this.attachName = attachName;
		this.suffix = suffix;
		this.size = size;
		this.orderId = orderId;
		this.uploadDate = uploadDate;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "attachName", length=200)
	public String getAttachName() {
		return this.attachName;
	}

	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
	
	@Column(name = "suffix", length=30)
	public String getSuffix() {
		return this.suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}
	
	@Column(name = "size")
	public int getSize() {
		return this.size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	@Column(name = "orderId")
	public int getOrderId() {
		return this.orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	@Column(name = "uploadDate", length=32)
	public Date getUploadDate() {
		return this.uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

}