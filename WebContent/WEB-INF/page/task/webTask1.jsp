<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.util.List"%>
<%@page import="com.smt.entity.TAppTask"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!-- page/task/webTask1.jsp -->
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
  		art.dialog.open('<%=request.getContextPath() %>/member/task!toAddUserTask.htm?type=1',{resize: false});
   }

	function toUpdateSchedule(id){
	  	art.dialog.open('<%=request.getContextPath() %>/member/task!toUpdateUserTask.htm?type=1&id='+id,{resize: false});
   }
 
	function tishi(content){
	   		alert(content);
   		window.location.href=window.document.location;
		}
  function submitSearchFrom() {
		document.getElementById("searchFrom").submit();
}
$(document).ready(function(){
	$("#active").attr("value",<s:property value="#request.active"/>);
	$("#status").attr("value",<s:property value="#request.status"/>);
});

function toView(id,flag){
		art.dialog.open('<%=request.getContextPath()%>/member/task!toView.htm?id='+id+'&flag='+flag,{width:550,height:400,resize: false});
	}
<s:if test="#request.roleId==1">
function toViewUser(userId){
	art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?userId='+userId,{width:750,height:750,resize: false});
}
</s:if>
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
        	<s:param name="menuFlag" value="111"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#" >首页</a> > <a href="#">任务发布</a></div>



<!-- 按月查询 开始 -->
<div style="height: 20px">&nbsp;</div>

       <!--<input type="hidden" name="active" id="active" value="${active}" />
     <input  type="hidden" id="status" name="status" value="${status }"/> --> 
     
<table width="99%">
	<tr>
		<td><form id="searchFrom" method="post" action="<%=request.getContextPath() %>/member/task!findZhua.htm">
			<table width="80%">
				<tr>
					<td>
						信息状态：<select name="status" id="status" style="width:200px;">
				                	<option value="0">所有</option>
				                	<option value="1">未审核</option>
				                	<option value="3">审核通过</option>
					            </select>
					</td>
					<td>
						发布状态：<select name="active" id="active" style="width:200px;">
				                	<option value="100">所有</option>
				                	<option value="-1">任务结束</option>
				                	<option value="0">屏蔽</option>
				                	<option value="1">发布中</option>
				                	<option value="2">置顶</option>
					            </select>
					</td>
					<td>
						<input type="button" value="查询" onclick="document.getElementById('searchFrom').submit();" />
					</td>
				</tr>
			</table>
			 </form>
			<!-- <div>信息状态： <input type="radio" name="radio1" id="status_0"  value="0" onclick="$('#status').val(0);document.getElementById('searchFrom').submit();"/>所有&nbsp;&nbsp;<input type="radio" name="radio1" id="status_1" value="1" onclick="$('#status').val(1);document.getElementById('searchFrom').submit();"/>未审核&nbsp;&nbsp;<input type="radio" name="radio1" id="status_3" value="3" onclick="$('#status').val(3);document.getElementById('searchFrom').submit();"/>审核通过&nbsp;&nbsp;</div> 
			<div>发布状态：<input type="radio" name="radio2" id="active_100"  value="100" onclick="$('#active').val(100);document.getElementById('searchFrom').submit();"/>所有&nbsp;&nbsp;<input type="radio" name="radio2"  id="active_-1" value="-1" onclick="$('#active').val(-1);document.getElementById('searchFrom').submit();"/>任务结束&nbsp;&nbsp;<input type="radio" name="radio2" id="active_0" value="0" onclick="$('#active').val(0);document.getElementById('searchFrom').submit();"/>屏蔽&nbsp;&nbsp;<input type="radio" name="radio2" id="active_1" value="1" onclick="$('#active').val(1);document.getElementById('searchFrom').submit();"/>发布中&nbsp;&nbsp;<input type="radio" name="radio2" id="active_2" value="2" onclick="$('#active').val(2);document.getElementById('searchFrom').submit();"/>置顶&nbsp;&nbsp;</div>-->
		</td>
	</tr>
	
	<tr>
		<td width="100%" style="color: #ff994c;font-size: 19px;font-weight: bolder;">任务发布人:<s:property value="#request.taskFromName" /></td>
		<td ><a href='javaScript:toAddSchedule();' title='添加任务'><img src='<%=request.getContextPath() %>/theme/images/add_nav.jpg' align='absmiddle'></a></td>
	</tr>
</table>
<table width="99%" class="ccc" >
	<tr style="font-size: 19px;font-weight: bolder;" >
		<td width="6%">编号</td>
		<s:if test="#request.roleId==1">
		<td width="10%">发布人</td>
		</s:if>
		<td width="18%">任务名称</td>
		<td  width="18%">任务地点</td>
 
		<td  width="12%">管理任务</td>
		<td  width="8%">状态</td>
		<td  width="20%">任务提交时间</td>
	</tr>
<s:iterator value="#request.userTaskList" var="item" status="st">
	<tr >
		<td><s:property value="#st.count" /></td>
		<s:if test="#request.roleId==1">
		<td>
		    <a href="javascript:toViewUser('<s:property value="#item[1].id"/>');" class="czjl_title_link">
		    <s:property value="#item[1].nickName" /></a>
		</td>
		</s:if>
		<td>
		<a href='javaScript:toUpdateSchedule(<s:property value="#item[0].id" />);' style="color: #0099ff;"><s:property value="#item[0].title" /></a>
			</td>
		<td title="<s:property value="#item[0].place" />">
			<s:if test="#item[0].place.length()>10">
				<s:property value="#item[0].place.substring(0,9)" />...
			</s:if>
			<s:else>
				<s:property value="#item[0].place" />
			</s:else>
			</td>
 
		<td>
			<s:if test="#item[0].status==2">【<a href='javaScript:toView(<s:property value="#item[0].id" />,2);' style="color: #0099ff;" >管理任务</a>】</s:if>
		<s:else>【<a href='javaScript:toUpdateSchedule(<s:property value="#item[0].id" />);' style="color: #0099ff;" >管理任务</a>】</s:else></td>
		<td>
			<s:if test="#item[0].status==1"><div style="color: #008800;">未审核</div>
			<s:if test="#item[0].active==-1">
					<div style="color: #ff0000;">(任务结束)</div>
				</s:if>
			</s:if>
			<s:elseif test="#item[0].status==2"><div style="color: #008800;">委托发布</div></s:elseif>
			<s:elseif test="#item[0].status==3"><div style="color: #008800;">审核通过</div>
				<s:if test="#item[0].active==-1">
					<div style="color: #ff0000;">(任务结束)</div>
				</s:if>
				<s:elseif test="#item[0].active==1"><div style="color: #008800;">(发布中)</div></s:elseif>
				<s:elseif test="#item[0].active==0"><div style="color: #ff0000;">(已被屏蔽)</div></s:elseif>
				<s:elseif test="#item[0].active==2"><div style="color: #008800;">(置顶)</div></s:elseif>
			</s:elseif>
		</td>
		<td><s:property value="#item[0].CreatTime" /></td>
	</tr>
</s:iterator>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="20"  url="task.htm" params=''  total='${total}' ></pg:pages></td>
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