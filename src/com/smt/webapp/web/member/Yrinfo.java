package com.smt.webapp.web.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.tuckey.web.filters.urlrewrite.utils.URLEncoder;
import sun.misc.BASE64Decoder;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
@Controller
public class Yrinfo extends ActionSupport{
	private List list ;
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	
	 
	@Autowired
	private UserInfoService uService;
	@Autowired
	private UserService userService;
	@Override
	/**
	 * 
	 */
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		String  keywords = request.getParameter("keywords");
		//System.err.print("===========11====="+keywords);
		
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getUserTotalByorgId(id, keywords);
		pageNum=pageNum>total?total:pageNum;
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		//System.out.println(pageNum+"----------");
		list = uService.getUserInfoByorgId(id, (pageNum-1)*rowCount, rowCount, keywords);
		System.out.println(total+"=======================");
		request.setAttribute("keywords", keywords);
		request.setAttribute("pageNum", pageNum);
		//System.out.println(total);
		request.setAttribute("total", total);
		request.setAttribute("game", total);
		return SUCCESS;
	}
}
