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
<html xmlns:wb="http://open.weibo.com/wb">
<head>

<meta charset="UTF-8">
<title>创建通告</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.picker.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body>

<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active">
				 		<div class="inp1"><label>通告名称：</label><input type="text" id="x-name" placeholder="请填写通告名称">*</div>

				 		<div class="inp1"><label>通告时间：</label>
				 			<div class="in relative">
				 				<span class="date-rl"></span>
				 				<button id='s-date' data-options='{}' class="btn mui-btn mui-btn-block btn-black"><s:property value="#request.defaultDate"/></button></div>
				 		<!-- <div class="in"><input type="date" id="date-x1">
				 			<input type="text" id="s-date">
				 		</div> --> <font style="color:orange">*</font></div>

				 		<div class="inp1"><label>应征截止：</label>
				 			<div class="in relative">
				 				<span class="date-rl"></span>	
				 				<button id='e-date' data-options='{}' class="btn mui-btn mui-btn-block btn-black"><s:property value="#request.defaultDate"/></button></div>
				 		<!-- <div class="in"><input type="date" id="date-x2">
				 			<input type="text" id="e-date" >
				 		</div> --> <font style="color:orange">*</font></div>

<%-- 				 		<div class="inp1"><label>应征结束：</label>
				 			<div class="in relative">
				 				<span class="date-rl"></span>	
				 				<button id='e-date2' data-options='{}' class="btn mui-btn mui-btn-block"><s:property value="#request.defaultDate"/></button></div>
				 		<!-- <div class="in"><input type="date" id="date-x3">
				 			<input type="text" id="e-date2" >
				 		</div> --> *</div> --%>

				 		<div class="inp1 clearfix"><label>通告城市：</label>
				 			<div class="in"><button id='showCityPicker3' class="mui-btn mui-btn-block btn-black" type='button'>请选择城市...</button></div>
				 		</div>	
				 		<div class="inp1"><label>通告地点：</label><input type="text" id="x-address" placeholder="请填写通告的具体地址"> <font style="color:orange">*</font></div>			
						<div class="btnBox"><a href="javascript:void(0);" class="create-com nextPage">下一页</a></div>
					</div>		
				</div>
				
			</div>
		</form>
    </div>
    <nav class="mui-bar mui-bar-tab menu">
    	<a class="menu-biz-home mui-tab-item jump-alert" href="#">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</a>
		<a class="menu-biz-task mui-tab-item jump-alert" href="#">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item jump-alert mui-active" href="#">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item jump-alert" href="#">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</section>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/dateX.js"></script>
<%-- <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data.js"></script> --%>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
 
<script>
	(function($, doc) {
		$.init();
		$.ready(function() {
			var cityPicker3 = new $.PopPicker({
				layer: 3
			});
			cityPicker3.setData(cityData3);
			var showCityPickerButton = doc.getElementById('showCityPicker3');
			showCityPickerButton.addEventListener('click', function(event) {
				cityPicker3.show(function(items) {
					showCityPickerButton.innerText = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
					//返回 false 可以阻止选择框的关闭
					//return false;
				});
			}, false);
		});
	})(mui, document);
</script>
</body>