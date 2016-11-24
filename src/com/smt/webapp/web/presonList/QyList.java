package com.smt.webapp.web.presonList;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;

public class QyList extends ActionSupport{
	private List list ;
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
		String  keywords = request.getParameter("keywords");
		
		if(keywords==null||("").equals(keywords)){
			keywords="搜索其他地区";
		}
		String loc1 = request.getParameter("provice")!=null&&!"".equals(request.getParameter("provice"))?request.getParameter("provice"):"0";
		String loc2 = request.getParameter("city")!=null&&!"".equals(request.getParameter("city"))?request.getParameter("city"):"0";
		String cityid = request.getParameter("cityid")!=null&&!"".equals(request.getParameter("cityid"))?request.getParameter("cityid"):"0";
		String sort = request.getParameter("sort")!=null&&!"".equals(request.getParameter("sort"))?request.getParameter("sort"):"0";
		String popularityTotal = request.getParameter("popularityTotal")!=null&&!"".equals(request.getParameter("popularityTotal"))?request.getParameter("popularityTotal"):"0";
		String attention = request.getParameter("attention")!=null&&!"".equals(request.getParameter("attention"))?request.getParameter("attention"):"0";
		
		if (!popularityTotal.equals("0")) {
			uService.updatePopul(popularityTotal);
		}
		if (!attention.equals("0")) {
			uService.updateAttent(attention);
		}
		
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):8;
		int total = uService.getorgUserTotal(loc1,loc2,keywords);
		pageNum=pageNum>total?total:pageNum;
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		list = uService.getorgUserInfo((pageNum-1)*rowCount, rowCount,loc1,loc2,sort,keywords);
		
		List yrinfoList = userService.getYrinfoByorgId(loc1,loc2); 
		request.setAttribute("loc1", loc1);
		request.setAttribute("loc2", loc2);
		request.setAttribute("cityid", cityid);
		request.setAttribute("sort", sort);
		request.setAttribute("keywords", keywords);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("game", total);
		request.setAttribute("yrinfoList", yrinfoList);
		return SUCCESS;
	}

}
