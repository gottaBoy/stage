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
<title>艺人详情</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />
<body>

<%
TAppUserInfo userInfo = (TAppUserInfo) request.getAttribute("userInfo");
TAppUser user = (TAppUser) request.getAttribute("user");

 %>
<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
					<div class="cnt swiper-slide swiper-slide-visible swiper-slide-active artist">

						<div class="art-head">
							<!-- <img src="/stage01/h5assets/images/pic3.jpg"> -->
							<div class="art-himg">
								<img src="http://www.d15t.com/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png">
								<div class="art-img-txt">
									<s:if test="#request.qyUserInfo == 1">
										<%-- <span class="qi">企</span> --%>
									</s:if>
									<s:elseif test="#request.qyUserInfo == 2">
										<span class="jing">经</span>
									</s:elseif>
									<s:if test="#request.userInfo.authority == 1">
										<span class="vip">V</span>
									</s:if>
									<s:else>
										<span class="no">V</span>
									</s:else>
								</div>
								<s:if test="'true'==#request.isCurrentUser || 'true'==#request.isCurrentOrgsArt">
				 					<div class="headImgEditBtn">
										<!-- <a href="uploadHeadImg.htm?editId=<s:property value="#request.userInfo.userId"/>">编 辑</a> -->
										<span>编 辑</span>
									</div>
				 				</s:if>								
							</div>
							
							<div class="art-name"><s:property value="#request.userInfo.nickName"/></div>
							<div class="art-fans">
								<span>粉丝：<em id="friendTotal"><s:property value="#request.friendFSTotal"/></em></span>
								
								<s:if test="'true'!=#request.isCurrentUser">
									<span id="follow-span">
									<s:if test="#request.isFollowing==true">
										<a href="javascript:void(0);" id="art-unfollow" class="art-follow gzing"><!-- + 关注 --> 已关注</a>
									</s:if>
									<s:else>
										<a href="javascript:void(0);" id="art-follow" data-user-id="#request.userInfo.userId" class="art-follow">关注</a>
									</s:else>
									</span>
								</s:if>
							</div>
						</div>

						<div id="artistList">
							<div class="list_outer">
								<ul class="list">
						 			<li><span>艺名</span><em><s:property value="#request.userInfo.nickName"/></em></li>
						 			<li><span>所在地</span><em><s:property value="#request.userInfo.provice"/> &nbsp;|&nbsp; <s:property value="#request.userInfo.city"/></em></li>
						 			<s:if test="#request.qyUserInfo==1">
						 			<li><span>手机</span><em><s:property value="#request.qyUInfo.mobile"/></em></li>
						 			<li><span>Email</span><em><s:property value="#request.qyUser.email"/></em></li>
						 			</s:if>
						 			<s:else>
						 			<li><span>手机</span><em><s:property value="#request.userInfo.mobile"/></em></li>
						 			<li><span>Email</span><em><s:property value="#request.user.email"/></em></li>
						 			</s:else>
						 			
						 			<s:if test="#request.userInfo.birthday != ''">
						 				<li><span>生日</span><em><s:property value="#request.userInfo.birthday"/></em></li>
						 			</s:if>
						 			<s:if test="#request.userInfo.height != '' && #request.userInfo.height != null">
						 				<li><span>身高</span><em><s:property value="#request.userInfo.height"/>CM</em></li>
						 			</s:if>
						 			<s:if test="#request.userInfo.heartSize != '' && #request.userInfo.waistSize != '' && #request.userInfo.bottocksSize != '' && #request.userInfo.heartSize null && #request.userInfo.waistSize != null && #request.userInfo.bottocksSize != null">
						 				<li><span>三围</span><em><s:property value="#request.userInfo.heartSize"/>*<s:property value="#request.userInfo.waistSize"/>*<s:property value="#request.userInfo.bottocksSize"/></em></li>
						 			</s:if>
						 			<s:if test="#request.userInfo.weight != '' && #request.userInfo.weight != null">
						 				<li><span>体重</span><em><s:property value="#request.userInfo.weight"/>KG</em></li>
						 			</s:if>
						 			<s:if test="#request.userInfo.booldType != '' && #request.userInfo.booldType != null">
						 				<li><span>血型</span><em><s:property value="#request.userInfo.booldType"/></em></li>
						 			</s:if>
						 			
						 			<li class="bbn"><span>简介</span><em class="intro">
						 			<s:if test="#request.userInfo.introduction.length() < 220">
										<s:property value="#request.userInfo.introduction" />
									</s:if>
									<s:elseif test="#request.userInfo.introduction==null||#request.userInfo.introduction==''">暂无</s:elseif>
									<s:else>
										<s:property value="#request.userInfo.introduction.substring(0,219)" />
										...<a href="javascript:alertInfo('<s:property value='#request.userInfo.introduction' />')" style="color:#00b7ed">查看全部介绍</a>
									</s:else></em></li>
						 		</ul>
							</div>
							<!-- <a class="telescopic" href="javascript:void(0)">...</a> -->
					 		<a class="telescopic" href="javascript:void(0)">显示更多</a>
						</div>
						
				 		<div class="artistprice">
				 			<h3><strong>才艺价格</strong> <span style='color:#888888'>(<s:property value="#request.costListCount"/>)</span></h3>
				 			<ul>
				 			<s:iterator value="#request.costList" var="item">
				 				<li><span><s:property value="#item.keywords"/></span><em><s:property value="#item.bprice"/>/<s:property value="#item.unit"/></em>
				 				<s:if test="'true'!=#request.isCurrentUser"><a class="invBtn" data-id='<s:property value="#item.id"/>' href="javascript:void(0);">预约</a></s:if>
				 				</li>
				 			</s:iterator>
				 			</ul>
				 		</div>

				 		<div class="works">
				 		
				 			<a style="width:100%" <s:if test="#request.productCount > 0">
				 				href="artistProducts.htm?userId=<s:property value="#request.userInfo.userId"/>"
				 				</s:if>>
				 				<h3>
				 					<strong>作品</strong>
				 					<span href="javascript:void(0)" class="nextBtn">&nbsp;</span>
				 				</h3>
				 			</a>

				 			
				 			
				 			<s:if test="#request.artDisplayCount > 1">
					 			<ul class="mui-table-view mui-grid-view" style="margin-top:0px; padding-bottom: 0px;">
					 			<s:iterator value="#request.artInfoList" var="item">
					 				<li class="mui-table-view-cell mui-media mui-col-xs-6">
							            <%-- <a href="artistImageGategory.htm?userId=<s:property value="#request.userInfo.userId"/>">
							                <img class="mui-media-object" src="http://www.d15t.com/<s:property value="#item.url"/>">
							                <div class="mui-media-body"><s:property value="#item.title"/></div>
							            </a> --%>
							            
							            <a href="artistProducts.htm?userId=<s:property value="#request.userInfo.userId"/>">
							                <span class="art-tab-img" style="height: 110.88px;background-image:url('http://www.d15t.com/<s:property value="#item.url"/>');"></span>
							                <%-- <div class="mui-media-body" style='font-size:12px; height:20px; color:#888888'><s:property value="#item.title"/></div> --%>
							            </a>
							    	</li>
					 			</s:iterator>
					 			</ul>
				 			</s:if>
				 			<s:else>
				 				<ul class="mui-table-view mui-grid-view" style="margin-top:0px; padding: 0px;">				 			
					 			<s:iterator value="#request.artInfoList" var="item">
	<%-- 				 			<img style="padding:10px;" src='http://localhost:8080/<s:property value="#item.url"/>'/> --%>
					 				<img style="padding:10px;" src='http://www.d15t.com/<s:property value="#item.url"/>'/>
					 			</s:iterator>
					 			</ul>
				 			</s:else>
						    </ul>
				 		</div>

				 		<div class="evaluate">
				 			<s:if test="#request.reviewCount != 0">
				 				<a style="width:100%" href="artistReviewList.htm?userId=<s:property value="#request.userInfo.userId"/>">
				 				<h3>
				 					<strong>交易评价</strong> <span style='color:#888888'>(<s:property value="#request.reviewCount"/>)</span>
				 					<a href="javascript:void(0);" class="nextBtn">&nbsp;</a>
				 				</h3>
				 				</a>
				 			</s:if>
				 			<s:else>
				 				<a style="width:100%" href="javascript:void(0);">
				 				<h3>
				 					<strong>交易评价</strong> <span style='color:#888888'>(<s:property value="#request.reviewCount"/>)</span>
				 					<a href="javascript:void(0);" class="nextBtn">&nbsp;</a>
				 				</h3>
				 				</a>
				 			</s:else>
				 		</div>
				 		
				 		<s:if test="'true'==#request.isCurrentUser || 'true'==#request.isCurrentOrgsArt">
				 			<div class="t-center" style="margin-bottom: 30px;">
				 				<a href="editProfile.htm?editId=<s:property value='#request.userInfo.userId'/>" style="width:40%; margin-right:16px;"  class="create-com edit-profile-btn">编辑</a>
				 				<a href="uploadArt.htm?editId=<s:property value='#request.userInfo.userId'/>" style="width:40%" class="create-com edit-profile-btn">上传作品</a>
				 			</div>
				 		</s:if>
					</div>		
				</div>
			</div>
		</form>
    </div>
    
    <nav class="mui-bar mui-bar-tab menu">
    	<a class="menu-biz-home mui-tab-item" href="h5IndexPage.htm">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</a>
		<a class="menu-biz-task mui-tab-item" href="createH5BizTask.htm">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item" href="createH5Task.htm">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item" href="myProfile.htm">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</section>

<div class="mask"></div>
<div class="popbox task-role" style="display:none">
	<span class="mui-icon mui-icon-close close-btn"></span>
	<div class="role-list-radio">
	</div>
	<a href="javascript:;" class="p-h-btn1">确定</a>
</div>

<div id='artistId' style='display:none'><s:property value="#request.userInfo.userId"/></div>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>

<script type="text/javascript">
	
	$(".headImgEditBtn").click(editHeadImg);
	
	function editHeadImg(){
		var btnArray = ["重新上传","旋转90度"];
		mui.confirm('', "编辑头像", btnArray,
			function(e) {
				if (e.index == 0) {
					window.location.href="uploadHeadImg.htm?editId=<s:property value='#request.userInfo.userId'/>";
				}else if(e.index ==1){
					rotate();	
				}
			});
		$(".mui-popup").css("position","fixed");	
	}

	function rotate(){
	
		$("#img-rotate").off("click");
		mui.toast("正在处理请求...");

		var param = {
			"orientation":"right"
		}

		$.ajax({
			url : "weih5/rotateHeadImg.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {
				if(data == null){
					mui.alert("参数错误，请稍候再试。");
					$(".mui-popup").css("position", "fixed");
					$("#upload-art-commit").click(uploadArt);
					$("#upload-art-commit").html("完 成");
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
					$("#img-rotate").click(uploadArt);
				} else {
					mui.toast("旋转成功！");
					window.location.reload(); 
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#img-rotate").click(uploadArt);
			}
		});
	}
</script>

<script type="text/javascript" language="javascript">

$("#art-follow").click(flowArt);
$("#art-unfollow").click(unflowArt);

$(".invBtn").click(invite);

$(".p-h-btn1").click(confirmInvite);

	function invite() {
		var costId = $(this).attr('data-id');
		var artistId = $("#artistId").text();
		
		var param = {
			"artistId":artistId
		}
		
		$.ajax({
			url:"weih5/fetchTaskForInviting.htm",
			type:'POST',
			dataType:'json',
			data: param,
			success: function(data){
				var result = data["result"];
				var message = data["message"];
				
				if(result == "error"){
					if( message != "" ){
						mui.alert(message);
					} else {
						mui.alert("参数错误，请稍候再试。");
					}
				}else{
					// success action;
					var taskHtml = "";
					var sendAble = false;
					if(data['data'] == null || data['data'].length == 0){	
						taskHtml = "<p>您还没有通告来预约，<br>先创建一个通告吧!</p>"
					}else{
						$.each(data['data'],function(index, ele){
							//console.info(ele.id);
							//console.info(ele.title);
							//console.info(ele.roleList);
							
							//var taskItem = "<div style='text-align:left; font-weight:bold' data-task-id='" + ele.id + "'>" + ele.title + "</div>";
							
							var taskItem = "<div class='role-yy'><span data-task-id='" + ele.id + "'>" + ele.title + "</span><div class='list-radio'>";
							
							//var taskItem = "<div class='mui-input-row mui-checkbox' style='text-align: left'><label>"+ele.title+"</label><input name='checkbox' class='inviteTaskCheck' value='task-"+ele.id+"' type='checkbox'>";
							taskHtml = taskHtml + taskItem;
							
							$.each(ele.roleList, function(index, role){
								
								var roleItem = "<p><em class='radio-un' value='" + role.id + "' name='" + role.title + "' cost-id='" + costId + "'></em> " + role.title + "</p>";
							
								//var roleItem = "<div class='mui-input-row mui-checkbox' style='text-align: left; color:#888888'><label>角色: "+role.title+"</label><input name='checkbox' class='inviteTaskRoleCheck' value='"+role.id+"' type='checkbox'></div>";
								taskHtml = taskHtml + roleItem;
							});
							
							taskHtml = taskHtml + "</div></div>";
						});
						sendAble = true;
					}
					
					//var mask = mui.createMask();//callback为用户点击蒙版时自动执行的回调；
					//mask.show();//显示遮罩
				
					if(sendAble){
						/* var btnArray = ['发送邀请','取消'];
						mui.confirm(taskHtml,'请选择通告的角色', btnArray, function(e){
							if(e.index == 0){
								var roles = [];
								$('.inviteTaskRoleCheck:checkbox:checked').each(function(){
									var role = $(this).val()
									roles.push(role);
								});
		
								if(roles.length == 0){
									mui.alert('请最少选择1个角色来邀请','参数错误');
									return;
								}
		
								sendInvite(roles, costId);
							}
						});
						$(".mui-popup").css("position","fixed"); */
						$(".mask").show();
						$(".role-list-radio").html('').html(taskHtml);
						$(".task-role").show();
					}else{
						var btnArray = ['发一个通告','取消'];
						mui.confirm(taskHtml,'无法预约', btnArray, function(e){
							if(e.index == 0){
								window.location.href = "createH5Task.htm";
							}
						});
						$(".mui-popup").css("position","fixed");
					}
				}
			},
			error: function(data){
				mui.alert('请稍后再试。','参数错误');
			}
		});
	}
	
	function confirmInvite(){
		
		var $em = $(".list-radio").find("em");
			var $arr = [];
			var roles = [];
			var costId;
			$em.each(function(index){
				if($em.eq(index).hasClass('radio-act')){
					//$arr.push({name:$em.eq(index).attr('name'),value:$em.eq(index).attr('value')});
					roles.push($em.eq(index).attr('value'));
					costId = $em.eq(index).attr('cost-id')
				}
			});
			
			if(roles.length == 0){
				mui.alert('请最少选择1个角色来邀请','参数错误');
				return;
			}
			
			$(".task-role").hide();
			$(".mask").hide();
			
			sendInvite(roles, costId);
	}
	
	function sendInvite(roles, costId) {

		var artistId = $('#artistId').text();
		
		var param = {
			'artistId' : artistId,
			'costId' : costId,
			'roles' : JSON.stringify(roles)
		}

		mui.toast('正在处理...');

		$.ajax({
			url : "weih5/doInvite.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
			success : function(data) {
				var result = data["result"];
				var message = data["message"];

				if (result == "error") {
					// error action

					if (message != "") {
						mui.alert(message);
					} else {
						mui.alert("参数错误，请稍候再试。");
					}

				} else {
					// success action
					mui.alert('您的邀请及联系方式已发送到艺人，请等待TA与您联系。', '邀请成功', function() {
						// change invite btn
					})
				}
			},
			error: function(data){
				mui.alert('网络错误，请稍后再试。', '邀请失败', function() {})
			}
		});
	}

	function flowArt() {
		var artistId = $("#artistId").text();
		var param = {
			"artistId" : artistId
		}
		mui.toast("处理中...");
		$.ajax({
			url:"weih5/followArt.htm",
			type:'POST',
			dataType:'json',
			data: param,
			success: function(data){
				var result = data["result"];
				var message = data["message"];
				
				if (result == "error") {
					// error action
			
					if (message != "") {
						mui.alert(message);
					} else {
						mui.alert("参数错误，请稍候再试。");
					}
					$(".mui-popup").css("position","fixed");
			
				} else {
					// success action
					mui.toast('关注成功');
					$('#follow-span').html('').html("<a href='javascript:void(0);' id='art-unfollow' class='art-follow gzing'>已关注</a>");
					$("#art-unfollow").click(unflowArt);
					var currentCount = $("#friendTotal").text();
					$("#friendTotal").html(parseInt(currentCount) + 1);
				}
			},
			error: function(data){
				mui.alert('请稍后再试。','参数错误');
			}
		});	
	}
	
	function unflowArt(){
		var artistId = $("#artistId").text();
		var param = {
			"artistId" : artistId
		}
		mui.toast("处理中...");
		$.ajax({
			url:"weih5/unfollowArt.htm",
			type:'POST',
			dataType:'json',
			data: param,
			success: function(data){
				var result = data["result"];
				var message = data["message"];
				
				if (result == "error") {
					// error action
			
					if (message != "") {
						mui.alert(message);
					} else {
						mui.alert("参数错误，请稍候再试。");
					}
					$(".mui-popup").css("position","fixed");
			
				} else {
					// success action
					mui.toast('取消关注成功');
					$('#follow-span').html('').html("<a href='javascript:void(0);' id='art-follow' data-user-id='#request.userInfo.userId' class='art-follow'>关注</a>");
					$("#art-follow").click(flowArt);
					var currentCount = $("#friendTotal").text();
					$("#friendTotal").html(parseInt(currentCount) - 1);
				}
			},
			error: function(data){
				mui.alert('请稍后再试。','参数错误');
			}
		});	
	}
</script>

</body>