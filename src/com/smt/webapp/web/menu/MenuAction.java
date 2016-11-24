package com.smt.webapp.web.menu;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppMenu;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;
import com.smt.webapp.service.menu.MenuService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class MenuAction extends ActionSupport{

	private List<TAppMenu> menus;
	public List<TAppMenu> getMenus() {
		return menus;
	}
	public void setMenus(List<TAppMenu> menus) {
		this.menus = menus;
	}
	private String menuFlag;
	
	public String getMenuFlag() {
		return menuFlag;
	}
	public void setMenuFlag(String menuFlag) {
		this.menuFlag = menuFlag;
		//set default
		
	}
	@Autowired
	private MessageService messageService;	
	@Autowired
	private MenuService menuService;
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private BusinessEvaluateService businessEvaluateSerive;
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		menus =menuService.getMenuByUserID(id);	
		
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int unreadMessageCount= messageService.getUnreadMessageCount(userId);
		request.setAttribute("unreadMessageCount", unreadMessageCount);
		
		int unreadPJCount = businessEvaluateSerive.getUnreadTotal(userId, 10, 2);
		request.setAttribute("unreadPJCount", unreadPJCount);
		
		//request.setAttribute("total", businessInfoService.getTotalByUserId(id, 1));
		return SUCCESS;
	}
	
	

	
}
