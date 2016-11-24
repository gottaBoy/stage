package com.smt.webapp.weih5;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.smt.webapp.weih5.utils.H5SignUtil;

public class H5WeixinAction extends H5BaseAction {

	public static String R_signature = "";
	public static String R_timestamp = "";
	public static String R_nonce = "";
	public static String R_echostr = "";

	public void checkWXService() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();

		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");

		PrintWriter out = null;

		try {
			out = response.getWriter();
			if (StringUtils.isBlank(signature) || StringUtils.isBlank(timestamp) || StringUtils.isBlank(nonce)) {

				out.print("lost some params?");
				out.close();
			} else {
				System.out.println("check signature...");

				if (H5SignUtil.checkSignature(signature, timestamp, nonce)) {
					System.out.println("check success.");
					out.print(echostr);

					R_signature = signature;
					R_timestamp = timestamp;
					R_nonce = nonce;
					R_echostr = echostr;
				} else {
					System.out.println("invalid param, fail to check...");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception when checking signature: " + e);
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}
}
