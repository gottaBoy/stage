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
<title>编辑企业信息</title>
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
		<h1 class="mui-title">编辑企业信息</h1>
	</header> -->
	<div class="mui-content reg_gz">
		<form id='biz-login-form' class="mui-input-group h-company">
			<div style="display:none" id="editBizUserId"><s:property value="#request.editUserInfo.userId"></s:property></div>
			<!-- <div class="mui-input-row"><em class="tel"></em><input type="text" name="phoneNo" id="biz-phone" class="mui-input-clear mui-input h-tel" placeholder="请输入手机号"></div>
			<div class="mui-input-row"><em class="chk"></em><input type="text" name="validCode" id="biz-valid-code" class="mui-input-clear mui-input" placeholder="请输入邀请码"></div>
			<div class="mui-input-row"><em class="psw"></em><input type="password" name="pwd" id="biz-pwd" class="mui-input-clear mui-input" placeholder="请输入6-12位密码"></div>
			<div class="mui-input-row"><em class="psw"></em><input type="password" name="pwdConfirm" id="biz-pwd-confirm" class="mui-input-clear mui-input" placeholder="请再次输入密码"></div>
			<div class="mui-input-row"><em class="eml"></em><input type="text" name="email" id="biz-email" class="mui-input-clear mui-input h-mail" placeholder="请输入邮箱地址"></div> -->
			<div class="mui-input-row service"><label><strong>基本信息</strong></label></span></div>
			<div class="mui-input-row"><label>公司名称</label><input type="text" class="mui-input-clear mui-input cname" id="biz-name" value="<s:property value='#request.editUserInfo.nickName'/>" placeholder="请输入公司名称"></div>
			<div class="mui-input-row"><label>所在地</label><input type="text" readonly="readonly" class="mui-input-clear mui-input  btn-black caddress" id="biz-address" placeholder="选择所在地" value="<s:property value='#request.editUserInfo.provice'/> <s:property value='#request.editUserInfo.city'/> <s:property value='#request.editUserInfo.place'/>"></div>
			<div class="mui-input-row txta"><label>简介</label><textarea class="txt_area"><s:property value="#request.editUserInfo.introduction"/></textarea></div>
			<div class="mui-input-row service"><label><strong>服务内容</strong></label><span>(至少选择1项)</span></div>

			<div class="mui-input-row rowList">
				<s:iterator value="#request.tagMap">
					<s:if test="value != ''">
						<span class="active"><s:property value="key"/></span>
					</s:if>
					<s:else>
						<span><s:property value="key"/></span>
					</s:else>
				</s:iterator>
			</div>

			<div class="agree upload_sc">
				<div style="margin-top:10px;">
					<a href="javascript:void(0);" class="reg-btn company-com" id="company-edit-commit">完 成</a>
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
		<a class="menu-task mui-tab-item jump-alert" href="#">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item jump-alert" href="#">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>



<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/upload.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/unload_sc.js"></script>
<script type="text/javascript" charset="utf-8">

	$("#company-edit-commit").click(companyEditCommit);
	
	function companyEditCommit(e) {

		var editId = $("#editBizUserId").text();
		var name = $("#biz-name").val();
		var address = $("#biz-address").val();
		var services = [];
		var $aList = $(".rowList").find("span");
		for (var i = 0; i < $aList.size(); i++) {
			if ($aList.eq(i).hasClass("active")) {
				services.push($aList.eq(i).html());
			}
		}

		var intro = $(".txt_area").val();

		// validation
		
		// invoke
		var param = {
			"editId" : editId,
			"name" : name,
			"address" : address,
			"services" : JSON.stringify(services),
			"intro" : intro
		}

		$("#company-edit-commit").off("click");
		$("#company-edit-commit").html("处理中...");
		mui.toast("正在处理请求...");

		$.ajax({
			url : "weih5/bizEditCommit.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {
				
				if(data == null){
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#company-edit-commit").click(companyEditCommit);
					$("#company-edit-commit").html("完 成");
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
					$("#company-edit-commit").click(companyEditCommit);
					$("#company-edit-commit").html("完 成");

				} else {
					mui.toast("保存成功!");
					window.location.href = "myProfile.htm";
				}
			},
			error : function(data){
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#company-edit-commit").click(companyEditCommit);
				$("#company-edit-commit").html("完 成");
			}
		});
	}
	
</script>
<script>
	(function($, doc) {
		$.init();
		$.ready(function() {
			var bizRegCityPicker = new $.PopPicker({
				layer: 3
			});
			bizRegCityPicker.setData(cityData3);
			var bizRegCityPickerButton = doc.getElementById('biz-address');
			bizRegCityPickerButton.addEventListener('click', function(event) {
				bizRegCityPicker.show(function(items) {
					bizRegCityPickerButton.value = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
					//返回 false 可以阻止选择框的关闭
					//return false;
				});
			}, false);
		});
	})(mui, document);
</script>

</body>
</html>