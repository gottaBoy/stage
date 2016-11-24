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
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>艺人列表</title>
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
	<div class="works">
	    <div class="mui-content">
			<div style="padding: 10px 10px;">
				<div id="segmentedControl1" class="mui-segmented-control">
				    <a class="mui-control-item mui-active" href="#item1">
					          按才艺：<span id="selectText1">不限</span>
					</a>
					<a class="mui-control-item" href="#item2">
						按价格：<span id="selectText2">不限</span>
					</a>
				</div>
			</div>
			<div id="item1" class="mui-control-content mui-active" style="display:none;">
			     <div class="role-a">
			         <span class="selected">不限</span>
				     <span>演员</span>
				     <span>音乐</span>
				     <span>舞蹈</span>
				     <span>模特</span>
				     <span>达人</span>
				     <span>幕后</span>
			     </div>
			</div>
			<div id="item2" class="mui-control-content" style="display:none;">
			   <div class="role-a">
			     <span class="selected">不限</span>
			     <span>500以下</span>
			     <span>500-1000</span>
			     <span>1000-3000</span>
			     <span>3000以上</span>
			   </div>
			</div>
		</div>
		
		<ul id="infoList" class="mui-table-view mui-table-view-chevron" style="margin-top:0;">
		    <%-- <li class="mui-table-view-cell mui-media">筛选：<span>按才艺</span><span>按价格</span></li> --%>
			<s:iterator value="#request.artistList" var="item" status="st">
		        <li class="mui-table-view-cell mui-media">
				<a class="mui-navigate-right" href="artistDetail.htm?userId=<s:property value="#item.userId"/>">
					<img class="mui-media-object mui-pull-left" src="http://www.d15t.com/stageUpload/headImage/<s:property value='#item.userId'/>.png">
					<div class="mui-media-body">
						<s:property value="#item.nickName"/>
						<p class='mui-ellipsis'><s:property value="#item.tags"/></p>
					</div>
				</a>
				</li>
	    	</s:iterator>	
		</ul>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
	<script type="text/javascript" charset="utf-8">
	</script>
	<script type="text/javascript">
	     $("[href='#item1']").bind("mousedown touchstart", function(event){
		     event.stopPropagation();
		     event.preventDefault();
	     //$("[href='#item1']").click(function(){
	    	 var id = $(this).attr("href");
	    	 var $id = $(id);
	    	 if($id.css("display")=="none"){
	    		 $("#item2").css("display","none");
	    		 $id.css("display","block");
	    	 }else{
	    		 //console.log();
	    		 $id.css("display","none");
	    	 }
	     })
	     $("[href='#item2']").bind("mousedown touchstart", function(event){
		     event.stopPropagation();
		     event.preventDefault();
	     //$("[href='#item2']").click(function(){
	    	 var id = $(this).attr("href");
	    	 var $id = $(id);
	    	 if($id.css("display")=="none"){
	    		 $("#item1").css("display","none");
	    		 $id.css("display","block");
	    	 }else{
	    		 //console.log();
	    		 $id.css("display","none");
	    	 }
	     })
	     $("#item1 span").bind("mousedown touchstart", function(event){
		     event.stopPropagation();
		     event.preventDefault();
	     //$("#item1 span").on("click",function(){
	    	if(!$(this).hasClass("selected")){
	    		$("#item1 .selected").removeClass("selected");
	    		$(this).addClass("selected");
	    		$("#selectText1").html($(this).html());
	    		$("#item1").css("display","none");
	    		itemfilter();
	    	}else{
	    		$("#item1").css("display","none");
	    	}
	     })
	     //$("#item2 span").on("click",function(){
	     $("#item2 span").bind("mousedown touchstart", function(event){
		     event.stopPropagation();
		     event.preventDefault();
	    	if(!$(this).hasClass("selected")){
	    		$("#item2 .selected").removeClass("selected");
	    		$(this).addClass("selected");
	    		$("#selectText2").html($(this).html());
	    		$("#item2").css("display","none");
	    		itemfilter();
	    	}else{
	    		$("#item2").css("display","none");
	    	}
	     })
	     
	     function itemfilter(){
	    	 var profession = $("#item1 .selected").html();
	    	 var range = $("#item2 .selected").html(); 
	    	 switch (profession){
		    	 case "不限": profession =-1;break;
		    	 case "演员": profession = 1;break;
		    	 case "音乐": profession = 2;break;
		    	 case "舞蹈": profession = 3;break;
		    	 case "模特": profession = 4;break;
		    	 case "达人": profession = 5;break;
		    	 case "幕后": profession = 6;break;
	    	 }
	    	 switch (range){
		    	 case "不限": range =-1;break;
		    	 case "500以下": range = 1;break;
		    	 case "500-1000": range = 2;break;
		    	 case "1000-3000": range = 3;break;
		    	 case "3000以上": range = 4;break;
	    	 }
	    	 var param = {
	    	     profession : profession,
	    	     range: range
	    	 } 
	    	 $.ajax({
	 			url : "weih5/indexArtistListParameter.htm",
	 			type : 'POST',
	 			dataType : 'json',
	 			data : param,
	 			success : function(data) {
	 				if(data.length>0){
	 					$(".mui-table-view").empty();
	 					for(var i=0;i<data.length;i++){
	 						 var info = data[i];
	 						 if(!info)continue;
	 						 if(!info.userId)continue;
	 						 if(!info.nickName)continue;
	 						 if(!info.tags)continue;
 							 var htm = '';
	 				    	 htm += '<li class="mui-table-view-cell mui-media">';
	 				    	 htm += 	'<a class="mui-navigate-right" href="artistDetail.htm?userId='+ info.userId + '">';
	 				    	 htm += 		'<img class="mui-media-object mui-pull-left" src="http://www.d15t.com/stageUpload/headImage/'+ info.userId + '.png">';
	 				    	 htm += 		'<div class="mui-media-body">';
	 				    	 htm += 			info.nickName;
	 				    	 htm += 			'<p class="mui-ellipsis">' + info.tags + '</p>';
	 				    	 htm += 		'</div>';
	 				    	 htm +=    '</a>';
	 				    	 htm += '</li>';
	 				    	 $("#infoList").append(htm); 
	 					}
	 				}

	 				/* if (result == "error") {
	 					if (message != "") {
	 						mui.alert(message);
	 					} else {
	 						mui.alert("参数错误，请稍候再试。");
	 					}
	 					//$(".mui-popup").css("position", "fixed");
	 					//$("#company-com").click(regCommit);
	 					//$("#company-com").html("注 册");

	 				} else {
	 					mui.toast("数据加载成功!");
	 					//window.location.href = "myProfile.htm";
	 				} */
	 			},
	 			error : function(data){
	 				mui.alert("参数错误，请稍候再试。");
	 			}
	 		}); 
	     }
	</script>
</body>
</html>