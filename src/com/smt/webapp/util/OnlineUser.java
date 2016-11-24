package com.smt.webapp.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class OnlineUser implements HttpSessionBindingListener{
    public final static String STAGE_ONLINE = "STAGE_ONLINE";
	UserSession userInfo; 
	List<UserSession> onlineUserList = null;
	public OnlineUser(){ 
        
    } 
    public OnlineUser(UserSession userInfo){ 
        this.userInfo=userInfo; 
    } 
    //session绑定时方法调用
    public void valueBound(HttpSessionBindingEvent event) { 
        HttpSession session = event.getSession(); 
        ServletContext application = session.getServletContext(); 
        // 把用户名放入在线列表 
        onlineUserList = (List) application.getAttribute(STAGE_ONLINE); 
        // 第一次使用前，需要初始化 
        if (onlineUserList == null) { 
            onlineUserList = new ArrayList(); 
            application.setAttribute(STAGE_ONLINE, onlineUserList); 
        }
        //循环list当有相同的账户登录的时候先移除在添加，确保同一账户只显示一次在线
        for (UserSession userSession : onlineUserList) {
        	if(this.userInfo.getUserName().equals(userSession.getUserName())){
        		onlineUserList.remove(userSession); 
        		break;
        	}
		}
        onlineUserList.add(this.userInfo); 
    } 
    //退出，session过期时调用此方法
    public void valueUnbound(HttpSessionBindingEvent event) { 
        HttpSession session = event.getSession(); 
        ServletContext application = session.getServletContext(); 
  
        // 从在线列表中删除用户名 
        onlineUserList = (List) application.getAttribute(STAGE_ONLINE); 
        onlineUserList.remove(this.userInfo); 
        //System.out.println(this.userInfo.getUserName() + "退出。"); 
  
    } 


}
