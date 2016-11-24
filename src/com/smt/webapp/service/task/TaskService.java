package com.smt.webapp.service.task;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppTaskRole;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.dao.task.TaskDao;
import com.smt.webapp.dao.task.TaskRoleDao;

@Service
public class TaskService {
	@Autowired
	private TaskDao taskDao;
	@Autowired
	private TaskRoleDao taskRoleDao;

	public List<TAppTask> getTaskList(int id, int begin, int rowCount, int sign) {
		return taskDao.getTaskListByUserID(id, begin, rowCount, sign);
	}

	public int getTotal(int userID, int rowCount, int sign) {
		return taskDao.getTotal(userID, rowCount, sign);
	}

	public List<TAppTask> getTasks(int begin, int rowCount, int status,String fromWeb) {
		return taskDao.getTaskList(begin, rowCount, status,fromWeb);
	}

	public List<TAppTask> getTask(int id) {
		return taskDao.getTaskByID(id);
	}

	/**
	 * 保存用户需求
	 * 
	 * @param user
	 */
	public void suTask(TAppTask task) {
		taskDao.suTask(task);
	}

	public void suTaskRole(TAppTaskRole taskRole) {
		taskRoleDao.suTaskRole(taskRole);
	}

	public void delTask(TAppTask task) {
		taskDao.delTask(task);
	}

	public void delTaskRole(TAppTaskRole taskRole) {
		taskRoleDao.delTaskRole(taskRole);
	}

	public void delTaks(int id) {
		taskDao.delTaks(id);
	}

	public List getAllTasks() {
		List list = taskDao.getAllTask();
		return list;
	}

	public List<TAppTask> getAllNewTask() {
		List list = taskDao.getAllNewTask();
		return list;
	}
	
	public List getTaskList(int begin, int rowCount, int status) {
		return taskDao.getTaskList(begin, rowCount, status,null);
	}

	public List getTaskRoleList(TAppTask task, int begin, int rowCount) {
		return taskRoleDao.getTaskRoleList(task, begin, rowCount);
	}

	public int getMoreTotal(int rowCount, int status) {
		return taskDao.getMoreTotal(rowCount, status);
	}

	public TAppTask findTaskById(int id) {
		return taskDao.findTaskById(id);
	}

	public TAppTaskRole findTaskRoleById(long id) {
		return taskRoleDao.findTaskRoleById(id);
	}

	// 发布需求(用户任务)查询（status=1，active=1）（status=2为委托发布，active=2为置顶信息，active=0为屏蔽信息）
	public List getUserTaskList(int roleId, int userId, int begin,
			int rowCount, String active, String status,String type) {
		return taskDao.getUserTaskList(roleId, userId, begin, rowCount, active,
				status,type);
	}

	public int getUserTaskListTotal(int roleId, int userId, String active,
			String status,String type) {
		return taskDao.getUserTaskListTotal(roleId, userId, active, status,type);
	}

	public List getpersonTaskList(int taskId, int begin, int rowCount,
			int isReady) {
		return taskDao.getpersonTaskList(taskId, begin, rowCount, isReady);
	}

	public List<TAppTask> getTaskList(int taskId) {
		return taskDao.getTaskList(taskId);
	}

	public List<TAppPersonTask> getpersonTaskList(int taskId) {
		return taskDao.getpersonTaskList(taskId);
	}

	public boolean checkStartDate(String startDate, String endDate, int id,
			int userId) {
		List<TAppTask> list = taskDao.checkStartDate(startDate, endDate, id,
				userId);
		if (list != null && list.size() > 0) {
			return false; // 档期时间重叠，不允许添加
		} else {
			return true; // 档期时间不重叠，可以添加
		}
	}

	public int findTaskTotal(String city, String searchContent, int status,String fromWeb) {
		return taskDao.findTaskTotal(city,searchContent, status,fromWeb);
	}

	public List findTask(String city,String searchContent,int begin, int length, int status,String fromWeb) {
		return taskDao.findTask(city,searchContent,begin, length, status,fromWeb);
	}

	public List getUserTaskListActive(int roleId, int userId, int i,
			int rowCount, String active, String status) {
		return taskDao.getUserTaskListActive( roleId,  userId,  i,
				 rowCount,  active,  status);
	}

	public int getUserTaskListTotalActive(int roleId, int userId,
			String active, String status) {
		return taskDao.getUserTaskListTotalActive( roleId,  userId,
				 active,  status);
	}
	
	public List<TAppTask> getTaskListByUserID(int userId, int begin, int rowCount){
		return taskDao.getTaskListByUserID(userId, begin, rowCount);
	}
	
	public List<TAppTask> getBizTaskListByUserID(int userId, int begin, int rowCount){
		return taskDao.getBizTaskListByUserID(userId, begin, rowCount);
	}
	
	public List<TAppTask> getTaskListByUserID4Test(int userId, int begin, int rowCount){
		return taskDao.getTaskListByUserID4Test(userId, begin, rowCount);
	}
	
	public int countTaskSumByUserID(int userId) {
		return taskDao.countTaskSumByUserID(userId);
	}
	
	public int countBizTaskSumByUserID(int userId) {
		return taskDao.countBizTaskSumByUserID(userId);
	}
	
	public int countTaskSumByAppliedUserId(int userId) {
		return taskDao.countTaskSumByAppliedUserId(userId);
	}
	
	public List<TAppTask> getTaskListByAppliedPersonID(int personId) {
		return taskDao.getTaskListByAppliedPersonID(personId);
	}
	
	public int countTaskSumByBizBroId(int userId) {
		List<TAppTask> list = taskDao.getTaskListByAppliedPersonOfBizBroID(userId);
		return list == null ? 0 : list.size();
	}
	
	public List<TAppTask> getTaskListByAppliedPersonOfBizBroID(int personId) {
		return taskDao.getTaskListByAppliedPersonOfBizBroID(personId);
	}
	
	public boolean checkRelations(int userId, int applyId) {
		return taskDao.countByUserAndApply(userId, applyId) > 0;
	}
}
