package com.smt.webapp.dao.information;

import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppInformation;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class InformationDao extends BaseDao{
	

	@SuppressWarnings("unchecked")
	public List getInformationList(int  begin,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppInformation t1,TAppInformation t2 where t1.parentId=t2.id ");
		hql.append(" and t1.parentId !=0 ");
		hql.append(" order by t1.parentId,t1.orderNo");
		List list= executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		
 		return list;
	}
	public List getInformationList(int userId,int  begin,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppInformation t  where 1=1 ");
		hql.append(" and t.userId =? ",userId);
		hql.append(" order by t.creatTime desc");
		List list= executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return list;
	}
	public List getInformationList(){
		SqlAppender hql = new SqlAppender("from TAppInformation t  where 1=1 ");
	    hql.append(" and t.parentId =0 ");
		hql.append(" order by t.orderNo");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());	
 		return list;
	}
	public List getInformationList(int userId){
		SqlAppender hql = new SqlAppender("from TAppInformation t  where 1=1 ");
		hql.append(" and t.userId =? ",userId);
		hql.append(" order by t.creatTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());	
		return list;
	}
	public int getTotal(int rowCount){
		SqlAppender hql = new SqlAppender("from TAppInformation t where 1=1 ");	
		hql.append(" and t.parentId !=0 ");
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	public int getInformationTotal(int userId){
		SqlAppender hql = new SqlAppender("from TAppInformation t where 1=1 ");	
		hql.append(" and t.userId = ? ",userId);
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
	@SuppressWarnings("unchecked")
	public List<TAppInformation> getInfoByID(int id){
		SqlAppender hql = new SqlAppender("from TAppInformation t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppInformation> info = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return info;
	}

	public void suInfo(TAppInformation info){
		saveOrUpdate(info);
	}
	
	public void delInfo(TAppInformation info){
		
		delete(info);
	}
	
	//首页关于页面，获取2级菜单数据
	public List getInformationMenu(int level){
		SqlAppender hql = new SqlAppender("from TAppInformation t where 1=1 ");
		if(level==1){
			hql.append(" and t.parentId =0 ");
		}else if(level==2){
			hql.append(" and t.parentId !=0 ");
		}
		hql.append(" order by t.orderNo ");
		List list= executeQuery(hql.getPsSql(),hql.getParamsValues());
 		return list;
	}
	public List getInformationListForOrg(int rowCount) {
		SqlAppender hql = new SqlAppender("from TAppInformation t, TAppUserInfo ui  where t.userId = ui.userId ");
		hql.append(" and t.menuName is null");
		hql.append(" order by t.creatTime desc");
		List list= executeQuery(hql.getPsSql(),hql.getParamsValues(), 0, rowCount);
		return list;
	}
	public List getInformationList(String city,String searchContent, int begin, int length) {
		SqlAppender hql = new SqlAppender("from TAppInformation t,TAppUserInfo i where t.userId = i.userId  and t.menuName is null ");	
		
		if(StringUtils.isNotBlank(city)){
			hql.append(" and ( i.provice like ? ","%"+city+"%");
			hql.append(" or i.city like ? )","%"+city+"%");
		}
		if(StringUtils.isNotBlank(searchContent)){
			hql.append(" and t.title like ? ","%"+searchContent+"%");
		}
		List list= executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, length);
		return list;
	}
	public int getInformationTotal(String city, String searchContent) {
		SqlAppender hql = new SqlAppender("from TAppInformation t,TAppUserInfo i where t.userId = i.userId and t.menuName is null ");	
		
		if(StringUtils.isNotBlank(city)){
			hql.append(" and( i.provice like ? ","%"+city+"%");
			hql.append(" or i.city like ? )","%"+city+"%");
		}
		if(StringUtils.isNotBlank(searchContent)){
			hql.append(" and t.title like ? ","%"+searchContent+"%");
		}
		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
	

}
