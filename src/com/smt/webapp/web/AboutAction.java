package com.smt.webapp.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppInformation;
import com.smt.webapp.service.information.InformationService;
@Controller
public class AboutAction extends ActionSupport{
	private String personPage;
	
	public String getPersonPage() {
		return personPage;
	}
	public void setPersonPage(String personPage) {
		this.personPage = personPage;
	}

	private TAppInformation info;
	public TAppInformation getInfo() {
		return info;
	}
	public void setInfo(TAppInformation info) {
		this.info = info;
	}
	
	@Autowired
	private InformationService infoService;
	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		List oneMenu=infoService.getInformationMenu(1);
		List twoMenu=infoService.getInformationMenu(2);
		request.setAttribute("oneMenu_bottom", oneMenu);
		request.setAttribute("twoMenu_bottom", twoMenu);

	
		return SUCCESS;
	}
	


	
	public String toAbout(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List oneMenu=infoService.getInformationMenu(1);
		List twoMenu=infoService.getInformationMenu(2);
		List <TAppInformation> infos = infoService.getInfoByID(id);
		if(infos != null && infos.size() > 0){
			info = infos.get(0);
		}		
		request.setAttribute("oneMenu", oneMenu);
		request.setAttribute("twoMenu", twoMenu);
		return "toAbout";
	}
	

}
