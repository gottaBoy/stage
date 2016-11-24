package com.smt.webapp.web.member;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import sun.misc.BASE64Decoder;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.evaluation.UserEvaluationService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
@Controller
public class OrgAction extends ActionSupport{
	

	private String sign ; 
	
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	private TAppUserInfo userInfo;

	public TAppUserInfo getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(TAppUserInfo userInfo) {
		this.userInfo = userInfo;
	}

	@Autowired
	private UserInfoService uService;
	@Autowired
	private UserService userService;
	@Autowired
	private CostService costService;
	@Autowired
	private GrowthService growthService;
	@Autowired
	private UserEvaluationService userEvaluationService;
	
	/**
	 * 
	 */
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		TAppUser user = userService.findUserById(id);
		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
		if(usrInfos != null && usrInfos.size() > 0){
			userInfo = usrInfos.get(0);
		}
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		String signString=request.getParameter("sign");
		List<TAppCostInfo>  costList = costService.getCostListByUserId(id);
		request.setAttribute("costList", costList);
		int sign = Integer.parseInt(signString==null?"1":signString);
		switch (sign) {
		case 1:
			return SUCCESS;//企业基础信息
		case 2:
			
			return "QYRZ";//企业认证
		case 3:
			return "QYTXXG";//头像修改
		case 4:
			return "BDZFB";//绑定支付宝
		case 5:
			return "BDZFB1";//个人用户绑定支付宝
		default:
			return SUCCESS;
		}
	}
	
	public String toAddUser(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int sign = NumberUtils.stringToInt(request.getParameter("sign"), 0);
		int id = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		
		if(id > 0){ //update
			if(StringUtils.isNotBlank(request.getParameter("addUser"))){
				HttpSessionHelper.setNewUserIdToSession(id);
			}	
		}else{
			//id 没传，新建，另外就是登录的用户。
			if(StringUtils.isNotBlank(request.getParameter("addUser"))){
				//新建用户，USERID存session, 
				id = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));
				HttpSessionHelper.setNewUserIdToSession(id);
			}else{
				id = HttpSessionHelper.getUserSession(request).getId();
			}
		}
		
		request.setAttribute("id", id);
		
		userInfo = uService.findUserInfoByUserId(id);
		
		TAppUser user = userService.findUserById(id);
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		
		
		switch (sign) {
		case 1:
			List<TAppCostInfo>  costList = costService.getCostListByUserId(id);
			request.setAttribute("costList", costList);
			int pageNum1 = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
			int  rowCount1=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
			int total1 = growthService.getTotal(id, rowCount1);
			pageNum1=pageNum1>total1?total1:pageNum1;
//			System.out.println(id+"------");
			List<TAppGrowth> growthList1 =growthService.getGrowthList(id, (pageNum1-1)*rowCount1, rowCount1);	

			ServletActionContext.getRequest().setAttribute("pageNum", pageNum1);
			ServletActionContext.getRequest().setAttribute("total", total1);
			ServletActionContext.getRequest().setAttribute("growthList", growthList1);
			return "ORG_USERINFO";
		case 2:
			return "ORG_USERINTRO";
		case 3:
			List  costList1 = costService.getCostInfo(id, 0);
			request.setAttribute("costList", costList1);
			return "ORG_VOCATION";
		case 4:
			
			int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
			int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
			int total = growthService.getTotal(id, rowCount);
			pageNum=pageNum>total?total:pageNum;
			List<TAppGrowth> growthList =growthService.getGrowthList(id, (pageNum-1)*rowCount, rowCount);	

			ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
			ServletActionContext.getRequest().setAttribute("total", total);
			ServletActionContext.getRequest().setAttribute("growthList", growthList);
			return "ORG_GROWTH";
		case 5:
			return "ORG_PORTRAIT";
		case 6:
			return "ORG_INDEXIMG";
			
		default:
			return "ORG_USERINFO";
		}
		
	}
	
	public String saveOrupdateOrgUser(){

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		TAppUserInfo userInfo1 = uService.findUserInfoByUserId(userSession.getId());
		int id = userSession.getId();
		TAppUser user = new TAppUser();
		user.setCreatTime(CommonUtil.getTime(new Date()));
		user.setParentID(id);
		
		TAppUser parentUser = userService.findUserById(userSession.getId());
		//观众的才需要更新成艺人
		if(parentUser!=null && parentUser.getIsOrg()==1){
			//默认用公司邮箱，电话
			user.setEmail(parentUser.getEmail());
		}
		//user.setEmail("XXXXX@XXX.COM");
		
		user.setUsername(userSession.getUserName()+"(公司艺人)");
		user.setUserPsd("123456");
		user.setState("1");
		user.setRzState("1");
		user.setIsOrg(0);
		user.setAuthority(0);
		user.setRoleId(2);
		//修改
		if(userInfo.getId()!=null&&!"".equals(userInfo.getId())){
			
			TAppUserInfo uInfo  =  new TAppUserInfo();
			uInfo = uService.findUserInfoById(userInfo.getId());
			request.setAttribute("id", uInfo.getUserId());
			String signString=request.getParameter("sign");
			int sign = Integer.parseInt(signString==null?"1":signString);
			if(2 == sign){
				uInfo.setEducation(userInfo.getEducation());
				uInfo.setSchool(userInfo.getSchool());
				uInfo.setMajor(userInfo.getMajor());
				uInfo.setIntroduction(userInfo.getIntroduction());
				userInfo = uInfo;
				
				uInfo.setMobile(userInfo1.getMobile());
				uService.updateUserInfo(uInfo);
				return "ORG_USERINTRO";
			}
			
			//uInfo.set
			//uInfo.setId(userInfo.getId());
			uInfo.setNickName(userInfo.getNickName());
			uInfo.setName(userInfo.getName());
			uInfo.setProvice(userInfo.getProvice());
			uInfo.setCity(userInfo.getCity());
			uInfo.setSex(userInfo.getSex());
			uInfo.setBirthday(userInfo.getBirthday());
			uInfo.setBooldType(userInfo.getBooldType());
			uInfo.setHeight(userInfo.getHeight());
			uInfo.setWeight(userInfo.getWeight());
			uInfo.setWaistSize(userInfo.getWaistSize());
			uInfo.setHeartSize(userInfo.getHeartSize());
			uInfo.setBottocksSize(userInfo.getBottocksSize());
			uInfo.setMobile(userInfo1.getMobile());
			
			uService.updateUserInfo(uInfo);
			return "ORG_USERINFO";
		}
		userInfo.setSignNumber(0);
    	userInfo.setSignAmount("保密");
    	userInfo.setPopularityTotal(0);
    	userInfo.setGrade("1");
    	userInfo.setSellerGrade("1");
    	userInfo.setAge(0);
    	
    	if(StringUtils.isEmpty(userInfo.getMobile())){
    		userInfo.setMobile(userInfo1.getMobile());
    	}
    	
    	userInfo.setFeedbackRate(100);
    	userInfo.setComRecommend("0");
    	userInfo.setAlipay(userInfo1.getAlipay());
    	userInfo.setAlipayName(userInfo1.getAlipayName());
    	//添加用户，并返回用户的userId
		int userId = uService.saveOrUpdateOrgUserInfo(userInfo, user);
		userInfo = uService.findUserInfoByUserId(userId);
		TAppUserEvaluation userEvaluation = new TAppUserEvaluation();
    	userEvaluation.setUserId(userId);
    	userEvaluation.setEvaluation(0);
    	userEvaluation.setSellerEvaluation(0);
    	userEvaluationService.addOrEdituserEvaluation(userEvaluation);
		//userService
		//把用户id带到页面
		request.setAttribute("id", userId);
		return "ORG_USERINFO";
	}
	public String upLoadPic() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		String userId  = request.getParameter("userId");
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\indexHeadImage\\";
		
		path = path.replace("\\", System.getProperty("file.separator"));
		
		//图1
		try {
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			File file1 = new File(path+userId+".png");
			FileOutputStream fout1 = null;
			fout1 = new FileOutputStream(file1);
			fout1.write(new BASE64Decoder().decodeBuffer(pic1));
			fout1.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
		}

		//ServletActionContext.getResponse().sendRedirect("userinfo.htm");
		ServletActionContext.getResponse().getWriter().write("success=上传成功");
		//System.out.println("{\"status\":1}");
		return null;
	}
}
