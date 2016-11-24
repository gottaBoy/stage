package com.smt.webapp.weih5.utils.model;

import java.util.Date;

import com.smt.webapp.weih5.utils.H5DateHelper;

public class ValidCodeModel {

	private static final int OVERDUE_MINUTES = 30;

	private int validCode;
	private long activityTime;
	private long overdueTime;

	public ValidCodeModel(int validCode) {
		this.validCode = validCode;
		this.activityTime = new Date().getTime();
		this.overdueTime = H5DateHelper.calDateAfterOnMinute(new Date(), OVERDUE_MINUTES).getTime();
	}

	public int getValidCode() {
		return validCode;
	}

	public void setValidCode(int validCode) {
		this.validCode = validCode;
	}

	public long getActivityTime() {
		return activityTime;
	}

	public void setActivityTime(long activityTime) {
		this.activityTime = activityTime;
	}

	public long getOverdueTime() {
		return overdueTime;
	}

	public void setOverdueTime(long overdueTime) {
		this.overdueTime = overdueTime;
	}

}
