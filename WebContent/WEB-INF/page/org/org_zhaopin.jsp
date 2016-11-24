<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
    <!---------org\org_zhaopin.jsp -->
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

	.querenbaocun {
		text-decoration: none;
		display: block;
		float: left;
		background: url(<%=request.getContextPath() %>/theme/images/tu06.jpg) no-repeat;
		color: white;
		font: normal 18px/40px "微软雅黑";
		text-align: center;
		width: 115px;
		height: 40px;
		margin-left: 110px;
		margin-top: 0px;
		margin-bottom: 40px;
	}
	</style>
	
<script type="text/javascript">
 

$(document).ready(function(){
	getUserInfoGrowth();
});




function toUpdateGrowth(id){
	$("#btn_"+id).html("<a href='javascript:toUpdateGrowthAction(\""+id+"\");'  >保存</a>");
	$("#title_"+id).attr("disabled", false);

	$("#daiyu_"+id).attr("disabled", false);
	$("#xueli_"+id).attr("disabled", false);
	$("#workYears_"+id).attr("disabled", false);
	$("#workAddress_"+id).attr("disabled", false);
	$("#zige_"+id).attr("disabled", false);

	$("#content_"+id).attr("disabled", false);
}

function toUpdateGrowthAction(id){
	if($("#title_"+id).val()==""){
		art.dialog.tips("标题不能为空！", 2);
		return;
	}
	if($("#content_"+id).val()==""){
		art.dialog.tips("岗位职责不能为空！", 2);
		return;
	}

 	if($("#daiyu_"+id).val()==""){
		art.dialog.tips("待遇不能为空！", 2);
		return;
	}
	if($("#xueli_"+id).val()==""){
		art.dialog.tips("学历不能为空！", 2);
		return;
	}
	if($("#workYears_"+id).val()==""){
		art.dialog.tips("工作年限不能为空！", 2);
		return;
	}
	if($("#workAddress_"+id).val()==""){
		art.dialog.tips("工作地点不能为空！", 2);
		return;
	}
	if($("#zige_"+id).val()==""){
		art.dialog.tips("职业资格不能为空！", 2);
		return;
	}
 



	$.ajax({
			url:"<%=request.getContextPath() %>/member/userinfo!updateInfo.htm?info_id="+id,
			type:'POST',
			data:$("#growthForm_"+id).serialize(),
			success:function(data){
				if(data == "1"){
					art.dialog.tips("招聘信息修改成功！");
					getUserInfoGrowth();
				}
			}
	});
	
	
}




//获取用户成长经历
function getUserInfoGrowth() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getZhaopinList.htm?id=<%=userSession.getId()%>",
		type:'POST',
		dataType:'json', 
		success:function(data){
			var d = eval(data);
			$("#growthHistory").html("");
			var html = "";

			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				html += "<form id='growthForm_"+obj.id+"'>";

				html += "<li><div class='name'> 职业名称：</div>";
				html += "<input  name='title_"+obj.id+"' id='title_"+obj.id+"' value='"+obj.title+"' disabled/>";
				html += ' <div class="xiugai" id="btn_'+obj.id+'"><a href="javascript:toUpdateGrowth('+obj.id+');">修改</a><a href="javascript:toDelGrowth('+obj.id+');" >删除</a></div>';
				html += "</li>";

				html += "<li><div class='name'> 薪资待遇：</div>";
				html += "<input  name='daiyu_"+obj.id+"' id='daiyu_"+obj.id+"' value='"+obj.daiyu+"' disabled/>";
				html += "</li>";

				html += "<li><div class='name'> 学历要求：</div>";
				html += "<input  name='xueli_"+obj.id+"' id='xueli_"+obj.id+"' value='"+obj.xueli+"' disabled/>";
				html += "</li>";

				html += "<li><div class='name'> 工作年限：</div>";
				html += "<input  name='workYears_"+obj.id+"' id='workYears_"+obj.id+"' value='"+obj.workYears+"' disabled/>";
				html += "</li>";

				html += "<li><div class='name'> 工作地址：</div>";
				html += "<input  name='workAddress_"+obj.id+"' id='workAddress_"+obj.id+"' value='"+obj.workAddress+"' disabled/>";
				html += "</li>";

				html += "<li><div class='name'> 任职资格：</div>";
				html += "<input  name='zige_"+obj.id+"' id='zige_"+obj.id+"' value='"+obj.zige+"' disabled/>";
				html += "</li>";


				html += "<li><div class='name'> 岗位职责：</div>";
				html += "<textarea  name='content_"+obj.id+"' id='content_"+obj.id+"'  disabled>"+obj.content+"</textarea></li>";

				html += "<li><hr></li></form>";
			}

			html += "<form id='growthForm' style='display:none'><a name='addMao'></a><li><div class='name'> 职业名称：</div>";
			html += "<input  name='information.title' id='information.title'  value=''  />";
			html += "</li>";

			html += "<li><div class='name'> 薪资待遇：</div>";
			html += "<input  name='information.daiyu' id='information.daiyu' value='' />";
			html += "</li>";

			html += "<li><div class='name'> 学历要求：</div>";
			html += "<input  name='information.xueli' id='information.xueli' value='' />";
			html += "</li>";

			html += "<li><div class='name'> 工作年限：</div>";
			html += "<input  name='information.workYears' id='information.workYears' value='' />";
			html += "</li>";

			html += "<li><div class='name'> 工作地址：</div>";
			html += "<input  name='information.workAddress' id='information.workAddress' value='' />";
			html += "</li>";

			html += "<li><div class='name'> 任职资格：</div>";
			html += "<input  name='information.zige' id='information.zige' value='' />";
			html += "</li>";

			html += "<li><div class='name'>  岗位职责：</div>";
			html += "<textarea id='information.content' name='information.content'  ></textarea></li>";
			
			html += '<li><a href="javascript:addGrowth()" class="querenbaocun">保存</a>';
			html += '<a href="javascript:hideGrowth()" class="querenbaocun">取消</a></li></form>';
			
		
			$("#growthHistory").html(html);
			
 		}
	});
}

function hideGrowth(){
	$("#growthForm")[0].reset();
	$("#growthForm").hide();
}
function showGrowth(){
	$("#growthForm").show();
}
function addGrowth(){
	if($("#information\\.title").val()==""){
		art.dialog.tips("标题不能为空！", 2);
		return;
	}
 	if($("#information\\.daiyu").val()==""){
		art.dialog.tips("待遇不能为空！", 2);
		return;
	}
	if($("#information\\.xueli").val()==""){
		art.dialog.tips("学历不能为空！", 2);
		return;
	}
	if($("#information\\.workYears").val()==""){
		art.dialog.tips("工作年限不能为空！", 2);
		return;
	}
	if($("#information\\.workAddress").val()==""){
		art.dialog.tips("工作地点不能为空！", 2);
		return;
	}
	if($("#information\\.zige").val()==""){
		art.dialog.tips("职业资格不能为空！", 2);
		return;
	}
	if($("#information\\.content").val()==""){
		art.dialog.tips("岗位职责不能为空！", 2);
		return;
	}
	$.ajax({
			url:"<%=request.getContextPath() %>/member/userinfo!saveInfo.htm",
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
		
		$.post('<%=request.getContextPath()%>/member/userinfo!delInfo.htm?information.id='+id,
			function(data){
				if(data=="1"){
					getUserInfoGrowth();
				}
			},"html");
		},
		cancel: true
	});
}

 
 
//分享页面
function userShare(wzd){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo!toUserShare.htm?wzd='+wzd,{lock:true,resize: false,fixed:true});
}
 
 

function tishi(content){
	art.dialog.tips(content);
}

 
var updateFlag = false;
function setUpdateFlag() {
	updateFlag = true;
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
        	<s:param name="menuFlag" value="13"></s:param>
        </s:action>

       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">


<!-- 导航 结束 -->

<div class="right_tab">
<ul>
<li><a href="orginfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>
<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（相册）</a></li>
<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（视频）</a></li>


<li><a  class="change"href="<%=request.getContextPath() %>/member/artInfo!toZhaoPin.htm?<%=HttpSessionHelper.getParamData(request)%>">招聘信息</a></li>
<!-- <li><a href="orginfo.htm?sign=4&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li> -->

</ul>
</div>
<!-- 基础信息 开始 -->

<div id="TabTab03Con">
 
<div class="tianjia" style="margin:10px 0px;border:0px;">
<a href="#addMao" onclick="javascript:showGrowth()">添加</a> 
</div>


<div class="content">
<div class="content_left">
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