package com.smt.webapp.web.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppMessage;
import com.smt.entity.TAppSkillEvaluate;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;

import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.dao.evaluation.UserEvaluationDao;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;
import com.smt.webapp.service.evaluation.UserEvaluationService;
import com.smt.webapp.service.skillEvaluate.SkillEvaluateService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class BusinessEvaluateAction extends ActionSupport{
	
	private TAppBusinessEvaluate evaluate=new TAppBusinessEvaluate();
	private TAppSkillEvaluate skillEvaluate = new TAppSkillEvaluate();
	public TAppSkillEvaluate getSkillEvaluate() {
		return skillEvaluate;
	}

	public void setSkillEvaluate(TAppSkillEvaluate skillEvaluate) {
		this.skillEvaluate = skillEvaluate;
	}

	public TAppBusinessEvaluate getEvaluate() {
		return evaluate;
	}

	public void setEvaluate(TAppBusinessEvaluate evaluate) {
		this.evaluate = evaluate;
	}

	@Autowired
	private BusinessEvaluateService businessEvaluateSerive;
	@Autowired
	private ArtInfoService artInfoService;
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private UserEvaluationService userEvaluationService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private SkillEvaluateService skillEvaluateService;

	public String myEvaluate(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		
		int total = businessEvaluateSerive.getTotal(userId, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;

		if(sign==2) {//设置 评价为已 查看
			businessEvaluateSerive.updateUnread(userId,rowCount,1);
		}
		
		List businessEvaluateList=businessEvaluateSerive.getMyBusinessEvaluate(userId, (pageNum-1)*rowCount, rowCount, sign);
		//用户名要重新找
		if(sign==1){
		Iterator iterator = businessEvaluateList.iterator();
			while(iterator.hasNext()){
				Object[] objArr = (Object[])iterator.next();
				Integer seller = (Integer)objArr[5];
				Integer buyer = (Integer)objArr[6];
				Integer sellerCompany = (Integer)objArr[7];
				Integer targetUserId = 0;
				if((seller!=null && seller==userId) || (sellerCompany!=null && sellerCompany==userId)){
					targetUserId = buyer;
				}
				if(buyer!=null && buyer==userId){
					if(seller!=null){
						targetUserId = seller;
					}else{
						targetUserId = sellerCompany;
					}
				}
				if(targetUserId!=null){
					TAppUserInfo userInfoByUserId = userInfoService.getUserInfoByUserId(targetUserId);
					if(userInfoByUserId!=null){
						objArr[2] = userInfoByUserId.getNickName();
						objArr[4] = userInfoByUserId.getUserId();
					}
				}
				
			}
		}
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("businessEvaluateList", businessEvaluateList);
		return "myEvaluate";
	}
	
	public String addEvaluate(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int businessId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		int flag = request.getParameter("flag")==null?0:Integer.parseInt(request.getParameter("flag"));
		request.setAttribute("businessId", businessId);
		request.setAttribute("flag", flag);
		if(flag == 1 || flag==2 || flag==0) {
			int userId=HttpSessionHelper.getUserSession(request).getId();
			evaluate=businessEvaluateSerive.getBusinessEvaluateByCreatId(userId, businessId);
//			request.setAttribute("evaluate", evaluate);
		}
		if(flag==1 || flag==0)
			return "addEvaluate";
		else
			return "viewEvaluate"; 
			
	}
	public String addYrEvaluate(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int businessId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		int flag = request.getParameter("flag")==null?0:Integer.parseInt(request.getParameter("flag"));
		request.setAttribute("businessId", businessId);
		request.setAttribute("flag", flag);
		if(flag == 1 || flag==2 || flag==0) {
			int userId=HttpSessionHelper.getUserSession(request).getId();
			evaluate=businessEvaluateSerive.getBusinessEvaluateByCreatId(userId, businessId);
//			request.setAttribute("evaluate", evaluate);
		}
		if(flag==1 || flag==0)
			return "addYrEvaluate";
		else
			return "viewYrEvaluate";
	}
	public String image1(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		int index = request.getParameter("index")==null?0:Integer.parseInt(request.getParameter("index"));
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		request.setAttribute("id", id);
		request.setAttribute("userId", userId);
		request.setAttribute("index", index);
		return "image1";
	}
	public String image2(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		request.setAttribute("userId", userId);
		return "image2";
	}
	public String image3(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		request.setAttribute("userId", userId);
		return "image3";
	}
	
	
	public void doAddEvaluate(){//买家评论卖家
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		
		//删除原先的评价,并返回评价值
		TAppBusinessEvaluate businessEvaluate = businessEvaluateSerive.getBusinessEvaluateByCreatId(userId, evaluate.getBusinessId());
		int pjcount=0;
		if(businessEvaluate!=null)
			businessEvaluate.getPjcount();
		if(pjcount<0)
			pjcount=0;
		if(pjcount>0) {
			try {
				response.getWriter().print("1");
				response.getWriter().flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		}
		int pjgrade = businessEvaluateSerive.deleteEvalute(userId,evaluate.getBusinessId());
		evaluate.setCreatId(userId);
		evaluate.setCreatTime(createDateTime);
		int bussinessId=evaluate.getBusinessId();
		int evaluation = Integer.parseInt(request.getParameter("evaluation"));//评价
		TAppBusinessInfo business=businessInfoService.getBusinessInfoById(bussinessId);
		
		if (pjgrade!=-2) {//修改时 恢复前一条评论的分值
			TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(business.getSeller());//获取评价总分对象
			
			userEvaluation.setEvaluation(userEvaluation.getSellerEvaluation()-pjgrade);//评价总分累加
			if (business.getSellerCompany()!=business.getSeller()) {
				TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(business.getSellerCompany());//获取评价总分对象
				
				userEvaluation1.setEvaluation(userEvaluation1.getSellerEvaluation()-(pjgrade*3));//评价总分累加
			}
			
			evaluate.setPjcount((short)(pjcount+1));
			
//			evaluate.setMsGrade(businessEvaluate.getMsGrade());
//			evaluate.setTdGrade(businessEvaluate.getTdGrade());
//			evaluate.setZlGrade(businessEvaluate.getZlGrade());

		}
		
		//每个自然月中（30天），相同买卖家之间的评价不得超过五个好评或差评
		int Count = businessInfoService.getDatecount(30,evaluation,userId,business.getSeller(),business.getSellerCompany());
		//10天内，相同买卖家之间同一“技能”计分不能超过三分
		int isBoth = businessInfoService.getBothBealoon(10,1,evaluation,userId,business.getSeller(),business.getSellerCompany(),bussinessId);
		
		business.setBuyerRate(2);
			//签约方给艺人（被签约方）评价
		
		businessInfoService.addOrEditBusinessInfo(business);
		
		TAppMessage message = new TAppMessage();
    	message.setCreatTime(createDateTime);
    	message.setTitle("您的订单已被评价");
    	message.setFromUserId(userId);
    	message.setToUserId(business.getSeller());
    	message.setContent("您的订单已被评价，请到评价管理查看。");
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(3);
    	message.setSendType((short)0);//系统发送
		messageService.addMessage(message);
		
		if(business.getSeller() !=business.getSellerCompany() ) {
			TAppMessage message1 = new TAppMessage();
	    	message1.setCreatTime(createDateTime);
	    	message1.setTitle("您的订单已被评价");
	    	message1.setFromUserId(userId);
	    	message1.setToUserId(business.getSellerCompany());
	    	message1.setContent("您的订单已被评价，请到评价管理查看。");
	    	message1.setStatus("0");	//发送短信后默认为未读
	    	message1.setType(3);
	    	message.setSendType((short)0);//系统发送
			messageService.addMessage(message1);
		}
		
		if(Count<5&&isBoth<3){
			int BqyUserId = business.getSeller();
			int OrgUserId = business.getSellerCompany();
			
			TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(BqyUserId);//获取评价总分对象
			System.out.println(userEvaluation.getSellerEvaluation()+"  ,"+evaluation);
			userEvaluation.setSellerEvaluation(userEvaluation.getSellerEvaluation()+evaluation);//评价总分累加
			
			userEvaluationService.addOrEdituserEvaluation(userEvaluation);
			
			TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(OrgUserId);
			
			//获取用户信息
			TAppUser user = userService.getUserById(BqyUserId);
			//获取用户详细信息
			TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(BqyUserId);
			businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation.getSellerEvaluation(),1);//判断是否晋级
			if(OrgUserId!=0&&OrgUserId!=BqyUserId){
				
				if(evaluation==-1){
					userEvaluation1.setSellerEvaluation(userEvaluation1.getSellerEvaluation()-3);
				}else {
					userEvaluation1.setSellerEvaluation(userEvaluation1.getSellerEvaluation()+evaluation);
				}
				userEvaluationService.addOrEdituserEvaluation(userEvaluation1);
			}
			//获取用户信息
			 user = userService.getUserById(OrgUserId);
			//获取用户详细信息
			 userInfo = userInfoService.getUserInfoByUserId(OrgUserId);
			 businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation1.getSellerEvaluation(),1);//判断是否晋级
			 
			 if (pjgrade==-2) {
				 userEvaluationService.saveGradeValue(evaluate, BqyUserId);
					
			 }
			
			
		}else{
				evaluate.setPjContent(evaluate.getPjContent()+"<span style=\"color: #ffffff\">不计分</span>");
		}
		businessEvaluateSerive.addOrEditEvaluate(evaluate);//保存评价
		TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(business.getSeller());
		userInfoService.saveOrUpdateFeek(userInfo);
		try {
			response.getWriter().print("1");
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void doAddYrEvaluate(){//卖家评论买家
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		
		TAppBusinessEvaluate businessEvaluate = businessEvaluateSerive.getBusinessEvaluateByCreatId(userId, evaluate.getBusinessId());		
		int pjcount=0;
		if(businessEvaluate!=null)
			businessEvaluate.getPjcount();
		if(pjcount<0)
			pjcount=0;
		if(pjcount>0) {
			try {
				response.getWriter().print("1");
				response.getWriter().flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		}		
		//删除原先的评价,并返回评价值
		int pjgrade = businessEvaluateSerive.deleteEvalute(userId,evaluate.getBusinessId());
		
		evaluate.setCreatId(userId);
		evaluate.setCreatTime(createDateTime);
		evaluate.setMsGrade("0");
		evaluate.setTdGrade("0");
		evaluate.setZlGrade("0");
		int bussinessId=evaluate.getBusinessId();
		TAppBusinessInfo business=businessInfoService.getBusinessInfoById(bussinessId);
		if (pjgrade!=-2) {//修改时 恢复前一条评论的分值
			TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(business.getBuyer());//获取评价总分对象
			
			userEvaluation.setEvaluation(userEvaluation.getEvaluation()-pjgrade);//评价总分累加

			evaluate.setPjcount((short)(pjcount+1));
		}
		int evaluation = Integer.parseInt(request.getParameter("evaluation"));//评价
		//每个自然月中（30天），相同买卖家之间的评价不得超过五个好评或差评
		int Count = businessInfoService.getDatecount1(30,evaluation,business.getSeller(),userId,business.getBuyer());
		int isBoth = businessInfoService.getBothBealoon(10,1,evaluation,business.getBuyer(),business.getSeller(),userId,bussinessId);
		business.setSellerRate(2);
		businessInfoService.addOrEditBusinessInfo(business);
		TAppMessage message = new TAppMessage();
    	message.setCreatTime(createDateTime);
    	message.setTitle("您的订单已被评价");
    	message.setFromUserId(userId);
    	message.setToUserId(business.getBuyer());
    	message.setContent("您的订单已被评价，请到评价管理查看。");
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(3);
    	message.setSendType((short)0);//系统发送
		messageService.addMessage(message);
		if(Count<=5&&isBoth<=3){
			int qyUserId = business.getBuyer();
			
			TAppUserEvaluation userEvaluation=userEvaluationService.getUserEvaluationById(qyUserId);//获取评价总分对象
			
			userEvaluation.setEvaluation(userEvaluation.getEvaluation()+evaluation);//评价总分累加

			userEvaluationService.addOrEdituserEvaluation(userEvaluation);
			
			TAppUserEvaluation userEvaluation1=userEvaluationService.getUserEvaluationById(qyUserId);
			
			//获取用户信息
			TAppUser user = userService.getUserById(qyUserId);
			//获取用户详细信息
			TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(qyUserId);
			businessInfoService.upOrdowmLevel(user.getIsOrg(),userInfo,userEvaluation.getEvaluation(),2);//判断是否晋级
		}else {
			evaluate.setPjContent(evaluate.getPjContent()+"<span style=\"color: #ffffff\">不计分</span>");
		}	
		businessEvaluateSerive.addOrEditEvaluate(evaluate);
		

		try {
			response.getWriter().print("1");
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void addSkillEvaluate(){//卖家评论买家
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int skillId =Integer.parseInt(request.getParameter("skillId"));
		skillEvaluate.setCreateId(userId);
		skillEvaluate.setCreatetime(createDateTime);
		skillEvaluate.setContent(skillEvaluate.getContent());
		skillEvaluate.setSkillId(skillId);
		
		
		skillEvaluateService.addOrEditEvaluate(skillEvaluate);
		
		int totalP = businessEvaluateSerive.getSkillEvaluateTotalAll(skillId);
		TAppArtInfo artInfo = artInfoService.getArtInfoByID(skillId);
		artInfo.setEvaluate(totalP);
		artInfoService.saveOrUpdateArtInfo(artInfo);		

		try {
			response.getWriter().print("1");
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
