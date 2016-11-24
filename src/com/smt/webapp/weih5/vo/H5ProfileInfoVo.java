package com.smt.webapp.weih5.vo;

public class H5ProfileInfoVo {

	private int userId;

	private String userNickName;
	private String userAccountName;

	private int myBizTaskCount;
	
	private int myTaskCount;
	private int myAppliedTaskCount;
	
	private int myInviteCount;
	private int invitedMeCount;

	private int myFanCount;
	private int myFollowCount;

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getUserAccountName() {
		return userAccountName;
	}

	public void setUserAccountName(String userAccountName) {
		this.userAccountName = userAccountName;
	}

	public int getMyTaskCount() {
		return myTaskCount;
	}

	public void setMyTaskCount(int myTaskCount) {
		this.myTaskCount = myTaskCount;
	}

	public int getMyInviteCount() {
		return myInviteCount;
	}

	public void setMyInviteCount(int myInviteCount) {
		this.myInviteCount = myInviteCount;
	}

	public int getMyFanCount() {
		return myFanCount;
	}

	public void setMyFanCount(int myFanCount) {
		this.myFanCount = myFanCount;
	}

	public int getMyFollowCount() {
		return myFollowCount;
	}

	public void setMyFollowCount(int myFollowCount) {
		this.myFollowCount = myFollowCount;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getMyBizTaskCount() {
		return myBizTaskCount;
	}

	public void setMyBizTaskCount(int myBizTaskCount) {
		this.myBizTaskCount = myBizTaskCount;
	}

	public int getMyAppliedTaskCount() {
		return myAppliedTaskCount;
	}

	public void setMyAppliedTaskCount(int myAppliedTaskCount) {
		this.myAppliedTaskCount = myAppliedTaskCount;
	}

	public int getInvitedMeCount() {
		return invitedMeCount;
	}

	public void setInvitedMeCount(int invitedMeCount) {
		this.invitedMeCount = invitedMeCount;
	}
}
