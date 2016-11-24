package com.smt.webapp.dao.company;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.validator.Var;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;

import z.B.l;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppCompanyPayRecord;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
@Repository
public class CompanyInfoDao extends BaseDao {
	
	public List getQyzxByBusinessId(int id){
		List a = (List)new java.util.ArrayList();
		SqlAppender hql = new SqlAppender("FROM TAppCompanyInfo WHERE  type = 1");
		hql.append(" and businessId = ?",id);
		List<TAppCompanyInfo> comList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		for (int i = 0; i < comList.size(); i++) {
			HashMap<String, String> map = new HashMap<String, String>();
			//能力（职业）
			TAppCompanyInfo companyInfo = comList.get(i);
			map.put("id", companyInfo.getBusinessId()+"");
			map.put("userId", companyInfo.getYrUserId()+"");
			if (companyInfo.getContentOfPictrue2()==null) {
				map.put("contentPic2", "");
			}else {
				map.put("contentPic2", companyInfo.getContentOfPictrue2());
			}
			if (companyInfo.getContentOfPictrue3()==null) {
				map.put("contentPic3", "");
			}else {
				map.put("contentPic3", companyInfo.getContentOfPictrue3());
			}
			if (companyInfo.getLinkOfPictrue2()==null) {
				map.put("linkPic2", "");
			}else {
				map.put("linkPic2", companyInfo.getLinkOfPictrue2());
			}
			if (companyInfo.getLinkOfPictrue3()==null) {
				map.put("linkPic3", "");
			}else {
				map.put("linkPic3", companyInfo.getLinkOfPictrue3());
			}
			if (companyInfo.getStarContent()==null) {
				map.put("content", "");
			}else {
				map.put("content", companyInfo.getStarContent());
			}
			SqlAppender hql1 = new SqlAppender(" FROM TAppCostInfo WHERE orderNo = 1");
			hql1.append(" and userId =  ?",companyInfo.getYrUserId());
			List<TAppCostInfo> costList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			TAppCostInfo costInfo =null;
			if (costList!=null&&costList.size()>0) {
				costInfo = costList.get(0);
				hql1 = new SqlAppender(" FROM TAppTalentCategory WHERE ");
				hql1.append(" id =  ?",costInfo.getProfession());
				List<TAppTalentCategory> talentList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
				TAppTalentCategory talentCategory = talentList.get(0);
				if (talentCategory.getTypeName()==null) {
					map.put("profession", "无");
				}else {
					map.put("profession", talentCategory.getTypeName());
				}
				
			}
			//人气
			hql1 = new SqlAppender("");
			hql1.append(" FROM TAppUserInfo WHERE  userId = ?",companyInfo.getYrUserId());
			
			List<TAppUserInfo> uList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			
			if (uList!=null&&uList.size()>0) {
				TAppUserInfo userInfo = uList.get(0);
				if (userInfo.getPopularityTotal()==null) {
					map.put("popularityTotal","0");
				}else {
					map.put("popularityTotal",Integer.toString(userInfo.getPopularityTotal()));
				}
				if (userInfo.getPopularityTotal()==null) {
					map.put("nickName","无");
				}else {
					map.put("nickName",userInfo.getNickName());
				}
				if (userInfo.getPopularityTotal()==null) {
					map.put("name","无");
				}else {
					map.put("name",userInfo.getName());
				}
			}else {
				map.put("qyTimes", "0");
			}
			
			a.add(map);
		}
 		return a;
	}
	public List<TAppCompanyInfo> getXrjrByBusinessId(int id){
		SqlAppender hql = new SqlAppender("FROM TAppCompanyInfo WHERE  type = 2");
		hql.append(" and businessId = ?",id);
		List<TAppCompanyInfo> comList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return comList;
	}
	public List<TAppCompanyInfo> getActiveByBusinessId(int id){
		SqlAppender hql = new SqlAppender("FROM TAppCompanyInfo WHERE  type = 3");
		hql.append(" and businessId = ?",id);
		List<TAppCompanyInfo> comList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return comList;
	}
	public void saveInfo2(TAppCompanyInfo companyInfo,int type,String flag){
 		if(flag.equals("1")){
 			saveOrUpdate(companyInfo);
 		}else {
 			String hql1 = "";
 			if (flag.equals("-1")) {
 				 hql1 = "delete from t_app_company_info WHERE BusinessId ="+companyInfo.getBusinessId()+" and yrUserId = "+companyInfo.getYrUserId();
			}else {
	 			 hql1 = "delete from t_app_company_info WHERE BusinessId ="+companyInfo.getBusinessId()+" and yrUserId = "+companyInfo.getYrUserId()+" AND type = "+type;

			}
 			Session session = getSession();
 			Transaction tx = session.beginTransaction();
 			try {
 				session.createSQLQuery(hql1).executeUpdate();
 				tx.commit();
 			} catch (DataAccessResourceFailureException e) {
 				// TODO Auto-generated catch block
 				e.printStackTrace();
 			} catch (IllegalStateException e) {
 				// TODO Auto-generated catch block
 				e.printStackTrace();
 			} catch (HibernateException e) {
 				tx.rollback();
 				e.printStackTrace();
 			}finally{
 				session.close();
 			}
		}
 		
	}
	public void saveInfo1(TAppCompanyInfo companyInfo,int type){
 		String hql1 = "delete from t_app_company_info WHERE BusinessId ="+companyInfo.getBusinessId()+" AND type = "+type;
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		try {
			session.createSQLQuery(hql1).executeUpdate();
			tx.commit();
		} catch (DataAccessResourceFailureException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (HibernateException e) {
			tx.rollback();
			e.printStackTrace();
		}finally{
			session.close();
		}
		if(companyInfo.getYrUserId()!=0)
			saveOrUpdate(companyInfo);
	}
	
}
