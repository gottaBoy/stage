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
<title>艺人作品</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<body>

<section class="mainBox">
	<div class="main">
		<form action="#" method="post" id="form1">		
			<div class="warp swiper-container">
				<div class="issue swiper-wrapper " id="issue">
			 		<div class="cnt swiper-slide ">
		 				<div class="list-type">
		 				
		 				<s:if test="#request.tag == 'image'">
		 					<span id='imageTab' class="active bl">相册</span><span id='videoTab'>视频</span>
		 				</s:if>
		 				<s:else>
		 					<span id='imageTab' class="bl">相册</span><span class='active' id='videoTab'>视频</span>
		 				</s:else>
			 				
			 			</div>

						<!-- image list -->			 			
			 			<div class="mui-content" id='imagePage' <s:if test="#request.tag=='video'">style='display:none'</s:if>>
							<div class="mui-content-padded">
							
								<s:iterator value="#request.artImageList" var="item">
							    	<p>
								    	<s:if test="'true'==#request.isCurrentUser || 'true'==#request.isCurrentOrg">
								    		<span art-id="<s:property value="#item.id"/>" class="mui-icon mui-icon-trash artist-product-delete" style="position:absolute; right:12px; padding-top:10px; color:#ff8604"></span>
								    	</s:if>
							    		<img src="http://www.d15t.com/<s:property value="#item.url"/>" data-preview-src="" data-preview-group="1" />
							    	</p>
									<p><s:property value="#item.title"/></p>
					 			</s:iterator>

							</div>
						</div>
						
						<!-- video list -->
						<div class="mui-content" id='videoPage' <s:if test="#request.tag=='image'">style='display:none'</s:if>>
							<div class="mui-content-padded video_list">
								<s:iterator value="#request.artVideoList" var="item">
								
									<a onclick="location='<s:property value="#item.url"/>'">
										<em class="mui-icon mui-icon-videocam"></em>
										<span><s:property value="#item.title"/></span>
										<s:if test="'true'==#request.isCurrentUser || 'true'==#request.isCurrentOrg">
								    		<span art-id="<s:property value="#item.id"/>" class="mui-icon mui-icon-trash artist-product-video-delete" style="position:absolute; right:12px; color:#ff8604"></span>
								    	</s:if>
									</a>
									
					 			</s:iterator>
					 			
							</div>
						</div>
						
						
					</div>	
				</div>
		  	</div>
		</form>
    </div>
    
    <nav class="mui-bar mui-bar-tab menu">
    	<a class="menu-biz-home mui-tab-item" href="#">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</a>
		<a class="menu-biz-task mui-tab-item" href="#">
			<span class="mui-icon mui-icon-email"></span>
			<span class="mui-tab-label">委托</span>
		</a>
		<a class="menu-task mui-tab-item" href="#">
			<span class="mui-icon mui-icon-compose"></span>
			<span class="mui-tab-label">发通告</span>
		</a>
		<a class="menu-profile mui-tab-item" href="#">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label">我的</span>
		</a>
	</nav>
</section>
<div id='artistId' style='display:none'><s:property value="#request.userId"/></div>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
<script src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script src="<%=request.getContextPath() %>/h5assets/js/mui.zoom.js"></script>
<script src="<%=request.getContextPath() %>/h5assets/js/mui.previewimage.js"></script>
<script>
	mui.previewImage();
</script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>

<script type="text/javascript" language="javascript">

	$('#imageTab').on('tap', showTab);
	$('#videoTab').on('tap', showTab);
	
	$('.artist-product-delete').on('tap', deleteArtistProduct);
	$('.artist-product-video-delete').on('tap', deleteArtistProductVideo);
	

	function showTab() {
		var tabId = $(this).attr('id');
		if ('imageTab' == tabId) {
			$('#videoPage').hide();
			$('#imagePage').show();
		} else if ('videoTab' == tabId) {
			$('#imagePage').hide();
			$('#videoPage').show();
		}
	}
	
	function deleteArtistProductVideo(){
		var currentItem = $(this);
		var artistId = $("#artistId").text();
		var artId = $(this).attr('art-id');
		var btnArray = ["删除","取消"];
		mui.confirm('', "确定要删除此作品？", btnArray,
			function(e) {
				if (e.index == 0) {
					var param = {
						"artId" : artId,
						"artistId" : artistId
					};
					mui.toast('正在处理...');
					$.ajax({
						url:"weih5/deleteArtistProductVideo.htm",
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
								currentItem.parent().remove();
								mui.toast('删除成功');
							}
						},
						error: function(data){
							mui.alert('请稍后再试。','参数错误');
						}
					});
				}
			});
		$(".mui-popup").css("position","fixed");
	}
	
	function deleteArtistProduct(){
		var currentItem = $(this);
		var artistId = $("#artistId").text();
		var artId = $(this).attr('art-id');
		var btnArray = ["删除","取消"];
		mui.confirm('', "确定要删除此作品？", btnArray,
			function(e) {
				if (e.index == 0) {
					var param = {
						"artId" : artId,
						"artistId" : artistId
					};
					mui.toast('正在处理...');
					$.ajax({
						url:"weih5/deleteArtistProduct.htm",
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
								currentItem.parent().remove();
								mui.toast('删除成功');
							}
						},
						error: function(data){
							mui.alert('请稍后再试。','参数错误');
						}
					});
				}
			});
		$(".mui-popup").css("position","fixed");
	}
</script>

</body>