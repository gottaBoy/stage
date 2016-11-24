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
<title>创建任务</title>
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

<a href="javascript:void(0);" class="add"><em class="mui-icon mui-icon-personadd"></em>添加角色</a>
<section class="mainBox top_h">
	<div class="main">
		<form action="#" method="post" id="form1">
		<div class="war" id="war"></div>
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
				 	<div class="cnt swiper-slide">
				 		<div class="role">
							
				 		</div>

				 		<div class="inp1 zong"><label>通告备注：</label><textarea id="totleMemo" class="tea1 bz-2"></textarea></div>		
						
	                    <div class="btnBox">
		                     <a href="javascript:void(0);" class="create-com publish">发布</a>
		                </div>
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

<div class="mask"></div>
<div class="popbox" style="display:none;">
	<span class="mui-icon mui-icon-close close-btn"></span>
	<p class="role-tile">角色</p>
	<div class="role-a" style="text-align:left;">
		<div class="t1"></div>
		<div class="t2"></div>
		<div class="t3"></div>
	</div>

	<div class="inp1 otherRoleInput" style="display: none;"><label>其他：</label><input type="text" class="ourset" disabled="disabled" placeholder='请输入角色'></div>
	<div class="inp1" style="overflow:hidden;"><label style="float:left;">性别：</label>
		<div class="in"><button id='showUserPicker' class="mui-btn mui-btn-block btn-black" type='button'>不限</button></div>
		<!-- <select id="sex" class="sex" name="sex"><option value="不限">不限</option><option value="男">男</option><option value="女">女</option></select> --></div>
	<div class="inp1"><label>人数：</label><input type="number" class="perNum"> <font style="color:orange">*</font></div>
	<div class="inp1"><label>预算：</label><input type="number" class="yen"> 元 <font style="color:orange">*</font></div>
	<div class="inp1"><label>角色要求：</label><textarea class="tea1 bz-1"></textarea></div>
	<div class="t-center special"><a href="javascript:void(0);" class="save-btn">保存</a></div>
</div>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<%-- <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data.js"></script> --%>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/roleList.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>

<script>
(function($, doc) {
	$.init();
	$.ready(function() {
		var userPicker = new $.PopPicker();
		userPicker.setData([{
			value: '1',
			text: '男'
		}, {
			value: '2',
			text: '女'
		},{
			value: '3',
			text: '不限'
		}]);
		var showUserPickerButton = doc.getElementById('showUserPicker');
		showUserPickerButton.addEventListener('tap', function(event) {
			userPicker.show(function(items) {
				showUserPicker.innerText = JSON.stringify(items[0]["text"]).replace(/\"/g, "");
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);
	});
})(mui, document);

</script>
</body>