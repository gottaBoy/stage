package com.smt.webapp.dao.task;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppPersonTask;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class PersonTaskDao extends BaseDao{
	
	/**
	 * 2013-02-21 lai
	 * 通过userID查找需求
	 * @param id
	 * @return
	 */
	public void saveOrUpdatePersonTask(TAppPersonTask personTask){
		merge(personTask);
	}
	public List getPersonTaskList(int taskId,int userId) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("from TAppPersonTask i where 1=1 ");
		hql.append(" and i.personId=?",userId);
		hql.append(" and i.taskId=?",taskId);
		List<TAppPersonTask> list = executeQuery(hql.getPsSql(), hql.getParamsValues());

		return list;
		
	}
	public List getPersonTaskList(Integer taskId) {
		SqlAppender hql = new SqlAppender("from TAppPersonTask i, TAppUserInfo u, TAppUser us where 1=1 ");
		hql.append(" and i.personId=u.userId ");
		hql.append(" and u.userId=us.id ");
		
		hql.append(" and i.taskId=?",taskId);
		hql.append(" group by i.personId ");
		return executeQuery(hql.getPsSql(), hql.getParamsValues());
	}
	
	/**
	 * ze9fan
	 * @param taskId
	 * @return
	 */
	public List findByTaskId(int taskId) {
		SqlAppender hql = new SqlAppender("from TAppPersonTask i where 1=1 ");
		hql.append(" and i.taskId=?", taskId);
		List<TAppPersonTask> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		return list;
	}

	/**
	 * ze9fan
	 * @param taskId
	 * @param userId
	 * @param roleId
	 * @return
	 */
	public TAppPersonTask findByTaskUserAndRole(Integer taskId, Integer userId, Long roleId) {
		SqlAppender hql = new SqlAppender("from TAppPersonTask i where 1=1 ");
		hql.append(" and i.personId=?", userId);
		hql.append(" and i.taskId=?", taskId);
		hql.append(" and i.taskRoleId=?", roleId);
		List<TAppPersonTask> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		if (list == null || list.size() == 0) {
			return null;
		} else {
			return list.get(0);
		}
	}

}
