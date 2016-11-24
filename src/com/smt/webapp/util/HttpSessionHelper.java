package com.smt.webapp.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;

public class HttpSessionHelper {
	public final  static String STAGE_SESSION = "STAGE01_SESSION"; 
	public final  static String NEW_USER_ID = "newUserId"; 
	public final static String SESSION_REDIRECT="SESSION_REDIRECT";
	
	public final static String SESSION_ORG_CITY_LIST="SESSION_ORG_CITY_LIST";
	
	public final static String SESSION_FEN_LEI_CITY_LIST="SESSION_FEN_LEI_CITY_LIST";

	public final static String SESSION_FEN_JOB_LIST="SESSION_JOB_CITY_LIST";
	
	
	
	//public final  static String STAGE_SESSION_ONLINE= "USER"; 
	public static void setHttpSession(UserSession si){
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute(STAGE_SESSION, si);
		
	       // 把用户放入在线列表 
	    session.setAttribute("onlineUserBindingListener", new OnlineUser(si)); 

	}
	
	public static UserSession getUserSession(HttpServletRequest request){
		HttpSession session = request.getSession();
		UserSession userInfo = (UserSession)session.getAttribute(STAGE_SESSION);
//		if(userInfo==null){
//			userInfo = new UserSession(); 
//			session.setAttribute(STAGE_SESSION, userInfo);
//		}
		return userInfo;
	}
	
	public static void removeUserSession(HttpServletRequest request){
		HttpSession session = (request).getSession();
		session.removeAttribute(STAGE_SESSION);
	}
	
	public static int getIsOrg(HttpServletRequest request){
		UserSession userInfo = getUserSession(request);
		return userInfo.getIsOrg();
	}
	
	public static int getOrgData(HttpServletRequest request){
		if(StringUtils.isNotBlank(request.getParameter("orgUserId"))){
			return Integer.parseInt(request.getParameter("orgUserId").trim());
		}else{
			return -1;
		}
	}
	public static String getParamData(HttpServletRequest request){
		StringBuilder param = new StringBuilder("a=1");
		if(StringUtils.isNotBlank(request.getParameter("isUpdate"))){
			param.append("&isUpdate=").append(request.getParameter("isUpdate"));
		}
		if(StringUtils.isNotBlank(request.getParameter("addUser"))){
			param.append("&addUser=").append(request.getParameter("addUser"));
		}
		if(StringUtils.isNotBlank(request.getParameter("orgUserId"))){
			param.append("&orgUserId=").append(request.getParameter("orgUserId"));
		}
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			param.append("&userId=").append(request.getParameter("userId"));
		}
		if(StringUtils.isNotBlank(request.getParameter("id"))){
			param.append("&id=").append(request.getParameter("id"));
		}
		return param.toString();
	}

	//-------------
	public static void setNewUserIdToSession(Integer newUserId){
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute(NEW_USER_ID, newUserId);
	}
	
	public static Integer getNewUserIdFromSession(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		if(session.getAttribute(NEW_USER_ID)!=null){
			return (Integer)session.getAttribute(NEW_USER_ID);
		}else{
			return 0;
		}
	}
	
	public static void removeNewUserIdFromSession(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.removeAttribute(NEW_USER_ID);
	}	
	
	//重置 redirect 路径
	public static String replaceRedirect(String r) {
		String a="";
		if(r!=null){
			a=r.replace("&", "|");
		}
		return a;
	}
	
	public static String replaceRedirectBack(String r){
		String a="";
		if(r!=null){
			a=r.replace("|", "&");
		}
		return a;
	}
	

	//重置 redirect 路径
	public static String urlEncode(String r) throws UnsupportedEncodingException {
		String encode = URLEncoder.encode(r,"UTF-8");
		return encode;
	}
	
	public static String urlDecode(String r) throws UnsupportedEncodingException{
		String decode = URLDecoder.decode(r,"UTF-8");
		return decode;
	}
	
}
