package com.smt.webapp.dao.top;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppTop;
import com.smt.entity.TAppTopImg;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class TopDao extends BaseDao {
	public  List<TAppTop> getListForTop(int  begin,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppTop");
		hql.append(" where status=?","1");
		return executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
	}
	public  List<TAppTopImg> getListForTopImg(int  begin,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppTopImg");
		return executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
	}
	
	public TAppTop getTopById(Integer id){
		SqlAppender hql = new SqlAppender("from TAppTop");
		hql.append(" where tid=?",id);
		return (TAppTop) executeQuery(hql.getPsSql(),hql.getParamsValues()).get(0);
	}
	
	
	public void addTop(TAppTop top,List<TAppTopImg> imgs){
		Session session = getHibernateSession();
		Transaction tx  = null;
		try {
			tx = session.beginTransaction();
			save(top);
			for (TAppTopImg tAppTopImg : imgs) {
				tAppTopImg.getTpid().setTid(top.getTid());
				save(tAppTopImg);
			}
			tx.commit();
		} catch (HibernateException e) {
			if(tx != null) tx.rollback();
			e.printStackTrace();
		}finally{
			session.close();
		}
	}
	
	public void updateTop(TAppTop top,List<TAppTopImg> imgs){
		Session session = getHibernateSession();
		Transaction tx  = null;
		try {
			tx = session.beginTransaction();
			update(top);
			for (TAppTopImg tAppTopImg : imgs) {
				update(tAppTopImg);
			}
			tx.commit();
		} catch (HibernateException e) {
			if(tx != null) tx.rollback();
			e.printStackTrace();
		}finally{
			session.close();
		}
	}
}
