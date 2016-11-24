package com.smt.webapp.web.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppPoster;
import com.smt.webapp.service.poster.PosterService;
@Controller
public class BannerAction extends ActionSupport{
	@Autowired
	private PosterService service;
	private String type;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public String topic()  {
		return "topic";
	}
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		List<TAppPoster> list = service.getList(0, 20, 0,type);
		request.setAttribute("list", list);
		return SUCCESS;
	}
}
