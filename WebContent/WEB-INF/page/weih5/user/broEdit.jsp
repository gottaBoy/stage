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
<title>编辑经纪人信息</title>
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
	
<!-- 	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">经纪人注册</h1>
	</header> -->
	
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
			<div style="display:none" id="editBroUserId"><s:property value="#request.editUserInfo.userId"></s:property></div>
			<div class="mui-input-row"><label>昵称</label><input type="text" id="bro-name" class="mui-input-clear mui-input jjr-nc" value="<s:property value='#request.editUserInfo.nickName'/>" placeholder="请输入昵称"></div>
			<div class="mui-input-row"><label>所在地</label><input type="text" readonly="readonly" class="mui-input-clear mui-input caddress" id="bro-address" placeholder="选择所在地" value="<s:property value='#request.editUserInfo.provice'/> <s:property value='#request.editUserInfo.city'/> <s:property value='#request.editUserInfo.place'/>"></div>
			<div class="mui-input-row txta"><label>简介</label><textarea class="txt_area"><s:property value="#request.editUserInfo.introduction"/></textarea></div>
			<div class="agree">
				<div><a href="#" class="reg-btn jjr-btn" id="bro-edit-commit">完 成</a><div>
			</div>
		</form> 
	</div>
	
	<nav class="mui-bar mui-bar-tab menu">
		<a class="menu-biz-home mui-tab-item jump-alert">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</a>
		<a class="menu-biz-task mui-tab-item jump-alert">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item jump-alert">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item jump-alert">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>

<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script> 
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<%-- 	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/upload.js"></script> --%>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/unload_sc.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/register.js"></script>
	<script type="text/javascript">
	
		//经纪人注册提交
		$("#bro-edit-commit").on("click", broEditCommit);

		function broEditCommit() {
			var editId = $("#editBroUserId").text();
			var name = $("#bro-name").val();
			var intro = $(".txt_area").val();
			var address = $("#bro-address").val();

			// validation

			// invoke
			var param = {
				"editId" : editId,
				"name" : name,
				"intro" : intro,
				"address" : address
			}
			
			$("#bro-edit-commit").off("click");
			$("#bro-edit-commit").html("注册中...");
			mui.toast("正在处理请求...");
			
			$.ajax({
				url : "weih5/broEditCommit.htm",
				type : 'POST',
				dataType : 'json',
				data : param,
				success : function(data) {
					if(data == null){
						mui.alert("参数错误，请稍候再试。");
						$(".mui-popup").css("position", "fixed");
						$("#bro-edit-commit").click(broEditCommit);
						$("#bro-edit-commit").html("完 成");
					}
				
					var result = data["result"];
					var message = data["message"];

					if (result == "error") {
						if (message != "") {
							mui.alert(message);
						} else {
							mui.alert("参数错误，请稍候再试。");
						}
						$(".mui-popup").css("position", "fixed");
						$("#bro-edit-commit").click(broEditCommit);
						$("#bro-edit-commit").html("完 成");

					} else {
						mui.toast("修改成功!");
						window.location.href = "myProfile.htm";
					}
				},
				error : function(data) {
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#bro-edit-commit").click(broEditCommit);
					$("#bro-edit-commit").html("完 成");
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














