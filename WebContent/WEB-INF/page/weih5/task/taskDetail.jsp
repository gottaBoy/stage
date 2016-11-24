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
<title>通告详情</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body>
<%TAppTask userTask=(TAppTask)request.getAttribute("userTask");%>
<%SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH"); 
	Date applyStart = userTask.getApplyStartDate();
	Date applyEnd = userTask.getApplyEndDate();
	
	String applyStartDisplay = applyStart != null ? df.format(applyStart) : "";
	String applyEndDisplay = applyEnd != null ? df.format(applyEnd) : "";
%>
<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active det">
				 		<div class="inp1"><label>通告名称：</label> <span class="act-det"><%=userTask.getTitle() %></span></div>
				 		<div class="inp1"><label>通告时间：</label> <span class="act-det"><%=userTask.getStartDate() %></span></div>
				 		<div class="inp1"><label>应征时间：</label> <span class="act-det"><%=applyStartDisplay %></span> </div>
				 		<div class="inp1"><label>通告城市：</label> <span class="act-det"><%=userTask.getProvice() %> <%=userTask.getCity() %></span></div>	
				 		<div class="inp1"><label>通告地点：</label> <span class="act-det"><%=userTask.getPlace() %></span></div>
				 		<div class="inp1"><label>备注：</label> <span class="act-det"><%=userTask.getContent() %></span></div>				
						<div class="role-list">
							<strong>角色列表</strong>
							<ul>
							
							<s:iterator value="#request.userTaskRole" var="item" status="st">
								<li class="list">
									<div class="role-title">
										<span><s:property value="#item.briefRoleName"/></span>
										<span><s:property value="#item.roleNum"/>人(<s:property value="#item.sex"/>)</span>
										<span><s:property value="#item.priceLow"/>元/人</span>
										<s:if test="#item.isReady == 0">
											<a style="height:1.5rem" href="javascript:;" class="yz disable" data-task-id='<s:property value="#item.taskId"/>' data-role-id='<s:property value="#item.roleId"/>'>已应征</a>
										</s:if>
										<s:elseif test="#item.isReady == -1">
											<a style="height:1.5rem" href="javascript:;" class="yz disable" data-task-id='<s:property value="#item.taskId"/>' data-role-id='<s:property value="#item.roleId"/>'>已被拒绝</a>
										</s:elseif>
										<s:else>
											<a style="height:1.5rem" href="javascript:;" class="yz" data-task-id='<s:property value="#item.taskId"/>' data-role-id='<s:property value="#item.roleId"/>'>应征</a>
										</s:else>
									</div>
									<div>角色要求：<s:property value="#item.memo"/></div>
								</li>
							</s:iterator> 
							</ul>
						</div>
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