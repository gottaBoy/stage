package com.smt.webapp.dao.message;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppMessage;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class MessageDao extends BaseDao {
	
	//发送的信息sign=1，接收的信息sign=2
	public List getMessageList(int userId,int  begin,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//发送的信息
			hql.append("select t,u.username,ui.nickName,u.id from TAppMessage t,TAppUser u,TAppUserInfo ui where t.toUserId=u.id and u.id=ui.userId");
			hql.append(" and t.sendType>0 and t.fromUserId=?",userId);
			hql.append(" order by t.creatTime desc");
		}else if(sign==2){ //接收的信息
			hql.append("select t,u.username,ui.nickName,u.id from TAppMessage t,TAppUser u,TAppUserInfo ui where t.fromUserId=u.id and u.id=ui.userId ");
			hql.append(" and t.toUserId=?",userId);
			hql.append(" order by t.creatTime desc");
		}
		List messageList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		
 		return messageList;
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//发送的信息
			hql.append("select t,u.username,ui.nickName from TAppMessage t,TAppUser u,TAppUserInfo ui where t.toUserId=u.id and u.id=ui.userId");
			hql.append(" and t.sendType>0 and t.fromUserId=?",userId);
		}else if(sign==2){ //接收的信息
			hql.append("select t,u.username,ui.nickName from TAppMessage t,TAppUser u,TAppUserInfo ui where t.fromUserId=u.id and u.id=ui.userId ");
			hql.append(" and t.toUserId=?",userId);
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public List<TAppMessage> getMessageByID(int id){
		SqlAppender hql = new SqlAppender("from TAppMessage t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppMessage> message = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return message;
	}
	
	public void addMessage(TAppMessage item){
		saveOrUpdate(item);
	}
	
	public void delMessage(TAppMessage item){
		delete(item);
	}
	
	//查询用户未读短信条数
	public int getUnreadMessageCount(int userId){
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppMessage t where t.status='0' ");
		hql.append(" and t.toUserId=?",userId);
		int unreadMessageCount=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return unreadMessageCount;
	}
}
