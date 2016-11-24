package com.smt.webapp.weih5.utils;

import javax.servlet.http.HttpServletRequest;

import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class H5SessionHelper {

	public static boolean checkLogin(HttpServletRequest request) {

		if (request == null) {
			return true;
		}

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		if (userSession == null) {
			return true;
		}
		int userId = userSession.getId();
		if (userId <= 0) {
			return true;
		}
		return false;
	}

	public static int currentUserId(HttpServletRequest request) {
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		if (userSession == null) {
			return 0;
		}
		return userSession.getId();
	}

	public static int currentIsOrgFlag(HttpServletRequest request) {
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		if (userSession == null) {
			return -1;
		}
		return userSession.getIsOrg();
	}
}
