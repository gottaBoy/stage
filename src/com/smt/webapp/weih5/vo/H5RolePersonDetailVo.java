package com.smt.webapp.weih5.vo;

import com.smt.entity.TAppUserInfo;

public class H5RolePersonDetailVo {

	private int userId;
	private String userNickName;
	private int isReady = -2;
	private String displayStatus;

	public H5RolePersonDetailVo(TAppUserInfo userInfo, String createTime, int isReady) {
		this.userId = userInfo.getUserId();
		this.userNickName = userInfo.getNickName();
		this.isReady = isReady;
		this.setDisplayStatus(displayByReadyFlag(isReady));
	}

	private String displayByReadyFlag(int isReady) {
		if (isReady == -1) {
			return "已拒绝";
		} else {
			return "";
		}
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public int getIsReady() {
		return isReady;
	}

	public void setIsReady(int isReady) {
		this.isReady = isReady;
	}

	public String getDisplayStatus() {
		return displayStatus;
	}

	public void setDisplayStatus(String displayStatus) {
		this.displayStatus = displayStatus;
	}

}
