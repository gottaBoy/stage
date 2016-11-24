package com.smt.entity;

import javax.persistence.Transient;

/**
 */
public class TAppCostInfoBean extends TAppCostInfo {

	@Transient
	private String price;
	@Transient
	private int days;
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
 

}