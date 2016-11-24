package com.smt.webapp.weih5.utils;

import org.apache.commons.lang.StringUtils;

public class H5ValidationHelper {

	public static boolean invalidEmail(String email){
		return StringUtils.isBlank(email) || !email.contains("@");
	}
	
	public static boolean isEmptyRole(String role) {
		return StringUtils.isBlank(role) || "{}".equals(role);
	}
}
