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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript">
	$().ready(function(){	 
		alert("风险提示：请仔细确认你的支付宝账号和姓名。若您自己输入的账号和名称有误造成打款错误，第1舞台将爱莫能助。");   
	    $("#alipayForm").validate({
		    	rules: {			    		
		    		'alipayName':{
		    			required: true
		    		},    		
		    		'alipay':{
		    			required: true
		    			//,email: true
		    		},
		    		'confirm_alipay':{
		    			equalTo: "#alipay"
		    		}
		    	},
		    	messages: {

					'alipayName': {
						required: "&nbsp;<font color='red';>真实姓名能不为空!</font>"
					},
					'alipay': {
					    //email :   "&nbsp;<font color='red';>对应支付宝帐号格式错误!</font>",
						required: "&nbsp;<font color='red';>对应支付宝帐号不能为空!</font>"
					},
					'confirm_alipay': {
						equalTo: "&nbsp;<font color='red';>对应支付宝帐号不一致!</font>"
					}
				},
				errorPlacement: function(error, element) {  //验证消息放置的地方   
					element.parent().parent().children(".password_ts").html("");
		            error.appendTo(element.parent().parent().children(".password_ts")); 
		        },   
		        highlight: function(element, errorClass) {  //针对验证的表单设置高亮   
		            $(element).addClass(errorClass);   
		        },   
		        success: function(label) {     
		              label.addClass("valid").text(""); 
		        }    
		    });
	});
			
	function updateAlipay(){
		if($("#alipayForm").valid()){
			$.ajax({
			   url:"<%=request.getContextPath() %>/member/userinfo!updateAlipay.htm",
			   type:'POST',
			   data:$("#alipayForm").serialize(),
			   success:function(data){
				   if(data=="1"){
						art.dialog.tips("支付宝绑定成功");
						art.dialog.close(); 
				   }
			   }
			});
			
		}
	}
	function updateAlipay1(){
		if(!$("#alipayForm").valid()){
			return;
		}
		$("#input_1").css("display","none");
		$("#input_2").css("display","");
		$("#alipayName1").text($("#alipayName").val()); 
		$("#alipay1").text($("#alipay").val()); 
		$("#confirm_alipay1").text($("#confirm_alipay").val()); 
	}
	function updateAlipay2(){
		$("#input_1").css("display","");
		$("#input_2").css("display","none");
	}
	</script>
  </head>
  <body>
	<form id="alipayForm" action="">
		<table style="margin-top:13px;" width="450" border="0" align="center" cellpadding="0" cellspacing="0"  class="password_title">
            <tr>
                <td height="18" style="font-size:20px;">绑定支付宝</td>
            </tr>
        </table>
        <table width="520" border="0" align="center" cellpadding="0" cellspacing="0" class="password_con" id="input_1">
            <tr><td colspan=3><font color=red style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;请确认输入的支付宝帐号和真实姓名是对应的，否则会无法收到交易款项！</font></td></tr>
            <tr>
                <td align="right"  width="25%">真实姓名：</td>
                <td align="left" width="45%"><input type="text" name="alipayName" id="alipayName" value="${alipayName}" style="width:210px;" /></td>
                <td align="left" class="password_ts" width="30%"> </td>
            </tr> 
            <tr>
                <td align="right"  width="25%">对应支付宝帐号：</td>
                <td align="left" width="45%"><input type="text" name="alipay" id="alipay" onblur="$('#alipay').val($('#alipay').val().replace(/(^\s*)|(\s*$)/g,''));" value="${alipay}" style="width:210px;" /></td>
                <td align="left" class="password_ts" width="30%"> </td>
            </tr>
            <tr>
                <td align="right">确认支付宝帐号：</td>
                <td align="left"><input type="text" name="confirm_alipay" id="confirm_alipay" onblur="$('#confirm_alipay').val($('#confirm_alipay').val().replace(/(^\s*)|(\s*$)/g,''));" value="${alipay}" style="width:210px;" /></td>
                <td align="left" class="password_ts"> </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td align="center" class="save"><a href="javascript:updateAlipay1();"><img src="<%=request.getContextPath() %>/theme/images/tanchu_save.jpg" width="70" height="28" /></a></td>
                <td >&nbsp;</td>
            </tr>
            
        </table>
         <table width="520" border="0" align="center" cellpadding="0" cellspacing="0" class="password_con" id="input_2" style="display: none;">
            <tr><td colspan="3" > <span style="font-size:14px; font-weight:bold;color:#ff0000;">&nbsp;&nbsp;请重新确认输入的支付宝帐号和真实姓名是否正确。</span></td></tr>
            <tr>
                <td align="right"  width="25%">真实姓名：</td>
                <td align="left" width="45%"><div id="alipayName1"></div></td>
                <td align="left" class="password_ts" width="30%"> </td>
            </tr> 
            <tr>
                <td align="right"  width="25%">对应支付宝帐号：</td>
                <td align="left" width="45%"><div id="alipay1"></div></td>
                <td align="left" class="password_ts" width="30%"> </td>
            </tr>
            <tr>
                <td align="right">确认支付宝帐号：</td>
                <td align="left"><div id="confirm_alipay1"></div></td>
                <td align="left" class="password_ts"> </td>
            </tr>
            <tr>
               <td colspan="3">
               		<table width="80%">
               			<tr>
               				<td width="50%"  align="right"><a href="javascript:updateAlipay();"><img src="<%=request.getContextPath() %>/theme/images/tanchu_save.jpg" width="70" height="28" /></a> </td>
               				<td align="center" width="50%"><a href="javascript:updateAlipay2();"><img src="<%=request.getContextPath() %>/theme/images2/fkreturn.png" width="70" height="28" /></a></td>
               			</tr>
               		</table>
               </td>
            </tr>
            
        </table>
        <div style="background:url(<%=request.getContextPath() %>/theme/images2/alipay.jpg) no-repeat;height:219px; width:500px; padding:1px; border:#999 solid 1px; margin-left:8px;"></div>
        <div></div>
        </form>
  </body>
</html>