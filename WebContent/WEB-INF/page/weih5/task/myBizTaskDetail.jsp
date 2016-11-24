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
<title>委托详情</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body>
<%TAppTask userTask=(TAppTask)request.getAttribute("bizTaskDetail");%>
<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active det">
				 		<div class="inp1"><label>活动名称：</label> <span class="act-det"><%=userTask.getTitle() %></span></div>
				 		<div class="inp1"><label>开始时间：</label> <span class="act-det"><%=userTask.getStartDate() %></span></div>
				 		<div class="inp1"><label>结束时间：</label> <span class="act-det"><%=userTask.getEndDate() %></span> </div>
<%-- 				 		<div class="inp1"><label>活动城市：</label> <span class="act-det"><%=userTask.getProvice() %> <%=userTask.getCity() %></span></div>	 --%>
				 		<div class="inp1"><label>活动地点：</label> <span class="act-det"><%=userTask.getProvice() %> <%=userTask.getCity() %> <%=userTask.getPlace() %></span></div>
				 		<div class="inp1"><label>活动预算：</label> <span class="act-det"><%=userTask.getPrice() %></span></div>
				 		<div class="inp1"><label>活动人数：</label> <span class="act-det"><%=userTask.getPersonCount() %></span></div>
				 		<div class="inp1"><label>联系方式：</label> <span class="act-det"><%=userTask.getMobile() %></span></div>
				 		<div class="inp1"><label>备注：</label> <span class="act-det"><%=userTask.getContent() %></span></div>				
					</div>		
				</div>
			</div>
		</form>
    </div>
    <nav class="mui-bar mui-bar-tab menu">
    	<a class="menu-biz-home mui-tab-item" href="#">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</a>
		<a class="menu-biz-task mui-tab-item" href="#">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item" href="#">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item" href="#">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</section>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>

</body>