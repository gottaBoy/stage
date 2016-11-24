package com.smt.webapp.dao.schedule;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppScheduleInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class ScheduleInfoDao extends BaseDao {
	private static final Logger LOGGER = Logger.getLogger(ScheduleInfoDao.class);
	public List<TAppScheduleInfo> getScheduleInfoByUserId(int userId){
		SqlAppender hql = new SqlAppender("from TAppScheduleInfo i where 1=1 ");
		hql.append(" and i.userId=?",userId);
		hql.append(" order by creatTime desc");
 		List<TAppScheduleInfo> scheduleInfo = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return scheduleInfo;
	}
	
	
	public TAppScheduleInfo getScheduleInfoById(int id){
		TAppScheduleInfo scheduleInfo=null;
		SqlAppender hql = new SqlAppender("from TAppScheduleInfo i where 1=1 ");
		hql.append(" and i.id=?",id);
		List<TAppScheduleInfo> scheduleInfoList=executeQuery(hql.getPsSql(), hql.getParamsValues());
		if(scheduleInfoList != null && scheduleInfoList.size() > 0){
			scheduleInfo=scheduleInfoList.get(0);
		}
		return scheduleInfo;
	}
	
	public void addScheduleInfo(TAppScheduleInfo item){
		save(item);
	}
	
	public void updateScheduleInfo(TAppScheduleInfo item){
		update(item);
	}
	
	public void delScheduleInfo(TAppScheduleInfo item){
		delete(item);
	}
	
	//验证档期日期是否重叠(查询开始时间在其他档期时间中的记录数）
	public List<TAppScheduleInfo> checkStartDate(String startDate,String endDate,int id,int userId){
		SqlAppender hql=new SqlAppender("from TAppScheduleInfo i where 1=1");
		hql.append(" and ((i.startDate<=?",startDate);
		hql.append(" and i.endDate>?)",startDate);
		hql.append(" or (i.startDate>?",startDate);
		hql.append(" and i.startDate<?))",endDate);
		hql.append(" and i.userId=?",userId);
		if(id!=0){
			hql.append(" and i.id<>?",id);
		}
		
		List<TAppScheduleInfo> scheduleInfo = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return scheduleInfo;
	}


	public List<TAppScheduleInfo> getScheLikeYm(String ym,int id) {
		SqlAppender hql  = new SqlAppender("from TAppScheduleInfo t where 1=1 ");
		hql.append(" and t.userId =?",id);
		hql.append(" and t.startDate like ?","%"+ym+"%");
		hql.append(" and t.endDate like ?","%"+ym+"%");
		List<TAppScheduleInfo> scheduleInfo = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return scheduleInfo;
	}
	
	
	public List<TAppBusinessInfo> getSchedxYm(String ym,int id) {
//		String hql ="select a.* from t_app_schedule_info a where 1=1 and TO_DAYS(a.StartDate) = TO_DAYS('"+ym+"') and UserId="+id;
		String hql ="select a.* from t_app_business_info a where 1=1 and beginDate='"+ym+"' and status = 4 and seller="+id+" GROUP BY status";
//		hql.append(" and t.endDate >= ?",ym + " 00:00");
		Session session = getSession();
//		List<TAppScheduleInfo> scheduleInfo = session.createSQLQuery(hql).addEntity(TAppScheduleInfo.class).list();
		List<TAppBusinessInfo> scheduleInfo = session.createSQLQuery(hql).addEntity(TAppBusinessInfo.class).list();
		session.close();
		return scheduleInfo;
	}
}
