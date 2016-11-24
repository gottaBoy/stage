package com.smt.webapp.dao.friend;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppDing;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class FriendInfoDao extends BaseDao{
	
	public List<TAppUserInfo> getFriendUserInfoList(int userId, int begin, int rowCount, int sign) {
		SqlAppender hql = new SqlAppender("");
		if (sign == 1) { // 查userid的粉丝
			hql.append("select u from TAppUserInfo u where u.userId in (select f.userId from TAppFriendInfo f where f.friendId=? order by f.creatTime desc)", userId);
//			hql.append(" order by f.creatTime desc");
		} else if (sign == 2) { // 查userid的关注
			hql.append("select u from TAppUserInfo u where u.userId in (select f.friendId from TAppFriendInfo f where f.userId=? order by f.creatTime desc)", userId);
//			hql.append(" order by f.creatTime desc");
		}
		List<TAppUserInfo> friendUserInfoList = executeQuery(hql.getPsSql(), hql.getParamsValues(), begin, rowCount);
		return friendUserInfoList;
	}
	
	//关注sign=1，粉丝sign=2，好友sign=3
	public List<TAppFriendInfo> getFriendList(int userId,int  begin,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	   //关注
			hql.append("select t,ui from TAppFriendInfo t,TAppUserInfo ui where t.friendId=ui.userId ");
			hql.append(" and t.userId=?",userId);
			//hql.append(" and t.friendId not in (select ii.userId from TAppFriendInfo ii where ii.friendId=?)",userId);
			hql.append(" order by t.creatTime desc");
		}else if(sign==2){ //粉丝
			hql.append("select t,ui from TAppFriendInfo t,TAppUserInfo ui where t.userId=ui.userId ");
			hql.append(" and t.friendId=?",userId);
			//hql.append(" and t.userId not in (select ii.friendId from TAppFriendInfo ii where ii.userId=?)",userId);
			hql.append(" order by t.creatTime desc");
		}else if(sign==3){	//好友
			hql.append("select t,ui from TAppFriendInfo t,TAppUserInfo ui where t.friendId=ui.userId ");
			hql.append(" and t.userId=?",userId);
			//hql.append(" and t.friendId in (select tt.userId from TAppFriendInfo tt where tt.friendId=?)",userId);
			hql.append(" order by t.creatTime desc");
//			
//			hql.append("select a,b,c,d from TAppUser a");
//			hql.append(" left join a.userList b");//TAppUserInfo
//			hql.append(" left join a.costList c");//TAppCostInfo
//			hql.append(" left join c.category d ");//TAppTalentCategory
//			hql.append(" left join a.friendInfo e");//TAppTalentCategory
//			hql.append(" where  a.id=?",userId);
//			hql.append(" and (e.userId=?",userId);
//			hql.append(" and e.friendId in (select tt.userId from TAppFriendInfo tt where tt.friendId=?))",userId);
////			hql.append(" and a.id in (select tt.userId from TAppFriendInfo tt where tt.friendId=?)",userId);
//			hql.append(" group by a.id order by a.creatTime desc ");
		}
		List<TAppFriendInfo> friendList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return friendList;
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	   //关注
			hql.append("select ui from TAppFriendInfo t,TAppUserInfo ui where t.friendId=ui.userId ");
			hql.append(" and t.userId=?",userId);
			//hql.append(" and t.friendId not in (select ii.userId from TAppFriendInfo ii where ii.friendId=?)",userId);
		}else if(sign==2){ //粉丝
			hql.append("select ui from TAppFriendInfo t,TAppUserInfo ui where t.userId=ui.userId ");
			hql.append(" and t.friendId=?",userId);
			//hql.append(" and t.userId not in (select ii.friendId from TAppFriendInfo ii where ii.userId=?)",userId);
		}else if(sign==3){	//好友
			hql.append("select ui from TAppFriendInfo t,TAppUserInfo ui where t.friendId=ui.userId ");
			hql.append(" and t.userId=?",userId);
			//hql.append(" and t.friendId in (select tt.userId from TAppFriendInfo tt where tt.friendId=?)",userId);
		}	
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	/**
	 * check if current user is the follower of the target user;
	 * userId, the target user;
	 * followerId, always the current userId;
	 * 
	 * ze9fan @201603
	 * @param userId
	 * @param followerId
	 * @return
	 */
	public boolean isFollowingUser(int userId, int followerId) {
		SqlAppender hql = new SqlAppender(" select * from TAppFriendInfo ");
		hql.append(" where userId=?", followerId);
		hql.append(" and friendId=?", userId);
		int count = getRowCount(hql.getPsSql(), hql.getParamsValues());
		return count != 0;
	}
	
	public TAppFriendInfo getFriendInfo(int userId,int friendId){
		TAppFriendInfo friendInfo=null;
		SqlAppender hql = new SqlAppender("from TAppFriendInfo t where 1=1 ");
		hql.append(" and t.userId=?",userId);
		hql.append(" and t.friendId=?",friendId);
 		List<TAppFriendInfo> friendList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(friendList!=null&&friendList.size()>0){
 			friendInfo=friendList.get(0);
 		}
 		return friendInfo;
	}
	
	public void delFriendInfo(TAppFriendInfo item){
		delete(item);
	}
	
	public void addFriendInfo(TAppFriendInfo item){
		save(item);
	}

	public int getTotalByorgId(int id) {
		SqlAppender hql = new SqlAppender("from TAppFriendInfo t where 1=1 ");
		hql.append(" and t.friendId=?",id);
		return getRowCount(hql.getPsSql(),hql.getParamsValues());
	}
	

	public void addDing(TAppDing item){
		save(item);
	}
	
	public int getDingTotal(int userId, int dingUserId,int type) {
		SqlAppender hql = new SqlAppender("from TAppDing t where 1=1 ");
		if(userId == 0) {//获取用户被顶次数
			hql.append(" and t.dingUserId=?",dingUserId);
			hql.append(" and t.type=?",type);
		} else {//判断用户今天是不是顶过某人
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.dingUserId=?",dingUserId);
			hql.append(" and t.type=?",type);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String date = format.format(new Date());
			hql.append(" and t.createTime like ?", date + "%");
		}
		
		return getRowCount(hql.getPsSql(),hql.getParamsValues());
	}

	public int getTotalFriends(Integer userId, int sign) {
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	   //关注
			hql.append("select ui from TAppFriendInfo t,TAppUserInfo ui where t.friendId=ui.userId ");
			hql.append(" and t.userId=?",userId);
		}else if(sign==2){ //粉丝
			hql.append("select ui from TAppFriendInfo t,TAppUserInfo ui where t.userId=ui.userId ");
			hql.append(" and t.friendId=?",userId);
		} 
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
}
