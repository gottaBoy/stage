package com.smt.webapp.service.weih5;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.smt.webapp.weih5.utils.H5WeixinHelper;
import com.smt.webapp.weih5.utils.H5WeixinUtils;
import com.smt.webapp.weih5.utils.HttpPostUtil;

import edu.emory.mathcs.backport.java.util.concurrent.ConcurrentHashMap;
import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import me.chanjar.weixin.mp.bean.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.WxMpTemplateMessage;

@Service
public class H5NotificationService {

	/**
	 * WEIXIN
	 */
	private static final String WEIXIN_API_URL = "";
	private static final String TEMPLATE_ID_APPLY = "";
	private static final String TEMPLATE_ID_INVITE = "";
	private static final String TEMPLATE_ID_REFUSE = "";
	private static final String TEMPLATE_ID_CLOSE_TASK = "";

	/**
	 * SMS
	 */
	private static final String SMS_API_URL = "";
	private static final String SMS_ACCOUNT = "";
	private static final String SMS_PASSWORD = "";
	
	//@Autowired
	//private WxMpService wxMpService;
	private static final String FONT_COLOR = "#173177";
	private static final String SEND_URL = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=";

	/**
	 * cache for sms sending
	 */
	private static final Map<Integer, List<Date>> SMS_CACHE = new ConcurrentHashMap();

	public void sendSMS(H5NotificationTypeEnum type, Integer[] mobileNOs) {

		// check type and for each

		// validation phone no: no style and cache

		// clean cache, save cache and send

		// log if not normal
	}

	private String sendPostRequest(String url, Map<String, String> param) {
		try {
			HttpClient client = new HttpClient();
			PostMethod method = new PostMethod(url);

			if (!CollectionUtils.isEmpty(param)) {
				NameValuePair[] data = new NameValuePair[param.size()];
				int index = 0;
				for (String key : param.keySet()) {
					NameValuePair valuePair = new NameValuePair(key, param.get(key));
					data[index] = valuePair;
				}
				method.setRequestBody(data);
			}

			int status = -1;
			status = client.executeMethod(method);
			String response = method.getResponseBodyAsString();
			method.releaseConnection();
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private String sendGetRequest(String url, Map<String, String> param) {
		try {
			HttpClient client = new HttpClient();
			HttpMethod method = new GetMethod(url);

			if (!CollectionUtils.isEmpty(param)) {
				HttpMethodParams params = client.getParams();
				for (String key : param.keySet()) {
					params.setParameter(key, param.get(key));
				}
				method.setParams(params);
			}

			int status = -1;
			status = client.executeMethod(method);
			String response = method.getResponseBodyAsString();
			method.releaseConnection();

			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

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
		String access_token = H5WeixinUtils.getAccessToken(H5WeixinHelper.APP_ID, H5WeixinHelper.APP_SECRET);
		config.setToken(access_token); // 设置微信公众号的token
		
		WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
		templateMessage.setToUser(ownerOpenId);
		templateMessage.setTemplateId("OPENTM405800262");//应征反馈通知
		//templateMessage.setTemplateId("sVtsb8NLtFIHif1CFrBBG-tl3-c3VEgWlKoVc2HHkmI");//应征反馈通知
		//String url = "http://www.d15t.com/taskDetail.htm?taskId=" + task.getId();
		String url = "http://4e421ec3.ngrok.io/stage01/taskDetail.htm?taskId=" + taskId;
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
		String result = "";
		result = HttpPostUtil.doHttpPostJson(SEND_URL + access_token, templateMessage.toJson());
		System.out.println("result: " + result);
//		try {
//			wxMpService.templateSend(templateMessage);
//		} catch (WxErrorException e) {
//			e.printStackTrace();
//		}
	}
	
	public void sendInviteNotification(int invitingUserId, String invitingUserName, String bizName, String roleName, String invitedUserOpenId,int taskId) {
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
		String access_token = H5WeixinUtils.getAccessToken(H5WeixinHelper.APP_ID, H5WeixinHelper.APP_SECRET);
		config.setToken(access_token); // 设置微信公众号的token
		
		WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
		templateMessage.setToUser(invitedUserOpenId);
		templateMessage.setTemplateId("OPENTM405800270");//应征反馈通知
		//templateMessage.setTemplateId("49LF514rsYfLUbHUxBre94Iv_Zl-4PPIlVI1gBrTvVQ");//应征反馈通知
		String url = "http://www.d15t.com/taskDetail.htm?taskId=" + taskId;
		//String url = "http://4e421ec3.ngrok.io/stage01/taskDetail.htm?taskId=" + taskId;
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
		String result = "";
		result = HttpPostUtil.doHttpPostJson(SEND_URL + access_token, templateMessage.toJson());
		System.out.println("result: " + result);
//		try {
//			wxMpService.templateSend(templateMessage);
//		} catch (WxErrorException e) {
//			e.printStackTrace();
//		}

	}

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
		String access_token = H5WeixinUtils.getAccessToken(H5WeixinHelper.APP_ID, H5WeixinHelper.APP_SECRET);
		config.setToken(access_token); // 设置微信公众号的token
		
		WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
		templateMessage.setToUser(openId);
		templateMessage.setTemplateId("OPENTM405800270");//应征反馈通知
		//templateMessage.setTemplateId("zw489X8PXurUw8WZgUr1cMHYO1qCrhySOIWEX1y6t8M");//应征反馈通知
		String url = "http://www.d15t.com/taskDetail.htm?taskId=" + taskId;
		//String url = "http://4e421ec3.ngrok.io/stage01/taskDetail.htm?taskId=" + taskId;
		templateMessage.setUrl(url);
		templateMessage.setTopColor(FONT_COLOR);
		templateMessage.getData().add(new WxMpTemplateData("first", "你好，抱歉的通知你未能入选，请再接再厉哦", FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword1", taskName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword2", roleName, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("keyword3", createTime, FONT_COLOR));
		templateMessage.getData().add(new WxMpTemplateData("remark", "还有更多机会在等待你，加油！", FONT_COLOR));
		String.format("您应征的通告 %s 的 %s 角色 已被创建人拒绝，请知晓。", taskName, roleName);
		System.out.println("taskId: " + taskId);
		System.out.println("openId: " + openId);
		String result = "";
		result = HttpPostUtil.doHttpPostJson(SEND_URL + access_token, templateMessage.toJson());
		System.out.println("result: " + result);

		// 您应征的通告，角色，已被拒绝＋拒绝理由？
//		try {
//			wxMpService.templateSend(templateMessage);
//		} catch (WxErrorException e) {
//			e.printStackTrace();
//		}

	}

	public void send4TaskClose() {
		System.out.println("send4TaskClose...");

		//

		// task id
		// task name
		// role name
		// applied users' open id
		//

	}
}
