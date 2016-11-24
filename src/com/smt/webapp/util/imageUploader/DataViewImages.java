package com.smt.webapp.util.imageUploader;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * DataViewImages.java Create on 2008-12-15 下午05:34:31
 * 
 * 说明: 显示所有图片
 * 
 * Copyright (c) 2008 by MTA.
 * 
 * @author 廖瀚卿
 * @version 1.0
 */
@SuppressWarnings("serial")
public class DataViewImages extends HttpServlet {

	public DataViewImages() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/plain");
		String strImage = "{'images':[";
		String[] strExten = { ".jpg", ".bmp", ".gif", ".png" };
		String rootPath = request.getSession().getServletContext().getRealPath("\\");
		String path = rootPath + "Upload\\";
		if (!path.endsWith("\\")) {
			path += "\\";
		}
		File file = new File(path.replace("\\", System.getProperty("file.separator")));
		String[] names = file.list();
		if (names != null) {
			for (String name : names) {
				for (String s : strExten) {
					if (name.toLowerCase().endsWith(s)) {
						strImage += "{'name':'" + name + "','url':'Upload/" + name + "','size':'"
								+ new File(path + name).length() + "'},";
					}
				}
			}
		}
		strImage = strImage.substring(0, (strImage.length() - 1));
		strImage += "]}";

		response.getWriter().write(strImage);
	}

	public void init() throws ServletException {
	}

	public static void main(String[] s) {
		File file = new File("D:\\");
		String[] names = file.list();
		for (String ds : names) {
			System.out.println(ds);
		}
	}

}
