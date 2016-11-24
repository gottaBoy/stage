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
@Table(name = "t_app_role", catalog = "no1stage")
public class TAppRole implements java.io.Serializable {

	// Fields

	private Integer id;
	private String roleName;//角色名
	private String roleDescribe;//角色描述
	private Integer creater;
	private Date createTime;

	// Constructors


	/** default constructor */
	public TAppRole() {
	}

	/** full constructor */
	public TAppRole(Integer id, String roleName, String roleDescribe, Integer creater,
			Date createTime) {
		super();
		this.id = id;
		this.roleName = roleName;
		this.roleDescribe = roleDescribe;
		this.creater = creater;
		this.createTime = createTime;
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

	@Column(name = "roleName", length=100)
	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Column(name = "roleDescribe", length=200)
	public String getRoleDescribe() {
		return roleDescribe;
	}

	public void setRoleDescribe(String roleDescribe) {
		this.roleDescribe = roleDescribe;
	}

	@Column(name = "creater")
	public Integer getCreater() {
		return creater;
	}

	public void setCreater(Integer creater) {
		this.creater = creater;
	}

	@Column(name = "createTime")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	

}