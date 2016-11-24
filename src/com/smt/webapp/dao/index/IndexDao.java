package com.smt.webapp.dao.index;

import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.smt.webapp.dao.BaseDao;

@Repository
public class IndexDao extends BaseDao{
	public int getCountForUser(){
		Integer count = (Integer)getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				String hql = "select count(id) from t_app_user where creattime <= now() and creattime >= date_sub(now(),interval 12 month)";
				Integer result = Integer.valueOf(session.createSQLQuery(hql).list().get(0).toString());
				return result;
			}
		});
		return count;
	}
}
