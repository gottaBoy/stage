package com.smt.webapp.dao.task;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppTask;
import com.smt.entity.TAppTaskRole;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class TaskRoleDao extends BaseDao {

	// 发布需求(用户任务)查询（status=2为委托发布，active=2为置顶信息，active=0为屏蔽信息） roleId=1 管理员
	public List getTaskRoleList(TAppTask task, int begin, int rowCount) {
		SqlAppender hql = new SqlAppender("from TAppTaskRole t where 1=1 ");
		hql.append(" and t.TAppTask=?", task);
		hql.append(" order by t.id");
		List list = executeQuery(hql.getPsSql(), hql.getParamsValues(), begin,
				rowCount);
		return list;
	}
	
	public TAppTaskRole findTaskRoleById(long id) {
		// TODO Auto-generated method stub
		TAppTaskRole taskRole = null;
		SqlAppender hql = new SqlAppender("from TAppTaskRole t where 1=1 ");
		hql.append(" and t.id = ?",id);
		List<TAppTaskRole> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		if(list != null && list.size() > 0){
			taskRole = list.get(0);
		}
		return taskRole;		
	}

	public void suTaskRole(TAppTaskRole task){
		saveOrUpdate(task);
	}
	
	public void delTaskRole(TAppTaskRole task){		
		delete(task);
	}

	public void delTaskRole(int id){
		String sql = "delete from t_app_task_role where id="+id;
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		try {
			tx.begin();
			session.createSQLQuery(sql).executeUpdate();
			tx.commit();
		} catch (HibernateException e) {
			tx.rollback();
			e.printStackTrace();
		}
	}
}
