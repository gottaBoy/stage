package com.smt.webapp.weih5.vo;

import java.util.List;

import org.apache.commons.lang.StringUtils;

public class H5RolePersonListVo {

	private int taskId;
	private int roleId;
	private String roleName;

	private String briefRoleName;

	/**
	 * for the "owner-view"
	 */
	private List<H5RolePersonDetailVo> applyUserList;

	/**
	 * for the common view
	 */
	private String roleDesc;
	private Integer roleNum;
	private Integer priceLow;
	private Integer priceHigh;
	private String sex;
	private String memo;
	private Integer isReady = -2;
	private String displayStatus;

	public String displayByReadyFlag(int isReady) {
		if (isReady == -1) {
			return "已被拒绝";
		} else {
			return "已应征";
		}
	}

	public String translateBriefRoleName(String roleName) {
		if (StringUtils.isBlank(roleName)) {
			return "";
		}
		String[] arr = roleName.split(" ");
		if (arr == null || arr.length == 0) {
			return "";
		}
		return arr[arr.length - 1];
	}

	public Integer getIsReady() {
		return isReady;
	}

	public void setIsReady(Integer isReady) {
		this.isReady = isReady;
	}

	public String getDisplayStatus() {
		return displayStatus;
	}

	public void setDisplayStatus(String displayStatus) {
		this.displayStatus = displayStatus;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<H5RolePersonDetailVo> getApplyUserList() {
		return applyUserList;
	}

	public void setApplyUserList(List<H5RolePersonDetailVo> applyUserList) {
		this.applyUserList = applyUserList;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public Integer getRoleNum() {
		return roleNum;
	}

	public void setRoleNum(Integer roleNum) {
		this.roleNum = roleNum;
	}

	public Integer getPriceLow() {
		return priceLow;
	}

	public void setPriceLow(Integer priceLow) {
		this.priceLow = priceLow;
	}

	public Integer getPriceHigh() {
		return priceHigh;
	}

	public void setPriceHigh(Integer priceHigh) {
		this.priceHigh = priceHigh;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getBriefRoleName() {
		return briefRoleName;
	}

	public void setBriefRoleName(String briefRoleName) {
		this.briefRoleName = briefRoleName;
	}

}
