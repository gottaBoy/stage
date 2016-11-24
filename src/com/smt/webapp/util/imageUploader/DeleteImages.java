/*
 * @(#)DeleteImages.java 2008-12-15
 *
 * Copyright YOURGAME. All rights reserved.
 */

package com.smt.webapp.util.imageUploader;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Create on 2008-12-15 下午11:16:49
 * 
 * 删除图片
 * 
 * @author 廖瀚卿
 * @version
 */
@SuppressWarnings("serial")
public class DeleteImages extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strNodes = request.getParameter("Nodes");
		response.setContentType("text/plain");

		String[] nodes = strNodes.split(",");
		String rootPath = request.getSession().getServletContext().getRealPath("\\");
		String path = rootPath + "Upload\\";
		try {
			for (String node : nodes) {
				File file = new File(path + node);
				if(file.exists()){
					file.delete();
				}
			}
			response.getWriter().write("{success:true}");
		} catch (RuntimeException e) {
			response.getWriter().write("{success:false}");
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
