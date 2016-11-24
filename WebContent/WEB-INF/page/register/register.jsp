<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!-- register/register.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
    function refresh(obj) {
        obj.src = "<%=request.getContextPath()%>/imageServlet?" + Math.random();
    }
    $().ready(function(){
    	window.location.hash = "#top";   
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
					email:true,
					remote:{
					url:'register/checkEmail.html?date='+new Date(),
					type:"post"}
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
	            error.appendTo( element.parent("div").parent("td").parent("tr").prev().children(0)); 
	           
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
    </script>
  </head>
  <body>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
<form id="userForm" name="userForm" action="<%=request.getContextPath() %>/register/saveUser.html" method="post">
<input type="hidden" name="tappUser.rzState" value="1"/> 
<input type="hidden" name="tappUser.state" value="1"/> 
<div id="main" style="height: 650px;">
<a name="top"></a>
<div class="zcxx_box">
        <table width="340" border="0" align="left" cellpadding="0" cellspacing="0" class="zc_style">
        <tr>
            <td height="32" class="text_title" style=" border-bottom:1px #CCC solid; line-height:50px;">注册</td>
        </tr>
        <tr>
            <td style="height:16px;"></td>
        </tr>
         <tr>
            <td height="30" class="text_mc"><table width="360" border="0" cellspacing="0" cellpadding="0" style="margin-top:6px;">
                <tr>
                    <td width="86"></td>
                    <td width="71"><input name="tappUser.isOrg" type="radio" value="0" checked="checked" /> 
                        个人</td>
                    <td width="172"><input type="radio" name="tappUser.isOrg"  value="1" />
                        公司及其他单位</td>
                    <td width="31">&nbsp;</td>
                </tr>
            </table></td>
        </tr>
        <tr>
            <td style="height:16px;"></td>
        </tr>
        <tr>
            <td height="30" class="text_mc">用户名</td>
        </tr>
        <tr>
            <td height="26"><div class="yhm_input">
                <input name="tappUser.username" type="text" class="in_01" id="tappUser.username" />
            </div></td>
        </tr>
        <tr>
            <td height="13" class="text_huise" style="height:2px;">用户名只能包含英文字母、数字、或者&quot;_&quot;(下划线)</td>
        </tr>
        <tr>
            <td valign="top" class="text_mc" style="height:20px;">密码</td>
        </tr>
        <tr>
            <td><div class="yhm_input">
                <input name="tappUser.userPsd" type="password" class="in_01" id="tappUser.userPsd" />
            </div></td>
        </tr>
        <tr>
            <td class="text_huise">6-16个字符，请使用字母加数字或符号的组合密码</td>
        </tr>
        <tr>
            <td class="text_mc">重复密码</td>
        </tr>
        <tr>
            <td><div class="yhm_input">
                <input name="userPsdbak" type="password" class="in_01" id="userPsdbak" />
            </div></td>
        </tr>
        <tr>
            <td class="text_mc">手机</td>
        </tr>
        <tr>
            <td><div class="yhm_input">
                <input name="mobile" type="text" class="in_01" id="mobile" />
            </div></td>
        </tr>
        <tr>
            <td style="height:4px;"></td>
        </tr>
        <tr>
            <td class="text_mc">Email</td>
        </tr>
        <tr>
            <td><div class="yhm_input">
                <input name="tappUser.email" type="text" class="in_01"  id="tappUser.email" />
            </div></td>
        </tr>
        <tr>
            <td class="text_mc" id="v_code">验证</td>
        </tr>
        <tr>
            <td><table width="370" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="255"><div class="yzm_input">
                <input type="text" name="verification_code" id="verification_code" class="in_02" />
            </div></td>
                    <td width="115" align="left" valign="middle" class="yzm_img "><img title="点击更换" onclick="javascript:refresh(this);" src="<%=request.getContextPath()%>/imageServlet"></td>
                </tr>
            </table></td>
        </tr>
        <tr>
            <td style="height:6px;"></td>
        </tr>

        <tr>
            <td height="66"><div style="margin:15px 0px 0px 92px;"> <a href="javascript:doSubmit();" class="zc_nav"><span>同意协议并注册</span></a></div></td>
        </tr>
        <tr>
            <td height="66" align="left"><div class="fwxy_cor">
                <a href="#"><<第1舞台服务协议>>
            
                </a></div></td>
        </tr>
        </table>
</div>
<div class="center_box"><img src="<%=request.getContextPath() %>/theme/images/zc_center.jpg" width="34" height="434" /></div>

<div class="tb_box">
<ul>
<li><a href="#"><img src="<%=request.getContextPath() %>/theme/images/zc_tb01.jpg" width="70" height="69" /></a></li>
<li><a href="#"><img src="<%=request.getContextPath() %>/theme/images/zc_tb02.jpg" width="70" height="68" /></a></li>
<li><a href="#"><img src="<%=request.getContextPath() %>/theme/images/zc_tb03.jpg" width="70" height="68" /></a></li>
</ul>
</div>
</div>
</form>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>
<script type="text/javascript">
var isSubmit = false;
    function doSubmit(){
    	if($("#userForm").valid()){
			if(!isSubmit){  
        	  isSubmit = true;   
			  $("#userForm").submit();
      	   } 
        }  
    }
    </script>
