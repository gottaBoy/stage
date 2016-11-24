package com.smt.webapp.web.member;

import java.io.IOException;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.CostValueSession;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class CostAction extends ActionSupport{
	private TAppCostInfo costInfo;
	public TAppCostInfo getCostInfo() {
		return costInfo;
	}
	public void setCostInfo(TAppCostInfo costInfo) {
		this.costInfo = costInfo;
	}
	@Autowired
	private CostService costService;
	
	@Autowired
	private UserService userService;
	
	public String toAddOrUpdate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = HttpSessionHelper.getUserSession(ServletActionContext.getRequest()).getId();		
		int orderNo=costService.getMaxOrderNo(userId);
		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List <TAppCostInfo> costInfos = costService.getCostInfoByID(id);
		if(costInfos != null && costInfos.size() > 0){
			costInfo = costInfos.get(0);
			orderNo = costInfo.getOrderNo();

		}
		
		TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
		if(userInfo!=null){
			userInfo.setZyjnIsFinish(1);
			userInfoService.updateUserInfo(userInfo);
		}
		
		
		List talentCategories = costService.getTalent(0,0);
		request.setAttribute("talentCategories", talentCategories);
		request.setAttribute("orderNo", orderNo);

		if(id>0){
			int profession=costInfo.getProfession();
			
			String cost=costService.getCostForUpdate(profession+"");
		    request.setAttribute("cost", cost);
		    return "toUpdate";
		}
	
		return "toAdd";
	}
	
	
	public void getSelectedTalentByParentId(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		Map map = new LinkedHashMap();
		int flag = 0;
		int userId = 0;
		if(StringUtils.isNotBlank(request.getParameter("flag"))){
			flag = Integer.parseInt(request.getParameter("flag"));
		}
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			userId = Integer.parseInt(request.getParameter("userId"));
		}
		 
		List<TAppTalentCategory> list = costService.getTalent(flag,userId);
		for (TAppTalentCategory tAppTalentCategory : list) {
			map.put(tAppTalentCategory.getId(),tAppTalentCategory.getTypeName());
		}
		
		CommonUtil.outputJson(response, map);
	}
 
	public String toAddOrUpdateByJs(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		//是否选择用searchTime代替，因为javabean不能加属性，加了报sql错误。
		List<TAppTalentCategory> list = costService.getTalent(0,0);
		int currentVal = 0;
		if(request.getParameter("id")!=null){
			currentVal = Integer.parseInt(request.getParameter("id"));
		}
		for (TAppTalentCategory tAppTalentCategory : list) {
			if(tAppTalentCategory.getId()==currentVal){
				tAppTalentCategory.setSearchTime(1);
			}else{
				tAppTalentCategory.setSearchTime(0);
			}
		}
		request.setAttribute("talentCategories", list);
		
		return "toAddCostByJs";
	}
	
	public String toOrgAddorUpdate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		//得到userInfoId
		int userId = Integer.parseInt(request.getParameter("userId"));
		int orderNo=costService.getMaxOrderNo(userId);
		request.setAttribute("userId", userId);
		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List <TAppCostInfo> costInfos = costService.getCostInfoByID(id);
		if(costInfos != null && costInfos.size() > 0){
			costInfo = costInfos.get(0);
			orderNo = costInfo.getOrderNo();

		}
		List talentCategories = costService.getTalent(0,0);
		request.setAttribute("talentCategories", talentCategories);
		request.setAttribute("orderNo", orderNo);

		if(id>0){
			int profession=costInfo.getProfession();
			
			String cost=costService.getCostForUpdate(profession+"");
		    request.setAttribute("cost", cost);
		    return "toOrgUpdate";
		}
	
		return "toOrgAdd";
	}
	
	@Autowired
	private UserInfoService userInfoService;
	public String saveCost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String index = request.getParameter("index");
		
		int id = costInfo.getId()==null?0:costInfo.getId();
		
		int userId = HttpSessionHelper.getUserSession(ServletActionContext.getRequest()).getId();
		if(StringUtils.isNotBlank(request.getParameter("addUser"))){
			userId = HttpSessionHelper.getNewUserIdFromSession();
		}		
		
		String norSign = request.getParameter("norSign");
		if(StringUtils.equals("1000", norSign)){
			TAppUser updateUser = userService.findUserById(userId);
			//观众的才需要更新成艺人
			if(updateUser!=null && updateUser.getIsOrg()==100){
				updateUser.setIsOrg(0); //升级为艺人
				userService.updateUser(updateUser);
			}
		}
		
		if(id==0){
			costInfo.setUserId(userId);
			costInfo.setCreatTime(CommonUtil.getTime(new Date()));
			
			//int orderNo=costInfo.getOrderNo();
			//TAppUserInfo userInfo =  userInfoService.findUserInfoByUserId(userId);
			//int profession=costInfo.getProfession();
			//if(orderNo==1){
				//String parentCostId=costService.getParentCostId(profession+"",1);				
				//userInfo.setProfession(parentCostId);
			//}
			//String professionStr=userInfo.getProfessionStr()==null?"":userInfo.getProfessionStr();
			//userInfo.setProfessionStr(professionStr+","+costService.getProfessionName(profession+""));
			//userInfoService.updateUserInfo(userInfo);  
		}
		//costService.saveCost(costInfo);

		request.getSession(true).setAttribute("costInfo_"+index, costInfo);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 企业服务，海报
	 * @return
	 */
	public String saveOrgServiceCost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		response.setContentType("text/plain");
		 
		//默认是登录的用户
		int userId = 0;
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			userId = Integer.parseInt(request.getParameter("userId"));
		}else{
			userId = userSession.getId();
		}
		
		int orderNo=costService.getMaxOrderNo(userId);
		request.setAttribute("userId", userId);
		
		//is update, id is not null, get the costInfo
		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		if(id!=0){
			List <TAppCostInfo> costInfos = costService.getCostInfoByID(id);
			if(costInfos != null && costInfos.size() > 0){
				costInfo = costInfos.get(0);
				orderNo = costInfo.getOrderNo();
			}
		}

		request.setAttribute("orderNo", orderNo);
		if(id==0){
			costInfo.setUserId(userId);
			costInfo.setCreatTime(CommonUtil.getTime(new Date()));
		}
		costInfo.setEprice(costInfo.getBprice()); //
		costInfo.setOrderNo(orderNo);
		
		costService.saveCost(costInfo);
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public String updateOrgCost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		response.setContentType("text/plain");
		
		//默认是登录的用户
		int userId = 0;
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			userId = Integer.parseInt(request.getParameter("userId"));
		}else{
			userId = userSession.getId();
		}
		
		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List <TAppCostInfo> costInfos = costService.getCostInfoByID(id);
		if(costInfos != null && costInfos.size() > 0){
			TAppCostInfo newCostInfo = costInfos.get(0);

			
			//newCostInfo.setCreatTime(CommonUtil.getTime(new Date()));
			//newCostInfo.setUserId(userId);
			
	 
			//company
			String yulanImgHid = request.getParameter("yulanImgHid_"+id);
			String price = request.getParameter("price_"+id);
			String unit = request.getParameter("unit_"+id);
			
			String title = request.getParameter("title_"+id);
			String content = request.getParameter("content_"+id);
			
			newCostInfo.setKeywords(title);
			newCostInfo.setDetail(content);
			
			if(StringUtils.isNotBlank(yulanImgHid)){
				newCostInfo.setBigImage(yulanImgHid);
			}
			if(StringUtils.isNotBlank(price)){
				newCostInfo.setBprice(Integer.valueOf(price));
				newCostInfo.setEprice(Integer.valueOf(price));
			}
			if(StringUtils.isNotBlank(unit)){
				newCostInfo.setUnit(unit);	
			}
			
			costService.saveCost(newCostInfo);
		}
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void delOrgCost(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
       
        TAppCostInfo tAppCostInfo=new TAppCostInfo();
        tAppCostInfo.setId(id);
		costService.delCostInfo(tAppCostInfo);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public void saveOrgCost(){
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		try {
			int id = costInfo.getId()==null?0:costInfo.getId();
			String UserIdStr = ServletActionContext.getRequest().getParameter("userId");
			int userId = Integer.parseInt(UserIdStr==null?"0":UserIdStr);
			//userId = userInfoService.findUserInfoById(userId).getUserId();
			if(id==0){
				costInfo.setUserId(userId);
				costInfo.setCreatTime(CommonUtil.getTime(new Date()));
				
				int orderNo=costInfo.getOrderNo();
				TAppUserInfo userInfo =  userInfoService.findUserInfoByUserId(userId);
				int profession=costInfo.getProfession();			
				if(orderNo==1){				
					String parentCostId=costService.getParentCostId(profession+"",1);				
					userInfo.setProfession(parentCostId);
				}
				String professionStr=userInfo.getProfessionStr()==null?"":userInfo.getProfessionStr();
				if (profession!=0) {
					userInfo.setProfessionStr(professionStr+","+costService.getProfessionName(profession+""));
				}else {
					userInfo.setProfessionStr(professionStr+","+costInfo.getKeywords());
				}
				
				userInfoService.updateUserInfo(userInfo);  
				
			}
			costService.saveCost(costInfo);
			response.getWriter().print("1");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	
	public void delCost(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		int userId = HttpSessionHelper.getUserSession(ServletActionContext.getRequest()).getId();
		String userIdStr = request.getParameter("userId");
		if(userIdStr != null && !"".equals(userIdStr)){
			userId = Integer.parseInt(userIdStr);
		}
        int orderNo=costService.getOrderNoById(id);
        int maxOrderNo=costService.getMaxOrderNo(userId)-1;       
		
		try {
			if(orderNo<maxOrderNo){
				response.getWriter().print("0");
	        }else{
	        	List costListByUserId = costService.getCostListByUserId(userId);
				if(costListByUserId!=null && (costListByUserId.size() > 1)){
	        	//多于1个才能删，最后要保留一项
					response.getWriter().print("1");
	        	
		        	TAppCostInfo costInfo=new TAppCostInfo();
		    		costInfo.setId(id);
		    		costService.delCostInfo(costInfo);
		    		TAppUserInfo userInfo =  userInfoService.findUserInfoByUserId(userId);			
					
		    		if(orderNo==1){
						userInfo.setProfession("");
						userInfo.setProfessionStr("");
			    		userInfoService.updateUserInfo(userInfo);  
					}else{
						
						List list = costService.getCostInfo(userId, 0);
						String professionStr="";
						if(list!=null&&list.size()>0){
							for(int i=0;i<list.size();i++){
								Object[] item=(Object[]) list.get(i);							
								professionStr=professionStr+","+((TAppTalentCategory) item[1]).getTypeName();							
							}
							
						}			
						userInfo.setProfessionStr(professionStr);
			    		userInfoService.updateUserInfo(userInfo); 
					}
				}else{
					response.getWriter().print("2"); //至少保留一项
				}
	    		
	        }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String checkCostId(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int costId = 0;
		
		try {
			costId = Integer.parseInt(request.getParameter("costId"));
		} catch (NumberFormatException e1) {
		}
		
		
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = userSession.getId();		
		String userIdStr = request.getParameter("userId");
		if(userIdStr != null && !"".equals(userIdStr)){
			userId = Integer.parseInt(userIdStr);
		}
		String flag=costService.checkCostId(userId,costId);			

		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public String checkCostIdForSession(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		String index = request.getParameter("index");
		try {
			CostValueSession costValueSession = new CostValueSession();
			costValueSession.setCostId(Integer.parseInt(request.getParameter("costId")));
			costValueSession.setCost1(Integer.parseInt(request.getParameter("cost1")));
			costValueSession.setCost2(Integer.parseInt(request.getParameter("cost2")));
			costValueSession.setCost3(Integer.parseInt(request.getParameter("cost3")));
			costValueSession.setCost4(Integer.parseInt(request.getParameter("cost4")));
			request.getSession().setAttribute("costValueSession_"+index, costValueSession);
		} catch (NumberFormatException e1) {
		}
		
		boolean exist = false;
		for(int i=1;i<=5;i++){
			CostValueSession costValueSession = (CostValueSession)request.getSession().getAttribute("costValueSession_"+i);
			CostValueSession costValueSessionIndex = (CostValueSession)request.getSession().getAttribute("costValueSession_"+index);
			//不是同一个，值同，不行.
			if(costValueSession != null && costValueSessionIndex!=null){
				if(i != Integer.parseInt(index)  && costValueSession.getCostId()== costValueSessionIndex.getCostId()){
					exist = true;
					break;
				}
			}
		}


		try {
			response.getWriter().print(exist);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	 public static void main(String[] args) {
	    	
	    	//getCostTree();
	    }

}
