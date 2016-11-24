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
<title><s:property value="#request.title"/></title>
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

<div class="works">
		<div style="display:none" id="uploadUserId"><s:property value="#request.editUserId"></s:property></div>
		<h3><strong>上传作品图片</strong></h3>
		<div class="w-text">
			<div class="imgload">
		    <div class="imgview  adDWXBgIMG  margin-top-20">
		        <!--<span class="mui-icon mui-icon-camera"></span>-->
		        <span><img id="img" src="/h5assets/images/camera.png"></span>
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
		<!-- <p class="tip" >图片不超过30M</p> -->
	</div>
	
	<s:if test="#request.currentIsOrg != 2">
		<div class="works videoList">
			<h3 class="clearfix"><strong>上传视频</strong> <span class="vlAdd">增加</span></h3>
			<div class="video_list videoListAdd"></div>
		</div>
	</s:if>
	
	<div id="uploadedImg" style="display:none;"></div>
	
	<div class="t-center" style="margin-bottom: 30px;">
		<a href="javascript:void(0);" class="create-com upload-com" id="upload-art-commit">完 成</a>
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
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/mui.picker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/upload.js"></script>
<script>
  var result = "";
  
  $("#testmm").localResizeIMG({
    //width: 600,
    quality: 0.8,
    maxsize: 5000000, //5M
    init: function() {
      popupDiv("pop_div");
    },

    before: function(that, blob) {
      $("#img").attr("src", blob).show();
      if (blob) {
        $("#error").css("color", "#5A7505").html("").show();
        //$(".fileinput-button").find("span").html("重新选择文件")
        //console.log(g); // 文件名称
        //console.info(g);
      $("#uploadedImg").data("imagename", g);
      } else {
        $("#error").css("color", "#5A7505").html("加载失败").show();
        $(".fileinput-button").find("span").html("重新选择文件")
      }
      hideDiv("pop_div");
      $(".imgview").removeClass("adDWXBgIMG")
    },
    success: function(result) {
      var imagedata = result.clearBase64;
      var data = {
        imagename: "myImage.png",
        imagedata: imagedata
      }
      $("#uploadedImg").data("imagedata", imagedata);
    }
  });
  function popupDiv(div_id) {
    var div_obj = $("#" + div_id);
    $(".shadow-bg").show();
    div_obj.show()
  }
  function hideDiv(div_id) {
    $(".shadow-bg").animate({
      opacity: "hide"
    },
    600);
    $("#" + div_id).animate({
      opacity: "hide"
    },
    600);
    return false
  };
  
</script>

<script>
$("#upload-art-commit").click(uploadArt);

function uploadArt(){
	
		var uploadUserId = $("#uploadUserId").text();
		var videoList = [];

		//video
		var vdfinda = $(".videoListAdd").find("a");
		for (var i = 0; i < vdfinda.size(); i++) {
			var vTitle = vdfinda.eq(i).find("i").eq(0).text();
			var vAddress = vdfinda.eq(i).find("i").eq(1).text();
			
			videoList.push({
				"videoTitle" : vTitle,
				"videoLink" : vAddress
			});
		}

		//pic
		var picName = $("#uploadedImg").data("imagename");
		var picdata = $("#uploadedImg").data("imagedata");

		// validation

		// invoke
		var param = {
			"uploadUserId" : uploadUserId,
			"proImg" : picdata,
			"proImgName" : picName,
			"videolist" : JSON.stringify(videoList)
		};

		$("#upload-art-commit").off("click");
		$("#upload-art-commit").html("处理中...");
		mui.toast("正在处理请求...");

		$.ajax({
			url : "weih5/doUploadArts.htm",
			type : 'POST',
			dataType : 'json',
/* 			processData:false,
			contentType:false, */
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
					$("#upload-art-commit").click(uploadArt);
					$("#upload-art-commit").html("完 成");

				} else {
					mui.toast("上传成功！");
					window.location.href = "artistDetail.htm?userId=" + uploadUserId;
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#upload-art-commit").click(uploadArt);
				$("#upload-art-commit").html("完 成");
			}
		});
}
</script>
</body>
</html>