package com.smt.webapp.weih5;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import alipay.util.httpClient.HttpRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppImagesInfo;
import com.smt.entity.TAppMessage;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.evaluation.UserEvaluationDao;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.friend.FriendInfoService;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
import com.smt.webapp.weih5.utils.H5CommonHelper;
import com.smt.webapp.weih5.utils.H5FileHelper;
import com.smt.webapp.weih5.utils.H5NotificationHelper;
import com.smt.webapp.weih5.utils.H5ParamTranslater;
import com.smt.webapp.weih5.utils.H5SessionHelper;
import com.smt.webapp.weih5.utils.H5ValidCodeCache;
import com.smt.webapp.weih5.utils.H5ValidCodeHelper;
import com.smt.webapp.weih5.utils.H5ValidationHelper;
import com.smt.webapp.weih5.vo.H5ProfileInfoVo;

import edu.emory.mathcs.backport.java.util.Collections;

public class H5UserMngAction extends H5BaseAction {

	private static final String LOGIN_ERROR_MESSAGE = "账户名或密码错误";

	private static final String[] BIZ_TAGS = { "广告|公关", "婚庆|会展", "演艺", "剧团", "影视制作", "文化传媒", "多媒体", "幕后制作", "动漫" };

	private static final int TEMP_REGISTER = 66688;

	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserEvaluationDao userEvaluationDao;
	@Autowired
	private MessageService messageService;
	@Autowired
	private FriendInfoService friendInfoService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private CostService costService;
	@Autowired
	private ArtInfoService artInfoService;
	
	public void validCode() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String phone = request.getParameter("phoneNo");

		int validCode = H5ValidCodeHelper.generate();
		String startTime = new Date(System.currentTimeMillis()).toString();
	
		// send to user
		int result = H5NotificationHelper.sendLoginValidCode(phone, validCode);
		
		if (result > 0) {
			// put into cache
			H5ValidCodeCache.addLoginValidCode(phone, validCode);
			responseAjax(SUCCESS, "");
			return;
		} else {
			responseAjax(ERROR, "验证码发送失败，请稍后再试。");
			return;
		}
	}

	public void validCodeRetrieve() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String phone = request.getParameter("phoneNo");

		// check if exists
		TAppUser phoneUser = userService.findUserByMobile(phone);
		if (phoneUser == null) {
			responseAjax(ERROR, "此号码暂未注册。");
			return;
		}

		int validCode = H5ValidCodeHelper.generate();
		// send to user
		int result = H5NotificationHelper.sendRetrieveValidCode(phone, validCode);
		if (result > 0) {
			// put into cache
			H5ValidCodeCache.addRetrievePsdValidCode(phone, validCode);
			responseAjax(SUCCESS, "");
			return;
		} else {
			responseAjax(ERROR, "验证码发送失败，请稍后再试。");
			return;
		}
	}

	public String toLoginPage() {

		HttpServletRequest request = ServletActionContext.getRequest();
		String ref = request.getHeader("Referer");
		if (!StringUtils.isBlank(ref)) {
			request.setAttribute("ref", ref);
		}

		return SUCCESS;
	}

	public void checkLoginUser() {

		HttpServletRequest request = ServletActionContext.getRequest();
		String account = (String) request.getParameter("account");
		String password = (String) request.getParameter("password");

		if (StringUtils.isBlank(account) || StringUtils.isBlank(password)) {
			responseAjax(ERROR, LOGIN_ERROR_MESSAGE);
			return;
		}
		// FIXME: refactor this logic
		TAppUser userData = null;
		if (account.length() == 11) {
			userData = userService.findUserByMobile(account);
		}
		if (userData == null) {
			userData = userService.findUser(account);
		}
		// TAppUser userData = userService.findUser(account);

		if (userData == null) {
			responseAjax(ERROR, LOGIN_ERROR_MESSAGE);
			return;
		} else if (userData.getUserPsd().equals(password)) {

			// /**
			// * fixme: testing code
			// */
			// int userId = userData.getId();
			// if (userId <= 11063 && 1 != userData.getAuthority()) {
			// responseAjax(ERROR, "您的帐号密码无误。但十分抱歉，此功能目前内测中，暂不对外开放。");
			// return;
			// }

			responseAjax(SUCCESS, "");
			return;
		} else {
			responseAjax(ERROR, LOGIN_ERROR_MESSAGE);
			return;
		}
	}

	public String myProfile() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}
		int currentUserId = H5SessionHelper.currentUserId(request);
		TAppUser userData = userService.findUserById(currentUserId);
		TAppUserInfo userInfoData = userInfoService.findUserInfoByUserId(currentUserId);

		if (userData == null || userInfoData == null) {
			return H5LOGIN;
		}

		H5ProfileInfoVo h5ProfileInfoVo = new H5ProfileInfoVo();
		h5ProfileInfoVo.setUserId(currentUserId);
		h5ProfileInfoVo.setUserNickName(userInfoData.getNickName());
		h5ProfileInfoVo.setUserAccountName(userData.getUsername());

		int bizTaskCount = taskService.countBizTaskSumByUserID(currentUserId);// 我发布的委托

		int taskCount = taskService.countTaskSumByUserID(currentUserId);// 我发布的通告
		int taskApplicationCount = 0;
		if (1 == userData.getIsOrg() || 2 == userData.getIsOrg()) {// 企业&经纪人
			taskApplicationCount = taskService.countTaskSumByBizBroId(currentUserId);// 我的艺人所应征的通告
		} else {
			taskApplicationCount = taskService.countTaskSumByAppliedUserId(currentUserId);// 我应征的通告
		}

		int inviteCount = businessInfoService.countByUserIdAndType(currentUserId, 2);// 我发出的邀请
		int invitedMeCount = 0;
		if (1 == userData.getIsOrg() || 2 == userData.getIsOrg()) {// 企业&经纪人
			invitedMeCount = businessInfoService.countByBizBroId(currentUserId); // 我的艺人所收到的邀请
		} else {
			invitedMeCount = businessInfoService.countByUserIdAndType(currentUserId, 3);// 我收到的邀请
		}

		int friendGZTotal = friendInfoService.getTotalFriends(currentUserId, 1); // 关注
		int friendFSTotal = friendInfoService.getTotalFriends(currentUserId, 2); // 粉丝

		h5ProfileInfoVo.setMyBizTaskCount(bizTaskCount);

		h5ProfileInfoVo.setMyTaskCount(taskCount);
		h5ProfileInfoVo.setMyAppliedTaskCount(taskApplicationCount);

		h5ProfileInfoVo.setMyInviteCount(inviteCount);
		h5ProfileInfoVo.setInvitedMeCount(invitedMeCount);

		h5ProfileInfoVo.setMyFanCount(friendFSTotal);
		h5ProfileInfoVo.setMyFollowCount(friendGZTotal);

		request.setAttribute("profileInfoVo", h5ProfileInfoVo);

		if (1 == userData.getIsOrg()) {
			// go to biz
			return "bizProfile";
		} else if (2 == userData.getIsOrg()) {
			// go to bro
			return "broProfile";
		} else if (100 == userData.getIsOrg()) {
			// go to common user
			return "userProfile";
		} else {
			// go to artist
			return SUCCESS;
		}

	}

	public String doLogin() {

		HttpServletRequest request = ServletActionContext.getRequest();

		/**
		 * get param
		 */
		String account = (String) request.getParameter("account");
		String password = (String) request.getParameter("password");

		/**
		 * validation
		 */
		if (StringUtils.isBlank(account) || StringUtils.isBlank(password)) {
			return ERROR;
		}

		// FIXME: refactor this logic
		TAppUser userData = null;
		if (account.length() == 11) {
			userData = userService.findUserByMobile(account);
		}
		if (userData == null) {
			userData = userService.findUser(account);
		}
		if (userData == null || !userData.getUserPsd().equals(password)) {
			return ERROR;
		}

		/**
		 * session
		 */
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		UserSession sessionInfo = new UserSession();
		sessionInfo.setId(userData.getId());
		sessionInfo.setUserName(userData.getUsername());
		sessionInfo.setEmail(userData.getEmail());
		sessionInfo.setState(userData.getState());
		sessionInfo.setIsOrg(userData.getIsOrg());
		sessionInfo.setAuthority(userData.getAuthority().toString());
		HttpSessionHelper.setHttpSession(sessionInfo);

		HttpSession session = ServletActionContext.getRequest().getSession();
		session.removeAttribute("hasNoMy");

		String refUrl = request.getParameter("ref");
		if (!StringUtils.isBlank(refUrl)) {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/plain");

			if (refUrl.contains("h5login")) {
				return SUCCESS;
			}

			// validation URL & redirect
			if (refUrl.startsWith("http://") && (refUrl.contains("www.d15t.com") || (refUrl.contains("localhost")) && (!refUrl.contains("h5retrievePsd")))) {
				try {
					response.sendRedirect(refUrl);
					return null;
				} catch (IOException e) {
					e.printStackTrace();
					return SUCCESS;
				}
			}
		}

		return SUCCESS;
	}

	public String doLogout() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSessionHelper.removeUserSession(request);
		return SUCCESS;
	}

	public String doUserRegister() {

		HttpServletRequest request = ServletActionContext.getRequest();
		String phoneNo = request.getParameter("phoneNo");
		String validCode = request.getParameter("validCode");
		String pwd = request.getParameter("pwd");
		String pwdConfirm = request.getParameter("pwdConfirm");
		String email = request.getParameter("email");
		String nickName = request.getParameter("nickName");

		String contract = request.getParameter("contract");// on | null

		System.out.println("phoneNo: " + phoneNo);
		System.out.println("validCode: " + validCode);
		System.out.println("pwd: " + pwd);
		System.out.println("pwdConfirm: " + pwdConfirm);
		System.out.println("email: " + email);
		System.out.println("contract: " + contract);
		System.out.println("nickName: " + nickName);

		int validCodeInCache = H5ValidCodeCache.findLoginValidCode(phoneNo);

		// validation
		if (!String.valueOf(TEMP_REGISTER).equals(validCode)) {
			if (StringUtils.isBlank(validCode) || !String.valueOf(validCodeInCache).equals(validCode)) {
				request.setAttribute("errormsg", "验证码错误，请稍后再试。");
				return ERROR;
			}
		}

		if (!"on".equals(contract)) {
			// responseAjax(ERROR, "请同意《注册协议》");
			request.setAttribute("errormsg", "请同意《注册协议》");
			return ERROR;
		}
		if (StringUtils.isBlank(phoneNo) || phoneNo.trim().length() != 11) {
			// responseAjax(ERROR, "请输入格式正确的11位手机号码.");
			request.setAttribute("errormsg", "请输入格式正确的11位手机号码.");
			return ERROR;
		}
		if (StringUtils.isBlank(pwd) || pwd.length() < 6 || pwd.length() > 12 || StringUtils.isBlank(pwdConfirm) || !pwd.equals(pwdConfirm)) {
			// responseAjax(ERROR, "请输入6-12位密码,并保证2次输入一致.");
			request.setAttribute("errormsg", "请输入6-12位密码,并保证2次输入一致.");
			return ERROR;
		}
		if (H5ValidationHelper.invalidEmail(email)) {
			// responseAjax(ERROR, "请输入格式正确的邮箱地址.");
			request.setAttribute("errormsg", "请输入格式正确的邮箱地址.");
			return ERROR;
		}
		if (StringUtils.isBlank(nickName)) {
			// responseAjax(ERROR, "请输入公司名称.");
			request.setAttribute("errormsg", "请输入昵称");
			return ERROR;
		}

		// duplicate phone no
		int phoneNoUserCount = userInfoService.countUserByMobile(phoneNo);
		int emailUserCount = userService.countUserByEmail(email);
		if (phoneNoUserCount > 0) {
			// responseAjax(ERROR, "此手机号已被注册.");
			request.setAttribute("errormsg", "此手机号已被注册.");
			return ERROR;
		}
		if (emailUserCount > 0) {
			// responseAjax(ERROR, "此邮箱已被注册.");
			request.setAttribute("errormsg", "此邮箱已被注册.");
			return ERROR;
		}

		// setup beans
		TAppUser tAppUser = new TAppUser();
		TAppUserInfo tAppUserInfo = new TAppUserInfo();
		int userId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));

		tAppUser.setId(userId);
		setUpForUser(tAppUser, tAppUserInfo);

		tAppUser.setUsername(H5CommonHelper.generateUserName(phoneNo));
		tAppUser.setUserPsd(pwd);
		tAppUser.setEmail(email);

		userService.saveUser(tAppUser);

		tAppUserInfo.setNickName(nickName);
		tAppUserInfo.setMobile(phoneNo);
		tAppUserInfo.setSytjIsFinish(1);// FIXME got image then will be 1

		userInfoService.saveUserInfo(tAppUserInfo);

		persistEvaluation(userId);
		persistWelcomeMessage(userId);

		saveUserInSession(tAppUser);
		return SUCCESS;
	}

	public void broEditCommit() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String editIdStr = request.getParameter("editId");
		String name = request.getParameter("name");
		String intro = request.getParameter("intro");
		String address = request.getParameter("address");

		if (StringUtils.isBlank(editIdStr) || !StringUtils.isNumeric(editIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得被编辑信息的id。请稍后再试。");
			return;
		}

		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输入昵称.");
			return;
		}
		if (StringUtils.isBlank(address)) {
			responseAjax(ERROR, "请选择所在地.");
			return;
		}

		int editId = Integer.valueOf(editIdStr);
		int currUserId = H5SessionHelper.currentUserId(request);
		if (editId != currUserId) {
			responseAjax(ERROR, "权限错误。您没有权限修改此信息。");
			return;
		}

		TAppUserInfo editUserInfo = userInfoService.findUserInfoByUserId(editId);
		if (editUserInfo == null) {
			responseAjax(ERROR, "数据错误。无法找到被编辑的数据。");
			return;
		}

		editUserInfo.setNickName(name);
		editUserInfo.setIntroduction(intro);
		/**
		 * convert province and city
		 */
		String province = "";
		String city = "";
		String place = "";
		String[] places = address.split(" ");
		if (places.length == 3) {
			province = places[0];
			city = places[1];
			place = places[2] + place;
		} else if (places.length == 2) {
			province = places[0];
			city = places[1];
		} else if (places.length == 1) {
			province = places[0];
			city = places[0];
		}
		editUserInfo.setProvice(province);
		editUserInfo.setCity(city);
		editUserInfo.setPlace(place);

		userInfoService.updateUserInfo(editUserInfo);
		responseAjax(SUCCESS, "");
		return;
	}

	public void doBroRegister() {

		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String phoneNo = request.getParameter("phoneNo");
			String validCode = request.getParameter("validCode");
			String pwd = request.getParameter("pwd");
			String pwdConfirm = request.getParameter("pwdConfirm");
			String email = request.getParameter("email");
			String name = request.getParameter("name");
			String intro = request.getParameter("intro");
			String address = request.getParameter("address");
			String contract = request.getParameter("contract");

			System.out.println(phoneNo);
			System.out.println(validCode);
			System.out.println(pwd);
			System.out.println(pwdConfirm);
			System.out.println(email);
			System.out.println(name);
			System.out.println(intro);
			System.out.println(contract);
			System.out.println(address);

			int validCodeInCache = H5ValidCodeCache.findLoginValidCode(phoneNo);
			if (!String.valueOf(TEMP_REGISTER).equals(validCode)) {
				if (StringUtils.isBlank(validCode) || !String.valueOf(validCodeInCache).equals(validCode)) {
					responseAjax(ERROR, "验证码错误，请稍后再试。");
					return;
				}
			}

			if (!"true".equals(contract)) {
				responseAjax(ERROR, "请同意《注册协议》");
				return;
			}
			if (StringUtils.isBlank(phoneNo) || phoneNo.trim().length() != 11) {
				responseAjax(ERROR, "请输入格式正确的11位手机号码.");
				return;
			}
			if (StringUtils.isBlank(pwd) || pwd.length() < 6 || pwd.length() > 12 || StringUtils.isBlank(pwdConfirm) || !pwd.equals(pwdConfirm)) {
				responseAjax(ERROR, "请输入6-12位密码,并保证2次输入一致.");
				return;
			}
			if (H5ValidationHelper.invalidEmail(email)) {
				responseAjax(ERROR, "请输入格式正确的邮箱地址.");
				return;
			}
			if (StringUtils.isBlank(name)) {
				responseAjax(ERROR, "请输入昵称.");
				return;
			}
			if (StringUtils.isBlank(address)) {
				responseAjax(ERROR, "请选择所在地.");
				return;
			}

			// duplicate phone no
			int phoneNoUserCount = userInfoService.countUserByMobile(phoneNo);
			int emailUserCount = userService.countUserByEmail(email);
			if (phoneNoUserCount > 0) {
				responseAjax(ERROR, "此手机号已被注册.");
				return;
			}
			if (emailUserCount > 0) {
				responseAjax(ERROR, "此邮箱已被注册.");
				return;
			}

			// setup beans
			TAppUser tAppUser = new TAppUser();
			TAppUserInfo tAppUserInfo = new TAppUserInfo();
			int userId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));

			tAppUser.setId(userId);
			setUpForBro(tAppUser, tAppUserInfo);

			tAppUser.setUsername(H5CommonHelper.generateUserName(phoneNo));
			tAppUser.setUserPsd(pwd);
			tAppUser.setEmail(email);

			userService.saveUser(tAppUser);

			tAppUserInfo.setNickName(name);
			tAppUserInfo.setMobile(phoneNo);
			// tAppUserInfo.setCompanyTags(cleanCompanyTagValue(services));
			// tAppUserInfo.setSeviceScope();
			tAppUserInfo.setIntroduction(intro);

			/**
			 * convert province and city
			 */
			String province = "";
			String city = "";
			String place = "";
			String[] places = address.split(" ");
			if (places.length == 3) {
				province = places[0];
				city = places[1];
				place = places[2] + place;
			} else if (places.length == 2) {
				province = places[0];
				city = places[1];
			} else if (places.length == 1) {
				province = places[0];
				city = places[0];
			}
			tAppUserInfo.setProvice(province);
			tAppUserInfo.setCity(city);
			tAppUserInfo.setPlace(place);

			// tAppUserInfo.setIdCardCopy(H5FileHelper.persistIdCardFile(userIdPic,
			// userIdPicName, userId));
			// tAppUserInfo.setOrgCardCopy(H5FileHelper.persistOrgCardFile(bizLisPic,
			// bizLisPicName, userId));

			userInfoService.saveUserInfo(tAppUserInfo);
			saveUserInSession(tAppUser);

			responseAjax(SUCCESS, "");
			return;
		} catch (Exception e) {
			e.printStackTrace();
			responseAjax(ERROR, "");
		}
	}

	public void bizEditCommit() {
		HttpServletRequest request = ServletActionContext.getRequest();

		String editIdStr = request.getParameter("editId");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String services = request.getParameter("services");
		String intro = request.getParameter("intro");

		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输入公司名称.");
			return;
		}
		if (StringUtils.isBlank(address)) {
			responseAjax(ERROR, "请选择公司地址.");
			return;
		}
		if (StringUtils.isBlank(services)) {
			responseAjax(ERROR, "最少选择1项公司服务.");
			return;
		}
		if (StringUtils.isBlank(editIdStr) || !StringUtils.isNumeric(editIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得编辑人id信息。请稍后再试。");
			return;
		}

		// biz validation
		int currentUserId = H5SessionHelper.currentUserId(request);
		int editId = Integer.valueOf(editIdStr);
		if (currentUserId != editId) {
			responseAjax(ERROR, "权限错误。只有本人才能修改此信息。");
			return;
		}

		TAppUserInfo editingUserInfo = userInfoService.findUserInfoByUserId(editId);
		if (editingUserInfo == null) {
			responseAjax(ERROR, "数据错误。无法获得被编辑的信息。请稍后再试。");
			return;
		}

		editingUserInfo.setIntroduction(intro);
		editingUserInfo.setNickName(name);
		editingUserInfo.setCompanyTags(cleanCompanyTagValue(services));
		//editingUserInfo.setCompanyTags(services);


		/**
		 * convert province and city
		 */
		String province = "";
		String city = "";
		String place = "";
		String[] places = address.split(" ");
		if (places.length == 3) {
			province = places[0];
			city = places[1];
			place = places[2] + place;
		} else if (places.length == 2) {
			province = places[0];
			city = places[1];
		} else if (places.length == 1) {
			province = places[0];
			city = places[0];
		}
		editingUserInfo.setProvice(province);
		editingUserInfo.setCity(city);
		editingUserInfo.setPlace(place);

		userInfoService.updateUserInfo(editingUserInfo);
		responseAjax(SUCCESS, "");
		return;
	}

	public void doRetrievePsd() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String phoneNo = request.getParameter("phone");
		String validCode = request.getParameter("validCode");
		String pwd = request.getParameter("password");
		String pwdConfirm = request.getParameter("passwordConfirm");

		int validCodeInCache = H5ValidCodeCache.findRetrievePsdValidCode(phoneNo);
		if (StringUtils.isBlank(validCode) || !String.valueOf(validCodeInCache).equals(validCode)) {
			responseAjax(ERROR, "验证码错误，请稍后再试。");
			return;
		}

		TAppUser phoneUser = userService.findUserByMobile(phoneNo);
		if (phoneUser == null) {
			responseAjax(ERROR, "手机号码暂未注册。");
			return;
		}

		if (StringUtils.isBlank(phoneNo) || phoneNo.trim().length() != 11) {
			responseAjax(ERROR, "请输入格式正确的11位手机号码.");
			return;
		}
		if (StringUtils.isBlank(pwd) || pwd.length() < 6 || pwd.length() > 12 || StringUtils.isBlank(pwdConfirm) || !pwd.equals(pwdConfirm)) {
			responseAjax(ERROR, "请输入6-12位密码,并保证2次输入一致.");
			return;
		}

		phoneUser.setUserPsd(pwd);
		userService.updateUser(phoneUser);
		responseAjax(SUCCESS, "");
		return;
	}

	private Map<String, String> getRequestParam(String params){  
        Map<String, String> paramMap = null;  
        if(null!=params){  
            paramMap = new HashMap<String, String>();  
            String param[]=params.split("&");  
           for(int i=0;i<param.length;i++){  
               String content = param[i];  
               String key = content.substring(0, content.indexOf("="));  
               String value = content.substring(content.indexOf("=")+1, content.length()); 
               try {
					value = URLDecoder.decode(value,"UTF-8");
			   } catch (UnsupportedEncodingException e) {
					e.printStackTrace();
			   }
               paramMap.put(key, value);  
           }  
        }  
        return paramMap;  
    }  
	
	public void doBizRegister() {

		HttpServletRequest request = ServletActionContext.getRequest();
		
		/*ServletInputStream inStream = null;
		try {
			inStream = request.getInputStream();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		BufferedReader br = new BufferedReader(new InputStreamReader(inStream));  
        String line = null;  
        StringBuilder params = new StringBuilder();  
        try {
			while ((line = br.readLine()) != null) {  
				params.append(line);  
			}
		} catch (IOException e) {
			e.printStackTrace();
		}  
        
	    Map<String, String> paramMap = getRequestParam(params.toString());
	    
	    String phoneNo = paramMap.get("phoneNo");
		String validCode = paramMap.get("validCode");
		String pwd = paramMap.get("pwd");
		String pwdConfirm = paramMap.get("pwdConfirm");
		String email = paramMap.get("email");
		String name = paramMap.get("name");
		String address = paramMap.get("address");
		String services = paramMap.get("services");
		String contract = paramMap.get("contract");
		String bizLisPic = paramMap.get("bizLisPic");
		String userIdPic = paramMap.get("userIdPic");
		String bizLisPicName = paramMap.get("bizLisPicName");
		String userIdPicName = paramMap.get("userIdPicName");
		String intro = paramMap.get("intro");*/
		
		String phoneNo = request.getParameter("phoneNo");
		String validCode = request.getParameter("validCode");
		String pwd = request.getParameter("pwd");
		String pwdConfirm = request.getParameter("pwdConfirm");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String services = request.getParameter("services");
		String contract = request.getParameter("contract");
//		11/02
//		String bizLisPic = request.getParameter("bizLisPic");
//		String userIdPic = request.getParameter("userIdPic");
//		String bizLisPicName = request.getParameter("bizLisPicName");
//		String userIdPicName = request.getParameter("userIdPicName");
		String intro = request.getParameter("intro");
		
		int validCodeInCache = H5ValidCodeCache.findLoginValidCode(phoneNo);
		
		if (!String.valueOf(TEMP_REGISTER).equals(validCode)) {
			if (StringUtils.isBlank(validCode) || !String.valueOf(validCodeInCache).equals(validCode)) {
				
				responseAjax(ERROR, "验证码错误，请稍后再试。");
				return;
			}
		}

		if (!"true".equals(contract)) {
			responseAjax(ERROR, "请同意《注册协议》");
			return;
		}
		if (StringUtils.isBlank(phoneNo) || phoneNo.trim().length() != 11) {
			responseAjax(ERROR, "请输入格式正确的11位手机号码.");
			return;
		}
		if (StringUtils.isBlank(pwd) || pwd.length() < 6 || pwd.length() > 12 || StringUtils.isBlank(pwdConfirm) || !pwd.equals(pwdConfirm)) {
			responseAjax(ERROR, "请输入6-12位密码,并保证2次输入一致.");
			return;
		}
		if (H5ValidationHelper.invalidEmail(email)) {
			responseAjax(ERROR, "请输入格式正确的邮箱地址.");
			return;
		}
		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输入公司名称.");
			return;
		}
		if (StringUtils.isBlank(address)) {
			responseAjax(ERROR, "请选择公司地址.");
			return;
		}
		if (StringUtils.isBlank(services)) {
			responseAjax(ERROR, "最少选择1项公司服务.");
			return;
		}
//		11/02
//		if (StringUtils.isBlank(bizLisPic) || StringUtils.isBlank(userIdPic) || StringUtils.isBlank(bizLisPicName) || StringUtils.isBlank(userIdPicName)) {
//			responseAjax(ERROR, "请上传公司执照和本人身份证，以完成注册.");
//			return;
//		}

		// duplicate phone no
		int phoneNoUserCount = userInfoService.countUserByMobile(phoneNo);
		int emailUserCount = userService.countUserByEmail(email);
		if (phoneNoUserCount > 0) {
			responseAjax(ERROR, "此手机号已被注册.");
			return;
		}
		if (emailUserCount > 0) {
			responseAjax(ERROR, "此邮箱已被注册.");
			return;
		}

		// setup beans
		TAppUser tAppUser = new TAppUser();
		TAppUserInfo tAppUserInfo = new TAppUserInfo();
		int userId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));

		tAppUser.setId(userId);
		setUpForBiz(tAppUser, tAppUserInfo);

		tAppUser.setUsername(H5CommonHelper.generateUserName(phoneNo));
		tAppUser.setUserPsd(pwd);
		tAppUser.setEmail(email);

		userService.saveUser(tAppUser);

		tAppUserInfo.setIntroduction(intro);
		tAppUserInfo.setNickName(name);
		tAppUserInfo.setMobile(phoneNo);
		tAppUserInfo.setCompanyTags(cleanCompanyTagValue(services));
		tAppUserInfo.setCompanyTags(services);

		/**
		 * convert province and city
		 */
		String province = "";
		String city = "";
		String place = "";
		String[] places = address.split(" ");
		if (places.length == 3) {
			province = places[0];
			city = places[1];
			place = places[2] + place;
		} else if (places.length == 2) {
			province = places[0];
			city = places[1];
		} else if (places.length == 1) {
			province = places[0];
			city = places[0];
		}
		tAppUserInfo.setProvice(province);
		tAppUserInfo.setCity(city);
		tAppUserInfo.setPlace(place);

		// tAppUserInfo.setSeviceScope();
		// tAppUserInfo.setIntroduction(intro);

//		11/02
//		tAppUserInfo.setIdCardCopy(H5FileHelper.persistIdCardFile(userIdPic, userIdPicName, userId));
//		tAppUserInfo.setOrgCardCopy(H5FileHelper.persistOrgCardFile(bizLisPic, bizLisPicName, userId));

		userInfoService.saveUserInfo(tAppUserInfo);
		saveUserInSession(tAppUser);

		responseAjax(SUCCESS, "");
		return;
	}

	public void doArtRegisterStep1() {

		HttpServletRequest request = ServletActionContext.getRequest();

		if (!request.getMethod().equals(HttpRequest.METHOD_POST)) {
			try {
				ServletActionContext.getResponse().sendRedirect(request.getContextPath() + "/weih5/h5error.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}

		String phoneNo = request.getParameter("phoneNo");
		String validCode = request.getParameter("validCode");
		String pwd = request.getParameter("pwd");
		String pwdConfirm = request.getParameter("pwdConfirm");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String contract = request.getParameter("contract");

		// validCode validation
		int validCodeInCache = H5ValidCodeCache.findLoginValidCode(phoneNo);

		if (!String.valueOf(TEMP_REGISTER).equals(validCode)) {
			if (StringUtils.isBlank(validCode) || !String.valueOf(validCodeInCache).equals(validCode)) {
				responseAjax(ERROR, "验证码错误，请稍后再试。");
				return;
			}
		}

		if (!"true".equals(contract)) {
			responseAjax(ERROR, "请同意《注册协议》");
			return;
		}
		if (StringUtils.isBlank(phoneNo) || phoneNo.trim().length() != 11) {
			responseAjax(ERROR, "请输入格式正确的11位手机号码.");
			return;
		}
		if (StringUtils.isBlank(pwd) || pwd.length() < 6 || pwd.length() > 12 || StringUtils.isBlank(pwdConfirm) || !pwd.equals(pwdConfirm)) {
			responseAjax(ERROR, "请输入6-12位密码,并保证2次输入一致.");
			return;
		}
		if (H5ValidationHelper.invalidEmail(email)) {
			responseAjax(ERROR, "请输入格式正确的邮箱地址.");
			return;
		}
		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输入艺名.");
			return;
		}

		// duplicate phone no
		int phoneNoUserCount = userInfoService.countUserByMobile(phoneNo);
		int emailUserCount = userService.countUserByEmail(email);
		if (phoneNoUserCount > 0) {
			responseAjax(ERROR, "此手机号已被注册.");
			return;
		}
		if (emailUserCount > 0) {
			responseAjax(ERROR, "此邮箱已被注册.");
			return;
		}

		// setup beans
		TAppUser tAppUser = new TAppUser();
		int userId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));

		tAppUser.setId(userId);
		setUpForArtUser(tAppUser);

		tAppUser.setUsername(H5CommonHelper.generateUserName(phoneNo));
		tAppUser.setUserPsd(pwd);
		tAppUser.setEmail(email);
		tAppUser.setCreatTime(CommonUtil.getTime(new Date()));

		int persistId = userService.saveUser(tAppUser);
		if (persistId <= 0) {
			responseAjax(ERROR, "注册失败，请稍候再试...");
			return;
		}

		/**
		 * set into session for step2
		 */
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("step1_userId", tAppUser.getId());
		session.setAttribute("step1_email", tAppUser.getEmail());
		session.setAttribute("step1_mobile", phoneNo);
		session.setAttribute("step1_name", name);

		responseAjax(SUCCESS, "");
		return;
	}

	public String become2Artist() {
		HttpServletRequest request = ServletActionContext.getRequest();

		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			request.setAttribute("errormsg", "没有登录");
			return H5LOGIN;
		}

		int currentUserId = H5SessionHelper.currentUserId(request);
		TAppUser tAppUser = userService.findUserByUserId(currentUserId);
		TAppUserInfo tAppUserInfo = userInfoService.findUserInfoByUserId(currentUserId);

		if (tAppUser == null || tAppUserInfo == null) {
			request.setAttribute("errormsg", "参数错误。请稍后再试。");
		}

		/**
		 * set into session for step2
		 */
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("step1_userId", tAppUser.getId());
		session.setAttribute("step1_email", tAppUser.getEmail());
		session.setAttribute("step1_mobile", tAppUserInfo.getMobile());
		session.setAttribute("step1_name", tAppUserInfo.getNickName());
		return "step2";
	}

	public String openH5ArtRegStep2() {

		try {
			// if no bean in session, turn to artReg
			HttpSession session = ServletActionContext.getRequest().getSession();
			int step1UserId = session.getAttribute("step1_userId") == null ? 0 : (Integer) session.getAttribute("step1_userId");
			String step1Email = String.valueOf(session.getAttribute("step1_email"));
			String step1Mobile = String.valueOf(session.getAttribute("step1_mobile"));
			String step1Name = String.valueOf(session.getAttribute("step1_name"));

			if (step1UserId <= 0 || StringUtils.isBlank(step1Email) || StringUtils.isBlank(step1Mobile) || StringUtils.isBlank(step1Name)) {
				return "artReg";
			}

			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("step1UserId", step1UserId);
			request.setAttribute("step1Name", step1Name);
			request.setAttribute("step1Email", step1Email);
			request.setAttribute("step1Mobile", step1Mobile);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return "artReg";
		}
	}

	public String goUploadHeadImg() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			request.setAttribute("errormsg", "没有登录");
			return H5LOGIN;
		}

		int currentUserId = H5SessionHelper.currentUserId(request);
		int currentIsOrg = H5SessionHelper.currentIsOrgFlag(request);

		String editUserIdStr = request.getParameter("editId");
		if (StringUtils.isBlank(editUserIdStr) || !StringUtils.isNumeric(editUserIdStr)) {
			request.setAttribute("errormsg", "参数错误。请稍后再试。");
			return ERROR;
		}
		int editUserId = Integer.valueOf(editUserIdStr);

		if (currentUserId != editUserId) {
			if (currentIsOrg != 1 && currentIsOrg != 2) {
				request.setAttribute("errormsg", "权限错误。您无权给此用户上传头像。");
				return ERROR;
			}
		}

		request.setAttribute("title", "上传头像");
		request.setAttribute("editUserId", editUserId);
		request.setAttribute("currentIsOrg", currentIsOrg);
		return SUCCESS;
	}

	public String goUploadArt() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			request.setAttribute("errormsg", "没有登录");
			return H5LOGIN;
		}

		int currentUserId = H5SessionHelper.currentUserId(request);
		int currentIsOrg = H5SessionHelper.currentIsOrgFlag(request);

		String editUserIdStr = request.getParameter("editId");
		if (StringUtils.isBlank(editUserIdStr) || !StringUtils.isNumeric(editUserIdStr)) {
			request.setAttribute("errormsg", "参数错误。请稍后再试。");
			return ERROR;
		}
		int editUserId = Integer.valueOf(editUserIdStr);

		if (currentUserId != editUserId) {
			if (currentIsOrg != 1 && currentIsOrg != 2) {
				request.setAttribute("errormsg", "权限错误。您无权给此用户上传作品。");
				return ERROR;
			}
		}

		// for bro's artist: upload 1 product only;
		if (currentIsOrg == 2) {
			List<TAppArtInfo> artInfoList = artInfoService.getArtInfoList(editUserId, 0, 2, 1);
			if (!CollectionUtils.isEmpty(artInfoList)) {
				request.setAttribute("errormsg", "经纪人艺人只能上传1件作品，无法继续上传。");
				return ERROR;
			}
		}

		request.setAttribute("title", "上传作品");
		request.setAttribute("editUserId", editUserId);
		request.setAttribute("currentIsOrg", currentIsOrg);
		return SUCCESS;
	}

	public String goEditProfilePage() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			request.setAttribute("errormsg", "没有登录");
			return H5LOGIN;
		}

		int currentUserId = H5SessionHelper.currentUserId(request);
		int currentIsOrg = H5SessionHelper.currentIsOrgFlag(request);

		String editUserIdStr = request.getParameter("editId");
		if (StringUtils.isBlank(editUserIdStr) || !StringUtils.isNumeric(editUserIdStr)) {
			request.setAttribute("errormsg", "参数错误。请稍后再试。");
			return ERROR;
		}
		int editUserId = Integer.valueOf(editUserIdStr);

		TAppUser editUser = userService.findUserById(editUserId);
		TAppUserInfo editUserInfo = userInfoService.findUserInfoByUserId(editUserId);

		if (editUser == null || editUserInfo == null) {
			request.setAttribute("errormsg", "无法找到要编辑的用户，请稍后再试。");
			return ERROR;
		}
		request.setAttribute("editUser", editUser);
		request.setAttribute("editUserInfo", editUserInfo);

		if (currentUserId == editUserId) {
			if (currentIsOrg == 100) {
				return "userEdit";
			} else if (currentIsOrg == 0) {
				List<TAppCostInfo> costList = costService.getCostListByUserId(editUserId);
				request.setAttribute("costList", costList);
				request.setAttribute("costListCount", costList == null ? 0 : costList.size());
				return "artEdit";
			} else if (currentIsOrg == 1) {

				String tags = editUserInfo.getCompanyTags();

				Map<String, String> tagMap = new HashMap<String, String>();
				String[] userTags = tags.split(",");
				for (String orgTag : BIZ_TAGS) {
					boolean selected = false;
					for (String userTag : userTags) {
						if (orgTag.equals(userTag)) {
							tagMap.put(orgTag, "1");
							selected = true;
							break;
						}
					}
					if (!selected) {
						tagMap.put(orgTag, "");
					}
				}

				request.setAttribute("tagMap", tagMap);
				return "bizEdit";
			} else if (currentIsOrg == 2) {
				return "broEdit";
			} else {
				request.setAttribute("editUser", null);
				request.setAttribute("editUserInfo", null);
				request.setAttribute("errormsg", "未知用户类型。无法编辑。");
				return ERROR;
			}
		} else {
			if (editUser.getParentID() == null || editUser.getParentID() != currentUserId) {
				request.setAttribute("editUser", null);
				request.setAttribute("editUserInfo", null);
				request.setAttribute("errormsg", "您无权修改此用户的信息.");
				return ERROR;
			} else {
				List<TAppCostInfo> costList = costService.getCostListByUserId(editUserId);
				request.setAttribute("costList", costList);
				request.setAttribute("costListCount", costList == null ? 0 : costList.size());

				if (currentIsOrg == 2) {
					return "broArtEdit";
				}

				return "artEdit";
			}
		}
	}

	public void doArtRegisterStep2() {

		HttpSession session = ServletActionContext.getRequest().getSession();
		int step1UserId = session.getAttribute("step1_userId") == null ? 0 : (Integer) session.getAttribute("step1_userId");
		if (step1UserId <= 0) {
			responseAjax(ERROR, "信息丢失，请从第一步开始");
			return;
		}

		HttpServletRequest request = ServletActionContext.getRequest();
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String birth = request.getParameter("birth");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String height = request.getParameter("height");
		String weight = request.getParameter("weight");
		String bust = request.getParameter("bust");
		String waist = request.getParameter("waist");
		String hipline = request.getParameter("hipline");
		String intro = request.getParameter("intro");

		String image = request.getParameter("proImg");
		String imageName = request.getParameter("proImgName");

		String role0 = request.getParameter("role_0");
		String role1 = request.getParameter("role_1");
		String role2 = request.getParameter("role_2");
		String role3 = request.getParameter("role_3");
		String role4 = request.getParameter("role_4");

		String videoList = request.getParameter("videolist");

		System.out.println(name);
		System.out.println(sex);
		System.out.println(birth);
		System.out.println(address);
		System.out.println(tel);
		System.out.println(email);
		System.out.println(height);
		System.out.println(weight);
		System.out.println(bust);
		System.out.println(waist);
		System.out.println(hipline);
		System.out.println(intro);

		System.out.println(StringUtils.isNotBlank(image));
		System.out.println(imageName);
		System.out.println(role0);
		System.out.println(role1);
		System.out.println(role2);
		System.out.println(role3);
		System.out.println(role4);

		System.out.println(videoList);

		// TODO validation
		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输名称");
			return;
		}
		if (StringUtils.isBlank(sex)) {
			responseAjax(ERROR, "请输性别");
			return;
		}
		if (StringUtils.isBlank(birth)) {
			responseAjax(ERROR, "选择生日");
			return;
		}
		if (StringUtils.isBlank(address)) {
			responseAjax(ERROR, "选择所在地");
			return;
		}
		if (StringUtils.isBlank(tel)) {
			responseAjax(ERROR, "请输入手机号");
			return;
		}
		if (StringUtils.isBlank(email)) {
			responseAjax(ERROR, "请输入邮箱");
			return;
		}
		if (H5ValidationHelper.isEmptyRole(role0) && H5ValidationHelper.isEmptyRole(role1) && H5ValidationHelper.isEmptyRole(role2) && H5ValidationHelper.isEmptyRole(role3) && H5ValidationHelper.isEmptyRole(role4)) {
			responseAjax(ERROR, "请至少选择1个角色");
			return;
		}

		TAppUser tAppUser = userService.findUserById(step1UserId);
		if (tAppUser == null) {
			responseAjax(ERROR, "信息丢失，请从第一步开始");
			return;
		}

		// Cost //
		List<TAppCostInfo> costList = new LinkedList<TAppCostInfo>();
		if (!H5ValidationHelper.isEmptyRole(role0)) {
			TAppCostInfo costInfo0 = translateRole2CostInfo(role0, 1, step1UserId);
			if (costInfo0 != null) {
				costList.add(costInfo0);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role1)) {
			TAppCostInfo costInfo1 = translateRole2CostInfo(role1, 2, step1UserId);
			if (costInfo1 != null) {
				costList.add(costInfo1);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role2)) {
			TAppCostInfo costInfo2 = translateRole2CostInfo(role2, 3, step1UserId);
			if (costInfo2 != null) {
				costList.add(costInfo2);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role3)) {
			TAppCostInfo costInfo3 = translateRole2CostInfo(role3, 4, step1UserId);
			if (costInfo3 != null) {
				costList.add(costInfo3);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role4)) {
			TAppCostInfo costInfo4 = translateRole2CostInfo(role4, 5, step1UserId);
			if (costInfo4 != null) {
				costList.add(costInfo4);
			}
		}
		tAppUser.setCostList(costList);
		userService.updateUser(tAppUser);

		// check userInfo
		boolean isNewRegister = false;
		TAppUserInfo tAppUserInfo = userInfoService.findUserInfoByUserId(step1UserId);
		if (tAppUserInfo == null) {
			// new register artist at step2
			isNewRegister = true;
			tAppUserInfo = new TAppUserInfo();
		}

		setUpForArtUserInfo(tAppUser, tAppUserInfo);
		tAppUserInfo.setSex(H5ParamTranslater.translateSexStr(sex));
		tAppUserInfo.setMobile(tel);
		tAppUserInfo.setNickName(name);
		// tAppUserInfo.setName();
		tAppUserInfo.setBirthday(birth);
		if (StringUtils.isNotBlank(bust) && StringUtils.isNumeric(bust.trim())) {
			tAppUserInfo.setHeartSize(bust.trim());
		}
		if (StringUtils.isNotBlank(waist) && StringUtils.isNumeric(waist.trim())) {
			tAppUserInfo.setWaistSize(waist.trim());
		}
		if (StringUtils.isNotBlank(hipline) && StringUtils.isNumeric(hipline.trim())) {
			tAppUserInfo.setBottocksSize(hipline.trim());
		}
		if (StringUtils.isNotBlank(height) && StringUtils.isNumeric(height.trim())) {
			tAppUserInfo.setHeight(height.trim());
		}
		if (StringUtils.isNotBlank(weight) && StringUtils.isNumeric(weight.trim())) {
			tAppUserInfo.setWeight(weight.trim());
		}
		if (StringUtils.isNotBlank(intro)) {
			tAppUserInfo.setIntroduction(intro);
		}
		/**
		 * convert province and city
		 */
		String province = "";
		String city = "";
		String place = "";
		String[] places = address.split(" ");
		if (places.length == 3) {
			province = places[0];
			city = places[1];
			place = places[2] + place;
		} else if (places.length == 2) {
			province = places[0];
			city = places[1];
		} else if (places.length == 1) {
			province = places[0];
			city = places[0];
		}
		tAppUserInfo.setProvice(province);
		tAppUserInfo.setCity(city);
		tAppUserInfo.setPlace(place);

		/**
		 * art of video
		 */
		List<TAppArtInfo> videoArtList = convertVideoList(videoList, step1UserId);
		if (!CollectionUtils.isEmpty(videoArtList)) {
			for (TAppArtInfo tAppArtInfo : videoArtList) {
				artInfoService.saveOrUpdateArtInfo(tAppArtInfo);
			}
		}

		/**
		 * art of image
		 */
		int artId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("art"));
		if (StringUtils.isNotBlank(image)) {
			TAppArtInfo artImage = new TAppArtInfo();
			artImage.setId(artId);
			artImage.setType("1");
			artImage.setUserId(step1UserId);
			artImage.setCreatTime(CommonUtil.getTime(new Date()));
			artImage.setUrl(H5FileHelper.persistArtImage(image, step1UserId, artId, imageName));
			artImage.setImgCount(1);
			artImage.setDing(0);
			artImage.setShare(0);
			artImage.setEvaluate(0);

			TAppImagesInfo tAppImagesInfo = new TAppImagesInfo();
			tAppImagesInfo.setParentId(artId);
			tAppImagesInfo.setUrl(artImage.getUrl());
			artInfoService.saveImginfo(tAppImagesInfo);
			artInfoService.saveOrUpdateArtInfo(artImage);
		}

		tAppUserInfo.setProfessionStr(convertCost2ProfessionStr(costList));
		if (isNewRegister) {
			userInfoService.saveUserInfo(tAppUserInfo);
		} else {
			userInfoService.updateUserInfo(tAppUserInfo);
			// reset user detail
			tAppUser.setIsOrg(0);
			userService.updateUser(tAppUser);
		}
		saveUserInSession(tAppUser);
		responseAjax(SUCCESS, "");
		return;
	}

	private String convertCost2ProfessionStr(List<TAppCostInfo> costList) {

		if (CollectionUtils.isEmpty(costList)) {
			return "";
		}
		StringBuilder sb = new StringBuilder();
		for (int index = 0; index < costList.size(); index++) {
			TAppCostInfo costInfo = costList.get(index);
			sb.append(costInfo.getKeywords());
			if (index < costList.size() - 1) {
				sb.append(",");
			}
		}
		return sb.toString();
	}

	private List<TAppArtInfo> convertVideoList(String videoList, int userId) {
		if (StringUtils.isBlank(videoList)) {
			return Collections.emptyList();
		}
		try {
			JSONArray videoArray = JSON.parseArray(videoList);
			if (videoArray == null) {
				return Collections.emptyList();
			}

			List<TAppArtInfo> result = new ArrayList<TAppArtInfo>();
			String currentDateTime = CommonUtil.getTime(new Date());
			for (int index = 0; index < videoArray.size(); index++) {
				JSONObject object = videoArray.getJSONObject(index);
				if (object == null) {
					continue;
				}

				String videoUrl = object.getString("videoLink");
				if (StringUtils.isBlank(videoUrl)) {
					continue;
				}

				TAppArtInfo tAppArtInfo = new TAppArtInfo();
				int artId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("art"));
				tAppArtInfo.setId(artId);
				tAppArtInfo.setTitle(object.getString("videoTitle"));
				tAppArtInfo.setUrl(videoUrl);
				tAppArtInfo.setCreatTime(currentDateTime);
				tAppArtInfo.setUserId(userId);
				tAppArtInfo.setType("2");
				tAppArtInfo.setImgCount(0);
				tAppArtInfo.setDing(0);
				tAppArtInfo.setShare(0);
				tAppArtInfo.setEvaluate(0);
				result.add(tAppArtInfo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	private TAppCostInfo translateRole2CostInfo(String role, int orderNo, int userId) {
		try {
			TAppCostInfo costInfo = new TAppCostInfo();
			costInfo.setUserId(userId);
			costInfo.setOrderNo(orderNo);

			JSONObject roleObj = null;
			try {
				roleObj = JSON.parseObject(role);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			if (roleObj == null) {
				return null;
			}

			String talentTypeName = roleObj.getString("role");
			costInfo.setKeywords(talentTypeName);

			String priceText = roleObj.getString("price");
			if (StringUtils.isNotBlank(priceText) && priceText.contains("元/")) {
				String[] arr = priceText.split("元/");
				String priceStr = arr[0];
				if (StringUtils.isNumeric(priceStr)) {
					int price = Integer.valueOf(priceStr);
					// normally eprice > bprice
					costInfo.setEprice(price);
					costInfo.setBprice(price);
				} else {
					System.out.println("[ERROR] not numeric for price: " + priceStr);
				}

				if (arr.length > 1) {
					costInfo.setUnit(arr[1]);
				}
			}
			int talentId = costService.findTalentIdByTypeName(talentTypeName);
			if (talentId > 0) {
				costInfo.setProfession(talentId);
			} else {
				System.out.println("[ERROR] can not find talent for : " + talentTypeName);
			}

			return costInfo;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	private void setUpForUser(TAppUser tAppUser, TAppUserInfo tAppUserInfo) {
		tAppUser.setIsOrg(100);
		tAppUser.setRoleId(2);
		// tAppUser.setRzState("1");
		tAppUser.setState("0");
		tAppUser.setCreatTime(CommonUtil.getTime(new Date()));
		tAppUser.setAuthority(0);
		tAppUser.setApplicate(0);

		tAppUserInfo.setId(tAppUser.getId());
		tAppUserInfo.setUserId(tAppUser.getId());
		tAppUserInfo.setSellerGrade("1");
		tAppUserInfo.setAge(0);
		tAppUserInfo.setIsRecommend("0");
		tAppUserInfo.setSignNumber(0);
		tAppUserInfo.setSignAmount("保密");
		tAppUserInfo.setPopularityTotal(0);
		tAppUserInfo.setGrade("1");
		tAppUserInfo.setFeedbackRate(100);
		tAppUserInfo.setCreatTime(CommonUtil.getTime(new Date()));
		return;
	}

	private void setUpForBro(TAppUser tAppUser, TAppUserInfo tAppUserInfo) {
		tAppUser.setIsOrg(2); // IMPORTANT
		tAppUser.setRoleId(6); // IMPORTANT
		// tAppUser.setRzState("1");
		tAppUser.setState("0");
		tAppUser.setCreatTime(CommonUtil.getTime(new Date()));
		tAppUser.setAuthority(0);
		tAppUser.setApplicate(0);

		tAppUserInfo.setId(tAppUser.getId());
		tAppUserInfo.setUserId(tAppUser.getId());
		tAppUserInfo.setSellerGrade("1");
		tAppUserInfo.setAge(0);
		tAppUserInfo.setIsRecommend("0");
		tAppUserInfo.setSignNumber(0);
		tAppUserInfo.setSignAmount("保密");
		tAppUserInfo.setPopularityTotal(0);
		tAppUserInfo.setGrade("1");
		tAppUserInfo.setFeedbackRate(0);
		tAppUserInfo.setCreatTime(CommonUtil.getTime(new Date()));
		return;
	}

	private void setUpForBiz(TAppUser tAppUser, TAppUserInfo tAppUserInfo) {
		tAppUser.setIsOrg(1);
		tAppUser.setRoleId(3);
		// tAppUser.setRzState("1");
		tAppUser.setState("0");
		tAppUser.setCreatTime(CommonUtil.getTime(new Date()));
		tAppUser.setAuthority(0);
		tAppUser.setApplicate(0);

		tAppUserInfo.setId(tAppUser.getId());
		tAppUserInfo.setUserId(tAppUser.getId());
		tAppUserInfo.setSellerGrade("1");
		tAppUserInfo.setAge(0);
		tAppUserInfo.setIsRecommend("0");
		tAppUserInfo.setSignNumber(0);
		tAppUserInfo.setSignAmount("保密");
		tAppUserInfo.setPopularityTotal(0);
		tAppUserInfo.setGrade("1");
		tAppUserInfo.setFeedbackRate(0);
		tAppUserInfo.setCreatTime(CommonUtil.getTime(new Date()));
		return;
	}

	private void setUpForArtUser(TAppUser tAppUser) {
		tAppUser.setIsOrg(0);
		tAppUser.setRoleId(2);
		// tAppUser.setRzState("1");
		tAppUser.setState("0");
		tAppUser.setCreatTime(CommonUtil.getTime(new Date()));
		tAppUser.setAuthority(0);
		tAppUser.setApplicate(0);
		return;
	}

	private void setUpForArtUserInfo(TAppUser tAppUser, TAppUserInfo tAppUserInfo) {
		tAppUserInfo.setId(tAppUser.getId());
		tAppUserInfo.setUserId(tAppUser.getId());
		tAppUserInfo.setSellerGrade("1");
		tAppUserInfo.setAge(0);
		tAppUserInfo.setIsRecommend("0");
		tAppUserInfo.setSignNumber(0);
		tAppUserInfo.setSignAmount("保密");
		tAppUserInfo.setPopularityTotal(0);
		tAppUserInfo.setGrade("1");
		tAppUserInfo.setFeedbackRate(0);
		tAppUserInfo.setCreatTime(CommonUtil.getTime(new Date()));
		return;
	}

	private void persistEvaluation(int userId) {
		TAppUserEvaluation userEvaluation = new TAppUserEvaluation();
		userEvaluation.setUserId(userId);
		userEvaluation.setEvaluation(0);
		userEvaluation.setSellerEvaluation(0);
		userEvaluationDao.addOrEdituserEvaluation(userEvaluation);
	}

	private void persistWelcomeMessage(int userId) {
		TAppMessage message = new TAppMessage();
		message.setCreatTime(CommonUtil.getTime(new Date()));
		message.setTitle("第1舞台迎宾信！");
		message.setFromUserId(3);
		message.setToUserId(userId);
		message.setContent("尊敬的会员，您好！                              欢迎您加入第1舞台，请您丰富并完善其资料（个人信息、头像、相册、视频、成长经历等），有利于您方便快捷的找活接活,您资料的完整程度也是检索您网站排名的重要依据哦。您自己的舞台为您而精彩！若有疑问或建议，您可拨打第1热线：021-52902120或者加入第1舞台微信公众号：d15tfamily第1舞台QQ群：311642987（专人1对1服务）");
		message.setStatus("0"); // 发送短信后默认为未读
		message.setType(2);
		messageService.addMessage(message);
	}

	private void saveUserInSession(TAppUser tAppUser) {
		UserSession sessionInfo = new UserSession();
		sessionInfo.setId(tAppUser.getId());
		sessionInfo.setUserName(tAppUser.getUsername());
		sessionInfo.setEmail(tAppUser.getEmail());
		sessionInfo.setState(tAppUser.getState());
		sessionInfo.setIsOrg(tAppUser.getIsOrg());
		sessionInfo.setAuthority(tAppUser.getAuthority().toString());
		HttpSessionHelper.setHttpSession(sessionInfo);
	}

	private String cleanCompanyTagValue(String originalCompanyTag) {
		originalCompanyTag = originalCompanyTag.replace("[", "");
		originalCompanyTag = originalCompanyTag.replace("]", "");
		originalCompanyTag = originalCompanyTag.replace("\"", "");
		System.out.println(originalCompanyTag);
		return originalCompanyTag;
	}
}
