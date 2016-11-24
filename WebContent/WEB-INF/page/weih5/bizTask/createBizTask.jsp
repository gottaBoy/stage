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
<title>创建委托</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.picker.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body class="entrust">
<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
		
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
			 		<div class="cnt swiper-slide ">
		 			<div class="list-type">
		 				<!--<span class="active bl" style="min-width:100px">公关/会展/发布会</span><span>企业年会</span><span>特别定制服务</span>-->
		 				
		 				<span id='typeMeetingTab' style="min-width:100px" class="active bl">活动委托</span><span id='typehunterTab' style="min-width:100px">演艺猎头</span>
		 			</div>
		 			
		 			<div id="meetingPage">
		 				<div class="inp1"><label>活动名称：</label><input type="text" class="bizTaskName" placeholder="请输入活动名称"> <font style="color:orange">*</font></div>
						<div class="inp1"><label>开始时间：</label><div class="in relative"><!-- <input type="date" class="time-x">
			 			<input type="text" class="activeTime"> -->
			 			<span class="date-rl"></span>
			 			<button id='bizTaskStartDate' data-options='{}' class="btn mui-btn mui-btn-block btn-black"><s:property value="#request.defaultDate"/></button>
			 			</div> <font style="color:orange">*</font></div>

						<div class="inp1" ><label>活动时长：</label>
				 			<div class="in"><button id='bizTaskTimeRangePicker' class="mui-btn mui-btn-block btn-black" type='button' select-index = 1>2小时</button></div>
				 		</div>
				 		<div class="inp1 clearfix"><label>活动城市：</label><div class="in"><button id='bizTaskCityPicker' class="mui-btn mui-btn-block btn-black" type='button'>上海市</button></div>
				 		</div>
						<div class="inp1"><label>活动预算：</label><input id="bizTaskBudget" type="text" placeholder="最低5w起" value="50000"> <font style="color:orange">*</font></div>
				 		<div class="inp1"><label>活动人数：</label><input id="bizTaskUserCount" type="number" class="activeNumber" placeholder="最少1人" value="1"></div>
						<div class="inp1"><label>手机号码：</label><input id="bizTaskTel" type="text" class="tel" placeholder="请输入手机号码" 
						<s:if test="#request.userPhone != null && #request.userPhone != ''">
							value='<s:property value="#request.userPhone"/>'
						</s:if>
						> <font style="color:orange">*</font></div>
						<div class="inp1"><label>备注：</label><textarea id="bizTaskMemo" class="tea1 bz-2"></textarea></div>
					</div>
		 			
		 			<div id="hunterPage" style='display:none'>
		 				<div class="inp1"><label>开始时间：</label><div class="in relative"><!-- <input type="date" class="time-x">
			 			<input type="text" class="activeTime"> -->
			 			<span class="date-rl"></span>
			 			<button id='bizTaskHunterStartDate' data-options='{}' class="btn mui-btn mui-btn-block btn-black"><s:property value="#request.defaultDate"/></button>
			 			</div> <font style="color:orange">*</font></div>

						<div class="inp1" ><label>活动时长：</label>
				 			<div class="in"><button id='bizTaskHunterTimeRangePicker' class="mui-btn mui-btn-block btn-black" type='button' select-index = 1>2小时</button></div>
				 		</div>
				 		<div class="inp1 clearfix"><label>活动城市：</label><div class="in"><button id='bizTaskHunterCityPicker' class="mui-btn mui-btn-block btn-black" type='button'>上海市</button></div>
				 		</div>
				 		<div class="inp1"><label>角色名称：</label><input id="bizTaskHunterRole" type="text" placeholder="请输入角色名称"/> <font style="color:orange">*</font></div>
						<div class="inp1"><label>角色预算：</label><input id="bizTaskHunterBudget" type="text" placeholder="请输入金额" value=""/> <font style="color:orange">*</font></div>
				 		<div class="inp1"><label>角色数量：</label><input id="bizTaskHunterUserCount" type="number" class="activeNumber" placeholder="最少1人" value="1"></div>
						<div class="inp1"><label>手机号码：</label><input id="bizTaskHunterTel" type="text" class="tel" placeholder="请输入手机号码" 
						<s:if test="#request.userPhone != null && #request.userPhone != ''">
							value='<s:property value="#request.userPhone"/>'
						</s:if>
						> <font style="color:orange">*</font></div>
						<div class="inp1"><label>备注：</label><textarea id="bizTaskHunterMemo" class="tea1 bz-2"></textarea></div>
		 			</div>
		 			
			 		
                    
                    <div class="btnBox" style="margin-top:30px; margin-bottom:50px;">
                     	 <a href="javascript:void(0);" class="create-com wt-btn" id="biz-task-commit">委 托</a>
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
		<a class="menu-biz-task mui-tab-item jump-alert mui-active" href="#">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item jump-alert" href="#tabbar-with-chat">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item jump-alert" href="#tabbar-with-map">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</section>
    
<!--     <a class="menu-task mui-tab-item" href="#tabbar-with-chat" onclick="javascript:window.location.href='createH5Task.htm';">
    <a class="menu-profile mui-tab-item" href="#tabbar-with-map" onclick="javascript:window.location.href='myProfile.htm';"> -->

<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/dateX.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>

<script>
(function($, doc) {
	$.init();
	$.ready(function() {
		var timeRangePicker = new $.PopPicker();
		timeRangePicker.setData([{
			value: '1',
			text: '2小时'
		}, {
			value: '2',
			text: '半天'
		}, {
			value: '3',
			text: '1天'
		}, {
			value: '4',
			text: '2天'
		}, {
			value: '5',
			text: '大于2天'
		}]);
		var bizTaskTimeRangeBtn = doc.getElementById('bizTaskTimeRangePicker');
		bizTaskTimeRangeBtn.addEventListener('tap', function(event) {
			timeRangePicker.show(function(items) {
				bizTaskTimeRangeBtn.innerText = JSON.stringify(items[0]["text"]).replace(/\"/g, "");
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);
		
		var bizTaskHunterTimeRangeBtn = doc.getElementById('bizTaskHunterTimeRangePicker');
		bizTaskHunterTimeRangeBtn.addEventListener('tap', function(event) {
			timeRangePicker.show(function(items) {
				bizTaskHunterTimeRangeBtn.innerText = JSON.stringify(items[0]["text"]).replace(/\"/g, "");
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);


		var bizTaskCityPicker = new $.PopPicker({
			layer: 3
		});
		bizTaskCityPicker.setData(cityData3);
		var showCityPickerButton = doc.getElementById('bizTaskCityPicker');
		showCityPickerButton.addEventListener('tap', function(event) {
			bizTaskCityPicker.show(function(items) {
				showCityPickerButton.innerText = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);
		
		var bizTaskHunterCityPicker = new $.PopPicker({
			layer: 3
		});
		bizTaskHunterCityPicker.setData(cityData3);
		var showHunterCityPickerButton = doc.getElementById('bizTaskHunterCityPicker');
		showHunterCityPickerButton.addEventListener('tap', function(event) {
			bizTaskHunterCityPicker.show(function(items) {
				showHunterCityPickerButton.innerText = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
				//返回 false 可以阻止选择框的关闭
				//return false;
			});
		}, false);
	});
})(mui, document);

</script>
<script>

	$("#biz-task-commit").click(entrust);

	function entrust() {
		var typeId;
		var type;
		var $Spn = $(".list-type span");
		for (var i = 0; i < $Spn.size(); i++) {
			if ($Spn.eq(i).hasClass("active")) {
				typeId = $Spn.eq(i).attr('id');
				type = $Spn.eq(i).html();
			}
		}
		
		var paramName = "";
		//var prarmRoleList = [];
		
		var startDate = "";
		var timeRangeType = "";

		var budget = 0;
		var userCount = 0;
		var tel = 0;
		var memo = "";
		var address = "";
		
		var roleName = "";
		
		if("typeMeetingTab" == typeId){
			var name = $(".bizTaskName").val();
			if(name == null || name == "" || $.trim(name) == ""){
				mui.alert("请输入活动名称");
				return;
			}
			paramName = name;
			
			startDate = $("#bizTaskStartDate").text();
			timeRangeType = $("#bizTaskTimeRangePicker").text();
			budget = $("#bizTaskBudget").val();
			userCount = $("#bizTaskUserCount").val();
			tel = $("#bizTaskTel").val();
			memo = $("#bizTaskMemo").val();
			address = $("#bizTaskCityPicker").text();
			
		} else {
			/* //fetch related roles; commented for now. 
			var roleList = [];

			var vdfinda = $(".bizRoleListAdd").find("a");
			for (var i = 0; i < vdfinda.size(); i++) {
				var roleName = vdfinda.eq(i).find("span").eq(0).text();
				var rolePrice = vdfinda.eq(i).find("span").eq(1).text();
				var roleCount = vdfinda.eq(i).find("span").eq(2).text();

				console.info("roleName: " + roleName);
				console.info("rolePrice: " + rolePrice);
				console.info("roleCount: " + roleCount);

				roleList.push({
					"roleName" : roleName,
					"rolePrice" : rolePrice,
					"roleCount" : roleCount
				});
			}
			console.info(roleList);
			if (roleList.length == 0) {
				mui.alert("参数错误，请添加角色。");
				return;
			}
			prarmRoleList = roleList */
			
			startDate = $("#bizTaskHunterStartDate").text();
			timeRangeType = $("#bizTaskHunterTimeRangePicker").text();
			budget = $("#bizTaskHunterBudget").val();
			userCount = $("#bizTaskHunterUserCount").val();
			tel = $("#bizTaskHunterTel").val();
			memo = $("#bizTaskHunterMemo").val();
			address = $("#bizTaskHunterCityPicker").text();
			roleName = $("#bizTaskHunterRole").val();
		}

		console.info("paramName: " + paramName);
		console.info("startDate: " + startDate);
		console.info("timeRangeType: " + timeRangeType);
		console.info("type: " + type);
		console.info("budget: " + budget);
		console.info("userCount: " + userCount);
		console.info("tel: " + tel);
		console.info("memo: " + memo);
		console.info("address: " + address);
		//console.info("prarmRoleList: " + prarmRoleList);
		console.info("roleName: " + roleName);

		//TODO: js validation

		// invoke

		var param = {
			"typeId" : typeId,
			"type" : type,
			"name" : paramName,
			"startDate" : startDate,
			"timeRangeType" : timeRangeType,
			"budget" : budget,
			"userCount" : userCount,
			"tel" : tel,
			"memo" : memo,
			"address" : address,
			"roleName" : roleName
			//"roleList" : JSON.stringify(prarmRoleList)
		}

		$("#biz-task-commit").off("click");
		$("#biz-task-commit").html("处理中...");
		mui.toast("正在处理请求...");

		$.ajax({
			url : "weih5/saveOrUpdateBizTask.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {

				if (data == null) {
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#biz-task-commit").click(entrust);
					$("#biz-task-commit").html("委托我们");
					return;
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
					$("#biz-task-commit").click(entrust);
					$("#biz-task-commit").html("委托我们");

				} else {
					mui.alert('我们已收到您的委托，我们会认真思考您的需求，并尽快与您沟通。', '发布成功',
							function() {
								window.location.href = "myProfile.htm";
							})
					$(".mui-popup").css("position", "fixed");
					//mui.toast("创建成功,请等待艺人信息审核！");
					//window.location.href = "myProfile.htm";
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#biz-task-commit").click(entrust);
				$("#biz-task-commit").html("委托我们");
			}
		});

	}
</script>
<script>
	$('#typeMeetingTab').on('tap', showTab);
	$('#typehunterTab').on('tap', showTab);
	
	function showTab(){
		var tabId = $(this).attr('id');
		if('typeMeetingTab'== tabId){
			$('#hunterPage').hide();
			$('#meetingPage').show();
		}else if('typehunterTab' == tabId){
			$('#meetingPage').hide();
			$('#hunterPage').show();
		}
	}
	
	//drop method
	$('#bizRoleAdd').click(addBizRoleClick);
	function addBizRoleClick(){
		var btnArray = ['添加', '取消'];
			mui.confirm("<section><input type='text' class='mui-input-clear mui-input bizRoleName' placeholder='角色名称，如：歌手'></div><div class='mui-input-row'><input type='text' class='mui-input-clear mui-input bizRolePrice' placeholder='角色价格（单位元），如：1000'></div><div class='mui-input-row'><input type='text' class='mui-input-clear mui-input bizRoleCount' placeholder='角色个数（单位人），如：3'></section>",
					"填写角色信息",
					btnArray,
					function(e){
						if(e.index == 0){
							var bizRoleName = $(".bizRoleName").val();
							var bizRolePrice = $(".bizRolePrice").val();
							var bizRoleCount = $(".bizRoleCount").val();
							
							var contentHtml = $(".bizRoleListAdd").html();
							
							//validation
							if(bizRoleName == null || bizRoleName == "" || $.trim(bizRoleName) == ""){
								mui.alert("角色名称不能为空，请重新填写。","");
								return
							}
							if(bizRolePrice == null || bizRolePrice == "" || $.trim(bizRolePrice) == ""){
								mui.alert("角色价格不能为空，请重新填写。","");
								return
							}
							if(bizRoleCount == null || bizRoleCount == "" || $.trim(bizRoleCount) == ""){
								mui.alert("角色个数不能为空，请重新填写。","");
								return
							}
							if(isNaN(bizRolePrice)){
								mui.alert("角色价格只能输入数字，请重新填写。","");
								$(".mui-popup").css("position", "fixed");
								return;
							}
							if(isNaN(bizRoleCount)){
								mui.alert("角色个数只能输入个数，请重新填写。","");
								$(".mui-popup").css("position", "fixed");
								return;
							}
							
							//process
							contentHtml += '<a href="javascript:void(0);" style="line-height:30px;"><em class="mui-icon mui-icon-person"></em><span style="width:50%">'+bizRoleName+'</span><span>'+bizRolePrice+'</span>元，<span>'+bizRoleCount+'</span>人<div></div></a>';
							$(".bizRoleListAdd").html(contentHtml);
						
							$(".bizRoleName").val("");
							$(".bizRolePrice").val("");
							$(".bizRoleCount").val("");
						}
					});
			$(".mui-popup").css("position", "fixed");
	}

</script>
</body>