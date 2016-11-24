<%@page import="com.smt.webapp.util.CommonUtil"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<%
	String path = request.getContextPath();
	String urlRewriteUrl = CommonUtil.getIsnullReturnString((String)request.getParameter("urlRewriteUrl"), "0");
	String urlRewriteParam = CommonUtil.getIsnullReturnString((String)request.getParameter("urlRewriteParam"), "0");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <!--  page/login2.jsp-->
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/data.css" />
	<script type="text/javascript" language="javascript" src="<%=path %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=path %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=path %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>theme/js/jquery.validate.min.js"></script>
<style type="text/css">
body{margin:0;padding:0;font-size:12px;font-family:"微软雅黑";margin:0 auto;width:630px;}
a{color:#000; text-decoration:none;}
ul{padding:0; margin:0; list-style:none; }
.l{float:left}
img,input{border:0;}
form,ul,li,dl,dd,p,dt,img{margin:0;padding:0;}
img{border:none;}
.bj{width:626px;background:#fff}
#box{width:620px;height:36px;border-bottom:1px solid #ccc;}
#box li{float:left;background:url(<%=path%>/theme/images2/tu63.jpg) repeat-x;width:113px;height:37px;margin-left:15px;}
#box li a{display:block;line-height:36px;text-align:center;color:#555;font-weight:bold;}
#box .cc a{color:#555;background:url(<%=path%>/theme/images2/tu62.jpg) repeat-x;}
.con{width:596px;padding:10px 10px 0 20px;/*height:100px;
 height:auto !important; min-height:100px;*/overflow: auto;zoom:1;display: none;}

#con1,#con2{display:none}
.pp{height:36px;line-height:37px;font-size:22px;padding-left:20px;width:300px}
.text{background:none;width:250px;height:30px;line-height:30px;}
.text2{width:135px;background:none;height:30px;line-height:30px;}
.tt{background:url(<%=path%>/theme/images2/tu64.jpg) no-repeat;}
.tt:hover{background:url(<%=path%>/theme/images2/tu68.jpg) no-repeat}
body,td,th {
	font-size: 14px;
}
.tt2{background:url(<%=path%>/theme/images2/tu70.jpg) no-repeat;width:137px}
.tt2:hover{background:url(<%=path%>/theme/images2/tu71.jpg) no-repeat}
</style>
<script type="text/javascript">
	function openShow(){
		parent.openShow();
	}
</script>
</head>

<body>



<div class="bj">
<div id="box">
<p class="pp l">用户登录</p>
<ul class="pp2 l">
   <li value="0" onclick="showView(0)"><a href="javascript:void(0)">用户登录</a></li>
   <li value="1" onclick="showView(1)"><a href="javascript:void(0)">快速注册</a></li>
</ul>
</div>  
<div class="con" id="con0">
<form action="<%=path %>/user/userAction!doLogin.htm" method="post" id="loginFrom">
<table width="95%" border="0" height="100%">
<tr>
    <td height="20" colspan="3" valign="top">&nbsp;</td>
    </tr>
  <tr>
    <td width="14%" height="40" valign="middle">用户名：</td>
    <td width="52%" height="40" valign="top" class="tt"><input type="text" name="user.username" id="username" onkeypress="fireLogin();" class="text" /></td>
<!--     <td width="34%" height="40" align="center" valign="middle">使用合作账号登录</td> -->
  </tr>
  <tr>
    <td height="40" valign="middle">密码：</td>
    <td height="40" valign="top" class="tt"><input type="password" name="user.userPsd" id="userPsd" onkeypress="fireLogin();" class="text" /></td>
<%--     <td height="40" align="center" valign="top"><a href=""><img src="<%=path%>/theme/images2/tu65.jpg" width="30" height="30" /></a>&nbsp;&nbsp;<a href=""><img src="<%=path%>/theme/images2/tu66.jpg" width="30" height="30" /></a>&nbsp;&nbsp;<a href=""><img src="<%=path%>/theme/images2/tu67.jpg" width="30" height="30" /></a></td> --%>
  </tr>
  <tr>
    <td height="20" valign="top">&nbsp;</td>
    <td height="20" align="right" valign="top" ><a href="javaScript:findPassword();" style="color:#00b7ed;text-decoration:underline">忘记密码？</a></td>
    <td height="20" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td height="40" valign="top">&nbsp;</td>
    <td height="40" valign="top"><form id="form1" name="form1" method="post" action="">
      <label>
        <input type="checkbox" name="checkbox" id="checkbox" />
      </label>
    下次自动登录
    </form></td>
    <td height="40" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td height="40" valign="top">&nbsp;</td>
    <td height="40" valign="top"><a href="javaScript:login();"><img src="<%=path%>/theme/images2/tu69.jpg" width="81" height="32" /></a></td>
    <td height="40" valign="top">&nbsp;</td>
  </tr>
</table>
</form>

</div>
<div class="con" id="con1">
<form id="userForm" name="userForm" action="register/saveUser.html" method="post">
<div id="showError"></div>
<table width="95%" border="0" height="100%">
<tr>
    <td height="20" colspan="3" valign="top">&nbsp;</td>
    </tr>
  <tr>
    <td width="14%" height="30" valign="middle"></td>
    <td width="52%" height="30" valign="middle"><input name="tappUser.isOrg" type="radio" value="0" checked="checked"/>个人&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tappUser.isOrg"  value="1"/>公司及其他单位</td>
    <td width="34%" height="30" valign="middle"></td>
  </tr>
  <tr>
    <td width="14%" height="40" valign="middle">用户名：</td>
    <td width="52%" height="40" valign="top" class="tt">
    <input  name="tappUser.username" id="tappUser.username" type="text" class="text" /><div></div></td>
<!--     <td width="34%" height="40" align="center" valign="middle">使用合作账号登录</td> -->
  </tr>
  <tr>
    <td height="40" valign="middle">密码：</td>
    <td height="40" valign="top" class="tt"><input name="tappUser.userPsd" type="password" id="tappUser.userPsd" class="text" /><div></div></td>
<%--     <td height="40" align="center" valign="top"><a href=""><img src="<%=path%>/theme/images2/tu65.jpg" width="30" height="30" /></a>&nbsp;&nbsp;<a href=""><img src="<%=path%>/theme/images2/tu66.jpg" width="30" height="30" /></a>&nbsp;&nbsp;<a href=""><img src="<%=path%>/theme/images2/tu67.jpg" width="30" height="30" /></a></td> --%>
  </tr>
    <tr>
    <td height="40" valign="middle">重复密码：</td>
    <td height="40" valign="top" class="tt"><input name="userPsdbak" type="password" id="userPsdbak" class="text" /><div></div></td>
    <td height="40" align="center" valign="top"></td>
  </tr>
    <tr>
    <td height="40" valign="middle">手机：</td>
    <td height="40" valign="top" class="tt"><input name="mobile" type="text" class="text" /><div></div></td>
    <td height="40" align="center" valign="top"></td>
  </tr>
  <tr>
    <td height="40" valign="middle">Email：</td>
    <td height="40" valign="top" class="tt"><input name="tappUser.email" type="text" class="text" id="tappUser.email"/><div></div></td>
    <td height="40" align="center" valign="top"></td>
  </tr>
    <tr>
    <td height="40" valign="middle">验证码：</td>
    <td height="40" valign="top" class="tt2"><input name="verification_code" id="verification_code" type="text" class="text2" />&nbsp;&nbsp;<img title="点击更换" onclick="javascript:refresh1(this);" src="imageServlet"><div></div></td>
    <td height="40" align="center" valign="top"></td>
  </tr>
  <tr>
    <td height="40" valign="top">&nbsp;</td>
    <td height="40" valign="top" >
      <label><input type="checkbox" name="checkbox1" id="checkbox1" /></label>
    我同意用户协议 <a href="javascript:openShow()" style="color:#00b7ed;">《第1舞台服务协议》</a>
    </td>
    <td height="40" valign="top">&nbsp;</td>
  </tr>
 
  <tr>
    <td height="40" valign="top">&nbsp;</td>
    <td height="40" valign="top"><a href="javascript:doSubmit();"><img src="<%=path%>/theme/images2/tu73.jpg" width="81" height="32" /></a></td>
    <td height="40" valign="top">&nbsp;</td>
  </tr>
</table>
</form>
</div>



<script language="javascript">
function showView(flag) {
	if(flag == 0) {
		try {
			parent.document.getElementById("top-pop").height = "350";
		} catch(e){}
		$1("con1").style.display="none";
		$1("box").getElementsByTagName("li")[1].className="";
		
		$1("con0").style.display="block";
		$1("box").getElementsByTagName("li")[0].className="cc";
	} else if(flag == 1) {
		try {
			parent.document.getElementById("top-pop").height = "500";
		} catch(e){}
		
		$1("con1").style.display="block";
		$1("box").getElementsByTagName("li")[1].className="cc";
		
		$1("con0").style.display="none";
		$1("box").getElementsByTagName("li")[0].className="";
	}
}
showView(${flag});

$().ready(function(){
	
	$("#userForm").validate({
    	rules: {
    		"tappUser.username":{
    			required: true,
    			isUserId: true,
				rangelength: [6, 25],
				remote:'register/findUserByUserName.html?date='+new Date()
    		},
    		"tappUser.userPsd":{
    			required: true,
				rangelength: [6, 25]
    		},
    		"userPsdbak":{
				equalTo: "#tappUser\\.userPsd"
    		},
    		"tappUser.email":{
    			required: true,
				rangelength: [1, 32],
				email:true/*,
				remote:{
				url:'register/checkEmail.html?date='+new Date(),
				type:"post"}*/
    		},
			verification_code:  {
				required: true,
				remote: {
			    url:'register/checkVerification_code.html',
			    type: "post"}
			}
    	},
    	messages: {
			"tappUser.username": {
				required: "&nbsp;<font color='red';>用户名不能为空!</font>",
				isUserId: "&nbsp;<font color='red';>用户名只能包含英文字母、数字、或者下划线!</font>",
				rangelength: "&nbsp;<font color='red';>用户名长度为6-25位!</font>",
				remote: "&nbsp;<font color='red';>用户名已存在!</font>"
			},
			"tappUser.email":{
				required: "&nbsp;<font color='red';>E-mail不能为空!</font>",
				rangelength:"&nbsp;<font color='red';>E-mail长度为1-32位!</font>",
				email:"&nbsp;<font color='red';>请输入正确的E-mail地址!</font>",
				remote: "&nbsp;<font color='red';>E-mail地址已存在!</font>"
				
			},
			"tappUser.userPsd":{
				required: "&nbsp;<font color='red';>密码不能为空!</font>",
				rangelength:"&nbsp;<font color='red';>密码的长度为6-25位!</font>"
			},
			"userPsdbak":{
				equalTo:"&nbsp;<font color='red';>两次密码输入不一致!</font>"
			},
			verification_code:{
				required: "&nbsp;<font color='red';>验证码不能为空!</font>",
				remote:"&nbsp;<font color='red';>验证码不正确!</font>"
			}
		},
		errorPlacement: function(error, element) {  //验证消息放置的地方   
		    if(element.attr("id")=='verification_code'){
		    	error.appendTo($("#v_code")); 
		    }
            error.appendTo( element.parent("td").find("div")); 
           
            //element.addClass("haha");
        },   
        highlight: function(element, errorClass) {  //针对验证的表单设置高亮   
            $(element).addClass(errorClass);   
        },   
        success: function(label) {     
              label.addClass("valid").text(""); 
        }    
	});
	
	jQuery.validator.addMethod("isUserId", function(value, element) {   
   		 var userid = /^[A-Za-z0-9_]+$/;
   		 return this.optional(element) || (userid.test(value));
	}, "请正确填写您的平台用户名");

});
function $1(id){
	return document.getElementById(id);
}

function refresh1(obj) {
    obj.src = "imageServlet?"+Math.random();
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
		
		$.ajax({
		   url:"<%=path %>/user/userAction!check.htm",
		   type:'POST',
		   data:$("#loginFrom").serialize(),
		   success:function(data2){
			   if(data2 == "2"){
				  $.ajax({
					 url:"<%=path %>/user/userAction!doLogin.htm",
					 type:'POST',
					 data:$("#loginFrom").serialize(),
					 success:function(data1){
						 if(data1=="1"){
							  parent.hide(null);
							  window.parent.location.reload();
						 }
					 }
				  });
				  //$("#loginFrom").submit();
				  
			  }else if(data2=="1"){
				  art.dialog.tips("用户名不存在！");
			  }else if(data2=="0"){
				  art.dialog.tips("密码错误！");
			  }
		   }
		});
		
		
		
}

function findPassword(){
//parent.hide(null);
		var userName=$("#username").val();
		window.open ('<%=path %>/register/registerAction!toFindPassword.htm?userName='+userName) ;

}

	//使用回车登录
var fireLogin =  function fireLogin(){
if (event.keyCode == 13)
		login();
};
</script>
</div>
<script type="text/javascript">
var isSubmit = false;
    function doSubmit(){
    	if(!$('#checkbox1').attr("checked")){
    		art.dialog.alert("请阅读《第1舞台服务协议》");
    		return;
    	}
    	if($("#userForm").valid()){
			if(!isSubmit){ 
        	  isSubmit = true;   
			  parent.hide(null);
			  $.ajax({
				 url:"<%=request.getContextPath() %>/register/saveUser.html",
				 type:'POST',
				 data:$("#userForm").serialize(),
				 success:function(data){
					 if(data=="1"){
				  		parent.window.location.href = "<%=request.getContextPath() %>/register/registerAction!registerSuccess.htm";
					 }
				 }
			  });
        	  //parent.hide(null);
			  //$("#userForm").submit();
			  //parent.subRegister();
      	   } 
    	}  
}
</script>
</body>
</html>
