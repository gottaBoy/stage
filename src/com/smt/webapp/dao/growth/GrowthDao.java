package com.smt.webapp.dao.growth;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppUser;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class GrowthDao extends BaseDao{
	
	/**
	 * 2013-02-21 lai
	 * 通过userID查找用户成长经历
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TAppGrowth> getGrowthListByUserID(int id,int  begin,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppGrowth t where 1=1 ");
		hql.append(" and t.userId=?",id);
		hql.append(" order by t.creatTime desc");
		List<TAppGrowth> list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		
 		return list;
	}
	public int getTotal(int id,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppGrowth t where 1=1 ");
		hql.append(" and t.userId=?",id);		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	public int getTotal(int id){
		SqlAppender hql = new SqlAppender("from TAppGrowth t where 1=1 ");
		hql.append(" and t.userId=?",id);		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
	public List<TAppGrowth> getGrowthByID(int id){
		SqlAppender hql = new SqlAppender("from TAppGrowth t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppGrowth> growth = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return growth;
	}
	/**
	 * 2013-02-21 lai
	 * 保存或修改
	 * @param growthDao
	 * @return
	 */
	public void suGrowth(TAppGrowth growth){
		saveOrUpdate(growth);
	}
	
	public void delGrowth(TAppGrowth growth){
		
		delete(growth);
	}
	public void updateGrowth(TAppGrowth growthUp) {
		update(growthUp);
	}
	

}
