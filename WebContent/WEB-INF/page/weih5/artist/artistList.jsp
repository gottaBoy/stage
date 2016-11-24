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
<title>艺人列表</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/app.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.picker.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body>

artist list page...

<!-- demo part -->

this is a test jsp;;;
<div id="test">123</div>

<input id="testBtn" type="button">btn!!
</body>


<script>

console.info("123");
console.info($("#test").text());

$("#testBtn").click(function(){

	var roleItem = {
		"roleName":"roleName123",
		"roleDesc":"roleDesc123",
		"roleNum":"roleNum123",
		"price":"price123",
		"sex":"sex123",
		"memo":"memo123"
	}

	var roleArray = new Array();
	roleArray.push(roleItem);// = roleItem;

	var savingTask = {
		"title":"title123",
		"startDate":"2015-11-12 9",
		"roleList":JSON.stringify(roleArray)
	};
	
	console.info(savingTask);
	
	$.ajax({
		url:"<%=request.getContextPath() %>/weih5/saveOrUpdateTask.htm",
		type:'POST',
		dataType:'json',
		data: savingTask,
		success:function(data){
			console.info("success 200=====");
			console.info(data);	
			var result = data["result"];
			var message = data["message"];
			console.info(result);
			console.info(message);
		}
	});
});



</script>