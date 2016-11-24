package com.smt.webapp.weih5;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import jxl.common.Logger;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppBusinessCost;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppFriendInfo;
import com.smt.entity.TAppImagesInfo;
import com.smt.entity.TAppPersonTask;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppTaskRole;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;
import com.smt.webapp.service.friend.FriendInfoService;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.service.weih5.H5NotificationService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.weih5.utils.H5CommonHelper;
import com.smt.webapp.weih5.utils.H5DateHelper;
import com.smt.webapp.weih5.utils.H5FileHelper;
import com.smt.webapp.weih5.utils.H5ParamTranslater;
import com.smt.webapp.weih5.utils.H5SessionHelper;
import com.smt.webapp.weih5.utils.H5ValidationHelper;
import com.smt.webapp.weih5.vo.H5ApplyArtistVo;
import com.smt.webapp.weih5.vo.H5ArtistBriefInfoVo;
import com.smt.webapp.weih5.vo.H5InviteInListVo;
import com.smt.webapp.weih5.vo.H5TaskInListVo;
import com.smt.webapp.weih5.vo.H5TaskRoleInListVo;

import edu.emory.mathcs.backport.java.util.Collections;

public class H5ArtistAction extends H5BaseAction {

	private Logger logger = Logger.getLogger(H5TaskAction.class);

	//@Autowired
	//private WxMpService wxMpService;
	@Autowired
	private H5NotificationService h5notificationService;

	@Autowired
	private TaskService taskService;
	@Autowired
	private UserInfoService uService;
	@Autowired
	private UserService userService;
	@Autowired
	private CostService costService;
	@Autowired
	private ArtInfoService artInfoService;
	@Autowired
	private BusinessEvaluateService businessEvaluateSerive;
	@Autowired
	private FriendInfoService friendInfoService;
	@Autowired
	private BusinessInfoService businessInfoService;

	public String artistDetail() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		/**
		 * GET THIS USER & USERINFO
		 */
		String userIdStr = request.getParameter("userId");
		if (StringUtils.isBlank(userIdStr) || !StringUtils.isNumeric(userIdStr)) {
			return ERROR;
		}
		int userId = Integer.valueOf(userIdStr);
		TAppUserInfo userInfo = uService.findUserInfoByUserId(userId);
		TAppUser user = userService.findUserByUserId(userId);
		if (userInfo == null || user == null) {
			return ERROR;
		}

		boolean showContact = false;

		int currentUserId = H5SessionHelper.currentUserId(request);
		boolean isCurrentUser = (userId == currentUserId);
		if (isCurrentUser) {
			request.setAttribute("isCurrentUser", "true");
			showContact = true;
		} else {
			// check relationship & set showContact
			boolean bizCheck = businessInfoService.checkRelations(currentUserId, userId);
			boolean taskCheck = taskService.checkRelations(currentUserId, userId);

			System.out.println("bizCheck: " + bizCheck);
			System.out.println("taskCheck: " + taskCheck);

			if (bizCheck || taskCheck) {
				showContact = true;
			}
		}
		if (!showContact) {
			userInfo.setMobile("被邀请/应征 后可查看");
			user.setEmail("被邀请/应征 后可查看");
		}

		boolean isBroArtist = false;

		if (user.getIsOrg() == 100) {
			// SET UP FOR USER

		} else if (user.getIsOrg() == 1) {
			// SET UP FOR BIZ
			List<TAppUserInfo> artistList = (List<TAppUserInfo>) userService.findUserInfoListByParentId(userId);
			if (!CollectionUtils.isEmpty(artistList)) {
				List<H5ArtistBriefInfoVo> artists = new ArrayList<H5ArtistBriefInfoVo>();

				for (TAppUserInfo taUserInfo : artistList) {
					H5ArtistBriefInfoVo briefInfoVo = new H5ArtistBriefInfoVo();
					briefInfoVo.setUserId(taUserInfo.getUserId());
					briefInfoVo.setNickName(taUserInfo.getNickName());
					briefInfoVo.setTags(StringUtils.isBlank(taUserInfo.getProfessionStr()) ? "" : taUserInfo.getProfessionStr().replace(",", " "));

					artists.add(briefInfoVo);
				}

				request.setAttribute("artistList", artists);
			}
		} else if (user.getIsOrg() == 2) {
			// SET UP FOR BRO
			List<TAppUserInfo> artistList = (List<TAppUserInfo>) userService.findUserInfoListByParentId(userId);
			if (!CollectionUtils.isEmpty(artistList)) {
				List<H5ArtistBriefInfoVo> artists = new ArrayList<H5ArtistBriefInfoVo>();

				for (TAppUserInfo taUserInfo : artistList) {
					H5ArtistBriefInfoVo briefInfoVo = new H5ArtistBriefInfoVo();
					briefInfoVo.setUserId(taUserInfo.getUserId());
					briefInfoVo.setNickName(taUserInfo.getNickName());
					briefInfoVo.setTags(StringUtils.isBlank(taUserInfo.getProfessionStr()) ? "" : taUserInfo.getProfessionStr().replace(",", " "));

					artists.add(briefInfoVo);
				}

				request.setAttribute("artistList", artists);
			}
		} else {
			// SET UP FOR ARTIST
			int parentId = user.getParentID() != null ? user.getParentID() : 0;
			if (parentId != 0 && parentId != user.getId()) {
				// artist of org
				TAppUser org = userService.findUserById(parentId);
				if (org == null) {
					request.setAttribute("qyUserInfo", 0);
				} else if (org.getIsOrg() == 1) {
					request.setAttribute("qyUserInfo", 1);
					if (org.getId() == currentUserId) { // tag for edit and
														// upload
						request.setAttribute("isCurrentOrgsArt", "true");
					}
				} else if (org.getIsOrg() == 2) {
					isBroArtist = true;
					request.setAttribute("qyUserInfo", 2);
					if (org.getId() == currentUserId) {// tag for edit and
														// upload
						request.setAttribute("isCurrentOrgsArt", "true");
					}
				}

				TAppUserInfo orgInfo = uService.findUserInfoByUserId(user.getParentID());

				if (!showContact) {
					orgInfo.setMobile("被邀请/应征 后可查看");
					org.setEmail("被邀请/应征 后可查看");
				}

				request.setAttribute("qyUInfo", orgInfo);
				request.setAttribute("qyUser", org);
				request.setAttribute("nowId", user.getParentID());
			} else {
				// artist of self
				request.setAttribute("qyUserInfo", 0);
				request.setAttribute("nowId", userId);
			}

			// skill-list of artist
			List<TAppCostInfo> costList = costService.getCostListByUserId(userId);
			request.setAttribute("costList", costList);
			request.setAttribute("costListCount", costList == null ? 0 : costList.size());
			List<TAppArtInfo> artInfoList = artInfoService.getArtInfoList(userId, 0, 2, 1);
			request.setAttribute("artInfoList", artInfoList);
			request.setAttribute("artDisplayCount", artInfoList == null ? 0 : artInfoList.size());

			// 获取相册-视频-音频的个数
			int imgCount = artInfoService.getTotalsArt(userId, "1");
			int movieCount = artInfoService.getTotalsArt(userId, "2");
			request.setAttribute("productCount", imgCount + movieCount);

			// review
			int totalP = businessEvaluateSerive.getTotal(userId, 5, 2);
			request.setAttribute("totalP", totalP);
			List businessEvaluateList = businessEvaluateSerive.getMyBusinessEvaluate(userId, 0, 5, 2);
			request.setAttribute("businessEvaluateList", businessEvaluateList);
			request.setAttribute("reviewCount", businessEvaluateList == null ? 0 : businessEvaluateList.size());
		}

		int friendFSTotal = friendInfoService.getTotalFriends(userId, 2); // 粉丝
		// int friendGZTotal = friendInfoService.getTotalFriends(userId, 1); //
		// 关注
		request.setAttribute("friendFSTotal", friendFSTotal);// fans

		if (!isCurrentUser) {
			boolean isFollowing = friendInfoService.isFollowingUser(userId, H5SessionHelper.currentUserId(request));
			// boolean isFollowing = friendInfoService.isFollowingUser(userId,
			// 132);//example
			request.setAttribute("isFollowing", isFollowing);
		}

		request.setAttribute("userInfo", userInfo);
		request.setAttribute("user", user);

		if (user.getIsOrg() == 100) {
			return "userDetail";
		} else if (user.getIsOrg() == 1) {
			return "bizDetail";
		} else if (user.getIsOrg() == 2) {
			return "broDetail";
		} else if (isBroArtist) {
			return "broArtistDetail";
		} else {
			return SUCCESS;
		}
	}

	public String artistProducts() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			// responseAjax(ERROR, "没有登录");
			return H5LOGIN;
		}

		String userIdStr = request.getParameter("userId");
		if (StringUtils.isBlank(userIdStr) || !StringUtils.isNumeric(userIdStr)) {
			return ERROR;
		}

		int userId = Integer.valueOf(userIdStr);

		List<TAppImagesInfo> artImageList = new ArrayList<TAppImagesInfo>();
		List<TAppArtInfo> artAlbumList = artInfoService.getArtInfoList(userId, 0, 10, 1);
		for (TAppArtInfo artInfo : artAlbumList) {
			List<TAppImagesInfo> imageList = artInfoService.getAppImagesInfos(artInfo.getId(), 0, 30);
			artImageList.addAll(imageList);
		}

		// List<TAppArtInfo> artImageList =
		// artInfoService.getArtInfoList(userId, 0, 10, 1);
		List<TAppArtInfo> artVideoList = artInfoService.getArtInfoList(userId, 0, 10, 2);

		request.setAttribute("tag", "image");// image: show image page; video:
												// show the video list page;
		request.setAttribute("userId", userIdStr);
		request.setAttribute("artImageList", artImageList);
		request.setAttribute("artVideoList", artVideoList);

		int currentUserId = H5SessionHelper.currentUserId(request);
		if (currentUserId == userId) {
			request.setAttribute("isCurrentUser", "true");
		} else {
			try {
				TAppUser artistUser = userService.findUserById(userId);
				if (artistUser != null) {
					if (currentUserId == (artistUser.getParentID() == null ? 0 : artistUser.getParentID())) {
						request.setAttribute("isCurrentOrg", "true");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return SUCCESS;
	}

	@Deprecated
	public String artistImageGategory() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			// responseAjax(ERROR, "没有登录");
			return H5LOGIN;
		}

		String userIdStr = request.getParameter("userId");
		if (StringUtils.isBlank(userIdStr) || !StringUtils.isNumeric(userIdStr)) {
			return ERROR;
		}

		int userId = Integer.valueOf(userIdStr);
		List<TAppArtInfo> artInfoList = artInfoService.getArtInfoList(userId, 0, 10, 1);

		request.setAttribute("userId", userIdStr);
		request.setAttribute("artInfoList", artInfoList);

		return SUCCESS;
	}

	@Deprecated
	public String artistVideoGategory() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			// responseAjax(ERROR, "没有登录");
			return H5LOGIN;
		}

		String userIdStr = request.getParameter("userId");
		if (StringUtils.isBlank(userIdStr) || !StringUtils.isNumeric(userIdStr)) {
			return ERROR;
		}

		int userId = Integer.valueOf(userIdStr);
		List<TAppArtInfo> artInfoList = artInfoService.getArtInfoList(userId, 0, 10, 2);

		request.setAttribute("userId", userIdStr);
		request.setAttribute("artInfoList", artInfoList);

		if (!org.springframework.util.CollectionUtils.isEmpty(artInfoList)) {
			for (TAppArtInfo tappAppArtInfo : artInfoList) {
				logger.info("img: " + tappAppArtInfo.getImg());
				logger.info("att: " + tappAppArtInfo.getAttachment());
				logger.info("time: " + tappAppArtInfo.getCreatTime());
				logger.info("intro: " + tappAppArtInfo.getIntro());
				logger.info("type: " + tappAppArtInfo.getType());
				logger.info("url: " + tappAppArtInfo.getUrl());
				logger.info("ding: " + tappAppArtInfo.getDing());
				logger.info("eva: " + tappAppArtInfo.getEvaluate());
				logger.info("share: " + tappAppArtInfo.getShare());
				logger.info("count: " + tappAppArtInfo.getImgCount());
			}
		} else {
			logger.info("empty video");
		}

		return SUCCESS;
	}

	public String artistReviewList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			// responseAjax(ERROR, "没有登录");
			return H5LOGIN;
		}

		String userIdStr = request.getParameter("userId");
		if (StringUtils.isBlank(userIdStr) || !StringUtils.isNumeric(userIdStr)) {
			return ERROR;
		}

		int userId = Integer.valueOf(userIdStr);

		List reviewList = businessEvaluateSerive.getMyBusinessEvaluate(userId, 0, 10, 2);
		request.setAttribute("reviewList", reviewList);

		return SUCCESS;
	}

	public void deleteArtistProductVideo() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String artIdStr = request.getParameter("artId");
		String artistIdStr = request.getParameter("artistId");

		if (!StringUtils.isNumeric(artIdStr) || !StringUtils.isNumeric(artistIdStr)) {
			responseAjax(ERROR, "参数错误，无法获得要删除的作品。");
			return;
		}

		int artId = Integer.valueOf(artIdStr);
		int artistId = Integer.valueOf(artistIdStr);

		// validation
		int currentUserId = H5SessionHelper.currentUserId(request);
		if (currentUserId != artistId) {
			TAppUser artist = userService.findUserById(artistId);
			if (artist == null) {
				responseAjax(ERROR, "参数错误，无法获得艺人信息");
				return;
			}
			if (artist.getParentID() != currentUserId) {
				responseAjax(ERROR, "权限错误，您无权删除此艺人的作品");
				return;
			}
		}

		// delete
		TAppArtInfo artInfo = artInfoService.getArtInfoByID(artId);
		artInfoService.delArtInfo(artInfo);
		responseAjax(SUCCESS, "");
	}

	public void deleteArtistProduct() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String artIdStr = request.getParameter("artId");
		String artistIdStr = request.getParameter("artistId");

		if (!StringUtils.isNumeric(artIdStr) || !StringUtils.isNumeric(artistIdStr)) {
			responseAjax(ERROR, "参数错误，无法获得要删除的作品。");
			return;
		}

		int artId = Integer.valueOf(artIdStr);
		int artistId = Integer.valueOf(artistIdStr);

		// validation
		int currentUserId = H5SessionHelper.currentUserId(request);
		if (currentUserId != artistId) {
			TAppUser artist = userService.findUserById(artistId);
			if (artist == null) {
				responseAjax(ERROR, "参数错误，无法获得艺人信息");
				return;
			}
			if (artist.getParentID() != currentUserId) {
				responseAjax(ERROR, "权限错误，您无权删除此艺人的作品");
				return;
			}
		}

		// delete
		artInfoService.delImgInfo(artId);
		responseAjax(SUCCESS, "");
	}

	public void followArt() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}
		int currentUserId = H5SessionHelper.currentUserId(request);

		String artistIdStr = request.getParameter("artistId");
		if (StringUtils.isBlank(artistIdStr) || !StringUtils.isNumeric(artistIdStr)) {
			responseAjax(ERROR, "参数错误，无法获得关注人ID");
			return;
		}
		int artistId = Integer.valueOf(artistIdStr);

		TAppFriendInfo friendInfo = new TAppFriendInfo();
		friendInfo.setUserId(currentUserId);
		friendInfo.setFriendId(artistId);
		friendInfo.setCreatTime(CommonUtil.getTime(new Date()));
		friendInfoService.addFriendInfo(friendInfo);
		responseAjax(SUCCESS, "");
		return;
	}

	public void unfollowArt() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}
		int currentUserId = H5SessionHelper.currentUserId(request);

		String artistIdStr = request.getParameter("artistId");
		if (StringUtils.isBlank(artistIdStr) || !StringUtils.isNumeric(artistIdStr)) {
			responseAjax(ERROR, "参数错误，无法获得关注人ID");
			return;
		}
		int artistId = Integer.valueOf(artistIdStr);

		TAppFriendInfo item = friendInfoService.getFriendInfo(currentUserId, artistId);
		friendInfoService.delFriendInfo(item);

		responseAjax(SUCCESS, "");
		return;
	}

	public void doInvite() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}
		int currentUserId = H5SessionHelper.currentUserId(request);

		String artistIdStr = request.getParameter("artistId");
		String costIdStr = request.getParameter("costId");

		if (StringUtils.isBlank(artistIdStr) || StringUtils.isBlank(costIdStr)) {
			responseAjax(ERROR, "参数错误，无发获得此艺人信息。");
			return;
		}

		if (!StringUtils.isNumeric(artistIdStr) || !StringUtils.isNumeric(costIdStr)) {
			responseAjax(ERROR, "参数错误，艺人信息格式不正确。");
			return;
		}
		int artistId = Integer.valueOf(artistIdStr);
		int costId = Integer.valueOf(costIdStr);

		String roles = request.getParameter("roles");
		JSONArray array = JSONArray.parseArray(roles);

		List<Integer> roleIds = new ArrayList<Integer>();
		for (int index = 0; index < array.size(); index++) {
			String roleStr = array.getString(index);
			if (StringUtils.isNotEmpty(roleStr) && StringUtils.isNumeric(roleStr)) {
				roleIds.add(Integer.valueOf(roleStr));
			}
		}

		if (CollectionUtils.isEmpty(roleIds)) {
			responseAjax(ERROR, "参数错误。未获得邀请角色。");
			return;
		}

		// taskId - roles
		Map<Integer, List<TAppTaskRole>> roleMap = new HashMap<Integer, List<TAppTaskRole>>();
		for (Integer in : roleIds) {
			TAppTaskRole taskRole = taskService.findTaskRoleById(in);
			int taskId = taskRole.getTAppTask().getId();

			if (!roleMap.containsKey(taskId)) {
				roleMap.put(taskId, new ArrayList<TAppTaskRole>());
			}
			roleMap.get(taskId).add(taskRole);
		}

		for (Integer key : roleMap.keySet()) {
			// task -> business info
			TAppTask task = taskService.findTaskById(key);
			if (task == null) {
				continue;
			}
			orderSubmit(task, roleMap.get(key), currentUserId, artistId, costId);

			TAppUser artistUser = userService.findUserById(artistId);
			TAppUserInfo curUserInfo = uService.findUserInfoByUserId(currentUserId);
			StringBuilder roleBuilder = new StringBuilder();
			List<TAppTaskRole> taskRoles = roleMap.get(key);
			for (int index = 0; index < taskRoles.size(); index++) {
				TAppTaskRole curRole = taskRoles.get(index);
				roleBuilder.append(curRole.getRoleName());
				if (index + 1 < taskRoles.size()) {
					roleBuilder.append(",");
				}
			}
			//String creatTime = task.getCreateDate().toString();
			h5notificationService.sendInviteNotification(currentUserId, curUserInfo.getNickName(), task.getTitle(), roleBuilder.toString(), artistUser.getOpenId(),task.getId());
			
//			int invitingUserId = currentUserId;
//			String invitingUserName = curUserInfo.getNickName();
//			String bizName = task.getTitle();
//			String roleName = roleBuilder.toString();
//			String invitedUserOpenId = artistUser.getOpenId();
			
		}

		responseAjax(SUCCESS, "");
		return;
	}

	/**
	 * copy from BusinessInfoAction:orderSubmit
	 */
	private synchronized void orderSubmit(TAppTask task, List<TAppTaskRole> roles, int currentUserId, int artistId, int artistCostId) {
		TAppBusinessInfo businessInfo = new TAppBusinessInfo();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String createDateTime = df.format(new Date());// new Date()为获取当前系统时间
		businessInfo.setBuyer(currentUserId);
		businessInfo.setCreateTime(new Date());
		businessInfo.setStatus(1); // 待接受
		businessInfo.setOrderCode(businessInfoService.getNewContractNo(createDateTime, 1)); // 订单编号
		businessInfo.setBuyerRate(1);
		businessInfo.setSellerRate(1);
		businessInfo.setReceipt(1);
		businessInfo.setUpdatePayTimeCount(0);
		businessInfo.setUpdatePayTimeStatus(0);

		businessInfo.setSeller(artistId);
		businessInfo.setSellerCompany(businessInfoService.getBqyUserOfOrgUserId(businessInfo.getSeller()));

		businessInfo.setPrice(task.getPrice());
		businessInfo.setProvice(task.getProvice());
		businessInfo.setCity(task.getCity());
		businessInfo.setAddress(task.getPlace());
		businessInfo.setContent(task.getContent());

		// yyyy-MM-dd HH:mm:ss
		String taskStart = task.getStartDate();
		String taskEnd = task.getEndDate();
		if (StringUtils.isNotBlank(taskStart)) {
			String[] taskStartArr = taskStart.split(" ");
			businessInfo.setBeginDate(taskStartArr[0]);
			if (taskStartArr.length > 1) {
				String[] startTimeArr = taskStartArr[1].split(":");
				if (startTimeArr != null && startTimeArr.length > 0) {
					businessInfo.setBeginTime(startTimeArr[0]);
				}
			}
		}

		if (StringUtils.isNotBlank(taskEnd)) {
			String[] taskEndArr = taskStart.split(" ");
			businessInfo.setEndDate(taskEndArr[0]);
			if (taskEndArr.length > 1) {
				String[] endTimeArr = taskEndArr[1].split(":");
				if (endTimeArr != null && endTimeArr.length > 0) {
					businessInfo.setEndTime(endTimeArr[0]);
				}
			}
		}

		businessInfo.setCreateTime(new Date());
		businessInfoService.addOrEditBusinessInfo(businessInfo);
		int businessInfoId = businessInfo.getId();

		int days = H5DateHelper.countDays(task.getStartDate(), task.getEndDate(), "yyyy-MM-dd HH:mm");

		for (TAppTaskRole role : roles) {
			TAppBusinessCost cost = new TAppBusinessCost();
			cost.setOrderId(businessInfoId);
			cost.setPrice(String.valueOf(role.getPriceLow()));
			if (StringUtils.isNotBlank(role.getRoleName())) {
				String[] roleNameArr = role.getRoleName().split(" ");
				String briefRole = roleNameArr[roleNameArr.length - 1];
				if (StringUtils.isNotBlank(briefRole)) {
					cost.setKeywords(briefRole.trim());
				} else {
					cost.setKeywords(role.getRoleName().trim());
				}
			}
			cost.setDays(days);
			cost.setCostId(artistCostId);
			businessInfoService.addOrEditBusinessCost(cost);
		}
	}

	public void checkRoleForInvite() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "needlogin");
			return;
		}

		String taskIdStr = request.getParameter("taskId");
		if (StringUtils.isBlank(taskIdStr) || !StringUtils.isNumeric(taskIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得当前任务ID");
			return;
		}
		int taskId = Integer.valueOf(taskIdStr);
		int currUserId = H5SessionHelper.currentUserId(request);
		int currIsOrg = H5SessionHelper.currentIsOrgFlag(request);

		if (currIsOrg == 1) {
			// for biz;
			// fetch artist list;
			List<TAppUserInfo> artistList = userService.findUserInfoListByParentId(currUserId);
			if (!CollectionUtils.isEmpty(artistList)) {

				// check the applied person for the task
				List<TAppPersonTask> taskPersons = taskService.getpersonTaskList(taskId);
				List<H5ApplyArtistVo> applyArtistVos = new LinkedList<H5ApplyArtistVo>();

				for (TAppUserInfo ui : artistList) {
					H5ApplyArtistVo vo = new H5ApplyArtistVo();
					vo.setId(ui.getUserId());
					vo.setName(ui.getNickName());

					for (TAppPersonTask personTask : taskPersons) {
						if (ui.getUserId().equals(personTask.getPersonId())) {
							vo.setApplied(true);
							break;
						}
					}
					applyArtistVos.add(vo);
				}

				responseAjax(SUCCESS, applyArtistVos);
				return;
			} else {
				responseAjax(ERROR, "暂无艺人，无法应征。快去添加艺人吧！");
				return;
			}

			// check if has applied;

		} else if (currIsOrg == 2) {
			// for bro: more than 5 artist, then could apply;
			List<TAppUserInfo> artistList = userService.findUserInfoListByParentId(currUserId);
			if ((!CollectionUtils.isEmpty(artistList)) && artistList.size() > 4) {

				// check the applied person for the task
				List<TAppPersonTask> taskPersons = taskService.getpersonTaskList(taskId);
				List<H5ApplyArtistVo> applyArtistVos = new LinkedList<H5ApplyArtistVo>();
				for (TAppUserInfo ui : artistList) {
					H5ApplyArtistVo vo = new H5ApplyArtistVo();
					vo.setId(ui.getUserId());
					vo.setName(ui.getNickName());

					for (TAppPersonTask personTask : taskPersons) {
						if (ui.getUserId().equals(personTask.getPersonId())) {
							vo.setApplied(true);
							break;
						}
					}
					applyArtistVos.add(vo);
				}

				responseAjax(SUCCESS, applyArtistVos);
				return;
			} else {
				responseAjax(ERROR, "您的艺人不超过5个，无法进行应征。快去添加更多艺人吧！");
				return;
			}
		}

		responseAjax(SUCCESS, "");
		return;
	}

	public void fetchTaskForInviting() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		// validation:
		String artistIdStr = request.getParameter("artistId");
		if (StringUtils.isBlank(artistIdStr) || !StringUtils.isNumeric(artistIdStr)) {
			responseAjax(ERROR, "参数错误：无法获得要邀请的用户ID。");
			return;
		}
		int artistId = Integer.valueOf(artistIdStr);
		TAppUser artistUser = userService.findUserById(artistId);
		if (artistUser == null) {
			responseAjax(ERROR, "参数错误：无法获得要邀请的用户。");
			return;
		}
		int currUserId = H5SessionHelper.currentUserId(request);
		Integer parentId = artistUser.getParentID();
		if (parentId != null && currUserId == parentId) {
			responseAjax(ERROR, "您不能邀请自己的艺人。");
			return;
		}

		// normal flow:
		// int currUserId = H5SessionHelper.currentUserId(request);
		List<TAppTask> userTaskList = taskService.getTaskListByUserID(currUserId, 0, 50);

		List<H5TaskInListVo> displayTaskList = new LinkedList<H5TaskInListVo>();

		if (!CollectionUtils.isEmpty(userTaskList)) {

			// update display time
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppTask tappTask : userTaskList) {
				H5TaskInListVo h5TaskInListVo = new H5TaskInListVo();
				h5TaskInListVo.setId(tappTask.getId());
				h5TaskInListVo.setTitle(tappTask.getTitle());
				h5TaskInListVo.setPersonCount(tappTask.getPersonCount());

				if (tappTask.getCreateDate() == null) {
					h5TaskInListVo.setDisplayCreateDate(tappTask.getCreatTime().substring(0, "yyyy-MM-dd".length()));
				} else {
					h5TaskInListVo.setDisplayCreateDate(format.format(tappTask.getCreateDate()));
				}

				String taskStatus = tappTask.getStatus();
				String taskActive = tappTask.getActive();
				String displayStatus = "";
				if ("-1".equals(taskActive)) {
					displayStatus = "已关闭";
					continue;
				} else if ("0".equals(taskActive)) {
					displayStatus = "审核不通过";
					continue;
				} else {
					if ("1".equals(taskStatus)) {
						displayStatus = "审核中";
						continue;
					} else if ("3".equals(taskStatus)) {
						displayStatus = "已发布";
					} else {
						// ERROR LOG TO TEAM
						displayStatus = "未知";
						continue;
					}
				}

				h5TaskInListVo.setStatus(displayStatus);

				// get related roles;
				List<TAppTaskRole> taskRoles = taskService.getTaskRoleList(tappTask, 0, 20);
				if (CollectionUtils.isEmpty(taskRoles)) {
					h5TaskInListVo.setRoleList(Collections.emptyList());
				} else {
					List<H5TaskRoleInListVo> roleList = new ArrayList<H5TaskRoleInListVo>();
					for (TAppTaskRole taskRole : taskRoles) {

						H5TaskRoleInListVo role = new H5TaskRoleInListVo();
						role.setId(String.valueOf(taskRole.getId()));

						String roleName = taskRole.getRoleName();
						if (roleName.contains(" ")) {
							String[] arr = roleName.split(" ");
							if (arr != null && arr.length > 0) {
								roleName = arr[arr.length - 1];
							}
						}
						role.setTitle(roleName);
						roleList.add(role);
					}
					h5TaskInListVo.setRoleList(roleList);
				}
				displayTaskList.add(h5TaskInListVo);
			}
		}

		// request.setAttribute("userTaskList", displayTaskList);

		responseAjax(SUCCESS, displayTaskList);

		// String key = request.getParameter("key");
		// logger.info("key: " + key);
		// responseAjax(SUCCESS, "");
		return;
	}

	public String createArtist() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int isOrgFlag = H5SessionHelper.currentIsOrgFlag(request);
		int currentUserId = H5SessionHelper.currentUserId(request);
		if (isOrgFlag < 0) {
			TAppUser user = userService.findUserById(currentUserId);
			if (user == null) {
				return H5LOGIN;
			}
			isOrgFlag = user.getIsOrg();
		}

		if (isOrgFlag != 1 && isOrgFlag != 2) {
			request.setAttribute("errormsg", "您无权限创建艺人。只有企业和经纪人可以创建艺人。");
			return ERROR;
		}
		TAppUserInfo tAppUserInfo = uService.findUserInfoByUserId(currentUserId);
		request.setAttribute("orgPhone", tAppUserInfo.getMobile());

		if (isOrgFlag == 2) {
			return "createBroArtist";
		}
		return SUCCESS;
	}

	public void updateArtist() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		int currentUserId = H5SessionHelper.currentUserId(request);

		// params
		String editIdStr = request.getParameter("editUserId");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String birth = request.getParameter("birth");
		String address = request.getParameter("address");
		// String tel = request.getParameter("tel");
		// String email = request.getParameter("email");
		String height = request.getParameter("height");
		String weight = request.getParameter("weight");
		String bust = request.getParameter("bust");
		String waist = request.getParameter("waist");
		String hipline = request.getParameter("hipline");
		String intro = request.getParameter("intro");

		String role0 = request.getParameter("role_0");
		String role1 = request.getParameter("role_1");
		String role2 = request.getParameter("role_2");
		String role3 = request.getParameter("role_3");
		String role4 = request.getParameter("role_4");

		logger.info("-----------------------");
		logger.info("name: " + name);
		logger.info("sex: " + sex);
		logger.info("birth: " + birth);
		logger.info("address: " + address);
		logger.info("height: " + height);
		logger.info("bust: " + bust);
		logger.info("waist: " + waist);
		logger.info("hipline: " + hipline);
		logger.info("intro: " + intro);
		// role1: {"role":"琵琶","price":"2001元/tian"}
		logger.info("role0: " + role0);
		logger.info("role1: " + role1);
		logger.info("role2: " + role2);
		logger.info("role3: " + role3);
		logger.info("role4: " + role4);
		logger.info("-----------------------");

		/**
		 * validation
		 */
		if (StringUtils.isBlank(editIdStr) || !StringUtils.isNumeric(editIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得被修改的ID，请稍后重试。");
			return;
		}
		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输名称");
			return;
		}
		if (StringUtils.isBlank(sex)) {
			responseAjax(ERROR, "请输性别");
			return;
		}
		if (StringUtils.isBlank(birth)) {
			responseAjax(ERROR, "选择生日");
			return;
		}
		if (StringUtils.isBlank(address)) {
			responseAjax(ERROR, "选择所在地");
			return;
		}
		if (isEmptyRole(role0) && isEmptyRole(role1) && isEmptyRole(role2) && isEmptyRole(role3) && isEmptyRole(role4)) {
			responseAjax(ERROR, "请至少选择1个角色");
			return;
		}

		/**
		 * persist
		 */
		// User //
		int editId = Integer.valueOf(editIdStr);
		TAppUser editingUser = userService.findUserById(editId);
		TAppUserInfo editingUserInfo = uService.findUserInfoByUserId(editId);
		if (editingUser == null || editingUserInfo == null) {
			responseAjax(ERROR, "参数错误。无法获得被编辑的信息。请稍后再试。");
			return;
		}

		// role validation

		int editOrg = editingUser.getIsOrg();
		if (editOrg != 0) {
			responseAjax(ERROR, "参数错误。非艺人信息。");
			return;
		}

		if (currentUserId != editId && currentUserId != editingUser.getParentID()) {
			responseAjax(ERROR, "权限错误。您无权编辑这个信息。");
			return;
		}

		// COST //
		List<TAppCostInfo> costList = new LinkedList<TAppCostInfo>();
		if (!H5ValidationHelper.isEmptyRole(role0)) {
			TAppCostInfo costInfo0 = translateRole2CostInfo(role0, 1, editId);
			if (costInfo0 != null) {
				costList.add(costInfo0);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role1)) {
			TAppCostInfo costInfo1 = translateRole2CostInfo(role1, 2, editId);
			if (costInfo1 != null) {
				costList.add(costInfo1);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role2)) {
			TAppCostInfo costInfo2 = translateRole2CostInfo(role2, 3, editId);
			if (costInfo2 != null) {
				costList.add(costInfo2);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role3)) {
			TAppCostInfo costInfo3 = translateRole2CostInfo(role3, 4, editId);
			if (costInfo3 != null) {
				costList.add(costInfo3);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role4)) {
			TAppCostInfo costInfo4 = translateRole2CostInfo(role4, 5, editId);
			if (costInfo4 != null) {
				costList.add(costInfo4);
			}
		}

		editingUser.setCostList(costList);
		userService.updateUser(editingUser);

		// UserInfo //
		editingUserInfo.setSex(H5ParamTranslater.translateSexStr(sex));
		editingUserInfo.setNickName(name);
		editingUserInfo.setBirthday(birth);
		if (StringUtils.isNotBlank(bust) && StringUtils.isNumeric(bust.trim())) {
			editingUserInfo.setHeartSize(bust.trim());
		}
		if (StringUtils.isNotBlank(waist) && StringUtils.isNumeric(waist.trim())) {
			editingUserInfo.setWaistSize(waist.trim());
		}
		if (StringUtils.isNotBlank(hipline) && StringUtils.isNumeric(hipline.trim())) {
			editingUserInfo.setBottocksSize(hipline.trim());
		}
		if (StringUtils.isNotBlank(height) && StringUtils.isNumeric(height.trim())) {
			editingUserInfo.setHeight(height.trim());
		}
		if (StringUtils.isNotBlank(weight) && StringUtils.isNumeric(weight.trim())) {
			editingUserInfo.setWeight(weight.trim());
		}
		if (StringUtils.isNotBlank(intro)) {
			editingUserInfo.setIntroduction(intro);
		}

		/**
		 * convert province and city
		 */
		String province = "";
		String city = "";
		String place = "";
		String[] places = address.split(" ");
		if (places.length == 3) {
			province = places[0];
			city = places[1];
			place = places[2] + place;
		} else if (places.length == 2) {
			province = places[0];
			city = places[1];
		} else if (places.length == 1) {
			province = places[0];
			city = places[0];
		}
		editingUserInfo.setProvice(province);
		editingUserInfo.setCity(city);
		editingUserInfo.setPlace(place);

		editingUserInfo.setProfessionStr(convertCost2ProfessionStr(costList));
		uService.updateUserInfo(editingUserInfo);
		responseAjax(SUCCESS, "");
	}

	private String convertCost2ProfessionStr(List<TAppCostInfo> costList) {

		if (CollectionUtils.isEmpty(costList)) {
			return "";
		}
		StringBuilder sb = new StringBuilder();
		for (int index = 0; index < costList.size(); index++) {
			TAppCostInfo costInfo = costList.get(index);
			sb.append(costInfo.getKeywords());
			if (index < costList.size() - 1) {
				sb.append(",");
			}
		}
		return sb.toString();
	}

	public void rotateHeadImg() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String orientation = request.getParameter("orientation");
		if (StringUtils.isBlank(orientation) || (!"right".equals(orientation) && !"left".equals(orientation))) {
			responseAjax(ERROR, "参数错误，无法获得旋转方向。");
			return;
		}

		int currentUserId = H5SessionHelper.currentUserId(request);
		int result = H5FileHelper.rotateHeadImg(currentUserId, orientation);

		if (result < 0) {
			responseAjax(ERROR, "旋转失败，请稍后再试。");
			return;
		}

		responseAjax(SUCCESS, "");
	}

	public void doUploadHeadImg() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String uploadUserIdStr = request.getParameter("uploadUserId");
		String image = request.getParameter("proImg");
		String imageName = request.getParameter("proImgName");

		/**
		 * validation
		 */
		if (StringUtils.isBlank(uploadUserIdStr) || !StringUtils.isNumeric(uploadUserIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得上传用户头像，请稍后再试。");
			return;
		}

		int uploadUserId = Integer.valueOf(uploadUserIdStr);
		int curUserId = H5SessionHelper.currentUserId(request);
		int isOrg = H5SessionHelper.currentIsOrgFlag(request);

		if (uploadUserId != curUserId) {
			if (isOrg != 1 && isOrg != 2) {
				responseAjax(ERROR, "权限错误。您无权上传此用户的头像。");
				return;
			}
		}

		try {
			H5FileHelper.persistHeadImg(image, uploadUserId, imageName);
		} catch (Exception e) {
			e.printStackTrace();
			responseAjax(ERROR, "上传失败，请稍后再试。");
		}

		responseAjax(SUCCESS, "");
	}

	public void doUploadArts() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		String uploadUserIdStr = request.getParameter("uploadUserId");
		String image = request.getParameter("proImg");
		String imageName = request.getParameter("proImgName");
		String videoList = request.getParameter("videolist");

		/**
		 * validation
		 */
		if (StringUtils.isBlank(uploadUserIdStr) || !StringUtils.isNumeric(uploadUserIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得上传作品的ID，请稍后再试。");
			return;
		}

		if ((StringUtils.isBlank(image) || StringUtils.isBlank(imageName)) && (StringUtils.isBlank(videoList) || "[]".equals(videoList))) {
			responseAjax(ERROR, "参数错误。未找到可上传的作品。");
			return;
		}

		int uploadUserId = Integer.valueOf(uploadUserIdStr);
		int curUserId = H5SessionHelper.currentUserId(request);
		int isOrg = H5SessionHelper.currentIsOrgFlag(request);

		if (uploadUserId != curUserId) {
			if (isOrg != 1 && isOrg != 2) {
				responseAjax(ERROR, "权限错误。您无权上传此用户的作品。");
				return;
			}
		}

		if (isOrg == 2) {
			List<TAppArtInfo> artInfoList = artInfoService.getArtInfoList(uploadUserId, 0, 2, 1);
			if (!CollectionUtils.isEmpty(artInfoList)) {
				responseAjax(ERROR, "经纪人艺人只能上传1件作品，无法继续上传。");
				return;
			}
		}

		/**
		 * validation
		 */
		if (StringUtils.isBlank(uploadUserIdStr) || !StringUtils.isNumeric(uploadUserIdStr)) {
			responseAjax(ERROR, "参数错误。无法获得上传作品的用户id。请稍后再试。");
			return;
		}

		/**
		 * art of video
		 */
		if (StringUtils.isNotBlank(videoList) && !"[]".equals(videoList)) {
			List<TAppArtInfo> videoArtList = convertVideoList(videoList, uploadUserId);
			if (!CollectionUtils.isEmpty(videoArtList)) {
				for (TAppArtInfo tAppArtInfo : videoArtList) {
					artInfoService.saveOrUpdateArtInfo(tAppArtInfo);
				}
			}
		}

		/**
		 * art of image
		 */
		if (StringUtils.isNotBlank(imageName) && StringUtils.isNotBlank(image)) {

			// check if has album id
			List<TAppArtInfo> albums = artInfoService.getArtInfoList(uploadUserId, 0, 1, 1);
			if (CollectionUtils.isEmpty(albums)) {
				// no albums, so create a new
				int artId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("art"));

				TAppArtInfo artImage = new TAppArtInfo();
				artImage.setId(artId);
				artImage.setType("1");
				artImage.setUserId(uploadUserId);
				artImage.setCreatTime(CommonUtil.getTime(new Date()));
				artImage.setUrl(H5FileHelper.persistArtImage(image, uploadUserId, artId, imageName));
				artImage.setImgCount(1);
				artImage.setDing(0);
				artImage.setShare(0);
				artImage.setEvaluate(0);
				artInfoService.saveOrUpdateArtInfo(artImage);

				TAppImagesInfo tAppImagesInfo = new TAppImagesInfo();
				tAppImagesInfo.setParentId(artId);
				tAppImagesInfo.setUrl(artImage.getUrl());
				artInfoService.saveImginfo(tAppImagesInfo);
			} else {
				TAppArtInfo tappArtInfo = albums.get(0);
				int albumsId = tappArtInfo.getId();

				TAppImagesInfo tAppImagesInfo = new TAppImagesInfo();
				tAppImagesInfo.setParentId(albumsId);
				tAppImagesInfo.setUrl(H5FileHelper.persistArtImage(image, uploadUserId, albumsId, imageName));
				artInfoService.saveImginfo(tAppImagesInfo);
			}
		}

		responseAjax(SUCCESS, "");
	}

	public void saveOrUpdateArtist() {

		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			responseAjax(ERROR, "没有登录");
			return;
		}

		int curUserId = H5SessionHelper.currentUserId(request);
		TAppUser curUser = userService.getUserById(curUserId);
		TAppUserInfo curUserInfo = uService.findUserInfoByUserId(curUserId);
		if (curUser == null || curUserInfo == null) {
			responseAjax(ERROR, "数据丢失，请重新登录");
			return;
		}

		int isOrgFlag = H5SessionHelper.currentIsOrgFlag(request);
		if (isOrgFlag == -1) {
			isOrgFlag = curUser.getIsOrg();
			// TODO PERSIST INTO SESSION
		}
		if (isOrgFlag != 1 && isOrgFlag != 2) {
			responseAjax(ERROR, "当前登录用户无权创建艺人");
			return;
		}

		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String birth = request.getParameter("birth");
		String address = request.getParameter("address");
		// String tel = request.getParameter("tel");
		// String email = request.getParameter("email");
		String height = request.getParameter("height");
		String weight = request.getParameter("weight");
		String bust = request.getParameter("bust");
		String waist = request.getParameter("waist");
		String hipline = request.getParameter("hipline");
		String intro = request.getParameter("intro");

		String image = request.getParameter("proImg");
		String imageName = request.getParameter("proImgName");

		String role0 = request.getParameter("role_0");
		String role1 = request.getParameter("role_1");
		String role2 = request.getParameter("role_2");
		String role3 = request.getParameter("role_3");
		String role4 = request.getParameter("role_4");

		String videoList = request.getParameter("videolist");

		logger.info("-----------------------");
		logger.info("name: " + name);
		logger.info("sex: " + sex);
		logger.info("birth: " + birth);
		logger.info("address: " + address);
		// logger.info("tel: " + tel);
		// logger.info("email: " + email);
		logger.info("height: " + height);
		logger.info("bust: " + bust);
		logger.info("waist: " + waist);
		logger.info("hipline: " + hipline);
		logger.info("intro: " + intro);

		// role0: {"role":"扬琴","price":"2000元/tian"}
		// role1: {"role":"琵琶","price":"2001元/tian"}

		logger.info("role0: " + role0);
		logger.info("role1: " + role1);
		logger.info("role2: " + role2);
		logger.info("role3: " + role3);
		logger.info("role4: " + role4);

		logger.info("-----------------------");

		/**
		 * TODO: validation
		 */
		if (StringUtils.isBlank(name)) {
			responseAjax(ERROR, "请输名称");
			return;
		}
		if (StringUtils.isBlank(sex)) {
			responseAjax(ERROR, "请输性别");
			return;
		}
		if (StringUtils.isBlank(birth)) {
			responseAjax(ERROR, "选择生日");
			return;
		}
		if (StringUtils.isBlank(address)) {
			responseAjax(ERROR, "选择所在地");
			return;
		}
		// if (StringUtils.isBlank(tel)) {
		// responseAjax(ERROR, "请输入手机号");
		// }
		// if (StringUtils.isBlank(email)) {
		// responseAjax(ERROR, "请输入邮箱");
		// }
		if (isEmptyRole(role0) && isEmptyRole(role1) && isEmptyRole(role2) && isEmptyRole(role3) && isEmptyRole(role4)) {
			responseAjax(ERROR, "请至少选择1个角色");
			return;
		}

		/**
		 * persist
		 */
		// User //
		TAppUser user = new TAppUser();
		TAppUserInfo userInfo = new TAppUserInfo();
		int userId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));
		user.setId(userId);
		setUpForOrgArtUser(user, userInfo, curUserId);

		user.setUsername(H5CommonHelper.generateUserName(curUser.getEmail()));
		user.setUserPsd(H5CommonHelper.generateRandomPsd());
		user.setEmail(curUser.getEmail());
		user.setCreatTime(CommonUtil.getTime(new Date()));

		// COST //
		List<TAppCostInfo> costList = new LinkedList<TAppCostInfo>();
		if (!H5ValidationHelper.isEmptyRole(role0)) {
			TAppCostInfo costInfo0 = translateRole2CostInfo(role0, 1, userId);
			if (costInfo0 != null) {
				costList.add(costInfo0);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role1)) {
			TAppCostInfo costInfo1 = translateRole2CostInfo(role1, 2, userId);
			if (costInfo1 != null) {
				costList.add(costInfo1);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role2)) {
			TAppCostInfo costInfo2 = translateRole2CostInfo(role2, 3, userId);
			if (costInfo2 != null) {
				costList.add(costInfo2);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role3)) {
			TAppCostInfo costInfo3 = translateRole2CostInfo(role3, 4, userId);
			if (costInfo3 != null) {
				costList.add(costInfo3);
			}
		}
		if (!H5ValidationHelper.isEmptyRole(role4)) {
			TAppCostInfo costInfo4 = translateRole2CostInfo(role4, 5, userId);
			if (costInfo4 != null) {
				costList.add(costInfo4);
			}
		}
		user.setCostList(costList);

		int persistId = userService.saveUser(user);
		if (persistId <= 0) {
			responseAjax(ERROR, "创建失败，请稍候再试...");
			return;
		}

		// UserInfo //
		userInfo.setSex(H5ParamTranslater.translateSexStr(sex));
		userInfo.setMobile(curUserInfo.getMobile());
		userInfo.setNickName(name);
		userInfo.setBirthday(birth);
		if (StringUtils.isNotBlank(bust) && StringUtils.isNumeric(bust.trim())) {
			userInfo.setHeartSize(bust.trim());
		}
		if (StringUtils.isNotBlank(waist) && StringUtils.isNumeric(waist.trim())) {
			userInfo.setWaistSize(waist.trim());
		}
		if (StringUtils.isNotBlank(hipline) && StringUtils.isNumeric(hipline.trim())) {
			userInfo.setBottocksSize(hipline.trim());
		}
		if (StringUtils.isNotBlank(height) && StringUtils.isNumeric(height.trim())) {
			userInfo.setHeight(height.trim());
		}
		if (StringUtils.isNotBlank(weight) && StringUtils.isNumeric(weight.trim())) {
			userInfo.setWeight(weight.trim());
		}
		if (StringUtils.isNotBlank(intro)) {
			userInfo.setIntroduction(intro);
		}

		/**
		 * convert province and city
		 */
		String province = "";
		String city = "";
		String place = "";
		String[] places = address.split(" ");
		if (places.length == 3) {
			province = places[0];
			city = places[1];
			place = places[2] + place;
		} else if (places.length == 2) {
			province = places[0];
			city = places[1];
		} else if (places.length == 1) {
			province = places[0];
			city = places[0];
		}
		userInfo.setProvice(province);
		userInfo.setCity(city);
		userInfo.setPlace(place);

		/**
		 * art of video
		 */
		List<TAppArtInfo> videoArtList = convertVideoList(videoList, userId);
		if (!CollectionUtils.isEmpty(videoArtList)) {
			for (TAppArtInfo tAppArtInfo : videoArtList) {
				artInfoService.saveOrUpdateArtInfo(tAppArtInfo);
			}
		}

		/**
		 * art of image
		 */
		int artId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("art"));
		if (StringUtils.isNotBlank(image)) {
			TAppArtInfo artImage = new TAppArtInfo();
			artImage.setId(artId);
			artImage.setType("1");
			artImage.setUserId(userId);
			artImage.setCreatTime(CommonUtil.getTime(new Date()));
			artImage.setUrl(H5FileHelper.persistArtImage(image, userId, artId, imageName));
			artImage.setImgCount(1);
			artImage.setDing(0);
			artImage.setShare(0);
			artImage.setEvaluate(0);

			TAppImagesInfo tAppImagesInfo = new TAppImagesInfo();
			tAppImagesInfo.setParentId(artId);
			tAppImagesInfo.setUrl(artImage.getUrl());
			artInfoService.saveImginfo(tAppImagesInfo);
			artInfoService.saveOrUpdateArtInfo(artImage);
		}
		userInfo.setProfessionStr(convertCost2ProfessionStr(costList));
		uService.saveUserInfo(userInfo);

		responseAjax(SUCCESS, "");
	}

	private List<TAppArtInfo> convertVideoList(String videoList, int userId) {
		if (StringUtils.isBlank(videoList)) {
			return Collections.emptyList();
		}
		try {
			JSONArray videoArray = JSON.parseArray(videoList);
			if (videoArray == null) {
				return Collections.emptyList();
			}

			List<TAppArtInfo> result = new ArrayList<TAppArtInfo>();
			String currentDateTime = CommonUtil.getTime(new Date());
			for (int index = 0; index < videoArray.size(); index++) {
				JSONObject object = videoArray.getJSONObject(index);
				if (object == null) {
					continue;
				}

				String videoUrl = object.getString("videoLink");
				if (StringUtils.isBlank(videoUrl)) {
					continue;
				}

				TAppArtInfo tAppArtInfo = new TAppArtInfo();
				int artId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("art"));
				tAppArtInfo.setId(artId);
				tAppArtInfo.setTitle(object.getString("videoTitle"));
				tAppArtInfo.setUrl(videoUrl);
				tAppArtInfo.setCreatTime(currentDateTime);
				tAppArtInfo.setUserId(userId);
				tAppArtInfo.setType("2");
				tAppArtInfo.setImgCount(0);
				tAppArtInfo.setDing(0);
				tAppArtInfo.setShare(0);
				tAppArtInfo.setEvaluate(0);
				result.add(tAppArtInfo);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	private void setUpForOrgArtUser(TAppUser tAppUser, TAppUserInfo tAppUserInfo, int parentId) {
		tAppUser.setIsOrg(0);
		tAppUser.setRoleId(2);
		// tAppUser.setRzState("1");
		tAppUser.setState("0");
		tAppUser.setCreatTime(CommonUtil.getTime(new Date()));
		tAppUser.setAuthority(0);
		tAppUser.setApplicate(0);
		tAppUser.setParentID(parentId);

		tAppUserInfo.setId(tAppUser.getId());
		tAppUserInfo.setUserId(tAppUser.getId());
		tAppUserInfo.setSellerGrade("1");
		tAppUserInfo.setAge(0);
		tAppUserInfo.setIsRecommend("0");
		tAppUserInfo.setSignNumber(0);
		tAppUserInfo.setSignAmount("保密");
		tAppUserInfo.setPopularityTotal(0);
		tAppUserInfo.setGrade("1");
		tAppUserInfo.setFeedbackRate(100);
		tAppUserInfo.setCreatTime(CommonUtil.getTime(new Date()));
		return;
	}

	private boolean isEmptyRole(String role) {
		return StringUtils.isBlank(role) || "{}".equals(role);
	}

	private TAppCostInfo translateRole2CostInfo(String role, int orderNo, int userId) {
		try {
			TAppCostInfo costInfo = new TAppCostInfo();
			costInfo.setUserId(userId);
			costInfo.setOrderNo(orderNo);

			JSONObject roleObj = null;
			try {
				roleObj = JSON.parseObject(role);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			if (roleObj == null) {
				return null;
			}

			String talentTypeName = roleObj.getString("role");
			costInfo.setKeywords(talentTypeName);

			String priceText = roleObj.getString("price");
			if (StringUtils.isNotBlank(priceText) && priceText.contains("元/")) {
				String[] arr = priceText.split("元/");
				String priceStr = arr[0];
				if (StringUtils.isNumeric(priceStr)) {
					int price = Integer.valueOf(priceStr);
					// normally eprice > bprice
					costInfo.setEprice(price);
					costInfo.setBprice(price);
				} else {
					System.out.println("[ERROR] not numeric for price: " + priceStr);
				}

				if (arr.length > 1) {
					costInfo.setUnit(arr[1]);
				}
			}
			int talentId = costService.findTalentIdByTypeName(talentTypeName);
			if (talentId > 0) {
				costInfo.setProfession(talentId);
			} else {
				System.out.println("[ERROR] can not find talent for : " + talentTypeName);
			}

			return costInfo;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * invite functions start
	 */
	public String myInvitingList() {

		// check login
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int curUserId = H5SessionHelper.currentUserId(request);
		List<TAppBusinessInfo> businessInfoList = businessInfoService.getBusinessInfosByUserIdAndRole(curUserId, 1);

		List<H5InviteInListVo> h5InviteInListVos = new ArrayList<H5InviteInListVo>();

		if (!CollectionUtils.isEmpty(businessInfoList)) {

			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppBusinessInfo bInfo : businessInfoList) {
				H5InviteInListVo invite = new H5InviteInListVo();
				Integer targetUserId = bInfo.getSeller();
				if (targetUserId == null) {
					System.out.println("ERROR: null seller id for buzinfo: " + bInfo.getId());
					continue;
				}
				TAppUserInfo targetUser = uService.findUserInfoByUserId(targetUserId);
				if (targetUser != null) {
					invite.setInviteUserId(targetUser.getUserId());
					invite.setInviteUserName(targetUser.getNickName());
				}

				invite.setPrice(bInfo.getPrice());
				invite.setAddress(bInfo.getProvice() + " " + bInfo.getCity() + " " + bInfo.getAddress());
				invite.setContent(bInfo.getContent());
				invite.setDisplayCreateDate(format.format(bInfo.getCreateTime()));

				List<TAppBusinessCost> bizCostList = businessInfoService.findBusiCostByBusiId(bInfo.getId());
				if (!CollectionUtils.isEmpty(bizCostList)) {
					invite.setCostName(bizCostList.get(0).getKeywords());
				}

				h5InviteInListVos.add(invite);
			}
		}
		request.setAttribute("invitingList", h5InviteInListVos);
		return SUCCESS;
	}

	public String myInvitedList() {
		// check login
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int curUserId = H5SessionHelper.currentUserId(request);
		List<TAppBusinessInfo> businessInfoList = businessInfoService.getBusinessInfosByUserIdAndRole(curUserId, 2);

		List<H5InviteInListVo> h5InviteInListVos = new ArrayList<H5InviteInListVo>();

		if (!CollectionUtils.isEmpty(businessInfoList)) {

			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppBusinessInfo bInfo : businessInfoList) {
				H5InviteInListVo invite = new H5InviteInListVo();
				Integer targetUserId = bInfo.getBuyer();// .getSeller();
				if (targetUserId == null) {
					System.out.println("ERROR: null seller id for buzinfo: " + bInfo.getId());
					continue;
				}
				TAppUserInfo targetUser = uService.findUserInfoByUserId(targetUserId);
				if (targetUser != null) {
					invite.setInviteUserId(targetUser.getUserId());
					invite.setInviteUserName(targetUser.getNickName());
				}

				invite.setPrice(bInfo.getPrice());
				invite.setAddress(bInfo.getProvice() + " " + bInfo.getCity() + " " + bInfo.getAddress());
				invite.setContent(bInfo.getContent());
				invite.setDisplayCreateDate(format.format(bInfo.getCreateTime()));

				List<TAppBusinessCost> bizCostList = businessInfoService.findBusiCostByBusiId(bInfo.getId());
				if (!CollectionUtils.isEmpty(bizCostList)) {
					invite.setCostName(bizCostList.get(0).getKeywords());
				}

				h5InviteInListVos.add(invite);
			}
		}
		request.setAttribute("invitedList", h5InviteInListVos);
		return SUCCESS;
	}

	public String myArtistInvitedList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int curUserId = H5SessionHelper.currentUserId(request);
		List<TAppBusinessInfo> businessInfoList = businessInfoService.getBusinessInfosByBizBroId(curUserId);

		List<H5InviteInListVo> h5InviteInListVos = new ArrayList<H5InviteInListVo>();

		if (!CollectionUtils.isEmpty(businessInfoList)) {

			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

			for (TAppBusinessInfo bInfo : businessInfoList) {
				H5InviteInListVo invite = new H5InviteInListVo();
				Integer targetUserId = bInfo.getSeller();
				if (targetUserId == null) {
					System.out.println("ERROR: null seller id for buzinfo: " + bInfo.getId());
					continue;
				}
				Integer artistUserId = bInfo.getBuyer();
				if (artistUserId == null) {
					System.out.println("ERROR: null buyer id for buzinfo: " + bInfo.getId());
					continue;
				}
				TAppUserInfo targetUser = uService.findUserInfoByUserId(targetUserId);
				if (targetUser != null) {
					invite.setInviteUserId(targetUser.getUserId());
					invite.setInviteUserName(targetUser.getNickName());
				}
				TAppUserInfo artistUser = uService.findUserInfoByUserId(artistUserId);
				if (targetUser != null) {
					invite.setArtistId(artistUser.getUserId());
					invite.setArtistName(artistUser.getNickName());
				}

				invite.setPrice(bInfo.getPrice());
				invite.setAddress(bInfo.getProvice() + " " + bInfo.getCity() + " " + bInfo.getAddress());
				invite.setContent(bInfo.getContent());
				invite.setDisplayCreateDate(format.format(bInfo.getCreateTime()));

				List<TAppBusinessCost> bizCostList = businessInfoService.findBusiCostByBusiId(bInfo.getId());
				if (!CollectionUtils.isEmpty(bizCostList)) {
					invite.setCostName(bizCostList.get(0).getKeywords());
				}

				h5InviteInListVos.add(invite);
			}
		}
		request.setAttribute("invitedList", h5InviteInListVos);

		return SUCCESS;
	}

	/**
	 * invite functions end
	 */

	public String myFansList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int curUserId = H5SessionHelper.currentUserId(request);
		List<TAppUserInfo> fanList = friendInfoService.getFriendUserInfoList(curUserId, 0, 50, 1);
		List<H5ArtistBriefInfoVo> fans = new ArrayList<H5ArtistBriefInfoVo>();

		if (!CollectionUtils.isEmpty(fanList)) {
			for (TAppUserInfo userInfo : fanList) {
				H5ArtistBriefInfoVo briefInfoVo = new H5ArtistBriefInfoVo();
				briefInfoVo.setUserId(userInfo.getUserId());
				briefInfoVo.setNickName(userInfo.getNickName());

				if (StringUtils.isNotBlank(userInfo.getCompanyTags())) {
					briefInfoVo.setTags(userInfo.getCompanyTags().replace(",", " "));
				} else {
					briefInfoVo.setTags(StringUtils.isBlank(userInfo.getProfessionStr()) ? "" : userInfo.getProfessionStr().replace(",", " "));
				}

				fans.add(briefInfoVo);
			}
		}

		request.setAttribute("fans", fans);
		return SUCCESS;
	}

	public String myFollowedList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean needLogin = H5SessionHelper.checkLogin(request);
		if (needLogin) {
			return H5LOGIN;
		}

		int curUserId = H5SessionHelper.currentUserId(request);
		List<TAppUserInfo> followedList = friendInfoService.getFriendUserInfoList(curUserId, 0, 50, 2);

		List<H5ArtistBriefInfoVo> followeds = new ArrayList<H5ArtistBriefInfoVo>();

		if (!CollectionUtils.isEmpty(followedList)) {
			for (TAppUserInfo userInfo : followedList) {
				H5ArtistBriefInfoVo briefInfoVo = new H5ArtistBriefInfoVo();
				briefInfoVo.setUserId(userInfo.getUserId());
				briefInfoVo.setNickName(userInfo.getNickName());

				if (StringUtils.isNotBlank(userInfo.getCompanyTags())) {
					briefInfoVo.setTags(userInfo.getCompanyTags().replace(",", " "));
				} else {
					briefInfoVo.setTags(StringUtils.isBlank(userInfo.getProfessionStr()) ? "" : userInfo.getProfessionStr().replace(",", " "));
				}

				followeds.add(briefInfoVo);
			}
		}

		request.setAttribute("followeds", followeds);
		return SUCCESS;
	}
}
