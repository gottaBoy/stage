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
<title>重设密码</title>
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
<style type="text/css">
	input[type=color], input[type=date], input[type=datetime-local], input[type=datetime], input[type=email], input[type=month], input[type=number], input[type=password], input[type=search], input[type=tel], input[type=text], input[type=time], input[type=url], input[type=week],input[type=radio], select, textarea{padding:10px 15px 10px 35px;}
</style>
<body style="background:#f2f2f2;">

	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">重设密码</h1>
	</header>
	<div class="mui-content reg_gz">
		<form id='loginx-form' class="mui-input-group">
			<div class="mui-input-row"><em class="mui-icon mui-icon-phone"></em><input id='retrieve-phone' type="text" class="mui-input-clear mui-input h-tel" placeholder="请输入手机号"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-chatbubble"></em><input id='retrieve-valid-code' type="text" class="mui-input-clear mui-input company-chk" placeholder="请输入短信验证码"><a href="javascript:;" class="publish-yz com-pub-retrieve" data-flag="true">发送验证码</a></div>
		</form>
		<form id='loginx-formx' class="mui-input-group">
			<div class="mui-input-row"><label>新密码</label><input id='retrieve-password' type="password" class="mui-input-clear mui-input" placeholder="请设置新密码"></div>
			<div class="mui-input-row"><label>确认密码</label><input id='retrieve-password-confirm' type="password" class="mui-input-clear mui-input" placeholder="请再次填入"></div>
		</form>
		<div class="mui-content-padded">
			<button id='retrieve-submit' class="mui-btn mui-btn-block mui-btn-primary">确认</button>
		</div>
	</div>
	
</body>
</html>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script type="text/javascript">
	
	var regTel = /^1[3|5|7|8|9]\d{9}$/; 
	var regMail =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	
	$('#retrieve-submit').click(onRetrieveSubmit);
	
	function onRetrieveSubmit(){
		var phone = $('#retrieve-phone').val();
		var validCode = $('#retrieve-valid-code').val();
		var password = $('#retrieve-password').val();
		var paaswordConfirm = $('#retrieve-password-confirm').val();
		
		var trimedPwd = (password == null ? "" : $.trim(password));
		var trimedPwdConfirm = (paaswordConfirm == null ? "" : $.trim(paaswordConfirm));
		
		if(chkTel(phone)){
			mui.alert("请输入格式正确的手机号码.");
			return;
		}
		if(trimedPwd == "" || trimedPwd != trimedPwdConfirm || trimedPwd.length < 6){
			mui.alert("请输入最少6位不含空格的密码，并且两次输入一致.");
			return;
		}
		if(validCode == "" || $.trim(validCode) == ""){
			mui.alert("请输入您收到的验证码.");
			return;
		}
		
		
		console.info(phone);
		console.info(validCode);
		console.info(password);
		console.info(paaswordConfirm);
		
		var param = {
			"phone":phone,
			"validCode":validCode,
			"password":trimedPwd,
			"passwordConfirm":trimedPwdConfirm
		}
		
		$("#retrieve-submit").off("click");
		$("#retrieve-submit").html("提交中...");
		mui.toast("正在处理请求...");
		
		$.ajax({
			url : "weih5/doRetrievePsd.htm",
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
					$("#retrieve-submit").click(onRetrieveSubmit);
					$("#retrieve-submit").html("确认");

				} else {
					mui.toast("重置密码成功！跳转至登录页...");
					window.location.href = "h5login.htm";
				}
			},
			error : function(data){
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#retrieve-submit").click(onRetrieveSubmit);
				$("#retrieve-submit").html("确认");
			}
		});
	}
	
	function chkTel(val){
		return !regTel.test(val);
	}

	function chkMail(val){
		return !regMail.test(val);
	}
</script>