package com.smt.webapp.weih5;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;

public class H5BaseAction extends ActionSupport {

	protected static final String FULL_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	protected static final String ERROR = "error";
	protected static final String H5LOGIN = "h5login";

//	protected static final int TEST_USER_ID = 1;

	/**
	 * This is used for AJAX response.
	 */
	protected void responseAjax(String result, String message) {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		obj.put("message", message);
		result = obj.toJSONString();
		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	protected void responseAjax(String result, Object data){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		obj.put("message", "");
		obj.put("data", data);
		result = obj.toJSONString();
		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
