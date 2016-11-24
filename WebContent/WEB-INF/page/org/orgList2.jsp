<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns:wb=“http://open.weibo.com/wb”>
  <head>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/jquery-1.7.1.min.js"></SCRIPT>
		<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/jquery.artDialog.js"></script>
<%-- 	<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/plugins/iframeTools.js"></script> --%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css"></link>
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>
	<link href="<%=path %>/theme/css2/gerenye.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/qiyezhongxin.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css"></link>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	
	
	<style type="text/css">
		.pointer{
			cursor: pointer;
		}
		.showCss{
			cursor: pointer;
			background-color: black;
			z-index: 1001;
			position: absolute;
			-moz-opacity:0.8;
			opacity:.65;
			filter: alpha(opacity=80);
		}
		.hideCss{
			
		}
		
	</style>

	<script type="text/javascript">  
 
	
var pageNum = 0;
var total = 0;
$().ready(function(){	
		var image = '<s:property value="#request.image"/>';
		if(image==1){
			$("#showList").css("display","none");
			$("#caiyiPageTA").css("display","none");
			$("#wank1").css("display","none");
			$("#photoList").css("display","");
			$("#fanhui").css("display","");
			$("#fenxiang").css("display","none");
		}else{
			$("#wank1").css("display","");
			$("#showList").css("display","");
			$("#caiyiPageTA").css("display","");
			$("#photoList").css("display","none");
			$("#fanhui").css("display","none");
			$("#fenxiang").css("display","");
		}
		//动态评分
		var imgSrc = '<img src=\"theme/images2/tu96.jpg\" />&nbsp;';
		var imgSrc1 = '<img src=\"theme/images2/x2.png\" />&nbsp;';
		var imgSrc2 = '<img src=\"theme/images2/x1x.png\" />&nbsp;';
		var msGradeValue = '<s:property value="#request.userEvaluation.msGradeValue"/>';
		var GradeValue2 = (msGradeValue*10)%10;
		var GradeValue1 = (msGradeValue*10-GradeValue2)/10;
		//alert(msGradeValue+"  ,"+msGradeValue1+"  ,"+msGradeValue2);
			for(var j = 0; j < GradeValue1; j++) {
				$("#msGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#msGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#msGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#msGrade").append(imgSrc2);
				}
			}

		var tdGradeValue = '<s:property value="#request.userEvaluation.tdGradeValue"/>';
		GradeValue2 = (tdGradeValue*10)%10;
		GradeValue1 = (tdGradeValue*10-GradeValue2)/10;
			for(var j = 0; j < GradeValue1; j++) {
				$("#tdGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#tdGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#tdGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#tdGrade").append(imgSrc2);
				}
			}

		var zlGradeValue = '<s:property value="#request.userEvaluation.zlGradeValue"/>';
		GradeValue2 = (zlGradeValue*10)%10;
		GradeValue1 = (zlGradeValue*10-GradeValue2)/10;
			for(var j = 0; j < GradeValue1; j++) {
				$("#zlGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#zlGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#zlGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#zlGrade").append(imgSrc2);
				}
			}

		var grade = '<s:property value="#request.userInfo.grade"/>';
		var sellerGrade = '<s:property value="#request.userInfo.sellerGrade"/>';
		var imgG1 = '<img src=\"theme/images2/m21.gif\" />&nbsp;';
		var imgG2 = '<img src=\"theme/images2/m22.gif\" />&nbsp;';
		var imgG3 = '<img src=\"theme/images2/m23.gif\" />&nbsp;';
		var imgSG1 = '<img src=\"theme/images2/m41.gif\" />&nbsp;';
		var imgSG2 = '<img src=\"theme/images2/m42.gif\" />&nbsp;';
		var imgSG3 = '<img src=\"theme/images2/m43.gif\" />&nbsp;';
		if(grade<=3&&grade!=null){
			for(var j = 0; j < grade; j++) {
				$("#grade").append(imgG1);
			}
		}else if(grade>3&&grade<=6){
			for(var j = 0; j < (grade-3); j++) {
				$("#grade").append(imgG2);
			}
		}else{
			for(var j = 0; j < (grade-6); j++) {
				$("#grade").append(imgG3);
			}
		}
		if(sellerGrade<=3&&sellerGrade!=null){
			for(var j = 0; j < sellerGrade; j++) {
				$("#sellerGrade").append(imgSG1);
			}
		}else if(sellerGrade>3&&sellerGrade<=6){
			for(var j = 0; j < (sellerGrade-3); j++) {
				$("#sellerGrade").append(imgSG2);
			}
		}else{
			for(var j = 0; j < (sellerGrade-6); j++) {
				$("#sellerGrade").append(imgSG3);
			}
		}

		
		
});

	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/temp/photo.jpg';
  	}
  	function handleImgLoadError1(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/images2/tu209-1.png';
  	}
  	function handleImgLoadError2(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/images2/tu209-2.png';
  	}
  	function handleImgLoadError3(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/images2/tu209-3.png';
  	}
  	 
  	 function indexImgLoadError(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
  	}
  	
	function setTab03Syn(i,obj){
		for(var j = 1 ; j<=2 ; j++){
			if(i==j){
				$("#TabTab03Con"+i).show();
				$("#font"+i).addClass("change");
			}else{
				$("#TabTab03Con"+j).hide();
				$("#font"+j).removeClass("change");
			}
		}
	}
	
	function refresh(){
		window.location.reload();
	}
	
	function sendMessage(){
			var a = ${qyUserInfo};
			if(a==1){
				art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<s:property value="#request.user.parentID"/>',{width:550,height:300,resize: false});
			}else{
				art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<s:property value="#request.userInfo.userId"/>',{width:550,height:300,resize: false});
			}
			
 }
	 function qianYueTa(){
	     	<%if(userSession==null){%>
	  	    	parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm?r=<%=HttpSessionHelper.urlEncode("/presonList.htm?id="+request.getParameter("id"))%>');
	  	    	//openWindowLogin();
	  	    <%  }else{  int loginUserId=userSession.getId();%>
	  	    var bqyUserId=<s:property value="#request.userInfo.userId"/>;
	  	    if(bqyUserId==<%=loginUserId %>){
	  	    	art.dialog.tips("不能预约自己！");
	  	    }else{
				var p=window.open("about:blank"); 
		  	    $.ajax({
				   url:"<%=request.getContextPath() %>/member/business!checkUserCost.htm?bqyUserId=<s:property value='#request.userInfo.userId'/>",
				   type:'POST',
				   success:function(data){
							
					   if(data=="2"){
						   	p.close();
							art.dialog.tips("该用户未添加职业，不能预约!");
					   } else {
					   		p.location = '<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>'; //toOrder
					   }
				   }
				});
				//art.dialog.open('<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>',{width:680,height:455,resize: false});
			 }
			  <%  }%>
	     }
	
	function toGrowthView(id){
		art.dialog.open('<%=request.getContextPath() %>/growth!toGrowth.htm?id='+id,{width:530,height:380,resize: false});
	}
	function alertInfo(content){
		art.dialog({
			content:content,
			width:300
		});
	}
	
	function addFriend(friendId){
		$.post('<%=request.getContextPath()%>/friend!addFriend.htm',{friendId:friendId},function(data){
		  if(data==1){
				location.reload() ;
		  }else if(data == 2){
			  art.dialog.tips('不能关注自己');
		  }else if(data == 3){
			  art.dialog.tips('登陆后才能关注！');
		  }else if(data == 4){
			  art.dialog.tips('已关注TA！');
		  }
		},"html");
	 }
	
	function addDing(dingUserId,flag){
		$.post('<%=request.getContextPath()%>/friend!addDing.htm',{dingUserId:dingUserId,flag:flag},function(data){
		  if(data==1){
				location.reload() ;
		  }else if(data == 2&&flag!=-1){
			  art.dialog.tips('不能顶自己');
		  }else if(data == 3&&flag!=-1){
			  art.dialog.tips('登陆后才能顶！');
		  }else if(data == 4&&flag!=-1){
			  art.dialog.tips('您今天已经顶过ta了！');
		  }
		},"html");
	 }

	function showdetails(){
		$("#windows1").css("display","");
	}
	function hidedetails(){
		$("#windows1").css("display","none");
	}
	function showdetails1(){
		$("#windows2").css("display","");
	}
	function hidedetails1(){
		$("#windows2").css("display","none");
	}
	 function hidePhoto(){alert(document.getElementById("fade").style.display);
  	//document.getElementById("light").style.display="none";
  	//document.getElementById("fade").style.display="none";
  	$("#light").css("display","none");
  	$("#fade").css("display","none");
  }
	function changeCss(e,opera,flag,id){
		if(opera==1){
			if(flag==3){
				$("#pro").css("display","");
			}else if(flag==1){
				$("#pre").css("display","");
			}else if(flag==4){
				$("#photo").css("display","");
			}else if(flag==5){
				$("#photo_"+id).css("display","");
			}else if(flag==6){
				$("#movie_"+id).css("display","");
			}else if(flag==7){
				$("#voice_"+id).css("display","");
			}else if(flag==8){
				$("#introduct").css("display","");
			}else if(flag==9){
				$("#Grow").css("display","");
			}else if(flag==10){
				$("#touxiang").css("display","");
			}
			
		}else{
			if(flag==3){
				$("#pro").css("display","none");
			}else if(flag==1){
				$("#pre").css("display","none");
			}else if(flag==4){
				$("#photo").css("display","none");
			}else if(flag==5){
				$("#photo_"+id).css("display","none");
			}else if(flag==6){
				$("#movie_"+id).css("display","none");
			}else if(flag==7){
				$("#voice_"+id).css("display","none");
			}else if(flag==8){
				$("#introduct").css("display","none");
			}else if(flag==9){
				$("#Grow").css("display","none");
			}else if(flag==10){
				$("#touxiang").css("display","none");
			}
		}
	}
	function updatePro1(id,flag,swf){
		if(flag==1){
			art.dialog.open('<%=request.getContextPath() %>/member/presonList!updateView.htm?id='+id+'&userId=<s:property value="#request.id"/>&flag='+flag,{width:800,height:550,close: function () {
				     		 location.reload();
				  		}});
		}else if(flag==2){
			art.dialog.open('<%=request.getContextPath() %>/member/presonList!updateView.htm?id='+id+'&userId=<s:property value="#request.id"/>&flag='+flag+'&swf='+swf,{width:1100,height:550,close: function () {
				     		 location.reload();
				  		}});
		}else if(flag==3){
			art.dialog.open('<%=request.getContextPath() %>/member/presonList!updateView.htm?id='+id+'&userId=<s:property value="#request.id"/>&flag='+flag+'&swf='+swf,{width:1100,height:550,close: function () {
				     		 location.reload();
				  		}});
		}
		
	}
	function updatePro(id,flag){
		art.dialog.open('<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign='+flag+'&&id='+id,
			{
			width: 800,
	    	height: 550,
	    	title:"艺人信息维护",
	   		//lock:true,
			close: function () {
	     		 location.reload();
	  			}
			}
		);
	}

	function toAdd(sign){
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign+'&userId=<s:property value="#request.id"/>&flag=2',
		{width:550,height:480,close: function () {
				     		 location.reload();
				  		}});
	}
	
    function openEvaView(skillId){
    	art.dialog.open('<%=request.getContextPath()%>/member/presonList!addEvaluate.htm?skillId='+skillId,
		{width:560,height:600,close: function () {
				     		 location.reload();
				  		}});
    }
	var yrname="";
	var yrurl = "";
	var yrpic = "";
	var jiathis_config = new Array();
	var shareOfId = 0;
	function share(id,picId,url,e,intro,type){
	shareOfId = picId;
	//分享按钮
		 yrname = $("#yrNameId").val();
		 if(type!=1){
		 	yrurl = url;
		 	yrpic ="http://localhost:8080"+intro;
		 }else{
		 	yrurl = "http://d15t.cn/stage01/presonList.htm?id="+id+"&pic="+picId+"&photoFlag=1";
		 	yrpic ="http://d15t.cn"+url;
		 }
		 
		 jiathis_config={
			url:yrurl,
			sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
			summary:"我在第一舞台发现了ta，非常棒！",
			title:"超喜欢 #"+yrname+"#",
			pic:yrpic,
			shortUrl:false,
			hideMore:true
		}
	
		if(document.getElementById("aaa").style.display=="none"){
			$("#aaa").show().css({'top':$(e).offset().top+20,'left':$(e).offset().left});
		}else{
			$("#aaa").hide();
			 yrname = $("#yrNameId").val();
			 yrurl = $("#yrUrl").val();
			 yrpic = $("#yrPic").val();
			 jiathis_config={
				url:yrurl,
				sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
				summary:"我在第一舞台发现了ta，非常棒！",
				title:"超喜欢 #"+yrname+"#",
				pic:yrpic,
				shortUrl:false,
				hideMore:true
			}
		}	
	}
	
	function addShare(){
		$.ajax({
				   url:"<%=request.getContextPath() %>/member/presonList!addShare.htm?id="+shareOfId,
				   type:'POST',
				   success:function(data){
					   if(data=="1"){
					   } 
				   }
				});
	}
		

	</script>
	<script src="http://mat1.gtimg.com/app/openjs/openjs.js#autoboot=no&debug=no"></script>
	
	<style type="text/css">
/* 		.gr-nex2-right9 { width:100%; margin:10px auto;} */
/*          .gr-nex2-right9 ul { width:520px; margin:10px auto;} */
/* 		 .gr-nex2-right9 ul li { height:30px; line-height:30px; padding-left:16px; border-bottom:1px #ccc solid;} */
/* 		.gr-nex2-right9 ul li a { height:30px; line-height:30px; font-family:"微软雅黑","宋体"; color:#000; font-size:12px;} */
/* 		.gr-nex2-right9 ul li a:hover { height:30px; line-height:30px; font-family:"微软雅黑","宋体"; color:#D12127; font-size:12px;} */
		.gr-nex2-right9 ul li span { float:right; font-family:"微软雅黑","宋体"; color:#666; font-size:11px;}
		.container1 {
			width:224px;
			height:205px;
			position:relative;
			overflow:hidden;
			background-repeat:no-repeat;
			z-index:0;
			padding:1px;
			margin:0 auto;
			border:1px solid #D9D9D9;
		}
		.container2 {
			width:228px;
			height:20px;
			margin-top:10px;
			background-color: #EBEBEB;
		}
	</style>
  </head>
  <body style="background: url('theme/images2/grbj.gif');font-family: 微软雅黑;color: #333333">
  <jsp:include page="/WEB-INF/page/public/head2.jsp">
   <jsp:param value="no" name="titleType"/>
</jsp:include>
<div id='light' style='display:none;position:fixed;top:25%;left:0%;width:100%;;z-index:1002;overflow:auto;'>
			<table width="100%" style="height: 100%;">

				<tr>
					<td align="center" valign="middle">
						<table >
							<tr>
								<td align="right"> 
									<div style="color: #ffffff;cursor: pointer;" onclick="hidePhoto()">关闭</div>
								</td>
							</tr>
							<tr>
								<td>
									<img  onerror="indexImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png" width="110" height="100" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			</div>
<div id='fade' style='display:none; position:fixed;top:0%;left:0%;width:100%;height:100%;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.65;filter: alpha(opacity=80);'></div>

<img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg" style="z-index:1000;position:fixed; bottom:120px; _margin-bottom:120px;"/>
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
<!--top4-->
<div class="qy-banner">
  <div class="qy-bleft l"><img src="theme/images2/tu201.png" width="4" height="215"  /></div>
  <div class="gr-zhong l">
     <table border="0" width="100%" style="height: 177px;">
     	<tr>
     		<td valign="top">
     			<table width="130" style="height: 170px;margin-left: 8px;">
     				<tr>
     					<td valign="top">
     					<div style="border:1px solid #e3e3e3; padding:2px;width: 110px;">
     						<s:if test="#request.nowId==#request.userId"><div onmouseover="changeCss(this,1,10)" onmouseout="changeCss(this,2,10)" title="编辑" onclick="updatePro(<s:property value="#request.id"/>,5)">
		  						<div class="showCss" style="display: none;width: 110px;height: 100px;" id="touxiang">
		  							<table width="100%" style="height: 100px;">
		  								<tr>
		  									<td style="font-size: 14px;color: #eeeeee;font-weight: bold;" align="center">编辑</td>
		  								</tr>
		  							</table>
		  						</div>
		  					</s:if>
		  					<s:else>
		  						<div >
		  					</s:else>
		  						
     							<img  onerror="indexImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png" width="110" height="100" title="<s:property value="#request.userInfo.Introduction"/>" onclick="document.getElementById('light').style.display='';document.getElementById('fade').style.display='';" />
     							</div>
     							<div style="background-color: #11b7ee;cursor: pointer;" onclick="addFriend(<s:property value="#request.id"/>)">
     								<table>
     									<tr>
     										<td style="color: #ffffff;font-size: 14px;font-weight: bold;width: 100px;height: 30px;" align="center"><s:if test="#request.friendInfo==null">+加关注</s:if>
           									<s:else>已关注</s:else></td>
     									</tr>
     								</table>
     							</div>
     						</div>
     					</td>
     				</tr>
     				<tr>
     					<td title="老板分值：<s:property value="#request.userEvaluation.evaluation"/>">
     						老板等级：<span id="grade"></span>
     					</td>
     				</tr>
     				<tr>
     					<td title="艺人分值：<s:property value="#request.userEvaluation.sellerEvaluation"/>">
     						艺人等级：<span id="sellerGrade"></span>
     					</td>
     				</tr>
     			</table>
     		</td>
     		<td valign="top">
     			<table width="670" style="border-bottom: #ccc 1px solid;">
     				<tr>
     					<td>
     						<table>
     							<tr>
     								<td style="font-size: 24px;color: #333333; font-weight: bold;">
     									<s:if test="#request.userInfo.sex==1"><img src="theme/images2/sex-n.png" /></s:if>
     									<s:else><img src="theme/images2/sex-v.png" /></s:else>
			     						<s:property value="#request.userInfo.nickName"/>
			     						<s:if test="#request.qyUserInfo==1">
			     							<span style="font-size:12px;color:#00aa00">企：</span><a style="font-weight:bolder;font-size:12px;color: #666666;cursor: pointer;"  onclick="window.location.href='<%=request.getContextPath() %>/orgListAction.htm?id=<s:property value='#request.user.parentID'/>';"><s:property value="#request.qyUInfo.nickName"/></a>
			     							<s:if test="#request.qyUser.rzState==3">
								         		<img src="theme/images2/tu95.jpg" width="15" height="17" />
								         	</s:if>
								         	<s:else>
								         		<img src="theme/images2/tu95_1.jpg" width="15" height="17" />
							         	</s:else>
			     						</s:if>
			     						<s:else>
			     							<s:if test="#request.user.rzState==3">
								         	<a style="color:#37bc07;font-size:14px;margin:0 10px"><img src="theme/images2/tu95.jpg" width="15" height="17" />&nbsp;&nbsp;实名认证</a>
								         	&nbsp;&nbsp;&nbsp;
								         	</s:if>
								         	<s:else>
								         		<a style="color:#cc0000;font-size:14px;margin:0 10px"><img src="theme/images2/tu95_1.jpg" width="15" height="17" />&nbsp;&nbsp;未认证</a>
								         	&nbsp;&nbsp;&nbsp;
							         	</s:else>
			     						</s:else>
			     						<input type="text" id="yrNameId" style="display: none;" value="<s:property value="#request.userInfo.nickName"/>" /><input type="text" id="yrUrl" style="display: none;" value="http://d15t.cn/stage01/presonList.htm?id=<s:property value="#request.userInfo.userId"/>" /><input type="text" id="yrPic" style="display: none;" value="http://d15t.cn/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png" /> 
			     						
			     					</td>
     							</tr>
     							<tr>
     								<td height="25">
     									<s:property value="#request.userInfo.provice"/> &nbsp;|&nbsp; <s:property value="#request.userInfo.city"/>
     								</td>
     							</tr>
     							<tr>
     								<td style="font-size: 12px;font-weight: bold;">
     									预约次数：<input name="" readonly="readonly" type="text" value="<s:property value="#request.userInfo.signNumber"/>" class="qx" style="font-weight: bold;color: #ee0000;"/>&nbsp;&nbsp;&nbsp;人气：<input name="" readonly="readonly" type="text"  value="<s:property value="#request.dingCount"/>" style="color: #ee0000;font-weight: bold;width:10px;" class="qx"/>
     									<img src="theme/images2/tu210.png" onmouseover="setTimeout(showdetails,100);" onmouseout="setTimeout(hidedetails,100)"/>
     									<div id="windows1" style="display:none; background-image:url(theme/images2/tu207.png);width: 186px;height: 54px;position: absolute;z-index: 1000;left: 293px;top: 7px;">
     										<table cellpadding="4">
     											<tr><td><span style="color: #333333;">每次获得一次赞或者被分享一次都会加1个人气值</span></td></tr>
     										</table>
     									</div>
     									<div id="windows2" style="display:none; background-image:url(theme/images2/tu206.png);width: 186px;height: 54px;position: absolute;z-index: 1000;left: 10px;top: 223px;">
     										<table cellpadding="4">
     											<tr><td><span style="font-family: 微软雅黑;color: #333333;">抱歉TA没有公开联系方式！<br/>试试点击联系TA</span></td></tr>
     										</table>
     									</div>
     								</td>
     							</tr>
     						</table>
     					</td>
     					<s:if test="#request.nowId==#request.userId"><td width="150"  valign="top" onmouseover="changeCss(this,1,3)" onmouseout="changeCss(this,2,3)" title="编辑" onclick="updatePro(<s:property value="#request.id"/>,3)">
     						<div class="showCss" style="display: none;width: 150px;height: 90px;" id="pro">
     							<table width="100%" style="height: 90px;">
     								<tr>
     									<td style="font-size: 14px;color: #eeeeee;font-weight: bold;" align="center">编辑</td>
     								</tr>
     							</table>
     						</div>
     					</s:if>
     					<s:else><td width="150" valign="top"></s:else>
     						<table  style="font-size: 14px;">
     									 <s:iterator value="#request.costList" var="item">
											<tr>
     											<td valign="top" style="height: 15px;color: #333333;font-weight: bold;" >
													<div title='<s:property value="#item[0].keywords"/>'><s:property value="#item[0].keywords"/>/<s:if test="#item[0].isConsult==1">面议</s:if><s:else><a style="color: #ee0000;font-weight: bold;"><s:property value="#item[0].bprice"/></a>/<s:if test="#item[0].unit.length()>2"><a style="color: #333333;" title="<s:property value="#item[0].unit"/>"><s:property value="#item[0].unit.substring(0,1)"/>..</a></s:if><s:else><s:property value="#item[0].unit"/></s:else></s:else> </div>
												</td>
			     							</tr>
										</s:iterator>
     								
     						</table>
     					</td>
     				</tr>
     				
     			</table>
     			<table style="height: 90px;">
     				<tr><s:if test="#request.nowId==#request.userId">
     						<td width="100%" style="padding-top: 8px;font-size: 12px;" valign="top"  onmouseover="changeCss(this,1,8)" onmouseout="changeCss(this,2,8)" title="编辑" onclick="updatePro(<s:property value="#request.id"/>,2)">
     						<div class="showCss" style="display: none;width: 660px;height: 90px;" id="introduct">
     							<table width="100%" style="height: 90px;">
     								<tr>
     									<td style="font-size: 14px;color: #eeeeee;font-weight: bold;" align="center">编辑</td>
     								</tr>
     							</table>
     						</div>
     					</s:if>
     					<s:else>
     						<td width="100%" style="padding-top: 8px;font-size: 12px;" valign="top">
     					</s:else>
     					
							个人介绍:<br/>
							<s:if test="#request.userInfo.introduction.length() < 220">
								<s:property value="#request.userInfo.introduction" />
							</s:if>
							<s:elseif test="#request.userInfo.introduction==null||#request.userInfo.introduction==''">暂无</s:elseif>
							<s:else>
								<s:property value="#request.userInfo.introduction.substring(0,219)" />
								...<a href="javascript:alertInfo('<s:property value='#request.userInfo.introduction' />')" style="color:#00b7ed">查看全部介绍</a>
							</s:else>
							
     					</td>
     				</tr>
     			</table>
     		</td>
     		<td>
     			<table width="175" cellpadding="3" style="border-left: #ccc 1px solid;margin-top: 7px;" >
     				<tr>
     					<td height="51">
     						<img src="theme/images2/tu204.png" width="164" height="51" onclick="qianYueTa()" style="cursor: pointer;"/>
     					</td>
     				</tr>
     				<tr>
     					<td style="font-family: 微软雅黑;font-weight: bold;font-size: 15px;">&nbsp;动态评分
     					
     					
     					<% if(userSession==null){
							%>
							<span style="color:#FF60C9;padding-left:28px;cursor: pointer;" onclick="parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;"><img src="theme/images2/tu203.png" width="20" height="17" />&nbsp;赞一个</span>
							<% }else{%>
								<span style="color:#FF60C9;padding-left:28px;cursor: pointer;" onclick="addDing(<s:property value="#request.id"/>,1)"><img src="theme/images2/tu203.png" width="20" height="17" />&nbsp;赞一个</span>
							<%} %>
     					</td>
     				</tr>
     				<tr>
     					<td style="color: #FB8728;font-size: 13px;font-weight: bold;">&nbsp;好评率：<s:property value="#request.userInfo.feedbackRate"/>%</td>
     				</tr>
     				<tr>
     					<td >&nbsp;描述相符：<span id="msGrade"></span>&nbsp;<s:if test="#request.userEvaluation.msGradeValue==null&&#request.userEvaluation.msGradeValue==0">尚未完成交易</s:if><s:else><s:property value="#request.userEvaluation.msGradeValue"/></s:else> </td>
     				</tr>
     				<tr>
     					<td >&nbsp;演出态度：<span id="tdGrade"></span>&nbsp;<s:if test="#request.userEvaluation.tdGradeValue==null&&#request.userEvaluation.tdGradeValue==0">尚未完成交易</s:if><s:else><s:property value="#request.userEvaluation.tdGradeValue"/></s:else></td>
     				</tr>
     				<tr>
     					<td >&nbsp;完成质量：<span id="zlGrade"></span>&nbsp;<s:if test="#request.userEvaluation.zlGradeValue==null&&#request.userEvaluation.zlGradeValue==0">尚未完成交易</s:if><s:else><s:property value="#request.userEvaluation.zlGradeValue"/></s:else></td>
     				</tr>
     			</table>
     			
     		</td>
     	</tr>
     </table>
      </div>
  <div class="qy-bright l"><img src="theme/images2/tu202.png" width="4" height="215" /></div>
</div>


<style type="text/css">
#pop-up1
{
	background: url("<%=request.getContextPath()%>/theme/images2/pop-up.png");
	width:240px;
	height:124px;
	position:absolute;
	
/* 	font-size:14px; */
	font-family:"微软雅黑" "宋体";

}
#pop-up1 a
{
	margin-left: 10px;
	margin-top: 20px;
}
</style>
<table class="gr-nex">
	<tr>
		<td class="gr-nex1"  valign="top">
			
    <div class="gr-nex1-top" style="margin-right:10px;margin-top: 10px;">
     <p><img src="theme/images2/tu97.jpg" width="304" height="7" /></p>
    <div class="gr-nex1-left">
    <!-- 会员详情 下 信息 开始 -->
      <s:action name="userViewLeft" namespace="" executeResult="true">
			<s:param name="userIdParam"><s:property value="#request.id"/></s:param>
		</s:action>
		<!-- 会员详情 下 信息 结束 -->
		<p>
 		<ul class="gr-nex1-left1">
            <li class="gezl" style="font-weight: bold;">档期安排</li>
       </ul>
       <div id="pop-up" style="display:none; background-image:url(theme/images2/pop-up.png);width: 240px;height: 124px;position: absolute;z-index: 1000;" >
       		
       </div>
	<s:action name="schedule" executeResult="true" namespace="">
		<s:param name="userIdParam"><s:property value="#request.id"/></s:param>
	</s:action>
	
     </div>
     <p><img src="theme/images2/tu99.jpg" width="304" height="7" /></p>
   </div>  
    
   <div>
     <p><img src="theme/images2/tu97.jpg" width="304" height="7" /></p>
    <div class="gr-nex1-left2">
       <ul class="gr-nex1-left1">
            <li style="border-bottom:1px solid #ff60c8;color:#ff60c8;font-size:18px;height:32px;line-height:32px;font-weight: bold;">我的好友</li>
       </ul>
       
       <s:iterator value="#request.listFriend" var="item">
       <dl class="gr-nex1-dl l">
          <dt><a href="<%=request.getContextPath()%>/presonList.htm?id=<s:property value="#item.userId" />"><img style="border:1px solid #e3e3e3; padding:2px;" width="110" height="100" onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#item.userId" />.png" /></a></dt>
          <dl><s:property value="#item.nickName" /></dl>
          <dl class="dd" ><span id="friend_<s:property value="#item.userId" />"></span></dl>
          
       </dl>
       <script type="text/javascript"> 
       var sellerGrade = '<s:property value="#item.sellerGrade"/>';
       var imgSG1 = '<img src=\"theme/images2/m41.gif\" />&nbsp;';
		var imgSG2 = '<img src=\"theme/images2/m42.gif\" />&nbsp;';
		var imgSG3 = '<img src=\"theme/images2/m43.gif\" />&nbsp;';
		if(sellerGrade<=3&&sellerGrade>0){
			for(var j = 0; j < sellerGrade; j++) {
				$("#friend_"+'<s:property value="#item.userId" />').append(imgSG1);
			}
		}else if(sellerGrade>3&&sellerGrade<=6){
			for(var j = 0; j < (sellerGrade-3); j++) {
				$("#friend_"+'<s:property value="#item.userId" />').append(imgSG2);
			}
		}else{
			for(var j = 0; j < (sellerGrade-6); j++) {
				$("#friend_"+'<s:property value="#item.userId" />').append(imgSG3);
			}
		}
		
       </script>
       </s:iterator>

     </div>
     <p><img src="theme/images2/tu99.jpg" width="304" height="7" /></p>
   </div>
		</td>
		<td class="gr-nex2" align="left" valign="top">
			<script type="text/javascript">
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	
	function showDetailPhoto(id,type,picid){
		//presonList!imageView.htm?id=<s:property value="#request.id"/>&&pic=<s:property value="#item.id" />
		window.location.href="<%=request.getContextPath() %>/presonList.htm?id="+id+"&pic="+picid+"&photoFlag=1";
	}
	function openMovie(swfurl){
		if(swfurl != ''){
			art.dialog({
		    padding: 0,
		    title: '视频播放',
		    content: "<embed src=\""+swfurl+"\" quality=\"high\" width=\"560\" height=\"480\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"

		});
	}
}
function openVedio(swfurl){
		if(swfurl != ''){
			art.dialog({
		    padding: 0,
		    title: '音频播放',
		    content: "<embed src=\""+swfurl+"\" quality=\"high\" width=\"560\" height=\"480\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"

		});
	}
}
// 	javascript:openMovie('<s:property value="#item.attachment" />');
<%-- 		window.location.href="<%=request.getContextPath() %>/presonList!showList.htm?id="+id+"&sign="+type; --%>
// 	}
	function showDetail(id,type){
		window.location.href="<%=request.getContextPath() %>/presonList!userPhoto.htm?id="+id+"&sign="+type;
	}
  	function showList(type,pageNum){
  		$('#showList').empty();
  		var id = ${nowId};
  		var userId = ${userId};
  		var html = "";
  		$("#caiyiPage").html("");
  		$("#addCaiYi").html("");
  		$.post('<%=request.getContextPath()%>/member/artInfo!showList.htm',
				{
  					sign:type,
  					id:<s:property value="#request.id"/>,
  					pageNo:pageNum
			    }, 
				function(data) {
			    	if(data != null){
			    		$(data).each(function(index,val){
			    			var  _dl = $("<dl></dl>");
			    			if((index+1) % 3 !=0){
			    				_dl.addClass("gr-nex2-right4 gr-nex2-right5 l");
			    			}else{
			    				_dl.addClass("gr-nex2-right4 l");
			    			}
			    			if(type=="1"){
			    			pageNum = this.userId;
			    			total = this.imgCount;
			    			if(id==userId){
			    				$("<dt><div class='showCss' style='display:none; width: 228px;height: 207px;' id='photo_"+this.id+"' onclick='updatePro1("+this.id+",1)' onmouseout='changeCss(this,2,5,"+this.id+")''>"+
							"<table width='100%' style='height: 207px;'>"+
							"<tr><td style='font-size: 14px;color: #eeeeee;font-weight: bold;' align='center'>编辑</td></tr></table></div><div class='container1'><table width='223'><tr><td align='center' style='vertical-align: middle;height:204px;width:223px;'><img onerror='handleImgLoadError1(event);' onload='AutoSize(this,223,204)' onmouseover='changeCss(this,1,5,"+this.id+")'  title='编辑' src='"+this.url+"'  /></td></tr></table></div></dt>")
			    				.addClass("pointer").bind("click",{id:<s:property value="#request.id"/>,type:type,picid:this.id},
			    						function(event){
			    					
			    				}).appendTo(_dl);
			    				var html1 = "<input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='添加相册' onclick='toAdd(1)' />";
			    				$("#addCaiYi").html(html1);
			    			}else{
			    				$("<dt><div class='container1'><table width='223'><tr><td align='center' style='vertical-align: middle;height:204px;width:223px;'><img onerror='handleImgLoadError1(event);' onload='AutoSize(this,223,204)' src='"+this.url+"' /></td></tr></table></div></dt>")
			    				.addClass("pointer").bind("click",{id:<s:property value="#request.id"/>,type:type,picid:this.id},
			    						function(event){
			    					showDetailPhoto(event.data.id,event.data.type,event.data.picid);
			    				}).appendTo(_dl);
			    			}
			    			
			    			}else if(type=="2"){
				    			pageNum = this.userId;
				    			total = this.imgCount;
				    			if(id==userId){
				    				$("<dt><div class='showCss' style='display:none; width: 228px;height: 207px;' id='movie_"+this.id+"' onclick='updatePro1("+this.id+",2,\""+this.attachment+"\")' onmouseout='changeCss(this,2,6,"+this.id+")''>"+
							"<table width='100%' style='height: 207px;'>"+
							"<tr><td style='font-size: 14px;color: #eeeeee;font-weight: bold;' align='center'>编辑</td></tr></table></div><img onerror='handleImgLoadError2(event);' src='"+this.intro+"' onmouseover='changeCss(this,1,6,"+this.id+")' width='223' height='204' /></dt>")
				    				.addClass("pointer").bind("click",{url:this.attachment},
				    						function(event){
				    					//openMovie(event.data.url);
				    				}).appendTo(_dl);
				    				var html1 = "<input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='添加视频' onclick='toAdd(2)' />";
			    					$("#addCaiYi").html(html1);
				    			}else{
				    				$("<dt><img onerror='handleImgLoadError2(event);' src='"+this.intro+"' width='223' height='204' /></dt>")
				    				.addClass("pointer").bind("click",{url:this.attachment},
				    						function(event){
				    					openMovie(event.data.url);
				    				}).appendTo(_dl);
				    			}
			    				
			    			}else{
			    				pageNum = this.userId;
			    				total = this.imgCount;
			    				if(id==userId){
				    				$("<dt><div class='showCss' style='display:none; width: 228px;height: 207px;' id='voice_"+this.id+"' onclick='updatePro1("+this.id+",3,\""+this.attachment+"\")' onmouseout='changeCss(this,2,7,"+this.id+")''>"+
									"<table width='100%' style='height: 207px;'>"+
									"<tr><td style='font-size: 14px;color: #eeeeee;font-weight: bold;' align='center'>编辑</td></tr></table></div><img onerror='handleImgLoadError3(event);' src='"+this.intro+"' onmouseover='changeCss(this,1,7,"+this.id+")' width='223' height='204' /></dt>")
				    				.addClass("pointer").bind("click",{url:this.attachment},
				    						function(event){
				    					//openVedio(event.data.url);
				    				}).appendTo(_dl);
				    				var html1 = "<input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='添加音频' onclick='toAdd(1)' />";
			    					$("#addCaiYi").html(html1);
				    			}else{
				    				$("<dt><img onerror='handleImgLoadError3(event);' src='"+this.intro+"' width='223' height='204' /></dt>")
				    				.addClass("pointer").bind("click",{url:this.attachment},
				    						function(event){
				    					openVedio(event.data.url);
				    				}).appendTo(_dl);
				    			}
			    			}
			    			<% if(userSession==null){
							%>
							$("<div class='container2'><table width='228' style='background-color: #EBEBEB;height:20px;border:1px solid #D9D9D9;'><tr><td width='33%'align='center' title='赞一下' onclick='addDing("+this.id+",("+this.type+"+1))'  style='cursor: pointer;border-right:1px solid #D9D9D9;' ><img src=\"theme/images2/s1.png\" />&nbsp;"+this.ding+"</td><td width='33%'align='center' title='分享' onclick='share("+this.userId+","+this.id+",\""+this.url+"\",this,\""+this.intro+"\","+this.type+")' style='cursor: pointer;border-right:1px solid #D9D9D9;'><img src=\"theme/images2/s2.png\" />&nbsp;"+this.share+"</td><td width='33%'align='center' title='评论' onclick='parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;' style='cursor: pointer;border-right:1px solid #D9D9D9;'><img src=\"theme/images2/s3.png\" />&nbsp;"+this.evaluate+"</td></tr></table><table ><tr><td width='228' align='center'>"+this.title+"</td></tr></table></div>").appendTo(_dl);
			    			<% }else{%>
								$("<div class='container2'><table width='228' style='background-color: #EBEBEB;height:20px;border:1px solid #D9D9D9;'><tr><td width='33%'align='center' title='赞一下' onclick='addDing("+this.id+",("+this.type+"+1))'  style='cursor: pointer;border-right:1px solid #D9D9D9;' ><img src=\"theme/images2/s1.png\" />&nbsp;"+this.ding+"</td><td width='33%'align='center' title='分享' onclick='share("+this.userId+","+this.id+",\""+this.url+"\",this,\""+this.intro+"\","+this.type+")' style='cursor: pointer;border-right:1px solid #D9D9D9;'><img src=\"theme/images2/s2.png\" />&nbsp;"+this.share+"</td><td width='33%'align='center' title='评论' onclick='openEvaView("+this.id+")' style='cursor: pointer;border-right:1px solid #D9D9D9;'><img src=\"theme/images2/s3.png\" />&nbsp;"+this.evaluate+"</td></tr></table><table ><tr><td width='228' align='center'>"+this.title+"</td></tr></table></div>").appendTo(_dl);
			    			<%} %>
			    			
			    			if(index == 5){
			    				//$("<p class='gr-nex2-right6'><a href='javascript:showDetail("+<s:property value="#request.id"/>+","+type+")'>查看更多</a></p>").appendTo(_dl);
			    			}
			    			_dl.appendTo("#showList");
			    			
			    			
			    			
			    		});
			    		if(pageNum==null){
			    			var  _dl = $("<dl></dl>");
			    			if(type==1){
			    				$("<dt><img onerror='handleImgLoadError1(event);'src= '<%=request.getContextPath()%>/theme/images2/tu209-1.png' width='223' height='204' /></dt>").appendTo(_dl);
				    			if(id==userId){
				    				var html1 = "<input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='添加相册' onclick='toAdd(1)' />";
			    					$("#addCaiYi").html(html1);
				    			}
				    		}else if(type==2){
				    			$("<dt><img onerror='handleImgLoadError2(event);'src= '<%=request.getContextPath()%>/theme/images2/tu209-2.png' width='223' height='204' /></dt>").appendTo(_dl);
				    			if(id==userId){
				    				var html1 = "<input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='添加视频' onclick='toAdd(2)' />";
			    					$("#addCaiYi").html(html1);
				    			}
				    		}else if(type==3){
				    			$("<dt><img onerror='handleImgLoadError3(event);' src= '<%=request.getContextPath()%>/theme/images2/tu209-3.png' width='223' height='204' /></dt>").appendTo(_dl);
				    			if(id==userId){
				    				var html1 = "<input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='添加音频' onclick='toAdd(3)' />";
			    					$("#addCaiYi").html(html1);
				    			}
				    		}
				    		_dl.appendTo("#showList");
			    		}
			    		if(pageNum==1&&total>1){//第一页
			    			html+=" <input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='下一页' onclick='showList("+type+","+(pageNum+1)+")' />";
			    		}else if(pageNum==total&&pageNum>1){
			    			html+=" <input type='button' id='last' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='上一页' onclick='showList("+type+","+(pageNum-1)+")' />";
			    		}else if(pageNum>1&&pageNum!=total){
			    			html+=" <input type='button' id='last' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='上一页' onclick='showList("+type+","+(pageNum-1)+")' /><input type='button' id='next' style='cursor: pointer;background-color:#ffffff;border:1px solid #000000;' value='下一页' onclick='showList("+type+","+(pageNum+1)+")' />";
			    		}
						$("#caiyiPage").html(html);
						
			    	}else{
			    		
			    		return;
			    	}
			},"json");
			
  	}
  </script>
  
 
  <!--正文右边-->
		<table class="gr-nex2-right">
			<tr>
				<td>&nbsp;&nbsp;才艺展示</td>
				<td width="225">
					 <input type="button" id="fanhui" style="margin-left: 170px;cursor: pointer;display: none;" value="返回" onclick="window.location.href='<%=request.getContextPath() %>/presonList.htm?id=${id}'" />
					<div class="jiathis_style" id="fenxiang" onclick="addDing(<s:property value="#request.id"/>,-1)"><span class="jiathis_txt">分享到：</span>
					<a class="jiathis_button_qzone" ></a>
					<a class="jiathis_button_tsina" ></a>
					<a class="jiathis_button_tqq" ></a>
					<a class="jiathis_button_weixin" ></a>
					<a class="jiathis_button_tsohu" ></a>
					</div>
					<script type="text/javascript" >
					 yrname = $("#yrNameId").val();
					 yrurl = $("#yrUrl").val();
					 yrpic = $("#yrPic").val();
					 jiathis_config={
						url:yrurl,
						sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
						summary:"我在第一舞台发现了ta，非常棒！",
						title:"超喜欢 #"+yrname+"#",
						pic:yrpic,
						shortUrl:false,
						hideMore:true
					}
					</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>

				</td>
				
			</tr>
		</table>
	
 	<div>
     <iframe id="wank1" src="tab5/<s:property value="#request.id"/>.html" name="wank1" width="690"  height="70" scrolling="no" frameborder="0"></iframe> 
     </div>
     <p class="gr-nex2-right2"></p>
     <div class="gr-nex2-right3" id="showList" name="showList">
     </div>
      <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	<table width="100%" id="caiyiPageTA">
		<tr>
			<td width="50%" align="left" id="addCaiYi"></td><td width="50%" align="right" id="caiyiPage"></td>
		</tr>
	</table>
     <!-- 图片列表  开始 -->
	<div style="display: none;width:690px;margin:10px 0" id="photoList">
		<s:iterator value="#request.images" var="item">
				<img src="<s:property value="#item.url" />" style="max-width: 650px;  " />
		</s:iterator>
		
	</div>
     
   <div class="gr-nex2-right7">
       <p class="gr-right7-z l"><img src="theme/images2/tu107.jpg" width="5" height="415" /></p>
      <div class="gr-right7-zz l">
        <p class="gr-right7-jy"><a name="pingjia">交易评价</a></p>
         <table width="98%" border="0">
         
          <s:iterator value="#request.businessEvaluateList" var="evaluate">
           <tr>
            <td width="83%" height="30"><s:property value="#evaluate[0].pjContent"/></td>
            <td width="17%" height="30"><s:property value="#evaluate[2]"/>&nbsp;<a style="color:#fc1616">LV<s:property value="#evaluate[4]"/></a></td>
          </tr>
           <tr >
            <td style="border-bottom:1px solid #ccc" height="30" style="color:#666"><s:property value="#evaluate[0].CreatTime"/></td>
            <td style="border-bottom:1px solid #ccc" height="30">&nbsp;</td>
          </tr>
          </s:iterator>
          <tr>
            <td height="30" colspan="2" align="left"> 
            <table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="page" style="margin-top: 0px;">
			    <tr>
			        <td align="center"><pg:pages  pageNo='${pageNumP}' rowCount ="5"  url="presonList.htm" params="id=${id}"  total='${totalP}' ></pg:pages></td>
			    </tr>
			</table>
		</td>
           </tr>
        </table>
		 
       </div>
       <p class="gr-right7-z l"><img src="theme/images2/tu109.jpg" width="4" height="415" /></p>
     </div>
   
     <div class="gr-nex2-right8">
        
         <table class="gr-nex2-right">
			<tr>
				<td>&nbsp;&nbsp;成长经历</td>
         	</tr>
         </table>	
         <s:if test="#request.nowId==#request.userId">
         		<div class="gr-nex2-right9" onmouseover="changeCss(this,1,9)" onmouseout="changeCss(this,2,9)" title="编辑" onclick="updatePro(<s:property value="#request.id"/>,4)">
     						<div class="showCss" style="display: none;width: 660px;height: 260px;" id="Grow">
     							<table width="100%" style="height: 90px;">
     								<tr>
     									<td style="font-size: 14px;color: #eeeeee;font-weight: bold;" align="center">编辑</td>
     								</tr>
     							</table>
     						</div>
     					</s:if>
     					<s:else>
     						<div class="gr-nex2-right9">
     					</s:else>
         
         
         <ul id ="growUl">
         	<li><table width="666"  >
         		<tr >
         			<td width="250" align="center">时间段</td>
         			<td width="150" align="center">标题</td>
         			<td width="366" align="center">内容</td>
         		</tr>
         	<s:iterator value="#request.listGrow" var="item">
			<!--  <li><span class="list_time"><s:property value="#item.creatTime.substring(0,10)" /></span><a href="javaScript:toGrowthView(<s:property value="#item.id" />);" title="<s:property value="#item.title" />"><s:property value="#item.title" /></a></li>-->
			
				<tr>
					<td align="center" ><s:property value="#item.startDate" />至<s:property value="#item.endDate" /></td>
					<td align="center" ><a href="javaScript:toGrowthView(<s:property value="#item.id" />);" style="color: #000000;"> <s:property value="#item.Title" /></a> </td>
					<td align="center" ><a href="javaScript:toGrowthView(<s:property value="#item.id" />);" style="color: #000000;">
						<s:if test="#item.Content.length()<10">
							<s:property value="#item[0].Content"/>
						</s:if>
						<s:else>
							<s:property value="#item.Content.substring(0,10)" />...
						</s:else>
						</a></td>
				</tr>
			
			</s:iterator>
			</table></li>
		</ul>
         </div>
     </div>
     
  </div>



</div>
<div id="aaa" style="background-image:url(theme/images2/x5.png);width:230px;height:35px; position: absolute;display: none;" onclick="addShare()">
<table style="margin-top: 12px;">
	<tr>
		<td style="padding-left: 20px;">
			<div class="jiathis_style" id="fenxiang"><span class="jiathis_txt">分享到：</span>
<a class="jiathis_button_qzone"></a>
<a class="jiathis_button_tsina"></a>
<a class="jiathis_button_tqq"></a>
<a class="jiathis_button_weixin"></a>
<a class="jiathis_button_renren"></a>

</div>
<script type="text/javascript" >
var jiathis_config={
	summary:"",
	shortUrl:false,
	hideMore:true
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<!-- JiaThis Button END -->

					<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" onclick="addDing(<s:property value="#request.id"/>)" target="_blank"></a>
					
					</div>
		</td>
	</tr>
</table>
	

<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
		</td>
	</tr>
</table>
<!--正文-->
  <!--正文左边-->
 
     
  </div>
  
</div>

<!--广告位-->
<div class="gg">我是广告位</div>

<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include><script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
  </body>
</html>