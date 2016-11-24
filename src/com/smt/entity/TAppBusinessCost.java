package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppBusinessInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_business_cost", catalog = "no1stage")
public class TAppBusinessCost implements java.io.Serializable {
	
	private int id;
	private int orderId;
	private int costId;
	private String price;//付款金额
	private int days;//付款比例
	private String keywords;//演员 具体 职业技能
	private int bcostId;//演员剧团 职业 id 
	
	public TAppBusinessCost() {
		
	}

	

	public TAppBusinessCost(int id, int orderId, int costId, String price,
			int days,String keywords, int bcostId) {
		super();
		this.id = id;
		this.orderId = orderId;
		this.costId = costId;
		this.price = price;
		this.days = days;
		this.keywords=keywords;
		this.bcostId=bcostId;
	}



	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true, nullable = false)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	@Column(name = "orderId")
	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	@Column(name = "costId")
	public int getCostId() {
		return costId;
	}

	public void setCostId(int costId) {
		this.costId = costId;
	}
	
	@Column(name = "price", length = 32)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@Column(name = "days")
	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	@Column(name = "keywords", length = 32)
	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	@Column(name = "bcostId")
	public int getBcostId() {
		return bcostId;
	}

	public void setBcostId(int bcostId) {
		this.bcostId = bcostId;
	}
}