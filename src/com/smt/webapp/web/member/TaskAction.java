package com.smt.webapp.web.member;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppTaskRole;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.task.PersonTaskService;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

@Controller
public class TaskAction extends ActionSupport {

	private TAppTask task;

	public TAppTask getTask() {
		return task;
	}

	public void setTask(TAppTask task) {
		this.task = task;
	}

	private String startDate;
	private String startTime;
	private String endDate;
	private String endTime;

	private String startDate1;
	private String startTime1;
	private String endDate1;
	private String endTime1;

	private List<String> roleId;
	private List<String> roleName;
	private List<String> roleDesc;
	private List<String> roleNum;
	private List<String> priceLow;
	private List<String> priceHigh;

	private String deleteIds;

	public String getDeleteIds() {
		return deleteIds;
	}

	public void setDeleteIds(String deleteIds) {
		this.deleteIds = deleteIds;
	}

	public List getRoleId() {
		return roleId;
	}

	public void setRoleId(List roleId) {
		this.roleId = roleId;
	}

	public List getRoleName() {
		return roleName;
	}

	public void setRoleName(List roleName) {
		this.roleName = roleName;
	}

	public List getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(List roleDesc) {
		this.roleDesc = roleDesc;
	}

	public List getRoleNum() {
		return roleNum;
	}

	public void setRoleNum(List roleNum) {
		this.roleNum = roleNum;
	}

	public List getPriceLow() {
		return priceLow;
	}

	public void setPriceLow(List priceLow) {
		this.priceLow = priceLow;
	}

	public List getPriceHigh() {
		return priceHigh;
	}

	public void setPriceHigh(List priceHigh) {
		this.priceHigh = priceHigh;
	}

	public String getStartDate1() {
		return startDate1;
	}

	public void setStartDate1(String startDate1) {
		this.startDate1 = startDate1;
	}

	public String getStartTime1() {
		return startTime1;
	}

	public void setStartTime1(String startTime1) {
		this.startTime1 = startTime1;
	}

	public String getEndDate1() {
		return endDate1;
	}

	public void setEndDate1(String endDate1) {
		this.endDate1 = endDate1;
	}

	public String getEndTime1() {
		return endTime1;
	}

	public void setEndTime1(String endTime1) {
		this.endTime1 = endTime1;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Autowired
	private TaskService taskService;
	@Autowired
	private PersonTaskService personTaskService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserService userService;

	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = HttpSessionHelper.getUserSession(request).getId();

		TAppUser loginUser = userService.findUserById(userId);
		int roleId = loginUser.getRoleId();

		int pageNum = request.getParameter("pageNo") != null
				&& !"".equals(request.getParameter("pageNo")) ? Integer
				.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null
				&& !"".equals(request.getParameter("rowCount")) ? Integer
				.parseInt(request.getParameter("rowCount")) : 20;
		String active = request.getParameter("active") != null
				&& !"".equals(request.getParameter("active")) ? request
				.getParameter("active") : "100";
		String status = request.getParameter("status") != null
				&& !"".equals(request.getParameter("status")) ? request
				.getParameter("status") : "0";
		List userTaskList = taskService.getUserTaskList(roleId, userId,
				(pageNum - 1) * rowCount, rowCount, active, status,null);
		TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
		int total = taskService.getUserTaskListTotal(roleId, userId, active,
				status,null);
		pageNum = pageNum > total ? total : pageNum;
		total = total % rowCount == 0 ? total / rowCount : total / rowCount + 1;
		request.setAttribute("userTaskList", userTaskList);
		request.setAttribute("taskFromName", userInfo.getNickName());
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("active", active);
		request.setAttribute("status", status);
		request.setAttribute("roleId", roleId);
		return SUCCESS;
	}
	
	public String findZhua() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = HttpSessionHelper.getUserSession(request).getId();
		
		TAppUser loginUser = userService.findUserById(userId);
		int roleId = loginUser.getRoleId();
		
		int pageNum = request.getParameter("pageNo") != null && !"".equals(request.getParameter("pageNo")) ? Integer.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null	&& !"".equals(request.getParameter("rowCount")) ? Integer.parseInt(request.getParameter("rowCount")) : 20;
		String active = request.getParameter("active") != null	&& !"".equals(request.getParameter("active")) ? request.getParameter("active") : "100";
		String status = request.getParameter("status") != null	&& !"".equals(request.getParameter("status")) ? request.getParameter("status") : "0";
		
		List userTaskList = taskService.getUserTaskList(roleId, userId,(pageNum - 1) * rowCount, rowCount, active, status,"1");
		TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
		int total = taskService.getUserTaskListTotal(roleId, userId, active,status,"1");
		pageNum = pageNum > total ? total : pageNum;
		total = total % rowCount == 0 ? total / rowCount : total / rowCount + 1;
		
		request.setAttribute("userTaskList", userTaskList);
		request.setAttribute("taskFromName", userInfo.getNickName());
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("active", active);
		request.setAttribute("status", status);
		request.setAttribute("roleId", roleId);
		return "toWebTask";
	}

	// 应征者列表
	public String toPersonTask() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int taskId = Integer.parseInt(request.getParameter("taskId"));
		int pageNum = request.getParameter("pageNo") != null
				&& !"".equals(request.getParameter("pageNo")) ? Integer
				.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null
				&& !"".equals(request.getParameter("rowCount")) ? Integer
				.parseInt(request.getParameter("rowCount")) : 20;
		int isReady = request.getParameter("isReady") != null
				&& !"".equals(request.getParameter("isReady")) ? Integer
				.parseInt(request.getParameter("isReady")) : -1;

		List taskList = taskService.getpersonTaskList(taskId,
				(pageNum - 1) * rowCount, rowCount, isReady);
		List<TAppTask> userTaskList = taskService.getTaskList(taskId);
		TAppTask task = userTaskList.get(0);
		request.setAttribute("taskList", taskList);
		request.setAttribute("personCount", taskList.size());
		request.setAttribute("taskTitle", task.getTitle());
		
		request.setAttribute("userTaskRole", taskService.getTaskRoleList(task, 0, 20));

		return "toPersonTask";
	}
	
	// 应征者列表
	public void getPersonTaskJson() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int taskId = Integer.parseInt(request.getParameter("taskId"));
		
		int pageNum = NumberUtils.stringToInt(request.getParameter("pageNo"),0);
		int rowCount = NumberUtils.stringToInt(request.getParameter("rowCount"),10); 
		int isReady = NumberUtils.stringToInt(request.getParameter("isReady"),-1);
								
		List taskList = taskService.getpersonTaskList(taskId, pageNum * rowCount, rowCount, isReady);
		List taskListTotal = taskService.getpersonTaskList(taskId, 0, 10000, isReady);
		
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("taskList", taskList);
		resultMap.put("personCount", ((taskListTotal==null) ? 0 : taskListTotal.size()));
		
		Gson gson = new Gson();
		String result = gson.toJson(resultMap);// list为要转换为JSON对象的数据
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取审核任务
	 * 
	 * @return
	 */
	public String getList() {
		// List list = taskService.getTasks(0, 10,3);
		// ServletActionContext.getRequest().setAttribute("list", list);
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String selectVal = request.getParameter("select");
		int select = selectVal == null || selectVal.equals("") ? 1 : Integer
				.parseInt(selectVal);
		int pageNum = request.getParameter("pageNo") != null
				&& !"".equals(request.getParameter("pageNo")) ? Integer
				.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null
				&& !"".equals(request.getParameter("rowCount")) ? Integer
				.parseInt(request.getParameter("rowCount")) : 10;

		int total = taskService.getMoreTotal(rowCount, select);
		pageNum = pageNum > total ? total : pageNum;
		List taskList = taskService.getTaskList((pageNum - 1) * rowCount,
				rowCount, select);

		ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
		ServletActionContext.getRequest().setAttribute("total", total);
		ServletActionContext.getRequest().setAttribute("taskList", taskList);
		ServletActionContext.getRequest().setAttribute("select", select);
		return "verifyList";
	}

	public String getTaskList() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);

		int pageNum = request.getParameter("pageNo") != null
				&& !"".equals(request.getParameter("pageNo")) ? Integer
				.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null
				&& !"".equals(request.getParameter("rowCount")) ? Integer
				.parseInt(request.getParameter("rowCount")) : 10;
		int sign = request.getParameter("sign") == null ? 1 : Integer
				.parseInt(request.getParameter("sign"));

		int total = taskService.getTotal(userSession.getId(), rowCount, sign);
		pageNum = pageNum > total ? total : pageNum;
		List<TAppTask> taskList = taskService.getTaskList(userSession.getId(),
				(pageNum - 1) * rowCount, rowCount, sign);

		ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
		ServletActionContext.getRequest().setAttribute("total", total);
		ServletActionContext.getRequest().setAttribute("taskList", taskList);
		return "toTaskList";
	}

	public String toTask() {
		HttpServletRequest request = ServletActionContext.getRequest();

		int id = request.getParameter("id") != null
				&& !"".equals(request.getParameter("id")) ? Integer
				.parseInt(request.getParameter("id")) : 0;
		List<TAppTask> tasks = taskService.getTask(id);
		if (tasks != null && tasks.size() > 0) {
			task = tasks.get(0);
		}
		ServletActionContext.getRequest().setAttribute("task", task);

		return "toTask";
	}

	public String toView() {
		HttpServletRequest request = ServletActionContext.getRequest();

		int id = request.getParameter("id") != null
				&& !"".equals(request.getParameter("id")) ? Integer
				.parseInt(request.getParameter("id")) : 0;
		String flag = request.getParameter("flag");
		List<TAppTask> tasks = taskService.getTask(id);
		if (tasks != null && tasks.size() > 0) {
			task = tasks.get(0);
		}
		ServletActionContext.getRequest().setAttribute("task", task);

		if (flag.equals("1")) {
			return "toView1";
		}
		return "toView2";
	}

	public String suTask() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = task.getId() == null ? 0 : task.getId();
		int userId = HttpSessionHelper.getUserSession(request).getId();
		if (id == 0) {
			task.setActive("1");
			task.setStatus("2");
			task.setUserId(userId);
			task.setCreatTime(CommonUtil.getTime(new Date()));
		}
		taskService.suTask(task);
		return SUCCESS;
	}

	public String wtwmTask() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = task.getId() == null ? 0 : task.getId();
		int userId = HttpSessionHelper.getUserSession(request).getId();
		if (id == 0) {
			task.setActive("1");
			task.setStatus("2");
			task.setUserId(userId);
			task.setCreatTime(CommonUtil.getTime(new Date()));
		}
		try {
			taskService.suTask(task);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return "wtwmTaskError";
		}
		return "wtwmTaskSuccess";
	}

	public void delTask() {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id") != null
				&& !"".equals(request.getParameter("id")) ? Integer
				.parseInt(request.getParameter("id")) : 0;

		TAppTask task = new TAppTask();
		task.setId(id);
		taskService.delTask(task);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getAllTask() {
		List list = taskService.getTasks(0, 18, 3,null);
		ServletActionContext.getRequest().setAttribute("list", list);
		return "indexTask";
	}

	public String toTaskMore() {

		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);

		int pageNum = request.getParameter("pageNo") != null
				&& !"".equals(request.getParameter("pageNo")) ? Integer
				.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null
				&& !"".equals(request.getParameter("rowCount")) ? Integer
				.parseInt(request.getParameter("rowCount")) : 10;

		int total = taskService.getMoreTotal(rowCount, 3);
		pageNum = pageNum > total ? total : pageNum;
		List taskList = taskService.getTaskList((pageNum - 1) * rowCount,
				rowCount, 3);

		ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
		ServletActionContext.getRequest().setAttribute("total", total);
		ServletActionContext.getRequest().setAttribute("taskList", taskList);
		return "toTaskMore";
	}

	public String toTaskMoreDetailOld() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = request.getParameter("id") != null
				&& !"".equals(request.getParameter("id")) ? Integer
				.parseInt(request.getParameter("id")) : 0;
		List<TAppTask> tasks = taskService.getTask(id);
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		List<TAppTaskRole> taskRoles = null;

		if (tasks != null && tasks.size() > 0) {
			task = tasks.get(0);
			taskRoles = taskService.getTaskRoleList(task, 0, 20);
			request.setAttribute("userTaskRole", taskRoles);
		}

		if (userSession != null) {
			int userId = userSession.getId();
			List<TAppPersonTask> pList = personTaskService.getPersonTaskList(
					id, userId);
			boolean foundFlag = false;
			if (taskRoles != null) {
				for (TAppTaskRole ttr : taskRoles) {
					foundFlag = false;
					for (TAppPersonTask tpt : pList) {
						if (ttr.getId().equals(tpt.getTaskRoleId())) {
							foundFlag = true;
							break;
						}
					}
					if (foundFlag)
						request.setAttribute("yzFlag_" + ttr.getId(), 1);
					else
						request.setAttribute("yzFlag_" + ttr.getId(), 0);
				}
			}
			if (pList.size() > 0) {
				if (taskRoles == null ||taskRoles.size()<1)
					request.setAttribute("yzFlag", pList.size());
			}
			TAppUser user = userService.getUserById(userId);
			int isOrg = user.getIsOrg();
			request.setAttribute("isOrg", isOrg);
		}

		if (tasks != null && tasks.size() > 0) {
			TAppUserInfo userInfo = new TAppUserInfo();
			userInfo = userInfoService.findUserInfoByUserId(task.getUserId());
			TAppUser tAppUser = new TAppUser();
			tAppUser = userService.getUserById(task.getUserId());
			request.setAttribute("user", tAppUser);
			request.setAttribute("userInfo", userInfo);
		}

		return "toTaskMoreDetail";
	}
	
	//查看任务详情
	public String toTaskMoreDetail() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		List<TAppTask> tasks = taskService.getTask(id);
		
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		List<TAppTaskRole> taskRoles = null;
		
		//任务的角色列表
		if (tasks != null && tasks.size() > 0) {
			task = tasks.get(0);
			taskRoles = taskService.getTaskRoleList(task, 0, 20);
			request.setAttribute("userTaskRole", taskRoles);
		}
		
		//登录用户已经应征过的角色
		if (userSession != null) {
			int userId = userSession.getId();
			List<TAppPersonTask> pList = personTaskService.getPersonTaskList(
					id, userId);
			boolean foundFlag = false;
			if (taskRoles != null) {
				for (TAppTaskRole ttr : taskRoles) {
					foundFlag = false;
					for (TAppPersonTask tpt : pList) {
						if (ttr.getId().equals(tpt.getTaskRoleId())) {
							foundFlag = true;
							break;
						}
					}
					if (foundFlag)
						request.setAttribute("yzFlag_" + ttr.getId(), 1);
					else
						request.setAttribute("yzFlag_" + ttr.getId(), 0);
				}
			}
			if (pList.size() > 0) {
				if (taskRoles == null ||taskRoles.size()<1)
					request.setAttribute("yzFlag", pList.size());
			}
			TAppUser user = userService.getUserById(userId);
			int isOrg = user.getIsOrg();
			request.setAttribute("isOrg", isOrg);
		}
		
		if (tasks != null && tasks.size() > 0) {
			TAppUserInfo userInfo = new TAppUserInfo();
			userInfo = userInfoService.findUserInfoByUserId(task.getUserId());
			TAppUser tAppUser = new TAppUser();
			tAppUser = userService.getUserById(task.getUserId());
			request.setAttribute("user", tAppUser);
			

			
			if(tAppUser != null){
				List<TAppBusinessEvaluate> scoresList = userService.getScore(userInfo.getUserId(),tAppUser.getIsOrg());
				String goodRateStr = "";
				if(CollectionUtils.isEmpty(scoresList)){
					goodRateStr = "尚未完成交易"; //""+userInfo.getFeedbackRate()
				}else{
					int totalRemarksTimes = scoresList.size();
					int goodRemarksTimes = 0;
					
					for (TAppBusinessEvaluate tAppBusinessEvaluate : scoresList) {
						if(NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getPjGrade(),StringUtils.EMPTY),0)==1){
							goodRemarksTimes++;
						}
					}
					//好评率：
					long goodRate = Math.round(goodRemarksTimes*100.0/totalRemarksTimes*1.0);
					goodRateStr = Long.toString(goodRate)+"%"; 
				}
				userInfo.setGrade(goodRateStr);
			}
			request.setAttribute("userInfo", userInfo);
			
			
			
			
			//该用户的其他任务
			int roleId = tAppUser.getRoleId();

			String active = StringUtils.defaultIfEmpty(request.getParameter("active"), "100");
			String status = StringUtils.defaultIfEmpty(request.getParameter("status"), "3"); 
			
			
			String fromWeb = request.getParameter("fromWeb");
			List userTaskList = taskService.getTasks(0, 10, 3,fromWeb);//taskService.getUserTaskListActive(roleId, task.getUserId(),0 , 1000, active, status);

			request.setAttribute("userTaskList", userTaskList);
			
			
			//应征该任务的艺人
			task = tasks.get(0);
			List personList = personTaskService.getPersonTaskList(task.getId());
			
			if(personList!=null){
				int isOrg = 0;
				for(int i=0; i<personList.size();i++){
					Object[] objArr = (Object[])personList.get(i);
					TAppUserInfo tAppUserInfo = (TAppUserInfo)objArr[1];
					
					List<TAppBusinessEvaluate> scoresList = userService.getScore(tAppUserInfo.getUserId(),isOrg);
					String goodRateStr = "";
					if(CollectionUtils.isEmpty(scoresList)){
						goodRateStr = "尚未完成交易"; //""+userInfo.getFeedbackRate()
					}else{
						int totalRemarksTimes = scoresList.size();
						int goodRemarksTimes = 0;
						
						for (TAppBusinessEvaluate tAppBusinessEvaluate : scoresList) {
							if(NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getPjGrade(),StringUtils.EMPTY),0)==1){
								goodRemarksTimes++;
							}
						}
						//好评率：
						long goodRate = Math.round(goodRemarksTimes*100.0/totalRemarksTimes*1.0);
						goodRateStr = Long.toString(goodRate)+"%"; 
					}
					tAppUserInfo.setGrade(goodRateStr);
				}
			}
				
			request.setAttribute("personList", personList);
		}
		
		
		if(StringUtils.equals("1", request.getParameter("fromWeb"))){
			return "toTaskMoreDetailFromWeb";
		}else{
			return "toTaskMoreDetail";
		}
		
	}

	public String addTaskByOrg() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int taskId = request.getParameter("taskId") == null ? 0 : Integer
				.parseInt(request.getParameter("taskId"));
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = userSession.getId();
		int pageNum = request.getParameter("pageNo") != null
				&& !"".equals(request.getParameter("pageNo")) ? Integer
				.parseInt(request.getParameter("pageNo")) : 1;
		int rowCount = request.getParameter("rowCount") != null
				&& !"".equals(request.getParameter("rowCount")) ? Integer
				.parseInt(request.getParameter("rowCount")) : 10;

		List userInfoList = userInfoService.getUserInfoByorgId1(userId,
				(pageNum - 1) * rowCount, rowCount);
		int total = userInfoService.getUserInfoByorgIdTotal1(userId);
		List<TAppPersonTask> personTaskList = taskService
				.getpersonTaskList(taskId);
		List userList = userInfoService.getUserInfoByorgId2(userId,
				(pageNum - 1) * rowCount, rowCount, taskId);
		// System.out.println(personTaskListString);
		request.setAttribute("userInfoList", userInfoList);
		request.setAttribute("total", total);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("rowCount", rowCount);
		request.setAttribute("taskId", taskId);
		request.setAttribute("personTaskList", personTaskList);
		request.setAttribute("userList", userList);

		return "addTaskByOrg";
	}

	public void checkTask() {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = Integer.parseInt(request.getParameter("id"));
		String flag = request.getParameter("flag");
		TAppTask task = taskService.findTaskById(id);
		task.setActive(flag);
		taskService.suTask(task);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String toUpdateUserTask() {
		HttpServletRequest request = ServletActionContext.getRequest();

		int id = request.getParameter("id") != null
				&& !"".equals(request.getParameter("id")) ? Integer
				.parseInt(request.getParameter("id")) : 0;
		List<TAppTask> tasks = taskService.getTask(id);
		if (tasks != null && tasks.size() > 0) {
			task = tasks.get(0);
			List<TAppTaskRole> taskRoles = taskService.getTaskRoleList(task, 0,
					20);
			request.setAttribute("userTaskRole", taskRoles);
			// task.setTAppTaskRoles(new HashSet(taskRoles));
		}
		String active = task.getActive();
		request.setAttribute("active", active);
		request.setAttribute("userTask", task);
		request.setAttribute("status", task.getStatus());

		return "toUpdateUserTask";
	}

	public String toUpdateUserTask2() {
		HttpServletRequest request = ServletActionContext.getRequest();

		int id = request.getParameter("id") != null
				&& !"".equals(request.getParameter("id")) ? Integer
				.parseInt(request.getParameter("id")) : 0;
		List<TAppTask> tasks = taskService.getTask(id);
		if (tasks != null && tasks.size() > 0) {
			task = tasks.get(0);
			List<TAppTaskRole> taskRoles = taskService.getTaskRoleList(task, 0,
					20);
			request.setAttribute("userTaskRole", taskRoles);
		}
		String active = task.getActive();
		request.setAttribute("active", active);
		request.setAttribute("userTask", task);

		return "toUpdateUserTask2";
	}

	public String updateUserTask() {
		// String startDate1 = startDate;
		// String startTime1 = startTime;
		// String endDate1 = endDate;
		// String endTime1 = endTime;

		HttpServletRequest request = ServletActionContext.getRequest();
		// UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = HttpSessionHelper.getUserSession(request).getId();
		// TAppUser loginUser = userService.findUserById(userId);

		String type = request.getParameter("type");
		if(StringUtils.equals("1", type)){
			task.setFromWeb("1");
		}

		
		TAppTask ta = taskService.findTaskById(task.getId());
		if (ta.getUserId().equals(userId)) {

			if(!StringUtils.equals("1", type)){
				String startDateTime = startDate + " " + startTime;
				String endDateTime = endDate + " " + endTime;
				String applyStartDate = startDate1 + " " + startTime1 + ":00";
				String applyEndDate = endDate1 + " " + endTime1 + ":00";
				Timestamp ts = new Timestamp(System.currentTimeMillis());
				try {
					ts = Timestamp.valueOf(applyStartDate);
					// System.out.println(ts);
				} catch (Exception e) {
					e.printStackTrace();
				}
				task.setApplyStartDate(ts);
	
				ts = new Timestamp(System.currentTimeMillis() + 24 * 60 * 60 * 1000
						* 30);
				try {
					ts = Timestamp.valueOf(applyEndDate);
					// System.out.println(ts);
				} catch (Exception e) {
					e.printStackTrace();
				}
				task.setApplyEndDate(ts);
				

				task.setStartDate(startDateTime);
				task.setEndDate(endDateTime);
			}
			

			task.setActive("1");
			task.setStatus("1");
			task.setPersonCount(0);
			taskService.suTask(task);

			if (roleName != null && roleDesc != null && roleId != null
					&& roleNum != null && priceLow != null && priceHigh != null) {

				if (roleId.size() == roleName.size()
						&& roleName.size() == roleDesc.size()
						&& roleDesc.size() == roleNum.size()
						&& roleNum.size() == priceLow.size()
						&& priceLow.size() == priceHigh.size()) {

					for (int i = 0; i < roleName.size(); i++) {
						TAppTaskRole ttr = null;
						if (roleName.get(i) != null && roleDesc.get(i) != null) {

							if (roleId.get(i) != null) {
								try {
									long id = Long.parseLong(roleId.get(i));
									if (id > 0) {
										ttr = taskService.findTaskRoleById(id);
										if (!ttr.getTAppTask().getId()
												.equals(task.getId())) {
											ttr = null;
										}
									}
								} catch (Exception e) {
								}
							}
							if (ttr == null) {
								ttr = new TAppTaskRole(task, roleName.get(i),
										roleDesc.get(i), roleNum.get(i),
										priceLow.get(i), priceHigh.get(i));
							} else {
								ttr.setRoleName(roleName.get(i));
								ttr.setRoleDesc(roleDesc.get(i));
								ttr.setRoleNum(roleNum.get(i));
								ttr.setPriceLow(priceLow.get(i));
								ttr.setPriceHigh(priceHigh.get(i));
							}
							taskService.suTaskRole(ttr);
						}
					}
				}
			}

			if (deleteIds.length() > 0) {
				String[] ids = deleteIds.split(",");
				for (String id : ids) {
					if (id.length() > 0) {
						try {
							long id1 = Long.parseLong(id);
							if (id1 > 0) {
								TAppTaskRole tat = taskService
										.findTaskRoleById(id1);
								if (tat.getTAppTask().getId()
										.equals(task.getId())) {
									taskService.delTaskRole(tat);
								}
							}

						} catch (Exception e) {
						}
					}
				}
			}
		}
		return "updateUserTask";
	}

	public String toAddUserTask() {
		return "toAddUserTask";
	}
	public String toAddWebTask() {
		return "toAddWebTask";
	}

	//public String addUserTask() {
	public void addUserTask() {
		HttpServletRequest request = ServletActionContext.getRequest();

		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String createDateTime = df.format(new Date());// new Date()为获取当前系统时间

		//抓取的内容
		String type = request.getParameter("type");
		if(StringUtils.equals("1", type)){
			task.setFromWeb("1");
		}
		
		// String startDate1=startDate;
		// String startTime1=startTime;
		// String endDate1=endDate;
		// String endTime1=endTime;
		String startDateTime = startDate + " " + startTime;
		String endDateTime = endDate + " " + endTime;
		task.setStartDate(startDateTime);
		task.setEndDate(endDateTime);
		task.setUserId(HttpSessionHelper.getUserSession(request).getId());
		task.setCreatTime(createDateTime);
		task.setActive("1");
		task.setStatus("1");
		task.setPersonCount(0);
		
		String applyStartDate = startDate1 + " " + startTime1 + ":00";
		String applyEndDate = endDate1 + " " + endTime1 + ":00";
		if(startDate1 != null){
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			try {
				ts = Timestamp.valueOf(applyStartDate);
				// System.out.println(ts);
			} catch (Exception e) {
				e.printStackTrace();
			}
			task.setApplyStartDate(ts);
		}

		if(endDate1 != null){
			Timestamp ts = new Timestamp(System.currentTimeMillis() + 24 * 60 * 60 * 1000 * 30);
			try {
				ts = Timestamp.valueOf(applyEndDate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			task.setApplyEndDate(ts);
		}

		taskService.suTask(task);

		// System.out.println("get Task=" + task.getId());

		if (roleName != null && roleDesc != null && roleId != null
				&& roleNum != null && priceLow != null && priceHigh != null) {

			if (roleName.size() == roleDesc.size()
					&& roleDesc.size() == roleNum.size()
					&& roleNum.size() == priceLow.size()
					&& priceLow.size() == priceHigh.size()) {

				// System.out.println("get roleDesc=" + roleDesc + "  size"
				// + roleDesc.size());

				TAppTaskRole ttr = null;
				for (int i = 0; i < roleName.size(); i++) {

					if (roleName.get(i) != null && roleDesc.get(i) != null) {
						ttr = new TAppTaskRole(task, roleName.get(i),
								roleDesc.get(i), roleNum.get(i),
								priceLow.get(i), priceHigh.get(i));
						taskService.suTaskRole(ttr);
					}
				}
			}
		}
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//return "addUserTask";
	}

	public void addPersonTask() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String d = request.getParameter("userId");
		int userId = request.getParameter("userId") != null
				&& !"".equals(request.getParameter("userId")) ? Integer
				.parseInt(request.getParameter("userId")) : 0;
		if (userId == 0) {
			userId = userSession.getId();
		}

		int taskId = Integer.parseInt(request.getParameter("taskId"));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String createDateTime = df.format(new Date());// new Date()为获取当前系统时间
		TAppPersonTask tAppPersonTask = new TAppPersonTask();
		tAppPersonTask.setCreateTime(createDateTime);
		tAppPersonTask.setPersonId(userId);
		tAppPersonTask.setTaskId(taskId);
		tAppPersonTask.setIsReady(0);
		long taskRoleId = 0;
		try {
			taskRoleId = Long.parseLong(request.getParameter("taskRoleId"));
		} catch (Exception e) {

		}
		tAppPersonTask.setTaskRoleId(taskRoleId);

		try {
			personTaskService.saveOrUpdatePersonTask(tAppPersonTask);
			List<TAppTask> taskList = taskService.getTaskList(taskId);
			TAppTask task = taskList.get(0);
			task.setPersonCount(task.getPersonCount() + 1);
			taskService.suTask(task);
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String checkStartDate() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int userId = userSession.getId();
		String startDate = request.getParameter("startDate").toString();
		String endDate = request.getParameter("endDate").toString();
		int id = request.getParameter("id") == null ? 0 : Integer
				.parseInt(request.getParameter("id").toString());
		try {
			if (taskService.checkStartDate(startDate, endDate, id, userId)) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public void delUserTask() {

		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = HttpSessionHelper.getUserSession(request).getId();

		if ((task.getUserId().intValue() == userId) || (userId==2)) { //admin01

			List<TAppTaskRole> taskRoles = taskService.getTaskRoleList(task, 0,	50);
			if (taskRoles != null) {
				for (TAppTaskRole id : taskRoles) {
					taskService.delTaskRole(id);
				}
			}

			taskService.delTask(task);
		}
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String delTaks() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String idPara = request.getParameter("id");
		int id = idPara == null || idPara.equals("") ? 0 : Integer
				.parseInt(idPara);
		if (id == 0) {
			response.getWriter().print("0");
			response.getWriter().close();
			return null;
		}
		taskService.delTaks(id);
		response.getWriter().print("1");
		response.getWriter().close();
		return null;
	}

	public void overUserTask() {
		int id = task.getId();
		TAppTask findTask = taskService.findTaskById(id);

		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = HttpSessionHelper.getUserSession(request).getId();

		if (findTask.getUserId().intValue()== userId) {
			findTask.setActive("-1"); // active=0，管理员屏蔽；action=1，普遍显示；action=2，置顶；action=-1，用户自己结束任务
			taskService.suTask(findTask);
		}else{
			//admin01
			if(userId==2){
				findTask.setActive("0"); // active=0，管理员屏蔽；action=1，普遍显示；action=2，置顶；action=-1，用户自己结束任务
				taskService.suTask(findTask);
			}
		}
		
		//return "updateUserTask";
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String verify() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String status = request.getParameter("status");
		int id = task.getId();
		TAppTask findTask = taskService.findTaskById(id);
		findTask.setStatus(status);
		taskService.suTask(findTask);
		response.getWriter().print("1");
		response.getWriter().close();
		return null;
	}

}
