<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.util.List"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
  <!--    <title><%=StageVariale.title%></title>  -->
    <title>第1舞台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/default.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<style>
	.ccc td{border: 1px solid #797979; color: #333333;text-align: center;height:50px;}
	</style>
	<script type="text/javascript"> 

   function toAddSchedule(){
  		art.dialog.open('<%=request.getContextPath() %>/member/task!toAddUserTask.htm',{resize: false});
   }

	function toUpdateSchedule(id){
	  	art.dialog.open('<%=request.getContextPath() %>/member/task!toUpdateUserTask.htm?id='+id,{resize: false});
   }
 
	function tishi(content){
	   		alert(content);
   		window.location.href=window.document.location;
		}
  function submitSearchFrom() {
		document.getElementById("searchFrom").submit();
}
$(document).ready(function(){

	$("#active_<s:property value="#request.active"/>").attr("checked","checked");
	$("#status_<s:property value="#request.status"/>").attr("checked","checked");
});
</script>
  </head>
  <body >
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="146" valign="top" class="left_menubj">
       <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="7"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#" >首页</a> > <a href="<%=request.getContextPath() %>/member/task.htm">任务发布</a> > <a>应征者信息</a></div>



<!-- 按月查询 开始 -->
<div style="height: 20px">&nbsp;</div>
<form id="searchFrom" method="post" action="<%=request.getContextPath() %>/member/task.htm">

      </form>
<table width="99%" >
	<tr style="display: none;">
		<td>
			<div>标记： <input type="radio" name="radio1" id="status_0"  value="0" onclick="$('#status').val(0);document.getElementById('searchFrom').submit();"/>所有&nbsp;&nbsp;<input type="radio" name="radio1" id="status_1" value="1" onclick="$('#status').val(1);document.getElementById('searchFrom').submit();"/>未审核&nbsp;&nbsp;<input type="radio" name="radio1" id="status_3" value="3" onclick="$('#status').val(3);document.getElementById('searchFrom').submit();"/>审核通过&nbsp;&nbsp;</div>
			<div>性别：<input type="radio" name="radio2" id="active_100"  value="100" onclick="$('#active').val(100);document.getElementById('searchFrom').submit();"/>所有&nbsp;&nbsp;<input type="radio" name="radio2"  id="active_-1" value="-1" onclick="$('#active').val(-1);document.getElementById('searchFrom').submit();"/>任务结束&nbsp;&nbsp;<input type="radio" name="radio2" id="active_0" value="0" onclick="$('#active').val(0);document.getElementById('searchFrom').submit();"/>屏蔽&nbsp;&nbsp;<input type="radio" name="radio2" id="active_1" value="1" onclick="$('#active').val(1);document.getElementById('searchFrom').submit();"/>发布中&nbsp;&nbsp;<input type="radio" name="radio2" id="active_2" value="2" onclick="$('#active').val(2);document.getElementById('searchFrom').submit();"/>置顶&nbsp;&nbsp;</div>
		</td>
	</tr>
	<tr>
		<td width="82%" style="color: #ff994c;font-size: 19px;font-weight: bolder;">任务名称:&nbsp;&nbsp;<s:property value="#request.taskTitle" /></td>
		<td style="font-size: 15px;font-weight: bolder;">当前应征者：<s:property value="#request.personCount" />人</td>
	</tr>
</table>
<table width="99%" class="ccc" >
	<tr style="font-size: 19px;font-weight: bolder;" >
		<td width="8%">编号</td>
		<td width="13%">应征者名称</td>
		<td  width="8%">性别</td>
		<td  width="8%">年龄</td>
		<td  width="13%">资料完整度</td>
		<td  width="13%">个人页展示</td>
		<td  width="8%">标记</td>
		<td  width="10%">应征人员</td>
		<td  width="16%">应征提交时间</td>
	</tr>
<s:iterator value="#request.taskList" var="item" status="st">
	<tr >
		<td><s:property value="#st.count" /></td>
		<td>
		<a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[1].userId" />" style="color: #0099ff;" target="_blank"><s:property value="#item[1].nickName" /></a>
			</td>
		<td>
			<s:if test="#item[1].sex==2">女</s:if>
			<s:elseif test="#item[1].sex==1">男</s:elseif>
			<s:else>未填写</s:else>
		</td>
		<td><s:property value="#item[1].age" /></td>
		<td><a id="wzd"></a>%
			<s:if test="#item[1].jcxxIsFinish==1">
				<input type="hidden" id="jcxx" value="30" />
			</s:if>
			<s:else>
				<input type="hidden" id="jcxx" value="0" />
			</s:else>
			<s:if test="#item[1].zyjnIsFinish==1">
				<input type="hidden" id="zyjn" value="20" />
			</s:if>
			<s:else>
				<input type="hidden" id="zyjn" value="0" />
			</s:else>
			<s:if test="#item[1].czjlIsFinish==1">
				<input type="hidden" id="czjl" value="10" />
			</s:if>
			<s:else>
				<input type="hidden" id="czjl" value="0" />
			</s:else>
			<s:if test="#item[1].xcIsFinish==1">
				<input type="hidden" id="xc" value="10" />
			</s:if>
			<s:else>
				<input type="hidden" id="xc" value="0" />
			</s:else>
			<s:if test="#item[1].spIsFinish==1">
				<input type="hidden" id="sp" value="10" />
			</s:if>
			<s:else>
				<input type="hidden" id="sp" value="0" />
			</s:else>
			<s:if test="#item[1].ypIsFinish==1">
				<input type="hidden" id="yp" value="10" />
			</s:if>
			<s:else>
				<input type="hidden" id="yp" value="0" />
			</s:else>
			<s:if test="#item[1].sytjIsFinish==1">
				<input type="hidden" id="sytj" value="10" />
			</s:if>
			<s:else>
				<input type="hidden" id="sytj" value="0" />
			</s:else>
		<script>	
			var wzd = parseInt($("#jcxx").val())+parseInt($("#zyjn").val())+parseInt($("#czjl").val())+parseInt($("#xc").val())+parseInt($("#sp").val())+parseInt($("#yp").val())+parseInt($("#sytj").val());
			$("#wzd").text(wzd);
		</script>
		</td>
		<td>【<a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[1].userId" />" style="color: #0099ff;" target="_blank">进入</a>】</td>
		<td>
			<s:if test="#item[0].isReady==1"><div style="color: #008800;">已阅</div></s:if>
			<s:elseif test="#item[0].isReady==0"><div style="color: #ff0000;">未读</div></s:elseif>
		</td>
		<td><s:if test="#item[0].taskRoleId!=null">
				<s:if test="#item[0].taskRoleId>0">				
<s:iterator value="#request.userTaskRole" var="taskRole" status="st1">
<s:if test="#item[0].taskRoleId==#taskRole.id">
<s:property value="#taskRole.roleName" />
</s:if>
</s:iterator>
				</s:if>
			</s:if>
			<s:else></s:else></td>
		<td><s:property value="#item[0].CreateTime" /></td>
	</tr>
</s:iterator>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="20"  url="task/toPersonTask.htm" params=''  total='${total}' ></pg:pages></td>
    </tr>
</table>
<!-- <div id="date_month" ></div> -->
</td>
</tr>
</table>

<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>