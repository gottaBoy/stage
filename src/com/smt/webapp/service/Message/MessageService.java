package com.smt.webapp.service.Message;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppMessage;
import com.smt.webapp.dao.message.MessageDao;

@Service
public class MessageService {
	
	@Autowired
	private MessageDao messageDao;

	public List getMessageList(int userId,int  begin,int rowCount,int sign){
		return messageDao.getMessageList(userId, begin, rowCount, sign);
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		return messageDao.getTotal(userId, rowCount, sign);
	}
	
	public TAppMessage getMessageByID(int id){
		TAppMessage message=new TAppMessage();
		if(messageDao.getMessageByID(id)!=null&&messageDao.getMessageByID(id).size()>0){
			message=messageDao.getMessageByID(id).get(0);
		}
		return message;
	}
	
	public void addMessage(TAppMessage item){
		messageDao.addMessage(item);
	}
	
	public void delMessage(TAppMessage item){
		messageDao.delMessage(item);
	}
	
	//查询用户未读短信条数
	public int getUnreadMessageCount(int userId){
		return messageDao.getUnreadMessageCount(userId);
	}
}
