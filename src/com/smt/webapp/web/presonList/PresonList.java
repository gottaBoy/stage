package com.smt.webapp.web.presonList;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONString;
import net.sf.json.JsonConfig;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.common.Constellation;
import com.smt.common.VideoUtil;
import com.smt.entity.TAppAction;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppImagesInfo;
import com.smt.entity.TAppInformation;
import com.smt.entity.TAppSkillEvaluate;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
import com.smt.entity.TBaseArea;
import com.smt.webapp.service.action.ActionService;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;
import com.smt.webapp.service.evaluation.UserEvaluationService;
import com.smt.webapp.service.friend.FriendInfoService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.information.InformationService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class PresonList extends ActionSupport{
	private Logger logger = Logger.getLogger("mylog");
	/**
	 * s:action 传值的get，set方法（用户id）
	 */
	private int userIdParam;
	public int getUserIdParam() {
		return userIdParam;
	}
	public void setUserIdParam(int userIdParam) {
		this.userIdParam = userIdParam;
	}
	
	@Autowired
	private InformationService informationService;
	//依赖注入服务层类
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private FriendInfoService friendInfoService;
	@Autowired
	private GrowthService growthService;
	@Autowired
	private ArtInfoService artInfoService;
	@Autowired
	private CostService costService;
	@Autowired
	private UserService userService;
	@Autowired
	private ActionService actionService;
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private UserEvaluationService userEvaluationService;
	@Autowired
	private BusinessEvaluateService businessEvaluateSerive;
	
	private TAppArtInfo artInfo1=new TAppArtInfo();
	
	public TAppArtInfo getArtInfo() {
		return artInfo1;
	}

	public void setArtInfo(TAppArtInfo artInfo1) {
		this.artInfo1 = artInfo1;
	}
	/**
	 * 获取演员演出时间
	 * @return
	 * @throws IOException 
	 */
	public void getActionForUser() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		request.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html;charset=utf-8");
		int userId = Integer.parseInt(request.getParameter("id"));
		String date = request.getParameter("date");
		List<TAppAction> list = actionService.getActionForUserId(userId,date);
		JsonConfig jsonConfig = new JsonConfig(); 
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor()); 
		JSONArray array = JSONArray.fromObject(list,jsonConfig);
		response.getWriter().print(array.toString());
		response.getWriter().close();
		return;
	}
	
	
	public void getArea() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		List<TBaseArea> province = actionService.getProvins();
		JSONArray _json_pro = JSONArray.fromObject(province);
		response.getWriter().print(_json_pro.toString());
		response.getWriter().close();
		return;
	}
	public void getCity() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int id = Integer.parseInt(request.getParameter("id"));
		response.setContentType("text/html;charset=utf-8");
		List<TBaseArea> province = actionService.getCity(id);
		JSONArray _json_pro = JSONArray.fromObject(province);
		response.getWriter().print(_json_pro.toString());
		response.getWriter().close();
		return;
	}
	
	
	//废弃了
	public void getScore() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		
		int id = Integer.parseInt(request.getParameter("id"));
		int isOrg = (request.getParameter("isOrg")==null)?0:Integer.parseInt(request.getParameter("isOrg"));
		List<TAppBusinessEvaluate> scoresList = userService.getScore(id,isOrg);
		
		Map<String,String> result = new HashMap<String,String>();
		if(!CollectionUtils.isEmpty(scoresList)){
			int totalRemarksTimes = scoresList.size();
			int goodRemarksTimes = 0;
			int totalMsRemarks = 0;
			int totalTdRemarks = 0;
			int totalZlRemarks = 0;
			
			int i = 0;
			int j = 0;
			int k = 0;
			
			for (TAppBusinessEvaluate tAppBusinessEvaluate : scoresList) {
				if(NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getPjGrade(),StringUtils.EMPTY),0)==1){
					goodRemarksTimes++;
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getMsGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getMsGrade()) > 0){
						i++;
					}
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getTdGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getTdGrade()) > 0){
						j++;
					}
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getZlGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getZlGrade()) > 0){
						k++;
					}
				}
				totalMsRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getMsGrade(),StringUtils.EMPTY),0);
				totalTdRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getTdGrade(),StringUtils.EMPTY),0);
				totalZlRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getZlGrade(),StringUtils.EMPTY),0);
			}
			//好评率：
			long goodRate = Math.round(goodRemarksTimes*100.0/totalRemarksTimes*1.0);
			
			String totalMsRemarksStr = ((i>0) ? (new BigDecimal(totalMsRemarks*1.0/i*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");
			String totalTdRemarksStr = ((j>0) ? (new BigDecimal(totalTdRemarks*1.0/j*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");
			String totalZlRemarksStr = ((k>0) ? (new BigDecimal(totalZlRemarks*1.0/k*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");

			long totalMsRemarksRate = (i>0) ? Math.round(totalMsRemarks*1.0/i*1.0) : 0;
			long totalTdRemarksRate = (j>0) ? Math.round(totalTdRemarks*1.0/j*1.0) : 0;
			long totalZlRemarksRate = (k>0) ? Math.round(totalZlRemarks*1.0/k*1.0) : 0 ;
			
			request.setAttribute("goodRate",Long.toString(goodRate)+"%");
			
			request.setAttribute("totalMsRemarksRate",Long.toString(totalMsRemarksRate));
			request.setAttribute("totalTdRemarksRate",Long.toString(totalTdRemarksRate));
			request.setAttribute("totalZlRemarksRate",Long.toString(totalZlRemarksRate));
			
			request.setAttribute("totalMsRemarksStr",totalMsRemarksStr);
			request.setAttribute("totalTdRemarksStr",totalTdRemarksStr);
			request.setAttribute("totalZlRemarksStr",totalZlRemarksStr);
		}

		String resultStr = new Gson().toJson(result);// list为要转换为JSON对象的数据
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}
	
	
	/**
	 * 
	 * @Description: 用户详细信息列表（根据id）
	 * @author hyl   
	 * @date 2013-3-15 下午4:57:52
	 * @return
	 */
	public String execute() throws Exception { 
		// TODO Auto-generated method stub
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		int id = Integer.parseInt(request.getParameter("id"));
		int photoFlag = request.getParameter("photoFlag")==null?0:Integer.parseInt(request.getParameter("photoFlag"));
		//根据id查找用户信息
		TAppUser user = userService.findUserByUserId(id);

		TAppUserInfo userInfo = userInfoService.findUserInfoByUserId(id);

		DecimalFormat df=new DecimalFormat(".#");
		
		//TAppUserEvaluation userEvaluation = userEvaluationService.getUserEvaluationById(id);
		//if(userEvaluation!=null){
			//userEvaluation.setMsGradeValue(Double.parseDouble(df.format(userEvaluation.getMsGradeValue())));
			//userEvaluation.setTdGradeValue(Double.parseDouble(df.format(userEvaluation.getTdGradeValue())));
			//userEvaluation.setZlGradeValue(Double.parseDouble(df.format(userEvaluation.getZlGradeValue())));
			
		int isOrg = 0;
		List<TAppBusinessEvaluate> scoresList = userService.getScore(id,isOrg);
		
		if(CollectionUtils.isEmpty(scoresList)){
			request.setAttribute("goodRate","尚未完成交易");//""+userInfo.getFeedbackRate()
			
			request.setAttribute("totalMsRemarksStr","尚未完成交易");
			request.setAttribute("totalTdRemarksStr","尚未完成交易");
			request.setAttribute("totalZlRemarksStr","尚未完成交易");
		}else{
			int totalRemarksTimes = scoresList.size();
			int goodRemarksTimes = 0;
			int totalMsRemarks = 0;
			int totalTdRemarks = 0;
			int totalZlRemarks = 0;
			
			int i = 0;
			int j = 0;
			int k = 0;
			
			for (TAppBusinessEvaluate tAppBusinessEvaluate : scoresList) {
				if(NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getPjGrade(),StringUtils.EMPTY),0)==1){
					goodRemarksTimes++;
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getMsGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getMsGrade()) > 0){
						i++;
					}
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getTdGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getTdGrade()) > 0){
						j++;
					}
				}
				if(NumberUtils.isNumber(tAppBusinessEvaluate.getZlGrade())){
					if(NumberUtils.createInteger(tAppBusinessEvaluate.getZlGrade()) > 0){
						k++;
					}
				}
				totalMsRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getMsGrade(),StringUtils.EMPTY),0);
				totalTdRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getTdGrade(),StringUtils.EMPTY),0);
				totalZlRemarks += NumberUtils.stringToInt(StringUtils.defaultIfEmpty(tAppBusinessEvaluate.getZlGrade(),StringUtils.EMPTY),0);
			}
			//好评率：
			long goodRate = Math.round(goodRemarksTimes*100.0/totalRemarksTimes*1.0);
			
			String totalMsRemarksStr = ((i>0) ? (new BigDecimal(totalMsRemarks*1.0/i*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");
			String totalTdRemarksStr = ((j>0) ? (new BigDecimal(totalTdRemarks*1.0/j*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");
			String totalZlRemarksStr = ((k>0) ? (new BigDecimal(totalZlRemarks*1.0/k*1.0).setScale(1,BigDecimal.ROUND_HALF_UP).toString()) : "");

			long totalMsRemarksRate = (i>0) ? Math.round(totalMsRemarks*1.0/i*1.0) : 0;
			long totalTdRemarksRate = (j>0) ? Math.round(totalTdRemarks*1.0/j*1.0) : 0;
			long totalZlRemarksRate = (k>0) ? Math.round(totalZlRemarks*1.0/k*1.0) : 0 ;
			
			request.setAttribute("goodRate",Long.toString(goodRate)+"%");
			
			request.setAttribute("totalMsRemarksRate",Long.toString(totalMsRemarksRate));
			request.setAttribute("totalTdRemarksRate",Long.toString(totalTdRemarksRate));
			request.setAttribute("totalZlRemarksRate",Long.toString(totalZlRemarksRate));
			
			request.setAttribute("totalMsRemarksStr",totalMsRemarksStr);
			request.setAttribute("totalTdRemarksStr",totalTdRemarksStr);
			request.setAttribute("totalZlRemarksStr",totalZlRemarksStr);
		}
			
		//}
		
		//获取成长信息的列表
		List listGrow = growthService.getGrowthList(id, 0, 6);

		UserSession userSession = HttpSessionHelper.getUserSession(request);


		//修改点击数+1
		if(userInfo.getPopularityTotal()!=null&&!"".equals(userInfo.getPopularityTotal())){
			userInfo.setPopularityTotal(userInfo.getPopularityTotal()+1);
		}else{
			userInfo.setPopularityTotal(1);
		}
		
		int dingCount = friendInfoService.getDingTotal(0, id,1);
		userInfoService.saveUserInfo(userInfo);

		request.setAttribute("user", user);
		if (!"保密".equals(userInfo.getSignAmount())) {
			
			if(userInfo.getSignAmount()==null){
				logger.info("..........userInfo.getSignAmount()==null");
				request.setAttribute("dingCount", dingCount);	
			}else{
				logger.info("..........userInfo.getSignAmount()"+userInfo.getSignAmount());
				if(StringUtils.isNumeric(userInfo.getSignAmount())){
					request.setAttribute("dingCount", dingCount+Integer.parseInt(userInfo.getSignAmount()));
				}else{
					request.setAttribute("dingCount", dingCount);
				}
			}
		}else {
			request.setAttribute("dingCount", dingCount);
		}
		//签约次数，交易数
		userInfo.setSignNumber(businessInfoService.getMyBusinessInfoTotal(id,3));
		request.setAttribute("userInfo", userInfo);

		//request.setAttribute("userEvaluation",userEvaluation);
		List costList=costService.getTop3CastByUserID(id);

		request.setAttribute("costList",costList);
		request.setAttribute("id", id);
		if(userSession==null){ 
			request.setAttribute("userId", 0);
		}else {
			request.setAttribute("userId", userSession.getId());
		}
		
		String actionName = request.getParameter("actionName");
		
		if(user.getIsOrg() != 1){
			request.setAttribute("listGrow", listGrow);
			
			if (user.getParentID()!=null&&user.getParentID()!=0&&user.getParentID()!=user.getId()) {
				request.setAttribute("qyUserInfo",1);
				TAppUserInfo userInfo1 = userInfoService.findUserInfoByUserId(user.getParentID());
				TAppUser user1 = userService.findUserByUserId(user.getParentID());
				request.setAttribute("qyUInfo", userInfo1);
				request.setAttribute("qyUser", user1);
				request.setAttribute("nowId", user.getParentID());
			}else {
				request.setAttribute("qyUserInfo",0);
				request.setAttribute("nowId", id);
			}
			
			int friendGZTotal = friendInfoService.getTotalFriends(id, 1); //关注
			int friendFSTotal = friendInfoService.getTotalFriends(id, 2); //粉丝
			
			request.setAttribute("friendGZTotal", friendGZTotal);
			request.setAttribute("friendFSTotal", friendFSTotal);
			
			//找到前一个和后一个 userId
			//先找出当前用户类别下的其他艺人，
			
			Integer professionId = 0;
			if(actionName==null){
				if(userInfo!=null){
					professionId = userService.findProfession(id);
					if(professionId!=null){
						request.getSession().setAttribute("professionId",professionId);
					}
				}
			}
			Integer newProfessionId = (Integer)request.getSession().getAttribute("professionId");
			if(newProfessionId!=null){
				TAppUser preUser = userService.findPrePostUserId(id,newProfessionId,1);
				TAppUser postUser = userService.findPrePostUserId(id,newProfessionId,-1);
				if(preUser !=null){
					request.setAttribute("preUserId", preUser.getId());	
				}
				if(postUser !=null){
					request.setAttribute("postUserId", postUser.getId());	
				}
			}
			
			//List artInfoList=artInfoService.getMyZuoPinList(id, 1); //相册列表
			//request.setAttribute("artInfoList", artInfoList);	
		}else{
			if (photoFlag==1) {
				int pic =Integer.parseInt(request.getParameter("pic"));
				List<TAppImagesInfo> images = artInfoService.getAppImagesInfos(pic,0,9999);
				request.setAttribute("images", images);
				request.setAttribute("image", 1);
			}else {
				request.setAttribute("image", 0);
			}
			
			int growTatols = growthService.getTotal(id, 6);
			//获取相册-视频-音频的个数
			int img = artInfoService.getTotalsArt(id, "1");
			int movie = artInfoService.getTotalsArt(id, "2");
			int voice = artInfoService.getTotalsArt(id, "3");
			
			//评论
			int pageNumP = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
			List businessEvaluateList=businessEvaluateSerive.getMyBusinessEvaluate(id, (pageNumP-1)*5, 5, 2);
			int totalP = businessEvaluateSerive.getTotal(id, 5, 2);
			pageNumP=pageNumP>totalP?totalP:pageNumP;

			request.setAttribute("businessEvaluateList", businessEvaluateList);
			request.setAttribute("pageNumP", pageNumP);
			request.setAttribute("totalP", totalP);
			
			request.setAttribute("growTatols", growTatols);
			request.setAttribute("img", img);
			request.setAttribute("movie", movie);
			request.setAttribute("voice", voice);
			
			if(userSession != null){
				int userId = userSession.getId();
				TAppFriendInfo  friendInfo = friendInfo  = friendInfoService.getFriendInfo(userId, id);;
				request.setAttribute("friendInfo", friendInfo);
			}
		}
		
		
		if(StringUtils.isNotEmpty(actionName)){
			return actionName;
		}else{
			//1==机构 0个人 100观众
			if(user.getIsOrg() != 1){
				return "userBaseInfo";
			}else{
				//得到朋友的详细信息列表（分页）
				List<TAppFriendInfo> listFriend = friendInfoService.getFriendList(id,0,6,3);
				int friendTatols = friendInfoService.getTotal(id, 5, 3);
				request.setAttribute("listFriend", listFriend);
				request.setAttribute("friendTatols", friendTatols);
			}
		}
		return SUCCESS;
	}

	public String addEvaluate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int skillId =Integer.parseInt(request.getParameter("skillId"));
		//评论
		int pageNumP = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		List sList=businessEvaluateSerive.getSkillEvaluate(skillId, (pageNumP-1)*5, 5, 2);
		int totalP = businessEvaluateSerive.getSkillEvaluateTotal(skillId, 5, 2);
		pageNumP=pageNumP>totalP?totalP:pageNumP;

		request.setAttribute("sList", sList);
		request.setAttribute("pageNumP", pageNumP);
		request.setAttribute("totalP", totalP);
		request.setAttribute("skillId", skillId);
		return "addevaluate";
	}
	
	public String updateView(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		int flag = request.getParameter("flag")==null?0:Integer.parseInt(request.getParameter("flag"));
		request.setAttribute("id", id);
		request.setAttribute("flag", flag);
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		String swf = request.getParameter("swf")==null?"":request.getParameter("swf");
		List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, (pageNum-1)*rowCount, rowCount, flag);
		int total = artInfoService.getTotal(id, rowCount, flag);
		pageNum=pageNum>total?total:pageNum;
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("artInfoList", artInfoList);
		int artId = 0;
		String  artType = "0";
		if (flag==4) {
			if(artInfoList != null && !artInfoList.isEmpty()){
				request.setAttribute("vo", artInfoList.get(0));
			}
		}else if (flag==1) {
			List<TAppImagesInfo> lists = artInfoService.getAppImagesInfos(id,0,9999);
			request.setAttribute("lists", lists);
			request.setAttribute("xcId", id);
			request.setAttribute("userId", request.getParameter("userId"));
		}else if (flag==2||flag==3) {
			artInfo1=artInfoService.getArtInfoByID(id);
			//Map map = VideoUtil.getYoukuContent(artInfo1.getUrl());
			//artInfo1.setIntro((String)map.get("img"));
			//artInfo1.setAttachment((String)map.get("swf"));
			request.setAttribute("artInfo", artInfo1);
			artId = artInfo1.getUserId();
			artType = artInfo1.getType();
			
		}
		request.setAttribute("artId", artId);
		request.setAttribute("artType", artType);
		request.setAttribute("swf", swf);
		return "updateView";
	}
	
	public String doShowImg(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id"));
		int flag = request.getParameter("flag")==null?0:Integer.parseInt(request.getParameter("flag"));
		List<TAppImagesInfo> lists = artInfoService.getAppImagesInfos(id,0,9999);
		request.setAttribute("lists", lists);
		request.setAttribute("xcId", id);
		request.setAttribute("flag", flag);
		request.setAttribute("userId", request.getParameter("userId"));
		return "updateView";
	}
	
	/**
	 * 
	 * @Description: s:action 标签的访问方法，
	 * 获取用户信息 （上）
	 * @author hyl   
	 * @date 2013-3-15 下午4:57:52
	 * @return
	 */
	public String userViewTop(){
		HttpServletRequest request = ServletActionContext.getRequest();
		TAppUser user = userService.findUserByUserId(userIdParam);
		TAppUserInfo userInfo = userInfoService.findUserInfoByUserId(userIdParam);
		List costList=costService.getTop3CastByUserID(userIdParam);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("user", user);
		request.setAttribute("costList",costList);
		return "userViewTop";
	}
	
	/**
	 * 
	 * @Description: s:action 标签的访问方法，
	 * 获取用户信息 （左）
	 * @author hyl   
	 * @date 2013-3-15 下午4:57:52
	 * @return
	 * @throws ParseException 
	 */
	public String userViewLeft() throws ParseException{
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		TAppUser user = userService.findUserByUserId(userIdParam);
		System.out.println(userIdParam+"-------------00000000");
		List costList = costService.getTop3CastByUserID(userIdParam);
		request.setAttribute("costList", costList);
		TAppUserInfo userInfo = new TAppUserInfo();
		int id = Integer.parseInt(request.getParameter("id"));
		userInfo = userInfoService.findUserInfoByUserId(userIdParam);
		
		if (user.getParentID()!=null&&user.getParentID()!=0&&user.getParentID()!=user.getId()) {
			if(userSession != null) {
				TAppFriendInfo friend = friendInfoService.getFriendInfo(user.getParentID(), userSession.getId());
					if(friend == null) {
						request.setAttribute("friend", 1);//登陆用户不是要查看的用户的好友
					} else {
						request.setAttribute("friend", 2);//登陆用户是要查看的用户的好友
					}
				}
			TAppUserInfo userInfo1 = userInfoService.findUserInfoByUserId(user.getParentID());
			userInfo.setMobileRadio(userInfo1.getMobileRadio());
			userInfo.setQqRadio(userInfo1.getQqRadio());
			userInfo.setMobile(userInfo1.getMobile());
			userInfo.setQq(userInfo1.getQq());
		}else {
			if(userSession != null) {
				TAppFriendInfo friend = friendInfoService.getFriendInfo(userIdParam, userSession.getId());
					if(friend == null) {
						request.setAttribute("friend", 1);//登陆用户不是要查看的用户的好友
					} else {
						request.setAttribute("friend", 2);//登陆用户是要查看的用户的好友
					}
				}
		}
		if(userInfo.getBirthday() != null && !userInfo.getBirthday().equals("")) {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(df.parse(userInfo.getBirthday()));
			String constell = Constellation.date2Constellation(calendar);
			request.setAttribute("constellation", constell);
		}
		
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("user", user);
		
		
		return "userViewLeft";
	}
	
	/**
	 * 
	 * @Description: 获取相册1，视频2，音频3(根据用户id)
	 * 然后进行分页并返回相应的页面
	 * @author hyl   
	 * @date 2013-3-15 下午4:53:30
	 * @return
	 */
	public String userPhoto(){
		HttpServletRequest request = ServletActionContext.getRequest();
		//获取用户id
		int id = Integer.parseInt(request.getParameter("id"));
		//获取相册1，视频2，音频3 标志
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		//分页
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		if(sign == 2 || sign == 3 ){
			//如果是视频2，音频3 一页的行数为6
			rowCount =6 ;
		}
		//获取列表
		int total = artInfoService.getTotal(id, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;
		List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, (pageNum-1)*rowCount, rowCount, sign);
		//把相应信息保存到页面
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		//List<TAppArtInfo> img =artInfoService.getArtInfoList(id, 0, 4, 1);
		request.setAttribute("artInfoList", artInfoList);
		request.setAttribute("id", id);
		List<TAppArtInfo> list = new ArrayList<TAppArtInfo>();
		//根据sign的值不同返回不同的页面
		switch (sign) {
		case 1:
			return "userPhoto";
		case 2:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				//获取优酷的视频缩略图
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				tAppArtInfo.setIntro((String)map.get("img"));
				tAppArtInfo.setAttachment((String)map.get("swf"));
				list.add(tAppArtInfo);
			}
			//把相应信息保存到页面
			request.setAttribute("list", list);
			return "userMovie";
		case 3:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				//获取优酷的视频缩略图
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				tAppArtInfo.setIntro((String)map.get("img"));
				tAppArtInfo.setAttachment((String)map.get("swf"));
				list.add(tAppArtInfo);
			}
			//把相应信息保存到页面
			request.setAttribute("list", list);
			return "userVedio";
		}
		return "userPhoto";
		
	}
	

	//获取粉丝，关注列表
	public void getFriendList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		int sign = NumberUtils.stringToInt(request.getParameter("sign"), 1); //1:关注 2：粉丝 3：朋友
		int begin = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		List listFriendList = friendInfoService.getFriendList(id,begin,length,sign);
		
		//粉丝数统计一下
		if(listFriendList!=null){
			Iterator iterator = listFriendList.iterator();
			while(iterator.hasNext()){
				Object[] objs = (Object[])iterator.next();
				TAppUserInfo tAppUserInfo = (TAppUserInfo)objs[1];
				int friendTotal = friendInfoService.getTotalFriends(tAppUserInfo.getUserId(), 2);//2:粉丝
				tAppUserInfo.setTotalFriends(friendTotal);
			}
		}
		
		int friendTotal = friendInfoService.getTotalFriends(id, sign);
		
		 
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("friendTotal", Integer.toString(friendTotal));
		result.put("listFriendList", listFriendList);
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		result.put("sign", request.getParameter("sign"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	//获取评价，关注列表
	public void getEvaluateList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		//1:我给他人的评价（我是签约者和我是被签约者，都有我给出的评价） 2://他人给我的评价（我是签约者和我是被签约者，都有给我的评价）
		
		int sign = NumberUtils.stringToInt(request.getParameter("sign"), 1); 
		int starLevel = NumberUtils.stringToInt(request.getParameter("starLevel"), 1); 
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		List list = businessEvaluateSerive.getMyBusinessEvaluate(id, begin, length, sign,starLevel);
		
		//用户名要重新找
		if(sign==1){ //买家给我的
		Iterator iterator = list.iterator();
			while(iterator.hasNext()){
				Object[] objArr = (Object[])iterator.next();
				Integer seller = (Integer)objArr[7];
				Integer buyer = (Integer)objArr[8];
				Integer sellerCompany = (Integer)objArr[9];
				Integer targetUserId = 0;
				if((seller!=null && seller==id) || (sellerCompany!=null && sellerCompany==id)){
					targetUserId = buyer;
				}
				if(buyer!=null && buyer==id){
					if(seller!=null){
						targetUserId = seller;
					}else{
						targetUserId = sellerCompany;
					}
				}
				if(targetUserId!=null){
					TAppUserInfo userInfoByUserId = userInfoService.getUserInfoByUserId(targetUserId);
					if(userInfoByUserId!=null){
						objArr[2] = userInfoByUserId.getNickName();
					}
				}
				
			}
		}
		
		int total = businessEvaluateSerive.getMyBusinessEvaluateTotal(id,sign,starLevel);
		int goodTotal = businessEvaluateSerive.getMyBusinessEvaluateTotal(id,sign,1);
		int generalTotal = businessEvaluateSerive.getMyBusinessEvaluateTotal(id,sign,0);
		int badTotal = businessEvaluateSerive.getMyBusinessEvaluateTotal(id,sign,-1);
		
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		result.put("goodTotal", Integer.toString(goodTotal));
		result.put("generalTotal", Integer.toString(generalTotal));
		result.put("badTotal", Integer.toString(badTotal));
		result.put("list", list);
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		result.put("sign", request.getParameter("sign"));
		result.put("starLevel", request.getParameter("starLevel"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 *获取交易记录 //订单状态1、等待确认2、已确认等待付款3、已部分付款4、已付款5、演出已完成6、订单已完成
	 *7、退款申请中8、退款已完成9、订单已关闭10、第一舞台已把所有款项支付给卖家
	 */
	public void getRecordList() {
		int status = 3;
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		List list = businessInfoService.getMyBusinessInfo(id, begin, length,status);
		int total = businessInfoService.getMyBusinessInfoTotal(id,status);
		
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		result.put("list", list);
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 *获取 招聘信息
	 */
	public void getZhaopinList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		
		List<TAppInformation> infoList =informationService.getInformationList(id,begin,length);	
		int total = informationService.getInformationTotal(id);
		
	 
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		result.put("list", infoList);
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 *获取 项目信息
	 */
	public void getServiceProjectList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		
		//List<TAppGrowth> infoList = growthService.getGrowthList(id, begin, length);	
		//int total = growthService.getGrowthTotal(id);
		
		List<TAppCostInfo>  costList = costService.getCostListByUserId(id,begin,length);
		int total = costService.getCostListByUserIdTotal(id);
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		for (TAppCostInfo tAppCostInfo : costList) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("bulletinImg", tAppCostInfo.getBigImage());
			map.put("price", tAppCostInfo.getBprice());
			map.put("unit", tAppCostInfo.getUnit());
			map.put("detail", tAppCostInfo.getDetail());
			map.put("title", tAppCostInfo.getKeywords());
			map.put("id", tAppCostInfo.getId());
			
			resultList.add(map);
		}
		
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		result.put("list", resultList);
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 *获取 艺人信息
	 */
	public void getArtUserList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		String sex = request.getParameter("sex");
		String pro = request.getParameter("pro");
		String pri = request.getParameter("pri");
		
		int total = userService.getArtUserTotal(id,sex,pro,pri);
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		result.put("total", Integer.toString(total));

		if(total > 0){
			List list = userService.getArtUserList(id, sex,pro,pri,begin, length);	
			
			List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
			Iterator iterator = list.iterator();
			while(iterator.hasNext()){
				Object[] objArr = (Object[])iterator.next();
				TAppUser user = (TAppUser)objArr[0];
				TAppUserInfo userInfo = (TAppUserInfo)objArr[1];
				TAppCostInfo userCost = (TAppCostInfo)objArr[2];
				TAppTalentCategory userCategory = (TAppTalentCategory)objArr[3];
				
				Map<String,Object> userMap = new HashMap<String,Object>();
				userMap.put("id", user.getId());
				userMap.put("img", "/stageUpload/headImage/"+user.getId()+".png");
				userMap.put("nickName", userInfo.getNickName());
				
				if(StringUtils.isEmpty(userCost.getKeywords())){
					userMap.put("profession", userCategory.getTypeName());
				}else{
					if(userCost.getKeywords().length()>8){
						userMap.put("profession", userCost.getKeywords().substring(0,8));
					}else{
						userMap.put("profession", userCost.getKeywords());
					}
				}
				
				userMap.put("popularityTotal", userInfo.getPopularityTotal());
				
				resultList.add(userMap);
			}
			result.put("list", resultList);
		}else{
			result.put("list", new ArrayList<Map<String,Object>>());
		}
		
		String resultStr = new Gson().toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 *获取 艺人信息
	 */
	public void getFenLeiUserList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		int begin  = NumberUtils.stringToInt(request.getParameter("begin"), 0);
		int length = NumberUtils.stringToInt(request.getParameter("length"), 10);
		
		String sex = request.getParameter("sex");
		String pro = request.getParameter("pro");
		String pri = request.getParameter("pri");
		
		int total = userService.getArtUserTotal(id,sex,pro,pri);
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		result.put("total", Integer.toString(total));

		if(total > 0){
			List list = userService.getArtUserList(id, sex,pro,pri,begin, length);	
			
			List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
			Iterator iterator = list.iterator();
			while(iterator.hasNext()){
				Object[] objArr = (Object[])iterator.next();
				TAppUser user = (TAppUser)objArr[0];
				TAppUserInfo userInfo = (TAppUserInfo)objArr[1];
				TAppCostInfo userCost = (TAppCostInfo)objArr[2];
				TAppTalentCategory userCategory = (TAppTalentCategory)objArr[3];
				
				Map<String,Object> userMap = new HashMap<String,Object>();
				userMap.put("id", user.getId());
				userMap.put("img", "/stageUpload/headImage/"+user.getId()+".png");
				userMap.put("nickName", userInfo.getNickName());
				
				if(StringUtils.isEmpty(userCost.getKeywords())){
					userMap.put("profession", userCategory.getTypeName());
				}else{
					if(userCost.getKeywords().length()>8){
						userMap.put("profession", userCost.getKeywords().substring(0,8));
					}else{
						userMap.put("profession", userCost.getKeywords());
					}
				}
				
				userMap.put("popularityTotal", userInfo.getPopularityTotal());
				
				resultList.add(userMap);
			}
			result.put("list", resultList);
		}else{
			result.put("list", new ArrayList<Map<String,Object>>());
		}
		
		String resultStr = new Gson().toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 相册，视频，音频等
	 */
	public void getZuoPinList() {
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int type = Integer.parseInt(request.getParameter("type"));
		
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		
		List artInfoList=artInfoService.getMyZuoPinList(id, type);
		List list = new ArrayList();
		
		//默认第一相册的图片
		int artId = 0;
		if(artInfoList!=null && artInfoList.size()>0){
			for(int i=0; i<artInfoList.size(); i++){
				Object[] tAppArtInfoArr = (Object[])artInfoList.get(i);
				if(type==2){
					if(tAppArtInfoArr[2] != null){
						Map map = VideoUtil.getYoukuContent((String)tAppArtInfoArr[2]);
						
						TAppArtInfo tAppArtInfo = new TAppArtInfo();
						tAppArtInfo.setId((Integer)tAppArtInfoArr[0]);
						tAppArtInfo.setTitle((String)tAppArtInfoArr[1]);
						String img = MapUtils.getString(map, "img","");
						String swf = MapUtils.getString(map, "swf","");
						
						tAppArtInfo.setImg(img);
						tAppArtInfo.setUrl(swf);
						list.add(tAppArtInfo);
						if(i==0){
							result.put("tAppArtInfo", tAppArtInfo);
						}
					}
				}else if(type==1){
					list.add(tAppArtInfoArr);
					if(i==0){
						Object[] artIdArr = (Object[])artInfoList.get(i);
						artId = (Integer)artIdArr[0];		
						List<TAppImagesInfo> imgList = artInfoService.getAppImagesInfos(artId,0,9999);
						result.put("imgList", imgList);
					}
				}
			}
		}

	 
		
		Gson gson = new Gson();
		result.put("artInfoList", list);
		
		result.put("actionName", request.getParameter("actionName"));
		result.put("type", request.getParameter("type"));
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 相册下的相片
	 */
	public void getMovie() {
		HttpServletRequest request = ServletActionContext.getRequest();
		//默认是登录的用户
		int artId = NumberUtils.stringToInt(request.getParameter("artId"), 0);
		
		//指定相册的图片
		TAppArtInfo tAppArtInfo = artInfoService.getArtInfoByID(artId);
		
		//获取优酷的视频缩略图
		Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
		tAppArtInfo.setImg((String)map.get("img"));
		tAppArtInfo.setUrl((String)map.get("swf"));
		
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("tAppArtInfo", tAppArtInfo);
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 相册下的相片
	 */
	public void getImgList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		int artId = NumberUtils.stringToInt(request.getParameter("artId"), 0);
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(userSession != null){
				id = userSession.getId();
			}
		}
		
		//指定相册的图片
		List<TAppImagesInfo> imgList = artInfoService.getAppImagesInfos(artId,0,9999);

		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("imgList", imgList);
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @Description: 获取相册的图片列表（根据相册id）
	 * @author hyl   
	 * @date 2013-3-15 下午4:52:38
	 * @return
	 */
	public String imageView(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int pic =Integer.parseInt(request.getParameter("pic"));
		int id = Integer.parseInt(request.getParameter("id"));
		List<TAppImagesInfo> images = artInfoService.getAppImagesInfos(pic,0,9999);
		request.setAttribute("images", images);
		request.setAttribute("id", id);
		return "imageView";
	}
	public void addShare(){//卖家评论买家
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		HttpServletRequest request=ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id"));
		TAppArtInfo artInfo = artInfoService.getArtInfoByID(id);
		artInfo.setShare(artInfo.getShare()+1);
		artInfoService.saveOrUpdateArtInfo(artInfo);		

		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
