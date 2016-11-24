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
<title>登录</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />


<body style="background:#f2f2f2;">
<div class="mui-content" style="text-align: center;">
		<!-- <img style="width:100px; margin-top:16px; margin-bottom:16px; id="img" src="/stage01/h5assets/images/logot1.png"> -->
		<img style="width:100px; margin-top:16px; margin-bottom:16px; id="img" src="<%=request.getContextPath() %>/h5assets/images/logot1.png">
		<form id='login-form' method="post" action="weih5/doLogin.htm" class="mui-input-group">
			<div class="mui-input-row">
				<label>账号</label>
				<input id='account' name="account" type="text" class="mui-input-clear mui-input" placeholder="请输入手机号/邮箱">
			</div>
			<div class="mui-input-row">
				<label>密码</label>
				<input id='password' name="password" type="password" class="mui-input-clear mui-input" placeholder="请输入密码">
			</div>
			<div style="display:none">
				<input id="ref" name="ref" type="text" readonly="readonly" value='<s:property value="#request.ref"></s:property>'>
			</div>
		</form>

		<div class="mui-content-padded">
			<button id='login' class="mui-btn mui-btn-block mui-btn-primary" style="color:#FFFFFF">登录</button>
			<div class="link-area"><a id='reg' href="h5register.htm">注册账号</a> <span class="spliter">|</span> <a id='forgetPassword' href="h5retrievePsd.htm">忘记密码</a> <span class="spliter">|</span> <a id='reg' href="h5IndexPage.htm">访问首页</a></div>
		</div>
	</div>

<!-- 	<div class="qq-weixin">
		<a href="#">QQ登录</a>
		<a href="#">微信登录</a>
	</div> -->
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script> 
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
	<script src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
	<script type="text/javascript">
		var oLogin = document.getElementById("login");
		oLogin.addEventListener('click', function() {
		
			// check input
			var account = $("#account").val();
			var password = $("#password").val();
			
			console.info(account);
			console.info(password);
			
			if(account == null || account == undefined || account == ""){
				mui.toast("请输入用户名");
				return;
			}
			if(password == null || password == undefined || password == ""){
				mui.toast("请输入密码");
				return;
			}
			
			var userInfo = {
				account : account,
				password : password
			};

			mui.toast("登录中...");

			$.ajax({
				url : "weih5/checkLoginUser.htm",
				type : 'POST',
				dataType : 'json',
				data : userInfo,
				success : function(data) {
					var result = data["result"];
					var message = data["message"];

					if(result == "error"){
						// error action
						if( message != ""){
							mui.alert(message);
						} else {
							mui.alert("参数错误，请稍候再试。");
						}
						
						//unlock
					} else {
						$("#login-form").submit();
					}
				}
			});
		});
	</script>
</body>