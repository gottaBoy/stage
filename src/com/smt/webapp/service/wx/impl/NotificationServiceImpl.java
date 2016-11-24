package com.smt.webapp.service.wx.impl;

import org.springframework.stereotype.Service;

import com.smt.webapp.service.wx.NotificationService;
import com.smt.webapp.weih5.utils.H5WeixinHelper;
import com.smt.webapp.weih5.utils.H5WeixinUtils;

import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.WxMpTemplateMessage;

@Service("NotificationService")
public class NotificationServiceImpl implements NotificationService{

   private static final String FONT_COLOR = "#173177";
   
   //@Autowired
   //@Qualifier("WxMpService")
   private WxMpService wxMpService;

   @Override
   public void sendApplyNotification(int applyUserId, String applyUserName, int taskId, String taskName,String roleName, String ownerOpenId) {
		/* 新应征通知
		        {{first.DATA}}
		        应征者：{{keyword1.DATA}}
		        应征通告：{{keyword2.DATA}}
		        应征角色：{{keyword3.DATA}}
		        {{remark.DATA}}
		*/
		System.out.println("sendApplyNotification...");
		WxMpInMemoryConfigStorage config = new WxMpInMemoryConfigStorage();
		config.setAppId(H5WeixinHelper.APP_ID); // 设置微信公众号的appid
		config.setSecret(H5WeixinHelper.APP_SECRET); // 设置微信公众号的app corpSecret
		config.setToken(H5WeixinUtils.ACCESS_TOKEN); // 设置微信公众号的token
		
		WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
		templateMessage.setToUser(ownerOpenId);
		//templateMessage.setTemplateId("OPENTM405800262");//应征反馈通知
		templateMessage.setTemplateId("sVtsb8NLtFIHif1CFrBBG-tl3-c3VEgWlKoVc2HHkmI");//应征反馈通知
		String url = "http://www.d15t.com/artistDetail.htm?userId=" + applyUserId;
		templateMessage.setUrl(url);
		templateMessage.setTopColor(FONT_COLOR);
		templateMessage.getData().add(new WxMpTemplateData("first","你好，你收到一份应征者简历",FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword1",applyUserName,FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword2", taskName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword3", roleName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("remark", "点击查看简历", FONT_COLOR));
		System.out.println(String.format("用户 %s 应征了您的通告: %s", applyUserName, taskName));
		System.out.println("userId: " + applyUserId);
		System.out.println("taskId: " + taskId);
		System.out.println("openId: " + ownerOpenId);
		System.out.println("json=" + templateMessage.toJson());
		try {
			wxMpService.templateSend(templateMessage);
		} catch (WxErrorException e) {
			e.printStackTrace();
		}
		// nickName
		// userId, url
		// taskName
		// taskId, url

		// String response = sendPostRequest(WEIXIN_API_URL, new HashMap<String,
		// String>());
	}
	
    @Override
	public void sendInviteNotification(int invitingUserId, String invitingUserName, String bizName, String roleName, String invitedUserOpenId,String creatTime) {
		/*
		        {{first.DATA}}
		        应征通告：{{keyword1.DATA}}
		        应征角色：{{keyword2.DATA}}
		        通告时间：{{keyword3.DATA}}
		        {{remark.DATA}}
		*/
		System.out.println("sendInviteNotification...");
		WxMpInMemoryConfigStorage config = new WxMpInMemoryConfigStorage();
		config.setAppId(H5WeixinHelper.APP_ID); // 设置微信公众号的appid
		config.setSecret(H5WeixinHelper.APP_SECRET); // 设置微信公众号的app corpSecret
		config.setToken(H5WeixinUtils.ACCESS_TOKEN); // 设置微信公众号的token
		
		WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
		templateMessage.setToUser(invitedUserOpenId);
		//templateMessage.setTemplateId("OPENTM405800270");//应征反馈通知
		templateMessage.setTemplateId("49LF514rsYfLUbHUxBre94Iv_Zl-4PPIlVI1gBrTvVQ");//应征反馈通知
		String url = "http://www.d15t.com/artistDetail.htm?userId=" + invitingUserId;
		templateMessage.setUrl(url);
		templateMessage.setTopColor(FONT_COLOR);
		templateMessage.getData().add(new WxMpTemplateData("first","你好，你收到一个新的预约通知", FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword1", invitingUserName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword2", bizName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword3", roleName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("remark", "点击查看详情", FONT_COLOR));
		// 用户 xxx 邀请您 xxx
		System.out.println(String.format("用户 %s 邀请了您", invitingUserName));
		System.out.println("invitingUserId: " + invitingUserId);
		System.out.println("bizName: " + bizName);
		System.out.println("roles: " + roleName);
		System.out.println("openId: " + invitedUserOpenId);
		try {
			wxMpService.templateSend(templateMessage);
		} catch (WxErrorException e) {
			e.printStackTrace();
		}

		// nickName
		// bizName

	}

    @Override
	public void sendRefuseNotification(int taskId, String taskName, String roleName, String openId,String createTime) {
		/*
		        {{first.DATA}}
		        应征通告：{{keyword1.DATA}}
		        应征角色：{{keyword2.DATA}}
		        通告时间：{{keyword3.DATA}}
		        {{remark.DATA}}
		*/
		System.out.println("sendRefuseNotification...");
		WxMpInMemoryConfigStorage config = new WxMpInMemoryConfigStorage();
		config.setAppId(H5WeixinHelper.APP_ID); // 设置微信公众号的appid
		config.setSecret(H5WeixinHelper.APP_SECRET); // 设置微信公众号的app corpSecret
		config.setToken(H5WeixinUtils.ACCESS_TOKEN); // 设置微信公众号的token
		
		WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
		templateMessage.setToUser(openId);
		//templateMessage.setTemplateId("OPENTM405800270");//应征反馈通知
		templateMessage.setTemplateId("zw489X8PXurUw8WZgUr1cMHYO1qCrhySOIWEX1y6t8M");//应征反馈通知
		templateMessage.setUrl("");
		templateMessage.setTopColor(FONT_COLOR);
		templateMessage.getData().add(new WxMpTemplateData("first", "你好，抱歉的通知你未能入选，请再接再厉哦", FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword1", taskName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword2", roleName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword3", createTime, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("remark", "还有更多机会在等待你，加油！", FONT_COLOR));

		String.format("您应征的通告 %s 的 %s 角色 已被创建人拒绝，请知晓。", taskName, roleName);

		System.out.println("taskId: " + taskId);
		System.out.println("openId: " + openId);

		// 您应征的通告，角色，已被拒绝＋拒绝理由？
		try {
			wxMpService.templateSend(templateMessage);
		} catch (WxErrorException e) {
			e.printStackTrace();
		}

	}
}
