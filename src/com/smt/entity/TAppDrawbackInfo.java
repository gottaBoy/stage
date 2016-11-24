package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppDrawbackInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_drawback_info", catalog = "no1stage")
public class TAppDrawbackInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private String drawbackNo;
	private Integer businessId;
	private String drawbackAmount;
	private String drawbackCause;
	private String drawbackDate;
	private String creatTime;
	private String status;//退款状态1、申请中2、乙方同意并且已付钱给第一舞台3、退款已完成4、已关闭
	private String price;//实际支付价格
	private String choucheng;//第一舞台抽成比例

	// Constructors

	/** default constructor */
	public TAppDrawbackInfo() {
	}

	/** minimal constructor */
	public TAppDrawbackInfo(String drawbackNo, Integer businessId,
			String drawbackAmount) {
		this.drawbackNo = drawbackNo;
		this.businessId = businessId;
		this.drawbackAmount = drawbackAmount;
	}

	/** full constructor */
	public TAppDrawbackInfo(Integer id, String drawbackNo, Integer businessId,
			String drawbackAmount, String drawbackCause, String drawbackDate,
			String creatTime, String status, String price, String choucheng) {
		super();
		this.id = id;
		this.drawbackNo = drawbackNo;
		this.businessId = businessId;
		this.drawbackAmount = drawbackAmount;
		this.drawbackCause = drawbackCause;
		this.drawbackDate = drawbackDate;
		this.creatTime = creatTime;
		this.status = status;
		this.price = price;
		this.choucheng = choucheng;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "Id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "DrawbackNo", nullable = false, length = 14)
	public String getDrawbackNo() {
		return this.drawbackNo;
	}

	public void setDrawbackNo(String drawbackNo) {
		this.drawbackNo = drawbackNo;
	}

	@Column(name = "BusinessId", nullable = false)
	public Integer getBusinessId() {
		return this.businessId;
	}

	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}

	@Column(name = "DrawbackAmount", nullable = false, length = 32)
	public String getDrawbackAmount() {
		return this.drawbackAmount;
	}

	public void setDrawbackAmount(String drawbackAmount) {
		this.drawbackAmount = drawbackAmount;
	}

	@Column(name = "DrawbackCause", length = 1000)
	public String getDrawbackCause() {
		return this.drawbackCause;
	}

	public void setDrawbackCause(String drawbackCause) {
		this.drawbackCause = drawbackCause;
	}

	@Column(name = "DrawbackDate", length = 100)
	public String getDrawbackDate() {
		return this.drawbackDate;
	}

	public void setDrawbackDate(String drawbackDate) {
		this.drawbackDate = drawbackDate;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	@Column(name = "Status")
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "price", length = 30)
	public String getPrice() {
		return this.price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@Column(name = "choucheng", length = 30)
	public String getChoucheng() {
		return this.choucheng;
	}

	public void setChoucheng(String choucheng) {
		this.choucheng = choucheng;
	}

}