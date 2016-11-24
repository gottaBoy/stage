package com.smt.webapp.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppPoster;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.index.IndexService;
import com.smt.webapp.service.poster.PosterService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class IndexAction extends ActionSupport{

	@Autowired
	private PosterService posterService;

	
	private int prof ;


	public int getProf() {
		return prof;
	}

	public void setProf(int prof) {
		this.prof = prof;
	}
	
	private int userId;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	@Autowired
	private IndexService iservice;
	@Autowired
	private UserInfoService uInfoService;
	@Autowired
	private CostService costService;
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		List list = null;
		switch (prof) {
		case 1://新加入
			list = uInfoService.getUserListsByProf("");
			break;
		case 2://演员
			list = uInfoService.getUserListsByProf("演员");
			break;
		case 3://音乐
			list = uInfoService.getUserListsByProf("音乐");
			break;
		case 5://模特
			list = uInfoService.getUserListsByProf("模特");
			break;
		case 4://舞蹈
			list = uInfoService.getUserListsByProf("舞蹈");
			break;
		case 6://达人
			list = uInfoService.getUserListsByProf("达人");
			break;		
		case 7://幕后
			list = uInfoService.getUserListsByProf("幕后");
			break;
		case 8://top排行榜
			list = uInfoService.getUserListsByProf("演员");

			break;

		default: 
			break;
		}
		
		
	
		if(prof == 9) {
			List list1 =uInfoService.getUserInfoList(null, 0, 6,2);	
			request.setAttribute("list1", list1);
			return "indexCompany";
		}else {
			TAppUser user = null;
			List costList = new ArrayList();
			int size = list.size();
			for (int i = 0; i < size; i++) {
				Object[] obj = (Object[])list.get(i);
				user = (TAppUser) obj[1];
				List st  = costService.getTop3CastByUserID(user.getId());
				costList.add(i,st);
			}
//				List st  = costService.getTop3CastByUserID(tAppUserInfo.getUserId());
			request.setAttribute("list", list);
			request.setAttribute("costList", costList);
			request.setAttribute("date", new Date().getTime());
			if(prof == 8) {
				return "top";
			}
		}
		
		return SUCCESS;
	}
	
	public String  toShow(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("count", iservice.getCountForUser());
		return "index";
	}
	public String headIframe(){
		return "headIframe";
	}
	public String  toNovice(){
		return "novice";
	}
	public String  toFenlei(){
		HttpServletRequest request = ServletActionContext.getRequest();

		//幻灯片
		List<TAppPoster> list = posterService.getList(0, 5, 0,"1");
		request.setAttribute("posterList", list);
		
		HttpSession session = request.getSession();
		List cityList = new ArrayList();
		int isOrg = 1;
		if(session.getAttribute(HttpSessionHelper.SESSION_FEN_LEI_CITY_LIST)==null){
			List cityListTemp = uInfoService.getCity(0);
			session.setAttribute(HttpSessionHelper.SESSION_FEN_LEI_CITY_LIST, cityListTemp);
			
			cityList = cityListTemp;
		}else{
			cityList = (List)session.getAttribute(HttpSessionHelper.SESSION_FEN_LEI_CITY_LIST);
		}
		
		request.setAttribute("cityList", cityList);
		request.setAttribute("headKeywords", StringUtils.defaultIfEmpty(request.getParameter("headKeywords"), StringUtils.EMPTY));
		
		return "fenlei";
	}
	
	public String  toJobChance(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		//幻灯片
		List<TAppPoster> list = posterService.getList(0, 5, 0,"1");
		request.setAttribute("posterList", list);
		int type = 3; //job
		
		HttpSession session = request.getSession();
		List cityList = new ArrayList();
		if(session.getAttribute(HttpSessionHelper.SESSION_FEN_JOB_LIST)==null){
			List cityListTemp = uInfoService.getCity(type);
			session.setAttribute(HttpSessionHelper.SESSION_FEN_JOB_LIST, cityListTemp);
			
			cityList = cityListTemp;
		}else{
			cityList = (List)session.getAttribute(HttpSessionHelper.SESSION_FEN_JOB_LIST);
		}
		
		request.setAttribute("cityList", cityList);
		
		return "jobchance";
	}

	public String  toOrg(){ 
		HttpServletRequest request = ServletActionContext.getRequest();
		int isOrg = 1;
		
		HttpSession session = request.getSession();
		List cityList = new ArrayList(); 
		if(session.getAttribute(HttpSessionHelper.SESSION_ORG_CITY_LIST)==null){
			List cityListTemp = uInfoService.getCity(isOrg);
			session.setAttribute(HttpSessionHelper.SESSION_ORG_CITY_LIST, cityListTemp);
			
			cityList = cityListTemp;
		}else{
			cityList = (List)session.getAttribute(HttpSessionHelper.SESSION_ORG_CITY_LIST);
		}
		
		request.setAttribute("cityList", cityList);
		
		request.setAttribute("headKeywords", StringUtils.defaultIfEmpty(request.getParameter("headKeywords"), StringUtils.EMPTY));
		
		return "toOrg";
	}
	
	public String login(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("flag", request.getParameter("flag"));
		request.setAttribute("type", request.getParameter("type"));
		return "login";
	}
	public String login1(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("flag", request.getParameter("flag"));
		request.setAttribute("type", request.getParameter("type"));
		return "login1";
	}
	
	public String windowLogin(){
		return "windowLogin";
	}
	
	public String userDetailTop3cost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List costList = costService.getTop3CastByUserID(userId);
		request.setAttribute("costList", costList);

		return "userDetailTop3cost";
	}

}
