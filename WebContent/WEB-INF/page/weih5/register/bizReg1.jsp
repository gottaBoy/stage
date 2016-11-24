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
<html lang="zh-CN" xmlns:wb="http://open.weibo.com/wb">
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
		<h1 class="mui-title">演艺机构注册</h1>
	</header>
	<div class="mui-content reg_gz">
		<form id='biz-login-form' class="mui-input-group h-company" action="doBizRegister.htm" method="post">
		<div class="mui-input-row"><em class="mui-icon mui-icon-phone"></em><input type="text" name="phoneNo" id="biz-phone" class="mui-input-clear mui-input h-tel" placeholder="请输入手机号"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-chatbubble"></em><input type="text" name="validCode" id="biz-valid-code" class="mui-input-clear mui-input" placeholder="请输入验证码"><a href="javascript:;" class="publish-yz com-pub" data-flag="true">发送验证码</a></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" name="pwd" id="biz-pwd" class="mui-input-clear mui-input" placeholder="请输入6-12位密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-locked"></em><input type="password" name="pwdConfirm" id="biz-pwd-confirm" class="mui-input-clear mui-input" placeholder="请再次输入密码"></div>
			<div class="mui-input-row"><em class="mui-icon mui-icon-email"></em><input type="text" name="email" id="biz-email" class="mui-input-clear mui-input h-mail" placeholder="请输入邮箱地址"></div>
			<div class="mui-input-row service"><label><strong>基本信息</strong></label></span></div>
			<div class="mui-input-row"><label>公司名称</label><input type="text" name="name" class="mui-input-clear mui-input cname" id="biz-name" placeholder="请输入公司名称"></div>
			<div class="mui-input-row"><label>所在地</label><input type="text" name="address" readonly="readonly" class="mui-input-clear mui-input caddress" id="biz-address" placeholder="选择所在地"></div>
			<div class="mui-input-row txta"><label>简介</label><textarea type="text" name="intro" class="txt_area"></textarea></div>
			<div class="mui-input-row service"><label><strong>服务内容</strong></label><span>(至少选择1项)</span></div>

			<div class="mui-input-row rowList">
				<span>广告|公关</span>
				<span>婚庆|会展</span>
				<span>演艺</span>
				<span>剧团</span>
				<span>影视制作</span>
				<span>文化传媒</span>
				<span>多媒体</span>
				<span>幕后制作</span>
				<span>动漫</span>
			</div>
            <input type="hidden" name="services" />
            
			<div class="mui-input-row service"><label><strong>上传两证</strong></label></div>

			<div class="agree upload_sc">
				<div class="w-west-outer">
					<div class="w-text">
		 				<div class="imgload">
						    <div class="imgview  adDWXBgIMG  margin-top-20">
						        <%-- <span><img id="img" src="/stage01/h5assets/images/cross.png"></span> --%>
						        <!--<span class="mui-icon mui-icon-camera"></span>-->
						        <span><img id="img" src="<%=request.getContextPath() %>/h5assets/images/camera.png"></span>
						        <p>营业执照</p>
						    </div>
						    <div id="error" class="help-block text-center"></div>
						    <div class="btn-box margin-top-20">
						        <div class="btn-block blue border fileinput-button">
						        	<input type="button" value="选择文件" class="sel-btn">
						            <input type="file" accept = "image/*; capture=camera" value="" id="testmm"/>
						            <input type="hidden" id="imgurl">
						            
						            <!-- <input type="hidden" name="bizLisPicName" />
						            <input type="hidden" name="userIdPic" /> -->
						        </div>
						    </div>
						</div>  
		 			</div>

		 			<div class="w-text">
		 				<div class="imgload">
						    <div class="imgview  adDWXBgIMG  margin-top-20">
						        <%-- <span><img id="imgx" src="/stage01/h5assets/images/cross.png"></span> --%>
						        <!--<span class="mui-icon mui-icon-camera"></span>-->
						        <span><img id="imgx" src="<%=request.getContextPath() %>/h5assets/images/camera.png"></span>
						        <p>身份证</p>
						    </div>
						    <div id="errorx" class="help-block text-center"></div>
						    <div class="btn-box margin-top-20">
						        <div class="btn-block blue border fileinput-button">
						        	<input type="button" value="选择文件" class="sel-btn">
						            <input type="file" accept = "image/*; capture=camera" value="" id="testme"/>
						            <input type="hidden" id="imgurlx">
						            
						            <!-- <input type="hidden" name="userIdPicName" />
						            <input type="hidden" name="userIdPic" /> -->
						        </div>
						    </div>
						</div>  
		 			</div>
				</div>
				
				<div class="h-descript">(图片清晰，图片为正方形，平台为用户保密)</div>
				<div style="margin-top:20px;">
					<div class="xieyi"><input type="checkbox" name="contract" id="biz-huo-chk" checked="true" value="true"> 同意《注册协议》<a href="h5login.htm">已有账户？直接登录</a></div>
					<a href="javascript:void(0);" class="reg-btn company-com" id="company-com">注 册</a>
				</div>
			</div>
		</form>
	</div>

<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/upload.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/unload_sc.js"></script>
<script type="text/javascript" charset="utf-8">
	sc("#testmm", "#img", "#error");
	sc("#testme", "#imgx", "#errorx");

	$("#company-com").click(regCommit);
	function regCommit(e) {
		var phoneNo = $("#biz-phone").val();
		var validCode = $("#biz-valid-code").val();
		var pwd = $("#biz-pwd").val();
		var pwdConfirm = $("#biz-pwd-confirm").val();
		var email = $("#biz-email").val();

		var name = $("#biz-name").val();
		var address = $("#biz-address").val(); 
		var services = [];
		//var services = '';
		var $aList = $(".rowList").find("span");
		for (var i = 0; i < $aList.size(); i++) {
			if ($aList.eq(i).hasClass("active")) {
				services.push($aList.eq(i).html());
				//services += $aList.eq(i).html()+",";
			}
		}
		//services = services.substring(0,services.length-1);
		//$('input[name=services]').val(services);

		var contract = $("#biz-huo-chk").prop("checked");

		var bizLisPic = $("#testmm").data("imagedata");
		var bizLisPicName = $("#testmm").data("imagename");
		//$('input[name=bizLisPic]').val(bizLisPic);
		//$('input[name=bizLisPicName]').val(bizLisPicName);
		
		var userIdPic = $("#testme").data("imagedata");
		var userIdPicName = $("#testme").data("imagename");
		//$('input[name=userIdPic]').val(userIdPic);
		//$('input[name=userIdPicName]').val(userIdPicName);
		
		var intro = $(".txt_area").val();
		// validation
 
		// invoke
		var param = {
			"phoneNo" : phoneNo,
			"validCode" : validCode,
			"pwd" : pwd,
			"pwdConfirm" : pwdConfirm,
			"email" : email,
			"name" : name,
			"address" : address,
			"services" : JSON.stringify(services),
			"contract" : contract,
			"bizLisPic" : bizLisPic,
			"userIdPic" : userIdPic,
			"bizLisPicName" : bizLisPicName,
			"userIdPicName" : userIdPicName,
			"intro" : intro
		}

		$("#company-com").off("click");
		$("#company-com").html("注册中...");
		mui.toast("正在处理请求...");
		
		$.ajax({
			//async:false,//是否异步  
            // cache:false,//是否使用缓存  
            //contentype:false,
            //processData:false,
			url : "weih5/doBizRegister.htm",//http://61.152.104.157:8080/
			//url : "http://192.168.0.104:8080/stage01/weih5/doBizRegister.htm",
			type : 'POST',
			//type : 'GET',
			dataType : 'json',
			//contentType:"application/json;charset=utf-8",
			//contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			data : param,//$('#biz-login-form').serialize(),//param, //JSON.stringify(param),
			//data:dataStr,
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
					$("#company-com").click(regCommit);
					$("#company-com").html("注 册");

				} else {
					mui.toast("注册成功!");
					window.location.href = "myProfile.htm";
				}
			},
			error : function(data){
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#company-com").click(regCommit);
				$("#company-com").html("注 册");
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