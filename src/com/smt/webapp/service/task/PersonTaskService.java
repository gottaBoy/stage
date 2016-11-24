package com.smt.webapp.service.task;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppScheduleInfo;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.task.PersonTaskDao;
import com.smt.webapp.dao.task.TaskDao;


@Service
public class PersonTaskService {
	@Autowired
	private PersonTaskDao personTaskDao;
	public void saveOrUpdatePersonTask(TAppPersonTask personTask) {
		personTaskDao.saveOrUpdatePersonTask(personTask);
	}
	public List getPersonTaskList(int taskId,int userId) {
		return personTaskDao.getPersonTaskList(taskId,userId);
	}
	public List getPersonTaskList(Integer taskId) {
		return personTaskDao.getPersonTaskList(taskId);
	}
	
	/**
	 * ze9fan
	 * 
	 * @param taskId
	 * @param userId
	 * @param roleId
	 * @return
	 */
	public TAppPersonTask findByTaskUserAndRole(Integer taskId, Integer userId, Long roleId) {
		return personTaskDao.findByTaskUserAndRole(taskId, userId, roleId);
	}

	/**
	 * ze9fan
	 * 
	 * @param taskId
	 * @return
	 */
	public List findByTaskId(int taskId) {
		return personTaskDao.findByTaskId(taskId);
	}
}
