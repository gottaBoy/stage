<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.UserSession" %>
<%@page import="com.smt.common.StageVariale"%>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
    <% UserSession userSession =  HttpSessionHelper.getUserSession(request) ;%>
<script type="text/javascript">

	   <%if(1==userSession.getIsOrg()){ %>
	   		window.location = "<%=request.getContextPath()%>/member/orginfo.htm";
			
		 <%} else{%>
		 	window.location = "<%=request.getContextPath()%>/member/userinfo!register02.htm";
		 <%} %>  

 </script>
  </head>
 