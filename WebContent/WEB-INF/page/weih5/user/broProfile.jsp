<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>

<meta charset="UTF-8">
<title>个人中心</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

</head>

<body style="background:#f2f2f2;">

<div id="setting" class="mui-page">
	<!--页面主内容区开始-->
	<div class="mui-page-content">
		<div class="mui-scroll-wrapper no-ab">
			<div class="mui-scroll no-ab">
				<ul class="mui-table-view mui-table-view-chevron">
					<li class="mui-table-view-cell mui-media">
						<a class="mui-navigate-right" href="artistDetail.htm?userId=<s:property value="#request.profileInfoVo.userId"/>">
							<img class="mui-media-object mui-pull-left head-img" id="head-img" src="http://www.d15t.com/stageUpload/headImage/<s:property value="#request.profileInfoVo.userId"/>.png">
							<div class="mui-media-body">
								<s:property value="#request.profileInfoVo.userNickName"/>
								<p class='mui-ellipsis'>账号:<s:property value="#request.profileInfoVo.userAccountName"/></p>
							</div>
						</a>
					</li>
					<li class="mui-table-view-cell center_list">
						<a href="createH5BizTask.htm" class="center_item">
                            <!-- <img class="icon" src="/stage01/h5assets/images/person_1.png"> -->
                            <img class="icon" src="/h5assets/images/person_1.png">
                            <div>委托我们</div>
                        </a> 
						<a href="createH5Task.htm" class="center_item item_2">
                            <!-- <img class="icon" src="/stage01/h5assets/images/person_2.png"> -->
                            <img class="icon" src="/h5assets/images/person_2.png">
                            <div>发布通告</div>
                        </a> 
						<a href="createArtist.htm" class="center_item">
                            <!-- <img class="icon" src="/stage01/h5assets/images/person_3.png"> -->
                            <img class="icon" src="/h5assets/images/person_3.png">
                            <div>添加艺人</div>
                        </a> 
					</li>
				</ul>
				<ul class="mui-table-view mui-table-view-chevron">
					<li class="mui-table-view-cell">
						<a href="myBizTaskList.htm" class="mui-navigate-right">我发布的委托(<s:property value="#request.profileInfoVo.myBizTaskCount"/>)</a>
					</li>
				</ul>
				<ul class="mui-table-view mui-table-view-chevron">
					<li class="mui-table-view-cell">
						<a href="myTaskList.htm" class="mui-navigate-right">我发布的通告(<s:property value="#request.profileInfoVo.myTaskCount"/>)</a>
					</li>
					<li class="mui-table-view-cell">
						<a href="myArtistAppliedTaskList.htm" class="mui-navigate-right">我应征的通告(<s:property value="#request.profileInfoVo.myAppliedTaskCount"/>)</a>
					</li>
				</ul>
				<ul class="mui-table-view mui-table-view-chevron">
					<li class="mui-table-view-cell">
						<a href="myInvitingList.htm" class="mui-navigate-right">我发出的邀请(<s:property value="#request.profileInfoVo.myInviteCount"/>)</a>
					</li>
					<li class="mui-table-view-cell">
						<a href="myArtistInvitedList.htm" class="mui-navigate-right">我的艺人收到的邀请(<s:property value="#request.profileInfoVo.invitedMeCount"/>)</a>
					</li>
				</ul>
				<ul class="mui-table-view mui-table-view-chevron">
					<li class="mui-table-view-cell">
						<a href="myFollowedList.htm" class="mui-navigate-right">我的关注(<s:property value="#request.profileInfoVo.myFollowCount"/>)</a>
					</li>
					<li class="mui-table-view-cell">
						<a href="myFansList.htm" class="mui-navigate-right">我的粉丝(<s:property value="#request.profileInfoVo.myFanCount"/>)</a>
					</li>
				</ul>
				<ul class="mui-table-view mui-table-view-chevron">
					<li class="mui-table-view-cell">
						<a href="#" id="my-qrcode" class="mui-navigate-right">我的二维码</a>
					</li>
				</ul>
				<ul class="mui-table-view">
					<li class="mui-table-view-cell" style="text-align: center;">
						<a href="h5logout.htm">退出登录</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<nav class="mui-bar mui-bar-tab menu">
		<a class="menu-biz-home mui-tab-item" href="h5IndexPage.htm">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</a>
		<a class="menu-biz-task mui-tab-item" href="createH5BizTask.htm">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item" href="createH5Task.htm">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item mui-active" href="myProfile.htm">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</div>
<div id='userId' style='display:none'><s:property value="#request.profileInfoVo.userId"/></div>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery.qrcode.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script>
	$("#my-qrcode").click(showQrcode);

	function showQrcode(){
		var userId = $("#userId").text();
		mui.alert("<div id='qrcode'></div>","我的二维码");
		$("#qrcode").qrcode({
			render: "table",
			width: 200,
			height:200,
			text: "http://www.d15t.com/weih5/artistDetail.htm?userId="+userId
		});
		$("#qrcode").find("table").css("margin","auto");
	}
</script>
</body>

</html>