package com.smt.webapp.dao.cost;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppTalentCategory;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class CostDao extends BaseDao{

	public List getCostInfooByUserId(int userID, int orderId){
		SqlAppender hql = new SqlAppender("");
		if(orderId != 0) {
			hql = new SqlAppender("from TAppBusinessCost bc,TAppTalentCategory c  where c.id=bc.costId and ");
			hql.append("  orderId=?",orderId);
		} else {
			hql = new SqlAppender("from TAppCostInfo t ,TAppTalentCategory c  where c.id=t.profession ");
			hql.append(" and t.userId=?",userID);
			hql.append(" order by t.orderNo ");
		}
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list;
	}
	
	//根据用户ID获取用户职业
	public List getCostListByUserId(int userID){
		SqlAppender hql = new SqlAppender("");
		hql = new SqlAppender("select t from TAppCostInfo t where 1=1");
		hql.append(" and t.userId=?",userID);
		hql.append(" order by t.orderNo ");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
		return list;
	}
  //根据用户ID获取用户职业
  public List getCostListByUserId(int userID, int begin, int rowCount) {
    SqlAppender hql = new SqlAppender("");
    hql = new SqlAppender("select t from TAppCostInfo t where 1=1");
    hql.append(" and t.userId=?", userID);
    hql.append(" order by t.orderNo ");
    List list = executeQuery(hql.getPsSql(), hql.getParamsValues(), begin, rowCount);
    return list;
  }


	public TAppTalentCategory getTAppTalentCategory(int id) {
		
		SqlAppender hql = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppTalentCategory> list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		TAppTalentCategory t = null;
		if(list != null && list.size() > 0) {
			t = list.get(0);
		}
		
		return t;
	}
	
	public List getCostInfoByBusinessId(int id){
//		List list = getSession().createSQLQuery("AND ci.yrUserId = cio.UserId AND cio.Profession = tc.ID").list();
//		TAppCompanyInfo TAppCostInfo TAppTalentCategory
		SqlAppender hql = new SqlAppender(" FROM TAppCostInfo cio, TAppCompanyInfo ci WHERE ci.type = 3 ");
		hql.append(" AND ci.businessId = ?",id);
		hql.append(" AND ci.yrUserId = cio.userId AND cio.orderNo = 1 and cio.eprice!='' and cio.bprice!=''  and cio.unit!='0' ");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
//		HashMap<String, String> map = new HashMap<String, String>();
//		map.put("cishu", "111");
//		for (int i = 0; i < list.size(); i++) {
//			list.set(arg0, arg1)
//		}
//		
//		for (int i = 0; i < list.size(); i++) {
//			TAppCostInfo costInfo = null;
//			costInfo = list.get(i);
//			SqlAppender hql1 = new SqlAppender(" FROM TAppTalentCategory WHERE  ");
//			hql1.append(" id = ?",costInfo.getProfession());
//			List<TAppTalentCategory> list1 = executeQuery(hql1.getPsSql(),hql1.getParamsValues());
//			TAppTalentCategory talentCategory = list1.get(0);
//			HashMap<String, String> map = new HashMap<String, String>();
//			map.put("pro", talentCategory.getTypeName());
//			list.get(i).add(map);
//
//		}
		return list;
	}

	public List<TAppCostInfo> getCostInfoByID(int id) {
		
		SqlAppender hql = new SqlAppender("from TAppCostInfo t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppCostInfo> list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list;
	}

	public void saveCost(TAppCostInfo costInfo) {
		
		// TODO Auto-generated method stub
		saveOrUpdate(costInfo);
	}
	public List getSelectedTalentByParentId(int flag,int userId,int currentVal){
		SqlAppender hql = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql.append(" and t.parentId=?",flag);
		//hql.append(" and t.id not in (select c.profession from TAppCostInfo c where c.userId=?)",userId);
		List<TAppTalentCategory> list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		//是否选择用searchTime代替，因为javabean不能加属性，加了报sql错误。
		for (TAppTalentCategory tAppTalentCategory : list) {
			if(tAppTalentCategory.getId()==currentVal){
				tAppTalentCategory.setSearchTime(1);
			}else{
				tAppTalentCategory.setSearchTime(0);
			}
		}
		
		return list;

	}
	public List getTalentByFlag(int flag,int userId){
		SqlAppender hql = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql.append(" and t.parentId=?",flag);
		//hql.append(" and t.id not in (select c.profession from TAppCostInfo c where c.userId=?)",userId);
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list;

	}
	public void delCostInfo(TAppCostInfo costInfo){
		
		delete(costInfo);
	}
	public int getMaxOrderNo(int userId){
		
		int orderNo=1;
		SqlAppender hql = new SqlAppender("select max(t.orderNo) from TAppCostInfo t where 1=1  ");
		hql.append(" and t.userId=?",userId);
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		if(list.get(0)!=null){
			orderNo = Integer.parseInt(String.valueOf(list.get(0)))+1 ;
		}
		return orderNo;
	}
	public int getOrderNoById(int id){
		
		SqlAppender hql = new SqlAppender("from TAppCostInfo t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppCostInfo> list = executeQuery(hql.getPsSql(),hql.getParamsValues());

		return list.get(0).getOrderNo();
	}
    public String getCostForUpdate(String profession){
		
		SqlAppender hql_1 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql_1.append(" and t.id=?",Integer.parseInt(profession));
		List<TAppTalentCategory> list1 = executeQuery(hql_1.getPsSql(),hql_1.getParamsValues());
		
		String cost1="";
		String cost2="";
		String cost3="";		
		SqlAppender hql_2 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql_2.append(" and t.id=?",list1.get(0).getParentId());
		List<TAppTalentCategory> list2 = executeQuery(hql_2.getPsSql(),hql_2.getParamsValues());

		List<TAppTalentCategory> list3=null;
		if(list2!=null&&list2.size()>0){
			SqlAppender hql_3 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
			hql_3.append(" and t.id=?",list2.get(0).getParentId());
			list3 = executeQuery(hql_3.getPsSql(),hql_3.getParamsValues());
		}
		
		
		if(list3!=null&&list3.size()>0){
			 cost1=String.valueOf(list3.get(0).getTypeName());
			 cost2=String.valueOf(list2.get(0).getTypeName());
			 cost3=String.valueOf(list1.get(0).getTypeName());
			 return cost1+"->"+cost2+"->"+cost3;
			
		}else{
			if(list2!=null&&list2.size()>0){
				
				cost1=String.valueOf(list2.get(0).getTypeName());
				cost2=String.valueOf(list1.get(0).getTypeName());
				return cost1+"->"+cost2;
			}
			return String.valueOf(list1.get(0).getTypeName());
		}
	
	}
    /**
     * 找父级
     * @param profession
     * @return
     */
    public Integer getParentCostId(String profession){
    	Integer parentId = 0;
		SqlAppender hql_1 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql_1.append(" and t.id=?",Integer.parseInt(profession));
		List<TAppTalentCategory> list1 = executeQuery(hql_1.getPsSql(),hql_1.getParamsValues());
		
		if(list1 != null && list1.size()>0){
			parentId = list1.get(0).getParentId();
		}
		return parentId;
	}
    public String getParentCostId(String profession,int flag){
		
		SqlAppender hql_1 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql_1.append(" and t.id=?",Integer.parseInt(profession));
		List<TAppTalentCategory> list1 = executeQuery(hql_1.getPsSql(),hql_1.getParamsValues());
		
		String costId="";		
		SqlAppender hql_2 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql_2.append(" and t.id=?",list1.get(0).getParentId());
		List<TAppTalentCategory> list2 = executeQuery(hql_2.getPsSql(),hql_2.getParamsValues());

		List<TAppTalentCategory> list3=null;
		if(list2!=null&&list2.size()>0){
			SqlAppender hql_3 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
			hql_3.append(" and t.id=?",list2.get(0).getParentId());
			list3 = executeQuery(hql_3.getPsSql(),hql_3.getParamsValues());
		}
		
		if(list3!=null&&list3.size()>0){
			if(flag==1){
				return String.valueOf(list3.get(0).getTypeName());
			}
			 return String.valueOf(list3.get(0).getId());
			
		}else{
			if(list2!=null&&list2.size()>0){
				if(flag==1){
					return String.valueOf(list2.get(0).getTypeName());
				}
				return String.valueOf(list2.get(0).getId());
			}else{
				if(flag==1){
					return String.valueOf(list1.get(0).getTypeName());
				}
				return profession;
			}
			
		}
	
	}
    
    
    public String getProfessionName(String profession){
		
		SqlAppender hql_1 = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql_1.append(" and t.id=?",Integer.parseInt(profession));
		List<TAppTalentCategory> list1 = executeQuery(hql_1.getPsSql(),hql_1.getParamsValues());
		
		return String.valueOf(list1.get(0).getTypeName());
	
	}
    
    public String checkCostId(int userId,int costId) {
    	SqlAppender hql = new SqlAppender("from TAppCostInfo t where 1=1 ");
		hql.append(" and t.profession=?",costId);
		hql.append(" and t.userId=?",userId);
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
		if(list!=null&&list.size()>0){
			return "1";
		}
		return "0";
		
	}
    public List getTop3CastByUserID(int userID){
    	
    	SqlAppender hql = new  SqlAppender("from TAppCostInfo t,TAppTalentCategory c where 1=1 and c.id = t.profession ");
    	hql.append(" and t.userId = ?",userID);
    	hql.append(" order by t.orderNo ");
    	return executeQuery(hql.getPsSql(),hql.getParamsValues(),0,4);
    }

    //获取用户第一职业
    public String getCostName(int userId){
		
		SqlAppender hql = new SqlAppender("from TAppTalentCategory t where t.id=(select Profession from TAppCostInfo c where ");
		hql.append(" c.userId=?)", userId);
		List<TAppTalentCategory> list1 = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
		return String.valueOf(list1.get(0).getTypeName());
	
	}
	public int getCostListByUserIdTotal(int id) {
		SqlAppender hql = new SqlAppender("");
		hql = new SqlAppender("select t from TAppCostInfo t where 1=1");
		hql.append(" and t.userId=?",id);
		hql.append(" order by t.orderNo ");
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		return total;
	}
	
	/**
	 * ze9fan
	 * 
	 * @param userId
	 * @return
	 */
	public int findTalentIdByTypeName(String typeName) {
		SqlAppender hql = new SqlAppender(" select t from TAppTalentCategory t where 1 =1 ");
		hql.append(" and t.typeName=?)", typeName);
		hql.append(" limit 1");
		List<TAppTalentCategory> list = (List<TAppTalentCategory>) executeQuery(hql.getPsSql(), hql.getParamsValues());
		return (list == null || list.size() == 0) ? 0 : list.get(0).getId();
	}
	
}
