<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!-- user/updateEmail.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<style type="text/css" media="screen">
		.name{width:110px; float:left; text-align:right; font:normal 14px/32px '宋体';}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			<c:if test='${flag=="2"}'>
		    	$("#mobile").show();
		    	$("#email").hide();
		    </c:if>

		    <c:if test='${flag=="1"}'>
		    	$("#mobile").hide();
		    	$("#email").show();
		    </c:if>


	   //通过得到客户登录IP得到所在的地址 
	    $("#emailForm").validate({
		    	rules: {
		    		'old_email':{
		    			required: true,
		    			email:true,
		    			remote:'<%=request.getContextPath()%>/user/userAction!checkEmail.htm?userId=<%=request.getParameter("userId")%>'
		    		},
		    		'new_email':{
		    			required: true,
						rangelength: [1, 32],
		    			email:true,
						remote:{url:'<%=request.getContextPath()%>/register/checkEmail.html?date='+new Date(),type:"post"}
		    		},
		    		'new_confirm_email':{
		    			equalTo: "#new_email"
		    		},
					'new_mobile':{
						required: true,
						rangelength: [11, 11]
					}
		    	},
		    	messages: {
					'old_email': {
						required: "&nbsp;<font color='red';>旧邮箱不为空!</font>",
						email :   "&nbsp;<font color='red';>邮箱格式错误!</font>",
						remote:"&nbsp;<font color='red';>邮箱不正错!</font>"
					},
					'new_email': {
						required: "&nbsp;<font color='red';>新邮箱不为空!</font>",
						rangelength:"&nbsp;<span style='color:red'>E-mail长度为1-32位!</span>",
						email :   "&nbsp;<font color='red';>邮箱格式错误!</font>",
						remote: "&nbsp;<span style='color:red'>E-mail地址已存在!</span>"
					},
					'new_confirm_email': {
						equalTo: "&nbsp;<font color='red';>邮箱不一致!</font>"
					},
					'new_mobile':{
						required: "&nbsp;<span style='color:red'>手机号码不能为空!</span>",
						rangelength:"&nbsp;<span style='color:red'>号码长度为11位!</span>"
					}
				},
				errorPlacement: function(error, element) {  //验证消息放置的地方   
					element.parent().children(".password_ts").html("");
		            error.appendTo(element.parent().children(".password_ts")); 
		        },   
		        highlight: function(element, errorClass) {  //针对验证的表单设置高亮   
		            $(element).addClass(errorClass);   
		        },   
		        success: function(label) {     
		              label.addClass("valid").text(""); 
		        }    
		    });

		});
		
		function updatePassEmail(flag){
				if($("#emailForm").valid()){
					if(flag==1){
						$.post('<%=request.getContextPath()%>/user/userAction!updateEmail.htm?new_email='+$("#new_email").val()+"&userId=<%=request.getParameter("userId")%>",
							function(data){
								if(data == 1){
									window.parent.tishi("邮箱修改成功");
									parent.location.href=parent.document.location;
									art.dialog.close(); 
								}
							},
						"html");
					}else{
						$.post('<%=request.getContextPath()%>/user/userAction!updateMobile.htm?new_mobile='+$("#new_mobile").val()+"&userId=<%=request.getParameter("userId")%>",
							function(data){
								if(data == 1){
									window.parent.tishi("手机号码修改成功");
									parent.location.href=parent.document.location;
									art.dialog.close(); 
								}
							},
						"html");
					}
				}
		}
	</script>
  </head>
  <body>
	<form id="emailForm" action="">
		<div id="email">
<div style="width:500px; height:34px; float:left; margin-top:5px; border-bottom:2px #BD0000 solid; margin-top:10px; margin-left:10px;margin-bottom:10px;">
<div style="line-height:34px; text-align:center; background-color:#BD0000; width:90px;font-family:'宋体'; font-size:14px; color:#fff; font-weight:bold;">修改邮箱</div>
</div>
	        <table width="505" border="0" align="center" cellpadding="0" cellspacing="0" class="password_con">
	            <tr>
	                <td width="130" align="right" class="name">已绑定邮箱：</td>
	                <td width="370" align="left"><input type="text" name="old_email" id="old_email" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" value="${Email }" /><div class="password_ts"></td>
	                
	            </tr>
	            <tr>
	                <td align="right" class="name">新邮箱：</td>
	                <td align="left"><input type="text" name="new_email" id="new_email" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" /><div class="password_ts"></td>
	            </tr>
	            <tr>
	                <td align="right" class="name">确认新邮箱：</td>
	                <td align="left"><input type="text" name="new_confirm_email" id="new_confirm_email" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" /><div class="password_ts"></td>
	            </tr>
	            <tr>
	                <td>&nbsp;</td>
	                <td ><a style=" display:block; width:115px; height:40px; background:url(<%=request.getContextPath()%>/theme/images/zhezhao/tu06.jpg) no-repeat; text-align:center; font:normal 14px/40px '微软雅黑'; color:#FFF;  margin-top:20px; " href="javascript:updatePassEmail(1);">确认保存</a></td>
	            </tr>
	            
	        </table>
        </div>
        <div id="mobile" style="display: none;">
<div style="width:500px; height:34px; float:left; margin-top:5px; border-bottom:2px #BD0000 solid; margin-top:10px; margin-left:10px;margin-bottom:10px;">
<div style="line-height:34px; text-align:center; background-color:#BD0000; width:90px;font-family:'宋体'; font-size:14px; color:#fff; font-weight:bold;">修改手机号</div>
</div>
	        <table width="505" border="0" align="center" cellpadding="0" cellspacing="0" class="password_con">
	            <tr>
	                <td width="130" align="right" class="name">已绑定手机：</td>
	                <td width="370" align="left"><input type="text" name="old_mobile" id="old_mobile" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" value="${Mobile}" /><div class="password_ts"></td>
	                
	            </tr>
	            <tr>
	                <td align="right" class="name">新手机号码：</td>
	                <td align="left"><input type="text" name="new_mobile" id="new_mobile" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" /><div class="password_ts"></td>
	            </tr>
	            <tr>
	                <td>&nbsp;</td>
	                <td ><a style=" display:block; width:115px; height:40px; background:url(<%=request.getContextPath()%>/theme/images/zhezhao/tu06.jpg) no-repeat; text-align:center; font:normal 14px/40px '微软雅黑'; color:#FFF;  margin-top:20px; " href="javascript:updatePassEmail(2);">确认保存</a></td>
	            </tr>
	            
	        </table>
        </div>
        </form>
  </body>
</html>