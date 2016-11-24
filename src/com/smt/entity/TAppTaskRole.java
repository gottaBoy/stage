package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * TAppTaskRole entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_task_role", catalog = "no1stage")
public class TAppTaskRole implements java.io.Serializable {

	// Fields

	private Long id;
	private TAppTask TAppTask;
	private String roleName;
	private String roleDesc;
	private Integer roleNum;
	private Integer priceLow;
	private Integer priceHigh;
	private String sex; //added 201512
	private String memo; //added 201512

	// Constructors

	/** default constructor */
	public TAppTaskRole() {
	}

	/** full constructor */
	public TAppTaskRole(TAppTask TAppTask, String roleName, String roleDesc,
			Integer roleNum, Integer priceLow, Integer priceHigh) {
		this.TAppTask = TAppTask;
		this.roleName = roleName;
		this.roleDesc = roleDesc;
		this.roleNum = roleNum;
		this.priceLow = priceLow;
		this.priceHigh = priceHigh;
	}

	public TAppTaskRole(TAppTask task, String string, String string2,
			String string3, String string4, String string5) {
		this.TAppTask = task;
		this.roleName = string;
		this.roleDesc = string2;
		try {
			roleNum = Integer.parseInt(string3);
		} catch (Exception e) {
			roleNum = 1;
		}
		try {
			priceLow = Integer.parseInt(string4);
		} catch (Exception e) {
		}
		try {
			priceHigh = Integer.parseInt(string5);
		} catch (Exception e) {
		}
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "taskId")
	public TAppTask getTAppTask() {
		return this.TAppTask;
	}

	public void setTAppTask(TAppTask TAppTask) {
		this.TAppTask = TAppTask;
	}

	@Column(name = "roleName", length = 32)
	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Column(name = "roleDesc", length = 200)
	public String getRoleDesc() {
		return this.roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	@Column(name = "roleNum")
	public Integer getRoleNum() {
		return this.roleNum;
	}

	public void setRoleNum(Integer roleNum) {
		this.roleNum = roleNum;
	}

	@Column(name = "priceLow")
	public Integer getPriceLow() {
		return this.priceLow;
	}

	public void setPriceLow(Integer priceLow) {
		this.priceLow = priceLow;
	}

	@Column(name = "priceHigh")
	public Integer getPriceHigh() {
		return this.priceHigh;
	}

	public void setPriceHigh(Integer priceHigh) {
		this.priceHigh = priceHigh;
	}
	
	@Column(name = "sex")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "memo")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public void setRoleNum(String string) {
		try {
			roleNum = Integer.parseInt(string);
		} catch (Exception e) {
			roleNum = 1;
		}
	}

	public void setPriceLow(String string) {
		try {
			priceLow = Integer.parseInt(string);
		} catch (Exception e) {
		}
	}

	public void setPriceHigh(String string) {
		try {
			priceHigh = Integer.parseInt(string);
		} catch (Exception e) {
		}
	}

}