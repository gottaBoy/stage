package com.smt.webapp.dao.user;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.smt.common.EscColumnToBean;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppMenu;
import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.entity.TBaseArea;
import com.smt.entity.UserParameter;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.util.HttpSessionHelper;
@Repository
public class UserInfoDao extends BaseDao{
	
	/**
	 * 2013-02-18 hyl
	 * 通过userID查找用户详细信息
	 * @param id
	 * @return
	 */
	public List<TAppUserInfo> getUserInfoByUserID(int id){
		SqlAppender hql = new SqlAppender("from TAppUserInfo i where 1=1 ");
		hql.append(" and i.userId=?",id);
 		List<TAppUserInfo> userInfos = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return userInfos;
	}
	
	public TAppUserInfo findUserInfoByUserId(int userId) {
		// TODO Auto-generated method stub
		TAppUserInfo userInfo = null;
		SqlAppender hql = new SqlAppender("from TAppUserInfo i where 1=1 ");
		hql.append(" and i.userId=?",userId);
		List<TAppUserInfo> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		if(list != null && list.size() > 0){
			userInfo = list.get(0);
		}
		return userInfo;
		
	}
	public TAppUserInfo findUserInfoByNickName(String nickName) {
		// TODO Auto-generated method stub
		TAppUserInfo userInfo = null;
		SqlAppender hql = new SqlAppender("from TAppUserInfo i where 1=1 ");
		hql.append(" and i.nickName like ?","%"+nickName+"%");
		List<TAppUserInfo> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		if(list != null && list.size() > 0){
			userInfo = list.get(0);
		}
		return userInfo;
		
	}
	
	/**
	 * 2013-02-18 hyl
	 * 保存或者修改用户详细信息
	 * @param userInfo
	 */
	
	public void saveOrUpdateUserInfo(TAppUserInfo userInfo){
		merge(userInfo);
	}

	
	//修改企业下艺人的支付宝帐号
	public void updateUserAlipay(String sql){
		update(sql);
	}
	
	public void saveOrUpdateFeek(TAppUserInfo userInfo){
		SqlAppender hql = new SqlAppender("from TAppBusinessInfo tb ,TAppBusinessEvaluate be where ");
		hql.append("  tb.seller=?",userInfo.getUserId());
		hql.append(" and be.businessId=tb.id");
 		List<TAppBusinessEvaluate> evaList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		double total = (double)evaList.size();
 		hql = new SqlAppender("from TAppBusinessInfo tb ,TAppBusinessEvaluate be where ");
		hql.append("  tb.seller=?",userInfo.getUserId());
		hql.append(" and be.businessId=tb.id and be.pjGrade = '1'");
 		List<TAppBusinessEvaluate> evaList1 = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		double PjTotal = (double)evaList1.size();
 		double a = PjTotal/total;
 		DecimalFormat df=new DecimalFormat(".#");
		int aa =Double.valueOf(df.format(a*100)).intValue();
 		userInfo.setFeedbackRate(aa);
		//merge(userInfo);
	}
	public List getUserInfoList(String  keywords,int  begin,int rowCount,int flag) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("");
		if(flag==2){
			hql.append(" from TAppUser u, TAppUserInfo t  where u.id=t.userId ");
			
			//hql.append(" and  u.isOrg=1 and t.isRecommend=1 order by u.creatTime desc ");
			hql.append(" and  u.isOrg=1 and t.isRecommend=1 and u.state <> '2' order by u.creatTime desc ");
		}else{
			hql.append("select a,b,c,d");
			hql.append(" from TAppUser a ");
			hql.append(" inner join a.userList b");//TAppUserInfo
			hql.append(" left join a.costList c");//TAppCostInfo
			hql.append(" left join c.category d ");//TAppTalentCategory
			//hql.append(" where a.authority='0' and a.isOrg=?",flag);
			hql.append(" where a.authority='0' and a.state <> '2' and a.isOrg=?",flag);
			if(keywords!=null&&!("请输入关键词").equals(keywords)){
				hql.append(" and( b.name like ?","%"+keywords+"%");
				hql.append(" or b.nickName like ? ","%"+keywords+"%");
				hql.append(" or a.username like ? ","%"+keywords+"%");
				hql.append(" or b.city like ? ","%"+keywords+"%");
				hql.append(" or b.provice like ? ","%"+keywords+"%");
				hql.append(" or d.typeName like ?) ","%"+keywords+"%");
			}
			hql.append(" group by a.id order by a.creatTime desc ");
		}

		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return list;
		
	}
	public List getNorUserInfoList(String  keywords,int  begin,int rowCount,int flag) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("");

			hql.append("select a,b,c,d");
			hql.append(" from TAppUser a ");
			hql.append(" inner join a.userList b");//TAppUserInfo
			hql.append(" left join a.costList c");//TAppCostInfo
			hql.append(" left join c.category d ");//TAppTalentCategory
			hql.append(" where a.authority='0' and applicate = 1 and a.isOrg=?",flag);
			if(keywords!=null&&!("请输入关键词").equals(keywords)){
				hql.append(" and( b.name like ?","%"+keywords+"%");
				hql.append(" or b.nickName like ? ","%"+keywords+"%");
				hql.append(" or a.username like ? ","%"+keywords+"%");
				hql.append(" or b.city like ? ","%"+keywords+"%");
				hql.append(" or b.provice like ? ","%"+keywords+"%");
				hql.append(" or d.typeName like ?) ","%"+keywords+"%");
			}
			hql.append(" group by a.id order by a.creatTime desc ");
		
		
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return list;
		
	}
	public int getTotal(String  keywords,int rowCount,int flag){
		SqlAppender hql = new SqlAppender("");
		if(flag==2){
			hql.append(" from TAppUser u, TAppUserInfo t  where u.id=t.userId ");
			hql.append(" and  u.isOrg=1 order by u.creatTime desc ");
		}else{
			hql.append("select a,b,c,d ");
			hql.append("  from TAppUser a ");
			hql.append(" inner join a.userList b");//TAppUserInfo
			hql.append(" left join a.costList c");//TAppCostInfo
			hql.append(" left join c.category d ");//TAppTalentCategory
			hql.append(" where a.authority='0' and a.isOrg=?",flag);
			if(keywords!=null&&!("请输入关键词").equals(keywords)){
				hql.append(" and( b.name like ?","%"+keywords+"%");
				hql.append(" or b.nickName like ? ","%"+keywords+"%");
				hql.append(" or a.username like ? ","%"+keywords+"%");
				hql.append(" or b.city like ? ","%"+keywords+"%");
				hql.append(" or b.provice like ? ","%"+keywords+"%");
				hql.append(" or d.typeName like ?) ","%"+keywords+"%");
			}
			hql.append("group by a.id order by a.creatTime desc ");
		}
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		int total=list.size();	
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	public int getNorTotal(String  keywords,int rowCount,int flag){
		SqlAppender hql = new SqlAppender("");

			hql.append("select a,b,c,d ");
			hql.append("  from TAppUser a ");
			hql.append(" inner join a.userList b");//TAppUserInfo
			hql.append(" left join a.costList c");//TAppCostInfo
			hql.append(" left join c.category d ");//TAppTalentCategory
			hql.append(" where a.authority='0' and applicate = 1 and a.isOrg=?",flag);
			if(keywords!=null&&!("请输入关键词").equals(keywords)){
				hql.append(" and( b.name like ?","%"+keywords+"%");
				hql.append(" or b.nickName like ? ","%"+keywords+"%");
				hql.append(" or a.username like ? ","%"+keywords+"%");
				hql.append(" or b.city like ? ","%"+keywords+"%");
				hql.append(" or b.provice like ? ","%"+keywords+"%");
				hql.append(" or d.typeName like ?) ","%"+keywords+"%");
			}
			hql.append("group by a.id order by a.creatTime desc ");

		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		int total=list.size();	
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public List getAttestationList(String  keywords,int  begin,int rowCount,int flag) {
		SqlAppender hql = new SqlAppender(" from TAppUser u, TAppUserInfo t where u.id=t.userId and u.parentID is null ");
		hql.append(" and  u.isOrg=?",flag);
		hql.append(" and u.rzState  <>1 ");
		if(keywords!=null&&!("请输入关键词").equals(keywords)){
			hql.append(" and( t.name like ?","%"+keywords+"%");
			hql.append(" or t.nickName like ? ","%"+keywords+"%");
			hql.append(" or u.username like ? ","%"+keywords+"%");
			hql.append(" or t.profession like ? ","%"+keywords+"%");
			hql.append(" or t.city like ? ","%"+keywords+"%");
			hql.append(" or t.provice like ?) ","%"+keywords+"%");
		}
		hql.append(" order by   u.rzState,u.creatTime desc ");

		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return list;
	}
	
	/**
	 * get the art user list by org id;
	 * 
	 * ze9fan @201603
	 * @param parentId
	 * @return
	 */
	public List findUserInfoListByParentId(int parentId) {
		SqlAppender hql = new SqlAppender(" select ui from TAppUser u, TAppUserInfo ui where u.id = ui.userId ");
		hql.append(" and u.parentID = ?", parentId);
		return executeQuery(hql.getPsSql(), hql.getParamsValues());
	}
	
	public List<UserParameter> findObjectBySql(String keywords){
        //使用SQL构造查询对象，此SQL是可以被JDBC接受的SQL，如SELECT * FROM XXX_TABLE
		//Query query = this.getSession().createSQLQuery(queryString);
        //设置结果集转换器，这是本文重点所在
		//query.setResultTransformer(new EscColumnToBean(pojoClass));
        //返回查询结果
		
		SqlAppender hql = new SqlAppender("from TAppUserInfo t");
		hql.append(" where name like ?", "%"+keywords+"%");
		hql.append(" or nickName like ? ", "%"+keywords+"%");
		List list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		return list;
		//return query.list();
	}
	public List<UserParameter> findObjectBySql1(String keywords){
        //使用SQL构造查询对象，此SQL是可以被JDBC接受的SQL，如SELECT * FROM XXX_TABLE
		//Query query = this.getSession().createSQLQuery(queryString);
        //设置结果集转换器，这是本文重点所在
		//query.setResultTransformer(new EscColumnToBean(pojoClass));
        //返回查询结果
		HttpServletRequest request=ServletActionContext.getRequest();
		int id=HttpSessionHelper.getUserSession(request).getId();
		
		SqlAppender hql = new SqlAppender("select t from TAppUserInfo t,TAppUser u ");
		hql.append(" where (name like ?", "%"+keywords+"%");
		hql.append(" or nickName like ? )", "%"+keywords+"%");
		hql.append(" and u.parentID = ? ", id);
		hql.append(" and u.id = t.userId ");
		List list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		return list;
		//return query.list();
	}
	
	public int getAttestationTotal(String  keywords,int rowCount,int flag){
		SqlAppender hql = new SqlAppender(" from TAppUser u, TAppUserInfo t where u.id=t.userId and u.parentID is null ");
		hql.append(" and  u.isOrg=?",flag);
		hql.append(" and u.rzState <>1 ");
		if(keywords!=null&&!("请输入关键词").equals(keywords)){
			hql.append(" and( t.name like ?","%"+keywords+"%");
			hql.append(" or t.nickName like ? ","%"+keywords+"%");
			hql.append(" or u.username like ? ","%"+keywords+"%");
			hql.append(" or t.profession  like ?) ","%"+keywords+"%");
		}	
		
		hql.append(" order by   u.rzState ");
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	/**
	 * 
	 * @Description: TODO
	 * @author hyl   
	 * @date 2013-3-10 下午2:02:30
	 * @param prof
	 * @param userId
	 * @return
	 */
	
	public List getUserInfoByProfNew(String prof,String isRecommend) { 
		SqlAppender hql = new SqlAppender("");
		if(StringUtils.equals(prof, "机构")){ //机构
			hql = new SqlAppender("from TAppUser u,TAppUserInfo t where t.isRecommend=1 and t.userId=u.id and u.isOrg=1 ");
			hql.append(" order by  t.recommendTime desc");
		}else{
			if(!("").equals(prof)){
				hql.append(" from TAppUser a");
				hql.append(" inner join a.userList b");//TAppUserInfo
				hql.append(" left join a.costList c");//TAppCostInfo
				hql.append(" left join c.category d ");//TAppTalentCategory

				hql.append(" where b.isRecommend=1 and a.isOrg=0 ");
				
				hql.append(" and (d.alias=?",prof);
				hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.alias=?) )",prof);
				hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.alias=?)) )) ",prof);
				hql.append(" group by a.id ");
				hql.append(" order by  b.recommendTime desc");
				//hql.append(" and t.profession=?",prof);			
			}else{
				hql = new SqlAppender("from TAppUser u, TAppUserInfo t where t.isRecommend=1 and t.userId=u.id and u.isOrg=0 ");
				hql.append(" and t.profession is not null");
				hql.append(" order by  t.recommendTime desc");
			}
		}
		
		
		
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues(),0,6);
		return list;
		
	}

	/**
	 * 
	 * @Description: TODO
	 * @author hyl   
	 * @date 2013-3-10 下午2:02:30
	 * @param prof
	 * @param userId
	 * @return
	 */
	
	public List getUserInfoByProf(String prof,String isRecommend) { 
		SqlAppender hql = new SqlAppender("");
		if(StringUtils.equals(prof, "机构")){ //机构
			hql = new SqlAppender("from TAppUserInfo t,TAppUser u where t.isRecommend=1 and t.userId=u.id and u.isOrg=1 ");	
		}else{
			hql = new SqlAppender("from TAppUserInfo t,TAppUser u where t.isRecommend=1 and t.userId=u.id and u.isOrg=0 ");
			if(!("").equals(prof))
			{
				hql.append(" and t.profession=?",prof);			
			}else{
				hql.append(" and t.profession is not null");		
			}
		}
		
		hql.append(" order by  t.recommendTime desc");
		
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues(),0,6);
		return list;
		
	}

	
	public List getUserInfoByorgId(int orgId,int  begin,int rowCount,String keywords){
		//SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where (u.parentID = "+orgId+" and t.userId=u.id");
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where u.state <> '2' and (u.parentID = "+orgId+" and t.userId=u.id");
		if(keywords!=null&&!("请输入关键词").equals(keywords)){
			hql.append(" and( t.name like ?","%"+keywords+"%");
			hql.append(" or t.nickName like ? ","%"+keywords+"%");
			hql.append(" or u.username like ? ","%"+keywords+"%");
			hql.append(" or t.profession  like ?)) ","%"+keywords+"%");
		}else{
			hql.append(")");
		}
		//hql.append(" and u.state = '1'");
		hql.append(" order by  u.creatTime desc");
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
		return list;
	}
	public List getUserInfoByorgId1(int orgId,int  begin,int rowCount){
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where (u.parentID = "+orgId+" and t.userId=u.id");
		hql.append(" and u.state = '1')");
		hql.append(" order by  u.creatTime desc");
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
		return list;
	}
	public List<TAppUser> getUserInfoByorgId2(int orgId,int  begin,int rowCount,int taskId){
		List a = (List)new java.util.ArrayList();
		SqlAppender hql = new SqlAppender("from TAppUser u where ");
		hql.append(" u.parentID = ?",orgId);
		hql.append(" and u.state = '1'");
		hql.append(" order by  u.creatTime desc");
		List<TAppUser>  list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
		for (int i = 0; i < list.size(); i++) {
			TAppUser user = list.get(i);
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", user.getId()+"");
			SqlAppender hql1 = new SqlAppender("from TAppUserInfo ui where ");
			hql1.append(" ui.userId =?",user.getId());
			List<TAppUserInfo> userinfoList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			if (userinfoList!=null&&userinfoList.size()>0) {
				TAppUserInfo userInfo = userinfoList.get(0);
				map.put("nickName", userInfo.getNickName());
				map.put("Introduction", userInfo.getIntroduction());
			}
			
			SqlAppender hql2 = new SqlAppender("from TAppPersonTask t where  ");
			hql2.append(" t.taskId=?",taskId);
			List<TAppPersonTask> personList = executeQuery(hql2.getPsSql(),hql2.getParamsValues());
			if (personList!=null&&personList.size()>0) {
				int flag = 0;
				for (int j = 0; j < personList.size(); j++) {
					TAppPersonTask personTask = personList.get(j);
					if (user.getId().equals(personTask.getPersonId())) {
						flag=1;
					}
				}
				map.put("yingzheng", flag+"");
			}
			a.add(map);
		}
		return a;
	}
	public int getUserInfoByorgIdTotal1(int orgId){
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where (u.parentID = "+orgId+" and t.userId=u.id");
		hql.append(" and u.state = '1')");
		hql.append(" order by  u.creatTime desc");
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list.size();
	}
	public int getUserTotalByorgId(int orgId,String keywords){
		//SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where (u.parentID = "+orgId+" and t.userId=u.id");
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where u.state <> '2' and (u.parentID = "+orgId+" and t.userId=u.id");
		if(keywords!=null&&!("请输入关键词").equals(keywords)){
			hql.append(" and( t.name like ?","%"+keywords+"%");
			hql.append(" or t.nickName like ? ","%"+keywords+"%");
			hql.append(" or u.username like ? ","%"+keywords+"%");
			hql.append(" or t.profession  like ?)) ","%"+keywords+"%");
		}else{
			hql.append(")");
		}
		//hql.append(" and u.state = '1'");
		hql.append(" order by  u.creatTime desc");
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list.size();
	}
	
	public List<TAppUserInfo> getIndexUserSuggestion(int begin, int rowCount) {
		SqlAppender hql = new SqlAppender("select i from TAppUser u, TAppUserInfo i where i.userId=u.id and u.isOrg=0 ");
		hql.append(" order by i.popularityTotal desc");
		List<TAppUserInfo> list = (List<TAppUserInfo>)executeQuery(hql.getPsSql(), hql.getParamsValues(), begin, rowCount);
		return list;
	}
	
	public List<TAppUserInfo> getIndexArtistListParameter(int profession,List<Integer> pidList,int range) {
		SqlAppender hql = new SqlAppender("select i from TAppUser u, TAppUserInfo i where i.userId=u.id");
		if(profession!=-1){
			String pidstr = "";
			 for(int i=0;i<pidList.size();i++){
				 pidstr = pidstr + pidList.get(i) + ",";
			 }
			 pidstr = pidstr.substring(0,pidstr.length()-1);
			 
			if(range==-1){ //
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE  c.profession in(" + pidstr + "))");
			}else if(range==1){ //500
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE  c.profession in(" + pidstr + ") and c.bprice < 500)");
			}else if(range==2){ //500 - 1000
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE  c.profession in(" + pidstr + ") and c.bprice >= 500 and c.bprice < 1000)");
			}else if(range==3){ //1000 - 3000
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE  c.profession in(" + pidstr + ") and c.bprice >= 1000 and c.bprice < 3000)");
			}else if(range==4){ //3000
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE  c.profession in(" + pidstr + ") and c.bprice >= 3000)");
			}
		}else{
			if(range==1){ //500
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE c.bprice < 500)");
			}else if(range==2){ //500 - 1000
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE c.bprice >= 500 and c.bprice < 1000)");
			}else if(range==3){ //1000 - 3000
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE c.bprice >= 1000 and c.bprice < 3000)");
			}else if(range==4){ //3000
				hql.append(" and i.userId in(SELECT DISTINCT c.userId  from TAppCostInfo c  WHERE c.bprice >= 3000)");
			}
		}
		hql.append(" and u.isOrg=0 ");
		hql.append(" order by i.popularityTotal desc");
		List<TAppUserInfo> list = (List<TAppUserInfo>)executeQuery(hql.getPsSql(), hql.getParamsValues());
		return list;
	}
	
	public List<Integer> getProfessionList(List<Integer> pids){
		 String pidstr = "";
		 for(int i=0;i<pids.size();i++){
			 pidstr = pidstr + pids.get(i) + ",";
		 }
		 pidstr = pidstr.substring(0,pidstr.length()-1);
		 SqlAppender hql = new SqlAppender("select tc.id from TAppTalentCategory tc where tc.parentId in(" + pidstr  +")");
		 List<Integer> pidList = (List<Integer>)executeQuery(hql.getPsSql(), hql.getParamsValues());
		 return pidList;
	}
	
	
	public List getorgUserInfo(int  begin,int rowCount,String loc1,String loc2,String sort,String keyword){
		int locality = Integer.parseInt(loc1);
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t  where t.userId=u.id and u.isOrg=1");
		if (locality==1) {
			hql.append(" and t.provice = '江苏'");
		}else if (locality==2) {
			hql.append(" and t.provice = '浙江'");
		}else if (locality==3) {
			hql.append(" and t.provice = '安徽'");
		}else if (locality==4) {
			hql.append(" and t.provice = '上海'");
		}
		if (!loc2.equals("0")) {
			hql.append(" and t.city like ?","%"+loc2+"%");
		}
		if(keyword!=null&&!("搜索其他地区").equals(keyword)){
			hql.append(" and( t.provice like ?","%"+keyword+"%");
			hql.append(" or t.city like ? ) )","%"+keyword+"%");
			
		}
		
		hql.append(" and u.state = '1'");
		if (sort.equals("0")) {
			hql.append(" order by  u.creatTime desc");
		}else if (sort.equals("1")) {
			hql.append(" order by  t.grade desc");
		}else if (sort.equals("2")) {
			hql.append(" order by  t.popularityTotal desc");
		}else if (sort.equals("3")) {
			hql.append(" order by  t.collect desc");
		}else if (sort.equals("4")) {
			hql.append(" order by  t.signNumber desc");
		}
		
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,rowCount);
		return list;
	}
	
	public int getorgUserTotal(String loc1,String loc2,String keyword){
		int locality = Integer.parseInt(loc1);
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t  where t.userId=u.id and u.isOrg=1");
		if (locality==1) {
			hql.append(" and t.provice = '江苏'");
		}else if (locality==2) {
			hql.append(" and t.provice = '浙江'");
		}else if (locality==3) {
			hql.append(" and t.provice = '安徽'");
		}else if (locality==4) {
			hql.append(" and t.provice = '上海'");
		}
		if (!loc2.equals("0")) {
			hql.append(" and t.city like ?","%"+loc2+"%");
		}
		if(keyword!=null&&!("搜索其他地区").equals(keyword)){
			hql.append(" and( t.provice like ?","%"+keyword+"%");
			hql.append(" or t.city like ? ) )","%"+keyword+"%");
			
		}
		
		hql.append(" and u.state = '1'");
		
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list.size();
	}
	public void updatePopul(String id){
		try {
			SqlAppender hql = new SqlAppender("from TAppUserInfo t  where ");
			hql.append(" t.userId = ?",Integer.parseInt(id));
			List<TAppUserInfo> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
			if (list!=null&&list.size()>0) {
				TAppUserInfo userInfo = list.get(0);
				if (userInfo.getPopularityTotal()!=null) {
					userInfo.setPopularityTotal(userInfo.getPopularityTotal()+1);
				}
				merge(userInfo);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	} 
	public void updateAttent(String id){
		try {
			SqlAppender hql = new SqlAppender("from TAppUserInfo t  where ");
			hql.append(" t.userId = ?",Integer.parseInt(id));
			List<TAppUserInfo> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
			if (list!=null&&list.size()>0) {
				TAppUserInfo userInfo = list.get(0);
				if (userInfo.getPopularityTotal()!=null) {
					userInfo.setAttention(Integer.parseInt(userInfo.getAttention()+1+""));
				}
				merge(userInfo);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	} 

	public TAppUserInfo findUserInfoById(int id) {
		// TODO Auto-generated method stub
		return (TAppUserInfo)load(TAppUserInfo.class, id);
	}
	
	/**
	 * ze9fan
	 * @param mobile
	 * @return
	 */
	public int countUserInfoByMobile(String mobile) {
		SqlAppender hql = new SqlAppender(" select o from TAppUserInfo o where 1 = 1 ");
		hql.append(" and o.mobile = ?", mobile);
		return getRowCount(hql.getPsSql(), hql.getParamsValues());
	}
	
	//根据用户id查用户详细信息
	public TAppUserInfo getUserInfoByUserId(int userId){
		TAppUserInfo userInfo=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppUserInfo where userId=?",userId);
		List<TAppUserInfo> userInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(userInfoList!=null&&userInfoList.size()>0){
 			userInfo=userInfoList.get(0);
 		}
 		return userInfo;
	}
	public List getBzzxByorgId(int id ,int type) {
		// TODO Auto-generated method stub
		SqlAppender hql=new SqlAppender("");

			hql.append(" FROM TAppUserInfo ui,TAppCompanyInfo ci WHERE ui.userId = ci.yrUserId");
			hql.append(" and ci.businessId = ?",id);
			hql.append(" and ci.type =  ?",type);
		List a =executeQuery(hql.getPsSql(),hql.getParamsValues());
//		
//		TAppCompanyInfo ci = bList.get(0);
//		HashMap<String, String> map = new HashMap<String, String>();
//		map.put("starContent", ci.getStarContent());
//		a.add(map);

		return a;
	}
	public List<TAppTalentCategory> getTalent(String pro1) {
		// TODO Auto-generated method stub
		List<TAppTalentCategory>  a  = null;
			SqlAppender hql=new SqlAppender("");
			if(!pro1.equals("0")){
				hql.append(" FROM TAppTalentCategory tc WHERE 1=1");
				hql.append(" and  tc.subId = ?",pro1);
				hql.append(" and  tc.parentId != 0");
				a=executeQuery(hql.getPsSql(),hql.getParamsValues());
			}else {
				hql.append(" FROM TAppTalentCategory tc ORDER BY tc.searchTime DESC ");
				a=executeQuery(hql.getPsSql(),hql.getParamsValues(),0,10);
				System.out.println(a.size());
			}
			
		
			return a;
	}
	public List<TBaseArea> getArea(String loc1) {
		// TODO Auto-generated method stub
		int loc = Integer.parseInt(loc1);
		List<TBaseArea>  a  = null;
			SqlAppender hql=new SqlAppender("");
			if(!loc1.equals("0")){
				hql.append(" FROM TBaseArea ba WHERE 1=1");
				hql.append(" and  ba.rootid = ?",loc);
				a=executeQuery(hql.getPsSql(),hql.getParamsValues());
			}else {
				hql.append(" FROM TBaseArea ba WHERE ba.aid=0");
				a=executeQuery(hql.getPsSql(),hql.getParamsValues());
			}
			
		
			return a;
	}
	public TAppCompanyInfo getBzzxByorgId1(int id) {
		// TODO Auto-generated method stub
		TAppCompanyInfo appCompanyInfo = null;
		SqlAppender hql=new SqlAppender("");
		
			hql.append(" FROM TAppCompanyInfo ci WHERE ci.type = 1 ");
			hql.append(" and ci.businessId = ?",id);
			List<TAppCompanyInfo> aList = executeQuery(hql.getPsSql(),hql.getParamsValues());
			if (aList!=null&&aList.size()>0) {
				appCompanyInfo = aList.get(0);
			}
			
		return appCompanyInfo;
	}

	public List getCity(int isOrg) {
		SqlAppender hql=new SqlAppender("");
		
		if(isOrg==3){ //job task
			hql.append(" select count(t.city),t.city FROM TAppUser u, TAppUserInfo t, TAppTask c where u.id=t.userId and c.userId= u.id and c.city is not null");
			hql.append(" and  u.authority='0' ");
			hql.append(" and u.state = '1' ");
					
			hql.append(" group by t.city having count(t.city) > 0 order by count(t.city) desc ");
		}else if(isOrg==0){
			hql.append(" select count(t.city),t.city FROM TAppUser u inner join u.userList t left join u.costList c where t.city is not null");
			hql.append(" and  u.authority='0' ");
			hql.append(" and u.state = '1' ");
			hql.append(" and u.isOrg <> 100 "); //观众
			hql.append(" and u.isOrg = ");
			hql.append(Integer.toString(isOrg));
			
			hql.append(" and c.bprice > 50 ");
			
			hql.append(" group by t.city having count(t.city) > 0 order by count(t.city) desc ");
		}else{//1
			hql.append(" select count(t.city),t.city FROM TAppUser u inner join u.userList t where t.city is not null");
			hql.append(" and  u.authority='0' ");
			hql.append(" and u.state = '1' ");
			hql.append(" and u.isOrg <> 100 "); //观众
			hql.append(" and u.isOrg = ");
			hql.append(Integer.toString(isOrg));
			
			hql.append(" group by t.city having count(t.city) > 0 order by count(t.city) desc ");
		}
		
		List<Object[]> aList = executeQuery(hql.getPsSql(),hql.getParamsValues());
		List<String> result = new ArrayList<String>();
		String arr = "黄浦,徐汇,闵行,浦东新,浦东新区,静安,长宁,普陀,虹口,闸北,杨浦,青浦,宝山,松江,嘉定,南汇";
		for (Object[] cityArr : aList) {
			String city = (String)cityArr[1];
			if(!StringUtils.startsWith(city, "?")){
				if(!StringUtils.contains(arr, city)){
					result.add(city);
				}
			}
		}
		return result;
	}
}
