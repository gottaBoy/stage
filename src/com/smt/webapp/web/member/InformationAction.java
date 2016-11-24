package com.smt.webapp.web.member;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppInformation;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.information.InformationService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
@Controller
public class InformationAction extends ActionSupport{

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
		UserSession userSession = HttpSessionHelper.getUserSession(request);

		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = infoService.getTotal(rowCount);
		pageNum=pageNum>total?total:pageNum;
		List infoList =infoService.getInformationList((pageNum-1)*rowCount, rowCount);	

		ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
		ServletActionContext.getRequest().setAttribute("total", total);
		ServletActionContext.getRequest().setAttribute("infoList", infoList);
		
	
		return SUCCESS;
	}
	

	public String toInfo(){
		HttpServletRequest request = ServletActionContext.getRequest();

		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List <TAppInformation> infos = infoService.getInfoByID(id);
		if(infos != null && infos.size() > 0){
			info = infos.get(0);
		}		
		ServletActionContext.getRequest().setAttribute("info", info);
		List infoParentList =infoService.getInformationList();	

		ServletActionContext.getRequest().setAttribute("infoParentList", infoParentList);
		if(id>0){
			
			
			request.setAttribute("contents", info.getContent());
			return "toEdit";
		}
		return "toAdd";
	}
	
	public String toViewInfo(){
		HttpServletRequest request = ServletActionContext.getRequest();

		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List <TAppInformation> infos = infoService.getInfoByID(id);
		if(infos != null && infos.size() > 0){
			info = infos.get(0);
		}		
		ServletActionContext.getRequest().setAttribute("info", info);
		request.setAttribute("contents", info.getContent());
		return "toView";
	}
	

	public String suInfo(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = info.getId()==null?0:info.getId();
		int userId = HttpSessionHelper.getUserSession(request).getId();
		
		if(id==0){
			info.setUserId(userId);
			info.setCreatTime(CommonUtil.getTime(new Date()));
		}
		infoService.suInfo(info);
		return SUCCESS;
	}
	
	public void delInfo(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
       
		TAppInformation info=new TAppInformation();
		info.setId(id);
		infoService.delInfo(info);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
