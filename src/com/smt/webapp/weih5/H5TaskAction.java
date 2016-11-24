package com.smt.webapp.weih5;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.common.Logger;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppTaskRole;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.task.PersonTaskService;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.service.weih5.H5NotificationService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
import com.smt.webapp.weih5.utils.H5SessionHelper;
import com.smt.webapp.weih5.utils.H5WeixinHelper;
import com.smt.webapp.weih5.utils.H5WeixinUtils;
import com.smt.webapp.weih5.utils.HttpPostUtil;
import com.smt.webapp.weih5.vo.H5RolePersonDetailVo;
import com.smt.webapp.weih5.vo.H5RolePersonListVo;
import com.smt.webapp.weih5.vo.H5TaskInListVo;

public class H5TaskAction extends H5BaseAction {

	private Logger logger = Logger.getLogger(H5TaskAction.class);

	@Autowired
	private H5NotificationService notificationService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private PersonTaskService personTaskService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserService userService;

	@Override
	@Deprecated
	public String execute() throws Exception {
		System.out.println("the action of weih5 task...");

		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = userSession.getId();

		System.out.println("userId: " + userId);
		return SUCCESS;
	}

	/**
	 * Show creating page of H5 task
	 * 
	 * @return
	 */
	public String createH5Task() {

		/**
		 * check user - not login -> go to login page;
		 */
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		String defaultDateStr = new SimpleDateFormat("yyyy-MM-dd HH:00").format(new Date());
		request.setAttribute("defaultDate", defaultDateStr);

		return SUCCESS;
	}

	public void saveOrUpdateTask() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		try {
			/**
			 * properties from page;
			 */
			String title = request.getParameter("title");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String applyStartDate = request.getParameter("applyStartDate") + ":00";
			// String applyEndDate = request.getParameter("applyEndDate") +
			// ":00";
			String applyEndDate = applyStartDate;
			String proviceCity = request.getParameter("provinceCity");
			String place = request.getParameter("place");
			String content = request.getParameter("content");
			String roleList = request.getParameter("roleList");
			JSONArray roleJsonArray = null;
			if (StringUtils.isNotBlank(roleList)) {
				roleJsonArray = JSONArray.parseArray(roleList);
			}

			/**
			 * print for test
			 */
			System.out.println("title: " + title);
			System.out.println("startDate: " + startDate);
			System.out.println("endDate: " + endDate);
			System.out.println("applyStartDate: " + applyStartDate);
			System.out.println("applyEndDate: " + applyEndDate);
			System.out.println("proviceCity: " + proviceCity);
			System.out.println("place: " + place);
			System.out.println("content: " + content);
			System.out.println("roleList: " + roleList);

			/**
			 * validation
			 */
			if (StringUtils.isBlank(roleList) || roleJsonArray == null || roleJsonArray.size() == 0) {
				logger.error("[saveOrUpdateTask]参数错误：roleList: " + roleList);
				responseAjax(ERROR, "参数错误, 请最少添加1个角色");
				return;
			}

			// print
			for (int index = 0; index < roleJsonArray.size(); index++) {
				JSONObject roleItem = (JSONObject) roleJsonArray.get(index);
				System.out.println(roleItem.toJSONString());
			}

			if (StringUtils.isBlank(title)) {
				logger.error("[saveOrUpdateTask]参数错误：title: " + title);
				responseAjax(ERROR, "参数错误, 请输入演出名称");
				return;
			}

			if (StringUtils.isBlank(startDate)) {
				logger.error("[saveOrUpdateTask]参数错误：startDate: " + startDate);
				responseAjax(ERROR, "参数错误, 请输入演出时间");
				return;
			}

			if (StringUtils.isBlank(endDate)) {
				endDate = startDate;// there's only 1 date in page, but 2 in db.
			}

			if (StringUtils.isBlank(applyStartDate) || StringUtils.isBlank(applyEndDate)) {
				logger.error(String.format("[saveOrUpdateTask]参数错误：applyStartDate: %s, applyEndDate: %s", applyStartDate, applyEndDate));
				responseAjax(ERROR, "参数错误, 请输入应征时间");
				return;
			}

			if (StringUtils.isBlank(proviceCity) || StringUtils.isBlank(place)) {
				logger.error(String.format("[saveOrUpdateTask]参数错误：proviceCity: %s, place: %s", proviceCity, place));
				responseAjax(ERROR, "参数错误, 请输入城市和地点");
				return;
			}

			/**
			 * convert province and city
			 */
			String province = "";
			String city = "";
			String[] places = proviceCity.split(" ");
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

			// print place
			System.out.println("province:" + province);
			System.out.println("city:" + city);
			System.out.println("place:" + place);

			// roleList:
			// [{"id":"tab75119979","role":"商演主持","sex":"男","perNum":"2","total":"4000","bz":"备注"}]
			// {"total":"4000","id":"tab75119979","sex":"男","bz":"备注","perNum":"2","role":"商演主持"}

			int priceSum = 0;
			List<TAppTaskRole> taskRoleList = new LinkedList<TAppTaskRole>();
			for (int index = 0; index < roleJsonArray.size(); index++) {
				JSONObject roleItem = (JSONObject) roleJsonArray.get(index);
				String roleName = roleItem.getString("role");
				String roleDesc = roleItem.getString("role");
				String roleNum = roleItem.getString("perNum");
				String price = roleItem.getString("total");
				String sex = roleItem.getString("sex");// Hey, I know 'gender'
														// is
														// better, but for sync
														// history field, have
														// to
														// keep this field for
														// gender;
				String memo = roleItem.getString("bz");

				if (StringUtils.isNumeric(roleNum) && Integer.valueOf(roleNum) > 1 && StringUtils.isNumeric(price)) {
					price = String.valueOf(Integer.valueOf(price) / Integer.valueOf(roleNum));
				}

				TAppTaskRole taskRole = new TAppTaskRole(null, roleName, roleDesc, roleNum, price, price);
				taskRole.setSex(sex);
				taskRole.setMemo(memo);
				taskRoleList.add(taskRole);
				priceSum = priceSum + (Integer.valueOf(price) * Integer.valueOf(roleNum));
			}

			System.out.println("totle price of task: " + priceSum);

			/**
			 * properties -> task bean
			 */
			SimpleDateFormat format = new SimpleDateFormat(FULL_DATE_FORMAT);

			TAppTask task = new TAppTask();
			task.setTitle(title);

			// varchar yyyy-MM-dd HH:mm
			task.setStartDate(startDate);
			task.setEndDate(endDate);

			// datetime yyyy-MM-dd HH:mm:ss
			task.setApplyStartDate(convertString2Timestamp(applyStartDate));
			task.setApplyEndDate(convertString2Timestamp(applyEndDate));

			task.setProvice(province);
			task.setCity(city);
			task.setPlace(place);
			task.setContent(content);

			task.setUserId(HttpSessionHelper.getUserSession(request).getId());

			// varchar yyyy-MM-dd HH:mm:ss
			task.setCreatTime(format.format(new Date()));

			task.setActive("1");
			task.setStatus("1");
			task.setPersonCount(0);// 已经应征的人数

			task.setPrice(String.valueOf(priceSum));

			task.setCreateDate(new Date());
			task.setUpdateDate(new Date());

			taskService.suTask(task);

			/**
			 * task roles
			 */
			for (TAppTaskRole taskRole : taskRoleList) {
				taskRole.setTAppTask(task);
				taskService.suTaskRole(taskRole);
			}

			System.out.println("finished to save!!!");
			responseAjax(SUCCESS, "");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("exception during saveOrUpdateTask");
			responseAjax(ERROR, "出错了，请稍后再试。");
		}
	}

	private Timestamp convertString2Timestamp(String timeStr) {
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		ts = Timestamp.valueOf(timeStr);
		return ts;
	}

	
	public String myTaskList() {

		// check login
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int currUserId = H5SessionHelper.currentUserId(request);

		// // get userId
		// UserSession userSession = HttpSessionHelper.getUserSession(request);
		// // int userId = userSession.getId();
		// int userId = 1;
		// int roleId = 3;
		// String active = "100";
		// String status = "1";
		//
		// // fetch tasks by user
		// // List<TAppTask> userTaskList = taskService.getUserTaskList(roleId,
		// // userId, 0, 50, active,
		// // status, null);

		List<TAppTask> userTaskList = taskService.getTaskListByUserID(currUserId, 0, 50);
		List<H5TaskInListVo> displayTaskList = new LinkedList<H5TaskInListVo>();

		if (!CollectionUtils.isEmpty(userTaskList)) {

			// update display time
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppTask tappTask : userTaskList) {
				H5TaskInListVo h5TaskInListVo = new H5TaskInListVo();
				h5TaskInListVo.setId(tappTask.getId());
				h5TaskInListVo.setTitle(tappTask.getTitle());
				h5TaskInListVo.setPersonCount(tappTask.getPersonCount());

				if (tappTask.getCreateDate() == null) {
					h5TaskInListVo.setDisplayCreateDate(tappTask.getCreatTime().substring(0, "yyyy-MM-dd".length()));
				} else {
					h5TaskInListVo.setDisplayCreateDate(format.format(tappTask.getCreateDate()));
				}

				String taskStatus = tappTask.getStatus();
				String taskActive = tappTask.getActive();
				String displayStatus = "";
				if ("-1".equals(taskActive)) {
					displayStatus = "已关闭";
				} else if ("0".equals(taskActive)) {
					displayStatus = "审核不通过";
				} else {
					if ("1".equals(taskStatus)) {
						displayStatus = "审核中";
					} else if ("3".equals(taskStatus)) {
						displayStatus = "已发布";
					} else {
						// ERROR LOG TO TEAM
						displayStatus = "未知";
					}
				}

				h5TaskInListVo.setStatus(displayStatus);

				displayTaskList.add(h5TaskInListVo);
			}
		}

		request.setAttribute("userTaskList", displayTaskList);

		return SUCCESS;
	}

	public String myAppliedTaskList() {

		// check login
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int currUserId = H5SessionHelper.currentUserId(request);

		List<TAppTask> userTaskList = taskService.getTaskListByAppliedPersonID(currUserId);
		List<H5TaskInListVo> displayTaskList = new LinkedList<H5TaskInListVo>();

		if (!CollectionUtils.isEmpty(userTaskList)) {

			// update display time
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppTask tappTask : userTaskList) {
				H5TaskInListVo h5TaskInListVo = new H5TaskInListVo();
				h5TaskInListVo.setId(tappTask.getId());
				h5TaskInListVo.setTitle(tappTask.getTitle());
				h5TaskInListVo.setPersonCount(tappTask.getPersonCount());

				if (tappTask.getCreateDate() == null) {
					h5TaskInListVo.setDisplayCreateDate(tappTask.getCreatTime().substring(0, "yyyy-MM-dd".length()));
				} else {
					h5TaskInListVo.setDisplayCreateDate(format.format(tappTask.getCreateDate()));
				}

				String taskStatus = tappTask.getStatus();
				String taskActive = tappTask.getActive();
				String displayStatus = "";
				if ("-1".equals(taskActive)) {
					displayStatus = "已关闭";
				} else if ("0".equals(taskActive)) {
					displayStatus = "审核不通过";
				} else {
					if ("1".equals(taskStatus)) {
						displayStatus = "审核中";
					} else if ("3".equals(taskStatus)) {
						displayStatus = "已发布";
					} else {
						// ERROR LOG TO TEAM
						displayStatus = "未知";
					}
				}

				h5TaskInListVo.setStatus(displayStatus);

				displayTaskList.add(h5TaskInListVo);
			}
		}

		request.setAttribute("appliedTaskList", displayTaskList);

		return SUCCESS;

	}

	public String myArtistAppliedTaskList() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}
		int curUserId = H5SessionHelper.currentUserId(request);
		List<TAppTask> taskList = taskService.getTaskListByAppliedPersonOfBizBroID(curUserId);
		List<H5TaskInListVo> displayTaskList = new LinkedList<H5TaskInListVo>();

		if (!CollectionUtils.isEmpty(taskList)) {

			// update display time
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppTask tappTask : taskList) {
				H5TaskInListVo h5TaskInListVo = new H5TaskInListVo();
				h5TaskInListVo.setId(tappTask.getId());
				h5TaskInListVo.setTitle(tappTask.getTitle());
				h5TaskInListVo.setPersonCount(tappTask.getPersonCount());

				if (tappTask.getCreateDate() == null) {
					h5TaskInListVo.setDisplayCreateDate(tappTask.getCreatTime().substring(0, "yyyy-MM-dd".length()));
				} else {
					h5TaskInListVo.setDisplayCreateDate(format.format(tappTask.getCreateDate()));
				}

				String taskStatus = tappTask.getStatus();
				String taskActive = tappTask.getActive();
				String displayStatus = "";
				if ("-1".equals(taskActive)) {
					displayStatus = "已关闭";
				} else if ("0".equals(taskActive)) {
					displayStatus = "审核不通过";
				} else {
					if ("1".equals(taskStatus)) {
						displayStatus = "审核中";
					} else if ("3".equals(taskStatus)) {
						displayStatus = "已发布";
					} else {
						// ERROR LOG TO TEAM
						displayStatus = "未知";
					}
				}

				h5TaskInListVo.setStatus(displayStatus);

				displayTaskList.add(h5TaskInListVo);
			}
		}

		request.setAttribute("appliedTaskList", displayTaskList);
		return SUCCESS;
	}

	public String taskDetail() {

		try {
			// check login
			HttpServletRequest request = ServletActionContext.getRequest();
			// boolean needLogin = H5SessionHelper.checkLogin(request);
			// if (needLogin) {
			// return H5LOGIN;
			// }

			// get task by id;
			String taskIdStr = request.getParameter("taskId");
			if (StringUtils.isBlank(taskIdStr) || !StringUtils.isNumeric(taskIdStr)) {
				return ERROR;
			}
			int taskId = Integer.valueOf(taskIdStr);
			int currUserId = H5SessionHelper.currentUserId(request);

			// why there's a list?
			List<TAppTask> tasks = taskService.getTask(taskId);

			if (tasks != null && tasks.size() > 0) {
				TAppTask task = tasks.get(0);
				// get related roles;
				List<TAppTaskRole> taskRoles = taskService.getTaskRoleList(task, 0, 20);

				if (currUserId == 0) {
					// not login, a common view
					List<H5RolePersonListVo> rolesWithStatus = new ArrayList<H5RolePersonListVo>();
					for (TAppTaskRole role : taskRoles) {
						Long roleIdL = role.getId();
						if (roleIdL == null) {
							continue;
						}
						int roleId = roleIdL.intValue();
						H5RolePersonListVo rolePersonListVo = new H5RolePersonListVo();
						rolePersonListVo.setTaskId(taskId);
						rolePersonListVo.setRoleId(roleId);
						rolePersonListVo.setRoleName(role.getRoleName());
						rolePersonListVo.setBriefRoleName(rolePersonListVo.translateBriefRoleName(role.getRoleName()));
						rolePersonListVo.setRoleDesc(role.getRoleDesc());
						rolePersonListVo.setRoleNum(role.getRoleNum());
						rolePersonListVo.setPriceLow(role.getPriceLow());
						rolePersonListVo.setPriceHigh(role.getPriceHigh());
						rolePersonListVo.setSex(role.getSex());
						rolePersonListVo.setMemo(role.getMemo());
						rolePersonListVo.setIsReady(-2);
						rolesWithStatus.add(rolePersonListVo);
					}
					request.setAttribute("userTaskRole", rolesWithStatus);
					request.setAttribute("userTask", task);
					return SUCCESS;
				}

				if (currUserId == task.getUserId()) {

					// myTaskDetail, show the appliers;
					List<H5RolePersonListVo> rolesWithAppliers = new ArrayList<H5RolePersonListVo>();
					Map<Integer, List<H5RolePersonDetailVo>> roleIdPersonsMap = new HashMap<Integer, List<H5RolePersonDetailVo>>();
					if (task.getPersonCount() != 0) {
						List<TAppPersonTask> tAppPersonTasks = personTaskService.findByTaskId(taskId);

						for (TAppPersonTask tAppPersonTask : tAppPersonTasks) {
							int roleId = tAppPersonTask.getTaskRoleId() == null ? 0 : tAppPersonTask.getTaskRoleId().intValue();
							if (!roleIdPersonsMap.containsKey(roleId)) {
								roleIdPersonsMap.put(roleId, new ArrayList<H5RolePersonDetailVo>());
							}
							int roleUserId = tAppPersonTask.getPersonId();
							TAppUserInfo roleUserInfo = userInfoService.findUserInfoByUserId(roleUserId);
							if (roleUserInfo == null) {
								continue;
							}
							roleIdPersonsMap.get(roleId).add(new H5RolePersonDetailVo(roleUserInfo, tAppPersonTask.getCreateTime(), tAppPersonTask.getIsReady()));
						}

						for (TAppTaskRole role : taskRoles) {
							Long roleId = role.getId();
							if (roleId == null) {
								continue;
							}
							int roleIdInt = roleId.intValue();
							H5RolePersonListVo rolePersonListVo = new H5RolePersonListVo();
							rolePersonListVo.setTaskId(taskId);
							rolePersonListVo.setRoleId(roleIdInt);
							rolePersonListVo.setRoleName(role.getRoleName());
							rolePersonListVo.setApplyUserList(roleIdPersonsMap.get(roleIdInt));
							rolesWithAppliers.add(rolePersonListVo);
						}
					} else {
						for (TAppTaskRole role : taskRoles) {
							Long roleId = role.getId();
							if (roleId == null) {
								continue;
							}
							int roleIdInt = roleId.intValue();
							H5RolePersonListVo rolePersonListVo = new H5RolePersonListVo();
							rolePersonListVo.setTaskId(taskId);
							rolePersonListVo.setRoleId(roleIdInt);
							rolePersonListVo.setRoleName(role.getRoleName());
							// rolePersonListVo.setApplyUserList(roleIdPersonsMap.get(roleIdInt));
							rolesWithAppliers.add(rolePersonListVo);
						}
					}

					request.setAttribute("userTaskRole", rolesWithAppliers);
					request.setAttribute("userTask", task);
					if ("-1".equals(task.getActive())) {
						request.setAttribute("beAbleToClose", false);
						request.setAttribute("beAbleToRefuse", false);
					} else {
						request.setAttribute("beAbleToClose", true);
						request.setAttribute("beAbleToRefuse", true);
					}
					return "ownerTask";
				} else {

					// current user != createor

					List<H5RolePersonListVo> rolesWithStatus = new ArrayList<H5RolePersonListVo>();
					if (task.getPersonCount() != 0) {
						// if applied?
						List<TAppPersonTask> appliedList = personTaskService.getPersonTaskList(taskId, currUserId);
						if (!CollectionUtils.isEmpty(appliedList)) {
							Map<Integer, Integer> roleStatusMap = new HashMap<Integer, Integer>();
							for (TAppPersonTask tAppPersonTask : appliedList) {
								Long roleIdL = tAppPersonTask.getTaskRoleId();
								if (roleIdL == null) {
									continue;
								}
								int roleId = roleIdL.intValue();
								roleStatusMap.put(roleId, tAppPersonTask.getIsReady());
							}
							for (TAppTaskRole role : taskRoles) {
								Long roleIdL = role.getId();
								if (roleIdL == null) {
									continue;
								}
								int roleId = roleIdL.intValue();
								H5RolePersonListVo rolePersonListVo = new H5RolePersonListVo();
								rolePersonListVo.setTaskId(taskId);
								rolePersonListVo.setRoleId(roleId);
								rolePersonListVo.setRoleName(role.getRoleName());
								rolePersonListVo.setBriefRoleName(rolePersonListVo.translateBriefRoleName(role.getRoleName()));
								rolePersonListVo.setRoleDesc(role.getRoleDesc());
								rolePersonListVo.setRoleNum(role.getRoleNum());
								rolePersonListVo.setPriceLow(role.getPriceLow());
								rolePersonListVo.setPriceHigh(role.getPriceHigh());
								rolePersonListVo.setSex(role.getSex());
								rolePersonListVo.setMemo(role.getMemo());
								int isReady = roleStatusMap.get(roleId) == null ? -2 : roleStatusMap.get(roleId);
								rolePersonListVo.setIsReady(isReady);
								rolePersonListVo.setDisplayStatus(rolePersonListVo.displayByReadyFlag(isReady));

								rolesWithStatus.add(rolePersonListVo);
							}
						} else {
							for (TAppTaskRole role : taskRoles) {
								Long roleIdL = role.getId();
								if (roleIdL == null) {
									continue;
								}
								int roleId = roleIdL.intValue();
								H5RolePersonListVo rolePersonListVo = new H5RolePersonListVo();
								rolePersonListVo.setTaskId(taskId);
								rolePersonListVo.setRoleId(roleId);
								rolePersonListVo.setRoleName(role.getRoleName());
								rolePersonListVo.setBriefRoleName(rolePersonListVo.translateBriefRoleName(role.getRoleName()));
								rolePersonListVo.setRoleDesc(role.getRoleDesc());
								rolePersonListVo.setRoleNum(role.getRoleNum());
								rolePersonListVo.setPriceLow(role.getPriceLow());
								rolePersonListVo.setPriceHigh(role.getPriceHigh());
								rolePersonListVo.setSex(role.getSex());
								rolePersonListVo.setMemo(role.getMemo());
								rolePersonListVo.setIsReady(-2);

								rolesWithStatus.add(rolePersonListVo);
							}
						}

					} else {
						for (TAppTaskRole role : taskRoles) {
							Long roleIdL = role.getId();
							if (roleIdL == null) {
								continue;
							}
							int roleId = roleIdL.intValue();
							H5RolePersonListVo rolePersonListVo = new H5RolePersonListVo();
							rolePersonListVo.setTaskId(taskId);
							rolePersonListVo.setRoleId(roleId);
							rolePersonListVo.setRoleName(role.getRoleName());
							rolePersonListVo.setBriefRoleName(rolePersonListVo.translateBriefRoleName(role.getRoleName()));
							rolePersonListVo.setRoleDesc(role.getRoleDesc());
							rolePersonListVo.setRoleNum(role.getRoleNum());
							rolePersonListVo.setPriceLow(role.getPriceLow());
							rolePersonListVo.setPriceHigh(role.getPriceHigh());
							rolePersonListVo.setSex(role.getSex());
							rolePersonListVo.setMemo(role.getMemo());
							rolePersonListVo.setIsReady(-2);
							rolesWithStatus.add(rolePersonListVo);
						}
					}

					request.setAttribute("userTaskRole", rolesWithStatus);
					request.setAttribute("userTask", task);
					return SUCCESS;
				}
			} else {
				logger.error("no task found for the given id: " + taskId);
				return ERROR;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public void updateTaskStatus() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String taskIdStr = request.getParameter("taskId");
		if (StringUtils.isBlank(taskIdStr) || !StringUtils.isNumeric(taskIdStr)) {
			responseAjax(ERROR, "参数无效，请刷新后尝试。");
			return;
		}

		int taskId = Integer.valueOf(taskIdStr);
		int currUserId = H5SessionHelper.currentUserId(request);
		TAppTask tAppTask = taskService.findTaskById(taskId);
		if (tAppTask == null) {
			responseAjax(ERROR, "数据错误，未找到此通告。");
			return;
		}
		if (tAppTask.getUserId() != currUserId) {
			responseAjax(ERROR, "您只能删除自己创建的通告。");
			return;
		}
		tAppTask.setActive("-1");
		taskService.suTask(tAppTask);

		notificationService.send4TaskClose();

		responseAjax(SUCCESS, "错误错误");
	}

	public void refuseApplicantInTask() {

		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			boolean needLogin = H5SessionHelper.checkLogin(request);
			if (needLogin) {
				responseAjax(ERROR, "请重新登录");
				return;
			}

			String taskIdStr = request.getParameter("taskId");
			String roleIdStr = request.getParameter("roleId");
			String refuseUserIdStr = request.getParameter("userId");

			System.out.println("taskId: " + taskIdStr);
			System.out.println("roleId: " + roleIdStr);
			System.out.println("refuseUserId: " + refuseUserIdStr);

			if (StringUtils.isBlank(taskIdStr) || !StringUtils.isNumeric(taskIdStr) || StringUtils.isBlank(roleIdStr) || !StringUtils.isNumeric(roleIdStr) || StringUtils.isBlank(refuseUserIdStr) || !StringUtils.isNumeric(refuseUserIdStr)) {
				responseAjax(ERROR, "参数错误，请刷新后尝试。");
				return;
			}

			int taskId = Integer.valueOf(taskIdStr);
			int roleId = Integer.valueOf(roleIdStr);
			int refuseUserId = Integer.valueOf(refuseUserIdStr);

			TAppPersonTask tAppPersonTask = personTaskService.findByTaskUserAndRole(taskId, refuseUserId, new Long(roleId));
			if (tAppPersonTask == null) {
				responseAjax(ERROR, "数据错误，未找到此用户的应征记录。");
				return;
			}
			tAppPersonTask.setIsReady(-1);
			personTaskService.saveOrUpdatePersonTask(tAppPersonTask);

			TAppTask task = taskService.findTaskById(taskId);
			TAppTaskRole taskRole = taskService.findTaskRoleById(roleId);
			TAppUser refuseUser = userService.findUserById(refuseUserId);
			if (task != null && taskRole != null && refuseUser != null) {
				notificationService.sendRefuseNotification(taskId, task.getTitle(), taskRole.getRoleName(), refuseUser.getOpenId(),task.getCreateDate().toString());
			}

			responseAjax(SUCCESS, "");
			return;
		} catch (Exception e) {
			e.printStackTrace();
			responseAjax(ERROR, "服务端错误，请稍候再试。");
			return;
		}
	}

	public void applyTask() {

		try {
			HttpServletResponse response = ServletActionContext.getResponse();

			// check login
			HttpServletRequest request = ServletActionContext.getRequest();
			boolean needLogin = H5SessionHelper.checkLogin(request);
			if (needLogin) {
				responseAjax(ERROR, "没有登录");
			}

			int currUserId = H5SessionHelper.currentUserId(request);
			int currIsOrg = H5SessionHelper.currentIsOrgFlag(request);
			String taskIdStr = request.getParameter("taskId");
			String roleIdStr = request.getParameter("roleId");
			String artistItems = request.getParameter("artistItems");

			/**
			 * validation
			 */
			if (StringUtils.isBlank(taskIdStr) || !StringUtils.isNumeric(taskIdStr)) {
				responseAjax(ERROR, "通告ID参数错误。无法处理。");
				return;
			}
			if (StringUtils.isBlank(roleIdStr) || !StringUtils.isNumeric(roleIdStr)) {
				responseAjax(ERROR, "角色ID参数错误。无法处理。");
				return;
			}
			int taskId = Integer.valueOf(taskIdStr);
			int roleId = Integer.valueOf(roleIdStr);

			/**
			 * can not apply self task
			 */
			TAppTask currTask = taskService.findTaskById(taskId);
			if (currTask == null) {
				responseAjax(ERROR, "此通告已不存在，不能应征。");
				return;
			}
			if (currTask.getUserId() == currUserId) {
				responseAjax(ERROR, "您不可以应征自己发布的通告。");
				return;
			}
			if ("-1".equals(currTask.getActive())) {
				responseAjax(ERROR, "此通告已被发布者关闭。无法应征。");
				return;
			} else if ("0".equals(currTask.getActive())) {
				responseAjax(ERROR, "此通告未通过审核，无法应征。");
				return;
			}
			if (!"3".equals(currTask.getStatus())) {
				responseAjax(ERROR, "此通告正在审核中，请稍候应征。");
				return;
			}
			// TODO 过期

			/**
			 * process
			 */
			if (currIsOrg == 0) {
				// apply for cur user

				/**
				 * check if any
				 */
				TAppPersonTask checkPersonTask = personTaskService.findByTaskUserAndRole(taskId, currUserId, new Long(roleId));
				if (checkPersonTask != null) {
					responseAjax(ERROR, "您已应征过此角色，请等待发布者的联系。");
					return;
				}

				TAppPersonTask tAppPersonTask = new TAppPersonTask();
				tAppPersonTask.setTaskId(taskId);
				tAppPersonTask.setPersonId(currUserId);
				tAppPersonTask.setCreateTime(CommonUtil.getTime(new Date()));
				tAppPersonTask.setIsReady(0);
				tAppPersonTask.setTaskRoleId(new Long(roleId));
				personTaskService.saveOrUpdatePersonTask(tAppPersonTask);

				currTask.setPersonCount(currTask.getPersonCount() + 1);
				taskService.suTask(currTask);

				TAppUser applyUser = userService.findUserById(currUserId);
				TAppUserInfo applyUserInfo = userInfoService.findUserInfoById(currUserId);
				
				TAppTaskRole appTaskRole = taskService.findTaskRoleById(taskId);
				notificationService.sendApplyNotification(currUserId, applyUserInfo.getNickName(), taskId, currTask.getTitle(),appTaskRole.getRoleName(), applyUser.getOpenId());

//				int invitingUserId = currentUserId;
//				String invitingUserName = curUserInfo.getNickName();
//				String bizName = task.getTitle();
//				String roleName = roleBuilder.toString();
//				String invitedUserOpenId = artistUser.getOpenId();
				
				responseAjax(SUCCESS, "");

			} else {
				// cur user is biz/bro, need to apply with the artistlist

				/**
				 * validation
				 */
				if (StringUtils.isBlank(artistItems) || "[]".equals(artistItems)) {
					responseAjax(ERROR, "参数错误。无法获得要应征的艺人。");
					return;
				}
				JSONArray array = null;
				try {
					array = JSONArray.parseArray(artistItems);
				} catch (Exception e) {
					responseAjax(ERROR, "参数错误。应征艺人的数据格式错误。");
					return;
				}
				if (array == null || array.size() == 0) {
					responseAjax(ERROR, "参数错误。无法获得要应征的艺人。");
					return;
				}

				String errorMessage = "";
				for (int index = 0; index < array.size(); index++) {
					int applyUserId = array.getInteger(index);

					/**
					 * check if any
					 */
					TAppPersonTask checkPersonTask = personTaskService.findByTaskUserAndRole(taskId, applyUserId, new Long(roleId));
					if (checkPersonTask != null) {
						errorMessage = "艺人" + applyUserId + "已应征过此角色";
						continue;
					}

					TAppPersonTask tAppPersonTask = new TAppPersonTask();
					tAppPersonTask.setTaskId(taskId);
					tAppPersonTask.setPersonId(applyUserId);
					tAppPersonTask.setCreateTime(CommonUtil.getTime(new Date()));
					tAppPersonTask.setIsReady(0);
					tAppPersonTask.setTaskRoleId(new Long(roleId));
					personTaskService.saveOrUpdatePersonTask(tAppPersonTask);

					currTask.setPersonCount(currTask.getPersonCount() + 1);
					taskService.suTask(currTask);

					TAppUser curUser = userService.findUserById(applyUserId);
					TAppUserInfo curUserInfo = userInfoService.findUserInfoByUserId(applyUserId);
					TAppTaskRole appTaskRole = taskService.findTaskRoleById(taskId);
					notificationService.sendApplyNotification(applyUserId, curUserInfo.getNickName(), taskId, currTask.getTitle(),appTaskRole.getRoleName(), curUser.getOpenId());
				}
				responseAjax(SUCCESS, "");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseAjax(ERROR, "服务器太忙啦，请稍候再试...");
			return;
		}

	}

}
