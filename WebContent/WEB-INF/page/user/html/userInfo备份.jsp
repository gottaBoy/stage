<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/followButton.css">
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
	<style type="text/css" media="screen">
		html, body { height:100px; background-color: #f5f5f5;}
	</style>
	
<script type="text/javascript">

function handleImgLoadError(oEvent) {
	oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/rz_imgphoto.jpg';
}

function handleImgLoadError1(oEvent) {
	oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
}

function handleImgLoadError2(oEvent) {
	oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
}
$(window).scroll(function(e){
	var top = $(window).scrollTop();
	if(top > 204) {
		$("#left_menu").css("position", "fixed");
		$("#left_menu").css("top", "0");
		$("#left_menu").css("border-left", "1px #F5F5F5 solid");
		$(".left_menubj").css("width", "166px");
	} else {
		$("#left_menu").css("position", "");
		$(".left_menubj").css("width", "146px");
		$("#left_menu").css("border-left", "0px");
	}
	
	if(top > 240) {
		$(".right_tab").css("position", "fixed");
		$(".right_tab").css("top", "0");
		
		$(".right_tab").css("margin-top", "0");
	} else {
		$(".right_tab").css("position", "");	
		$(".right_tab").css("margin-top", "5");
	}
	
})

function saveCookie(id){
	$.cookie("tempClickType", id);
}

$(document).ready(function(){
	var height = document.documentElement.clientHeight-350;
	if(height > 370){
		$("#main_content").height(document.documentElement.clientHeight-350);
	}
	getUserInfo();
	$("#jcxxTd1").css("display", "block");
});

//获取用户基本信息
function getUserInfo() {
	$.ajax({
	   url:"<%=request.getContextPath() %>/member/userinfo!getUserInfoById.htm",
	   type:'POST',
	   dataType:'json',  
	   success:function(data){
		   //var d = eval('('+data+')');
		   var d = eval(data);
		   
		   var wzd = 0;
		   
		   if(d.userInfo.jcxxIsFinish == 1) {
			   $("#img1").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 30;
		   } else {
			   $("#img1").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   
		   if(d.userInfo.zyjnIsFinish == 1) {
			   $("#img2").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 20;
		   } else {
			   $("#img2").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.czjlIsFinish == 1) {
			   $("#img3").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img3").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.xcIsFinish == 1) {
			   $("#img4").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img4").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.spIsFinish == 1) {
			   $("#img5").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img5").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.ypIsFinish == 1) {
			   $("#img6").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img6").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.sytjIsFinish == 1) {
			   $("#img7").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img7").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   
		   $("#img1").show();
		   $("#img2").show();
		   $("#img3").show();
		   $("#img4").show();
		   $("#img5").show();
		   $("#img6").show();
		   $("#img7").show();
		   $("#wcdDiv").html(wzd + "%");
		   
		   if(wzd == 0) {
			   $(".wcd-1").hide();
			   $(".wcd-2").hide();
			   $(".wcd-3").hide();
		   } else {
			   $(".wcd-1").show();
			   $(".wcd-2").show();
			   $(".wcd-3").show();
			   $(".wcd-2").css("width", (wzd-7) + "%");
		   }
		   
		   $("#userId").val(d.userInfo.userId);
		   $("#userName").html(d.username);
		   if(d.isOrg == "1") {
			   $("#nickName_span").html("公司名称：");
			   $("#birthday_span").html("成立时间：");
			   $("#grjs_span").html("公司介绍：");
			   $("#sign").val(2);
			   
			   $(".jcxx_box_01_01").find("tr:eq(1)").hide();
			   $(".jcxx_box_02").hide();
			   $(".box_01").find("tr:eq(0)").hide();
			   $(".box_01").find("tr:eq(1)").hide();
		   } else {
			   $("#nickName_span").html("昵&nbsp;&nbsp;&nbsp;&nbsp;称：");
			   $("#birthday_span").html("生&nbsp;&nbsp;&nbsp;&nbsp;日：");
			   $("#grjs_span").html("个人介绍：");
			   $("#sign").val(1);
		   }
		   $("#nickName").val(d.userInfo.nickName);
		   $("#name").val(d.userInfo.name);
		   
		   if(d.userInfo.sex == "1") {
			   $("#radio1").attr("checked", true);
		   } else if(d.userInfo.sex == "2"){
			   $("#radio2").attr("checked", true);
		   }
		   $("#provice_text").val(d.userInfo.provice);
		   $("#city_text").val(d.userInfo.city);
		   $("#birthday").val(d.userInfo.birthday);
		   
		   var myDate = new Date();
		   $("#photo_pic").attr("src", "/stageUpload/headImage/" + d.userInfo.userId + ".png?date=" + myDate.getTime());
		   $("#booldType").val(d.userInfo.booldType);
		   $("#height").val(d.userInfo.height);
		   $("#weight").val(d.userInfo.weight);
		   $("#heartSize").val(d.userInfo.heartSize);
		   $("#waistSize").val(d.userInfo.waistSize);
		   $("#bottocksSize").val(d.userInfo.bottocksSize);
		   $("#mobile").val(d.userInfo.mobile);
		   if(d.userInfo.mobileRadio == "1") {
			   $("#mobileRadio1").attr("checked", true);
		   } else if(d.userInfo.mobileRadio == "2"){
			   $("#mobileRadio2").attr("checked", true);
		   } else if(d.userInfo.mobileRadio == "3"){
			   $("#mobileRadio3").attr("checked", true);
		   }
		   $("#qq").val(d.userInfo.qq);
		   if(d.userInfo.qqRadio == "1") {
			   $("#qq1").attr("checked", true);
		   } else if(d.userInfo.qqRadio == "2"){
			   $("#qq2").attr("checked", true);
		   } else if(d.userInfo.qqRadio == "3"){
			   $("#qq3").attr("checked", true);
		   }
		   $("#telPhone").val(d.userInfo.telPhone);
		   $("#email_span").html(d.email);
		   $("#education").val(d.userInfo.education);
		   $("#school").val(d.userInfo.school);
		   $("#major").val(d.userInfo.major);
		   $("#introduction").val(d.userInfo.introduction);
		   
		   initAddress("provice","city",$("#provice_text").val(),$("#city_text").val());
		   
		   $(document.body).height($("#main_content").height() + 350);
		   
		   
			var tempClickType = $.cookie("tempClickType");
			if(tempClickType == 4) {
				showContent(4);
			}
	   }
	});
}


//获取用户资料完成度
function getUserInfo1() {
	$.ajax({
	   url:"<%=request.getContextPath() %>/member/userinfo!getUserInfoById.htm",
	   type:'POST',
	   dataType:'json',  
	   success:function(data){
		   //var d = eval('('+data+')');
		   var d = eval(data);
		   
		   var wzd = 0;
		   
		   if(d.userInfo.jcxxIsFinish == 1) {
			   $("#img1").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 30;
		   } else {
			   $("#img1").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   
		   if(d.userInfo.zyjnIsFinish == 1) {
			   $("#img2").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 20;
		   } else {
			   $("#img2").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.czjlIsFinish == 1) {
			   $("#img3").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img3").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.xcIsFinish == 1) {
			   $("#img4").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img4").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.spIsFinish == 1) {
			   $("#img5").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img5").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.ypIsFinish == 1) {
			   $("#img6").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img6").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   if(d.userInfo.sytjIsFinish == 1) {
			   $("#img7").attr("src", "<%=request.getContextPath() %>/theme/images2/x12.png");
			   wzd += 10;
		   } else {
			   $("#img7").attr("src", "<%=request.getContextPath() %>/theme/images2/x11.png");
		   }
		   
		   $("#img1").show();
		   $("#img2").show();
		   $("#img3").show();
		   $("#img4").show();
		   $("#img5").show();
		   $("#img6").show();
		   $("#img7").show();
		   $("#wcdDiv").html(wzd + "%");
		   
		   if(wzd == 0) {
			   $(".wcd-1").hide();
			   $(".wcd-2").hide();
			   $(".wcd-3").hide();
		   } else {
			   $(".wcd-1").show();
			   $(".wcd-2").show();
			   $(".wcd-3").show();
			   $(".wcd-2").css("width", (wzd-7) + "%");
		   }
		   
	   }
	});
}

//获取用户资料完成度
function getUserInfo2() {
	$.ajax({
	   url:"<%=request.getContextPath() %>/member/userinfo!getUserInfoById.htm",
	   type:'POST',
	   dataType:'json',  
	   success:function(data){
		   //var d = eval('('+data+')');
		   var d = eval(data);
		   
		   var wzd = 0;
		   
		   if(d.userInfo.jcxxIsFinish == 1) {
			   wzd += 30;
		   }
		   if(d.userInfo.zyjnIsFinish == 1) {
			   wzd += 20;
		   }
		   if(d.userInfo.czjlIsFinish == 1) {
			   wzd += 10;
		   }
		   if(d.userInfo.xcIsFinish == 1) {
			   wzd += 10;
		   }
		   if(d.userInfo.spIsFinish == 1) {
			   wzd += 10;
		   }
		   if(d.userInfo.ypIsFinish == 1) {
			   wzd += 10;
		   }
		   if(d.userInfo.sytjIsFinish == 1) {
			   wzd += 10;
		   }
		   
		   if(wzd >= 50) {
			   userShare(wzd);
		   }
		   
	   }
	});
}

//分享页面
function userShare(wzd){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo!toUserShare.htm?wzd='+wzd,{lock:true,resize: false,fixed:true});
}

//删除用户头像
function delHeadImg() {
	$.ajax({
	   url:"<%=request.getContextPath() %>/member/userinfo!delHeadImg.htm",
	   type:'POST',
	   success:function(data){
		   if(data == 1) {
			   getUserInfo();
		   }
	   }
	});
}

//获取用户技能
function getUserInfoCost() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserInfoCost.htm",
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			$("#cyjn_table").html("");
			var html = "<tr><td width='167' align='center' class='zyfl_title'>职业排序</td><td width='167' align='center' class='zyfl_title'>职业</td><td width='115' align='center' class='zyfl_title'>关键字</td><td width='231' align='center' class='zyfl_title'>价格区间</td><td width='80' align='center' class='zyfl_title'>操作</td></tr>";
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				html += "<tr><td align='center'><a href='javascript:toEditCost("+obj.id+")' class='czjl_title_link'>第"+obj.orderNo+"职业</a></td><td align='center'>"+obj.typeName+"</td><td align='center'>"+obj.keywords+"</td><td align='center'>";
				
				var price = "";
				if(obj.isConsult == 1) {
					price = "面议";
				} else {
					price = obj.bprice + "-" + obj.eprice + "&nbsp;（元/" + obj.unit + "）";
				}
				html += price + "</td><td align='center'><a href='javascript:toDelCost("+obj.id+")' class='czjl_title_link'>删除</a></td></tr>";
			}
			
			$("#cyjn_table").html(html);
			getUserInfo1();
		   $(document.body).height($("#main_content").height() + 350);
		}
	});
}

function toAddCost(){
	art.dialog.open('<%=request.getContextPath()%>/member/cost!toAddOrUpdate.htm',{width:800,height:300,lock:true,resize: false});
}
function toEditCost(id){
	art.dialog.open('<%=request.getContextPath()%>/member/cost!toAddOrUpdate.htm?id='+id,{width:550,height:400,lock:true,resize: false});
}
function toDelCost(id){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/cost!delCost.htm?id='+id,
				function(data){
					if(data=="1"){
						getUserInfoCost();
					}else{
						 art.dialog.tips("请按职业顺序来删除职业!");
					}
			},"html");
		},
		cancel: true
	});
}

//获取用户成长经历
function getUserInfoGrowth() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getGrowthList.htm",
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			$("#czjl_table").html("");
			//<table width='780' border='0' align='center' class='zyfl_table123'>
			var html = "<tr><td width='167' align='center' class='zyfl_title'>标题</td><td width='167' align='center' class='zyfl_title'>日期</td><td width='231' align='center' class='zyfl_title'>内容</td><td width='115' align='center' class='zyfl_title'>创建时间</td><td width='80' align='center' class='zyfl_title'>操作</td></tr>";
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				
				html += "<tr><td align='center'><a href='javascript:toEditGrowth("+obj.id+");' class='czjl_title_link'>"+obj.title+"</a></td><td align='center'>"+obj.startDate+"&nbsp;-&nbsp;"+obj.endDate+"</td><td align='left'>";
				
				var content = "";
				if(obj.content.length >= 30) {
					content = obj.content.substring(0,30) + "...";
				} else {
					content = obj.content;
				}
				html += content + "</td><td align='center'>"+obj.creatTime+"</td><td align='center'><a href='javascript:toDelGrowth("+obj.id+");' class='czjl_title_link'>删除</a></td></tr>";
			}
			
			$("#czjl_table").html(html);
			
			getUserInfo1();
		   $(document.body).height($("#main_content").height() + 350);
		}
	});
}

function toAddGrowth(){
	art.dialog.open('<%=request.getContextPath()%>/member/growth!toGrowth.htm',{width:800,height:400,resize: false});
}
function toEditGrowth(id){
	art.dialog.open('<%=request.getContextPath()%>/member/growth!toGrowth.htm?id='+id,{width:800,height:400,resize: false});
}
function toDelGrowth(id){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
		
		$.post('<%=request.getContextPath()%>/member/growth!delGrowth.htm?id='+id,
			function(data){
				if(data=="1"){
					getUserInfoGrowth();
				}
			},"html");
		},
		cancel: true
	});
}

//获取用户才艺（相册视频音频）
function getUserArt(type) {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserArtList.htm?type=" + type,
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			
			var html = "<ul>";
			
			var html1 = "<tr><td width='180' align='center' class='zyfl_title'>标题</td><td width='280' align='center' class='zyfl_title'>简介</td><td width='180' align='center' class='zyfl_title'>创建时间</td><td width='120' align='center' class='zyfl_title'>操作</td></tr>";
			
			var html2 = "<tr><td width='180' align='center' class='zyfl_title'>标题</td><td width='280' align='center' class='zyfl_title'>简介</td><td width='180' align='center' class='zyfl_title'>创建时间</td><td width='120' align='center' class='zyfl_title'>操作</td></tr>";
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				
				if(type == 1) {
					html += "<li><div class='xc_div'><a href='javascript:openXiangce("+obj.id+")'><img onerror='handleImgLoadError2(event);' onload='AutoSize(this,140,140)' src='"+obj.url+"' width='140' height='140' /></a></div><p><div class='xiangce_name'>"+obj.imgCount+" 张</div><a href='javascript:toUpdateArt(1,"+obj.id+");' class='xiangce_sl'>"+obj.title+"</a><p><div class='xiangce_name'><a href='javascript:toDelArt("+obj.id+",1);' class='czjl_title_link'>删除</a></div><font style='color: #999'>"+obj.creatTime.substring(0,10)+"</font></p></li>";
				} else if(type == 2) {
					html1 += "<tr><td align='center'><a href='javaScript:openMovie(\""+obj.attachment+"\",2);' class='czjl_title_link'>"+obj.title+"</a></td><td align='left'>"+obj.intro+"</td><td align='center'>"+obj.title+"</td><td align='center'><a href='javaScript:toUpdateArt(2,"+obj.id+");' class='czjl_title_link'>修改</a>&nbsp;<a href='javascript:toDelArt("+obj.id+",2);' class='czjl_title_link'>删除</a></td></tr>";
				} else if(type == 3) {
					html2 += "<tr><td align='center'><a href='javaScript:openMovie(\""+obj.attachment+"\",3);' class='czjl_title_link'>"+obj.title+"</a></td><td align='left'>"+obj.intro+"</td><td align='center'>"+obj.title+"</td><td align='center'><a href='javaScript:toUpdateArt(3,"+obj.id+");' class='czjl_title_link'>修改</a>&nbsp;<a href='javascript:toDelArt("+obj.id+",3);' class='czjl_title_link'>删除</a></td></tr>";
				}
			}
			if(type == 1) {
				$("#xiangce_div").html("");
				$("#xiangce_div").html(html + "</ul>");
			} else if(type == 2) {
				$("#shipin_table").html("");
				$("#shipin_table").html(html1);
			} else if(type == 3) {
				$("#yinpin_table").html("");
				$("#yinpin_table").html(html2);
			}
			
			getUserInfo1();
		   $(document.body).height($("#main_content").height() + 350);
		}
	});
}

function toDelArt(id, type){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/artInfo!delArtInfo.htm?id='+id,
			function(data){
				if(data=="1"){
					getUserArt(type);
				}
			},"html");
		},
		cancel: true
	});
}

function toAddArt(sign){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign,{width:750,height:680,resize:false,lock:true});
}
function toUpdateArt(sign,id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&sign='+sign,{width:550,height:450,lock:true,resize: false});
}

function openXiangce(id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id='+id+"&userId=<s:property value='#request.userId'/>",{width:900,height:550,resize:false,lock:true,close: 
		function () {
			getUserArt(1);
		}});
}

function openMovie(swfurl, type){
	var title = "";
	if(type == 2) {
		title = "视频播放";
	} else {
		title = "音频播放";
	}
	if(swfurl != ''){
		art.dialog({
			padding: 0,
			title: title,
			lock: true,
			content: "<embed src=\""+swfurl+"\" quality=\"high\" width=\"560\" height=\"480\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"
		});
	}
}

var flashvars = {
	"uploadServerUrl":"./userinfo!upLoadIndexHeadImage.htm"
};
var params = {
	wmode:"opaque",
	width:700,
	height:600,
	type:"application/x-shockwave-flash"	
};
var attributes = {
	
};

swfobject.embedSWF("../theme/flex/indexHeadImage.swf", "altContent", "600", "500", "9.0.0", "expressInstall.swf", flashvars, params, attributes);

function avatar_success() {
	//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
	var myDate = new Date();
	$("#indexHeadImg").attr("src", "/stageUpload/indexHeadImage/<s:property value='#request.userId'/>.png?date=" + myDate.getTime());
	getUserInfo1();
	getUserInfo2();
}
			
//修改密码
function updatePass(){
	art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdatePassWord.htm',{lock:true,resize: false});
}

//修改邮箱
function updateEmail(){
	art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdateEmail.htm',{lock:true,resize: false});
}

//实名认证
function realName(){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=4',{lock:true,resize: false});
}

//修改头像
function updateTouxiang(){
	if(updateFlag) {
		if(checknull()){
			art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=5',{lock:true,resize: false});
			$.ajax({
			   url:"<%=request.getContextPath() %>/member/userinfo!saveOrUpdate.htm",
			   type:'POST',
			   data:$("#jcxxForm").serialize(),
			   success:function(data){
				   if(data == 1){
					   getUserInfo();
				   }
			   }
			});
		}
	} else {
		art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=5',{lock:true,resize: false});	
	}
	
}

function tishi(content){
	art.dialog.tips(content);
}

function checknull(){

	var nickName=$("#nickName").val();
	var mobile=$("#mobile").val();

	if(nickName==""){
		//$("#yzxx").text("");
		//$("#yzxx").append("【昵称】不能为空！");
		art.dialog.tips("【昵称】不能为空！", 2);
		return false;
	}
	
	if(mobile==""){
		//$("#yzxx").text("");
		//$("#yzxx").append("【手机】不能为空！");
		art.dialog.tips("【手机】不能为空！", 2);
		return false;
	}
	return true;
}

function jcxx_submit(){
	if(checknull()){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/userinfo!saveOrUpdate.htm",
		   type:'POST',
		   data:$("#jcxxForm").serialize(),
		   success:function(data){
			   if(data == 1){
				   art.dialog.tips("保存成功！", 1);
				   getUserInfo();
				   
				   var i = 0;
				   var t=setInterval(function(){
						if(i == 1) {
							showContent(2, 2);
							getUserInfo2();
							clearInterval(t);
						}
						i++;
				   }, 1000);
				   
			   }
		   }
		});
	}
}

function showContent(i, type) {
	$(".tabClass").removeClass("change");
	$("#tab" + i).addClass("change");
	
	saveCookie(i);
	
	if($("#jcxxTd" + i).css("display") == "none") {
		
		if(i == 2) {
			getUserInfoCost();
		} else if(i == 3) {
			getUserInfoGrowth();
		} else if(i == 4) {
			getUserArt(1);
		} else if(i == 5) {
			getUserArt(2);
		} else if(i == 6) {
			getUserArt(3);
		} else if(i == 7) {
		   $(document.body).height($("#main_content").height() + 880);
		}
		
		$("#jcxxTd" + i).css("display", "block");
		$("#btn" + i).attr("class", "shouqi");
	} else {
		if(type != 1) {//点击横向菜单 只打开 不收起
			$("#jcxxTd" + i).css("display", "none");
			$("#btn" + i).attr("class", "zhankai");
		}
		$(document.body).height($("#main_content").height() + 350);
	}
	
	//if(type != 1) {
		TargetTo("jcxxTd" + i);
	//}
}
function updateEmailOrMobile(flag){
		art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdateEmail.htm?flag='+flag,{lock:true,resize: false
	});
	}

//页面内跳转
function TargetTo(id){
	$("html,body").animate({scrollTop: $("#"+id).offset().top-68}, 500); 
}

var updateFlag = false;
function setUpdateFlag() {
	updateFlag = true;
}
</script>
  </head>
  <body>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>

<div style="height:auto!important; width:1003px; margin:auto;" id="main_content">
  <!-- 主内容开始 -->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 
        -->
        <div id="left_menu" style="min-height:400px;">
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="1"></s:param>
        </s:action>
        </div>
       <!-- 会员 左导航 结束 -->
</td>
        <td width="850" align="left" valign="top" style="padding-left:10px">
        <div class="your_position
">您的位置：<a >首页</a> > <a >个人信息</a></div>



<!-- 导航 开始 -->
<div class="right_tab">
<ul>
<li><a id="tab1" class="tabClass change" onclick="showContent(1,1)" href="javascript:void(0)">基础信息<img style="padding-left:3px; display:none;" id="img1" src="" /></a></li>
<li><a id="tab2" class="tabClass" onclick="showContent(2,1)" href="javascript:void(0)">职业技能<img id="img2" style="padding-left:3px; display:none;" src="" /></a></li>
<li><a id="tab3" class="tabClass" onclick="showContent(3,1)" href="javascript:void(0)">成长经历<img id="img3" style="padding-left:3px; display:none;" src="" /></a></li>
<li><a id="tab4" class="tabClass" onclick="showContent(4,1)" href="javascript:void(0)">相册<img id="img4" style="padding-left:3px; display:none;" src="" /></a></li>
<li><a id="tab5" class="tabClass" onclick="showContent(5,1)" href="javascript:void(0)">视频<img id="img5" style="padding-left:3px; display:none;" src="" /></a></li>
<li><a id="tab6" class="tabClass" onclick="showContent(6,1)" href="javascript:void(0)">音频<img id="img6" style="padding-left:3px; display:none;" src="" /></a></li>
<li><a id="tab7" class="tabClass" onclick="showContent(7,1)" href="javascript:void(0)">首页照片<img id="img7" style="padding-left:3px; display:none;" src="" /></a></li>
</ul>
</div>


<div style="width:760px; height:30px; line-height:30px; margin-top:40px;" class="">
<div style="float:left;">个人信息完整度：（<span style="color:red;">*</span>为必填项）</div>
<div class="wcd">
<div class="wcd-1"></div>
<div class="wcd-2"></div>
<div class="wcd-3"></div>
</div>
<div id="wcdDiv"></div>
</div>

<!-- 导航 结束 -->

<!-- 基础信息 开始 -->
<table width="810">
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">基础信息</div>
      <div style="margin-right:15px; float:right;">
        <!-- <div class="baocun" onclick="jcxx_submit()"></div> -->
        <div class="shouqi" id="btn1" onclick="showContent(1)"></div>
      </div></td>
  </tr>
  <tr>
    <td id="jcxxTd1" align="left" class="jcxxContent">
    	<form name="jcxxForm" id="jcxxForm" action="userinfo!saveOrUpdate.htm?sign=1" method="post">
	      <input type="hidden" name="userInfo.id" id="userId" /> 
	      <input type="hidden" name="sign" id="sign" /> 
	      <div style="height:10px;"></div>
    	<div id="TabTab03Con">
		<div class="content">
		<div class="content_left">
		<ul>
		<li>
		    <div class="name">用户名：</div>
		    <div class="xinxi"><span id="userName"></span></div>
		    <a href="javascript:updatePass();"  class="zhezhaoLink">修改密码</a>
		</li>
		<li>
		    <div class="name"><div id="nickName_span"></div></div>
		    <input type="text" onchange="setUpdateFlag()" name="userInfo.nickName" id="nickName"  maxlength="50" />
		    <p>昵称，你的个性象征</p>
		</li>
		
		<li>
		    <div class="name"><span>*</span> 真实姓名：</div>
		   <input type="text" onchange="setUpdateFlag()" name="userInfo.name" id="name" />&nbsp;
		    <a href="javascript:realName();" class="zhezhaoLink">实名认证</a>
		</li>
		    <div class="tishi">用于提升账号的安全性和信任级别。<br />
		认证后的企业能够获得更多合作机会和优先权。</div>
		
		<li>
		   <div class="name"> 性别：</div>
		   <input onchange="setUpdateFlag()" name="userInfo.sex" type="radio" id="radio1" value="1" class="yuan" />
		   <dd>男</dd> 
		    <input onchange="setUpdateFlag()" name="userInfo.sex" type="radio" id="radio2" value="2" class="yuan" />
		   <dd>女</dd>
		</li>
		
		<li>
		    <div class="name" id="birthday_span"></div>
		   <input onchange="setUpdateFlag()" type="text" name="userInfo.birthday" id="birthday" class="nc_input Wdate" style="width:120px;" onClick="WdatePicker()" />
		
		</li>
		
		<li>
		    <div class="name"> 身高：</div>
		    <input onchange="setUpdateFlag()" type="text" name="userInfo.height"  onkeydown="checkKeyForFloat(this.value,event)" class="duan" id="height" /><font>（CM）</font>
		    <div class="name3"> 体重：</div>
		    <input onchange="setUpdateFlag()" type="text" name="userInfo.weight"  onkeydown="checkKeyForFloat(this.value,event)" class="duan" id="weight" /><font>(KG)</font>
		</li>
		
		<li>
		    <div class="name"> 胸围：</div>
		    <input onchange="setUpdateFlag()" type="text" name="userInfo.heartSize"  onkeydown="checkKeyForFloat(this.value,event)" class="duan" id="heartSize" /><font>（CM）</font>
		    <div class="name3"> 腰围：</div>
		    <input onchange="setUpdateFlag()" type="text" name="userInfo.waistSize"  onkeydown="checkKeyForFloat(this.value,event)" class="duan" id="waistSize" /><font>（CM）</font>
		    <div class="name3"> 臀围：</div>
		    <input onchange="setUpdateFlag()" type="text" name="userInfo.bottocksSize"  onkeydown="checkKeyForFloat(this.value,event)" class="duan" id="bottocksSize" /><font>（CM）</font>
		</li>
		
		<li>
		    <div class="name"><span>*</span> 所在地：</div>
				<input type="hidden" id="provice_text" />
                  <input type="hidden" id="city_text" />
                  <select onchange="setUpdateFlag()" name="userInfo.provice" id="provice" class="sel_jcxx"></select>
                  <select onchange="setUpdateFlag()" name="userInfo.city" id="city" class="sel_jcxx"></select>
		</li>
		
		<li>
		    <div class="name"><span>*</span> 详细地址：</div>
		    <input />
		</li>
		
		<li>
		    <div class="name"> 手机：</div>
		    <div class="xinxi"><input name="userInfo.mobile" id="mobile" /></div>
		    <a href="javascript:updateEmailOrMobile(2);"  class="zhezhaoLink">修改</a>
		</li>
		
		<li>
		    <div class="name"> E-mail：</div>
		    <div class="xinxi"><span id="email_span"></span></div>
		    <a href="javascript:updateEmailOrMobile(1);" class="zhezhaoLink">修改</a>
		</li>
		
		<li>
		    <div class="name"> 毕业院校：</div>
		    <input onchange="setUpdateFlag()" type="text" name="userInfo.school" id="school"   />
		</li>
		
		<li>
		    <div class="name"> 个人介绍：</div>
		    <textarea onchange="setUpdateFlag()" name="userInfo.introduction" id="introduction" cols="45" rows="5" ></textarea>
		</li>
		
		</ul>
		</div>
		
		<div class="baocun1">
			<a href="javascript:jcxx_submit();">保存</a>
		</div>
		<div class="touxiang">
		<div><img style="border:1px #E3E3E3 solid; padding:2px;" onerror="handleImgLoadError(event);" id="photo_pic" width="110" height="100" /></div>
		<a href="javascript:updateTouxiang();"   class="zhezhaoLink">修改头像</a>
		<a href="javascript:updateTouxiang();"  class="zhezhaoLink">上传</a>
		</div>
		</div>
		</form>
      <!-- <form name="jcxxForm" id="jcxxForm" action="userinfo!saveOrUpdate.htm?sign=1" method="post">
      <input type="hidden" name="userInfo.id" id="userId" /> 
      <input type="hidden" name="sign" id="sign" /> 
      <div style="height:10px;"></div>
      <table width="780" border="0" cellpadding="0" cellspacing="0" class="jcxx_box_01">
        <tr>
          <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0" class="jcxx_box_01_01">
              <tr>
                <td width="100" align="right">用 户 名：</td>
                <td width="220"><span id="userName"></span>&nbsp;<a href="javascript:updatePass();" class="a_link">修改密码</a></td>
                <td width="80" align="right"><span style="color:red;">*</span><span id="nickName_span"></span></td>
                <td width="200"><input type="text" onchange="setUpdateFlag()" name="userInfo.nickName" id="nickName"  maxlength="50" class="nc_input" /></td>
              </tr>
              <tr>
                <td align="right">真实姓名：</td>
                <td><input type="text" onchange="setUpdateFlag()" name="userInfo.name" id="name" maxlength="50" class="nc_input" />&nbsp;<a href="javascript:realName();" class="a_link">认证</a></td>
                <td align="right">性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
                <td>
                  <input onchange="setUpdateFlag()" name="userInfo.sex" type="radio" id="radio1" value="1"  />男&nbsp;
                  <input onchange="setUpdateFlag()" name="userInfo.sex" type="radio" id="radio2" value="2" /> 女
                </td>
              </tr>
              <tr>
                <td align="right"><span style="color:red;">*</span>所 在 地：</td>
                <td>
                  <input type="hidden" id="provice_text" />
                  <input type="hidden" id="city_text" />
                  <select onchange="setUpdateFlag()" name="userInfo.provice" id="provice" class="sel_jcxx"></select>
                  <select onchange="setUpdateFlag()" name="userInfo.city" id="city" class="sel_jcxx"></select>
                </td>
                <td align="right"><span id="birthday_span"></span></td>
                <td><input onchange="setUpdateFlag()" type="text" name="userInfo.birthday" id="birthday" class="nc_input Wdate" style="width:90px;" onClick="WdatePicker()" /></td>
              </tr>
            </table>
          </td>
          <td align="center" width="170">
            <img style="border:1px #E3E3E3 solid; padding:2px;" onerror="handleImgLoadError(event);" id="photo_pic" width="110" height="100" />
            <div><span onclick="updateTouxiang()" style="cursor:pointer; color:blue;">>>编辑</span>&nbsp;<span onclick="delHeadImg()" style="padding-left:20px; cursor:pointer; color:blue;">>>删除</span></div>
          </td>
        </tr>
        <tr height="15">
          <td colspan="2" style="color:#F00;" id="yzxx">&nbsp;</td>
        </tr>
      </table>
      
      <table border="0" align="center" cellpadding="0" cellspacing="0" class="jcxx_box_02">
        <tr>
          <td align="right">血型：&nbsp;</td>
          <td colspan="3" align="left">
          <select onchange="setUpdateFlag()" name="userInfo.booldType" id="booldType" class="sel_jcxx">
            <option value="A">A</option>
            <option value="B">B</option>
            <option value="AB">AB</option>
            <option value="O">O</option>
          </select>
          </td>
        </tr>
        <tr>
          <td width="100" align="right">身高：&nbsp;</td>
          <td width="124" align="left"><input onchange="setUpdateFlag()" type="text" name="userInfo.height" maxlength="6" onkeydown="checkKeyForFloat(this.value,event)" class="sg_input" id="height" />&nbsp;<span class="dw_style">(CM)</span></td>
          <td width="65" align="right">体重：&nbsp;</td>
          <td width="475" align="left"><input onchange="setUpdateFlag()" type="text" name="userInfo.weight" maxlength="6" onkeydown="checkKeyForFloat(this.value,event)" class="sg_input" id="weight" />&nbsp;<span class="dw_style">(KG)</span></td>
        </tr>
        <tr>
          <td align="right" class="pad_left">三围：&nbsp;</td>
          <td colspan="3" align="left">
            <input onchange="setUpdateFlag()" type="text" name="userInfo.heartSize" maxlength="6" onkeydown="checkKeyForFloat(this.value,event)" class="sg_input" id="heartSize" />&nbsp;<span style="line-height:36px; vertical-align:middle; padding-bottom:10px;">胸</span>
            <input onchange="setUpdateFlag()" type="text" name="userInfo.waistSize" maxlength="6" onkeydown="checkKeyForFloat(this.value,event)" class="sg_input" id="waistSize" />&nbsp;腰&nbsp;
            <input onchange="setUpdateFlag()" type="text" name="userInfo.bottocksSize" maxlength="6" onkeydown="checkKeyForFloat(this.value,event)" class="sg_input" id="bottocksSize" />&nbsp;臀
            <span class="dw_style">(CM)</span>
          </td>
        </tr>
        <tr height="15">
          <td colspan="4" style="color:#F00;" id="yzxx">&nbsp;</td>
        </tr>
      </table>
      
      <table width="780" border="0" align="center" cellpadding="0" cellspacing="0" class="jcxx_box_03">
        <tr>
          <td width="82" align="right"><span>*</span>手机：</td>
          <td width="175" align="left"><input onchange="setUpdateFlag()" type="text" name="userInfo.mobile" onkeydown="checkKeyForInt(this.value,event)"  maxlength="20" class="lxfs_input" id="mobile" /></td>
          <td>
            <input onchange="setUpdateFlag()" type="radio" name="userInfo.mobileRadio" value="1" id="mobileRadio1" /><span style="cursor:pointer; color:#000;" onclick="$('#mobileRadio1').attr('checked', true)">不公开</span>
            <input onchange="setUpdateFlag()" type="radio" name="userInfo.mobileRadio" value="2" id="mobileRadio2" /><span style="cursor:pointer; color:#000;" onclick="$('#mobileRadio2').attr('checked', true)">公开</span>
            <input onchange="setUpdateFlag()" type="radio" name="userInfo.mobileRadio" value="3" id="mobileRadio3" /><span style="cursor:pointer; color:#000;" onclick="$('#mobileRadio3').attr('checked', true)">仅好友可见</span>&nbsp;&nbsp;&nbsp;&nbsp;
          </td>
        </tr>
        <tr>
          <td align="right">QQ：</td>
          <td align="left">
            <input onchange="setUpdateFlag()" type="text" name="userInfo.qq" maxlength="20" onkeydown="checkKeyForInt(this.value,event)" class="lxfs_input" id="qq" />
          </td>
          <td>
            <input onchange="setUpdateFlag()" type="radio" name="userInfo.qqRadio" value="1" id="qq1" /><span style="cursor:pointer; color:#000;" onclick="$('#qq1').attr('checked', true)">不公开</span>
            <input onchange="setUpdateFlag()" type="radio" name="userInfo.qqRadio" value="2" id="qq2" /><span style="cursor:pointer; color:#000;" onclick="$('#qq2').attr('checked', true)">公开</span>
            <input onchange="setUpdateFlag()" type="radio" name="userInfo.qqRadio" value="3" id="qq3" /><span style="cursor:pointer; color:#000;" onclick="$('#qq3').attr('checked', true)">仅好友可见</span>&nbsp;&nbsp;&nbsp;&nbsp;
          </td>
        </tr>
        <tr>
          <td align="right">电话：</td>
          <td align="left">
            <input onchange="setUpdateFlag()" type="text" name="userInfo.telPhone" maxlength="20" class="lxfs_input" id="telPhone" /></td>
          <td align="left">E-mail：<span id="email_span"></span>&nbsp;<a href="javascript:updateEmail();" class="a_link">修改</a></td>
        </tr>
        <tr height="15">
          <td colspan="3" style="color:#F00;" id="yzxx"></td>
        </tr>
      </table>
      
      <table width="780" border="0" align="center" cellpadding="0" cellspacing="0" class="box_01">
        <tr>
          <td width="100" align="right">学历:</td>
          <td colspan="3" align="left"><input onchange="setUpdateFlag()" type="text" class="input_xl" name="userInfo.education" maxlength="100" id="education" /></td>
        </tr>
        <tr>
          <td width="100" align="right">毕业院校:</td>
          <td align="left"><input onchange="setUpdateFlag()" type="text" class="input_xl" name="userInfo.school" id="school"  maxlength="100" /></td>
          <td width="100" align="right">所学专业:</td>
          <td align="left"><input onchange="setUpdateFlag()" type="text" class="input_xl" name="userInfo.major" id="major" maxlength="100" /></td>
        </tr>
        <tr>
          <td align="right"><span id="grjs_span"></span></td>
          <td colspan="3" height="180" align="left">
            <textarea onchange="setUpdateFlag()" name="userInfo.introduction" id="introduction" cols="45" rows="5" class="wby_box"></textarea></td>
        </tr>
        <tr height="15">
          <td colspan="4" style="color:#F00;" id="yzxx"></td>
        </tr>
      </table>
      </form>-->
    </td>
  </tr>


  <tr height="10"><td>&nbsp;</td></tr>
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">职业技能</div><div style="margin-right:15px; float:right;">
        <div class="zhankai" id="btn2" onclick="showContent(2)"></div></div></td>
  </tr>
  <tr>
    <td id="jcxxTd2" align="left" class="jcxxContent">
      <table width="788" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
              <tr>
                <td height="24" align="right"><a href="javascript:toAddCost();" class="a_link"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
              </tr>
            </table>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table" id="cyjn_table">
              
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>


  <tr height="10"><td>&nbsp;</td></tr>
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">成长经历</div><div style="margin-right:15px; float:right;">
        <div class="zhankai" id="btn3" onclick="showContent(3)"></div></div></td>
  </tr>
  <tr>
    <td id="jcxxTd3" align="left" class="jcxxContent">
      <table width="788" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <table id="addGrowth_table" width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
              <tr>
                <td height="24" align="right"><a href="javascript:toAddGrowth();" class="a_link"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
              </tr>
            </table>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table" id="czjl_table">
              
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>


  <tr height="10"><td>&nbsp;</td></tr>
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">相册</div>
    	<div style="margin-right:15px; float:right;">
        <div class="zhankai" id="btn4" onclick="showContent(4)"></div></div>
        </td>
  </tr>
  <tr>
    <td id="jcxxTd4" align="left" class="jcxxContent">
     <!--  <table width="788" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <table width="788" border="0" align="left" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
              <tr>
                <td align="center" width="700"><div style="color:#0099ff; cursor:pointer;">出来混，没有像样的作品怎么行？，第1舞台帮您解决，点击查看套餐</div></td>
                <td height="24" align="right"><a href="javaScript:toAddArt(1);"><img src="<%=request.getContextPath()%>/theme/images/cjxc_ico.jpg" width="80" height="24" /></a></td>
              </tr>
			</table>
            <div class="xiangce_list" id="xiangce_div">
			
			</div>
          </td>
        </tr>
      </table>--> 
      	<div class="zuopin" style="padding-left: 20px;">
			
			<div class="zuopin_bt">
			<a href="javaScript:toAddArt(1);">创建相册</a>
			<a href="#">设置首页推荐图</a>
			</div>
			 <div class="xiangce_list" id="xiangce_div">
			
			</div>
    </td>
  </tr>


  <tr height="10"><td>&nbsp;</td></tr>
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">视频</div><div style="margin-right:15px; float:right;">
        <div class="zhankai" id="btn5" onclick="showContent(5)"></div></div></td>
  </tr>
  <tr>
    <td id="jcxxTd5" align="left" class="jcxxContent">
      <table width="788" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
              <tr>
                <td align="center" width="700"><div style="color:#0099ff; cursor:pointer;">出来混，没有像样的作品怎么行？，第1舞台帮您解决，点击查看套餐</div></td>
                <td height="24" align="right"><a href="javascript:toAddArt(2);" class="a_link"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
              </tr>
            </table>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table" id="shipin_table">
              
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>


  <tr height="10"><td>&nbsp;</td></tr>
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">音频</div><div style="margin-right:15px; float:right;">
        <div class="zhankai" id="btn6" onclick="showContent(6)"></div></div></td>
  </tr>
  <tr>
    <td id="jcxxTd6" align="left" class="jcxxContent">
      <table width="788" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
              <tr>
                <td height="24" align="right"><a href="javascript:toAddArt(3);" class="a_link"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
              </tr>
            </table>
            <table width="788" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table" id="yinpin_table">
              
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  

  <tr height="10"><td>&nbsp;</td></tr>
  <tr>
    <td align="left" class="jcxxHead"><div style="margin-left:15px; float:left;">首页推荐</div><div style="margin-right:15px; float:right;">
        <div class="zhankai" id="btn7" onclick="showContent(7)"></div></div></td>
  </tr>
  <tr>
    <td id="jcxxTd7" align="left" class="jcxxContent">
      <div style="color:#0099ff; cursor:pointer; width:700px; text-align:center; padding-top:10px;">出来混，没有像样的作品怎么行？，第1舞台帮您解决，点击查看套餐</div>
      <div style=" float:left; margin-top:15px;">
        <div id="altContent"></div>
      </div>
      <div id="avatar_priview" style=" margin-top:15px;float: right; margin-right:10px;"><img id="indexHeadImg" width="182" height="167" src="/stageUpload/indexHeadImage/<s:property value='#request.userId'/>.png?date=<%=new Date() %>" onerror="handleImgLoadError1(event);" /></div>        
    </td>
  </tr>
</table>
<div style="height:10px;"></div>
</td>
</tr>
</table>
</div>

<!-- 主内容结束 -->

  </body>
</html>