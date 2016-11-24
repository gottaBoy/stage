package com.smt.webapp.weih5.vo;

import java.util.List;

public class H5TaskInListVo {

	private int id;
	private String title;
	private int personCount;
	private String displayCreateDate;
	private String status;

	private List<H5TaskRoleInListVo> roleList;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPersonCount() {
		return personCount;
	}

	public void setPersonCount(int personCount) {
		this.personCount = personCount;
	}

	public String getDisplayCreateDate() {
		return displayCreateDate;
	}

	public void setDisplayCreateDate(String displayCreateDate) {
		this.displayCreateDate = displayCreateDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<H5TaskRoleInListVo> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<H5TaskRoleInListVo> roleList) {
		this.roleList = roleList;
	}

}
