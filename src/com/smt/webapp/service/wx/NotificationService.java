package com.smt.webapp.service.wx;

public interface NotificationService {
   
	 public void sendApplyNotification(int applyUserId, String applyUserName, int taskId, String taskName,String roleName, String ownerOpenId);
	 
	 public void sendInviteNotification(int invitingUserId, String invitingUserName, String bizName, String roleName, String invitedUserOpenId,String creatTime);
	 
	 public void sendRefuseNotification(int taskId, String taskName, String roleName, String openId,String createTime);
}
