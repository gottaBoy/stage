package com.smt.webapp.weih5;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import jxl.common.Logger;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppTaskRole;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.weih5.utils.H5DateHelper;
import com.smt.webapp.weih5.utils.H5SessionHelper;

public class H5BizTaskAction extends H5BaseAction {

	private Logger logger = Logger.getLogger(H5BizTaskAction.class);

	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private TaskService taskService;

	public String createH5BizTask() {

		/**
		 * check user - not login -> go to login page;
		 */
		HttpServletRequest request = ServletActionContext.getRequest();
		// boolean needLogin = H5SessionHelper.checkLogin(request);
		// if (needLogin) {
		// return H5LOGIN;
		// }

		int userId = H5SessionHelper.currentUserId(request);

		// get mobile;
		if (userId != 0) {
			TAppUserInfo userInfo = userInfoService.findUserInfoByUserId(userId);
			if (userInfo != null && StringUtils.isNotBlank(userInfo.getMobile())) {
				request.setAttribute("userPhone", userInfo.getMobile());
			}
		}

		String defaultDateStr = new SimpleDateFormat("yyyy-MM-dd HH:00").format(new Date());
		request.setAttribute("defaultDate", defaultDateStr);
		return SUCCESS;
	}

	public String myBizTaskList() {

		// check login
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int currUserId = H5SessionHelper.currentUserId(request);

		List<TAppTask> userBizTaskList = taskService.getBizTaskListByUserID(currUserId, 0, 50);

		// TODO fetch info for the list to display

		request.setAttribute("userBizTaskList", userBizTaskList);

		return SUCCESS;
	}

	public String myBizTaskDetail() {

		// check login
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		// get task by id;
		String taskIdStr = request.getParameter("taskId");
		if (StringUtils.isBlank(taskIdStr) || !StringUtils.isNumeric(taskIdStr)) {
			return ERROR;
		}
		int taskId = Integer.valueOf(taskIdStr);
		int currUserId = H5SessionHelper.currentUserId(request);

		List<TAppTask> tasks = taskService.getTask(taskId);

		if (tasks != null && tasks.size() > 0) {
			TAppTask task = tasks.get(0);
			request.setAttribute("bizTaskDetail", task);
		}

		return SUCCESS;
	}

	public void saveOrUpdateBizTask() {
		HttpServletRequest request = ServletActionContext.getRequest();

		// FIXME
		// boolean needLogin = H5SessionHelper.checkLogin(request);
		// if (needLogin) {
		// responseAjax(ERROR, "没有登录");
		// return;
		// }

		try {
			String typeId = request.getParameter("typeId");
			String type = request.getParameter("type");
			String name = request.getParameter("name");
			String startDate = request.getParameter("startDate");
			String timeRangeType = request.getParameter("timeRangeType");
			String budget = request.getParameter("budget");
			String userCount = request.getParameter("userCount");
			String tel = request.getParameter("tel");
			String memo = request.getParameter("memo");
			String address = request.getParameter("address");
			String roleName = request.getParameter("roleName");
//			String roleList = request.getParameter("roleList");

			System.out.println("typeId: " + typeId);
			System.out.println("type: " + type);
			System.out.println("name: " + name);
			System.out.println("startDate: " + startDate);
			System.out.println("timeRangeType: " + timeRangeType);
			System.out.println("budget: " + budget);
			System.out.println("userCount: " + userCount);
			System.out.println("tel: " + tel);
			System.out.println("memo: " + memo);
			System.out.println("address: " + address);
			System.out.println("roleName: " + roleName);

			// validation
			if (StringUtils.isBlank(type)) {
				responseAjax(ERROR, "参数错误。您没有选择委托类别。");
				return;
			}
			if ("typeMeetingTab".equals(typeId) && StringUtils.isBlank(name)) {
				responseAjax(ERROR, "参数错误，请输入活动名称。");
				return;
			}
			if ("typehunterTab".equals(typeId) && StringUtils.isBlank(roleName)) {
				responseAjax(ERROR, "参数错误，请输入角色名称。");
				return;
			}
			if (StringUtils.isBlank(startDate)) {
				responseAjax(ERROR, "参数错误，请活动开始日期。");
				return;
			}
			Date inputDate = null;
			try {
				inputDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(startDate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (inputDate == null || inputDate.before(new Date())) {
				responseAjax(ERROR, "参数错误，开始时间不正确。");
				return;
			}

			if (StringUtils.isBlank(timeRangeType)) {
				responseAjax(ERROR, "参数错误，请选择活动时长。");
				return;
			}
			if (!"2小时".equals(timeRangeType) && !"半天".equals(timeRangeType) && !"1天".equals(timeRangeType) && !"2天".equals(timeRangeType) && !"大于2天".equals(timeRangeType)) {
				responseAjax(ERROR, "参数错误，请选择一个活动时长。");
				return;
			}
			if (StringUtils.isBlank(budget) || !StringUtils.isNumeric(budget)) {
				responseAjax(ERROR, "参数错误，请输入活动预算。以数字形式。");
				return;
			}
			int inputBudget = 0;
			try {
				inputBudget = Integer.valueOf(budget);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if ("typeMeetingTab".equals(typeId) && inputBudget < 50000) {
				responseAjax(ERROR, "参数错误，活动预算50000起。请以数字形式输入。");
				return;
			}

			if (StringUtils.isBlank(userCount) || !StringUtils.isNumeric(userCount)) {
				responseAjax(ERROR, "参数错误，请输入活动人数，以数字形式输入，最少1人。");
				return;
			}
			int inputUserCount = 0;
			try {
				inputUserCount = Integer.valueOf(userCount);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (inputUserCount < 1) {
				responseAjax(ERROR, "参数错误，活动人数以数字形式输入，最少1人。");
				return;
			}

			if (StringUtils.isBlank(tel) || !StringUtils.isNumeric(tel) || 11 != tel.length()) {
				responseAjax(ERROR, "参数错误，请输入11位手机号码，方便我们与您沟通。");
				return;
			}
			if (StringUtils.isBlank(address)) {
				responseAjax(ERROR, "请选择活动地点。");
				return;
			}

			// persist the biz task;
			System.out.println("-------");
			System.out.println(inputDate);
			System.out.println(inputBudget);
			System.out.println(inputUserCount);

			SimpleDateFormat format = new SimpleDateFormat(FULL_DATE_FORMAT);
			SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date stDate = inputFormat.parse(startDate);

			TAppTask tAppTask = new TAppTask();
			if ("typeMeetingTab".equals(typeId)) {
				tAppTask.setTitle(name);
			} else {
				tAppTask.setTitle(type + " @ " + startDate);
			}

			tAppTask.setStartDate(startDate);

			int hourCount = -1;
			if ("2小时".equals(timeRangeType)) {
				hourCount = 2;
			} else if ("半天".equals(timeRangeType)) {
				hourCount = 12;
			} else if ("1天".equals(timeRangeType)) {
				hourCount = 24;
			} else if ("2天".equals(timeRangeType)) {
				hourCount = 48;
			} else {
				hourCount = 60;
			}

			tAppTask.setEndDate(inputFormat.format(H5DateHelper.calDateAfterOnHour(stDate, hourCount)));

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

			tAppTask.setProvice(province);
			tAppTask.setCity(city);
			tAppTask.setPlace(place);

			tAppTask.setPrice(budget);

			tAppTask.setMobile(tel);
			tAppTask.setUserId(H5SessionHelper.currentUserId(request));

			Date currentDate = new Date();
			tAppTask.setCreatTime(format.format(currentDate));
			tAppTask.setCreateDate(currentDate);
			tAppTask.setUpdateDate(currentDate);

			tAppTask.setActive("1");
			tAppTask.setStatus("2");
			tAppTask.setPersonCount(inputUserCount);
			tAppTask.setContent("[" + type + "] " + memo);

			taskService.suTask(tAppTask);
			
			if ("typehunterTab".equals(typeId)) {
				TAppTaskRole role = new TAppTaskRole();
				role.setRoleName(roleName);
				role.setRoleNum(inputUserCount);
				role.setPriceHigh(inputBudget);
				role.setPriceLow(inputBudget);
				role.setTAppTask(tAppTask);
				taskService.suTaskRole(role);				
			}

			responseAjax(SUCCESS, "");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("exception during saveOrUpdateBizTask");
			responseAjax(ERROR, "出错了，请稍后再试。");
		}

	}
}
