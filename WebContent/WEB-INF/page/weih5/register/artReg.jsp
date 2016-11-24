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
<title>注册</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.picker.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<style type="text/css">
	input[type=color], input[type=date], input[type=datetime-local], input[type=datetime], input[type=email], input[type=month], input[type=number], input[type=password], input[type=search], input[type=tel], input[type=text], input[type=time], input[type=url], input[type=week], select, textarea{padding:10px 15px 10px 35px;}
</style>
</head>

<body style="background:#f2f2f2;">

	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">艺人注册</h1>
	</header>
	<div class="mui-content reg_gz">
		<form id='login-form' class="mui-input-group">
			<div class="mui-input-row"><em class="mui-icon mui-icon-phone"></em><input type="text" id="art-phone" class="mui-input-clear mui-input h-tel" placeholder="请输入手机号"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-chatbubble"></em><input type="text" id="art-valid-code" class="mui-input-clear mui-input" placeholder="请输入验证码"><a href="javascript:;" class="publish-yz com-pub" data-flag="true">发送验证码</a></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" id="art-password" class="mui-input-clear mui-input" placeholder="请输入6-12位密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" id="art-password-confirm" class="mui-input-clear mui-input" placeholder="请再次输入密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-email"></em><input type="text" id="art-email" class="mui-input-clear mui-input h-mail" placeholder="请输入邮箱地址"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-person"></em><input type="text" name="art-name" id="art-name" class="mui-input-clear mui-input h-mail" placeholder="请输入昵称"></div>
			<div class="agree">
				<div class="xieyi"><input type="checkbox" id="art-huo-chk" checked="true"> 同意《注册协议》<a href="h5login.htm">已有账户？直接登录</a></div>
				<div><a href="#" class="reg-btn" id="art-reg-btn-next">下一步</a><div>
			</div>
		</form>
	</div>
</body>

<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/dateX.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/roleList.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/upload.js"></script> --%>

<script type="text/javascript">
	
	$("#art-reg-btn-next").click(artRegNext);
	
	function artRegNext() {

		var phoneNo = $("#art-phone").val();
		var validCode = $("#art-valid-code").val();
		var pwd = $("#art-password").val();
		var pwdConfirm = $("#art-password-confirm").val();
		var email = $("#art-email").val();
		var name = $("#art-name").val();
		var contract = $("#art-huo-chk").prop("checked");

/* 		console.info(phoneNo);
		console.info(validCode);
		console.info(pwd);
		console.info(pwdConfirm);
		console.info(email);
		console.info(name);
		console.info(contract); */

		// validation

		// invoke
		var param = {
			"phoneNo" : phoneNo,
			"validCode" : validCode,
			"pwd" : pwd,
			"pwdConfirm" : pwdConfirm,
			"email" : email,
			"name" : name,
			"contract" : contract
		}

		$("#art-reg-btn-next").off("click");
		$("#art-reg-btn-next").html("处理中...");
		mui.toast("正在处理请求...");

		$.ajax({
			url : "weih5/doArtRegisterStep1.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {
				var result = data["result"];
				var message = data["message"];

				if (result == "error") {
					if (message != "") {
						mui.alert(message);
					} else {
						mui.alert("参数错误，请稍候再试。");
					}
					$(".mui-popup").css("position", "fixed");
					$("#art-reg-btn-next").click(artRegNext);
					$("#art-reg-btn-next").html("下一步");

				} else {
					mui.toast("正在跳转到下一步");
					window.location.href = "h5artRegStep2.htm";
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#art-reg-btn-next").click(artRegNext);
				$("#art-reg-btn-next").html("下一步");
			}
		});
	}
</script>
</html>