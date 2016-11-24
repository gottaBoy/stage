package com.smt.webapp.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport; 
import com.smt.entity.TAppUser;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.index.IndexService;
import com.smt.webapp.service.user.UserInfoService;

public class Index3Action extends ActionSupport{

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
			list = uInfoService.getUserListsByProfNew("");
			break;
		case 2://演员
			list = uInfoService.getUserListsByProfNew("yanyuan");
			break;
		case 3://音乐
			list = uInfoService.getUserListsByProfNew("yinyue");
			break;
		case 5://模特
			list = uInfoService.getUserListsByProfNew("mote");
			break;
		case 4://舞蹈
			list = uInfoService.getUserListsByProfNew("wudao");
			break;
		case 6://达人
			list = uInfoService.getUserListsByProfNew("daren");
			break;		
		case 7://幕后
			list = uInfoService.getUserListsByProfNew("muhou");
			break;
		case 8://top排行榜
			list = uInfoService.getUserListsByProfNew("yanyuan");

			break;

		default: 
			break;
		}
		
		request.setAttribute("date", new Date().getTime());
	
		if(prof == 9) { //机构
			List list1 =uInfoService.getUserInfoList(null, 0, 6,2);	
			request.setAttribute("orgList", list1);
		}else {
			TAppUser user = null;
			List newList = new ArrayList();
			int size = list.size();
			for (int i = 0; i < size; i++) {
				Object[] obj = (Object[])list.get(i);
				Object[] objNew = new Object[3];
				
				objNew[1]=obj[0]; //user
				objNew[0]=obj[1]; //userinfo
				
				user = (TAppUser) obj[0]; //user
				objNew[2]=costService.getTop3CastByUserID(user.getId());
				
				newList.add(objNew);
			}
			request.setAttribute("newList", newList);
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
