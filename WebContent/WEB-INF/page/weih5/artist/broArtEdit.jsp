<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>

<meta charset="UTF-8">
<title>编辑艺人信息</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.picker.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />
</head>
<body>

<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active artist">
				 		<ul class="list">
				 			<div style="display:none" id="editArtUserId"><s:property value="#request.editUserInfo.userId"></s:property></div>
				 			<li><div class="inp1"><label>艺名：</label><input type="text" 
				 			<s:if test="#request.editUserInfo.nickName != ''">
				 				value="<s:property value="#request.editUserInfo.nickName"/>"
				 			</s:if> class="artname cname"> <font style="color:orange">*</font></div></li>
				 			<li><div class="inp1"><label>性别：</label><div class="in">
				 				<button id='showUserPicker' class="mui-btn mui-btn-block  btn-black csex" type='button'><s:if test="#request.editUserInfo.sex == 1">男</s:if><s:elseif test="#request.editUserInfo.sex == 2">女</s:elseif><s:elseif test="#request.editUserInfo.sex == 3">组合</s:elseif></button></div> <font style="color:orange">*</font></div></li>
				 			<li><div class="inp1"><label>出生年月：</label> <div class="in relative">
						 			<span class="date-rl"></span>
						 			<button id='demo1' data-options='{"type":"date","beginYear":1920,"endYear":2020}' class="btn mui-btn mui-btn-block btn-black cbrith"><s:property value="#request.editUserInfo.birthday"/></button>
						 		</div> 
			 				<font style="color:orange">*</font></div></li>
				 			<li><div class="inp1"><label>所在地：</label> <div class="in"><button id='showCityPicker' class="mui-btn mui-btn-block btn-black caddress" type='button'><s:property value="#request.editUserInfo.provice"/> <s:property value="#request.editUserInfo.city"/> <s:property value="#request.editUserInfo.place"/></button> </div></div></li>
				 		</ul>

				 		<div class="artistprice role-mes">
				 			<h3><strong>才艺价格</strong><span>(最多添加5个)</span></h3>
				 			
							<s:iterator value="#request.costList" var="item" status="status">
				 				<div class="role-mess rle-A clearfix" bNum = "<s:property value="#status.index"/>" bclick="false"><div><span added=true><s:property value="#item.keywords"/></span> <span><s:property value="#item.bprice"/>元/<s:property value="#item.unit"/></span></div></div>
				 			</s:iterator>
				 			
				 			<s:iterator begin="0" end="4-#request.costListCount" var="item" status="st">
				 				<div class="role-mess rle-A clearfix" bNum = "<s:property value='#request.costListCount + #st.index'/>"><span>请添加角色..<span> <a href="javascript:void(0);">+</a></div>
				 			</s:iterator>
				 		</div>

				 		<div class="tcenter mb10">
				 			<a href="javascript:void(0);" id="art-edit-commit" style="background-color: #ff8604; width:50%; margin: 0 auto; border-radius: 5px; height: 35px; color:#fff; font-size:14px; text-align: center; line-height:35px; cursor: pointer">完成</a>
				 		</div>
					</div>		
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
</section>

<div class="mask"></div>
<div class="popbox" style="display:none;">
	<span class="mui-icon mui-icon-close close-btn"></span>
	<p class="role-tile">角色</p>
	<div class="role-a" style="text-align:left;">
		<div class="t1"></div>
		<div class="t2"></div>
		<div class="t3"></div>
	</div>
	<div class="inp1 otherRoleInput" style="display: none;"><label>其他：</label><input type="text" class="ourset"></div>
	<div class="inp1 h-price">
		<label>价格：</label>
		<input type="number" class="yen" placeholder="1000" value="5000">元&nbsp;/<select class="mui-btn mui-btn-block ptype" style="font-size:15px; line-height:20px; width:50px;background-color:#ff8604">
					<option value="场">场</option>
					<option value="首">首</option>
					<option value="小时">小时</option>
					<option value="天">天</option>
				</select>
	</div>
	<div class="t-center"><a href="javascript:void(0);" class="create-btn">保存</a></div>
</div>

<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/dateX.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/roleList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script>
(function($, doc) {
	$.init();
	$.ready(function() {

		var userPicker = new $.PopPicker();
		userPicker.setData([{
			value: '1',
			text: '男'
		}, {
			value: '2',
			text: '女'
		}, {
			value: '3',
			text: '组合'
		}]);
		var showUserPickerButton = doc.getElementById('showUserPicker');
		showUserPickerButton.addEventListener('tap', function(event) {
			userPicker.show(function(items) {
				showUserPickerButton.innerText = JSON.stringify(items[0]["text"]).replace(/\"/g, "");
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);

		var cityPicker3 = new $.PopPicker({
			layer: 3
		});
		cityPicker3.setData(cityData3);
		var showCityPickerButton = doc.getElementById('showCityPicker');
		showCityPickerButton.addEventListener('tap', function(event) {
			cityPicker3.show(function(items) {
				showCityPickerButton.innerText = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
			});
		}, false);
	});
})(mui, document);
</script>
<script>
	
	$("#art-edit-commit").click(artEditCommit);

	function artEditCommit() {

		var editUserId = $("#editArtUserId").text();
		var name = $(".cname").val();
		var sex = $(".csex").text();
		var birth = $(".cbrith").text();
		var address = $(".caddress").text();
		var height = $(".cheight").val();
		var weight = $(".cweight").val();
		var bust = $(".cbust").val();
		var waist = $(".cwaist").val();
		var hipline = $(".chipline").val();
		var intro = $(".cintro").val();
		var videoList = [];
		var roleArr = [];

		//role
		var len = $(".rle-A").size();
		for (var i = 0; i < len; i++) {
			if (!$(".rle-A").eq(i).find("div")) {
				var emptyRole = {
					role : "",
					price : ""
				};
				roleArr["role_" + i + ""] = JSON.stringify(emptyRole);
			}

			var curRole = {
				role : $(".rle-A").eq(i).find("div").find("span").eq(0).html(),
				price : $(".rle-A").eq(i).find("div").find("span").eq(1).html()
			};
			roleArr["role_" + i + ""] = JSON.stringify(curRole);
		}

		/* console.info(name);
		console.info(sex);
		console.info(birth);
		console.info(address);
		console.info(tel);
		console.info(email);
		console.info(height);
		console.info(weight);
		console.info(bust);
		console.info(waist);
		console.info(hipline);
		console.info(intro);
		console.info(roleArr); */

		// validation

		// invoke
		var param = {
			"editUserId" : editUserId,
			"name" : name,
			"sex" : sex,
			"birth" : birth,
			"address" : address,
			"height" : height,
			"weight" : weight,
			"bust" : bust,
			"waist" : waist,
			"hipline" : hipline,
			"intro" : intro,
			"role_0" : roleArr["role_0"],
			"role_1" : roleArr["role_1"],
			"role_2" : roleArr["role_2"],
			"role_3" : roleArr["role_3"],
			"role_4" : roleArr["role_4"]
		};

		$("#art-edit-commit").off("click");
		$("#art-edit-commit").html("处理中...");
		mui.toast("正在处理请求...");

		$.ajax({
			url : "weih5/artEditCommit.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {
				if(data == null){
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#art-edit-commit").click(artEditCommit);
					$("#art-edit-commit").html("完成");
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
					$("#art-edit-commit").click(artEditCommit);
					$("#art-edit-commit").html("完成");

				} else {
					mui.toast("编辑成功！");
					window.location.href = "myProfile.htm";
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#art-edit-commit").click(artEditCommit);
				$("#art-edit-commit").html("完成");
			}
		});
	}
</script>
</body>
</html>