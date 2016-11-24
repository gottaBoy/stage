package com.smt.webapp.service.friend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppDing;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.friend.FriendInfoDao;

@Service
public class FriendInfoService {

	@Autowired
	private FriendInfoDao friendInfoDao;
	
	public List<TAppUserInfo> getFriendUserInfoList(int userId,int  begin,int rowCount,int sign){
		return friendInfoDao.getFriendUserInfoList(userId, begin, rowCount, sign);
	}
	
	public List<TAppFriendInfo> getFriendList(int userId,int  begin,int rowCount,int sign){
		return friendInfoDao.getFriendList(userId, begin, rowCount, sign);
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		return friendInfoDao.getTotal(userId, rowCount, sign);
	}
	
	public TAppFriendInfo getFriendInfo(int userId,int friendId){
		return friendInfoDao.getFriendInfo(userId, friendId);
	}
	
	public void delFriendInfo(TAppFriendInfo item){
		friendInfoDao.delFriendInfo(item);
	}
	
	public void addFriendInfo(TAppFriendInfo item){
		friendInfoDao.addFriendInfo(item);
	}

	public int getTotalByorgId(int id) {
		// TODO Auto-generated method stub
		return friendInfoDao.getTotalByorgId(id);
	}

	public void addDing(TAppDing item){
		friendInfoDao.addDing(item);
	}

	public int getDingTotal(int userId, int dingUserId,int type){
		return friendInfoDao.getDingTotal(userId, dingUserId,type);
	}

	public int getTotalFriends(Integer userId, int sign) {
		return friendInfoDao.getTotalFriends(userId, sign);
	}
	
	public boolean isFollowingUser(int userId, int followerId) {
		return friendInfoDao.isFollowingUser(userId, followerId);
	}
}
