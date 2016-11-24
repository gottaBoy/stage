<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<title>注册导航</title>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/h5assets/css/style.css" />
<body style="background:#fff;">

	<div class="sec_list">
		<h2>演艺需求方</h2>
		<ul class="list one">
			<a href="h5userReg.htm">
				<li><div class="img"><i class="img-box img" style="background-image: url(<%=request.getContextPath()%>/h5assets/images/maijia.png); background-size: cover;"></i><h4 class="d-title">买家</h4></div></li>
			</a>
		</ul>
		<h2>演艺供应方</h2>
		<ul class="list ">
			<a href="h5artReg.htm">
				<li><div class="img"><i class="img-box img" style="background-image: url(<%=request.getContextPath()%>/h5assets/images/yiren.png); background-size: cover;"></i><h4 class="d-title">艺人</h4></div></li>
			</a>
			<a href="h5bizReg.htm">
				<li><div class="img"><i class="img-box img" style="background-image: url(<%=request.getContextPath()%>/h5assets/images/company.png); background-size: cover;"></i></div><h4 class="d-title">演艺机构</h4></li>
			</a>
			<a href="h5broReg.htm">
				<li><div class="img"><i class="img-box img" style="background-image: url(<%=request.getContextPath()%>/h5assets/images/jingjiren.png); background-size: cover;"></i><h4 class="d-title">经纪人</h4></div></li>
			</a>
		</ul>
	</div>
</body>
</html>

<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script type="text/javascript">
	//remix.personNav();
	/* function h5artRegister(){
		window.location.href="h5artReg.htm";
	}
	
	function h5bizRegister(){
		window.location.href="h5bizReg.htm";
	}
	
	function h5broRegister(){
		window.location.href="h5broReg.htm";
	}
	
	function h5userRegister(){
		window.location.href="h5userReg.htm";
	} */
</script>