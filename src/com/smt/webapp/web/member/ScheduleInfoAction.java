package com.smt.webapp.web.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppScheduleInfo;
import com.smt.webapp.service.schedule.ScheduleInfoService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

@Controller
public class ScheduleInfoAction extends ActionSupport {
	private TAppScheduleInfo scheduleInfo;
	public TAppScheduleInfo getScheduleInfo() {
		return scheduleInfo;
	}

	public void setScheduleInfo(TAppScheduleInfo scheduleInfo) {
		this.scheduleInfo = scheduleInfo;
	}
	
	
	private int userIdParam;
	
	public int getUserIdParam() {
		return userIdParam;
	}

	public void setUserIdParam(int userIdParam) {
		this.userIdParam = userIdParam;
	}

	private String startDate;
	private String startTime;
	private String endDate;
	private String endTime;
	
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	

	@Autowired
	private ScheduleInfoService scheduleInfoService;

	public String toScheduleInfo() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper
				.getUserSession(request);
		int userId = userSession.getId();
		String id = request.getParameter("id");
		if(id != null && !"".equals(id)){
			userId = Integer.parseInt(id);
			request.setAttribute("userId", id);
		}
		List<TAppScheduleInfo> scheduleInfoList = scheduleInfoService
				.getScheduleInfoByUserId(userId);
		// TODO Auto-generated method stub
		ServletActionContext.getRequest().setAttribute("scheduleInfoList",
				scheduleInfoList);
		if(id != null && !"".equals(id)){
			return "orgScheduleInfo";
		}
		return "toScheduleInfo";

	}

	public String toAddScheduleInfo() {

		// TODO Auto-generated method stub
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("userId", request.getParameter("id"));
		return "toAddScheduleInfo";

	}
	
	
	public String showScheduleInfo(){
		List<TAppScheduleInfo> scheduleInfoList = scheduleInfoService
				.getScheduleInfoByUserId(userIdParam);
		System.out.println(userIdParam);
		// TODO Auto-generated method stub
		//ServletActionContext.getRequest().setAttribute("scheduleInfoList",
				//scheduleInfoList);
		ServletActionContext.getRequest().setAttribute("userIdParam",
				userIdParam);
		
		return "showSch";
	}

	public void getScheByYm() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		String yy = request.getParameter("yy");
		String mm = request.getParameter("mm");
		int id = Integer.parseInt(request.getParameter("id"));
		if(yy.length()==1){
			yy="0"+yy;
		}
		if(mm.length()==1){
			mm="0"+mm;
		}
		String ym=yy+"-"+mm;
		List<TAppScheduleInfo> list = scheduleInfoService.getScheLikeYm(ym,id);
		String flag = "";
		for (TAppScheduleInfo tAppScheduleInfo : list) {
			int i =  Integer.parseInt(tAppScheduleInfo.getStartDate().substring(8, 10));
			int j =  Integer.parseInt(tAppScheduleInfo.getEndDate().substring(8, 10));
			for(int v = i;v <= j ;v++){
					flag = flag + v+",";
	
			}
			
		}
		flag = flag + "no";
		response.getWriter().write(flag);
		
	}
	
	public void getScheinfoByYm() throws IOException{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		HttpServletRequest request = ServletActionContext.getRequest();
		String yy = request.getParameter("yy");
		String mm = request.getParameter("mm");
		String dd = request.getParameter("dd");
		int id = Integer.parseInt(request.getParameter("id"));
		if(yy.length()==1){
			yy="0"+yy;
		}
		if(mm.length()==1){
			mm="0"+mm;
		}
		
		if(dd.length()==1){
			dd="0"+dd;
		}
		String ym=yy+"-"+mm+"-"+dd;
		System.out.println(ym);
		String string="";
		List<TAppBusinessInfo> list = scheduleInfoService.getSchedxYm(ym,id);
		for (TAppBusinessInfo tAppBusinessInfo : list) {
			//string = string +"<br>时间："+tAppBusinessInfo.getBeginDate()+" 至 "+tAppBusinessInfo.getEndDate()+ "<br>标题："+ tAppBusinessInfo.getContent()+"<br>地点："+tAppBusinessInfo.getAddress();
			string = string +"<table width='100%' style='height: 100px;font-weight: bold;color: #333333;' cellpadding='2'><tr><td>&nbsp;演出时间:</td></tr><tr><td>&nbsp;<label style='color: red;'>"+tAppBusinessInfo.getBeginDate()+"</label>&nbsp;至&nbsp;<label style='color: red;'>"+tAppBusinessInfo.getEndDate()+ "</label></td></tr><tr><td>&nbsp;标题&nbsp;:&nbsp;<label style='color: red;'>"+ tAppBusinessInfo.getContent()+"</label></td></tr><tr><td>&nbsp;地点&nbsp;:&nbsp;"+tAppBusinessInfo.getAddress()+"</td></tr>";
		}
		System.err.println(string);
//		ServletActionContext.getResponse().setCharacterEncoding("UTF-8");
		response.getWriter().write(string);
		
	}
	public String addScheduleInfo() {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		int id =HttpSessionHelper.getUserSession(request).getId();
		String userId = request.getParameter("userId");
		if(!userId.equals("")&&userId!=null){
			id = Integer.parseInt(userId);
			request.setAttribute("userId", id);
		}
		String startDate1=startDate;
		String startTime1=startTime;
		String endDate1=endDate;
		String endTime1=endTime;
		String startDateTime=startDate+" "+startTime;
		String endDateTime=endDate+" "+endTime;
		scheduleInfo.setStartDate(startDateTime);
		scheduleInfo.setEndDate(endDateTime);
		scheduleInfo.setUserId(id);
		scheduleInfo.setCreatTime(createDateTime);
		scheduleInfoService.addScheduleInfo(scheduleInfo);
		return "addScheduleInfo";
	}

	public String toUpdateScheduleInfo() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id").toString());
		scheduleInfo= scheduleInfoService.getScheduleInfoById(id);
		request.setAttribute("scheduleInfo", scheduleInfo);
		request.setAttribute("userId",request.getParameter("uid"));
		return "toUpdateScheduleInfo";

	}

	public String updateScheduleInfo() {
		String startDate1=startDate;
		String startTime1=startTime;
		String endDate1=endDate;
		String endTime1=endTime;
		String startDateTime=startDate+" "+startTime;
		String endDateTime=endDate+" "+endTime;
		scheduleInfo.setStartDate(startDateTime);
		scheduleInfo.setEndDate(endDateTime);
		scheduleInfoService.updateScheduleInfo(scheduleInfo);
		return "updateScheduleInfo";
	}
	
	public String delScheduleInfo(){
		scheduleInfoService.delScheduleInfo(scheduleInfo);
		return null;
	}
	
	public String checkStartDate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
        int userId = userSession.getId();
        String idUser =request.getParameter("userId");
        if(!idUser.equals("")&&idUser!=null){
        	userId = Integer.parseInt(idUser);
        	//request.setAttribute("userId", userId);
        }
		String startDate = request.getParameter("startDate").toString();
		String endDate = request.getParameter("endDate").toString();
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
		try {
			if(scheduleInfoService.checkStartDate(startDate,endDate,id,userId)){
				response.getWriter().print("1");
			}else{
				response.getWriter().print("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}