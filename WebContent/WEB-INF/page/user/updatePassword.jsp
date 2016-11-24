<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<style type="text/css" media="screen">
		.name{width:110px; float:left; text-align:right; font:normal 14px/32px '宋体';}
	</style>
	<script type="text/javascript">
		$().ready(function(){
	   //通过得到客户登录IP得到所在的地址 
	    
	    $("#mmxgForm").validate({
		    	rules: {
		    		'old_pass':{
		    			required: true,
		    			remote:'<%=request.getContextPath()%>/user/userAction!checkPassWord.htm?userId=<%=request.getParameter("userId")%>'
						
		    		},
		    		'new_pass':{
		    			required: true,
		    			rangelength: [6, 25]
		    		},
		    		'new_confirm_pass':{
		    			equalTo: "#new_pass"
		    		}
		    	},
		    	messages: {
					'old_pass': {
						required: "&nbsp;<font color='red';>旧密码不能为空!</font>",
						remote:"&nbsp;<font color='red';>密码不正错!</font>"
					},
					'new_pass': {
						required: "&nbsp;<font color='red';>新密码不能为空!</font>",
						rangelength: "&nbsp;<font color='red';>长度为6-25位!</font>"
					},
					'new_confirm_pass': {
						equalTo: "&nbsp;<font color='red';>两次密码不一致!</font>"
						//rangelength: "&nbsp;<font color='red';>用户名长度为6-25位!</font>"
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
	
		
		function updatePassWord(){
				if($("#mmxgForm").valid()){
					$.post('<%=request.getContextPath()%>/user/userAction!updatePwd.htm?new_pass='+$("#new_pass").val()+'&userId=<%=request.getParameter("userId")%>',
						function(data){
							if(data == 1){
							window.parent.tishi("密码修改 成功");
							art.dialog.close(); 
						}
					},"html");
				}
		}
	</script>
  </head>
  <body> 
	<form id="mmxgForm" action="">
<div style="width:500px; height:34px; float:left; margin-top:5px; border-bottom:2px #BD0000 solid; margin-top:10px; margin-left:10px;margin-bottom:10px;">
<div style="line-height:34px; text-align:center; background-color:#BD0000; width:90px;font-family:'宋体'; font-size:14px; color:#fff; font-weight:bold;">修改密码</div>
</div>

        <table width="505" border="0" align="center" cellpadding="0" cellspacing="0" class="password_con">
            <tr>
                <td width="130" align="right" class="name"><span style="color:#ff0000;">*</span>请输入旧密码：</td>
                <td width="370" align="left"><input type="password" name="old_pass" id="old_pass" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" /><div class="password_ts"></td>
            </tr>
            <tr>
                <td align="right" class="name"><span style="color:#ff0000;">*</span>请输入新密码:</td>
                <td align="left"><input type="password" name="new_pass" id="new_pass"style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';"/><div class="password_ts"></td>
            </tr>
            <tr>
                <td align="right" class="name"><span style="color:#ff0000;">*</span>确认新密码：</td>
                <td align="left"><input type="password" name="new_confirm_pass" id="new_confirm_pass" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" /><div class="password_ts"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td  >
                <a style=" display:block; width:115px; height:40px; background:url(<%=request.getContextPath()%>/theme/images/zhezhao/tu06.jpg) no-repeat; text-align:center; font:normal 14px/40px '微软雅黑'; color:#FFF;  margin-top:20px; " href="javascript:updatePassWord();;">确认保存</a>
                </td>
            </tr>
        </table>
        <div></div>
        </form> 
       
    <!--
     <div class="jg"></div>
  <div class="mima">
     <h3>修改密码</h3>
     <ul>
        <li>
           <div class="name"><span>*</span>请输入旧密码:</div>
           <input />
        </li>
        <li>
           <div class="name"><span>*</span>请输入新密码:</div>
           <input />
        </li>
        <li>
           <div class="name"><span>*</span>再次输入密码:</div>
           <input />
        </li>
        <li>
           <a href="#">确认保存</a>
        </li>
     </ul>
  </div>
  -->
  
  </body>
</html>