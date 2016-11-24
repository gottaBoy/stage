<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	UserSession userSession = HttpSessionHelper.getUserSession(request);
	int isForOrg = HttpSessionHelper.getOrgData(request); //0:no  1:yes
	int isIndividual = HttpSessionHelper.getIsOrg(request);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!--- org/updateAlipay1.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/WdatePicker.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link href="<%=request.getContextPath() %>/theme/css/style.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/theme/css/hg.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">  

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/43!register.css" />

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
	<style type="text/css" media="screen">
		html, body { height:auto !important;background-color: #f5f5f5;}
 
	</style>
	
<script type="text/javascript">
		function modify(){
				$("#input_1").show();
				$("#input_2").hide();
		}

		$(document).ready(function(){	 
			<c:choose>
				<c:when test="${userInfo.alipay!=null}">
					$("#input_1").hide();
					$("#input_2").show();
				</c:when>
				<c:otherwise>
					art.dialog.alert("风险提示：请仔细确认你的支付宝账号和姓名。若您自己输入的账号和名称有误造成打款错误，第1舞台将爱莫能助。");   
					$("#input_1").show();
					$("#input_2").hide();
				</c:otherwise>
			</c:choose>

			
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
					element.parent().children(".ti_shi").html("");
		            error.appendTo(element.parent().children(".ti_shi")); 
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
						updateAlipay1();
				   }
			   }
			});
			
		}
	}
	function updateAlipay1(){
		/*if(!$("#alipayForm").valid()){
			return;
		}*/
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
  <body  style="background: #ffffff;">
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>

<div style="height:auto !important; width:100%; margin:0;overflow:hidden;" id="main_content">

 <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tbody><tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="1"></s:param>
        </s:action>

       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">


<!-- 导航 结束 -->

<div class="right_tab">
<ul>
<li><a href="<%=request.getContextPath() %>/member/userinfo.htm?<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>

<c:if test="${user.isOrg==0}"> 
	<li><a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=8&<%=HttpSessionHelper.getParamData(request)%>">相册</a></li>
	<li><a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=9&<%=HttpSessionHelper.getParamData(request)%>">视频</a></li>
</c:if>

<!-- <li><a class="change" href="<%=request.getContextPath() %>/member/orginfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li> -->
</ul>
</div>
<!-- 基础信息 开始 -->
<div id="TabTab03Con">
 <form id="alipayForm" action="">
<div id="input_1">
<div class="zhifu">
支付宝可以帮助您实现安全、快捷的网络支付，在线交易有保障！<br />
*请确认输入的支付宝帐号和真实姓名是对应的，否则会无法收到交易款项！
</div>
<div class="content_left">
<ul>
<li>
    <div class="name2"> 真实姓名：</div>
    <input type="text" name="alipayName" id="alipayName" value="${userInfo.alipayName}" style="width:210px;" />
	<div class="ti_shi"></div>
</li>
<li>
    <div class="name2"> 对应支付宝帐号：</div>
    <input type="text" name="alipay" id="alipay" onblur="$('#alipay').val($('#alipay').val().replace(/(^\s*)|(\s*$)/g,''));" value="${userInfo.alipay}" style="width:210px;" />
	<div class="ti_shi"></div>
</li>
<li>
    <div class="name2"> 确认支付宝帐号：</div>
    <input type="text" name="confirm_alipay" id="confirm_alipay" onblur="$('#confirm_alipay').val($('#confirm_alipay').val().replace(/(^\s*)|(\s*$)/g,''));" value="${userInfo.alipay}" style="width:210px;" />
	<div class="ti_shi"></div>
</li>
<li>
    <a href="javascript:updateAlipay()" class="querenbaocun2">确认保存</a>
</li>
</ul>
</div>
</div>
 
     <div id="input_2" style="display: none;">
        <div class="zhifu">
			支付宝可以帮助您实现安全、快捷的网络支付，在线交易有保障！<br />
*请确认输入的支付宝帐号和真实姓名是对应的，否则会无法收到交易款项！
			</div>
			<div class="content_left">
			<ul>
			<li>
			    <div class="name2"> 真实姓名：</div>
			    <div class="name2" id="alipayName1" >${userInfo.alipayName}</div>
			</li>
			<li>
			    <div class="name2"> 对应支付宝帐号：</div>
			    <div id="alipay1" class="name2" >${userInfo.alipay}</div>
			</li>
			<li>
			    <div class="name2"> 确认支付宝帐号：</div>
			    <div id="confirm_alipay1" class="name2" >${userInfo.alipay}</div>
			</li>
			<li>
				 <a href="javascript:modify()"class="querenbaocun2">修改</a>
			</li>
			</ul>
			</div>
			</div>   
   
        </form>                 
</div>


</td>
</tr>
</table>

<!-- 主内容结束 -->













<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>
<!-- 底部结束 --> 




  </body>
</html>