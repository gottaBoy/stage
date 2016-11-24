<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.UserSession" %>
<%@page import="java.net.URLEncoder"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
<style>
.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:4250px;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.80;filter: alpha(opacity=80);}
.white_content{display:none;position:absolute;top:25%;width:630px;height:4250px;z-index:1002;overflow:auto;}

#weixin_img{
	width:371px; height:354px; background:url(<%=request.getContextPath()%>/theme/images2/2wm.png) no-repeat; position:fixed; left:230px; top:30px; display:none; z-index:9999;
_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)));
}
</style>

<%
String titleType = (String)request.getParameter("titleType");  
UserSession userSession = HttpSessionHelper.getUserSession(request) ;
String style="class='change'";
String path = request.getContextPath();
String hasNoMy=(String)session.getAttribute("hasNoMy");

%>


<iframe src="<%=request.getContextPath()%>/index/indexAction!headIframe.htm" width="100%" height="190" border="0" scrolling="no" style="margin:0px;padding:0px;border:0px;overflow:hidden;z-index:-2"></iframe>