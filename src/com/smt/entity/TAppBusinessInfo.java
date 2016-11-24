package com.smt.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TAppBusinessInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_business_info", catalog = "no1stage")
public class TAppBusinessInfo implements java.io.Serializable {
	private Integer id;
	private String orderCode;

//    <s:if test="#businessInfo.business.status==1">等待确认</s:if>
//	<s:if test="#businessInfo.business.status==2">订单已确认</s:if>
//	<s:if test="#businessInfo.business.status==3">任务已完成</s:if>
//	<s:if test="#businessInfo.business.status==4">任务确认完成</s:if>
//	<s:if test="#businessInfo.business.status==5">任务到期完成</s:if>
//	<s:if test="#businessInfo.business.status==6">已确认付款</s:if>
//	<s:if test="#businessInfo.business.status==7">申请退款中</s:if>
//	<s:if test="#businessInfo.business.status==8">退款已完成</s:if>
//	<s:if test="#businessInfo.business.status==9">订单关闭</s:if>
//	<s:if test="#businessInfo.business.status==10">交易成功</s:if>

	//订单状态1、等待确认2、已确认等待付款3、已部分付款4、已付款5、演出已完成6、订单已完成
	//7、退款申请中8、退款已完成9、订单已关闭
	//10、第一舞台已把所有款项支付给卖家
	private Integer status;
	private Integer buyer;//签约者 买家
	private Integer seller;//被签约者  卖家
	private Integer sellerCompany;//被签约者  卖家所属公司
	private String price;//签约价格
	private String choucheng;//第一舞台抽成比例
	private String provice;
	private String city;
	private String address;
	private String content;
	private String beginDate;
	private String beginTime;
	private String endDate;
	private String endTime;
	private Integer buyerRate;//买家是否已评价1、否2、是
	private Integer sellerRate;//卖家是否已评价1、否2、是
	private Integer isByStages;//是否分期支付1、否2、是
	private Date createTime;
	private String createTimeStr;
	private String otherCost1;//其他费用1、车船费
	private String otherCost2;//其他费用2、住宿费
	private String otherCost3;//其他费用3、餐饮费
	private Integer receipt;//是否需要发票1、否2、是
	private Date createTime2;//确认时间
	private Date createTime3;//付款时间
	private Date createTime4;//演出完成时间
	private Date createTime5;//订单完成时间
	private Date createTime6;//退款申请时间
	private Date createTime7;//退款完成时间
	private Date createTime8;//订单关闭时间
	private Date createTime9;//评价时间
	private Integer drawbackStatus;//申请退款前的订单状态，用于退款撤销后恢复原订单状态
	private Integer updatePayTimeCount;//修改付款时间的次数
	private Integer updatePayTimeStatus;//修改付款时间的状态1、申请中2、同意3、不同意
	
	
	public TAppBusinessInfo() {
		
	}


	public TAppBusinessInfo(Integer id, String orderCode, Integer status, Integer buyer,
			Integer seller, Integer sellerCompany, String price,
			String choucheng, String provice, String city, String address,
			String content, String beginDate, String beginTime, String endDate,
			String endTime, Integer buyerRate, Integer sellerRate, Integer isByStages,
			Date createTime, String otherCost1, String otherCost2, Integer receipt,
			Date createTime2, Date createTime3, Date createTime4,
			Date createTime5, Date createTime6, Date createTime7,
			Date createTime8, Date createTime9, Integer drawbackStatus,
			Integer updatePayTimeCount, Integer updatePayTimeStatus, String otherCost3) {
		super();
		this.id = id;
		this.orderCode = orderCode;
		this.status = status;
		this.buyer = buyer;
		this.seller = seller;
		this.sellerCompany = sellerCompany;
		this.price = price;
		this.choucheng = choucheng;
		this.provice = provice;
		this.city = city;
		this.address = address;
		this.content = content;
		this.beginDate = beginDate;
		this.beginTime = beginTime;
		this.endDate = endDate;
		this.endTime = endTime;
		this.buyerRate = buyerRate;
		this.sellerRate = sellerRate;
		this.isByStages = isByStages;
		this.createTime = createTime;
		this.otherCost1 = otherCost1;
		this.otherCost2 = otherCost2;
		this.otherCost3 = otherCost3;
		this.receipt = receipt;
		this.createTime2 = createTime2;
		this.createTime3 = createTime3;
		this.createTime4 = createTime4;
		this.createTime5 = createTime5;
		this.createTime6 = createTime6;
		this.createTime7 = createTime7;
		this.createTime8 = createTime8;
		this.createTime9 = createTime9;
		this.drawbackStatus = drawbackStatus;
		this.updatePayTimeCount = updatePayTimeCount;
		this.updatePayTimeStatus = updatePayTimeStatus;
	}




	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "orderCode", length = 50)
	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	@Column(name = "status")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "buyer")
	public Integer getBuyer() {
		return buyer;
	}

	public void setBuyer(Integer buyer) {
		this.buyer = buyer;
	}

	@Column(name = "seller")
	public Integer getSeller() {
		return seller;
	}

	public void setSeller(Integer seller) {
		this.seller = seller;
	}

	@Column(name = "sellerCompany")
	public Integer getSellerCompany() {
		return sellerCompany;
	}

	public void setSellerCompany(Integer sellerCompany) {
		this.sellerCompany = sellerCompany;
	}

	@Column(name = "price", length = 32)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@Column(name = "choucheng", length = 32)
	public String getChoucheng() {
		return choucheng;
	}

	public void setChoucheng(String choucheng) {
		this.choucheng = choucheng;
	}

	@Column(name = "address", length = 300)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "content", length = 500)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "beginDate", length=32)
	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	@Column(name = "beginTime", length=32)
	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	@Column(name = "endDate", length=32)
	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	@Column(name = "endTime", length=32)
	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Column(name = "buyerRate")
	public Integer getBuyerRate() {
		return buyerRate;
	}

	public void setBuyerRate(Integer buyerRate) {
		this.buyerRate = buyerRate;
	}

	@Column(name = "sellerRate")
	public Integer getSellerRate() {
		return sellerRate;
	}

	public void setSellerRate(Integer sellerRate) {
		this.sellerRate = sellerRate;
	}

	@Column(name = "isByStages")
	public Integer getIsByStages() {
		return isByStages;
	}

	public void setIsByStages(Integer isByStages) {
		this.isByStages = isByStages;
	}

	@Column(name = "createTime")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setCreateTimeStr(format.format(createTime));
	}

	
	
	@Transient
	public String getCreateTimeStr() {
	    return this.createTimeStr;
	}

	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}


	@Column(name = "provice", length=32)
	public String getProvice() {
		return provice;
	}

	public void setProvice(String provice) {
		this.provice = provice;
	}

	@Column(name = "city", length=32)
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "otherCost1", length=32)
	public String getOtherCost1() {
		return otherCost1;
	}

	public void setOtherCost1(String otherCost1) {
		this.otherCost1 = otherCost1;
	}

	@Column(name = "otherCost2", length=32)
	public String getOtherCost2() {
		return otherCost2;
	}

	public void setOtherCost2(String otherCost2) {
		this.otherCost2 = otherCost2;
	}

	@Column(name = "otherCost3", length=32)
	public String getOtherCost3() {
		return otherCost3;
	}

	public void setOtherCost3(String otherCost3) {
		this.otherCost3 = otherCost3;
	}
	@Column(name = "receipt")
	public Integer getReceipt() {
		return receipt;
	}

	public void setReceipt(Integer receipt) {
		this.receipt = receipt;
	}
	
	@Column(name = "createTime2")
	public Date getCreateTime2() {
		return createTime2;
	}

	public void setCreateTime2(Date createTime2) {
		this.createTime2 = createTime2;
	}
	
	@Column(name = "createTime3")
	public Date getCreateTime3() {
		return createTime3;
	}

	public void setCreateTime3(Date createTime3) {
		this.createTime3 = createTime3;
	}
	
	@Column(name = "createTime4")
	public Date getCreateTime4() {
		return createTime4;
	}

	public void setCreateTime4(Date createTime4) {
		this.createTime4 = createTime4;
	}
	
	@Column(name = "createTime5")
	public Date getCreateTime5() {
		return createTime5;
	}

	public void setCreateTime5(Date createTime5) {
		this.createTime5 = createTime5;
	}
	
	@Column(name = "createTime6")
	public Date getCreateTime6() {
		return createTime6;
	}

	public void setCreateTime6(Date createTime6) {
		this.createTime6 = createTime6;
	}
	
	@Column(name = "createTime7")
	public Date getCreateTime7() {
		return createTime7;
	}

	public void setCreateTime7(Date createTime7) {
		this.createTime7 = createTime7;
	}
	
	@Column(name = "createTime8")
	public Date getCreateTime8() {
		return createTime8;
	}

	public void setCreateTime8(Date createTime8) {
		this.createTime8 = createTime8;
	}
	
	@Column(name = "createTime9")
	public Date getCreateTime9() {
		return createTime9;
	}

	public void setCreateTime9(Date createTime9) {
		this.createTime9 = createTime9;
	}
	
	@Column(name = "drawbackStatus")
	public Integer getDrawbackStatus() {
		return drawbackStatus;
	}

	public void setDrawbackStatus(Integer drawbackStatus) {
		this.drawbackStatus = drawbackStatus;
	}
	
	@Column(name = "updatePayTimeCount")
	public Integer getUpdatePayTimeCount() {
		return updatePayTimeCount;
	}

	public void setUpdatePayTimeCount(Integer updatePayTimeCount) {
		this.updatePayTimeCount = updatePayTimeCount;
	}
	
	@Column(name = "updatePayTimeStatus")
	public Integer getUpdatePayTimeStatus() {
		return updatePayTimeStatus;
	}

	public void setUpdatePayTimeStatus(Integer updatePayTimeStatus) {
		this.updatePayTimeStatus = updatePayTimeStatus;
	}
	
}