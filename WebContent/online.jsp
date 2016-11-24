<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>1stage第1舞台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
            当前用户:<%
            UserSession userInfo = HttpSessionHelper.getUserSession(request);
             if(userInfo != null){
             %>
             <%=userInfo.getUserName() %>
             <% 
             }
            %>
            在线人数:<%
            //ServletContext appContext = session.getServletContext();
            ServletContext app = session.getServletContext(); 
             List<UserSession> onlineUserList = (List) app.getAttribute(OnlineUser.STAGE_ONLINE); 
            if(onlineUserList != null) {
            
               for(int i= 0 ; i<onlineUserList.size();i++){
                  UserSession dSession= onlineUserList.get(i);
                  %>
                 <%= dSession.getUserName()%> 
               <%
               }
            
             } %>
  </form>
  </body>
</html>
