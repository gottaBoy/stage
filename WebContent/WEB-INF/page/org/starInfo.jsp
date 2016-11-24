<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/jquery.autocomplete.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/menuService.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.js"></script>
	<script type="text/javascript">
	var userId = 0;
	$(document).ready(function(){
	var afterMethod = function (record){
		document.getElementById("Name").innerHTML = record.name;
		document.getElementById("NickName").innerHTML = record.label;
		document.getElementById("popularityTotal").innerHTML = record.popularityTotal;
		document.getElementById("profession").innerHTML = record.profession;
		//document.getElementById("no1StarImage").src = "/stageUpload/starInfoImage/"+record.id+"_1.png";
		userId = record.id;
		document.getElementById("starContent").value = "";
		document.getElementById("no1StarImage1").src = "/stageUpload/starInfoImage/"+record.id+"_1.png";
		document.getElementById("no1StarImage2").src = "/stageUpload/starInfoImage/"+record.id+"_2.png";
		document.getElementById("no1StarImage3").src = "/stageUpload/starInfoImage/"+record.id+"_3.png";
		document.getElementById("contentOfPictrue2").value = "";
		document.getElementById("contentOfPictrue3").value = "";
		document.getElementById("linkOfPictrue2").value = "";
		document.getElementById("linkOfPictrue3").value = "";
		document.getElementById("yrUserId").value = userId;
		

	}
	dyncSearchToolkit.initial("","250px");//下拉框提示初始化
	bindQueryToolkit(document.getElementById("username"),
			{url:'<%=request.getContextPath()%>/member/top!doqyStarIndex.htm',
		afterCall:afterMethod,labelField:"username",hiddenValueObj:document.getElementById("info.userId")});	
	});

function loadImageWindow(index){
	//document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block';handleImgLoadError(event);
	art.dialog.open('<%=request.getContextPath() %>/member/evaluate!image1.htm?id='+userId+'&index='+index,{width:600,height:500,resize: false});
}
</script>		

<style>
.b{
	padding-left:18px; }
.b1{
	padding-left:18px;
   color:#999999 }

</style>
</head>
  <body>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="28"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a href="#">首页</a> > <a href="#">企业之星</a></div>
<script type="text/javascript">
var flag = 0;
function doSubmit(){  
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/starInfo!saveInfo.htm",
		   type:'POST',
		   data:$("#infoForm").serialize(),
		   success:function(data){
			   if(data=="1"){
			   		alert("保存成功");
			   		window.location.reload();
					//window.location.href='/stage01/member/starInfo.htm'	;
			   }
		   }
		});

}
function CloseWin() 
{ 
	//window.location.href="<%=request.getContextPath()%>/member/top.htm";
} 


</script>
<span class="clear"></span>
<div style="padding-top:15px; ">

<input  type="hidden" id="city" name="city" style="display: none;" value="${loc2 }"/>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td height="20" width="50%"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/> 本周之星首图</td>
		<td width="50%"></td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" style="color: #ffffff;background-color: #64c8b9;height: 30px;" onclick="loadImageWindow(1);" value="添加/修改图片" /> </td>
		<td width="50%">
			<form id="searchForm" name="searchForm" action="member/top!doqyStarIndex.htm" method="post" >
				<input class="input_xl" type="text" value="${vo.userid.name}" name="username" id="username" style="width:150px; height:25px ;">&nbsp;(请输入艺人名称)
			</form>
			</td><td>
			<form id="infoForm" name="infoForm" action="member/starInfo!saveInfo.htm" method="post" >
	        <input type="hidden" id="yrUserId" name="companyInfo.yrUserId" value=""/>
        </td>
	</tr>
	<tr>
	   <td>
			<div style="padding-top: 10px;padding-left: 15px;" id="no1StarDiv1"><img id="no1StarImage1" src="<%=request.getContextPath() %>/theme/images/no_img.jpg" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'"/>	</div>   
	   </td>
	   <td valign="bottom">
	   		<s:iterator value="#request.qyzxInfo" var="qyzxInfo">
	   		<script>
	   			 userId = <s:property value="#qyzxInfo.userId"/>;
	   			$("#no1StarImage1").attr("src","/stageUpload/starInfoImage/<s:property value="#qyzxInfo.id"/>_<s:property value="#qyzxInfo.userId"/>_1.png");
	   			//$("#no1StarImage2").attr("src","/stageUpload/starInfoImage/"+<s:property value="#qyzxInfo.userId"/>+"_2.png");
	   			//$("#no1StarImage3").attr("src","/stageUpload/starInfoImage/"+<s:property value="#qyzxInfo.userId"/>+"_3.png");
	   			document.getElementById("yrUserId").value = userId;
	   		</script>
	   		</s:iterator>
	   	   <div style="padding-left: 20px;height: 100px;">
	   	   	<table>
	   	   		<tr>
	   	   			<td >
	   	   				<span id="NickName"><s:iterator value="#request.qyzxInfo" var="qyzxInfo"><s:property value="#qyzxInfo.nickName"/></s:iterator></span>
	   	   			</td>
	   	   		</tr>
	   	   		<tr>
	   	   			<td >
	   	   				<span id="Name"><s:iterator value="#request.qyzxInfo" var="qyzxInfo"><s:property value="#qyzxInfo.name"/></s:iterator></span>
	   	   			</td>
	   	   		</tr>
	   	   		<tr>
	   	   			<td >
	   	   				职业：
	   	   			</td>
	   	   			<td><span id="profession"><s:iterator value="#request.qyzxInfo" var="qyzxInfo"><s:property value="#qyzxInfo.profession"/></s:iterator></span></td>
	   	   		</tr>
	   	   		<tr>
	   	   			<td>
	   	   				人气：
	   	   			</td>
	   	   			<td><span id="popularityTotal"><s:iterator value="#request.qyzxInfo" var="qyzxInfo"><s:property value="#qyzxInfo.popularityTotal"/></s:iterator></span></td>
	   	   		</tr>
	   	   	</table>
	   	   </div>
		   <div>
		   	<table>
		   		<tr>
		   			<td height="20"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/> 推荐理由</td>
		   		</tr>
		   		<tr>
		   			<td>
		   				<textarea name="companyInfo.starContent" id="starContent" style="width:300px; height:100px; "><s:iterator value="#request.qyzxInfo" var="qyzxInfo"><s:property value="#qyzxInfo.content"/></s:iterator></textarea>
		   				
		   			</td>
		   		</tr>
		   	</table>
		   </div>
		   
	   </td>
	</tr>
	
	<tr>
		<td height="20" style="padding-top: 30px;"><img  src="<%=request.getContextPath() %>/theme/images2/circle.png"/>第一图片</td>
  		<td style="padding-top: 30px;"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>第二图片</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;<input type="button" style="color: #ffffff;background-color: #64c8b9;height: 30px;" onclick="loadImageWindow(2);" value="添加/修改图片" /> </td>
		<td>&nbsp;&nbsp;&nbsp;<input type="button" style="color: #ffffff;background-color: #64c8b9;height: 30px;" onclick="loadImageWindow(3);" value="添加/修改图片" /> </td>
	</tr>
	<tr>
		<td>
			<div style="padding-top: 10px;padding-left: 10px;"><img id="no1StarImage2" src="<%=request.getContextPath() %>/theme/images/no_img.jpg" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'"/>	</div>  
		</td>
		<td>
			<div style="padding-top: 10px;padding-left: 10px;"><img id="no1StarImage3" src="<%=request.getContextPath() %>/theme/images/no_img.jpg" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'"/>	</div>  
		</td>
	</tr>
	<s:iterator value="#request.qyzxInfo" var="qyzxInfo">
	<script>
		//userId = <s:property value="#qyzxInfo.userId"/>;
		$("#no1StarImage2").attr("src","/stageUpload/starInfoImage/<s:property value="#qyzxInfo.id"/>_<s:property value="#qyzxInfo.userId"/>_2.png");
		$("#no1StarImage3").attr("src","/stageUpload/starInfoImage/<s:property value="#qyzxInfo.id"/>_<s:property value="#qyzxInfo.userId"/>_3.png");
		
	</script>
	</s:iterator>
	<tr>
    <td height="39">&nbsp;&nbsp;&nbsp;图片描述 

      <input class="input_xl" type="text" name="companyInfo.contentOfPictrue2" id="contentOfPictrue2" style="width:150px; height:25px ;" />  
      </td>
    
    <td>&nbsp;&nbsp;&nbsp;图片描述 
      <input class="input_xl" type="text" name="companyInfo.contentOfPictrue3" id="contentOfPictrue3" style="width:150px; height:25px ;"/> 
</td>
  </tr>
  <tr>
    <td height="35">&nbsp;&nbsp;&nbsp;链接：
      <input class="input_xl" type="text" name="companyInfo.linkOfPictrue2" id="linkOfPictrue2" style="width:150px; height:25px ;"/></td>
    <td>&nbsp;&nbsp;&nbsp;链接：
      <input class="input_xl" type="text" name="companyInfo.linkOfPictrue3" id="linkOfPictrue3" style="width:150px; height:25px ;"/></td>
  </tr>
<s:iterator value="#request.qyzxInfo" var="qyzxInfo">
<tr>
<td>
<input type="text" style="display: none" id="conPic2" value="<s:property value="#qyzxInfo.contentPic2"/>"/>
<input type="text" style="display: none" id="conPic3" value="<s:property value="#qyzxInfo.contentPic3"/>"/>
</td>
</tr>
<script>
	$("#contentOfPictrue2").attr("value",$("#conPic2").val());
	$("#contentOfPictrue3").attr("value",$("#conPic3").val());
	$("#linkOfPictrue2").attr("value","<s:property value="#qyzxInfo.linkPic2"/>");
	$("#linkOfPictrue3").attr("value","<s:property value="#qyzxInfo.linkPic3"/>");
</script>
</s:iterator>
  <tr>
    <td><div style="float:left; margin-right:20px; padding-top:20px; "><a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg"/></a></div><div><a href="javascript:CloseWin();"></a></div></td>
  </tr>
</form>
</div>
</td>
    </tr>
</table>

</td>
</tr>
</table>


</td>
</tr> 
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

  </body>
</html>