package com.smt.webapp.web.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppDing;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.friend.FriendInfoService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;

@Controller
public class FriendInfoAction extends ActionSupport {
	
	@Autowired
	private FriendInfoService friendInfoService;
	@Autowired
	private ArtInfoService artInfoService;
	
	private TAppUserInfo userInfo;

	public TAppUserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(TAppUserInfo userInfo) {
		this.userInfo = userInfo;
	}
	
	public String toFriendInfo(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();

		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		
		int total = friendInfoService.getTotal(userId, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;

		List<TAppFriendInfo> friendList=friendInfoService.getFriendList(userId, (pageNum-1)*rowCount, rowCount, sign);

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("friendList", friendList);
		
		return SUCCESS;
	}
	
	public String delFriendInfo(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int friendId=request.getParameter("friendId")==null?0:Integer.parseInt(request.getParameter("friendId").toString());
		TAppFriendInfo item=friendInfoService.getFriendInfo(userId, friendId);
		friendInfoService.delFriendInfo(item);
		return "delFriendInfo";
		
	}
	
	public String addFriendInfo(){
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int friendId=request.getParameter("friendId")==null?0:Integer.parseInt(request.getParameter("friendId").toString());
		
		TAppFriendInfo friend = friendInfoService.getFriendInfo(userId, friendId);
		if(friend != null) {
			return null;
		}
		
		TAppFriendInfo item=new TAppFriendInfo();
		item.setUserId(userId);
		item.setFriendId(friendId);
		item.setCreatTime(createDateTime);
		friendInfoService.addFriendInfo(item);
		return "addFriendInfo";
		
	}
	
	
	public void addFriend() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		if(HttpSessionHelper.getUserSession(request) == null) {
			response.getWriter().write("3");
			return ;
		}
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int friendId=request.getParameter("friendId")==null?0:Integer.parseInt(request.getParameter("friendId").toString());
		if(userId==friendId){
			response.getWriter().write("2");
			return ;
		}
		
		TAppFriendInfo friend = friendInfoService.getFriendInfo(userId, friendId);
		if(friend != null) {
			response.getWriter().write("4");
			return;
		}
		
		TAppFriendInfo item=new TAppFriendInfo();
		item.setUserId(userId);
		item.setFriendId(friendId);
		item.setCreatTime(CommonUtil.getTime(new Date()));
		friendInfoService.addFriendInfo(item);
		response.getWriter().write("1");
	}
	
	
	public void addDing() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		if(HttpSessionHelper.getUserSession(request) == null) {
			response.getWriter().write("3");
			return ;
		}
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int dingUserId=request.getParameter("dingUserId")==null?0:Integer.parseInt(request.getParameter("dingUserId").toString());
		int type=request.getParameter("flag")==null?0:Integer.parseInt(request.getParameter("flag").toString());
		if(userId==dingUserId){
			response.getWriter().write("2");
			return ;
		}
		int count = friendInfoService.getDingTotal(userId, dingUserId,type);
		if(count > 0) {
			response.getWriter().write("4");
			return ;
		}
		TAppDing item=new TAppDing();
		item.setUserId(userId);
		item.setDingUserId(dingUserId);
		item.setCreateTime(CommonUtil.getTime(new Date()));
		item.setType(type);
		friendInfoService.addDing(item);
		if (type>1) {
			int count1 = friendInfoService.getDingTotal(0, dingUserId,type);
			TAppArtInfo artInfo = artInfoService.getArtInfoByID(dingUserId);
			artInfo.setDing(count1);
			artInfoService.saveOrUpdateArtInfo(artInfo);
		}
		
		response.getWriter().write("1");
	}
	
	

}
