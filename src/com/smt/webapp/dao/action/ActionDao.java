package com.smt.webapp.dao.action;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppAction;
import com.smt.entity.TBaseArea;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class ActionDao extends BaseDao{
	
	/**
	 * 获取演员演出时间
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TAppAction> getActionForUserId(int userId,String date){
		System.err.println("date:"+date);
		String sql = "select * from t_app_action where userid="+userId+" and to_days(startdate) = to_days('"+date+"')";
		Session session = getHibernateSession();
		SQLQuery query = session.createSQLQuery(sql).addEntity(TAppAction.class);
		List<TAppAction> list = null;
		list = (List<TAppAction>)query.list();
		session.clear( );
		session.close();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<TBaseArea> getProvins(){
		String sql = "select * from t_base_area where rootid=0 and astatus=1 ";
		Session session = getHibernateSession();
		SQLQuery query = session.createSQLQuery(sql).addEntity(TBaseArea.class);
		List<TBaseArea> list = null;
		list = query.list();
		session.clear( );
		session.close();
		return list;
	}
	
	public List<TBaseArea> getCity(int id){
		String sql = "select * from t_base_area where rootid="+id;
		Session session = getHibernateSession();
		SQLQuery query = session.createSQLQuery(sql).addEntity(TBaseArea.class);
		List<TBaseArea> list = null;
		list = query.list();
		session.clear( );
		session.close();
		return list;
	}
}
