<%@page import="com.smt.webapp.util.CommonUtil"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
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
  <!-- org/login1.jsp -->
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/43!register.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/login.css">
	

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>

	<style type="text/css" media="screen">
		html, body { height:100%; background-color: #ffffff;}
		#flashContent { width:100%; height:100%; }
	</style>

	
</head>
  <body style="background: #ffffff;">

  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
 
 <div class="content_login" id="con0">
     <div class="content_loginbt">
       <a href="javascript:showView(0);" class="hong">用户登录</a>
       <a href="javascript:showView(1);" class="hei">快速注册</a>
     </div>
<form action="<%=path %>/user/userAction!doLogin.htm" method="post" id="loginFrom">    
     <div class="content_logincont" style="background:url(<%=request.getContextPath() %>/theme/images/zhezhao/bg02.jpg) ">
       <div style=" height:60px; width:1000px;"></div>
       <ul>
         <li>
           <div>用户名：</div>
           <input type="text" name="user.username" id="username" onkeypress="fireLogin();"  />
         </li>
         <li>
           <div>密码：</div>
           <input type="password" name="user.userPsd" id="userPsd" onkeypress="fireLogin();" />
         </li>
         <li class="meihua">
         	<input type="checkbox" name="checkbox" id="checkbox" class="gou" />
           <font>下次自动登录</font> 
           <a href="javaScript:findPassword();" class="tan">忘记密码？</a>
      
         </li>
         <li>
           <a href="javaScript:login();">登录</a>
         </li>
       
       </ul>
     
     </div>
     
</form>
</div>
<div class="content_login"  id="con1" style="display: none;">
<form id="userForm" name="userForm" action="register/saveUser.html" method="post">
     <div class="content_loginbt">
       <a href="javascript:showView(0);" class="hei">用户登录</a>
       <a href="javascript:showView(1);" class="hong">快速注册</a>
     </div>
     
     <div class="content_logincont">
       <div style=" height:40px; width:1000px;"></div>
       <ul>
         <li style="margin-left:100px;">
		 <span style="width:100px;float:left;display:inline">
         <input name="tappUser.isOrg" type="radio" value="0" checked="checked" class="yuan"/>个人</span>
        <span style="width:200px;float:left;display:inline"><input type="radio" name="tappUser.isOrg"  value="1" class="yuan"/>公司及其他单位</span>
         </li>
         <li>
           <div>用户名：</div>
           <input  name="tappUser.username" id="tappUser.username" type="text" class="text" />
           				<p>该用户名为您的登录账号，由英文字母和数字组成，不含中文和特殊符号</p>
           	
         </li>
         <li>
           <div>密码：</div>
           <input name="tappUser.userPsd" type="password" id="tappUser.userPsd" class="text" />
           <p>密码为6-18位英文字母或数字构成。</p>
         </li>
         <li>
           <div>确认密码：</div>
          <input name="userPsdbak" type="password" id="userPsdbak" class="text" />
          <p></p>
         </li>
         <li>
           <div>手机：</div>
           <input name="mobile" id="mobile" type="text" class="text" />
           <p></p>
         </li>
         <li>
           <div>邮箱：</div>
           <input name="tappUser.email" type="text" class="text" id="tappUser.email"/>
           <p>你忘记密码的时候该邮箱发挥作用咯！</p>
         </li>
         <li>
           <div>验证码：</div>
           <input name="verification_code" id="verification_code" type="text" class="duan" style="margin-left: 35px;"/>
           <dd class="yanzheng"><img title="点击更换" onclick="javascript:refresh1(this);" src="imageServlet" style="cursor: pointer;"></dd>
           <p></p>
         </li>

         <li class="meihua">
           <input type="checkbox" name="checkbox1" id="checkbox1"  class="gou"/>
           <font>我同意用户协议</font>
           <a href="javascript:openShow()" class="tann">《第一舞台服务协议》</a>
           <span></span>
         </li>
         <li>
           <a href="javascript:doSubmit();">继续</a>
         </li>
       
       </ul>
       <div style=" height:40px; width:1000px;"></div>
     </div>
     </form>
</div>
<script language="javascript">

	// 手机号码验证
	jQuery.validator.addMethod("mobile", function(value, element) {
				var length = value.length;
				return this.optional(element)
						|| (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/
								.test(value));
			}, "手机号码格式错误");


function showView(flag) {
	if(flag == 0) {
		$1("con1").style.display="none";
		$1("con0").style.display="block";
	} else if(flag == 1) {
		$1("con1").style.display="block";
		$1("con0").style.display="none";
	}
}
showView(${flag});

$().ready(function(){
	showView(${flag});
	
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
				required: true,
				equalTo: "#tappUser\\.userPsd"
    		},
    		"mobile":{
    			required: true,
				mobile:true,
				remote: {
					url:'register/checkMobile.html?date='+new Date(),
					type: "post"
				}
    		},
    		"tappUser.email":{
    			required: true,
				rangelength: [1, 32],
				email:true,
				remote:{
					url:'register/checkEmail.html?date='+new Date(),
					type:"post"
				}
    		},
			"verification_code":  {
				required: true,
				remote: {
					url:'register/checkVerification_code.html?date='+new Date(),
					type: "post"
				}
			}
    	},
    	messages: {
			"tappUser.username": {
				required: "&nbsp;<span style='color:red'>用户名不能为空!</span>",
				isUserId: "&nbsp;<span style='color:red'>用户名只能包含英文字母、数字、或者下划线!</span>",
				rangelength: "&nbsp;<span style='color:red'>用户名长度为6-25位!</span>",
				remote: "&nbsp;<span style='color:red'>用户名已存在!</span>"
			},
			"mobile":{
				required: "&nbsp;<span style='color:red'>手机号码不能为空!</span>",
				mobile:"&nbsp;<span style='color:red'>请输入正确的手机号码!</span>",
				remote: "&nbsp;<span style='color:red'>手机号码已存在!</span>"
			},
			"tappUser.email":{
				required: "&nbsp;<span style='color:red'>E-mail不能为空!</span>",
				rangelength:"&nbsp;<span style='color:red'>E-mail长度为1-32位!</span>",
				email:"&nbsp;<span style='color:red'>请输入正确的E-mail地址!</span>",
				remote: "&nbsp;<span style='color:red'>E-mail地址已存在!</span>"
				
			},
			"tappUser.userPsd":{
				required: "&nbsp;<span style='color:red'>密码不能为空!</span>",
				rangelength:"&nbsp;<span style='color:red'>密码的长度为6-25位!</span>"
			},
			"userPsdbak":{
				required: "&nbsp;<span style='color:red'>确认密码不能为空!</span>",
				equalTo:"&nbsp;<span style='color:red'>两次密码输入不一致!</span>"
			},
			"verification_code":{
				required: "&nbsp;<span style='color:red'>验证码不能为空!</span>",
				remote:"&nbsp;<span style='color:red'>验证码不正确!</span>"
			}
		},
		errorPlacement: function(error, element) {  //验证消息放置的地方   
		    if(element.attr("id")=='verification_code'){
		    	error.appendTo($("#v_code")); 
		    }
		    element.parent("li").find("p").text("");
           error.appendTo( element.parent("li").find("p"));
           //alert(error.html());
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
						if(data1>=0){
							//parent.hide(null);
							//window.parent.location.reload();
						var url = "<%=path+session.getAttribute(HttpSessionHelper.SESSION_REDIRECT) %>";
						<%
						if(session.getAttribute(HttpSessionHelper.SESSION_REDIRECT)!=null) {%>
							var indUserId = url.indexOf("@{loginUserId}");
							if(indUserId>=0){
								var preUrl = url.substring(0,indUserId);
								var postUrl = url.substring(indUserId+"@{loginUserId}".length);
								url = preUrl + data1 + postUrl;
							}
							//alert("<%=path %>"+url);
							window.location.href = "<%=path %>"+url;
						<%} else{%>
								window.location.href ="<%=path %>/index.html";
						<%
							}
							session.removeAttribute(HttpSessionHelper.SESSION_REDIRECT);
						%>
						//history.go(-1);
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
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

<script type="text/javascript">
    function doSubmit(){
    	if(!$('#checkbox1').attr("checked")){
    		//alert("请阅读《第1舞台服务协议》");
			art.dialog.alert("请阅读《第1舞台服务协议》", 2);
    		return;
    	}

    	if($("#userForm").valid()){
			  //parent.hide(null);
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
    	} 
}
</script>
  </body>
</html>