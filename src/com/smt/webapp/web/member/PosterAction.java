package com.smt.webapp.web.member;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppPoster;
import com.smt.webapp.service.poster.PosterService;
import com.smt.webapp.util.CommonUtil;

@Controller
public class PosterAction extends ActionSupport {
	private String type;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	private TAppPoster info;

	public TAppPoster getInfo() {
		return info;
	}

	public void setInfo(TAppPoster info) {
		this.info = info;
	}

	@Autowired
	private PosterService service;

	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String type = request.getParameter("type");
		List<TAppPoster> list = service.getList(0, 20, 1,"1");
		request.setAttribute("infoList", list);
		request.setAttribute("type", "1");
		return SUCCESS;
	}
	
	public String paging() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String type = request.getParameter("type");
		List<TAppPoster> list = service.getList(0, 20, 1,"2");
		request.setAttribute("infoList", list);
		request.setAttribute("type", "2");
		return "paging_list";
	}

	public String toAdd() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		String flag = type.equals("1")?"add":"paging_add";
		return flag;
	}

	public String edit() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		int pid = Integer.parseInt(request.getParameter("pid"));
		String type = request.getParameter("type");
		TAppPoster vo = (TAppPoster) service.getVOByID(pid,type).get(0);
		
		if(vo!=null){
			vo.setPurl("<img src=\""+vo.getPurl()+"\" alt=\"\" />");
		}
		request.setAttribute("info", vo);
		request.setAttribute("type", type);
		String flag = type.equals("1")?"edit":"paging_edit";
		return flag;
	}

	public String doAdd() throws UnsupportedEncodingException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		this.type = request.getParameter("type");
		String result = this.type.equals("1")?"redirect":"paging_redirect";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String _pid = request.getParameter("info.pid");
		int messageId = _pid == null ? 1 : Integer.parseInt(request.getParameter("info.pid"));
		info.setPString(CommonUtil.getTime(new Date()));
		info.setPid(messageId);
		info.setPis(1);
		info.setPtype(type);
		
		//正则取图片 组1为地址
		//String regSrc="http://([^\"]+(?:jpg|gif|png|bmp|jpeg))";
		
		String regEx="([^\"]+(?:jpg|gif|png|bmp|jpeg))";
		Pattern p=Pattern.compile(regEx);  
        Matcher m=p.matcher(info.getPurl());
        if(m.find()){
        	info.setPurl(m.group(0));
        }
         
		if (_pid == null) {
			service.addOrUpPoster(info);
		} else {
			service.update(info);
		}
		request.setAttribute("type", type);
		return result;
	}
}
