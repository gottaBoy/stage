package com.smt.webapp.dao.user;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppMessage;
import com.smt.entity.TAppSeqTable;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HqlToSql;
@Repository
public class Userdao extends BaseDao {
	private Logger logger = Logger.getLogger("mylog");

	@Autowired
	private MessageService messageService;
	/**
	 * 通过userName查找用户信息
	 * huyuanliang 
	 * 2013-02-05
	 * @param email
	 * @return
	 */
	public TAppUser findUserByUserName(String userName) {
		// TODO Auto-generated method stub
		TAppUser user = null;
		SqlAppender hql = new SqlAppender("from TAppUser t where 1=1 ");
		hql.append(" and t.username = ?",userName);
		List<TAppUser> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		//List<TAppUser> list = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			user = list.get(0);
		}
		return user;
		
	}
	/**
	 * 通过NickName查找用户信息
	 * huyuanliang 
	 * 2013-02-05
	 * @param email
	 * @return
	 */
	public TAppUserInfo findUserByNickName(String nickName,String userId) {
		// TODO Auto-generated method stub
		TAppUserInfo user = null;
		SqlAppender hql = new SqlAppender("from TAppUserInfo t where 1=1 ");
		hql.append(" and t.nickName = ?",nickName);
		
		if(StringUtils.isNotBlank(userId)){
			hql.append(" and t.userId <> ?",Integer.parseInt(userId));
		}
		
		List<TAppUserInfo> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		//List<TAppUser> list = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			user = list.get(0);
		}
		return user;
		
	}
	
	public String getMaxUserIdFromSequenceTable(String tableName) {
		String newId = "0";
		TAppSeqTable seqTable = null;
		SqlAppender hql = new SqlAppender("from TAppSeqTable t where 1=1 ");
		hql.append(" and t.tableName = ?",tableName);
		
		List<TAppSeqTable> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		//List<TAppUser> list = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			seqTable = list.get(0);
			newId = Long.toString(Long.parseLong(seqTable.getSequenceId())+1);
			
			seqTable.setSequenceId(newId); //更新最大id
			update(seqTable);
		}
		//更新
		
		return newId;
	}
	
	
	public TAppUser findUserByUserId(int userId) {
		// TODO Auto-generated method stub
		TAppUser user = null;
		SqlAppender hql = new SqlAppender("from TAppUser t where 1=1 ");
		hql.append(" and t.id = ?",userId);
		List<TAppUser> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		//List<TAppUser> list = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			user = list.get(0);
		}
		return user;
		
	}
	
	public TAppUser findUserById(int id) {
		// TODO Auto-generated method stub
		TAppUser user = null;
		SqlAppender hql = new SqlAppender("from TAppUser t where 1=1 ");
		hql.append(" and t.id = ?",id);
		List<TAppUser> list = executeQuery(hql.getPsSql(), hql.getParamsValues());
		//List<TAppUser> list = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			user = list.get(0);
		}
		return user;
		
	}
	
	public int saveUser(final TAppUser user){
		user.setState("0"); //审核后才能看
		user.setApplicate(0); //默认没申请
		Integer id = (Integer)this.getHibernateTemplate().execute(new HibernateCallback() { 
		     public  Object doInHibernate(Session s)  throws  HibernateException, SQLException { 
		          Integer msgId = (Integer)s.save(user);
		          return msgId;
		       } 
		     }); 
		return id;
	}
	
	
	/**
	 * 通过email查找用户信息
	 * huyuanliang 
	 * 2013-02-05
	 * @param email
	 * @return
	 */
	public TAppUser findUserByEmail(String email) {
		// TODO Auto-generated method stub
		TAppUser user = null;
		SqlAppender hql = new SqlAppender("from TAppUser t where 1=1 ");
		hql.append(" and t.email = ?",email);
		List<TAppUser> list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			user = list.get(0);
		}
		return user;
		
	}
	/**
	 * 
	 * @Description: 修改用户
	 * @author hyl   
	 * @date 2013-2-22 上午9:41:32
	 * @param user
	 */
	public void updateUser(TAppUser user) {
		// TODO Auto-generated method stub
		merge(user);
		
	}
	
	public TAppUser getAppUserById(Integer id){
		return (TAppUser)load(TAppUser.class, id);
	}
	public int getYrSunByUserId(int id) {
		SqlAppender hql = new SqlAppender("from TAppUser u,TAppUserInfo t where (u.parentID = "+id+" and t.userId=u.id");
		hql.append(")");
		hql.append(" and u.state = '1'");
		hql.append(" order by  u.creatTime desc");
		List  list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list.size();
	}
	
	public void doAddMessage() {
		SqlAppender hql = new SqlAppender("from TAppUser u where 1=1");
		List<TAppUser> userList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		for (int i = 0; i < userList.size(); i++) {
			TAppUser user = userList.get(i);
			TAppMessage message = new TAppMessage();
	    	message.setCreatTime(CommonUtil.getTime(new Date()));
	    	message.setTitle("第1舞台迎宾信！"); 
	    	message.setFromUserId(3); 
	    	message.setToUserId(user.getId());
	    	message.setContent("尊敬的会员，您好！                               欢迎您加入第1舞台，请您丰富并完善其资料（个人信息、头像、相册、视频、成长经历等），有利于您方便快捷的找活接活,您资料的完整程度也是检索您网站排名的重要依据哦。您自己的舞台为您而精彩！若有疑问或建议，您可拨打第1热线：021-52902120或者加入第1舞台微信公众号：d15tfamily第1舞台QQ群：311642987（专人1对1服务）");
	    	message.setStatus("0");	//发送短信后默认为未读
	    	message.setType(2);
			messageService.addMessage(message);
		}
	}
	public List getYrinfoByorgId(String loc1,String loc2) {
		List a = (List)new java.util.ArrayList();
		
		int locality = Integer.parseInt(loc1);
		SqlAppender hql = new SqlAppender("from TAppUser u where u.isOrg=1");
		List<TAppUser> userList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		for (int i = 0; i < userList.size(); i++) {
			HashMap<String, String> map = new HashMap<String, String>();
			TAppUser user = userList.get(i);
			hql = new SqlAppender("from TAppUserInfo t where ");
			hql.append(" t.userId = ?",user.getId());
			if (locality==1) {
				hql.append(" and t.provice = '江苏'");
			}else if (locality==2) {
				hql.append(" and t.provice = '浙江'");
			}else if (locality==3) {
				hql.append(" and t.provice = '安徽'");
			}else if (locality==4) {
				hql.append(" and t.provice = '上海'");
			}
			List<TAppUserInfo> userinfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
			if (userinfoList!=null&&userinfoList.size()>0) {
				TAppUserInfo userInfo = userinfoList.get(0);
				map.put("id", userInfo.getUserId()+"");
//				hql = new SqlAppender("from TAppUser u,TAppUserInfo t where (u.parentID = "+userInfo.getUserId()+" and t.userId=u.id");
//				hql.append(")");
//				hql.append(" and u.state = '1'");
//				hql.append(" order by  u.creatTime desc");
//				List  list = executeQuery(hql.getPsSql(),hql.getParamsValues());
//				map.put("yrSun", list.size()+"");
				
				hql = new SqlAppender("from TAppBusinessInfo b where ");
				hql.append(" b.buyer = ?",userInfo.getUserId());
				hql.append(" or b.sellerCompany = ?",userInfo.getUserId());
				List  list1 = executeQuery(hql.getPsSql(),hql.getParamsValues());
				map.put("businessTime", list1.size()+"");
			}
			a.add(map);
		}
		return a;
	}

	public List getZhyByorgId(int id) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("select t.id ,count(t.id) as odby, sum(i.price) as sumPrice ,o.recommendUrl  from TAppUser t ,TAppUserInfo o,TAppBusinessInfo i where t.id = i.qyUserId and t.id = o.userId and i.status IN ('3','4','5') ");
		hql.append(" and i.orgUserId = ?",id);
		hql.append(" and t.state = ?","1");
		hql.append(" GROUP BY i.qyUserId ORDER BY count(t.id) desc, i.creatTime desc");
		return executeQuery(hql.getPsSql(),hql.getParamsValues(),0,4);
	}
	public List getZhyByorgId_other(int id) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("select t.id ,'0' as odby, '0' as sumPrice,o.recommendUrl  from TAppUser t ,TAppUserInfo o where  t.id = o.userId  ");
		hql.append(" and t.parentID = ?",id);
		hql.append(" and t.state = ?","1");
		hql.append(" ORDER BY t.creatTime desc");
		return executeQuery(hql.getPsSql(),hql.getParamsValues(),0,4);
	}
	
	public List getYrxxs(int id, int i, int rowCount, String sex, String pro1,String pro2, String pri) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("from TAppUser t ,TAppUserInfo o,TAppCostInfo c,TAppTalentCategory s where t.id = o.userId and t.id = c.userId and s.id= c.profession ");
		
		hql.append(" and t.parentID = ?",id);
		hql.append(" and t.state = ?","1");
		if("1".equals(sex)){
			hql.append(" and o.sex = '1'");
		}else if("2".equals(sex)){
			hql.append(" and o.sex = '2'");
		}
		if("1".equals(pro1)){
			hql.append(" and s.subId ='1'");
		}else if ("2".equals(pro1)){
			hql.append(" and s.subId ='2'");
		}else if ("3".equals(pro1)){
			hql.append(" and s.subId ='3'");
		}else if ("4".equals(pro1)){
			hql.append(" and s.subId ='4'");
		}else if ("5".equals(pro1)){
			hql.append(" and s.subId ='5'");
		}else if ("6".equals(pro1)){
			hql.append(" and s.subId ='6'");
		}
		hql.append(" and s.parentId !='0'");
		
		if(!pro2.equals("0"))
			hql.append(" and s.id ='"+pro2+"'");
		
		if("1".equals(pri)){
			hql.append(" and c.eprice+0>=?",100);
			hql.append(" and c.bprice+0<=?",500);
		}else if("2".equals(pri)){
			hql.append(" and c.eprice+0>=?",500);
			hql.append(" and c.bprice+0<=?",1000);
		}else if("3".equals(pri)){
			hql.append(" and c.eprice+0>=?",1000);
			hql.append(" and c.bprice+0<=?",2000);
		}else if("4".equals(pri)){
			hql.append(" and c.eprice+0>=?",2000);
		}
		hql.append(" group by t.id order by o.comRecommend desc,o.comRecommendTime desc");
		return executeQuery(hql.getPsSql(),hql.getParamsValues(),i,rowCount);
	}
	public int getYrxxsTotal(int id,String sex, String pro1,String pro2, String pri){
SqlAppender hql = new SqlAppender("from TAppUser t ,TAppUserInfo o,TAppCostInfo c,TAppTalentCategory s where t.id = o.userId and t.id = c.userId and s.id= c.profession ");
		
		hql.append(" and t.parentID = ?",id);
		hql.append(" and t.state = ?","1");
		if("1".equals(sex)){
			hql.append(" and o.sex = '1'");
		}else if("2".equals(sex)){
			hql.append(" and o.sex = '2'");
		}
		if("1".equals(pro1)){
			hql.append(" and s.subId ='1'");
		}else if ("2".equals(pro1)){
			hql.append(" and s.subId ='2'");
		}else if ("3".equals(pro1)){
			hql.append(" and s.subId ='3'");
		}else if ("4".equals(pro1)){
			hql.append(" and s.subId ='4'");
		}else if ("5".equals(pro1)){
			hql.append(" and s.subId ='5'");
		}else if ("6".equals(pro1)){
			hql.append(" and s.subId ='6'");
		}
		hql.append(" and s.parentId !='0'");
		
		if(!pro2.equals("0"))
			hql.append(" and s.id ='"+pro2+"'");
		
		if("1".equals(pri)){
			hql.append(" and c.eprice+0>=?",100);
			hql.append(" and c.bprice+0<=?",500);
		}else if("2".equals(pri)){
			hql.append(" and c.eprice+0>=?",500);
			hql.append(" and c.bprice+0<=?",1000);
		}else if("3".equals(pri)){
			hql.append(" and c.eprice+0>=?",1000);
			hql.append(" and c.bprice+0<=?",2000);
		}else if("4".equals(pri)){
			hql.append(" and c.eprice+0>=?",2000);
		}
		hql.append(" group by t.id order by o.comRecommend desc,o.comRecommendTime desc");
		List list=  executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list.size();
	}
	public int getUserTotalByorgId(int id, String sex, String pro, String pri) {
		// TODO Auto-generated method stub
	SqlAppender hql = new SqlAppender("from TAppUser t ,TAppUserInfo o,TAppCostInfo c,TAppTalentCategory s where t.id = o.userId and t.id = c.userId and s.id= c.profession ");
		
		hql.append(" and t.parentID = ?",id);
		hql.append(" and t.state = ?","1");
		if("sex1".equals(sex)){
			hql.append(" and o.sex = '1'");
		}else if("sex2".equals(sex)){
			hql.append(" and o.sex = '2'");
		}
		if("pro1".equals(pro)){
			hql.append(" and s.subId ='1'");
		}else if ("pro2".equals(pro)){
			hql.append(" and s.subId ='2'");
		}else if ("pro3".equals(pro)){
			hql.append(" and s.subId ='3'");
		}else if ("pro4".equals(pro)){
			hql.append(" and s.subId ='4'");
		}else if ("pro5".equals(pro)){
			hql.append(" and s.subId ='5'");
		}else if ("pro6".equals(pro)){
			hql.append(" and s.subId ='6'");
		}else if ("pro7".equals(pro)){
			hql.append(" and s.subId ='38'");
		}
		
		
		if("pri1".equals(pri)){
			hql.append(" and c.eprice+0>=?",0);
			hql.append(" and c.bprice+0<=?",500);
		}else if("pri2".equals(pri)){
			hql.append(" and c.eprice+0>=?",500);
			hql.append(" and c.bprice+0<=?",2000);
		}else if("pri3".equals(pri)){
			hql.append(" and c.eprice+0>=?",2000);
			hql.append(" and c.bprice+0<=?",5000);
		}else if("pri4".equals(pri)){
			hql.append(" and c.eprice+0>=?",5000);
			hql.append(" and c.bprice+0<=?",10000);
		}else if("pri5".equals(pri)){
			hql.append(" and c.eprice+0>=?",10000);
			hql.append(" and c.bprice+0<=?",200000);
		}else if("pri6".equals(pri)){
			hql.append(" and c.eprice+0>=?",200000);
			hql.append(" and c.bprice+0<=?",1000000000);
		}
		hql.append("group by t.id order by o.recommendUrl desc,o.recommendTime desc");
//		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		List list =  getSession().createSQLQuery("SELECT * FROM t_app_user t ,t_app_user_info o,t_app_cost_info c,t_app_talent_category s WHERE t.id = o.userId AND t.id = c.userId AND s.id= c.profession AND t.parentID =167 AND t.state = '1' GROUP BY t.id ORDER BY o.recommendUrl DESC,o.recommendTime DESC ").list();
		if(list != null){
			return list.size();
		}else{
			return 0;
		}
		//return getRowCount(hql.getPsSql(),hql.getParamsValues());
	}
	
//	public int getUserCountByorgId(int id) {
//		// TODO Auto-generated method stub
//	SqlAppender hql = new SqlAppender("from TAppUser t ,TAppUserInfo o,TAppCostInfo c,TAppTalentCategory s where t.id = o.userId and t.id = c.userId and s.id= c.profession ");
//		
//		hql.append(" and t.parentID = ?",id);
//		hql.append(" and t.state = ?","1");
//		
//		hql.append("group by t.id order by o.recommendUrl desc,o.recommendTime desc");
////		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
//		List list =  getSession().createSQLQuery("SELECT * FROM t_app_user t ,t_app_user_info o,t_app_cost_info c,t_app_talent_category s WHERE t.id = o.userId AND t.id = c.userId AND s.id= c.profession AND t.parentID =167 AND t.state =1 GROUP BY t.id ORDER BY o.recommendUrl DESC,o.recommendTime DESC ").list();
//		if(list != null){
//			return list.size();
//		}else{
//			return 0;
//		}
//		//return getRowCount(hql.getPsSql(),hql.getParamsValues());
//	}
//	
	public int getQySumByOrgId(int id) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("from TAppBusinessInfo i,TAppUser t where  i.status IN ('3','4','5')  and t.id = i.qyUserId ");
		hql.append(" and i.orgUserId=?",id);
		hql.append(" and t.state = ?","1");
		return getRowCount(hql.getPsSql(),hql.getParamsValues());
	}
	//根据用户id查用户信息
	public TAppUser getUserById(int id){
		TAppUser user=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppUser where id=?",id);
		List<TAppUser> userList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(userList!=null&&userList.size()>0){
 			user=userList.get(0);
 		}
 		return user;
	}
	public List findPrePostUserId(int id,Integer profession, int direction) {
		SqlAppender hql = new SqlAppender(" select t from TAppUser t ,TAppCostInfo c where t.id = c.userId ");
		//SqlAppender hql = new SqlAppender(" select t from TAppUser t ");
		if(direction > 0){
			hql.append(" and t.id < ?",id);
			hql.append(" and c.profession = ?",profession);
			hql.append(" and t.state = '1' ORDER BY t.id desc");
		}else{
			hql.append(" and t.id > ?",id);
			hql.append(" and c.profession = ?",profession);
			hql.append(" and t.state = '1' ORDER BY t.id asc ");
		}
		return executeQuery(hql.getPsSql(),hql.getParamsValues(),0,1);
	}
	
	/**
	 * Get user list by the parent id;
	 * 
	 * ze9fan @201603
	 * @param parentId
	 * @return
	 */
	public List findUserListByParentId(int parentId) {
		SqlAppender hql = new SqlAppender(" select t from TAppUser t where t.state = 1 ");
		hql.append(" and t.parentID = ?", parentId);
		return executeQuery(hql.getPsSql(), hql.getParamsValues());
	}
	
	public List<TAppCostInfo> findProfession(int id) {
		SqlAppender hql = new SqlAppender("select c from TAppUser t ,TAppCostInfo c where t.id = c.userId ");
		 
		hql.append(" and t.id = ?",id);
	 
		return executeQuery(hql.getPsSql(),hql.getParamsValues(),0,1);
	}
	public List getArtUserList(int id,String sex,String pro1,String pri,int begin, int length) {
		SqlAppender hql = new SqlAppender("from TAppUser t ,TAppUserInfo o,TAppCostInfo c,TAppTalentCategory s where t.id = o.userId and t.id = c.userId and s.id= c.profession ");
		
		hql.append(" and t.parentID = ?",id);
		hql.append(" and t.state = ?","1");
		if("1".equals(sex)){
			hql.append(" and o.sex = '1'");
		}else if("2".equals(sex)){
			hql.append(" and o.sex = '2'");
		}
		if("1".equals(pro1)){
			hql.append(" and s.subId ='1'");
		}else if ("2".equals(pro1)){
			hql.append(" and s.subId ='2'");
		}else if ("3".equals(pro1)){
			hql.append(" and s.subId ='3'");
		}else if ("4".equals(pro1)){
			hql.append(" and s.subId ='4'");
		}else if ("5".equals(pro1)){
			hql.append(" and s.subId ='5'");
		}else if ("6".equals(pro1)){
			hql.append(" and s.subId ='6'");
		}
		//hql.append(" and s.parentId !='0'");
		
	
		if("1".equals(pri)){
			hql.append(" and (c.bprice+0>=?",0);
			hql.append(" and c.bprice+0<?)",500);
		}else if("2".equals(pri)){
			hql.append(" and (c.bprice+0>=?",500);
			hql.append(" and c.bprice+0<?)",1000);
		}else if("3".equals(pri)){
			hql.append(" and (c.bprice+0>=?",1000);
			hql.append(" and c.bprice+0<?)",2000);
		}else if("4".equals(pri)){
			hql.append(" and (c.bprice+0>=?",2000);
			hql.append(" and c.bprice+0<?)",3000);
		}else if("5".equals(pri)){
			hql.append(" and c.bprice+0>=?",3000);
		}
		hql.append(" group by t.id order by o.comRecommend desc,o.comRecommendTime desc,t.id desc");
		List list =  executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,length);
		return list;
	}
	public int getArtUserTotal(int id,String sex,String pro1,String pri) {
		SqlAppender hql = new SqlAppender("from TAppUser t ,TAppUserInfo o,TAppCostInfo c,TAppTalentCategory s where t.id = o.userId and t.id = c.userId and s.id= c.profession ");
		
		hql.append(" and t.parentID = ?",id);
		hql.append(" and t.state = ?","1");
		if("1".equals(sex)){
			hql.append(" and o.sex = '1'");
		}else if("2".equals(sex)){
			hql.append(" and o.sex = '2'");
		}
		if("1".equals(pro1)){
			hql.append(" and s.subId ='1'");
		}else if ("2".equals(pro1)){
			hql.append(" and s.subId ='2'");
		}else if ("3".equals(pro1)){
			hql.append(" and s.subId ='3'");
		}else if ("4".equals(pro1)){
			hql.append(" and s.subId ='4'");
		}else if ("5".equals(pro1)){
			hql.append(" and s.subId ='5'");
		}else if ("6".equals(pro1)){
			hql.append(" and s.subId ='6'");
		}
		//hql.append(" and s.parentId !='0'");
		
	
		if("1".equals(pri)){
			hql.append(" and (c.bprice+0>=?",0);
			hql.append(" and c.bprice+0<?)",500);
		}else if("2".equals(pri)){
			hql.append(" and (c.bprice+0>=?",500);
			hql.append(" and c.bprice+0<?)",1000);
		}else if("3".equals(pri)){
			hql.append(" and (c.bprice+0>=?",1000);
			hql.append(" and c.bprice+0<?)",2000);
		}else if("4".equals(pri)){
			hql.append(" and (c.bprice+0>=?",2000);
			hql.append(" and c.bprice+0<?)",3000);
		}else if("5".equals(pri)){
			hql.append(" and c.bprice+0>=?",3000);
		}
		
		hql.append(" group by t.id ");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		if(list != null){
			return list.size();
		}else{
			return 0;
		}
	}
	public TAppUser findUserByMobile(String mobile) {
		SqlAppender hql = new SqlAppender(" select t from TAppUser t ,TAppUserInfo o where t.id = o.userId ");
		
		hql.append(" and o.mobile = ?",mobile);
		 
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		if(list != null && list.size() > 0){
			return (TAppUser)list.get(0);
		}else{
			return null;
		}
	}
	
	public List getScore(int userId,int isOrg) {
		SqlAppender hql = new SqlAppender(" select t from TAppBusinessEvaluate t ,TAppBusinessInfo info where info.id = t.businessId  ");
		
		if(isOrg==0){
			hql.append(" and info.seller = ?",userId);
		}else{
			hql.append(" and (info.sellerCompany = ?",userId);
			hql.append(" or info.seller = ?)",userId);
		}
		
		//String tSql = HqlToSql.formatHqlToSql(super.getSession(),hql.getPsSql(), CollectionUtils.arrayToList(hql.getParamsValues()));
		//logger.info(".....getScore.tSql="+tSql);
		
		
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		return list;
	}
	
	/**
	 * ze9fan
	 * @param email
	 * @return
	 */
	public int countUserByEmail(String email){
		SqlAppender hql = new SqlAppender(" select u from TAppUser u where 1 = 1 ");
		hql.append(" and u.email = ?", email);
		return getRowCount(hql.getPsSql(), hql.getParamsValues());
	}
}
