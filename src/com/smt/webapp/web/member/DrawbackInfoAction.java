package com.smt.webapp.web.member;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import alipay.config.AlipayConfig;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.common.DateFormatUtil;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppBusinessPay;
import com.smt.entity.TAppCompanyPayRecord;
import com.smt.entity.TAppDrawbackInfo;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.drawback.DrawbackInfoService;
import com.smt.webapp.util.HttpSessionHelper;

public class DrawbackInfoAction extends ActionSupport {
	
	private TAppDrawbackInfo drawback=new TAppDrawbackInfo();

	private int choucheng = 1;
	
	public TAppDrawbackInfo getDrawback() {
		return drawback;
	}

	public void setDrawback(TAppDrawbackInfo drawback) {
		this.drawback = drawback;
	}

	@Autowired
	private DrawbackInfoService drawbackInfoService;
	@Autowired
	private BusinessInfoService businessInfoService;
	
	public String myDrawback(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		
		int total = drawbackInfoService.getTotal(userId, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;

		List drawbackList=drawbackInfoService.getMyDrawback(userId, (pageNum-1)*rowCount, rowCount, sign);

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("drawbackList", drawbackList);
		return "myDrawback";
	}
	
	public String addDrawback(){
		DecimalFormat df=new DecimalFormat("#0.00");
		HttpServletRequest request=ServletActionContext.getRequest();
		int businessId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		TAppBusinessInfo businessInfo=businessInfoService.getBusinessInfoById(businessId);
		String businessNo=businessInfo.getOrderCode();
		double amount=Double.parseDouble(businessInfo.getPrice());
		
		double returnPrice = drawbackInfoService.getReturnPrice(businessInfo.getId(), 1);
		
		String businessAmount=df.format(amount);
		request.setAttribute("businessId", businessId);
		request.setAttribute("returnPrice", returnPrice);
		request.setAttribute("choucheng", choucheng);
		request.setAttribute("businessNo", businessNo);
		request.setAttribute("businessAmount", businessAmount);
		return "addDrawback";
	}
	
	public String editDrawback(){
		DecimalFormat df=new DecimalFormat("#0.00");
		HttpServletRequest request=ServletActionContext.getRequest();
		int drawbackId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		drawback=drawbackInfoService.getDrawbackById(drawbackId);
		
		double payment = Double.parseDouble(drawback.getDrawbackAmount());
		double cc = Double.parseDouble(drawback.getChoucheng());
		double price = DateFormatUtil.calValue(payment, cc, "*", 2);
		price = DateFormatUtil.calValue(price, 100, "/", 2);
		price = DateFormatUtil.calValue(payment, price, "-", 2);
		drawback.setPrice(price + "");
		
		int businessId = drawback.getBusinessId();
		TAppBusinessInfo businessInfo=businessInfoService.getBusinessInfoById(businessId);
		String businessNo=businessInfo.getOrderCode();
		double amount=Double.parseDouble(businessInfo.getPrice());
		String businessAmount=df.format(amount);

		double returnPrice = drawbackInfoService.getReturnPrice(businessInfo.getId(), 1);
		
		request.setAttribute("returnPrice", returnPrice);
		request.setAttribute("choucheng", choucheng);
		request.setAttribute("businessNo", businessNo);
		request.setAttribute("businessAmount", businessAmount);
		return "editDrawback";
	}
	
	public synchronized void doAddDrawback(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		drawback.setCreatTime(createDateTime);
		drawback.setStatus("1");	//等待退款
		double payment = Double.parseDouble(drawback.getDrawbackAmount());
		double cc = Double.parseDouble(drawback.getChoucheng());
		double price = DateFormatUtil.calValue(payment, cc, "*", 2);
		price = DateFormatUtil.calValue(price, 100, "/", 2);
		price = DateFormatUtil.calValue(payment, price, "-", 2);
		drawback.setPrice(price + "");
		
		drawback.setDrawbackNo(drawbackInfoService.getNewDrawbackNo(createDateTime));
		drawbackInfoService.saveOrEditDrawback(drawback);
		int bussinessId=drawback.getBusinessId();
		TAppBusinessInfo business=businessInfoService.getBusinessInfoById(bussinessId);
		business.setDrawbackStatus(business.getStatus());
		business.setStatus(7);	//申请退款中
		businessInfoService.addOrEditBusinessInfo(business);
		
		//return "myDrawback";
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void doEditDrawback(){
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		//drawback.setStatus("3");	//再次退款
		drawbackInfoService.saveOrEditDrawback(drawback);
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//return null;
	}
	
	//确认退款信息
	public void checkDrawback(){
		HttpServletRequest request=ServletActionContext.getRequest();
    	HttpServletResponse response=ServletActionContext.getResponse();
    	
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		
		drawback=drawbackInfoService.getDrawbackById(id);
		//return "confirmDrawback";
		
		try {
			if(drawback.getStatus().equals("1")) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//确认退款信息
	public String confirmDrawback(){
		HttpServletRequest request=ServletActionContext.getRequest();
    	
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		drawback=drawbackInfoService.getDrawbackById(id);
		return "confirmDrawback";
	}
	
	public void updateDrawbackStatus(){
		HttpServletRequest request=ServletActionContext.getRequest();
    	HttpServletResponse response=ServletActionContext.getResponse();
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
    	int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
    	String orderNo = "";
    	try {
			id = Integer.parseInt(request.getParameter("id"));
			drawback=drawbackInfoService.getDrawbackById(id);
		} catch (NumberFormatException e1) {
			orderNo = request.getParameter("id");
			drawback = drawbackInfoService.getDrawbackByCode(orderNo);
		}
    	
    	
    	String status=request.getParameter("status")==null?"":request.getParameter("status");
    	if(!status.equals("")){
    		//同意退款，设定当前时间为退款时间
    		if(status.equals("2")){
    			drawback.setDrawbackDate(createDateTime);
    		}
     		drawback.setStatus(status);	
    	}
    	drawbackInfoService.saveOrEditDrawback(drawback);
    	//退款同意后，交易关闭
    	if(status.equals("3")){
	    	int bussinessId=drawback.getBusinessId();
			TAppBusinessInfo business=businessInfoService.getBusinessInfoById(bussinessId);
			business.setStatus(8);	//退款完成
			businessInfoService.addOrEditBusinessInfo(business);
    	}
    	//退款撤销后，订单状态改为原状态
    	else if(status.equals("5")){
    		int bussinessId=drawback.getBusinessId();
			TAppBusinessInfo business=businessInfoService.getBusinessInfoById(bussinessId);
			business.setStatus(business.getDrawbackStatus());	//交易成功
			businessInfoService.addOrEditBusinessInfo(business);
    	}
    	try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//后台我的退款显示信息
	public String toDrawbackView(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		drawback=drawbackInfoService.getDrawbackById(id);
		return "toDrawbackView";
	}
	

	//后台要退款列表
	public String drawbackList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign = 3;
		
		int total = drawbackInfoService.getTotal(userId, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;

		List drawbackList=drawbackInfoService.getMyDrawback(userId, (pageNum-1)*rowCount, rowCount, sign);

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("drawbackList", drawbackList);
		
		return "drawbackList";
	}
	
	//获取要付款的订单的信息给支付宝
	public synchronized String getPayInfo(){
		HttpServletRequest request=ServletActionContext.getRequest();
		
		int userId = HttpSessionHelper.getUserSession(request).getId();
		
    	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
    	String date = format.format(new Date());
    	double priceTotal = 0;
    	int payCount = 0;
    	String detail = "";
    	
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		
    	String batchNo = businessInfoService.getNewContractNo(createDateTime, 2);	//订单编号
    	
    	TAppDrawbackInfo drawbackInfo = null;
    	TAppBusinessInfo businessInfo = null;
    	
    	int id = 0;
    	//如果有ID，是对单个订单付款，否则批量查询需要付款的订单
    	try {
			id = Integer.parseInt(request.getParameter("id"));
			drawbackInfo = drawbackInfoService.getDrawbackById(id);
			
			businessInfo = businessInfoService.getBusinessInfoById(drawbackInfo.getBusinessId());
			
			TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
			detail = drawbackInfo.getDrawbackNo();
			
			TAppCompanyPayRecord payRecord = new TAppCompanyPayRecord();
			
			if(userInfo != null) {
				detail += "^" + userInfo.getAlipay() + "^" + userInfo.getAlipayName() + "^" + drawbackInfo.getPrice() + "^来自第一舞台的付款已支付";
				payRecord.setPayEmail(userInfo.getAlipay());
				payRecord.setPayName(userInfo.getAlipayName());
			}
			
			priceTotal = Double.parseDouble(drawbackInfo.getPrice());
			
			payCount++;
			
			payRecord.setCreater(userId);
			payRecord.setCreateDate(new Date());
			payRecord.setBatchNo(batchNo);
			payRecord.setOrderNo(drawbackInfo.getDrawbackNo());
			payRecord.setEmail(AlipayConfig.sellerEmail);
			payRecord.setName(AlipayConfig.sellerName);
			payRecord.setPayDate(date);
			
			payRecord.setPayPrice(Double.parseDouble(drawbackInfo.getPrice()));
			payRecord.setStatus(1);
			
			businessInfoService.addCompanyPayRecord(payRecord);
		} catch (NumberFormatException e1) {
			priceTotal = 0;
	    	payCount = 0;
	    	detail = "";
	    	
	    	//需要付款的订单列表
			List<TAppDrawbackInfo> payList = drawbackInfoService.getPayList();
			
			for (int i = 0; i < payList.size(); i++) {
				TAppDrawbackInfo pay = payList.get(i);
				businessInfo = businessInfoService.getBusinessInfoById(pay.getBusinessId());
				
				priceTotal = DateFormatUtil.calValue(priceTotal, Double.parseDouble(pay.getPrice()), "+", 2);
				payCount++;
				
				TAppCompanyPayRecord payRecord = new TAppCompanyPayRecord();
				
				TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
				if(userInfo != null) {
					detail += pay.getDrawbackNo() + "^" + userInfo.getAlipay() + "^" + userInfo.getAlipayName() + "^" + pay.getPrice() + "^来自第一舞台的付款已支付|";
					payRecord.setPayEmail(userInfo.getAlipay());
					payRecord.setPayName(userInfo.getAlipayName());
				}
				payRecord.setCreater(userId);
				payRecord.setCreateDate(new Date());
				payRecord.setBatchNo(batchNo);
				payRecord.setOrderNo(pay.getDrawbackNo());
				payRecord.setEmail(AlipayConfig.sellerEmail);
				payRecord.setName(AlipayConfig.sellerName);
				payRecord.setPayDate(date);
				
				payRecord.setPayPrice(Double.parseDouble(pay.getPrice()));
				payRecord.setStatus(1);
				
				businessInfoService.addCompanyPayRecord(payRecord);
			}
			
			detail = detail.substring(0, detail.length() - 1);
		}
		
		request.setAttribute("date", date);
		request.setAttribute("priceTotal", priceTotal);
		request.setAttribute("payCount", payCount);
		request.setAttribute("detail", detail);
		request.setAttribute("batchNo", batchNo);
		
		return "toPay";
	}
}
