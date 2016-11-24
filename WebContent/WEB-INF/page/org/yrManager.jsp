<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
   <!--- ------org\yrManager.jsp -->
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

	<link href="<%=request.getContextPath() %>/theme/css/style.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/theme/css/hg.css" rel="stylesheet" type="text/css">

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">  

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/3!register.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>


<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js/9!tool1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js/4!register.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
	<style type="text/css" media="screen">
		html, body { height:auto !important;background-color: #f5f5f5;}

		.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:4250px;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.80;filter: alpha(opacity=80);}
		.white_content{display:none;position:absolute;top:25%;width:630px;height:4250px;z-index:1002;overflow:auto;}

		#weixin_img{
			width:371px; height:354px; background:url(/theme/images2/2wm.png) no-repeat; position:fixed; left:230px; top:30px; display:none; z-index:9999;
		_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)));
}

	</style>



<script type="text/javascript">


$(document).ready(function(){
});

 
   
function submitForm(){
		var objs = $("#current-job > div ");
		var tags = "";
		for(var i=0; i<objs.length; i++){
			var val = $(objs[i]," > a").text().trim();
			if(i==(objs.length-1)){
				tags += val ;
			}else{
				tags += val + ",";
			}
		}
		$("#userInfo\\.companyTags").val(tags);

	if(checknull()){
		$.ajax({
			url:"<%=request.getContextPath() %>/member/userinfo!updateOnlyOrgInfo.htm",
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


function toOrgArtMangeer(){
		art.dialog.open('<%=request.getContextPath()%>/member/orginfo.htm?sign=2',
		{
			width: 750,
			height: 550,
			title:"企业认证",
			close: function () {
				 location.reload();
			}
		});
}

//=============================
	function toAdd(id){
		window.location.href="<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign=1&addUser=true&userId="+id;
	}
	function toView(userId){
		art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?type=2&&userId='+userId,{width:750,height:570,resize: false});
	}
 
	function toCheck(id,flag){
	   
	   var str1="删除用户，您确定吗？";
	   var str2="删除用户，您确定吗？";
	   if(flag==0){
	       str1="删除用户，您确定吗？";
	   	   str2="删除用户，您确定吗？";
	   }

		art.dialog({
		        icon: 'succeed',
				content: str1,
				ok: function () {
				   $.post('<%=request.getContextPath()%>/user/userAction!deleteUser.htm?id='+id+'&flag='+flag,
						function(data){
							if(data=="1"){
							
							art.dialog.tips(str2);
							//window.location.reload();
							window.location.href=window.document.location;
				  
						}
					},"html");
				},
				cancel: true
		});

		
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
        	<s:param name="menuFlag" value="14"></s:param>
        </s:action>

       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">


<!-- 导航 结束 -->

<div class="right_tab">
<ul>


<li><a class="change" href="<%=request.getContextPath() %>/member/yrinfo.htm?userId=0">艺人管理</a></li>
<!--<li><a href="<%=request.getContextPath() %>/member/orginfo201.html">相册</a></li>
<li><a href="<%=request.getContextPath() %>/member/orginfo301.html">视频</a></li>-->


</ul>
</div>
<!-- 基础信息 开始 -->

<div id="TabTab03Con">

<div class="yiren_list">
   <div class="yiren_listbt">
      <h3>艺人管理</h3>
     <a href="javascript:toAdd('0');">创建添加</a>   
   </div>
   
   <ul class="yiren_listcont_name">
      <li class="kuang1"><h3>昵称</h3></li>
      <li class="kuang2"><h3>职业</h3></li>
      <li class="kuang3"><h3>姓名</h3></li>
      <li class="kuang4"><h3>地区</h3></li>
      <li class="kuang5"><h3>操作</h3></li>
   </ul>

	    <form name="zzjs_net">
	    <%int i = 0; %>
	<s:iterator value="#request.list" var="item" status="st">


   <ul class="yiren_listcont">
      <li class="kuang1"><a href="<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign=1&addUser=true&isUpdate=true&userId=<s:property value="#item[0].id"/>" class="czjl_title_link"><s:property value="#item[1].nickName"/></a>&nbsp;</li>
      <li class="kuang2"><s:property value="#item[1].profession"/>&nbsp;</li>
      <li class="kuang3"><s:property value="#item[1].name"/>&nbsp;</li>
      <li class="kuang4"><s:property value="#item[1].provice"/>&nbsp;<s:property value="#item[1].city"/></li>
      <li class="kuang5"><a href="javascript:toCheck('<s:property value="#item[0].id"/>','0');" class="czjl_title_link">删除</a>	 
		      		<a href='<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign=1&addUser=true&isUpdate=true&userId=<s:property value="#item[0].id"/>' target="_blank" class="czjl_title_link">修改</a>	</li>
   </ul>
	</s:iterator>
	</form>




</div>

<div>


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