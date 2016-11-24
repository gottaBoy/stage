<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
    System.out.println(path);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>第1舞台</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="format-detection" content="telephone=no"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/mui.min.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/style.css" />

<style type="text/css">
	.mui-slider .mui-slider-group .mui-slider-item img{width: 100% !important}
</style>
</head>
	<body>
		<div id="slider" class="mui-slider artist-banner" >
			<div class="mui-slider-group mui-slider-loop">
				<!-- 额外增加的一个节点(循环轮播：第一个节点是最后一张轮播) -->
				<div class="mui-slider-item mui-slider-item-duplicate">
					<a href="#">
						<img src="<%=request.getContextPath() %>/h5assets/images/artist-banner.jpg" />
					</a>
				</div>
				<!-- 第一张 -->
				<div class="mui-slider-item">
					<a href="#">
						<img src="<%=request.getContextPath() %>/h5assets/images/artist-banner.jpg" />
					</a>
				</div>
				<!-- 第二张 -->
				<div class="mui-slider-item">
					<a href="#">
						<img src="<%=request.getContextPath() %>/h5assets/images/artist-banner.jpg" />
					</a>
				</div>
				<!-- 第三张 -->
				<div class="mui-slider-item">
					<a href="#">
						<img src="<%=request.getContextPath() %>/h5assets/images/artist-banner.jpg" />
					</a>
				</div>
				<!-- 第四张 -->
				<div class="mui-slider-item">
					<a href="#">
						<img src="<%=request.getContextPath() %>/h5assets/images/artist-banner.jpg" />
					</a>
				</div>
				<!-- 额外增加的一个节点(循环轮播：最后一个节点是第一张轮播) -->
				<div class="mui-slider-item mui-slider-item-duplicate">
					<a href="#">
						<img src="<%=request.getContextPath() %>/h5assets/images/artist-banner.jpg" />
					</a>
				</div>
			</div>
			<div class="mui-slider-indicator">
				<div class="mui-indicator mui-active"></div>
				<div class="mui-indicator"></div>
				<div class="mui-indicator"></div>
				<div class="mui-indicator"></div>
			</div>
		</div>
		<div class="recom">
			<div class="fl title">官方推荐</div>
			<div class="recom-box">
			    <ul class="list ">
			    	
			    	<s:iterator value="#request.artistList" var="item" status="st">
			    	<li>
			      		<a href="artistDetail.htm?userId=<s:property value="#item.userId"/>">
			      			<img src="http://www.d15t.com/stageUpload/headImage/<s:property value='#item.userId'/>.png">
			          		<!-- img src="http://www.d15t.com/h5assets/images/pic1.jpg" -->
			          		<h4 class="d-title"><s:property value="#item.nickName"></s:property></h4>
			          		<p class="p1"><s:property value="#item.tags"></s:property></p>
			      		</a>
			        </li>
			    	</s:iterator>
			    </ul>
			</div>
		</div>
 		<div class="works">
 			<a href="h5IndexArtistList.htm" style="width:100%;line-height:16px;"><strong style="padding:11px 0 11px 15px">艺人列表</strong><a href="h5IndexArtistList.htm" class="nextBtn">&nbsp;</a></a>
 			
 			<ul class="mui-table-view mui-table-view-chevron">
				
				<s:iterator value="#request.suggestArtistList" var="item">
				<li class="mui-table-view-cell mui-media">
					<a class="mui-navigate-right" href="artistDetail.htm?userId=<s:property value="#item.userId"/>">
					<img class="mui-media-object mui-pull-left" src="http://www.d15t.com/stageUpload/headImage/<s:property value='#item.userId'/>.png">
<!-- 						<img class="mui-media-object mui-pull-left" src="/stage01/h5assets/images/pic1.jpg"> -->
						<div class="mui-media-body">
							<s:property value="#item.nickName"/>
							<p class='mui-ellipsis'><s:property value="#item.tags"/></p>
						</div>
					</a>
				</li>
				</s:iterator>
			</ul>
 		</div>
 		<div class="works">
 		    <a href="h5IndexTaskList.htm" style="width:100%;line-height:16px;"><strong style="padding:11px 0 11px 15px">任务列表</strong><a href="h5IndexTaskList.htm" class="nextBtn">&nbsp;</a></a>
 		    <ul class="mui-table-view mui-table-view-chevron">
 		    <li class="mui-table-view-cell mui-media"></li>
 		    </ul>
 		</div>
 		<div class="personal" style="width:50%;float:left;">
 		    <div class="title"><span class="mui-icon mui-icon-personadd-filled"></span> 演艺猎头</div>
        	<a class="wbox clearfix" href="createH5BizTask.htm" style="width:90%;">
	            <div class="rbox fldi" style="width:90%;text-align:center;">
	              <span class="mui-icon mui-icon-paperplane"></span>
	                                   帮您猎头专业艺人！
	            </div>
	        </a>
	    </div>
 		<div class="personal" style="width:50%;float:left;">
 			<div class="title"><span class="mui-icon mui-icon-compose"></span> 委托我们</div>
	        	<a class="wbox clearfix" href="createH5BizTask.htm" style="width:90%;">
		            <%-- <div class="weituo" style="background-image: url(<%=request.getContextPath() %>/h5assets/images/wbox.png)"></div> --%>
		            <!-- <div class="rbox fldi" style="width:40%;">神马？上面都没有找到你所需要的服务？没关系，委托我们，立即体验专属服务吧！</div> -->
		            <div class="rbox fldi" style="width:90%;text-align:center;">
		            	<span class="mui-icon mui-icon-paperplane"></span>
		            	提供一站式活动解决方案
		            </div>
		        </a>
 		</div>
 		<nav class="mui-bar mui-bar-tab menu">
		<a class="menu-biz-home mui-tab-item mui-active" href="#">
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
 		
 		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
		<script type="text/javascript" language="javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" charset="utf-8">
			mui.init({
				swipeBack:true //启用右滑关闭功能
			});
			var slider = mui("#slider");
			document.getElementById("slider").addEventListener('toggle', function(e) {
				if (e.detail.isActive) {
					slider.slider({
						interval: 5000
					});
				} else {
					slider.slider({
						interval: 0
					});
				}
			});
		</script>
		<script>
		wx.config({
		    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId: '<s:property value="#request.appId"/>', // 必填，公众号的唯一标识
		    timestamp: '<s:property value="#request.timestamp"/>', // 必填，生成签名的时间戳
		    nonceStr: '<s:property value="#request.nonceStr"/>', // 必填，生成签名的随机串
		    signature: '<s:property value="#request.signature"/>',// 必填，签名，见附录1
		    jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		
		wx.ready(function(){
			console.info("wx. ready success!!!!!!!!!!!!!!");
		});
		wx.error(function(res){
			console.info("wx. err..");
			console.info(res);
		});
		
		wx.checkJsApi({
		    jsApiList: ['onMenuShareTimeline'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
		    success: function(res) {
		    	console.info("checkJsApi");
		    	console.info(res);
		        // 以键值对的形式返回，可用的api值true，不可用为false
		        // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
		    }
		});
		
		wx.onMenuShareAppMessage({
		    title: '第1舞台首页', // 分享标题
		    desc: '自定义分享描述', // 分享描述
		    link: 'http://www.d15t.com/weih5/h5IndexPage.htm', // 分享链接
		    imgUrl: 'http://www.d15t.com/h5assets/images/logot1.png', // 分享图标
		    type: '', // 分享类型,music、video或link，不填默认为link
		    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		
		wx.onMenuShareTimeline({
		    title: '第1舞台首页', // 分享标题
		    link: 'http://www.d15t.com/weih5/h5IndexPage.htm', // 分享链接
		    imgUrl: 'http://www.d15t.com/h5assets/images/logot1.png', // 分享图标
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		
		</script>
	</body>

</html>