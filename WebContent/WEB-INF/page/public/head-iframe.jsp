<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.UserSession" %>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.net.URLEncoder"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>



<%
String titleType = (String)request.getParameter("titleType");  
UserSession userSession = HttpSessionHelper.getUserSession(request) ;
String style="class='change'";
String path = request.getContextPath();
String hasNoMy=(String)session.getAttribute("hasNoMy");

%>


<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
 
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/index/css/style2.css" />

	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/select.js"></script>
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

<link rel="stylesheet" href="<%=path%>/theme/job/css/style3.css" />




<SCRIPT LANGUAGE="JavaScript">

	  function headSubmit(){
		if($("#headKeywords").val()=="请输入关键词"){ 
			$("#headKeywords").val("");
			return;
		}
			$("#headSearchFrom").submit();
		}
		
		function showHelp(){
			art.dialog({
					icon: 'help',
					content: '艺人职业价格为参考价，具体价格可与艺人协商。',
					ok: true,
					cancel: false
				});
		}


$(function(){
 

		//商品分类
		/*	
		$(".fwfl").hover(function(){
			$(this).find(".arrow_Downward").removeClass().addClass("arrow_Upward")
			$(this).find("#fwfl_c").show()
		},function(){
			$(this).find(".arrow_Upward").removeClass().addClass("arrow_Downward")
			$(this).find("#fwfl_c").hide()
		})
		*/
		
			
		$('.Cnav .item').hover(function(){
			$(this).addClass('active').find('.product span').attr("class","product_Arrow2");
			$(this).find('.product_wrap').show();
		},function(){
			$(this).removeClass('active').find('.product span').attr("class","product_Arrow")
			$(this).find('.product_wrap').hide();
		});


});
function pinfen(){}


</SCRIPT>



  </head>
<body>
<div class="top Layout" style="text-align:center; ">

<div class="top_t">


<%@include file= "/WEB-INF/page/public/top3-iframe.jsp"%>

</div>
<div class="top_c">
	<div class="top_c_nav mian Layout">
   	  <div class="top_c_nav_l fl" style="margin-left:-34px;">
      	<ul>
        	<li class="fwfl"><!-- <a >全部服务分类</a> -->
              <div class="Cnav" id="fwfl_c">


<%@include file= "/WEB-INF/page/public/menu-iframe.jsp"%>
