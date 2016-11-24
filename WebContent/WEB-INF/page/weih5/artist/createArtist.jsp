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
<title>创建艺人</title>
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
				 			<li><div class="inp1"><label>艺名：</label><input type="text" class="artname cname"> <font style="color:orange">*</font></div></li>
				 			<li><div class="inp1"><label>性别：</label><div class="in"><button id='showUserPicker' class="mui-btn mui-btn-block btn-black csex" type='button'>男</button></div> <font style="color:orange">*</font></div></li>
				 			<li><div class="inp1"><label>出生年月：</label> <div class="in relative"><!-- <input type="date" class="time-x">
						 			<input type="text" class="activeTime"> -->
						 			<span class="date-rl"></span>
						 			<button id='demo1' data-options='{"type":"date","beginYear":1920,"endYear":2020}' class="btn mui-btn mui-btn-block btn-black cbrith">2015-01-01</button>
						 		</div> 
			 				<font style="color:orange">*</font></div></li>
				 			<li><div class="inp1"><label>所在地：</label> <div class="in"><button id='showCityPicker' class="mui-btn mui-btn-block btn-black caddress" type='button'>上海市</button> </div></div></li>
				 			<li><div class="inp1"><label>联系方式：</label><input type="text" class="artname ctel" value="<s:property value="#request.orgPhone"/>"></div></li>
				 			<!-- <li><div class="inp1"><label>手机：</label><input type="text" class="artname ctel"> *</div></li>
				 			<li><div class="inp1"><label>Email：</label><input type="text" class="artname cmail"> *</div></li> -->
				 			<li><div class="inp1"><label>身高：</label><input type="text" class="artname cheight"> cm</div></li>
				 			<li><div class="inp1"><label>体重：</label><input type="text" class="artname cweight"> kg</div></li>
				 			<li><div class="inp1"><label>胸围：</label><input type="text" class="artname cbust"> cm</div></li>
				 			<li><div class="inp1"><label>腰围：</label><input type="text" class="artname cwaist"> cm</div></li>
				 			<li><div class="inp1"><label>臀围：</label><input type="text" class="artname chipline"> cm</div></li>
				 			<li class="bbn"><div class="inp1"><label class="lab-intro">个人介绍：</label><textarea cols='7' class="tea-intro cintro"></textarea></div></li>
				 		</ul>

				 		<div class="artistprice role-mes">
				 			<h3><strong>才艺价格</strong><span>(最多添加5个)</span></h3>
				 			<div class="role-mess rle-A clearfix" bNum = "0"><span>请添加角色..<span> <a href="javascript:void(0);">+</a></div>
				 			<div class="role-mess rle-A clearfix" bNum = "1"><span>请添加角色..<span> <a href="javascript:void(0);">+</a></div>
				 			<div class="role-mess rle-A clearfix" bNum = "2"><span>请添加角色..<span> <a href="javascript:void(0);">+</a></div>
				 			<div class="role-mess rle-A clearfix" bNum = "3"><span>请添加角色..<span> <a href="javascript:void(0);">+</a></div>	
				 			<div class="role-mess bbn rle-A clearfix" bNum = "4"><span>请添加角色..<span> <a href="javascript:void(0);">+</a></div>
				 		</div>

				 		<div class="works">
				 			<h3><strong>作品图片</strong></h3>
				 			<div class="w-text">
				 				<div class="imgload">
								    <div class="imgview  adDWXBgIMG  margin-top-20">
								        <%-- <span><img id="img" src="/stage01/h5assets/images/cross.png"></span> --%>
								        <!--<span><img id="img" src="/h5assets/images/cross.png"></span>-->
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
				 			<p class="tip" >此处仅传1张图片，如上传更多作品（图片或视频）请登录PC端www.d15t.com进行操作。</p>
				 		</div>
				 		<div class="works videoList">
				 			<h3 class="clearfix"><strong>上传视频</strong> <span class="vlAdd">增加</span></h3>
				 			<%-- <section>
					 			<div class="mui-input-row">
									<input type="text" class="mui-input-clear mui-input videoTitle" placeholder="请输入视频标题">
								</div>

								<div class="mui-input-row">
									<input type="text" class="mui-input-clear mui-input videoAddress" placeholder="请输入视频地址">
								</div>
							</section> --%>

							<div class="video_list videoListAdd">
								<!-- <a href="javascript:void(0);">
									<em></em>
									<span>
										<i>感谢你们对峨眉山世界自然</i>
										<i>http://www.w3school.com.cn/i/movie.mp4</i>
									</span>
									<div></div>
								</a> -->
							</div>
							
				 		</div>
				 		
				 		<div id="uploadedImg" style="display:none;"></div>
				 		<div class="tcenter mb10">
				 			<a href="javascript:void(0);" id="create-art-commit" class="create-com">完成</a>
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
		<input type="number" class="yen" placeholder="1000" value="5000">元&nbsp;/<select class="mui-btn mui-btn-block btn-black ptype" style="font-size:15px; line-height:20px; width:50px;background-color:#ff8604">
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
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/city.data-3.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath() %>/h5assets/js/roleList.js"></script>
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

$("#create-art-commit").click(createArt);

function createArt(){
	
	var name = $(".cname").val();
		var sex = $(".csex").text();
		var birth = $(".cbrith").text();
		var address = $(".caddress").text();
		//var tel = $(".ctel").val();
		//var email = $(".cmail").val();
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

		//video
		var vdfinda = $(".videoListAdd").find("a");
		for (var i = 0; i < vdfinda.size(); i++) {
			var vTitle = vdfinda.eq(i).find("i").eq(0).text();
			var vAddress = vdfinda.eq(i).find("i").eq(1).text();
			
			console.info(vTitle);
			console.info(vAddress);
			
			videoList.push({
				"videoTitle" : vTitle,
				"videoLink" : vAddress
			});
		}

		//pic
		var picName = $("#uploadedImg").data("imagename");
		var picdata = $("#uploadedImg").data("imagedata");

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
		console.info(roleArr);
		console.info(videoList);
		console.info(picName);
		console.info(picdata);  */
	
		// validation

		// invoke
		var param = {
			"name" : name,
			"sex" : sex,
			"birth" : birth,
			"address" : address,
			//"tel" : tel,
			//"email" : email,
			"height" : height,
			"weight" : weight,
			"bust" : bust,
			"waist" : waist,
			"hipline" : hipline,
			"intro" : intro,
			"proImg" : picdata,
			"proImgName" : picName,
			"role_0" : roleArr["role_0"],
			"role_1" : roleArr["role_1"],
			"role_2" : roleArr["role_2"],
			"role_3" : roleArr["role_3"],
			"role_4" : roleArr["role_4"],
			"videolist" : JSON.stringify(videoList)
		};

		$("#create-art-commit").off("click");
		$("#create-art-commit").html("处理中...");
		mui.toast("正在处理请求...");

		$.ajax({
			url : "weih5/saveOrUpdateArtist.htm",
			type : 'POST',
			dataType : 'json',
			data : param,
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
					$("#create-art-commit").click(createArt);
					$("#create-art-commit").html("完成");

				} else {
					mui.toast("创建成功,请等待艺人信息审核！");
					window.location.href = "myProfile.htm";
				}
			},
			error : function(data) {
				mui.alert("参数错误，请稍候再试。");
				$(".mui-popup").css("position", "fixed");
				$("#create-art-commit").click(createArt);
				$("#create-art-commit").html("完成");
			}
		});
}

</script>

</body>
</html>