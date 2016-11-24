package com.smt.webapp.util;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smt.entity.TAppUser;
import com.smt.webapp.dao.SqlAppender;

public class MemberFilter implements Filter {
	
	FilterConfig filterConfig = null;
    public void init(FilterConfig filterConfig) throws ServletException {
    	
    	this.filterConfig = filterConfig;
    }
    private static final String FILTERPATH[] = {"/member/artInfo!showList.htm"};
    public void doFilter(ServletRequest request, ServletResponse response,

           FilterChain filterChain) throws ServletException, IOException {

       HttpServletRequest sRequest = (HttpServletRequest) request;

       HttpServletResponse sResponse = (HttpServletResponse) response;

       HttpSession session = sRequest.getSession(); 

       //读取标示符"STAGE01_SESSION"转换为类
       String path = sRequest.getServletPath();
       
       boolean flag = false;
       UserSession admin = (UserSession)session.getAttribute (HttpSessionHelper.STAGE_SESSION);
       for (String st : FILTERPATH) {
    	   flag = path.equals(st);
       }
       if(admin==null && !flag){ //如果没有内容直接跳回首页
    	   System.out.println(sRequest.getRequestURI());
    	   System.out.println(sRequest.getRequestURL());
    	   System.out.println(sRequest.getContextPath());
           sResponse.sendRedirect(sRequest.getContextPath()+"/index.html");
       }else{
	      
           filterChain.doFilter(request, response);             

       }

    }

  //实现销毁方法
    public void destroy() {  
    	filterConfig = null;
     } 


}

