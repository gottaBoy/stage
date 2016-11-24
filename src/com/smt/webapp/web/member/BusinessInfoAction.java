package com.smt.webapp.web.member;

import java.io.File;

import org.apache.log4j.Logger;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.commons.validator.Var;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.WriteException;
import alipay.config.AlipayConfig;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.common.DateFormatUtil;
import com.smt.entity.TAppBusinessCost;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppBusinessPay;
import com.smt.entity.TAppCompanyPayRecord;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppCostInfoBean;
import com.smt.entity.TAppMessage;
import com.smt.entity.TAppUploadFile;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.drawback.DrawbackInfoService;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;
import com.smt.webapp.service.evaluation.UserEvaluationService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class BusinessInfoAction extends ActionSupport {
	
	private Logger logger = Logger.getLogger("mylog");
	
	private int choucheng = 5;
	
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private CostService costService;
	@Autowired
	private DrawbackInfoService drawbackInfoService;
	@Autowired
	private BusinessEvaluateService businessEvaluateSerive;
	@Autowired
	private UserEvaluationService userEvaluationService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageService messageService;
	
	private TAppBusinessInfo businessInfo;
	
	public TAppBusinessInfo getBusinessInfo() {
		return businessInfo;
	}

	public void setBusinessInfo(TAppBusinessInfo businessInfo) {
		this.businessInfo = businessInfo;
	}


	private List<TAppBusinessCost> costList;
 	
 	public List<TAppBusinessCost> getCostList() {
 		return costList;
 	}

 	public void setCostList(List<TAppBusinessCost> costList) {
 		this.costList = costList;
 	}
 	
 	private List<TAppBusinessPay> paymentList;

 	public List<TAppBusinessPay> getPaymentList() {
 		return paymentList;
 	}

 	public void setPaymentList(List<TAppBusinessPay> paymentList) {
 		this.paymentList = paymentList;
 	}
 	
 	private File file;
 	private String fileFileName;
	private String fileContentType;

	public File getFile() {
		return this.file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return this.fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return this.fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	
	/**
	 * 机构服务下单
	 * @return
	 */
	public String  toPreOrder(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		int bqyUserId = NumberUtils.stringToInt(request.getParameter("bqyUserId"), 0);
		request.setAttribute("bqyUserId", bqyUserId);
		
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 1000);
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		
		//List<TAppGrowth> infoList = growthService.getGrowthList(id, begin, length);	
		//int total = growthService.getGrowthTotal(id);
		
		List<TAppCostInfo>  costList = costService.getCostListByUserId(bqyUserId,begin,length);
		List<TAppCostInfoBean> costList2 = new ArrayList<TAppCostInfoBean>();
		for (TAppCostInfo tAppCostInfo : costList) {
			TAppCostInfoBean costInfoBean = new TAppCostInfoBean();
 
			costInfoBean.setId(tAppCostInfo.getId());
			costInfoBean.setKeywords(tAppCostInfo.getKeywords());
			costInfoBean.setBprice(tAppCostInfo.getBprice());
			costInfoBean.setUnit(tAppCostInfo.getUnit());
			
			
			//第一次，而且是选择企业的服务
			if(id==0){
				String serviceId=request.getParameter("serviceId");
				if(StringUtils.equals(tAppCostInfo.getId().toString(), serviceId)){
					costInfoBean.setPrice(tAppCostInfo.getBprice().toString());
					costInfoBean.setDays(1);
				}
				//price,days
				
			}
			costList2.add(costInfoBean);
		}
		request.setAttribute("costList", costList2);
		
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int contactId = userSession.getId();
		
		TAppUserInfo ui1 = userInfoService.findUserInfoById(bqyUserId);
		TAppUser user1 = userService.findUserById(bqyUserId);
		
		TAppUserInfo ui2 = userInfoService.findUserInfoById(contactId);
		
		request.setAttribute("user1", user1);
		request.setAttribute("ui1", ui1); 
		request.setAttribute("ui2", ui2);
		request.setAttribute("isOrg",userSession.getIsOrg());
		
		/*
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		for (TAppCostInfo tAppCostInfo : costList) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("bulletinImg", tAppCostInfo.getBigImage());
			map.put("price", tAppCostInfo.getBprice());
			map.put("unit", tAppCostInfo.getUnit());
			map.put("detail", tAppCostInfo.getDetail());
			map.put("title", tAppCostInfo.getKeywords());
			map.put("id", tAppCostInfo.getId());
			
			resultList.add(map);
		}*/
		
		int userId=HttpSessionHelper.getUserSession(request).getId();
		List list=bqyUserId!=0?costService.getCostInfo(bqyUserId, 0):null;
		List list2=null;//已经下单的 职业列表
		
		
		if(id!=0){
			businessInfo=businessInfoService.getBusinessInfoById(id);
			request.setAttribute("businessInfo", businessInfo);
			
			
			int businessId = businessInfo.getId();
			
			List<TAppBusinessCost> busiCost = businessInfoService.findBusiCostByBusiId(businessId);
			for (TAppBusinessCost tAppBusinessCost : busiCost) {
				for (TAppCostInfoBean tAppCostInfo : costList2) {
					if(tAppCostInfo.getId() == tAppBusinessCost.getCostId()){
						if(StringUtils.isNotBlank(tAppBusinessCost.getPrice())){
							tAppCostInfo.setPrice(tAppBusinessCost.getPrice());
						}else{
							tAppCostInfo.setPrice(StringUtils.EMPTY);
						}
						tAppCostInfo.setDays(tAppBusinessCost.getDays());
					}
				}
			}
			
			//request.setAttribute("busiCost", busiCost);
			
			
			if(businessInfo!=null && businessInfo.getBuyer()==userId) {
				paymentList = businessInfoService.getBusinessPayList(id, 1);
	
/*				List list1 = bqyUserId!=0?costService.getCostInfo(bqyUserId, id):null;
				list2= new ArrayList();
				for( int index = 0;index<list1.size();index++) {
					Object o1[]=(Object [])list1.get(index);
					Object oNew[]= new Object[3];
					oNew[0]=o1[0];
					oNew[1]=o1[1];
					oNew[2]=null;
					TAppBusinessCost t1 = (TAppBusinessCost) o1[0];
					for(int index1=0;index1<list.size();index1++) {
						Object lo1[]=(Object [])list.get(index1);
						TAppCostInfo lt1=(TAppCostInfo)lo1[0];
						if(t1.getBcostId() == lt1.getId()) {
							oNew[2]=lt1;
							list.remove(index1);
							break;
						}
					}
					list2.add(oNew);
				}*/
				//request.setAttribute("costInfoList", list);
//				List<TAppUploadFile> fileList = businessInfoService.getBusinessFile(id);
//				request.setAttribute("fileList", fileList);
			}
		}
//		int size = 0;
//		if(paymentList != null) {
//			size = paymentList.size();
//		}
//		request.setAttribute("paymentListSize", size);
//		request.setAttribute("costInfoList", list2);//已经下单的用户职业列表
		
		
		
		
		request.setAttribute("choucheng", choucheng);
		return "preOrder";
	}
	
	
	// 打开下单页面（包括编辑订单时显示已有订单信息）
	public String toOrder(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int bqyUserId=request.getParameter("bqyUserId")==null?0:Integer.parseInt(request.getParameter("bqyUserId"));
		List list=bqyUserId!=0?costService.getCostInfo(bqyUserId, 0):null;
		List list2=null;//已经下单的 职业列表
		request.setAttribute("bqyUserId", bqyUserId);
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		if(id!=0){
			businessInfo=businessInfoService.getBusinessInfoById(id);
			if(businessInfo!=null && businessInfo.getBuyer()==userId) {
				paymentList = businessInfoService.getBusinessPayList(id, 1);
	
				List list1 = bqyUserId!=0?costService.getCostInfo(bqyUserId, id):null;
				list2= new ArrayList();
				for( int index = 0;index<list1.size();index++) {
					Object o1[]=(Object [])list1.get(index);
					Object oNew[]= new Object[3];
					oNew[0]=o1[0];
					oNew[1]=o1[1];
					oNew[2]=null;
					TAppBusinessCost t1 = (TAppBusinessCost) o1[0];
					for(int index1=0;index1<list.size();index1++) {
						Object lo1[]=(Object [])list.get(index1);
						TAppCostInfo lt1=(TAppCostInfo)lo1[0];
						if(t1.getBcostId() == lt1.getId()) {
							oNew[2]=lt1;
							list.remove(index1);
							break;
						}
					}
					list2.add(oNew);
				}
				//request.setAttribute("costInfoList", list);
				List<TAppUploadFile> fileList = businessInfoService.getBusinessFile(id);
				request.setAttribute("fileList", fileList);
			}
		}
		int size = 0;
		if(paymentList != null) {
			size = paymentList.size();
		}
		request.setAttribute("paymentListSize", size);
		request.setAttribute("talentList", list);//当前用户的 职业列表
		request.setAttribute("costInfoList", list2);//已经下单的用户职业列表
		TAppUserInfo userInfo = businessInfoService.getUserInfoById(bqyUserId);
		
		if(userInfo != null) {
			request.setAttribute("shangjia", userInfo.getNickName());
		}
		
		request.setAttribute("choucheng", choucheng);
		
		return "toOrder";
	}
	
	//检查被签约者是否添加职业
	public void checkUserCost() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int bqyUserId=request.getParameter("bqyUserId")==null?0:Integer.parseInt(request.getParameter("bqyUserId"));
		int success = businessInfoService.checkUserCost(bqyUserId);
		
		if(success != 1) {
			try {
				response.getWriter().print(success);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//订单提交(为了订单单号的唯一性，此方法使用方法锁，只能单线程执行此方法）
    public synchronized void orderSubmit(){
    	HttpServletRequest request=ServletActionContext.getRequest();
    	HttpServletResponse response=ServletActionContext.getResponse();
		int userId=HttpSessionHelper.getUserSession(request).getId();
//		int sellId =Integer.parseInt(request.getParameter("businessInfo.seller"));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
//		businessInfo  = new TAppBusinessInfo();
    	businessInfo.setBuyer(userId);
//    	businessInfo.setSeller(sellId);
    	businessInfo.setCreateTime(new Date());
    	businessInfo.setStatus(1);	//待接受
    	businessInfo.setOrderCode(businessInfoService.getNewContractNo(createDateTime, 1));	//订单编号
    	businessInfo.setBuyerRate(1);
    	businessInfo.setSellerRate(1);
    	businessInfo.setReceipt(1);
    	businessInfo.setUpdatePayTimeCount(0);
    	businessInfo.setUpdatePayTimeStatus(0);
//    	businessInfo.setContent(request.getParameter("businessInfo.content"));
    	logger.info("businessInfoAction:address= "+businessInfo.getAddress());
    	TAppMessage message = new TAppMessage();
    	message.setCreatTime(createDateTime);
    	message.setTitle("您有一个新的订单");
    	message.setFromUserId(userId);
    	message.setToUserId(businessInfo.getSeller());
    	message.setContent("您有一个新的订单，请到我是卖家>>待确认列表中查看。");
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(2);
		messageService.addMessage(message);

//    	logger.info("businessInfoAction:add message= "+message.getTitle());
    	
    	//被签约用户所属企业用户id,0表示无上级企业用户
    	businessInfo.setSellerCompany(businessInfoService.getBqyUserOfOrgUserId(businessInfo.getSeller()));	
     	businessInfoService.addOrEditBusinessInfo(businessInfo);
     	
     	List<TAppBusinessCost> newCostList = new ArrayList<TAppBusinessCost>();
     	for (int i = 0; i < costList.size(); i++) {
			TAppBusinessCost cost = costList.get(i);
			if(StringUtils.isNotBlank(cost.getPrice()) && cost.getDays()>0) {
				newCostList.add(cost);
			}
		}

     	
//    	logger.info("businessInfoAction:add costList ");
     	for (int i = 0; i < newCostList.size(); i++) {
     		TAppBusinessCost cost = newCostList.get(i);
     		cost.setOrderId(businessInfo.getId());
			
			businessInfoService.addOrEditBusinessCost(cost);
		}

//    	logger.info("businessInfoAction:addOrEditBusinessCost ");
     	if(businessInfo.getIsByStages()!=null &&  businessInfo.getIsByStages()== 2) {
	     	List<TAppBusinessPay> newPaymentList = new ArrayList<TAppBusinessPay>();
	     	for (int i = 0; i < paymentList.size(); i++) {
				TAppBusinessPay pay = paymentList.get(i);
				if(!pay.getPayRatio().equals("")) {
					newPaymentList.add(pay);
				}
			}
	     	
	     	double price = 0;
	     	for (int i = 0; i < newPaymentList.size(); i++) {
				TAppBusinessPay pay = newPaymentList.get(i);
				pay.setOrderId(businessInfo.getId());
				double payment = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), Double.parseDouble(pay.getPayRatio()), "*", 2);
				payment = DateFormatUtil.calValue(payment, 100, "/", 2);
				price = DateFormatUtil.calValue(price, payment, "+", 2);
					
				pay.setPrice(payment + "");
				
				double payment1 = DateFormatUtil.calValue(payment, choucheng, "*", 2);
				payment1 = DateFormatUtil.calValue(payment1, 100, "/", 2);
				payment1 = DateFormatUtil.calValue(payment, payment1, "-", 2);
				
				pay.setPrice1(payment1 + "");
				if(i == newPaymentList.size() - 1) {
					if(price != Double.parseDouble(businessInfo.getPrice())) {
						double value1 = DateFormatUtil.calValue(price, Double.parseDouble(pay.getPrice()), "-", 2);
						value1 = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), value1, "-", 2);
						pay.setPrice(value1 + "");
						
						double value2 = DateFormatUtil.calValue(value1, choucheng, "*", 2);
						value2 = DateFormatUtil.calValue(value2, 100, "/", 2);
						value2 = DateFormatUtil.calValue(value1, value2, "-", 2);
						
						pay.setPrice1(value2 + "");
					}
				}
				pay.setPos(i + 1);
				pay.setIsPay(1);
				pay.setIsPayment(1);
				pay.setConfrimPay(1);
				
				businessInfoService.addOrEditBusinessPay(pay);
			}
     	} else {
//        	logger.info("businessInfoAction: 111 ");
     		TAppBusinessPay pay = new TAppBusinessPay();
     		pay.setOrderId(businessInfo.getId());
     		pay.setPrice(businessInfo.getPrice());
     		double payment = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), choucheng, "*", 2);
     		payment = DateFormatUtil.calValue(payment, 100, "/", 2);
     		payment = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), payment, "-", 2);
				
     		pay.setPrice1(payment + "");
     		pay.setPayRatio("100");
     		try {
				pay.setPaymentTime(df.parse(businessInfo.getBeginDate() + " 00:00:00"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
     		pay.setPos(1);
			pay.setIsPay(1);
			pay.setIsPayment(1);
			pay.setConfrimPay(1);

//        	logger.info("businessInfoAction: 222 ");
			businessInfoService.addOrEditBusinessPay(pay);
     	}

    	logger.info("businessInfoAction: id= "+businessInfo.getId());
     	try {
     		response.setContentType("text/text");
//            response.setCharacterEncoding("UTF-8");
			response.getWriter().print(businessInfo.getId());
		} catch (IOException e) {

        	logger.info("businessInfoAction error: "+e.getMessage());
			e.printStackTrace();
		}
	}
    
	//再次交易，订单关闭后生成一张新的订单
    public synchronized void alignAddOrder(){
    	HttpServletRequest request=ServletActionContext.getRequest();
    	HttpServletResponse response=ServletActionContext.getResponse();

		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		TAppBusinessInfo business=businessInfoService.getBusinessInfoById(id);
		
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		business.setCreateTime(new Date());
		business.setStatus(1);	//待接受
		business.setOrderCode(businessInfoService.getNewContractNo(createDateTime, 1));	//订单编号
		business.setBuyerRate(1);
		business.setSellerRate(1);
		business.setReceipt(1);
		business.setUpdatePayTimeCount(0);
		business.setUpdatePayTimeStatus(0);
		business.setCreateTime2(null);
		business.setCreateTime3(null);
		business.setCreateTime4(null);
		business.setCreateTime5(null);
		business.setCreateTime6(null);
		business.setCreateTime7(null);
		business.setCreateTime8(null);
		business.setCreateTime9(null);
		business.setDrawbackStatus(null);
		business.setUpdatePayTimeCount(0);
		business.setUpdatePayTimeStatus(0);
		
    	TAppMessage message = new TAppMessage();
    	message.setCreatTime(createDateTime);
    	message.setTitle("您有一个新的订单");
    	message.setFromUserId(business.getBuyer());
    	message.setToUserId(business.getSeller());
    	message.setContent("您有一个新的订单，请到我的交易>>被签约者列表中查看。");
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(2);
		messageService.addMessage(message);
    	
     	businessInfoService.addBusinessInfo(business);
     	
		paymentList = businessInfoService.getBusinessPayList(id, 1);
		for (int i = 0; i < paymentList.size(); i++) {
			TAppBusinessPay pay = paymentList.get(i);
			pay.setOrderId(business.getId());
			pay.setActualPayTime(null);
			pay.setIsPay(1);
			pay.setPayTime(null);
			pay.setIsPayment(1);
			pay.setConfrimPay(1);
			pay.setUpdatePayTime(null);
			
			
			businessInfoService.addBusinessPay(pay);
		}
		
		costList = businessInfoService.getBusinessCost(id, 2);
		for (int i = 0; i < costList.size(); i++) {
     		TAppBusinessCost cost = costList.get(i);
     		cost.setOrderId(business.getId());
			
			businessInfoService.addBusinessCost(cost);
		}
		
		List<TAppUploadFile> fileList = businessInfoService.getBusinessFile(id);
		for (int i = 0; i < fileList.size(); i++) {
			TAppUploadFile file = fileList.get(i);
			file.setOrderId(business.getId());
			
			businessInfoService.addBusinessFile(file);
		}
     	
     	try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
    //打开上传附件页面
    public String toUploadFile(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		request.setAttribute("id", id);
		
		int type=request.getParameter("type")==null?2:Integer.parseInt(request.getParameter("type"));
		request.setAttribute("type", type);
		
		return "toUploadFile";
	}
    
    public void uploadFile() {
    	HttpServletRequest request = ServletActionContext.getRequest();
    	try {
    		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));

			String path = request.getSession().getServletContext().getRealPath("");
			path.lastIndexOf(System.getProperty("file.separator"));
			path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\orderFile\\";
			
			path = path.replace("\\", System.getProperty("file.separator"));
			
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			InputStream is = new FileInputStream(this.file);

			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String createTime=df.format(new Date());// new Date()为获取当前系统时间
			TAppUploadFile uploadFile = new TAppUploadFile();
    		uploadFile.setOrderId(id);
    		uploadFile.setAttachName(this.fileFileName);
    		uploadFile.setSize((int)this.file.length());
    		uploadFile.setUploadDate(new Date());
    		String suffix = this.fileFileName.substring(this.fileFileName.lastIndexOf(".") + 1, this.fileFileName.length());
    		uploadFile.setSuffix(suffix);
    		businessInfoService.addOrEditBusinessFile(uploadFile);
    		
			String newFileName = uploadFile.getId() + "." + suffix;

			File deskFile = new File(path, newFileName);
			OutputStream os = new FileOutputStream(deskFile);
			byte[] bytefer = new byte[400];
			int length = 0;
			while ((length = is.read(bytefer)) > 0) {
				os.write(bytefer, 0, length);
			}
			//System.out.println(newFileName + "文件的大小为：" + deskFile.length());
			os.close();
			is.close();
			// return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    public  void uploadFile1 ()throws IOException{
    	try {
    		userService.doAddMessage();
    		
    		
//    		String fileName = "D:\\click.xls"; // Excel文件所在路径  
//            File file = new File(fileName); // 创建文件对象  
//            Workbook wb = Workbook.getWorkbook(file); // 从文件流中获取Excel工作区对象（WorkBook）  
//            Sheet sheet = wb.getSheet(0); // 从工作区中取得页（Sheet）  
//              
//            for (int i = 0; i < sheet.getRows(); i++) { // 循环打印Excel表中的内容  
//            	 TAppUserInfo userInfo = null; 
//            	if (i==0) {
//					continue;
//				}
//                for (int j = 0; j < sheet.getColumns(); j++) {  
//                    Cell cell = sheet.getCell(j, i);  
//                   
//                    if (j==0) {
//                    	userInfo = userInfoService.findUserInfoByNickName(cell.getContents());
//					}
//                    if (userInfo!=null) {
//                    	  if (j==1) {
//      						userInfo.setPopularityTotal(cell.getContents());
//      					}
//                          if (j==3) {
//      						userInfo.setSignNumber(Integer.parseInt(cell.getContents()));
//      					}
//                          if (j==4) {
//                        	  userInfo.setSignAmount(cell.getContents());
//      					}
//					}
//                  
////                    System.out.println(cell.getContents());  
//                }  
////                System.out.println();  
//                if (userInfo!=null) {
//                	 userInfoService.saveUserInfo(userInfo);
//				}
//            }  

		} catch (Exception e) {
			// TODO: handle exception
		}
    	
    }

    
    
	// 我是老板交易列表
	public String myBuyerList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int type=request.getParameter("type")==null?0:Integer.parseInt(request.getParameter("type"));
		String costName=request.getParameter("costName")==null?"":request.getParameter("costName");
		
		int total = businessInfoService.getTotal(userId, rowCount, 1, type, costName);
		pageNum=pageNum>total?total:pageNum;
		
		//评价生效检查
		//检查评价是否过期
		List<TAppBusinessInfo> buInfoList = businessInfoService.getBusinessInfoByQyUserId(userId);
		for (int i = 0; i < buInfoList.size(); i++) {
			TAppBusinessInfo bi = null;
			bi = buInfoList.get(i);
			int status = bi.getStatus();
			if(status>=6){
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime=sd.format(new Date());// new Date()为获取当前系统时间
				long day = 0;
				String finishTime = "";
				if (bi.getCreateTime6()!=null) {
					 finishTime = sd.format(bi.getCreateTime6());
					day = businessInfoService.getDateDifference(finishTime,nowTime);
				}
				if(day>14){//交易成功15天后的评价结束
					
					
//					TAppMessage message = new TAppMessage();
//			    	message.setCreatTime(nowTime);
//			    	message.setTitle("您的订单已被评价");
//			    	message.setFromUserId(userId);
//			    	message.setToUserId(bi.getQyUserId());
//			    	message.setContent("您的订单已被评价，请到评价管理查看。");
//			    	message.setStatus("0");	//发送短信后默认为未读
//			    	message.setType(3);
//					messageService.addMessage(message);
//					TAppMessage message1 = new TAppMessage();
//			    	message1.setCreatTime(nowTime);
//			    	message1.setTitle("您的订单已被评价");
//			    	message1.setFromUserId(userId);
//			    	message1.setToUserId(bi.getBqyUserId());
//			    	message1.setContent("您的订单已被评价，请到评价管理查看。");
//			    	message1.setStatus("0");	//发送短信后默认为未读
//			    	message1.setType(3);
//					messageService.addMessage(message1);
//					TAppMessage message2 = new TAppMessage();
//			    	message2.setCreatTime(nowTime);
//			    	message2.setTitle("您的订单已被评价");
//			    	message2.setFromUserId(userId);
//			    	message2.setToUserId(bi.getOrgUserId());
//			    	message2.setContent("您的订单已被评价，请到评价管理查看。");
//			    	message2.setStatus("0");	//发送短信后默认为未读
//			    	message2.setType(3);
//					messageService.addMessage(message2);
					//系统默认评价
					int evaluateFlag = businessInfoService.isEvaluateFlag(bi.getBuyer(),bi.getSeller(),bi.getId());
					if(evaluateFlag==0){//双方未评
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
						evaluate.setCreatId(bi.getBuyer());
						evaluate.setCreatTime(createDateTime);
						evaluate.setBusinessId(bi.getId());
						evaluate.setPjContent("系统自动评价");
						evaluate.setMsGrade("3");
						evaluate.setTdGrade("3");
						evaluate.setZlGrade("3");
						evaluate.setPjGrade("1");
						
						//每个自然月中（30天），相同买卖家之间的评价不得超过五个好评或差评
						int Count = businessInfoService.getDatecount(30,1,userId,bi.getSeller(),bi.getSellerCompany());
						//10天内，相同买卖家之间同一“技能”计分不能超过三分
						int isBoth = businessInfoService.getBothBealoon(10,1,1,userId,bi.getSeller(),bi.getSellerCompany(),bi.getId());
						if(Count<5&&isBoth<3){
							
							if (bi.getSeller()!=bi.getSellerCompany()) {
								TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(bi.getSellerCompany());//获取企业评价总分对象
								userEvaluation.setSellerEvaluation(userEvaluation.getSellerEvaluation()+1);
								userEvaluationService.addOrEdituserEvaluation(userEvaluation);
								
								TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(bi.getSellerCompany());
								TAppUser user = userService.getUserById(bi.getSellerCompany());
								businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation.getSellerEvaluation(),1);//判断是否晋级
							}
							TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(bi.getSeller());//获取旗下个人评价总分对象
							userEvaluation1.setSellerEvaluation(userEvaluation1.getSellerEvaluation()+1);
							userEvaluationService.addOrEdituserEvaluation(userEvaluation1);
							
							TAppUserInfo userInfo1 = userInfoService.getUserInfoByUserId(bi.getSeller());
							TAppUser user1 = userService.getUserById(bi.getSeller());
							businessInfoService.upOrdowmLevel(user1.getIsOrg(),userInfo1,userEvaluation1.getSellerEvaluation(),1);//判断是否晋级
							
							TAppBusinessEvaluate evaluate1=new TAppBusinessEvaluate();
							evaluate1.setCreatId(bi.getSellerCompany());
							evaluate1.setCreatTime(createDateTime);
							evaluate1.setBusinessId(bi.getId());
							evaluate1.setPjContent("系统自动评价");
							evaluate1.setMsGrade("3");
							evaluate1.setTdGrade("3");
							evaluate1.setZlGrade("3");
							evaluate1.setPjGrade("1");
							businessEvaluateSerive.addOrEditEvaluate(evaluate1);
							
							TAppUserEvaluation userEvaluation3=userEvaluationService.getUserEvaluationById(bi.getSeller());//获取企业评价总分对象
							userEvaluation3.setEvaluation(userEvaluation3.getEvaluation()+1);
							userEvaluationService.addOrEdituserEvaluation(userEvaluation3);
							TAppUserInfo userInfo3 = userInfoService.getUserInfoByUserId(bi.getBuyer());
							TAppUser user3 = userService.getUserById(bi.getBuyer());
							businessInfoService.upOrdowmLevel(user3.getIsOrg(),userInfo3,userEvaluation3.getEvaluation(),2);//判断是否晋级
							
							userEvaluationService.saveGradeValue(evaluate, bi.getSeller());
						}else {
							evaluate.setPjContent(evaluate.getPjContent()+"<span style=\"color: #ffffff\">不计分</span>");
						}
						businessEvaluateSerive.addOrEditEvaluate(evaluate);
						
					}else if(evaluateFlag==1){
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate1=new TAppBusinessEvaluate();
						evaluate1.setCreatId(bi.getSellerCompany());
						evaluate1.setCreatTime(createDateTime);
						evaluate1.setBusinessId(bi.getId());
						evaluate1.setPjContent("系统自动评价");
						evaluate1.setMsGrade("3");
						evaluate1.setTdGrade("3");
						evaluate1.setZlGrade("3");
						evaluate1.setPjGrade("1");
						businessEvaluateSerive.addOrEditEvaluate(evaluate1);
						
						TAppUserEvaluation userEvaluation3=userEvaluationService.getUserEvaluationById(bi.getBuyer());//获取企业评价总分对象
						userEvaluation3.setEvaluation(userEvaluation3.getEvaluation()+1);
						userEvaluationService.addOrEdituserEvaluation(userEvaluation3);
						TAppUserInfo userInfo3 = userInfoService.getUserInfoByUserId(bi.getBuyer());
						TAppUser user3 = userService.getUserById(bi.getBuyer());
						businessInfoService.upOrdowmLevel(user3.getIsOrg(),userInfo3,userEvaluation3.getEvaluation(),2);//判断是否晋级
						
					}else if (evaluateFlag==2) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate1=new TAppBusinessEvaluate();
						evaluate1.setCreatId(bi.getSellerCompany());
						evaluate1.setCreatTime(createDateTime);
						evaluate1.setBusinessId(bi.getId());
						evaluate1.setPjContent("系统自动评价");
						evaluate1.setMsGrade("3");
						evaluate1.setTdGrade("3");
						evaluate1.setZlGrade("3");
						evaluate1.setPjGrade("0");
						businessEvaluateSerive.addOrEditEvaluate(evaluate1);
					}else if (evaluateFlag==3) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
						evaluate.setCreatId(bi.getBuyer());
						evaluate.setCreatTime(createDateTime);
						evaluate.setBusinessId(bi.getId());
						evaluate.setPjContent("系统自动评价");
						evaluate.setMsGrade("3");
						evaluate.setTdGrade("3");
						evaluate.setZlGrade("3");
						evaluate.setPjGrade("1");
						businessEvaluateSerive.addOrEditEvaluate(evaluate);
						if (bi.getSeller()!=bi.getSellerCompany()) {
							TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(bi.getSellerCompany());//获取企业评价总分对象
							userEvaluation.setSellerEvaluation(userEvaluation.getSellerEvaluation()+1);
							userEvaluationService.addOrEdituserEvaluation(userEvaluation);
							
							TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(bi.getSellerCompany());
							TAppUser user = userService.getUserById(bi.getSellerCompany());
							businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation.getSellerEvaluation(),1);//判断是否晋级
						}
						TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(bi.getSeller());//获取旗下个人评价总分对象
						userEvaluation1.setSellerEvaluation(userEvaluation1.getSellerEvaluation()+1);
						userEvaluationService.addOrEdituserEvaluation(userEvaluation1);
						
						TAppUserInfo userInfo1 = userInfoService.getUserInfoByUserId(bi.getSeller());
						TAppUser user1 = userService.getUserById(bi.getSeller());
						businessInfoService.upOrdowmLevel(user1.getIsOrg(),userInfo1,userEvaluation1.getSellerEvaluation(),1);//判断是否晋级
						userEvaluationService.saveGradeValue(evaluate, bi.getSeller());
					}else if (evaluateFlag==4) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
						evaluate.setCreatId(bi.getBuyer());
						evaluate.setCreatTime(createDateTime);
						evaluate.setBusinessId(bi.getId());
						evaluate.setPjContent("系统自动评价");
						evaluate.setMsGrade("3");
						evaluate.setTdGrade("3");
						evaluate.setZlGrade("3");
						evaluate.setPjGrade("0");
						businessEvaluateSerive.addOrEditEvaluate(evaluate);
					}
					bi.setSellerRate(2);
					bi.setBuyerRate(2);
					businessInfoService.addOrEditBusinessInfo(bi);
				}
			}
			
		}
		
		List businessInfoList=businessInfoService.getMyBusiness(userId, (pageNum-1)*rowCount, rowCount, 1, type, costName);
		
		List list = new ArrayList();
		
		for (int i = 0; i < businessInfoList.size(); i++) {
			TAppBusinessInfo businessInfo = (TAppBusinessInfo) businessInfoList.get(i);
			Map map = new HashMap();
			map.put("business", businessInfo);
			
			TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
			map.put("userInfo", userInfo);

			//paymentList = businessInfoService.getBusinessPayList(businessInfo.getId(), 1);
			//map.put("paymentList", paymentList);
			
			costList = businessInfoService.getBusinessCost(businessInfo.getId(), 1);
			map.put("costList", costList);
			
			TAppUser user = userService.findUserById(businessInfo.getSeller());
			map.put("user", user);

			if(businessInfo.getStatus() == 6 ||businessInfo.getStatus()==10) {
				//目前只支持 线下支付，如果 用户确认已付款 和 交易成功 则 显示 订单价格 
				map.put("payment", businessInfo.getPrice());
			} else {
				double payment = drawbackInfoService.getReturnPrice(businessInfo.getId(), 2);
				map.put("payment", payment);				
			}
			
			list.add(map);
		}
		
		int waitCount = businessInfoService.getCount(userId, 1);
		request.setAttribute("waitCount", waitCount);
		int confirmCount = businessInfoService.getCount(userId, 2);
		request.setAttribute("confirmCount", confirmCount);
		int rateCount = businessInfoService.getCount(userId, 3);
		request.setAttribute("rateCount", rateCount);

		request.setAttribute("costName", costName);
		List<TAppBusinessEvaluate> infoToEvaluateList = businessEvaluateSerive.getInfoToEvaluate(userId);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("businessInfoList", list);
		request.setAttribute("infoToEvaluateList", infoToEvaluateList);
		
//		request.setAttribute("qianyue", businessInfoService.getTotalByUserId(userId, 2));
//
//		request.setAttribute("beiqianyue", businessInfoService.getTotalByUserId(userId, 3));
		
		return "myBuyerList";
	}
	
    
	// 我是艺人交易列表
	public String mySellerList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int type=request.getParameter("type")==null?0:Integer.parseInt(request.getParameter("type"));
		String costName=request.getParameter("costName")==null?"":request.getParameter("costName");
		
		int total = businessInfoService.getTotal(userId, rowCount, 2, type, costName);
		pageNum=pageNum>total?total:pageNum;
		
		//评价生效检查
		//检查评价是否过期
		List<TAppBusinessInfo> buInfoList = businessInfoService.getBusinessInfoByQyUserId(userId);
		for (int i = 0; i < buInfoList.size(); i++) {
			TAppBusinessInfo bi = null;
			bi = buInfoList.get(i);
			int status = bi.getStatus();
			if(status>=6){
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime=sd.format(new Date());// new Date()为获取当前系统时间
				long day = 0;
				String finishTime = "";
				if (bi.getCreateTime6()!=null) {
					 finishTime = sd.format(bi.getCreateTime6());
					day = businessInfoService.getDateDifference(finishTime,nowTime);
				}
				if(day>14){//交易成功15天后的评价结束
					//bi.setStatus(12);
					bi.setBuyerRate(2);
					bi.setSellerRate(2);
					businessInfoService.addOrEditBusinessInfo(bi);
					
//					TAppMessage message = new TAppMessage();
//			    	message.setCreatTime(nowTime);
//			    	message.setTitle("您的订单已被评价");
//			    	message.setFromUserId(userId);
//			    	message.setToUserId(bi.getQyUserId());
//			    	message.setContent("您的订单已被评价，请到评价管理查看。");
//			    	message.setStatus("0");	//发送短信后默认为未读
//			    	message.setType(3);
//					messageService.addMessage(message);
//					TAppMessage message1 = new TAppMessage();
//			    	message1.setCreatTime(nowTime);
//			    	message1.setTitle("您的订单已被评价");
//			    	message1.setFromUserId(userId);
//			    	message1.setToUserId(bi.getBqyUserId());
//			    	message1.setContent("您的订单已被评价，请到评价管理查看。");
//			    	message1.setStatus("0");	//发送短信后默认为未读
//			    	message1.setType(3);
//					messageService.addMessage(message1);
//					TAppMessage message2 = new TAppMessage();
//			    	message2.setCreatTime(nowTime);
//			    	message2.setTitle("您的订单已被评价");
//			    	message2.setFromUserId(userId);
//			    	message2.setToUserId(bi.getOrgUserId());
//			    	message2.setContent("您的订单已被评价，请到评价管理查看。");
//			    	message2.setStatus("0");	//发送短信后默认为未读
//			    	message2.setType(3);
//					messageService.addMessage(message2);
					//系统默认评价
					int evaluateFlag = businessInfoService.isEvaluateFlag(bi.getBuyer(),bi.getSeller(),bi.getId());
					if(evaluateFlag==0){//双方未评
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
						evaluate.setCreatId(bi.getBuyer());
						evaluate.setCreatTime(createDateTime);
						evaluate.setBusinessId(bi.getId());
						evaluate.setPjContent("系统自动评价");
						evaluate.setMsGrade("3");
						evaluate.setTdGrade("3");
						evaluate.setZlGrade("3");
						evaluate.setPjGrade("1");
						
						//每个自然月中（30天），相同买卖家之间的评价不得超过五个好评或差评
						int Count = businessInfoService.getDatecount(30,1,userId,bi.getSeller(),bi.getSellerCompany());
						//10天内，相同买卖家之间同一“技能”计分不能超过三分
						int isBoth = businessInfoService.getBothBealoon(10,2,1,userId,bi.getSeller(),bi.getSellerCompany(),bi.getId());
						if(Count<5&&isBoth<3){
							
							
							TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(bi.getSellerCompany());//获取企业评价总分对象
							userEvaluation.setEvaluation(userEvaluation.getEvaluation()+1);
							userEvaluationService.addOrEdituserEvaluation(userEvaluation);
							
							TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(bi.getSellerCompany());
							TAppUser user = userService.getUserById(bi.getSellerCompany());
							businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation.getEvaluation(),2);//判断是否晋级
							
							TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(bi.getSeller());//获取旗下个人评价总分对象
							userEvaluation1.setEvaluation(userEvaluation1.getEvaluation()+1);
							userEvaluationService.addOrEdituserEvaluation(userEvaluation1);
							
							TAppUserInfo userInfo1 = userInfoService.getUserInfoByUserId(bi.getSeller());
							TAppUser user1 = userService.getUserById(bi.getSeller());
							businessInfoService.upOrdowmLevel(user1.getIsOrg(),userInfo1,userEvaluation1.getEvaluation(),2);//判断是否晋级
							
							TAppBusinessEvaluate evaluate1=new TAppBusinessEvaluate();
							evaluate1.setCreatId(bi.getSellerCompany());
							evaluate1.setCreatTime(createDateTime);
							evaluate1.setBusinessId(bi.getId());
							evaluate1.setPjContent("系统自动评价");
							evaluate1.setMsGrade("3");
							evaluate1.setTdGrade("3");
							evaluate1.setZlGrade("3");
							evaluate1.setPjGrade("1");
							businessEvaluateSerive.addOrEditEvaluate(evaluate1);
							if (bi.getSeller()!=bi.getSellerCompany()) {
								TAppUserEvaluation userEvaluation3=userEvaluationService.getUserEvaluationById(bi.getSeller());//获取企业评价总分对象
								userEvaluation3.setEvaluation(userEvaluation3.getEvaluation()+1);
								userEvaluationService.addOrEdituserEvaluation(userEvaluation3);
								TAppUserInfo userInfo3 = userInfoService.getUserInfoByUserId(bi.getBuyer());
								TAppUser user3 = userService.getUserById(bi.getBuyer());
								businessInfoService.upOrdowmLevel(user3.getIsOrg(),userInfo3,userEvaluation3.getEvaluation(),2);//判断是否晋级
							}
							userEvaluationService.saveGradeValue(evaluate, bi.getSeller());
						}else {
							evaluate.setPjContent(evaluate.getPjContent()+"<span style=\"color: #ffffff\">不计分</span>");
						}
						businessEvaluateSerive.addOrEditEvaluate(evaluate);
						
					}else if(evaluateFlag==1){
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate1=new TAppBusinessEvaluate();
						evaluate1.setCreatId(bi.getSellerCompany());
						evaluate1.setCreatTime(createDateTime);
						evaluate1.setBusinessId(bi.getId());
						evaluate1.setPjContent("系统自动评价");
						evaluate1.setMsGrade("3");
						evaluate1.setTdGrade("3");
						evaluate1.setZlGrade("3");
						evaluate1.setPjGrade("1");
						businessEvaluateSerive.addOrEditEvaluate(evaluate1);
						
						TAppUserEvaluation userEvaluation3=userEvaluationService.getUserEvaluationById(bi.getBuyer());//获取企业评价总分对象
						userEvaluation3.setEvaluation(userEvaluation3.getEvaluation()+1);
						userEvaluationService.addOrEdituserEvaluation(userEvaluation3);
						TAppUserInfo userInfo3 = userInfoService.getUserInfoByUserId(bi.getBuyer());
						TAppUser user3 = userService.getUserById(bi.getBuyer());
						businessInfoService.upOrdowmLevel(user3.getIsOrg(),userInfo3,userEvaluation3.getEvaluation(),2);//判断是否晋级
						
					}else if (evaluateFlag==2) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate1=new TAppBusinessEvaluate();
						evaluate1.setCreatId(bi.getSellerCompany());
						evaluate1.setCreatTime(createDateTime);
						evaluate1.setBusinessId(bi.getId());
						evaluate1.setPjContent("系统自动评价");
						evaluate1.setMsGrade("3");
						evaluate1.setTdGrade("3");
						evaluate1.setZlGrade("3");
						evaluate1.setPjGrade("0");
						businessEvaluateSerive.addOrEditEvaluate(evaluate1);
					}else if (evaluateFlag==3) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
						evaluate.setCreatId(bi.getBuyer());
						evaluate.setCreatTime(createDateTime);
						evaluate.setBusinessId(bi.getId());
						evaluate.setPjContent("系统自动评价");
						evaluate.setMsGrade("3");
						evaluate.setTdGrade("3");
						evaluate.setZlGrade("3");
						evaluate.setPjGrade("1");
						businessEvaluateSerive.addOrEditEvaluate(evaluate);
						if (bi.getSeller()!=bi.getSellerCompany()) {
							TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(bi.getSellerCompany());//获取企业评价总分对象
							userEvaluation.setEvaluation(userEvaluation.getEvaluation()+1);
							userEvaluationService.addOrEdituserEvaluation(userEvaluation);
							
							TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(bi.getSellerCompany());
							TAppUser user = userService.getUserById(bi.getSellerCompany());
							businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation.getEvaluation(),2);//判断是否晋级
						}
						TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(bi.getSeller());//获取旗下个人评价总分对象
						userEvaluation1.setEvaluation(userEvaluation1.getEvaluation()+1);
						userEvaluationService.addOrEdituserEvaluation(userEvaluation1);
						
						TAppUserInfo userInfo1 = userInfoService.getUserInfoByUserId(bi.getSeller());
						TAppUser user1 = userService.getUserById(bi.getSeller());
						businessInfoService.upOrdowmLevel(user1.getIsOrg(),userInfo1,userEvaluation1.getEvaluation(),2);//判断是否晋级
						userEvaluationService.saveGradeValue(evaluate, bi.getSeller());
					}else if (evaluateFlag==4) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
						evaluate.setCreatId(bi.getBuyer());
						evaluate.setCreatTime(createDateTime);
						evaluate.setBusinessId(bi.getId());
						evaluate.setPjContent("系统自动评价");
						evaluate.setMsGrade("3");
						evaluate.setTdGrade("3");
						evaluate.setZlGrade("3");
						evaluate.setPjGrade("0");
						businessEvaluateSerive.addOrEditEvaluate(evaluate);
					}
				}
			}
			
		}
		
		List businessInfoList=businessInfoService.getMyBusiness(userId, (pageNum-1)*rowCount, rowCount, 2, type, costName);
		
		List list = new ArrayList();
		
		for (int i = 0; i < businessInfoList.size(); i++) {
			TAppBusinessInfo businessInfo = (TAppBusinessInfo) businessInfoList.get(i);
			Map map = new HashMap();
			map.put("business", businessInfo);
			
			TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
			map.put("userInfo", userInfo);
			
			TAppUserInfo userInfo1 = businessInfoService.getUserInfoById(businessInfo.getBuyer());
			map.put("userInfo1", userInfo1);

			//paymentList = businessInfoService.getBusinessPayList(businessInfo.getId(), 1);
			//map.put("paymentList", paymentList);
			
			costList = businessInfoService.getBusinessCost(businessInfo.getId(), 1);
			map.put("costList", costList);
			
			TAppUser user = userService.findUserById(businessInfo.getSeller());
			map.put("user", user);

			if(businessInfo.getStatus() == 6 ||businessInfo.getStatus()==10) {
				//目前只支持 线下支付，如果 用户确认已付款 和 交易成功 则 显示 订单价格 
				map.put("payment", businessInfo.getPrice());
			} else {
				double payment = drawbackInfoService.getReturnPrice(businessInfo.getId(), 3);
				map.put("payment", payment);				
			}
			
			list.add(map);
		}
		
		
		int confirmCount = businessInfoService.getCount(userId, 4);
		request.setAttribute("confirmCount", confirmCount);
		int waitCount = businessInfoService.getCount(userId, 7);
		request.setAttribute("waitCount", waitCount);
		int payCount = businessInfoService.getCount(userId, 5);
		request.setAttribute("payCount", payCount);
		int rateCount = businessInfoService.getCount(userId, 6);
		request.setAttribute("rateCount", rateCount);
		
		List<TAppBusinessEvaluate> infoToEvaluateList = businessEvaluateSerive.getInfoToEvaluate(userId);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("costName", costName);
		request.setAttribute("businessInfoList", list);
		request.setAttribute("infoToEvaluateList", infoToEvaluateList);
		
//		request.setAttribute("qianyue", businessInfoService.getTotalByUserId(userId, 2));
//
//		request.setAttribute("beiqianyue", businessInfoService.getTotalByUserId(userId, 3));
		
		return "mySellerList";
	}
	
    //交易在接受之前允许修改（后台）
    public void updateBusinessInfo(){
    	HttpServletRequest request=ServletActionContext.getRequest();
    	HttpServletResponse response=ServletActionContext.getResponse();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		
    	businessInfoService.addOrEditBusinessInfo(businessInfo);

    	businessInfoService.delForSql("delete from TAppBusinessCost where orderId=" + businessInfo.getId());
    	List<TAppBusinessCost> newCostList = new ArrayList<TAppBusinessCost>();
     	for (int i = 0; i < costList.size(); i++) {
			TAppBusinessCost cost = costList.get(i);
			if(!cost.getPrice().equals("") && cost.getDays()>0) {
				newCostList.add(cost);
			}
		}
     	
     	for (int i = 0; i < newCostList.size(); i++) {
     		TAppBusinessCost cost = newCostList.get(i);
     		cost.setOrderId(businessInfo.getId());
			
			businessInfoService.addOrEditBusinessCost(cost);
		}
     	

    	businessInfoService.delForSql("delete from TAppBusinessPay where orderId=" + businessInfo.getId());
    	if(businessInfo.getIsByStages() == 2) {
	     	List<TAppBusinessPay> newPaymentList = new ArrayList<TAppBusinessPay>();
	     	for (int i = 0; i < paymentList.size(); i++) {
				TAppBusinessPay pay = paymentList.get(i);
				if(!pay.getPayRatio().equals("")) {
					newPaymentList.add(pay);
				}
			}
	     	
	     	double price = 0;
	     	for (int i = 0; i < newPaymentList.size(); i++) {
				TAppBusinessPay pay = newPaymentList.get(i);
				pay.setOrderId(businessInfo.getId());
				double payment = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), Double.parseDouble(pay.getPayRatio()), "*", 2);
				payment = DateFormatUtil.calValue(payment, 100, "/", 2);
				price = DateFormatUtil.calValue(price, payment, "+", 2);
					
				pay.setPrice(payment + "");
				
				double payment1 = DateFormatUtil.calValue(payment, choucheng, "*", 2);
				payment1 = DateFormatUtil.calValue(payment1, 100, "/", 2);
				payment1 = DateFormatUtil.calValue(payment, payment1, "-", 2);
				
				pay.setPrice1(payment1 + "");
				if(i == newPaymentList.size() - 1) {
					if(price != Double.parseDouble(businessInfo.getPrice())) {
						double value1 = DateFormatUtil.calValue(price, Double.parseDouble(pay.getPrice()), "-", 2);
						value1 = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), value1, "-", 2);
						pay.setPrice(value1 + "");
						
						double value2 = DateFormatUtil.calValue(value1, choucheng, "*", 2);
						value2 = DateFormatUtil.calValue(value2, 100, "/", 2);
						value2 = DateFormatUtil.calValue(value1, value2, "-", 2);
						
						pay.setPrice1(value2 + "");
					}
				}
				pay.setPos(i + 1);
				pay.setIsPay(1);
				pay.setIsPayment(1);
				pay.setConfrimPay(1);
				
				businessInfoService.addOrEditBusinessPay(pay);
			}
    	} else {
    		TAppBusinessPay pay = new TAppBusinessPay();
     		pay.setOrderId(businessInfo.getId());
     		pay.setPrice(businessInfo.getPrice());
     		double payment = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), choucheng, "*", 2);
     		payment = DateFormatUtil.calValue(payment, 100, "/", 2);
     		payment = DateFormatUtil.calValue(Double.parseDouble(businessInfo.getPrice()), payment, "-", 2);
				
     		pay.setPrice1(payment + "");
     		pay.setPayRatio("100");
     		try {
				pay.setPaymentTime(df.parse(businessInfo.getBeginDate() + " 00:00:00"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
     		pay.setPos(1);
			pay.setIsPay(1);
			pay.setIsPayment(1);
			pay.setConfrimPay(1);
			
			businessInfoService.addOrEditBusinessPay(pay);
    	}
     	
     	try {
     		response.setContentType("text/text");
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
    }
	
	//后台我的交易提交后的显示信息
	public String toBusinessView(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		businessInfo=businessInfoService.getBusinessInfoById(id);
		paymentList = businessInfoService.getBusinessPayList(id, 1);
		costList = businessInfoService.getBusinessCost(id, 1);
		
		List<TAppUploadFile> fileList = businessInfoService.getBusinessFile(id);
		
		TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
		if(userInfo != null) {
			request.setAttribute("shangjia", userInfo.getNickName());

		}
		request.setAttribute("choucheng", choucheng);
		request.setAttribute("fileList", fileList);
		
		int userId=HttpSessionHelper.getUserSession(request).getId();
		request.setAttribute("loginUserId", userId);
		return "toBusinessView";
	}
	
	//接受，付款，确认，关闭一系列更改状态的方法
    public void updateBusinessInfoStatus(){
    	HttpServletRequest request=ServletActionContext.getRequest();
    	HttpServletResponse response=ServletActionContext.getResponse();
    	int userId = HttpSessionHelper.getUserSession(request).getId();
    	
    	int id = 0;
    	TAppBusinessInfo business = null;
    	
    	String orderNo = "";
    	String orderNo1 = "";
    	int payPos = 0;
    	try {
			id = Integer.parseInt(request.getParameter("id"));
			business = businessInfoService.getBusinessInfoById(id);
		} catch (NumberFormatException e1) {
			orderNo = request.getParameter("id");
			//支付宝回调时使用，orderNo格式为订单号+订单分期付款的序号（pos），
			//如20130926000001001 代表支付的是订单号为20130926000001的订单的第一条分期记录
			//如果订单不是分期付款的，这里是20130926000001000
			orderNo1 = orderNo.substring(0, orderNo.length() - 3);
			business = businessInfoService.getBusinessInfoByNo(orderNo1);
			
			String posStr = orderNo.substring(orderNo.length() - 3, orderNo.length());
			payPos = Integer.parseInt(posStr);
		}
    	
    	int oldStatus = business.getStatus();
    	int status = Integer.parseInt(request.getParameter("status"));
    	int pos = 0;
		try {
			pos = Integer.parseInt(request.getParameter("pos"));
		} catch (NumberFormatException e1) {
			//e1.printStackTrace();
		}
    	
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		TAppMessage message = new TAppMessage();
    	message.setCreatTime(createDateTime);
    	
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(2);
    	
    	if(oldStatus != status) {
    		if(status == 2) {
    			if(oldStatus == 9) {//订单已关闭
    				try {
    	    			response.getWriter().print("1");
    	    			return;
    	    		} catch (IOException e) {
    	    			e.printStackTrace();
    	    		}
    			}
    			
    			message.setTitle("对方已接受您的订单");
            	message.setFromUserId(userId);
            	message.setToUserId(business.getBuyer());
            	message.setContent("对方已接受您的订单（" + business.getOrderCode() + "）。");            	
    			business.setStatus(status);
            	business.setCreateTime2(new Date());	
    		}
    		
    		if(status == 3) {//seller用户设定 任务已完成
				business.setStatus(status);				
				message.setTitle("任务已完成");
            	message.setFromUserId(userId);
            	message.setToUserId(business.getBuyer());
            	message.setContent("订单（" + business.getOrderCode() + "）任务已经完成。");
            	business.setCreateTime3(new Date());
    		}

    		if(status == 4) {//buyer用户设定 任务确认已完成
				business.setStatus(status);				
//				message.setTitle("任务已完成");
//            	message.setFromUserId(userId);
//            	message.setToUserId(business.getBuyer());
//            	message.setContent("订单（" + business.getOrderCode() + "）任务已经完成。");
            	business.setCreateTime4(new Date());
    		}

    		if(status == 6) {//seller用户设定 已收款
				business.setStatus(status);
//				message.setTitle("任务已完成");
//            	message.setFromUserId(userId);
//            	message.setToUserId(business.getBuyer());
//            	message.setContent("订单（" + business.getOrderCode() + "）任务已经完成。");
            	business.setCreateTime6(new Date());
    		}
    			//这个订单没有付款的记录条数
//    			int payCount = businessInfoService.getPayCount(business.getId(), 1);
    			
    			
//    			if(payCount == 1) {//只有一条没有付款的记录，订单状态改为已付款
//    				business.setStatus(4);
//    				
//    				message.setTitle("订单已经付款");
//                	message.setFromUserId(userId);
//                	message.setToUserId(business.getSeller());
//                	message.setContent("订单（" + business.getOrderCode() + "）已经付款，请按时间去演出。");
//    			} else if(payCount > 1) {//多于1条，订单状态为部分付款
//    				business.setStatus(3);
//    				
//    				message.setTitle("订单已经付款");
//                	message.setFromUserId(userId);
//                	message.setToUserId(business.getSeller());
//                	message.setContent("订单（" + business.getOrderCode() + "）已经部分付款，请注意查收。");
//    			} else {//没有要付款的记录
//    				try {
//    	    			response.getWriter().print("2");
//    	    			return;
//    	    		} catch (IOException e) {
//    	    			e.printStackTrace();
//    	    		}
//    			}
//            	business.setCreateTime3(new Date());
//    			TAppBusinessPay businessPay = businessInfoService.getBusinessPay(business.getId(), payPos);
//
//				businessPay.setIsPayment(2);
//				businessPay.setConfrimPay(2);
//				businessPay.setActualPayTime(new Date());
//				
//				businessInfoService.addOrEditBusinessPay(businessPay);
//    		}
    		
//    		if(status == 5) {
//    			if(oldStatus == 6) {//甲方已确认付款
//    				try {
//    	    			response.getWriter().print("3");
//    	    			return;
//    	    		} catch (IOException e) {
//    	    			e.printStackTrace();
//    	    		}
//    			}
//    			
//    			message.setTitle("订单已经付款");
//            	message.setFromUserId(userId);
//            	message.setToUserId(business.getBuyer());
//            	message.setContent("订单（" + business.getOrderCode() + "）演出已完成，请及时确认。");
//            	
//    			business.setStatus(status);	
//            	business.setCreateTime4(new Date());
//    		}
//    		
//    		if(status == 6) {//确认订单，订单完成，可以付款给乙方
//            	if(business.getIsByStages() == 1) {
//            		TAppBusinessPay businessPay = businessInfoService.getBusinessPay(business.getId(), 1);
//    				businessPay.setConfrimPay(2);
//    				businessInfoService.addOrEditBusinessPay(businessPay);
//    				
//    				message.setTitle("对方已确认");
//                	message.setFromUserId(userId);
//                	message.setToUserId(business.getSeller());
//                	message.setContent("订单（" + business.getOrderCode() + "）对方已确认，演出款项24小时内到账，请注意查收。");
//                	
//                	business.setStatus(status);	
//                	//business.setCreateTime5(new Date());
//                	
//            	} else {
//            		TAppBusinessPay businessPay = businessInfoService.getBusinessPay(business.getId(), pos);
//    				businessPay.setConfrimPay(2);
//    				businessInfoService.addOrEditBusinessPay(businessPay);
//    				
//    				message.setTitle("对方已确认");
//	            	message.setFromUserId(userId);
//	            	message.setToUserId(business.getSeller());
//	            	message.setContent("订单（" + business.getOrderCode() + "）对方已确认支付第"+pos+"笔款项，24小时内到账，请注意查收。");
//	            	
//    				int payCount = businessInfoService.getPayCount(business.getId(), 2);
//    				if(payCount == 0) {
//    	            	business.setStatus(status);	
//    	            	//business.setCreateTime5(new Date());
//    				}
//            	}
//    		}
    		
    		if(status == 9){
        		message.setTitle("订单已关闭");
            	message.setFromUserId(userId);
            	message.setToUserId(business.getSeller());
            	message.setContent("您的订单（" + business.getOrderCode() + "）已关闭。");

    			business.setStatus(status);
            	business.setCreateTime9(new Date());
            	
            	TAppMessage message1 = new TAppMessage();
            	message1.setTitle(message.getTitle());
            	message1.setContent(message.getContent());
            	message1.setFromUserId(business.getSeller());
            	message1.setToUserId(userId);
            	message1.setCreatTime(createDateTime);
            	message1.setStatus("0");	//发送短信后默认为未读
            	message1.setType(2);
            	messageService.addMessage(message1);
        	}
    		
    		messageService.addMessage(message);
        	
    		businessInfoService.addOrEditBusinessInfo(business);
    		
    		try {
         		response.setContentType("text/text");
    			response.getWriter().print("0");
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	} else {
    		try {
         		response.setContentType("text/text");
    			response.getWriter().print("4");
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	}
    	
    }
    
	//后台我的交易提交后的显示信息
	public void goAlipay(){
		HttpServletRequest request=ServletActionContext.getRequest();
		
		//return "goAlipay";
	}


	//确认订单信息
	public String confirmOrder(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		
		businessInfo=businessInfoService.getBusinessInfoById(id);
		paymentList = businessInfoService.getBusinessPayList(id, 1);
		costList = businessInfoService.getBusinessCost(id, 1);
		
		TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
		if(userInfo != null) {
			request.setAttribute("shangjia", userInfo.getNickName());

		}
		request.setAttribute("choucheng", choucheng);
		
		int userId=HttpSessionHelper.getUserSession(request).getId();
		request.setAttribute("loginUserId", userId);
		String total_fee = "";
		String out_trade_no =businessInfo.getOrderCode();
		if(businessInfo.getIsByStages().equals("1")) {
				total_fee = businessInfo.getPrice();
				out_trade_no = out_trade_no + "001";
			} else {
					TAppBusinessPay tAppBusinessPay = new TAppBusinessPay();
					tAppBusinessPay = paymentList.get(0);
					total_fee = tAppBusinessPay.getPrice();
					
					String code = "";
					int pos = tAppBusinessPay.getPos();
					if(pos < 10) {
						code = "00" + pos;
					} else if(pos < 100) {
						code = "0" + pos;
					}
					out_trade_no = out_trade_no + code;
			}
		request.setAttribute("total_fee", total_fee);
		request.setAttribute("out_trade_no", out_trade_no);
			
		return "confirmOrder";
	}
    
	//后台要付款给艺人的订单列表（分页显示）
	public String payList(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount = request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign = 3;
		
		int total = businessInfoService.getTotal(userId, rowCount, sign, 0, "");
		pageNum = pageNum > total ? total : pageNum;

		List payList = businessInfoService.getMyBusiness(userId, (pageNum-1)*rowCount, rowCount, sign, 0, "");

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPage", total);
		request.setAttribute("payList", payList);
		
		return "payList";
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
    	
    	TAppBusinessInfo businessInfo = null;
    	
    	int id = 0;
    	//如果有ID，是对单个订单付款，否则批量查询需要付款的订单
    	try {
			id = Integer.parseInt(request.getParameter("id"));
			businessInfo = businessInfoService.getBusinessInfoById(id);
			
			TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
			detail = "";
			
			//获取这个订单需要付款的数据
			List<TAppBusinessPay> payList = businessInfoService.getBusinessPayList(id, 1);
			for (int i = 0; i < payList.size(); i++) {
				TAppBusinessPay pay = payList.get(i);
				if(pay.getIsPay() == 1 && pay.getConfrimPay() == 2 && pay.getIsPayment() == 2) {
					priceTotal = DateFormatUtil.calValue(priceTotal, Double.parseDouble(pay.getPrice1()), "+", 2);
					TAppCompanyPayRecord payRecord = new TAppCompanyPayRecord();
					
					String orderCode = "";
					if(pay.getPos() < 10) {
						orderCode = businessInfo.getOrderCode() + "00" + pay.getPos();
					} else if(pay.getPos() < 100) {
						orderCode = businessInfo.getOrderCode() + "0" + pay.getPos();
					} else {
						orderCode = businessInfo.getOrderCode();
					}
					detail += orderCode;
					if(userInfo != null) {
						detail += "^" + userInfo.getAlipay() + "^" + userInfo.getAlipayName() + "^" + pay.getPrice1() + "^来自第一舞台的付款已支付|";
						payRecord.setPayEmail(userInfo.getAlipay());
						payRecord.setPayName(userInfo.getAlipayName());
					}
					
					payCount++;
					
					payRecord.setCreater(userId);
					payRecord.setCreateDate(new Date());
					payRecord.setBatchNo(batchNo);
					payRecord.setOrderNo(orderCode);
					payRecord.setEmail(AlipayConfig.sellerEmail);
					payRecord.setName(AlipayConfig.sellerName);
					payRecord.setPayDate(date);
					
					payRecord.setPayPrice(Double.parseDouble(pay.getPrice1()));
					payRecord.setStatus(1);
					
					businessInfoService.addCompanyPayRecord(payRecord);
					
				}
			}
			detail = detail.substring(0, detail.length() - 1);
		} catch (NumberFormatException e1) {
			priceTotal = 0;
	    	payCount = 0;
	    	detail = "";
	    	
	    	//需要付款的订单列表
			List<TAppBusinessPay> payList = businessInfoService.getPayList();
			
			for (int i = 0; i < payList.size(); i++) {
				TAppBusinessPay pay = payList.get(i);
				businessInfo = businessInfoService.getBusinessInfoById(pay.getOrderId());
				
				priceTotal = DateFormatUtil.calValue(priceTotal, Double.parseDouble(pay.getPrice1()), "+", 2);
				payCount++;
				
				String orderCode = "";
				if(pay.getPos() < 10) {
					orderCode = businessInfo.getOrderCode() + "00" + pay.getPos();
				} else if(pay.getPos() < 100) {
					orderCode = businessInfo.getOrderCode() + "0" + pay.getPos();
				} else {
					orderCode = businessInfo.getOrderCode();
				}
				detail += orderCode;
				TAppCompanyPayRecord payRecord = new TAppCompanyPayRecord();
				
				TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getSeller());
				if(userInfo != null) {
					detail += "^" + userInfo.getAlipay() + "^" + userInfo.getAlipayName() + "^" + pay.getPrice1() + "^来自第一舞台的付款已支付|";
					payRecord.setPayEmail(userInfo.getAlipay());
					payRecord.setPayName(userInfo.getAlipayName());
				}
				payRecord.setCreater(userId);
				payRecord.setCreateDate(new Date());
				payRecord.setBatchNo(batchNo);
				payRecord.setOrderNo(orderCode);
				payRecord.setEmail(AlipayConfig.sellerEmail);
				payRecord.setName(AlipayConfig.sellerName);
				payRecord.setPayDate(date);
				
				payRecord.setPayPrice(Double.parseDouble(pay.getPrice1()));
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
	
	public String getConfirmPay() {
		HttpServletRequest request=ServletActionContext.getRequest();
		int orderId = request.getParameter("orderId")==null?1:Integer.parseInt(request.getParameter("orderId"));
		
		List payList = businessInfoService.getBusinessPayList(orderId, 2);
		request.setAttribute("payList", payList);

		request.setAttribute("orderId", orderId);
		return "confirmPay";
	}

	public String updatePayTime() {
		HttpServletRequest request=ServletActionContext.getRequest();
		int orderId = request.getParameter("orderId")==null?1:Integer.parseInt(request.getParameter("orderId"));
		int type = request.getParameter("type")==null?1:Integer.parseInt(request.getParameter("type"));
		
		List payList = businessInfoService.getBusinessPayList(orderId, 1);
		request.setAttribute("payList", payList);

		request.setAttribute("orderId", orderId);
		request.setAttribute("type", type);
		return "updatePayTime";
	}
	
	public void doUpdatePayTime() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int orderId = request.getParameter("orderId")==null?1:Integer.parseInt(request.getParameter("orderId"));
		
		TAppBusinessInfo business = businessInfoService.getBusinessInfoById(orderId);
		business.setUpdatePayTimeStatus(1);
		
		businessInfoService.addOrEditBusinessInfo(business);
		
		for (int i = 0; i < paymentList.size(); i++) {
			TAppBusinessPay pay = paymentList.get(i);
			
			businessInfoService.addOrEditBusinessPay(pay);
		}
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void updatePayTimeStatus() {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int orderId = request.getParameter("orderId")==null?1:Integer.parseInt(request.getParameter("orderId"));
		int status = request.getParameter("status")==null?1:Integer.parseInt(request.getParameter("status"));
		
		TAppBusinessInfo business = businessInfoService.getBusinessInfoById(orderId);
		business.setUpdatePayTimeStatus(status);
		if(status == 2) {//同意延期付款
			//同意后状态该为0，可以开始下一次延期
			business.setUpdatePayTimeStatus(0);
			
			business.setUpdatePayTimeCount(business.getUpdatePayTimeCount() + 1);
			
			List<TAppBusinessPay> payList = businessInfoService.getBusinessPayList(orderId, 1);
			for (int i = 0; i < payList.size(); i++) {
				TAppBusinessPay pay = payList.get(i);
				pay.setPaymentTime(pay.getUpdatePayTime());
				
				businessInfoService.addOrEditBusinessPay(pay);
			}
		} 
		businessInfoService.addOrEditBusinessInfo(business);
		
		try {
     		response.setContentType("text/text");
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
//	//查看合同
//	public String goAgreement(){
//		HttpServletRequest request=ServletActionContext.getRequest();
//		int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
//		businessInfo=businessInfoService.getBusinessInfoById(id);
//
//		TAppUserInfo userInfo = businessInfoService.getUserInfoById(businessInfo.getQyUserId());
//		
//		if(userInfo != null) {
//			request.setAttribute("jiafang", userInfo.getName());
//		}
//		
//		TAppUserInfo userInfo1 = businessInfoService.getUserInfoById(businessInfo.getBqyUserId());
//		
//		if(userInfo1 != null) {
//			request.setAttribute("yifang", userInfo1.getName());
//		}
//		
//		return "goAgreement";
//	}
//
//	
//	//打开我的购物车
//    public String toMyCar(){
//    	HttpServletRequest request=ServletActionContext.getRequest();
//		int userId=HttpSessionHelper.getUserSession(request).getId();
//		List list=businessInfoService.getMyCarData(userId);
//		double myCarSumAmount=businessInfoService.getMyCarSumAmount(userId);
//		request.setAttribute("myCarList",list);
//		request.setAttribute("myCarSumAmount",myCarSumAmount);
//		return "toMyCar";
//
//	}
//    
//    
//    
//    //订单加入购物车
//    public void doAddMyCar(){
//    	HttpServletRequest request=ServletActionContext.getRequest();
//		int userId=HttpSessionHelper.getUserSession(request).getId();
//		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
//    	businessInfo.setQyUserId(userId);
//    	businessInfo.setCreatTime(createDateTime);
//    	businessInfo.setStatus("1");	//待提交
//    	//被签约用户所属企业用户id,0表示无上级企业用户
//    	businessInfo.setOrgUserId(businessInfoService.getBqyUserOfOrgUserId(businessInfo.getBqyUserId()));	
//    	businessInfoService.addOrEditBusinessInfo(businessInfo);
// 
//	}
//    
//    //删除购物车内订单
//    public void delBusinessInfo(){
//    	HttpServletRequest request=ServletActionContext.getRequest();
//    	HttpServletResponse response=ServletActionContext.getResponse();
//    	int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
//    	TAppBusinessInfo business=businessInfoService.getBusinessInfoById(id);
//    	businessInfoService.delBusinessInfo(business);
//    	try {
//			response.getWriter().print("1");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    }
//    
//    //提交购物车内的所有订单(为了订单单号的唯一性，此方法使用方法锁，只能单线程执行此方法）
//    public synchronized void doMyCarSubmit(){
//    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
//		
//    	HttpServletRequest request=ServletActionContext.getRequest();
//    	HttpServletResponse response=ServletActionContext.getResponse();
//		int userId=HttpSessionHelper.getUserSession(request).getId();
//		List list=businessInfoService.getMyCarData(userId);
//		Iterator it = list.iterator();       
//		while (it.hasNext()) {       
//			Object[] item = (Object[]) it.next();       
//			TAppBusinessInfo business=(TAppBusinessInfo)item[0];
//			business.setStatus("2");	//待接受
//			business.setContractNo(businessInfoService.getNewContractNo(createDateTime, 1));	//订单编号
//			businessInfoService.addOrEditBusinessInfo(business);
//		}
//		try {
//			response.getWriter().print("1");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    }
//
//    //在head.jsp页面中显示购物车订单条数
//    public void getMyCarCount(){
//    	HttpServletRequest request=ServletActionContext.getRequest();
//    	HttpServletResponse response=ServletActionContext.getResponse();
//		int userId=HttpSessionHelper.getUserSession(request).getId();
//    	int myCarCount=businessInfoService.getMyCarCount(userId);
//    	try {
//    		System.out.println("-----------"+myCarCount);
//			response.getWriter().print(myCarCount);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    }
}
