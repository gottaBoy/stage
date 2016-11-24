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
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
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

	
	getUserInfoCost();
	toggleAll(true);
	$("#myinfobaocun").html('<a href="javascript:modifyForm();">修改</a>');

	getUserInfoGrowth();
});


//获取用户成长经历
function getUserInfoGrowth() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getGrowthList.htm",
		type:'POST',
		dataType:'json', 
		success:function(data){
			var d = eval(data);
			$("#growthHistory").html("");
			var html = "";

			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				html += "<li><div class='name'> 标题：</div>";
				html += "<input  name='title' id='title' value='"+obj.title+"' disabled/>";
				html += "</li><li>";
				html += "<div class='name'> 日期：</div>";
				html += "<input class='duan' class='Wdate' type='text' name='startDate' id='startDate'  value='"+obj.startDate+"' disabled/>";
				html += "<span class='heng'>-</span>";
				html += "<input class='duan' class='Wdate' type='text' name='endDate' id='endDate'  value='"+obj.endDate+"' disabled/>";
				html += "</li><li>";
				html += "<div class='name'> 内容：</div>";
				html += "<textarea disabled>"+obj.content+"</textarea></li>";
				html += "<li><a href='javascript:toDelGrowth("+obj.id+");'  class='tianjia'>删除</a></li>";
				html += "<li><hr></li>";
			}

			html += "<form id='growthForm'><li><div class='name'> 标题：</div>";
			html += "<input  name='growth.title' id='growth.title'  value=''  />";
			html += "</li><li>";
			html += "<div class='name'> 日期：</div>";
			html += "<input class='duan' class='Wdate' type='text' id='growth.startDate' name='growth.startDate' value=''  onFocus=\"WdatePicker({lang:'zh-cn'})\" />";
			html += "<span class='heng'>-</span>";
			html += "<input class='duan' class='Wdate' type='text' id='growth.endDate' name='growth.endDate'  value=''  onFocus=\"WdatePicker({lang:'zh-cn'})\" />";
			html += "</li><li>";
			html += "<div class='name'> 内容：</div>";
			html += "<textarea id='growth.content' name='growth.content'  ></textarea></li>";
			html += "<li><a href='javascript:addGrowth()' class='tianjia'>添加</a></li></form>";
			
			$("#growthHistory").html(html);
			
 		}
	});
}

function addGrowth(){
	if($("#growth\\.title").val()==""){
		art.dialog.tips("标题不能为空！", 2);
		return false;
	}
	if($("#growth\\.startDate").val()==""){
		art.dialog.tips("开始日期不能为空！", 2);
		return false;
	}
	if($("#growth\\.endDate").val()==""){
		art.dialog.tips("结束日期不能为空！", 2);
		return false;
	}
	if($("#growth\\.content").val()==""){
		art.dialog.tips("内容不能为空！", 2);
		return false;
	}
	$.ajax({
			url:"<%=request.getContextPath() %>/member/growth!saveGrowth.htm",
			type:'POST',
			data:$("#growthForm").serialize(),
			success:function(data){
				if(data == 1){
					getUserInfoGrowth();
				}
			}
	});
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
				if(data > 0){
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


function toAddArt(sign){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign,{width:750,height:680,resize:false,lock:true});
}
function toUpdateArt(sign,id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&sign='+sign,{width:550,height:450,lock:true,resize: false});
}
 
			
//修改密码
function updatePass(){
	art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdatePassWord.htm',{lock:true,resize: false});
}

//实名认证
function realName(){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=4',{lock:true,resize: false});
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



 



//===============================
function onlyShowContent(id,price,unit,keywords,profession,costId){
		showContentAction(id,price,unit,keywords,profession,costId);
}

function showContent(id,price,unit,keywords,profession,costId){
		showContentAction(id,price,unit,keywords,profession,costId);

		$.ajax({
				url:"<%=request.getContextPath() %>/member/userinfo!onlySaveCost.htm",
				type:'POST',
				data:{
					price:price,
					unit:unit, 
					keywords:keywords,
					profession:profession,
					costId:costId,
					index:id
				},
				success:function(data){
					//if(data == 1){
						//getUserInfo();
					//}
				}
		});
}

function showContentAction(id,price,unit,keywords,profession,costId){
		var html='<div class="current-null">'+keywords+'</div>';

		html += '<input type="hidden" id="profession_'+id+'" name="profession_'+id+'" value="'+profession+'">';
		html += '<input type="hidden" id="bprice'+id+'" name="bprice'+id+'" value="'+price+'">';
		html += '<input type="hidden" id="eprice'+id+'" name="eprice'+id+'" value="'+price+'">';
		html += '<input type="hidden" id="unit'+id+'" name="unit'+id+'" value="'+unit+'">';
		html += '<input type="hidden" id="keywords'+id+'" name="keywords'+id+'" value="'+keywords+'">';

		html += '<div class="current-nulll">'+price+'(元/'+unit+')</div>';
		html += '<input type="button" class="btn" value="修改" onclick=\'toEditCost("'+id+'","'+costId+'")\'>';
		html += '<input type="button" class="btn" value="删除" onclick=\'toDeleteCost("'+id+'","'+costId+'")\'>';
		$('#div_'+id).html(html);
}

function toDeleteCost(id,costId){
		var index = 0;
 		if(id){
			index = parseInt(id)-1;
		}
		var idName = new Array('一','二','三','四','五');
		var html='<input class="current-null" value="+第'+idName[index]+'职业" type="button" onclick=\'toAddCost("'+id+'")\'/>';
		$('#div_'+id).html(html);

		//后台删除数据....................
		$.ajax({
				url:"<%=request.getContextPath() %>/member/userinfo!deleteCost.htm?costId="+costId,
				type:'POST',
				//data:$("#jcxxForm").serialize(),
				success:function(data){
					//if(data == 1){
						//getUserInfo();
					//}
				}
		});
}

function toAddCost(index){
	art.dialog.open("<%=request.getContextPath()%>/member/cost!toAddOrUpdateByJs.htm?costId=0&add=true&index="+index,{width:700,height:450,lock:true,resize: false});
}

function toEditCost(index,costId){
	art.dialog.open("<%=request.getContextPath()%>/member/cost!toAddOrUpdateByJs.htm?costId="+costId+"&index="+index,{width:700,height:450,lock:true,resize: false});
}



//获取用户技能
function getUserInfoCost() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserInfoCost.htm",
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				onlyShowContent((i+1), obj.bprice,obj.unit,obj.keywords,obj.profession,obj.id);
			}
		}
	});
}

//修改头像
function uploadPic(imgid,rPath,fileName){
		art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=100&rPath='+rPath+'&dateRandomStr='+fileName+'&imgid='+imgid,{lock:true,resize: false});
}

//flash callback
function updatePic(imgid,rPath,fileName) {
	//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
	$("#"+imgid).attr("src", "/stageUpload/"+rPath+"/"+fileName+".png?date=" + new Date().getTime());
 }

</script>
  </head>
  <body>
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
<li><a class="change" href="#">基本信息</a></li>
<li><a href="#">相册</a></li>
<li><a href="#">视频</a></li>
<!-- <li><a href="#">绑定支付宝</a></li> -->
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
    <div class="name"> 真实姓名：</div>
    <input  name="userInfo.name" id="userInfo.name" value="${userInfo.name}"/>
    <a href="javascript:realName();" class="zhezhaoLink">实名认证</a>
</li>
    <div class="tishi">用于提升账号的安全性和信任级别。<br />
认证后的企业能够获得更多合作机会和优先权。</div>

<li>
   <div class="name"> 性别：</div>
   <input name="userInfo.sex" type="radio" value="1"  ${(userInfo.sex=='1') ?'checked="checked"':''} class="yuan">
   <dd>男</dd> 
   <input type="radio" name="userInfo.sex" value="2" ${(userInfo.sex=='2') ?'checked="checked"':''} class="yuan">
   <dd>女</dd>
</li>

<li>
    <div class="name">出生年月：</div>
        <c:set var="birthday" value="${userInfo.birthday}" scope="request"/>
        <%
        String birthday = (String)request.getAttribute("birthday");
        int year=2014;
        int month = 1;
        if(birthday!=null && birthday.indexOf("-")>=0){
            String[] birthdayArr = birthday.split("-");
            year = Integer.parseInt(birthdayArr[0]);
            month = Integer.parseInt(birthdayArr[1]);
        }
        %>

    <select name="birthdayYear" id="birthdayYear"   class="sel_jcxx">
        <%
            for(int i=1950;i<=2050;i++){
        %>
        <option value="<%=i%>" <%if(i==year){out.print("selected='selected'");}%>><%=i%></option>
        <%}%>
    </select>
    <select name="birthdayMonth" id="birthdayMonth"    class="sel_jcxx">
        <%
            for(int i=1;i<=12;i++){
        %>
        <option value="<%out.print((i<10)?"0"+i : i);%>" <%if(i==month){out.print("selected='selected'");}%>><%out.print((i<10)?"0"+i : i);%></option>
        <%}%>
    </select>

</li>

<li>
    <div class="name"> 身高：</div>
    <input class="duan" name="userInfo.height" id="userInfo.height" value="${userInfo.height}"/><font>（CM）</font>
    <div class="name3"> 体重：</div>
    <input class="duan" name="userInfo.weight" id="userInfo.weight" value="${userInfo.weight}"/><font>(KG)</font>
</li>

<li>
    <div class="name"> 胸围：</div>
    <input class="duan" name="userInfo.heartSize" id="userInfo.heartSize" value="${userInfo.heartSize}"/><font>（CM）</font>
    <div class="name3"> 腰围：</div>
    <input class="duan" name="userInfo.waistSize" id="userInfo.waistSize" value="${userInfo.waistSize}"/><font>（CM）</font>
    <div class="name3"> 臀围：</div>
    <input class="duan" name="userInfo.bottocksSize" id="userInfo.bottocksSize" value="${userInfo.bottocksSize}"/><font>（CM）</font>
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

<li>
    <div class="name"> 毕业院校：</div>
    <input name="userInfo.school" id="userInfo.school" value="${userInfo.school}"/>
</li>

<li>
    <div class="name"> 个人介绍：</div>
    <textarea name="userInfo.introduction" id="userInfo.introduction" >${userInfo.introduction}</textarea>
</li>

</ul>
 </form>

</div>

<div class="baocun" id="myinfobaocun">
</div>
<div class="touxiang" style="text-align:center">
<div ><img src="/stageUpload/headImage/${user.id}.png"  id="pic001"  /></div>
<a href="javascript:uploadPic('pic001','headImage','<%=userSession.getId()%>')"   class="zhezhaoLink">修改头像</a>
</div>

</div>

<div class="content">
<div class="content_left">
<h3>职业技能</h3>




						<div class="current-jobBox" id="div_1">
                            <input class="current-null" value="+第一职业" type="button" onclick="toAddCost('1')"/>
                        </div>
						<div class="current-jobBox" id="div_2">
							<input class="current-null" value="+第二职业" type="button" onclick="toAddCost('2')"/>
						</div>
						<div class="current-jobBox" id="div_3">
							<input class="current-null" value="+第三职业" type="button" onclick="toAddCost('3')"/>
						</div>
                        <div class="current-jobBox" id="div_4">
							<input class="current-null" value="+第四职业" type="button" onclick="toAddCost('4')"/>
						</div>
                        <div class="current-jobBox" id="div_5">
							<input class="current-null" value="+第五职业" type="button" onclick="toAddCost('5')"/>
						</div>









</div>

</div>



<div class="content">
<div class="content_left">
<h3>成长经历</h3>
<ul id="growthHistory">

</ul>
 

</div>
<!--
<div class="baocun">
<a href="#">保存</a>
</div>
-->
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