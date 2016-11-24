package com.smt.webapp.dao.evaluation;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppUserEvaluation;

import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class UserEvaluationDao extends BaseDao {

	/****/
	//根据交易用户Id查用户评价分
	public TAppUserEvaluation getUserEvaluationById(int userId){
		TAppUserEvaluation TAppUserEvaluation=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppUserEvaluation where userId=?",userId);
		List<TAppUserEvaluation> TAppUserEvaluationList =null;
		try {
			TAppUserEvaluationList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		if(TAppUserEvaluationList!=null&&TAppUserEvaluationList.size()>0){
 			TAppUserEvaluation=TAppUserEvaluationList.get(0);
 		}
 		return TAppUserEvaluation;
	}
	
	//添加或者修改交易订单
	public void addOrEdituserEvaluation(TAppUserEvaluation evaluation){
		saveOrUpdate(evaluation);
	}
	//添加或者修改交易订单
	//保存动态评分总分
	public void saveGradeValue(TAppBusinessEvaluate evaluate,int BqyUserId){
	
		double MsGrade = Double.parseDouble(evaluate.getMsGrade());
		double TdGrade = Double.parseDouble(evaluate.getTdGrade());
		double ZlGrade = Double.parseDouble(evaluate.getZlGrade());
			List<TAppBusinessEvaluate> list = getSession().createSQLQuery("SELECT * FROM t_app_business_evaluate WHERE BusinessId IN (SELECT BusinessId FROM t_app_business_info WHERE seller = "+BqyUserId+")").list();
			int count = list.size();
			DecimalFormat df=new DecimalFormat(".###");
			
		TAppUserEvaluation tAppUserEvaluation=null;
		//SqlAppender hql=new SqlAppender("");
		//hql.append("from TAppUserEvaluation where userId=?",BqyUserId);
		//List<TAppUserEvaluation> userEvaluationList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		List<TAppUserEvaluation> userEvaluationList = getSession().createSQLQuery("SELECT * FROM t_app_user_evaluation WHERE userId = "+BqyUserId).addEntity(TAppUserEvaluation.class).list();
		
		if(userEvaluationList!=null&&userEvaluationList.size()>0){
 			tAppUserEvaluation=userEvaluationList.get(0);
 		
			if (tAppUserEvaluation.getMsGradeValue()==0) {
				tAppUserEvaluation.setMsGradeValue(5);
			}
			if (tAppUserEvaluation.getZlGradeValue()==0) {
				tAppUserEvaluation.setZlGradeValue(5);
			}
			if (tAppUserEvaluation.getTdGradeValue()==0) {
				tAppUserEvaluation.setTdGradeValue(5);
			}
			double MsGradeValue =Double.parseDouble(df.format((MsGrade-tAppUserEvaluation.getMsGradeValue())/(count+1)+tAppUserEvaluation.getMsGradeValue()));
			double TdGradeValue =Double.parseDouble(df.format((TdGrade-tAppUserEvaluation.getTdGradeValue())/(count+1)+tAppUserEvaluation.getTdGradeValue()));
			double ZlGradeValue =Double.parseDouble(df.format((ZlGrade-tAppUserEvaluation.getZlGradeValue())/(count+1)+tAppUserEvaluation.getZlGradeValue()));
			tAppUserEvaluation.setMsGradeValue(MsGradeValue);
			tAppUserEvaluation.setTdGradeValue(TdGradeValue);
			tAppUserEvaluation.setZlGradeValue(ZlGradeValue);
			saveOrUpdate(tAppUserEvaluation);
		}else{
			tAppUserEvaluation = new TAppUserEvaluation();
			tAppUserEvaluation.setMsGradeValue(5);
			tAppUserEvaluation.setZlGradeValue(5);
			tAppUserEvaluation.setTdGradeValue(5);
			
			double MsGradeValue =Double.parseDouble(df.format((MsGrade-tAppUserEvaluation.getMsGradeValue())/(count+1)+tAppUserEvaluation.getMsGradeValue()));
			double TdGradeValue =Double.parseDouble(df.format((TdGrade-tAppUserEvaluation.getTdGradeValue())/(count+1)+tAppUserEvaluation.getTdGradeValue()));
			double ZlGradeValue =Double.parseDouble(df.format((ZlGrade-tAppUserEvaluation.getZlGradeValue())/(count+1)+tAppUserEvaluation.getZlGradeValue()));
			tAppUserEvaluation.setMsGradeValue(MsGradeValue);
			tAppUserEvaluation.setTdGradeValue(TdGradeValue);
			tAppUserEvaluation.setZlGradeValue(ZlGradeValue);
			saveOrUpdate(tAppUserEvaluation);
		}
	}
	/****/

}
