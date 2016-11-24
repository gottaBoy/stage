package com.smt.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppBusinessInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_business_pay", catalog = "no1stage")
public class TAppBusinessPay implements java.io.Serializable {
	
	private int id;
	private int orderId;
	private String price;//付款金额
	private String price1;//实际付款金额扣除第一舞台抽成应该支付给艺人的金额
	private String payRatio;//付款比例
	private Date paymentTime;//约定的付款时间
	private Date actualPayTime;//实际付款时间
	private int pos;
	private int isPay;//第一舞台是否支付给卖家钱1、否2、是
	private Date payTime;//第一舞台支付时间
	private int isPayment;//买家是否已支付1、否2、是
	private int confrimPay;//是否已确认付款给卖家1、否2、是 需手动确认时为否，否则全部为是
	private Date updatePayTime;//延后的时间
	
	public TAppBusinessPay() {
		
	}

	public TAppBusinessPay(int id, int orderId, String price, String price1, String payRatio,
			Date paymentTime, Date actualPayTime, int pos, int isPay,
			Date payTime, int isPayment, int confrimPay, Date updatePayTime) {
		super();
		this.id = id;
		this.orderId = orderId;
		this.price = price;
		this.price1 = price1;
		this.payRatio = payRatio;
		this.paymentTime = paymentTime;
		this.actualPayTime = actualPayTime;
		this.pos = pos;
		this.isPay = isPay;
		this.payTime = payTime;
		this.isPayment = isPayment;
		this.confrimPay = confrimPay;
		this.updatePayTime = updatePayTime;
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

	@Column(name = "price", length = 32)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@Column(name = "price1", length = 32)
	public String getPrice1() {
		return price1;
	}

	public void setPrice1(String price1) {
		this.price1 = price1;
	}

	@Column(name = "payRatio", length = 32)
	public String getPayRatio() {
		return payRatio;
	}

	public void setPayRatio(String payRatio) {
		this.payRatio = payRatio;
	}

	@Column(name = "paymentTime")
	public Date getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(Date paymentTime) {
		this.paymentTime = paymentTime;
	}

	@Column(name = "actualPayTime")
	public Date getActualPayTime() {
		return actualPayTime;
	}

	public void setActualPayTime(Date actualPayTime) {
		this.actualPayTime = actualPayTime;
	}

	@Column(name = "pos")
	public int getPos() {
		return pos;
	}

	public void setPos(int pos) {
		this.pos = pos;
	}

	@Column(name = "isPay")
	public int getIsPay() {
		return isPay;
	}

	public void setIsPay(int isPay) {
		this.isPay = isPay;
	}

	@Column(name = "payTime")
	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	@Column(name = "isPayment")
	public int getIsPayment() {
		return isPayment;
	}

	public void setIsPayment(int isPayment) {
		this.isPayment = isPayment;
	}

	@Column(name = "confrimPay")
	public int getConfrimPay() {
		return confrimPay;
	}

	public void setConfrimPay(int confrimPay) {
		this.confrimPay = confrimPay;
	}

	@Column(name = "updatePayTime")
	public Date getUpdatePayTime() {
		return updatePayTime;
	}

	public void setUpdatePayTime(Date updatePayTime) {
		this.updatePayTime = updatePayTime;
	}
		
	
	
	
}