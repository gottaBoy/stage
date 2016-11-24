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
@Table(name = "t_app_ding", catalog = "no1stage")
public class TAppDing implements java.io.Serializable {

	// Fields

	private int id;
	private int userId;//谁顶的
	private int dingUserId;//被顶的人
	private String createTime;
	private int type;//被顶的类型，1是个人，2是相册，3是视频，4是音频

	// Constructors

	/** default constructor */
	public TAppDing() {
	}

	/** full constructor */
	public TAppDing(int userId, int dingUserId, String createTime,int type) {
		this.userId = userId;
		this.dingUserId = dingUserId;
		this.createTime = createTime;
		this.type = type;
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

	@Column(name = "userId", nullable = false)
	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Column(name = "dingUserId", nullable = false)
	public int getDingUserId() {
		return this.dingUserId;
	}

	public void setDingUserId(int dingUserId) {
		this.dingUserId = dingUserId;
	}

	@Column(name = "createTime", length=32)
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	@Column(name = "type", nullable = false)
	public int getType() {
		return this.type;
	}

	public void setType(int type) {
		this.type = type;
	}

}