package com.smt.webapp.dao.poster;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppPoster;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class PosterDao extends BaseDao {
	
	public List getList(int  begin,int rowCount,int sign ,String type){
		SqlAppender hql = new SqlAppender("from TAppPoster");
		hql.append(" where pis=?",1);
		hql.append(" and ptype=?",type);
		return executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
	}
	
	public List getVOByID(int id,String type){
		SqlAppender hql = new SqlAppender("from TAppPoster");
		hql.append(" where pid=?",id);
		hql.append(" and PTYPE=?",type);
		return executeQuery(hql.getPsSql(),hql.getParamsValues());
	}
	
	public void addOrUpPoster(TAppPoster poster){
		save(poster);
	}
	
	public void updateByVO(TAppPoster poster){
		update(poster);
	}
}		
