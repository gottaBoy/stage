package com.smt.webapp.web.presonList;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class LoginHtml extends ActionSupport {
	private List list;

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	private String provice;
	private String city;
	private String sort;
	private String keywords;

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvice() {
		return provice;
	}

	public void setProvice(String provice) {
		this.provice = provice;
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
		//UserSession userSession = HttpSessionHelper.getUserSession(request);
		int flag = Integer.parseInt(request.getParameter("flag"));
		request.setAttribute("flag", flag);
		if (request.getParameter("r") != null) {
			
			String url = request.getParameter("r");
			if(StringUtils.contains(url,"@{loginUserId}")){
				//url = StringUtils.replace(url, "${loginUserId}", Integer.toString(userSession.getId()));
				url = HttpSessionHelper.urlDecode(url);
			}else{
				url = HttpSessionHelper.replaceRedirectBack(request.getParameter("r"));
			}
			
			HttpSession session = request.getSession();
			session.setAttribute(HttpSessionHelper.SESSION_REDIRECT, url);
		}
		request.getSession().setAttribute("needUserId", "true");
		return SUCCESS;
	}

}
