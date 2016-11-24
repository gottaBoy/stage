<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>

<meta charset="UTF-8">
<title>经纪人详情</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />
</head>
<body>

<%
TAppUserInfo userInfo = (TAppUserInfo) request.getAttribute("userInfo");
TAppUser user = (TAppUser) request.getAttribute("user");
 %>

<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active artist company">

						<div class="art-head">
							<div class="art-himg">
								<img src="http://www.d15t.com/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png">
								<div class="art-img-txt">
									<!--<span class="no">&radic;</span>-->
								</div>
								<s:if test="'true'==#request.isCurrentUser">
				 					<div class="headImgEditBtn">
										<!-- <a href="uploadHeadImg.htm?editId=<s:property value="#request.userInfo.userId"/>">编 辑</a> -->
										<span>编 辑</span>
									</div>
				 				</s:if>	
							</div>
							
							<div class="art-name"><s:property value="#request.userInfo.nickName"/></div>
							
							<div class="art-fans">
								<span>粉丝：<em><s:property value="#request.friendFSTotal"/></em></span>
								
								<s:if test="'true'!=#request.isCurrentUser">
									<s:if test="#request.isFollowing==true">
										<a href="javascript:void(0);" class="art-follow gzing"><!-- + 关注 --> 已关注</a>
									</s:if>
									<s:else>
										<a href="javascript:void(0);" class="art-follow">关注</a>
									</s:else>
								</s:if>
								
							</div>
						</div>

				 		<ul class="list">
							<s:if test="#request.userInfo.introduction == null || #request.userInfo.introduction == ''">
				 				<li><span>简介</span><em class="intro">暂无</em></li>
				 			</s:if>
				 			<s:else>
				 				<li><span>简介</span><em class="intro"><s:property value="#request.userInfo.introduction"/></em></li>
				 			</s:else>

				 			<li>
				 				<span>联系方式：</span>
				 				<em class="intro">
				 					<s:property value="#request.userInfo.mobile"/><br />
				 					<s:property value="#request.user.email"/>
				 				</em>
				 			</li>
				 			<li class="bbn">
								<span>所在地</span><em class="intro"><s:property value="#request.userInfo.provice"/> &nbsp;<s:if test="#request.userInfo.city != null && #request.userInfo.city != ''">|&nbsp; <s:property value="#request.userInfo.city"/>
								</s:if><s:if test="#request.userInfo.place != null && #request.userInfo.place != ''">|&nbsp; <s:property value="#request.userInfo.place"/>
								</s:if></em>
							</li>
				 		</ul>

						<s:if test="'true'==#request.isCurrentUser">
				 			<div class="t-center" style="margin-bottom: 20px;">
				 				<a href="editProfile.htm?editId=<s:property value='#request.userInfo.userId'/>" class="create-com edit-profile-btn">编辑</a>
				 			</div>
				 		</s:if>

				 		<div class="works">
				 			<h3><strong>艺人列表</strong></h3>
				 			
				 			<s:if test="#request.artistList==null || #request.artistList.size==0">
				 				暂无艺人信息
				 				<p class="jwarning">提示: 少于5个艺人，不能应征通告！</p>
				 			</s:if>
				 			<s:else>
				 			<ul class="mui-table-view mui-table-view-chevron" style="margin-top:0px;">
				 				<s:iterator value="#request.artistList" var="art" status="st">
				 				<li class="mui-table-view-cell mui-media">
				 					<a class="mui-navigate-right" href="artistDetail.htm?userId=<s:property value='#art.userId'/>">
										<img class="mui-media-object mui-pull-left" src="http://www.d15t.com/stageUpload/headImage/<s:property value='#art.userId'/>.png">
										<div class="mui-media-body"><s:property value="#art.nickName"/><p class='mui-ellipsis'><s:property value="#art.tags"/></p></div>
									</a>
								</li>
						 		</s:iterator>
						 	</ul>
				 			</s:else>
				 		</div>
					</div>		
				</div>
			</div>
		</form>
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
		<a class="menu-profile mui-tab-item" href="myProfile.htm">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</section>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>

<script type="text/javascript">
	
	$(".headImgEditBtn").click(editHeadImg);
	
	function editHeadImg(){
		var btnArray = ["重新上传","旋转90度"];
		mui.confirm('', "编辑头像", btnArray,
			function(e) {
				if (e.index == 0) {
					window.location.href="uploadHeadImg.htm?editId=<s:property value='#request.userInfo.userId'/>";
				}else if(e.index ==1){
					rotate();	
				}
			});
		$(".mui-popup").css("position","fixed");	
	}

	function rotate(){
	
		$("#img-rotate").off("click");
		mui.toast("正在处理请求...");

		var param = {
			"orientation":"right"
		}

		$.ajax({
			url : "weih5/rotateHeadImg.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {
				if(data == null){
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#upload-art-commit").click(uploadArt);
					$("#upload-art-commit").html("完 成");
				}
			
				var result = data["result"];
				var message = data["message"];

				if (result == "error") {
					if (message != "") {
						mui.alert(message);
					} else {
						mui.alert("参数错误，请稍候再试。");
					}
					$(".mui-popup").css("position", "fixed");
					$("#img-rotate").click(uploadArt);
				} else {
					mui.toast("旋转成功！");
					window.location.reload(); 
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#img-rotate").click(uploadArt);
			}
		});
	}
</script>

</body>