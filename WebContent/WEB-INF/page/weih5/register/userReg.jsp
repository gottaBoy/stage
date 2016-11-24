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
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<style type="text/css">
	input[type=color], input[type=date], input[type=datetime-local], input[type=datetime], input[type=email], input[type=month], input[type=number], input[type=password], input[type=search], input[type=tel], input[type=text], input[type=time], input[type=url], input[type=week], select, textarea{padding:10px 15px 10px 35px;}
</style>
</head>

<body style="background:#f2f2f2;">

	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">买家注册</h1>
	</header>
	<div class="mui-content reg_gz">
		<s:if test="#request.errormsg != null && #request.errormsg != ''">
			<p class="jwarning mui-icon mui-icon-info" style="margin-top:20px;">提示：<s:property value="#request.errormsg"/></p>
		</s:if>
		<form id='login-form' class="mui-input-group" action="doUserRegister.htm" method="post">
			<div class="mui-input-row"><em class="mui-icon mui-icon-phone"></em><input type="text" id="user-reg-phone" name="phoneNo" class="mui-input-clear mui-input h-tel" placeholder="请输入手机号"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-chatbubble"></em><input type="text" id="user-reg-valid" name="validCode" class="mui-input-clear mui-input" placeholder="请输入验证码"><a href="javascript:;" class="publish-yz com-pub" data-flag="true">发送验证码</a></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" id="user-reg-pwd" name="pwd" class="mui-input-clear mui-input" placeholder="请输入6-12位密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" id="user-reg-pwdConfirm" name="pwdConfirm" class="mui-input-clear mui-input" placeholder="请再次输入密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-email"></em><input type="text" id="user-reg-email" name="email" class="mui-input-clear mui-input h-mail" placeholder="请输入邮箱地址"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-person"></em><input type="text" id="user-reg-nickname" name="nickName" class="mui-input-clear mui-input h-mail" placeholder="请输入昵称"></div>
			<div class="agree">
				<div class="xieyi"><input type="checkbox" name="contract" id="huo-chk" checked="true"> 同意《注册协议》<a href="h5login.htm">已有账户？直接登录</a></div>
				<div><a href="javascript:void(0);" id="reg-btn" class="reg-btn">注 册</a></div>
			</div>
		</form>
	</div>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script type="text/javascript" charset="utf-8">

	var regTel = /^1[3|5|7|8|9]\d{9}$/; 
	var regMail =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

	$("#reg-btn").click(regCommit);
	
	function regCommit(){
		
		//validation
		var phone = $("#user-reg-phone").val();
		var valid = $("#user-reg-valid").val();
		var pwd = $("#user-reg-pwd").val();
		var pwdConfirm = $("#user-reg-pwdConfirm").val();
		var trimedPwd = (pwd == null ? "" : $.trim(pwd));
		var trimedPwdConfirm = (pwdConfirm == null ? "" : $.trim(pwdConfirm));
		
		var email = $("#user-reg-email").val();
		var nickName = $("#user-reg-nickname").val();
		var checked = $("#huo-chk").attr("checked");
		
		if(chkTel(phone)){
			mui.alert("请输入格式正确的手机号码.");
			return;
		}
		if(chkMail(email)){
			mui.alert("请输入格式正确的邮箱地址.");
			return;
		}
		if(trimedPwd == "" || trimedPwd != trimedPwdConfirm || trimedPwd.length < 6){
			mui.alert("请输入最少6位不含空格的密码，并且两次输入一致.");
			return;
		}
		if(valid == "" || $.trim(valid) == ""){
			mui.alert("请输入您收到的验证码.");
			return;
		}
		if(nickName == "" || $.trim(nickName) == ""){
			mui.alert("请输入一个昵称.");
			return;
		}
		if("checked" != checked){
			mui.alert("请同意《注册协议》.");
			return;
		}
		
/* 		console.info(phone);
		console.info(valid);
		console.info(pwd);
		console.info(pwdConfirm);
		console.info(email);
		console.info(nickName);
		console.info(checked); */
	
		$("#login-form").submit();
	}
	
	function chkTel(val){
		return !regTel.test(val);
	}

	function chkMail(val){
		return !regMail.test(val);
	}
</script>
</body>
</html>