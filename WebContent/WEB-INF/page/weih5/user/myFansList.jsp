<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>我的粉丝</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<style type="text/css">
	.mui-slider .mui-slider-group .mui-slider-item img{width: 100% !important}
</style>
</head>
<body>
	<div class="works">
		<ul class="mui-table-view mui-table-view-chevron" style="margin-top:0;">
			<s:iterator value="#request.fans" var="item" status="st">
			<li class="mui-table-view-cell mui-media">
				<a class="mui-navigate-right" href="artistDetail.htm?userId=<s:property value="#item.userId"/>">
					<img class="mui-media-object mui-pull-left" src="http://www.d15t.com/stageUpload/headImage/<s:property value="#item.userId"/>.png">
					<div class="mui-media-body">
						<s:property value="#item.nickName"/>
						<p class='mui-ellipsis'><s:property value="#item.tags"/></p>
					</div>
				</a>
			</li>
		 	</s:iterator>
		</ul>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	</script>
</body>
</html>