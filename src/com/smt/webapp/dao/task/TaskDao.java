package com.smt.webapp.dao.task;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.xwork.ObjectUtils;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class TaskDao extends BaseDao{
	private Logger logger = Logger.getLogger("mylog");
	
	/**
	 * 2013-02-21 lai
	 * 通过userID查找需求
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TAppTask> getTaskListByUserID(int id,int  begin,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		if(sign==1){
			hql.append(" and t.status='1'");
			//hql.append(" and t.userId=?",id);
			hql.append(" order by t.creatTime desc");
		}else if(sign==2){
			hql.append(" and t.status='2'");
			//hql.append(" and t.userId=?",id);
			hql.append(" order by t.creatTime desc");
		}
		
		List<TAppTask> list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		
 		return list;
	}

	public int getTotal(int id,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		if(sign==1){
			hql.append(" and t.status='1'");
			//hql.append(" and t.userId=?",id);
		}else if(sign==2){
			hql.append(" and t.status='2'");
			//hql.append(" and t.userId=?",id);
		}		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public TAppTask findTaskById(int id) {
		// TODO Auto-generated method stub
		TAppTask task = null;
		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		hql.append(" and t.id = ?",id);
		List<TAppTask> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		if(list != null && list.size() > 0){
			task = list.get(0);
		}
		return task;
		
	}
	
	
	
	public List<TAppTask> getTaskByID(int id){
		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppTask> task = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return task;
	}
	
	
	public List getAllTask(){ 
		SqlAppender hql = new SqlAppender("from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId ");
		hql.append(" and t.active != '0' and t.active != '-1' and t.status ='1' and u.authority='0'");
		hql.append(" order by t.active desc,t.creatTime desc");
		
		List list  = executeQuery(hql.getPsSql());
		return list;
	}
	
	public List<TAppTask> getAllNewTask(){ 
		SqlAppender hql = new SqlAppender("select t from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId");
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date nowTime=new Date();
		hql.append(" and t.endDate>=?","'" + dfs.format(nowTime)+ "'");
		hql.append(" and t.active != '0' and t.active != '-1' and t.status ='1' and u.authority='0'");
		hql.append(" order by t.active desc,t.creatTime desc");
		List<TAppTask> list  = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list;
	}
	/**
	 * 2013-02-21 lai
	 * 保存或修改
	 * @param growthDao
	 * @return
	 */
	public void suTask(TAppTask task){
		saveOrUpdate(task);
	}
	
	public void delTask(TAppTask task){
		
		delete(task);
	}
	
	public void delTaks(int id){
		String sql = "delete from t_app_task where id="+id;
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		try {
			tx.begin();
			session.createSQLQuery("delete from t_app_task_role where taskId="+id).executeUpdate();
			session.createSQLQuery(sql).executeUpdate();
			tx.commit();
		} catch (HibernateException e) {
			tx.rollback();
			e.printStackTrace();
		}
	}
	
	/**
	 * 2013-03-13 qjm
	 * 首页新任务more页面所获取的数据集合（active=2置顶：order 不用active desc；active=0屏蔽：active!=0）
	 * @param 
	 * @return
	 */
	public List getTaskList(int begin,int rowCount,int status,String fromWeb){

		SqlAppender hql = new SqlAppender("from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId ");
		hql.append(" and t.active != '0' and t.active !='-1'");
 
		
		if (StringUtils.equals("1", fromWeb)) {
			hql.append(" and t.status >=?","1");
			hql.append(" and t.fromWeb= '1'");
		}else{
			SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date nowTime=new Date();
			hql.append(" and t.endDate>=?",dfs.format(nowTime));
			
			hql.append(" and t.status =?",String.valueOf(status));
			hql.append(" and t.fromWeb is null");
		}
		
		hql.append(" order by t.active desc,t.creatTime desc ");
		
		logger.info(hql.getPsSql());
		logger.info(ArrayUtils.toString(hql.getParamsValues()));
		
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return list;
	}
	
	public int getMoreTotal(int rowCount,int status){
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date nowTime=new Date();

		SqlAppender hql = new SqlAppender("from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId ");
		hql.append(" and t.active != '0' and t.active !='-1' and t.status ='"+status+"' and u.authority='0'");
		hql.append(" and t.endDate>=?",dfs.format(nowTime));
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	//发布需求(用户任务)查询（status=2为委托发布，active=2为置顶信息，active=0为屏蔽信息） roleId=1 管理员
	public List getUserTaskList(int roleId,int userId,int begin,int rowCount,String active,String status,String type){
	
		SqlAppender hql = new SqlAppender("from TAppTask t ,TAppUserInfo u where  1=1 ");
		if(roleId>1){
			hql.append(" and t.userId=?",userId);
		}
		if (!active.equals("100")) {
			hql.append(" and t.active= ?",active);
		}
		if (!status.equals("0")) {
			hql.append(" and t.status= ?",status);
		}
		if (type != null) {
			hql.append(" and t.fromWeb= '1'");
		}else{
			hql.append(" and t.fromWeb is null");
		}
		
		//hql.append(" and u.id=t.userId");
		hql.append(" and u.userId=t.userId");
		hql.append(" order by t.creatTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
 		return list;
 		
 		
	}
	public int getUserTaskListTotal(int roleId,int userId,String active,String status,String type){
		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		if(roleId>1){
			hql.append(" and t.userId=?",userId);
		}
		if (!active.equals("100")) {
			hql.append(" and t.active= ?",active);
		}
		if (!status.equals("0")) {
			hql.append(" and t.status= ?",status);
		}
		if (type != null) {
			hql.append(" and t.fromWeb= '1'");
		}else{
			hql.append(" and t.fromWeb is null");
		}
		
		
		hql.append(" order by t.creatTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
 		return list.size();
	}
	public List getpersonTaskList(int taskId,int begin,int rowCount,int isReady){
		SqlAppender hql = new SqlAppender("from TAppPersonTask t ,TAppUserInfo u where  ");
		hql.append(" t.taskId=?",taskId);
		hql.append(" and u.userId=t.personId");
		if (isReady!=-1) {
			hql.append(" and t.isReady=?",isReady);
		}
		hql.append(" order by t.createTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
 		return list;
	}
	public List<TAppTask> getTaskList(int taskId){
		SqlAppender hql = new SqlAppender("from TAppTask t where  ");
		hql.append(" t.id=?",taskId);
		List<TAppTask> list = executeQuery(hql.getPsSql(),hql.getParamsValues());
 		return list;
	}
	public List<TAppPersonTask> getpersonTaskList(int taskId){
		SqlAppender hql = new SqlAppender("from TAppPersonTask t where  ");
		hql.append(" t.taskId=?",taskId);
		List<TAppPersonTask> list = executeQuery(hql.getPsSql(),hql.getParamsValues());
 		return list;
	}
	//原发布需求(用户任务)查询（status=1，active=1）（status=2为委托发布，active=2为置顶信息，active=0为屏蔽信息）
	public List getUserTaskList1(int userId){
		SqlAppender hql = new SqlAppender("from TAppTask t where t.status ='1' ");
		hql.append(" and t.userId=?",userId);
		hql.append(" order by t.creatTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
 		return list;
	}
	
	//验证需求日期是否重叠(查询开始时间在其他需求时间中的记录数）
	public List<TAppTask> checkStartDate(String startDate,String endDate,int id,int userId){
		SqlAppender hql=new SqlAppender("from TAppTask i where 1=1");
		hql.append(" and ((i.startDate<=?",startDate);
		hql.append(" and i.endDate>?)",startDate);
		hql.append(" or (i.startDate>?",startDate);
		hql.append(" and i.startDate<?))",endDate);
		hql.append(" and i.userId=?",userId);
		if(id!=0){
			hql.append(" and i.id<>?",id);
		}
		
		List<TAppTask> task = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return task;
	}


	public int findTaskTotal(String city, String searchContent, int status,String fromWeb) {

		SqlAppender hql = new SqlAppender("from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId ");
		hql.append(" and t.active != '0' and t.active !='-1' and u.authority='0'");
		
		if (StringUtils.equals("1", fromWeb)) {
			hql.append(" and t.status >=?","1");
			hql.append(" and t.fromWeb= '1'");
		}else{
			SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date nowTime=new Date();		
		
			hql.append(" and t.endDate>=?",dfs.format(nowTime));
			hql.append(" and t.status =?",String.valueOf(status));
		}
		
		if(StringUtils.isNotBlank(city)){
			hql.append(" and t.provice like ?","%"+city+"%");
		}
		if(StringUtils.isNotBlank(searchContent)){
			hql.append(" and t.title like ?","%"+searchContent+"%" );
		}
		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		logger.warn("findTaskTotal="+total);	
		return total;
	}


	public List findTask(String city, String searchContent, int begin,int length, int status,String fromWeb) {

		SqlAppender hql = new SqlAppender("from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId ");
		hql.append(" and t.active != '0' and t.active !='-1'  and u.authority='0' ");
		
		if (StringUtils.equals("1", fromWeb)) {
			hql.append(" and t.status >=?","1");
			hql.append(" and t.fromWeb= '1'");
		}else{
			SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date nowTime=new Date();
			
			hql.append(" and t.endDate>=?",dfs.format(nowTime));
			hql.append(" and t.status =?",String.valueOf(status));
		}
		
		if(StringUtils.isNotBlank(city)){
			hql.append(" and t.provice like ?","%"+city+"%");
		}
		if(StringUtils.isNotBlank(searchContent)){
			hql.append(" and t.title like ?","%"+searchContent+"%" );
		}
		
		hql.append(" order by t.active desc,t.creatTime desc ");
		
		
		logger.warn(hql.getPsSql());
		Object[] paramsValues = hql.getParamsValues();
		for(int i=0; i<paramsValues.length; i++){
			logger.warn(paramsValues[i]);
		}
		
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, length);
		if(list != null){
			logger.warn("list.size="+list.size());	
		}
		
 		return list;
	}


	public List getUserTaskListActive(int roleId, int userId, int begin,
			int rowCount, String active, String status) {

		SqlAppender hql = new SqlAppender("from TAppTask t ,TAppUserInfo u where  1=1 ");
		if(roleId>1){
			hql.append(" and t.userId=?",userId);
		}
		if (!active.equals("100")) {
			hql.append(" and t.active= ?",active);
		}
		if (!status.equals("0")) {
			hql.append(" and t.status= ?",status);
		}
		hql.append(" and t.active != '0' and t.active !='-1'");
		
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date nowTime=new Date();
		
		hql.append(" and t.endDate>=?",dfs.format(nowTime));
		//hql.append(" and u.id=t.userId");
		hql.append(" and u.userId=t.userId");
		hql.append(" order by t.creatTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
 		return list;
	}


	public int getUserTaskListTotalActive(int roleId, int userId,
			String active, String status) {
		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		if(roleId>1){
			hql.append(" and t.userId=?",userId);
		}
		if (!active.equals("100")) {
			hql.append(" and t.active= ?",active);
		}
		if (!status.equals("0")) {
			hql.append(" and t.status= ?",status);
		}
		hql.append(" and t.active != '0' and t.active !='-1'");
		
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date nowTime=new Date();
		
		hql.append(" and t.endDate>=?",dfs.format(nowTime));
		
		hql.append(" order by t.creatTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
 		return list.size();
	}
	
	/**
	 * added @ 201601 by zefan
	 * 
	 * @param userId
	 * @param begin
	 * @param rowCount
	 * @return
	 */
	public List<TAppTask> getTaskListByUserID(int userId, int begin, int rowCount){
		SqlAppender hql = new SqlAppender("from TAppTask t where status<>2 ");
		hql.append(" and t.userId=?",userId);
		hql.append(" order by t.creatTime desc");
		List<TAppTask> list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return list;
	}
	
	public List<TAppTask> getBizTaskListByUserID(int userId, int begin, int rowCount){
		SqlAppender hql = new SqlAppender("from TAppTask t where status=2 ");
		hql.append(" and t.userId=?",userId);
		hql.append(" order by t.creatTime desc");
		List<TAppTask> list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return list;
	}
	
	public int countTaskSumByUserID(int userId) {
		SqlAppender hql = new SqlAppender("from TAppTask t where status<>2 ");
		hql.append(" and t.userId=?", userId);
		return getRowCount(hql.getPsSql(), hql.getParamsValues());
	}
	
	public int countTaskSumByAppliedUserId(int userId) {
		SqlAppender hql = new SqlAppender("from TAppPersonTask t where 1=1");
		hql.append(" and t.personId=?", userId);
		return getRowCount(hql.getPsSql(), hql.getParamsValues());
	}
	
	public List<TAppTask> getTaskListByAppliedPersonID(int personId) {
		SqlAppender hql = new SqlAppender("select t from TAppTask t, TAppPersonTask pt where pt.taskId=t.id ");
		hql.append(" and pt.personId=?", personId);
		hql.append(" order by t.creatTime desc");
		List<TAppTask> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		return list;
	}
	
	public int countBizTaskSumByUserID(int userId) {
		SqlAppender hql = new SqlAppender("from TAppTask t where status=2 ");
		hql.append(" and t.userId=?", userId);
		return getRowCount(hql.getPsSql(), hql.getParamsValues());
	}
	
	public List getTaskListByUserID4Test(int userId, int begin, int rowCount){
		SqlAppender hql = new SqlAppender("from TAppTask t,TAppUser u,TAppUserInfo i where t.userId=u.id and u.id = i.userId ");
//		hql.append(" and t.active != '0' and t.active !='-1'  and u.authority='0' ");
//		SqlAppender hql = new SqlAppender("from TAppTask t where 1=1 ");
		hql.append(" and t.userId=?",userId);
		hql.append(" order by t.creatTime desc");
 		return executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
	}

	public List<TAppTask> getTaskListByAppliedPersonOfBizBroID(int userId) {
		SqlAppender hql = new SqlAppender("select t from TAppTask t, TAppPersonTask tp where t.id=tp.taskId ");
		hql.append(" and tp.personId in (select id from TAppUser u where u.parentID=?)", userId);
		hql.append(" group by t.id order by t.creatTime desc");
		return executeQuery(hql.getPsSql(), hql.getParamsValues());
	}
	
	public int countByUserAndApply(int userId, int applyId) {
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppTask t, TAppPersonTask tp where t.id=tp.taskId and t.userId=?", userId);
		hql.append(" and tp.personId=?", applyId);
		int total = getRowCount(hql.getPsSql(), hql.getParamsValues());
		return total;
	}
}
