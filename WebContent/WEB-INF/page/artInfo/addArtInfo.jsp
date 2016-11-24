<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	UserSession userSession = HttpSessionHelper.getUserSession(request);
	int isForOrg = HttpSessionHelper.getOrgData(request); //0:no  1:yes
	int isIndividual = HttpSessionHelper.getIsOrg(request);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
        <!---------artinfo\addArtInfo.jsp -->
    <title><%=StageVariale.title%></title>
    <% String sign=request.getParameter("sign");%>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){	 
		<% if("2".equals(sign)){%>
			if($("#artInfo\\.title").val()==""){
				$("#artInfo\\.title").val("给你的视频文件取个有力的名字吧！");
			}
			if($("#artInfo\\.url").val()==""){
				$("#artInfo\\.url").val("请复制视频链接到这里！");
			}
		<%}%>
 
	});
			
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		
        function doSubmit(){
		<% if("2".equals(sign)){%>
			/*
			if($("#artInfo\\.title").val()=="给你的视频文件取个有力的名字吧！" || $("#artInfo\\.title").val()==""){
				art.dialog.tips("给你的视频文件取个有力的名字吧！");
				return;
			}
			*/
			if($("#artInfo\\.title").val()=="给你的视频文件取个有力的名字吧！"){
				$("#artInfo\\.title").val("");
			}
			if($("#artInfo\\.url").val()=="请复制视频链接到这里！"  || $("#artInfo\\.url").val()=="" ){
				art.dialog.tips("请复制视频链接到这里！");
				return;
			}
			/*
			if($("#artInfo\\.intro").val()=="讲讲视频背后的故事吧！" ){
				$("#artInfo\\.intro").val("");
			}
			
			if($("#artInfo\\.intro").val()=="讲讲视频背后的故事吧！"  || $("#artInfo\\.intro").val()=="" ){
				art.dialog.tips("讲讲视频背后的故事吧！");
				return;
			}
			*/
		<%}else{%>
			if($("#artInfo\\.title").val()==""){
				art.dialog.tips("请提供相册名称！");
				return;
			}
			/*
			if($("#artInfo\\.intro").val()=="" ){
				art.dialog.tips("请提供简介！");
				return;
			}
			*/
		<%}%>

			 $.ajax({
			   url:"<%=request.getContextPath() %>/member/artInfo!saveOrUpdateArtInfo.htm?sign="+${artInfo.type},
			   type:'POST',
			   data:$("#artInfoForm").serialize(),
			   success:function(data){
				   if(data=="1"){
						art.dialog.close();
				   }
			   }
			});
 
			
        }
		
		function openTudou() {
			window.open("<%=request.getContextPath() %>/tudou/tudou.jsp","_blank");	
		}
	</script>
  </head>
  <body>
 
  <form id="artInfoForm" name="artInfoForm" action="member/artInfo!saveOrUpdateArtInfo.htm?sign=${artInfo.type}" method="post">
	<input type="hidden" name="id" value="${artInfo.userId}"/> 
	<input type="hidden" name="artInfo.id" value="${artInfo.id}"/> 
	<input type="hidden" name="artInfo.userId" value="${artInfo.userId}"/> 
	<input type="hidden" name="artInfo.type" value="${artInfo.type}"/> 
	<input type="hidden" name="artInfo.imgCount" value="${artInfo.imgCount}"/> 

<% if("2".equals(sign)){%>
	<div  style="height:400px;">
<%}else{%>
	<div  style="height:300px;">
<%}%>

  <span class="zhezhaoClose" title="关闭"></span>
    
  <div class="zhezhaoxiangce">
  <% if("2".equals(sign)){%>
		<h3>视频信息</h3>
<%}else{%>
		<h3>相册信息</h3>
<%}%>
     
     <div class="zhezhaoxiangce_a">
		<% if("2".equals(sign)){%>
		     1、优酷视频直接复制链接<br />
		<%}%>
   </div>
     <ul>
        <li style="line-height:35px;height:35px;">
  <% if("2".equals(sign)){%>
		<div class="name">标题:</div>
<%}else{%>
		<div class="name">相册名称:</div>
<%}%>
           
           <input type="text" name="artInfo.title" id="artInfo.title" value="${artInfo.title}"  onfocus="if (this.value=='给你的视频文件取个有力的名字吧！') this.value=''" />
		   <div class="ti_shi"></div>
        </li>
		<% if("2".equals(sign)){%>
        <li style="line-height:35px;height:35px;">
           <div class="name"><span>*</span>链接地址:</div>
           <input type="text" name="artInfo.url" id="artInfo.url" value="${artInfo.url }"   onfocus="if (this.value=='请复制视频链接到这里！') this.value='';" />
		   <div class="ti_shi"></div>
        </li>


		 <%}%>
        <li>
           <a href="javascript:doSubmit();" class="baocun01">保存</a>
           <a href="javascript:CloseWin();">取消</a>
        </li>
     </ul>
  </div>
  
  
</div></form>
  </body>
</html>