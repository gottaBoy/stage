package com.smt.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_app_company_pay_record", catalog = "no1stage")
public class TAppCompanyPayRecord {
	public int id;
	public int creater;
	public Date createDate;
	public String batchNo;
	public String orderNo;
	public String email;
	public String name;
	public String payDate; 
	public String payEmail;
	public String payName;
	public double payPrice;
	public int status;//付款状态1、未付款2、付款成功3、付款失败
	
	public TAppCompanyPayRecord() {
		
	}

	public TAppCompanyPayRecord(int id, int creater, Date createDate,
			String batchNo, String orderNo, String email, String name,
			String payDate, String payEmail, String payName, double payPrice,
			int status) {
		super();
		this.id = id;
		this.creater = creater;
		this.createDate = createDate;
		this.batchNo = batchNo;
		this.orderNo = orderNo;
		this.email = email;
		this.name = name;
		this.payDate = payDate;
		this.payEmail = payEmail;
		this.payName = payName;
		this.payPrice = payPrice;
		this.status = status;//付款状态1、未付款2、付款成功3、付款失败
	}

	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "creater")
	public int getCreater() {
		return creater;
	}

	public void setCreater(int creater) {
		this.creater = creater;
	}

	@Column(name = "createDate")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Column(name = "batchNo", length = 50)
	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	@Column(name = "orderNo", length = 50)
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	@Column(name = "email", length = 50)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "payDate", length = 50)
	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	@Column(name = "payEmail", length = 50)
	public String getPayEmail() {
		return payEmail;
	}

	public void setPayEmail(String payEmail) {
		this.payEmail = payEmail;
	}

	@Column(name = "payName", length = 50)
	public String getPayName() {
		return payName;
	}

	public void setPayName(String payName) {
		this.payName = payName;
	}

	@Column(name = "payPrice")
	public double getPayPrice() {
		return payPrice;
	}

	public void setPayPrice(double payPrice) {
		this.payPrice = payPrice;
	}

	@Column(name = "status")
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	

//	@Id
//	@GeneratedValue
//	@Column(name = "id", unique = true, nullable = false)
//	public int getId() {
//		return id;
//	}
//
//	public void setId(int id) {
//		this.id = id;
//	}
//
//	@Column(name = "createDate")
//	public Date getCreateDate() {
//		return createDate;
//	}
//
//	public void setCreateDate(Date createDate) {
//		this.createDate = createDate;
//	}
//
//	@Column(name = "creater")
//	public int getCreater() {
//		return creater;
//	}
//	
//	public void setCreater(int creater) {
//		this.creater = creater;
//	}
//
//	@Column(name = "orderNo", length = 50)
//	public String getOrderNo() {
//		return orderNo;
//	}
//
//	public void setOrderNo(String orderNo) {
//		this.orderNo = orderNo;
//	}
//
//	@Column(name = "email", length = 50)
//	public String getEmail() {
//		return email;
//	}
//
//	public void setEmail(String email) {
//		this.email = email;
//	}
//
//	@Column(name = "name", length = 50)
//	public String getName() {
//		return name;
//	}
//
//	public void setName(String name) {
//		this.name = name;
//	}
//
//	@Column(name = "payDate", length = 50)
//	public String getPayDate() {
//		return payDate;
//	}
//
//	public void setPayDate(String payDate) {
//		this.payDate = payDate;
//	}
//
//	@Column(name = "payPrice")
//	public double getPayPrice() {
//		return payPrice;
//	}
//
//	public void setPayPrice(double payPrice) {
//		this.payPrice = payPrice;
//	}
	
	
	
	
	
}
