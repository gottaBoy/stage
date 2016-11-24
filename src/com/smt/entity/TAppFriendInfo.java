package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppFriendInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_friend_info", catalog = "no1stage")
public class TAppFriendInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private Integer friendId;
	private String creatTime;

	// Constructors

	/** default constructor */
	public TAppFriendInfo() {
	}

	/** minimal constructor */
	public TAppFriendInfo(Integer userId, Integer friendId) {
		this.userId = userId;
		this.friendId = friendId;
	}

	/** full constructor */
	public TAppFriendInfo(Integer userId, Integer friendId, String creatTime) {
		this.userId = userId;
		this.friendId = friendId;
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

	@Column(name = "FriendId", nullable = false)
	public Integer getFriendId() {
		return this.friendId;
	}

	public void setFriendId(Integer friendId) {
		this.friendId = friendId;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

}