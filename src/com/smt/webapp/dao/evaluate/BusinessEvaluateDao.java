package com.smt.webapp.dao.evaluate;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.config.TxNamespaceHandler;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppSkillEvaluate;
import com.smt.entity.TAppUserEvaluation;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;

@Repository
public class BusinessEvaluateDao extends BaseDao {
	
	public List getMyBusinessEvaluate(int userId,int  begin,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t,u.username,ui.nickName,bi.orderCode,u.id,bi.seller,bi.buyer,bi.sellerCompany from TAppBusinessEvaluate t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
		hql.append(" where bi.id=t.businessId and u.id=ui.userId ");
		hql.append(" and (bi.seller=?",userId);
		hql.append(" or bi.sellerCompany=?",userId);
		hql.append(" or bi.buyer=? )",userId);
		hql.append(" and t.creatId=u.id");
		
		
		if(sign==1){	//我给他人的评价（我是签约者和我是被签约者，都有我给出的评价） 找被评价人，可能是买家或卖家
			hql.append(" and t.creatId=?",userId);
		}else if(sign==2){ 	//他人给我的评价（我是签约者和我是被签约者，都有给我的评价）
			hql.append(" and t.creatId<>?",userId);
		}
		hql.append(" order by bi.orderCode desc,t.creatTime desc");
		List businessEvaluateList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return businessEvaluateList;
	}
	  
	public List getMyBusinessEvaluate(int userId, int begin, int rowCount,int sign, int starLevel) {
		SqlAppender hql = new SqlAppender("");
		hql.append("select t,1,ui.nickName,1,ui.userId,bi.price,bi.content,bi.seller,bi.buyer,bi.sellerCompany from TAppBusinessEvaluate t,TAppBusinessInfo bi, TAppUserInfo ui");
		hql.append(" where t.pjGrade=?", Integer.toString(starLevel));
		hql.append(" and bi.id=t.businessId ");

		
		hql.append(" and t.creatId=ui.userId");
		hql.append(" and t.creatId<>?",userId);
		
		if (sign == 1) { //卖家给我的评价
			hql.append(" and bi.buyer=? )",userId);
		} else if (sign == 2) { // 买家给我的评价
			hql.append(" and (bi.seller=?",userId);
			hql.append(" or bi.sellerCompany=?)",userId);
		}
		hql.append(" order by t.creatTime desc ");
 
		List businessEvaluateList = executeQuery(hql.getPsSql(), hql.getParamsValues(), begin, rowCount);
		return businessEvaluateList;
	}
	  // cdh
	public int getMyBusinessEvaluateTotal(int userId, int sign, int starLevel) {
		SqlAppender hql = new SqlAppender("");
		hql.append("select t,1,ui.nickName,1,ui.userId,bi.price,bi.content,bi.seller,bi.buyer,bi.sellerCompany from TAppBusinessEvaluate t,TAppBusinessInfo bi, TAppUserInfo ui");
		hql.append(" where t.pjGrade=?", Integer.toString(starLevel));
		hql.append(" and bi.id=t.businessId ");

		
		hql.append(" and t.creatId=ui.userId");
		hql.append(" and t.creatId<>?",userId);
		
		if (sign == 1) { //卖家给我的评价
			hql.append(" and bi.buyer=? )",userId);
		} else if (sign == 2) { // 买家给我的评价
			hql.append(" and (bi.seller=?",userId);
			hql.append(" or bi.sellerCompany=?)",userId);
		}
		
		int total = getRowCount(hql.getPsSql(), hql.getParamsValues()).intValue();
		return total;
	}
	  
	  
	  
	  
	  
	public List getSkillEvaluate(int skillId,int  begin,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
			hql.append(" from TAppSkillEvaluate t,TAppUserInfo bi");
			hql.append(" where t.skillId = ?",skillId);
			hql.append(" and bi.userId = t.createId order by t.createtime desc");
		List sList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return sList;
	}
	public int getSkillEvaluateTotal(int skillId,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		hql.append(" from TAppSkillEvaluate t");
		hql.append(" where t.skillId = ?",skillId);
		hql.append(" order by t.createtime desc");
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	public int getSkillEvaluateTotalAll(int skillId){
		SqlAppender hql = new SqlAppender("");
		hql.append(" from TAppSkillEvaluate t");
		hql.append(" where t.skillId = ?",skillId);
		hql.append(" order by t.createtime desc");
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
	public List<TAppBusinessEvaluate> getInfoToEvaluate(int userId){
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		
		Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
        calendar.add(Calendar.DATE, -30);    //得到前30天
        String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
		SqlAppender hql = new SqlAppender("");
			hql.append("from TAppBusinessEvaluate where");
			hql.append(" creatId=?",userId);
			hql.append(" and creatTime > ?","'"+yestedayDate+"'");
			hql.append(" AND pjcount<1 ");//修改评价此次数
		List<TAppBusinessEvaluate> businessEvaluateList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		try {
			TAppBusinessEvaluate bEvaluate = null;
			for (int i = 0; i < businessEvaluateList.size(); i++) {
				bEvaluate = businessEvaluateList.get(i);
				String finishTimeString = bEvaluate.getCreatTime();
				System.out.println(finishTimeString+"  "+yestedayDate+"===="+businessEvaluateList.size()+"=================");
				Date date = sd.parse(finishTimeString);
				Date date1 = sd.parse(yestedayDate);
				if(date.before(date1)){
					businessEvaluateList.remove(i);
					System.out.println("删掉一个");
				}
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		return businessEvaluateList;
	}
	
	public void updateUnread(int userId,int rowCount, int page) {
		StringBuilder hql = new StringBuilder();
		hql.append("update  t_app_business_evaluate t,t_app_business_info bi,t_app_user u  set t.state=1 ");
		hql.append(" where bi.id=t.businessId and u.id=t.creatId and t.state<1 ");
		hql.append(" and ((bi.sellerCompany=u.id and bi.buyer="+userId+")");
		hql.append(" or (bi.buyer=u.id and bi.sellerCompany="+userId+"))");
		
		Session session = getSession();
		Transaction tx = session.beginTransaction();
//		List list = this.getHibernateTemplate().find(hql);
		try {
			session.createSQLQuery(hql.toString()).executeUpdate();
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
	
	public int getUnreadTotal(int userId,int rowCount,int sign) {
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//我给他人的评价（我是签约者和我是被签约者，都有我给出的评价）
			hql.append("select t,u.username,ui.nickName,bi.orderCode from TAppBusinessEvaluate t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and ((bi.sellerCompany=u.id and bi.buyer=t.creatId) or (bi.buyer=u.id and bi.sellerCompany=t.creatId))");
			hql.append(" and t.creatId=?",userId);
			
		}else if(sign==2){ 	//他人给我的评价（我是签约者和我是被签约者，都有给我的评价）
			hql.append("select t,u.username,ui.nickName,bi.orderCode from TAppBusinessEvaluate t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and u.id=t.creatId and t.state<1 ");
			hql.append(" and ((bi.sellerCompany=u.id and bi.buyer=?)",userId);
			hql.append(" or (bi.buyer=u.id and bi.sellerCompany=?))",userId);
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t,u.username,ui.nickName,bi.orderCode,u.id from TAppBusinessEvaluate t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
		hql.append(" where bi.id=t.businessId and u.id=ui.userId ");
		hql.append(" and (bi.seller=?",userId);
		hql.append(" or bi.sellerCompany=?",userId);
		hql.append(" or bi.buyer=? )",userId);
		hql.append(" and t.creatId=u.id");
		
		if(sign==1){	//我给他人的评价（我是签约者和我是被签约者，都有我给出的评价）
			hql.append(" and t.creatId=?",userId);
		}else if(sign==2){ 	//他人给我的评价（我是签约者和我是被签约者，都有给我的评价）
			hql.append(" and t.creatId<>?",userId);
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}

  public int getTotal(int userId, int sign) {
	    SqlAppender hql = new SqlAppender("");
	    if (sign == 1) {
	      hql.append("select t,u.username,ui.nickName,bi.orderCode from TAppBusinessEvaluate t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
	      hql.append(" where bi.id=t.businessId and u.id=ui.userId and ((bi.sellerCompany=u.id and bi.buyer=t.creatId) or (bi.buyer=u.id and bi.sellerCompany=t.creatId))");
	      hql.append(" and t.creatId=?", userId);
	    }
	    else if (sign == 2) {
	      hql.append("select t,u.username,ui.nickName,bi.orderCode from TAppBusinessEvaluate t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
	      hql.append(" where bi.id=t.businessId and u.id=ui.userId and u.id=t.creatId ");
	      hql.append(" and ((bi.sellerCompany=u.id and bi.buyer=?)", userId);
	      hql.append(" or (bi.buyer=u.id and bi.sellerCompany=?))", userId);
	    }

	    int total = getRowCount(hql.getPsSql(), hql.getParamsValues()).intValue();
	    return total;
	  }
 
	public void addOrEditEvaluate(TAppBusinessEvaluate evaluate){
		saveOrUpdate(evaluate);
	}
	public int deleteEvalute(int userId,int bussinessId){
		String t = getMyBusinessEvaluateByCreatId(userId, bussinessId);
		int pjGrade =0;
		if(t!=null && t.length()>0)
			pjGrade=Integer.parseInt(t);
		String hql = "delete from t_app_business_evaluate WHERE BusinessId ="+bussinessId+" AND CreatId = "+userId;
		Session session = getSession();
		Transaction tx = session.beginTransaction();
//		List list = this.getHibernateTemplate().find(hql);
		try {
			session.createSQLQuery(hql).executeUpdate();
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
		return pjGrade;
	}
	public String getMyBusinessEvaluateByCreatId(int creatId,int bussinessId){
		String PjGrade = "-2";
		TAppBusinessEvaluate businessEvaluate=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppBusinessEvaluate where CreatId=?",creatId);
		hql.append(" and BusinessId = ?",bussinessId);
		hql.append("order by creattime desc");
		List<TAppBusinessEvaluate> TAppBusinessEvaluate = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(TAppBusinessEvaluate!=null&&TAppBusinessEvaluate.size()>0){
 			businessEvaluate=TAppBusinessEvaluate.get(0);
 			PjGrade = businessEvaluate.getPjGrade();
 		}
		
		return PjGrade;
	}
	public TAppBusinessEvaluate getBusinessEvaluateByCreatId(int creatId,int bussinessId){
		TAppBusinessEvaluate businessEvaluate=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppBusinessEvaluate where CreatId=?",creatId);
		hql.append(" and BusinessId = ?",bussinessId);
		List<TAppBusinessEvaluate> TAppBusinessEvaluate = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(TAppBusinessEvaluate!=null&&TAppBusinessEvaluate.size()>0){
 			businessEvaluate=TAppBusinessEvaluate.get(0);
 		}
		return businessEvaluate;
	}

}
