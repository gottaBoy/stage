<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	UserSession userSession = HttpSessionHelper.getUserSession(request);
	int isForOrg = HttpSessionHelper.getOrgData(request); //0:no  1:yes
	int isIndividual = HttpSessionHelper.getIsOrg(request);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
        <!--- ------user\nor_userInfo.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/WdatePicker.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link href="<%=request.getContextPath() %>/theme/css/style.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/theme/css/hg.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">  

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/43!register.css" />

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
		html, body { height:auto !important;background-color: #f5f5f5;}
	</style>
	
<script type="text/javascript">
function toggleAll(status){
	$("#jcxxForm input:not(:button,:hidden)").attr("disabled", status);
	$("#jcxxForm select").attr("disabled", status);
	$("#jcxxForm textarea").attr("disabled", status);
}



$(document).ready(function(){
	if("${userInfo.provice}"!=""){
		initAddress('provice','city','${userInfo.provice}','${userInfo.city}');
	}else{
		initAddress("provice","city","上海","");  
	}


	toggleAll(true);
	getUserPercent();
	$("#myinfobaocun").html('<a href="javascript:modifyForm();">修改</a>');
});

 

function getUserPercent(){
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getPercent.htm",
		type:'POST',
		dataType:'json', 
		success:function(data){
			var d = parseInt(data);

			$(".wanzheng").html('');
			if(d > 0 && d <=50){
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng1.jpg" />'+d+'%');
			}else if(d > 50 && d <= 70){
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng2.jpg" />'+d+'%');
			}else if(d > 70 && d <= 99){
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng.jpg" />'+d+'%');
			}else{
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng3.jpg" />'+d+'%');
			}
		}
	});
}

function modifyForm(){
	toggleAll(false);
	$("#myinfobaocun").html('<a href="javascript:submitForm();">保存</a>');
}
function checknull(){

	var nickName=$("#userInfo\\.nickName").val();
	//var realName=$("#userInfo\\.name").val();
	//var place = $("#userInfo\\.place").val();

	if(nickName==""){
		art.dialog.tips("昵称不能为空！", 2);
		return false;
	}
/*
	if(place==""){
		art.dialog.tips("详细地址不能为空！", 2);
		return false;
	}	

	if(realName==""){
		art.dialog.tips("真实姓名不能为空！", 2);
		return false;
	}
	*/
	return true;
}


function submitForm(){
	if(checknull()){
		$.ajax({
			url:"<%=request.getContextPath() %>/member/userinfo!updateOnlyUserInfo.htm",
			type:'POST',
			data:$("#jcxxForm").serialize(),
			success:function(data){
				if(data == 1){
					art.dialog.tips("保存成功！", 3);
					toggleAll(true);
					$("#myinfobaocun").html('<a href="javascript:modifyForm();">修改</a>');
					//window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
			   }
		   }
		});
	}
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
  
			
//修改密码
function updatePass(){
	art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdatePassWord.htm',{lock:true,resize: false});
}

//实名认证
function realName(){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=4',{width:750,height:670,lock:true,resize: false});
}
 

function tishi(content){
	art.dialog.tips(content);
}


//修改手机/邮箱
function updateEmailOrMobile(flag){
		art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdateEmail.htm?flag='+flag,{lock:true,resize: false	});
}


var updateFlag = false;
function setUpdateFlag() {
	updateFlag = true;
}





function applicate(userId){
	//if(checknull()){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/userinfo!applicate.htm",
		   type:'POST',
		   success:function(data){
			   if(data == "1") {
				   window.location.href = "<%=request.getContextPath() %>/member/userinfo.htm?sign=1000";
				   //location.reload();
				   //art.dialog.alert("申请提交成功！",3);
			   }
		   }
		});
	//}
}

//===============================

 

//修改头像
function uploadPic(imgid,rPath,fileName){
		art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?swfFile=indexHeadImage&sign=100&rPath='+rPath+'&dateRandomStr='+fileName+'&imgid='+imgid,{lock:true,resize: false});
}

//flash callback
function updatePic(imgid,rPath,fileName) {
	//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
	$("#"+imgid).attr("src", "/stageUpload/"+rPath+"/"+fileName+".png?date=" + new Date().getTime());
 }

</script>
  </head>
  <body  style="background: #ffffff;">
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>

<div style="height:auto !important; width:100%; margin:0;overflow:hidden;" id="main_content">

 <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tbody><tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="1"></s:param>
        </s:action>

       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">


<!-- 导航 结束 -->

<div class="right_tab">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/userinfo.htm">基本信息</a></li>
<!-- <li><a href="orginfo.htm?sign=5">绑定支付宝</a></li> -->
</ul>
</div>
<!-- 基础信息 开始 -->

<div id="TabTab03Con">

<div class="wanzheng" style="margin:20px 0px"> 个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng.jpg" />80%</div>

<div class="content">
<div class="content_left">
<form name="jcxxForm" id="jcxxForm" action="">
<ul>
<li>
    <div class="name">用户名：</div>
    <div class="xinxi">${user.username}</div>
    <a href="javascript:updatePass();" class="zhezhaoLink">修改密码</a>
</li>
<li>
    <div class="name"><span>*</span> 昵称：</div>
    <input name="userInfo.nickName" id="userInfo.nickName" value="${userInfo.nickName}"/>
    <p>昵称，你的个性象征</p>
</li>


<li>
<div class="name"><!-- <span style="color:#ff0000;">*</span> -->实名认证</div>
	<a href="javascript:realName();" class="zhezhaoLink">认证</a>　<br>　
</li>
    <div class="tishi">用于提升账号的安全性和信任级别。<br />
认证后的会员能够获得更多合作机会和优先权。</div>




<li>
   <div class="name"> 性别：</div>
   <div style="float:left"><input name="userInfo.sex" type="radio" value="1"  ${(userInfo.sex=='1') ?'checked="checked"':''} ${(userInfo.sex==null) ?'checked="checked"':''}  class="yuan">
   <dd>男</dd> </div><div style="float:left">
   <input type="radio" name="userInfo.sex" value="2" ${(userInfo.sex=='2') ?'checked="checked"':''} class="yuan">
   <dd>女</dd>
   </div>
<div style="float:left">
   <input type="radio" name="userInfo.sex" value="3" ${(userInfo.sex=='3') ?'checked="checked"':''} class="yuan">
   <dd>组合</dd>
   </div>
</li>
  
<li>
    <div class="name"><span>*</span> 所在地：</div>
                  <select  name="userInfo.provice" id="provice" class="sel_jcxx"></select>
                  <select   name="userInfo.city" id="city" class="sel_jcxx"></select>

    
</li>

<!--
<li>
    <div class="name"><span>*</span> 详细地址：</div>
    <input  name="userInfo.place" id="userInfo.place" value="${ userInfo.place}"/> 
</li>
-->

<li>
    <div class="name"> 手机：</div>
    <div class="xinxi">${userInfo.mobile}</div>
	<a href="javascript:updateEmailOrMobile(2);" class="zhezhaoLink">修改</a>
</li>

<li>
    <div class="name"> E-mail：</div>
    <div class="xinxi">${user.email}</div>
	<a href="javascript:updateEmailOrMobile(1);" class="zhezhaoLink">修改</a>
</li>

<c:if test="${user.applicate==0 || user.applicate == null}">
 <li>
 <a href="javascript:applicate('<%=userSession.getId()%>')" class="querenbaocun">申请专业会员</a> 
 </li>
 </c:if>

</ul>
 </form>

</div>

<div class="baocun" id="myinfobaocun"></div>
<div class="touxiang" style="text-align:center">
<div ><img src="/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>"  id="pic001"  /></div>
<a href="javascript:uploadPic('pic001','headImage','<%=userSession.getId()%>')"   class="zhezhaoLink">修改头像</a>
</div>

</div>






</div>


                    

</td>
</tr>
</tbody></table>
<!-- 主内容结束 -->













<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>
<!-- 底部结束 --> 




  </body>
</html>