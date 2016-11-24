package com.smt.webapp.web.presonList;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.evaluation.UserEvaluationService;
import com.smt.webapp.service.friend.FriendInfoService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class OrgListAction extends ActionSupport{


	//依赖注入服务层类
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private FriendInfoService friendInfoService;
	@Autowired
	private GrowthService growthService;
	@Autowired
	private CostService costService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserEvaluationService userEvaluationService;
	@Autowired
	private BusinessInfoService businessInfoService;	
	@Override

	/**
	 * 
	 * @Description: 用户详细信息列表（根据id）
	 * @author hyl   
	 * @date 2013-3-15 下午4:57:52
	 * @return
	 */
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//得到企业Id
		int id = Integer.parseInt(request.getParameter("id"));
		//根据id查找用户信息
		TAppUser user = userService.findUserByUserId(id);
		TAppUserInfo userInfo = userInfoService.findUserInfoByUserId(id);
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):8;
		
		String sign = request.getParameter("sign")!=null&&!"".equals(request.getParameter("sign"))?request.getParameter("sign"):"0";
		String sex = request.getParameter("sex")!=null&&!"".equals(request.getParameter("sex"))?request.getParameter("sex"):"0";
		String profession = request.getParameter("profession")!=null&&!"".equals(request.getParameter("profession"))?request.getParameter("profession"):"0_0";
		String price = request.getParameter("price")!=null&&!"".equals(request.getParameter("price"))?request.getParameter("price"):"0";
		String pro[] = profession.split("_");
		String pro1 = pro[0];
		String pro2 = pro[1];

//		//得到旗下艺人的总数
		int yrSun = userService.getYrSunByUserId(id);
//		int qySum = userService.getQySumByOrgId(id);
		//本周之星
		List bzzx1 = userInfoService.getBzzxByorgId(id,1);
		TAppCompanyInfo bzzx2 = userInfoService.getBzzxByorgId1(id);
		//新人加入
		List xrjr = userInfoService.getBzzxByorgId(id,2);
		for (int i = 0; i < 6; i++) {
			if (xrjr.size()<=i) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("name", "-1");
				xrjr.add(map);
			}
		}
		//最活跃艺人
		List hotStar = userInfoService.getBzzxByorgId(id,3);
		List professionList = costService.getCostInfoByBusinessId(id);
		List buList = businessInfoService.getYrDdByBusinessId(id);
		List yrxxs = userService.getYrxxs(id,(pageNum-1)*rowCount, rowCount,sex,pro1,pro2,price);
		List<TAppTalentCategory> professionListAll = userInfoService.getTalent(pro1);
		int total = userService.getYrxxsTotal(id,sex,pro1,pro2,price);
		pageNum=pageNum>total?total:pageNum;
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		
		if(userSession != null) {
			TAppFriendInfo friend = friendInfoService.getFriendInfo(id, userSession.getId());
				if(friend == null) {
					request.setAttribute("friend", 1);//登陆用户不是要查看的用户的好友
				} else {
					request.setAttribute("friend", 2);//登陆用户是要查看的用户的好友
				}
			}
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("game", total);
		request.setAttribute("id", id);

		request.setAttribute("bzzx1", bzzx1);
		request.setAttribute("bzzx2", bzzx2);
		request.setAttribute("xrjr", xrjr);
		request.setAttribute("professionList", professionList);
		request.setAttribute("buList", buList);
		request.setAttribute("hotStar", hotStar);
		request.setAttribute("yrxxs", yrxxs);
		request.setAttribute("yrSun", yrSun);
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("sex", sex);
		request.setAttribute("pro1", pro1);
		request.setAttribute("pro2", pro2);
		request.setAttribute("price", price);
		request.setAttribute("professionListAll", professionListAll);
		return SUCCESS;
	}	
	
	//获取评价，关注列表
	public void getEvaluateList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		String serviceId = request.getParameter("serviceId");
		
		int starLevel = NumberUtils.stringToInt(request.getParameter("starLevel"), 1); 
		int begin     = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length    = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		List list = businessInfoService.getEvaluationByService2(id,NumberUtils.stringToInt(serviceId,0),starLevel,begin,length);
		
	/*	//用户名要重新找
		Iterator iterator = list.iterator();
		while(iterator.hasNext()){
			Object[] objArr = (Object[])iterator.next();
			Integer seller = (Integer)objArr[7];
			Integer buyer = (Integer)objArr[8];
			Integer sellerCompany = (Integer)objArr[9];
			Integer targetUserId = 0;
			if((seller!=null && seller==id) || (sellerCompany!=null && sellerCompany==id)){
				targetUserId = buyer;
			}
			if(buyer!=null && buyer==id){
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
				}
			}
			
		}*/
		
		int total        = businessInfoService.getEvaluationByService(id,NumberUtils.stringToInt(serviceId,0),-100).size(); 
		int goodTotal    = businessInfoService.getEvaluationByService(id,NumberUtils.stringToInt(serviceId,0),1).size(); 
		int generalTotal = businessInfoService.getEvaluationByService(id,NumberUtils.stringToInt(serviceId,0),0).size(); 
		int badTotal     = businessInfoService.getEvaluationByService(id,NumberUtils.stringToInt(serviceId,0),-1).size(); 
		
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		result.put("goodTotal", Integer.toString(goodTotal));
		result.put("generalTotal", Integer.toString(generalTotal));
		result.put("badTotal", Integer.toString(badTotal));
		result.put("list", list);
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		result.put("starLevel", request.getParameter("starLevel"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	 
	public void getSales(){
		//已成交：18评论：16
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id"));
		
		String serviceId = request.getParameter("serviceId");
		List infoList = businessInfoService.getBusinessInfoByService(id,3,NumberUtils.stringToInt(serviceId,0));
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(infoList);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	
	/**
	 * 
	 * @Description: 用户详细信息列表（根据id）
	 * @author hyl   
	 * @date 2013-3-15 下午4:57:52
	 * @return
	 */
	public String execute2() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String actionName = request.getParameter("actionName");
		
		response.setContentType("text/html;charset=utf-8");
		int id = Integer.parseInt(request.getParameter("id"));
		int photoFlag = request.getParameter("photoFlag")==null?0:Integer.parseInt(request.getParameter("photoFlag"));
		//根据id查找用户信息
		TAppUser user = userService.findUserByUserId(id);

		TAppUserInfo userInfo = userInfoService.findUserInfoByUserId(id);

		//DecimalFormat df=new DecimalFormat(".#");
		
		int isOrg = 1;
		List<TAppBusinessEvaluate> scoresList = userService.getScore(id,isOrg);
		
		if(CollectionUtils.isEmpty(scoresList)){
			request.setAttribute("goodRate","尚未完成交易");//""+userInfo.getFeedbackRate()
			
			request.setAttribute("totalMsRemarksStr","尚未完成交易");
			request.setAttribute("totalTdRemarksStr","尚未完成交易");
			request.setAttribute("totalZlRemarksStr","尚未完成交易");
		}else{
			int totalRemarksTimes = scoresList.size();
			int goodRemarksTimes = 0;
			int totalMsRemarks = 0;
			int totalTdRemarks = 0;
			int totalZlRemarks = 0;
			
			int i = 0;
			int j = 0;
			int k = 0;
			
			for (TAppBusinessEvaluate tAppBusinessEvaluate : scoresList) {
				if(NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getPjGrade(),StringUtils.EMPTY),0)==1){
					goodRemarksTimes++;
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getMsGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getMsGrade()) > 0){
						i++;
					}
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getTdGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getTdGrade()) > 0){
						j++;
					}
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getZlGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getZlGrade()) > 0){
						k++;
					}
				}
				totalMsRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getMsGrade(),StringUtils.EMPTY),0);
				totalTdRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getTdGrade(),StringUtils.EMPTY),0);
				totalZlRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getZlGrade(),StringUtils.EMPTY),0);
			}
			//好评率：
			long goodRate = Math.round(goodRemarksTimes*100.0/totalRemarksTimes*1.0);
			
			String totalMsRemarksStr = ((i>0) ? (new BigDecimal(totalMsRemarks*1.0/i*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");
			String totalTdRemarksStr = ((j>0) ? (new BigDecimal(totalTdRemarks*1.0/j*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");
			String totalZlRemarksStr = ((k>0) ? (new BigDecimal(totalZlRemarks*1.0/k*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");

			long totalMsRemarksRate = (i>0) ? Math.round(totalMsRemarks*1.0/i*1.0) : 0;
			long totalTdRemarksRate = (j>0) ? Math.round(totalTdRemarks*1.0/j*1.0) : 0;
			long totalZlRemarksRate = (k>0) ? Math.round(totalZlRemarks*1.0/k*1.0) : 0 ;
			
			request.setAttribute("goodRate",Long.toString(goodRate)+"%");
			
			request.setAttribute("totalMsRemarksRate",Long.toString(totalMsRemarksRate));
			request.setAttribute("totalTdRemarksRate",Long.toString(totalTdRemarksRate));
			request.setAttribute("totalZlRemarksRate",Long.toString(totalZlRemarksRate));
			
			request.setAttribute("totalMsRemarksStr",totalMsRemarksStr);
			request.setAttribute("totalTdRemarksStr",totalTdRemarksStr);
			request.setAttribute("totalZlRemarksStr",totalZlRemarksStr);
		}		
		
		
		//TAppUserEvaluation userEvaluation = userEvaluationService.getUserEvaluationById(id);
		/*if(userEvaluation!=null){
			userEvaluation.setMsGradeValue(Double.parseDouble(df.format(userEvaluation.getMsGradeValue())));
			userEvaluation.setTdGradeValue(Double.parseDouble(df.format(userEvaluation.getTdGradeValue())));
			userEvaluation.setZlGradeValue(Double.parseDouble(df.format(userEvaluation.getZlGradeValue())));
		}*/
		

		UserSession userSession = HttpSessionHelper.getUserSession(request);


		//修改点击数+1
		if(userInfo.getPopularityTotal()!=null&&!"".equals(userInfo.getPopularityTotal())){
			userInfo.setPopularityTotal(userInfo.getPopularityTotal()+1);
		}else{
			userInfo.setPopularityTotal(1);
		}
		
		int dingCount = friendInfoService.getDingTotal(0, id,1);
		userInfoService.saveUserInfo(userInfo);

		request.setAttribute("user", user);
		if (!"保密".equals(userInfo.getSignAmount())) {
			if(userInfo.getSignAmount()==null){
				request.setAttribute("dingCount", dingCount);	
			}else{
				if(StringUtils.isNumeric(userInfo.getSignAmount())){
					request.setAttribute("dingCount", dingCount+Integer.parseInt(userInfo.getSignAmount()));
				}else{
					request.setAttribute("dingCount", dingCount);
				}
			}
		}else {
			request.setAttribute("dingCount", dingCount);
		}
		
		//签约次数，交易数 对于企业来说应该是他旗下艺人签约的次数总和加上他服务项目的签约次数总和
		userInfo.setSignNumber(businessInfoService.getMyBusinessInfoTotal(id,3));
		
		request.setAttribute("userInfo", userInfo);

		//request.setAttribute("userEvaluation",userEvaluation);
		List costList=costService.getTop3CastByUserID(id);

		request.setAttribute("costList",costList);
		request.setAttribute("id", id);
		if(userSession==null){ 
			request.setAttribute("userId", 0);
		}else {
			request.setAttribute("userId", userSession.getId());
		}
		
		if (user.getParentID()!=null&&user.getParentID()!=0&&user.getParentID()!=user.getId()) {
			request.setAttribute("qyUserInfo",1);
			TAppUserInfo userInfo1 = userInfoService.findUserInfoByUserId(user.getParentID());
			TAppUser user1 = userService.findUserByUserId(user.getParentID());
			request.setAttribute("qyUInfo", userInfo1);
			request.setAttribute("qyUser", user1);
			request.setAttribute("nowId", user.getParentID());
		}else {
			request.setAttribute("qyUserInfo",0);
			request.setAttribute("nowId", id);
		}
		
		int friendGZTotal = friendInfoService.getTotalFriends(id, 1); //关注
		int friendFSTotal = friendInfoService.getTotalFriends(id, 2); //粉丝
		
		request.setAttribute("friendGZTotal", friendGZTotal);
		request.setAttribute("friendFSTotal", friendFSTotal);
		
		//找到前一个和后一个 userId
		//先找出当前用户类别下的其他艺人，
		
		Integer professionId = 0;
		if(actionName==null){
			if(userInfo!=null){
				professionId = userService.findProfession(id);
				if(professionId!=null){
					request.getSession().setAttribute("professionId",professionId);
				}
			}
		}
		Integer newProfessionId = (Integer)request.getSession().getAttribute("professionId");
		if(newProfessionId!=null){
			TAppUser preUser = userService.findPrePostUserId(id,newProfessionId,1);
			TAppUser postUser = userService.findPrePostUserId(id,newProfessionId,-1);
			if(preUser !=null){
				request.setAttribute("preUserId", preUser.getId());	
			}
			if(postUser !=null){
				request.setAttribute("postUserId", postUser.getId());	
			}
		}		
		
		
		
		if(StringUtils.isNotEmpty(actionName)){
			if(StringUtils.equals(actionName, "orgServiceDetail")){
				//int serviceId = NumberUtils.stringToInt(request.getParameter("serviceId"),0);
				request.setAttribute("serviceId", request.getParameter("serviceId"));
				int yrSum = userService.getYrSunByUserId(id);
				request.setAttribute("yrSum", yrSum);
				
				//已成交：18评论：16
				String serviceId = request.getParameter("serviceId");
				List infoList = businessInfoService.getBusinessInfoByService(id,3,NumberUtils.stringToInt(serviceId,0));
				int hasSold = (infoList==null) ? 0 : infoList.size();
				request.setAttribute("hasSold", Integer.toString(hasSold));
				
				List remarkList = businessInfoService.getEvaluationByService(id,NumberUtils.stringToInt(serviceId,0),-100);
				int hasRemarks = (remarkList==null) ? 0 : remarkList.size();
				request.setAttribute("hasRemarks", Integer.toString(hasRemarks));
				
				List<TAppCostInfo>  costList3 = costService.getCostListByUserId(id,0,10);
				
				List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
				for (TAppCostInfo tAppCostInfo : costList3) {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("bulletinImg", tAppCostInfo.getBigImage());
					map.put("price", tAppCostInfo.getBprice());
					map.put("unit", tAppCostInfo.getUnit());
					map.put("content", tAppCostInfo.getDetail());
					map.put("title", tAppCostInfo.getKeywords());
					map.put("id", tAppCostInfo.getId());
					map.put("userId", tAppCostInfo.getUserId());
					
					resultList.add(map);
				}
				request.setAttribute("resultList", resultList);
				
				//List<TAppGrowth> listGrow = growthService.getGrowthList(id, 0, 10);
				//request.setAttribute("listGrow", listGrow);
				/*for (TAppGrowth tAppGrowth : listGrow) {
					if(tAppGrowth.getId()==serviceId){
						request.setAttribute("serviceContent", tAppGrowth.getContent());
						request.setAttribute("serviceContent", tAppGrowth.getContent());
						request.setAttribute("serviceContent", tAppGrowth.getContent());
						request.setAttribute("serviceContent", tAppGrowth.getContent());
					}
				}*/
			}
			return actionName;
		}else{
			return "orgService";
		}
	}
	
}
