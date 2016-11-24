<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		
         function login(){
	   		var userName= $("#username").val();
	   		var userPsd=$("#userPsd").val();
	   		if(userName==""){
	   			art.dialog.tips("请输入用户名！");
	   			return;
	   		}
	   		if(userPsd==""){
	   			art.dialog.tips("请输入密码！");
	   			return;
	   		}
	   		$.post('<%=request.getContextPath()%>/user/userAction!check.htm?username='+userName+'&userPsd='+userPsd,
						function(data){
							if(data == "2"){
								$("#loginFrom").submit();
								parent.location.reload();
							}else if(data=="1"){
								art.dialog.tips("用户名不存在！");
							}else if(data=="0"){
								art.dialog.tips("密码错误！");
							}
			},"html");
	   		
	   }
	   
	   
	   function findPassword(){
	   		var userName=$("#username").val();
	   		window.open ('<%=request.getContextPath() %>/register/registerAction!toFindPassword.htm?userName='+userName,'_self') ;

	   }
	   
	    //使用回车登录
 		var fireLogin =  function fireLogin(){
		if (event.keyCode == 13)
			login();
		}
					
	</script>
  </head>
  <body>
	<form action="<%=request.getContextPath() %>/user/userAction!doWindowLogin.htm" method="post" id="loginFrom">
	<table border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <br/>
        <h2>用户登录</h2>
        <br/>
		<div class="login_srk">
		<label class="lab_ys">用户名：</label>
		<div class="login_in"><input type="text" name="user.username" id="username" onkeypress="fireLogin();" class="login_box"/><div class="login_error" style="display:none;">请输入用户名</div></div>
		</div>
		
		<div class="login_srk">
		<label class="lab_ys">密码：</label>
		<div class="login_in"><input type="password" name="user.userPsd" id="userPsd" onkeypress="fireLogin();" class="login_box" /><div class="login_error" style="display:none;">请输入密码</div></div>
		</div>
		<div class="dl_nav"><a href="javaScript:login();"><img src="<%=request.getContextPath() %>/theme/images/dl_nav.jpg" width="92" height="38" /></a></div>
		
		<div class="hzch_dl">
		<span>使用合作帐号登录</span>
		<ul>
		<li><a href="#"><img src="<%=request.getContextPath() %>/theme/images/hzzh_01.jpg" width="32" height="32" /></a></li>
		<li><a href="#"><img src="<%=request.getContextPath() %>/theme/images/hzzh_02.jpg" width="32" height="32" /></a></li>
		<li><a href="#"><img src="<%=request.getContextPath() %>/theme/images/hzzh_03.jpg" width="32" height="32" /></a></li>
		</ul></div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
	
 
        </form>
  </body>
</html>