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
		<h1 class="mui-title">经纪人注册</h1>
	</header>
	
	<div class="mui-content reg_gz">
		<form id='login-form' class="mui-input-group">
		
			<%-- <div class="mui-input-row h-portrait">
				<label>头像</label> 
				<div class="w-text">
	 				<div class="imgload">
					    <div class="imgview  adDWXBgIMG  margin-top-20">
					        <span><img id="img" src="/stage01/h5assets/images/cross.png"></span>
					    </div>
					    <div id="error" class="help-block text-center"></div>
					    <div class="btn-box margin-top-20">
					        <div class="btn-block blue border fileinput-button">
					        	<input type="button" value="选择文件" class="sel-btn">
					            <input type="file" accept = "image/*; capture=camera" value="" id="testmm"/>
					            <input type="hidden" id="imgurl">
					        </div>
					    </div>
					</div>  
	 			</div>
			</div> --%>

			<div class="mui-input-row"><em class="mui-icon mui-icon-phone"></em><input type="text" id="bro-phone" name="phoneNo" class="mui-input-clear mui-input h-tel" placeholder="请输入手机号"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-chatbubble"></em><input type="text" id="bro-valid-code" name="validCode" class="mui-input-clear mui-input" placeholder="请输入验证码"><a href="javascript:;" class="publish-yz com-pub" data-flag="true">发送验证码</a></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" id="bro-password" name="pwd" class="mui-input-clear mui-input" placeholder="请输入6-12位密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" id="bro-password-confirm" name="pwdConfirm" class="mui-input-clear mui-input" placeholder="请再次输入密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-email"></em><input type="text" id="bro-email" name="email" class="mui-input-clear mui-input h-mail" placeholder="请输入邮箱地址"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-person"></em><input type="text" id="bro-name" class="mui-input-clear mui-input jjr-nc" placeholder="请输入昵称"></div>
<!-- 			<div class="mui-input-row"><label>名称</label><input type="text" class="mui-input-clear mui-input jjr-name" placeholder="请输入名称"></div>
			<div class="mui-input-row"><label>邮箱</label><input type="text" class="mui-input-clear mui-input jjr-mail" placeholder="请再次邮箱"></div> -->
			<div class="mui-input-row"><em class="mui-icon mui-icon-location"></em><input type="text" readonly="readonly" class="mui-input-clear mui-input caddress" id="bro-address" placeholder="选择所在地"></div>
			<div class="mui-input-row txta"><label>简介</label><textarea class="txt_area"></textarea></div>
			<div class="agree">
				<p class="jwarning mui-icon mui-icon-info">少于5个艺人不能应征不能发任务！</p>
				<!-- <p class="jwarning">提示: 少于5个艺人，不能应征通告！</p>  -->
				<div class="xieyi" style="margin-top:20px;"><input type="checkbox" name="contract" id="bro-huo-chk" checked="true"> 同意《注册协议》<a href="h5login.htm">已有账户？直接登录</a></div>
				<div><a href="#" class="reg-btn jjr-btn" id="jjr-btn">注 册</a><div>
			</div>
		</form> 
	</div>

	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script> 
<%-- 	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/upload.js"></script> --%>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/unload_sc.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/register.js"></script>
	<script type="text/javascript">
	
		//经纪人注册提交
		$("#jjr-btn").on("click", regCommit);

		function regCommit() {
			
			var phoneNo = $("#bro-phone").val();
			var validCode = $("#bro-valid-code").val();
			var pwd = $("#bro-password").val();
			var pwdConfirm = $("#bro-password-confirm").val();
			var email = $("#bro-email").val();
			var name = $("#bro-name").val();
			var intro = $(".txt_area").val();
			var contract = $("#bro-huo-chk").prop("checked");
			var address = $("#bro-address").val();

			/* console.info(phoneNo);
			console.info(validCode);
			console.info(pwd);
			console.info(pwdConfirm);
			console.info(email);
			console.info(name);
			console.info(intro);
			console.info(contract); */
			
			// validation

			// invoke
			var param = {
				"phoneNo":phoneNo,
				"validCode":validCode,
				"pwd":pwd,
				"pwdConfirm":pwdConfirm,
				"email":email,
				"name":name,
				"intro":intro,
				"contract":contract,
				"address" : address
			}
			
			$("#jjr-btn").off("click");
			$("#jjr-btn").html("注册中...");
			mui.toast("正在处理请求...");
			
			$.ajax({
				url : "weih5/doBroRegister.htm",
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
						$("#jjr-btn").click(regCommit);
						$("#jjr-btn").html("注 册");

					} else {
						mui.toast("注册成功!");
						window.location.href = "myProfile.htm";
					}
				},
				error : function(data) {
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#jjr-btn").click(regCommit);
					$("#jjr-btn").html("注 册");
				}
			});
		}
	</script>

<script>
	(function($, doc) {
		$.init();
		$.ready(function() {
			var broRegCityPicker = new $.PopPicker({
				layer: 3
			});
			broRegCityPicker.setData(cityData3);
			var broRegCityPickerButton = doc.getElementById('bro-address');
			broRegCityPickerButton.addEventListener('click', function(event) {
				broRegCityPicker.show(function(items) {
					broRegCityPickerButton.value = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
					//返回 false 可以阻止选择框的关闭
					//return false;
				});
			}, false);
		});
	})(mui, document);
</script>
	
</body>

</html>














