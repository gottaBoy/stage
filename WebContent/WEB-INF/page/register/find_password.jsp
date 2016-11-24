<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.entity.TAppTask"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>1stage第1舞台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
    	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/slides.jquery.js"></script>

	<script language="javascript" type="text/javascript">
			    
  	    
  	    function submit(){
  	   		var email=$("#email").val();
  	   		/*var userName=$("#userName").val();
  	   		if(userName==""){
   	   			viewErrorMessage("userName","用户名不能为空！");
  	   			return;
  	   		}*/
  	   		if(email==""){
  	   			viewErrorMessage("email","邮箱不能为空！");
  	   			return;
  	   		}
  	   		
  	   		$.post('<%=request.getContextPath()%>/register/registerAction!checkUserEmail.htm?email='+email,
						function(data){
							if(data == "2"){
								$('#findPasswordFrom').submit();
							}else if(data=="1"){
								viewErrorMessage("email","用户不存在！");
							}
							/*else if(data=="0"){
								viewErrorMessage("email","与注册的邮箱不同！");
							}*/
			},"html");
 		}
 		
 		function viewErrorMessage(wordkey,message){
 			$("#"+wordkey+"Message").html(message);
  	   		$("#"+wordkey+"Message").css("color","red"); 
  	   		$("#"+wordkey+"Img").attr("src","<%=request.getContextPath() %>/theme/images/error.jpg");
 		}
 		
 		function viewMessage(wordkey,message){
 			$("#"+wordkey+"Message").html(message);
  	   		$("#"+wordkey+"Message").css("color","#000000"); 
  	   		$("#"+wordkey+"Img").attr("src","<%=request.getContextPath() %>/theme/images/ok.gif");
 		}
 		
 		
 	
</script>
  </head>
 
 
<body >
    <jsp:include page="/WEB-INF/page/public/head2.jsp">
      <jsp:param value="no" name="titleType"/>
  </jsp:include>
<s:property value="#task.title"/>
<!-- 主内容开始 -->
<div id="login_box_password">
<form id="findPasswordFrom" action="<%=request.getContextPath() %>/register/registerAction!findPassword.htm" method="post">
    <table width="550" border="0" align="center" cellpadding="0" cellspacing="0" class="find_password">
        <tr>
            <td width="72">&nbsp;</td>
            <td colspan="2" align="left" class="find_password_tit">找回密码</td>
        </tr>
<!--         <tr>
            <td align="right">登录名：</td>
            <td width="275"><input type="text" name="userName" id="userName" class="find_password_input" value="<%=request.getParameter("userName") %>"/></td>
            <td width="203" class="password_sm"><img id="userNameImg" src="<%=request.getContextPath() %>/theme/images/light.jpg" width="12" height="17" />&nbsp;<font size="2" id="userNameMessage">请输入您的用户名</font></td>
        </tr> -->
        <tr>
            <td align="right" class="find_password_email">E-mail：</td>
            <td><input type="text" name="email" id="email" class="find_password_input" /></td>
            <td class="password_sm"><img id="emailImg" src="<%=request.getContextPath() %>/theme/images/light.jpg" width="12" height="17" />&nbsp;<font size="2" id="emailMessage">请输入您注册时填写的E-mail</font></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="password_sm_nav"><a href="javaScript:submit();"><img src="<%=request.getContextPath() %>/theme/images/find.jpg" width="92" height="38" /></a></td>
            <td>&nbsp;</td>
        </tr>
    </table>
</form>

</div>
<!-- 主内容结束 -->
<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>

<!-- 底部结束 --> 
  
  </body>
  <script>
/*  $("#userName").blur(function(){
 			var userName=$("#userName").val();
  	   		if(userName==""){
   	   			viewErrorMessage("userName","用户名不能为空！");
  	   		}else{
  	   			viewMessage("userName","");
  	   		}
  		});
*/ 		
 		$("#email").blur(function(){
 			var email=$("#email").val();
   	   		if(email==""){
  	   			viewErrorMessage("email","邮箱不能为空！");
  	   		}else{
  	   			viewMessage("email","");
  	   		}
 		});
 	
</script>
  
</html>

