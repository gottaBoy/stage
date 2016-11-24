<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<link href="<%=request.getContextPath() %>/theme/css/global_layout.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>验证码</title>
  </head>
  <body>
  <%String pageNo = (String)request.getParameter("pageNo"); 
  %>

  <%
  if(pageNo!=null&&!"".equals(pageNo)){
  
  }else{
  
  pageNo ="1";
  }
  %>

 <pg:pages  pageNo="<%=pageNo %>" rowCount ="5" params="sdf=sdf&&sdf=sdf" url="image.jsp" total="22" styleClass="page" ></pg:pages> 


  </body>
</html>