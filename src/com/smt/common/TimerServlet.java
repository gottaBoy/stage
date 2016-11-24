package com.smt.common;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class TimerServlet extends HttpServlet {

	public void init() throws ServletException {
		super.init();
		
		new TimerManager();
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException{
	
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException{
		
	}
}
