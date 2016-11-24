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
@Table(name = "t_app_role_authority", catalog = "no1stage")
public class TAppRoleAuthority implements java.io.Serializable {

	// Fields

	private int id;
	private int roleId;
	private int menuId;

	// Constructors


	/** default constructor */
	public TAppRoleAuthority() {
	}

	/** full constructor */
	public TAppRoleAuthority(int id, int roleId, int menuId) {
		super();
		this.id = id;
		this.roleId = roleId;
		this.menuId = menuId;
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

	@Column(name = "roleId")
	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	@Column(name = "menuId")
	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	

}