<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
    	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/slides.jquery.js"></script>
	<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
	<script language="javascript" type="text/javascript">
	
		
		
		//说明 所有的元素以ul li ul li ul li的循环格式嵌套 如果没有下级分类 就用li a结束嵌套
		$(document).ready(function(){

		$(".nav").find("li").not(":has(ul)").children("a").css({textDecoration:"none",color:"#333",background:"none"})
		.click(function(){
		$(this).get(0).location.href="'"+$(this).attr("href")+"'";
		});
		$(".nav").find("li:has(ul)").children("a").css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg.jpg) no-repeat left top;"})
		.click(function(){
		if($(this).next("ul").is(":hidden")){
		$(this).next("ul").slideDown("slow");
		if($(this).parent("li").siblings("li").children("ul").is(":visible")){
		$(this).parent("li").siblings("li").find("ul").slideUp("1000");
		$(this).parent("li").siblings("li:has(ul)").children("a").css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg.jpg) no-repeat left top;"})
		.end().find("li:has(ul)").children("a").css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg.jpg) no-repeat left top;"});}
		$(this).css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg02.jpg) no-repeat left top;"});
		return false;
		}else{
		$(this).next("ul").slideUp("normal");
		//不用toggle()的原因是为了在收缩菜单的时候同时也将该菜单的下级菜单以后的所有元素都隐藏
		$(this).css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg.jpg) no-repeat left top;"});
		$(this).next("ul").children("li").find("ul").fadeOut("normal");
		$(this).next("ul").find("li:has(ul)").children("a").css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg.jpg) no-repeat left top;"});
		return false;
		}
		});
		//默认展开
		<%String sign = (String)request.getParameter("sign");%>
		$("#<%=sign%>").show();
		$("#<%=sign%>").prev("a").css({background:"url(<%=request.getContextPath() %>/theme/images/nav_liimg02.jpg) no-repeat left top;"})

		});
		
				
		function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
  	    }
		
</script>
  </head>
 
 
<body >
    <jsp:include page="/WEB-INF/page/public/head2.jsp">
      <jsp:param value="no" name="titleType"/>
  </jsp:include>

<!-- 主内容开始 -->

<!-- 主内容开始 -->
<div id="user_list_box">
<div class="user_list_left">
<h1>平台相关</h1>

<div class="nav">
<ul>
<s:iterator value="#request.oneMenu" var="oneItem">
<li><a href="#"><s:property value="#oneItem.menuName"/></a>
<ul class="child" id="<s:property value="#oneItem.id"/>">
<s:iterator value="#request.twoMenu" var="twoItem">
<s:if test="#twoItem.parentId==#oneItem.id">	
<li class="second_li">
<a href="<%=request.getContextPath() %>/about/about!toAbout.htm?id=<s:property value="#twoItem.id"/>&sign=<s:property value="#oneItem.id"/>"><s:property value="#twoItem.menuName"/></a>
</li>
</s:if>
</s:iterator>
</ul>
</li>
</s:iterator>
</ul>
</div>
</div>
<!--  右 内容 结束 -->

<div class="user_list_right_02">
<table width="800" border="0" cellspacing="0" cellpadding="0" id="list_photo_img" >
    <tr>
        <td>
<div class="list_contitle"><ul>
<li><span class="list_contitle_01">${info.menuName }</span></li></ul></div>

<!-- 图片列表  开始 -->

<div class="member_photo_detcontecnt" style="min-height: 450px">
 
    ${info.content }

</div>
</td>
</tr>
</table>
</div>
</div>
<!-- 主内容结束 -->

<div class="clear"></div>
<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>

<!-- 底部结束 --> 
  
  </body>
</html>
