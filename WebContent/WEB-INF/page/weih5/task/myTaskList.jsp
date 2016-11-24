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
<title>我创建的通告列表</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body>
<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active">
				 		
				 		<s:iterator value="#request.userTaskList" var="item" status="st">
				 		<div class="list-x">
			 				<a href="taskDetail.htm?taskId=<s:property value="#item.id"/>">
			 					<h2><s:property value="#item.title" /></h2>
			 					<span>已应征<s:property value="#item.personCount" />人</span>
			 					<span class="tcenter">
			 						<s:property value="#item.displayCreateDate" />
			 					</span>
			 					<s:if test="#item.status == '已关闭'"> <span class="tright" style="color:gray;"><s:property value="#item.status" /></span></s:if>
                                <s:elseif test="#item.status == '审核中'"><span class="tright" style="color:green;"><s:property value="#item.status" /></span></s:elseif>
                                <s:elseif test="#item.status == '已发布'"><span class="tright" style="color:orange;"><s:property value="#item.status" /></span></s:elseif>
								<s:else><span class="tright"><s:property value="#item.status" /></span></s:else>
			 					
			 				</a>
			 			</div>
				 		</s:iterator>
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

<!-- <a href="createH5Task.htm" class="newAdd" style="font-size:14px;bottom:60px;">新通告</a> -->
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
</body>