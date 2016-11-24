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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>


<style> 

</style>
	<script type="text/javascript">
	
function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
  	    }
  	    
  	    function addPersonTask(taskId,userId){
				$.ajax({
				   url:"<%=request.getContextPath() %>/member/task!addPersonTask.htm?userId="+userId+"&taskId="+taskId,
				   type:'POST',
				   success:function(data){
					   if(data=="1"){
							window.location.href=window.location.href;
					   }
				   }
				});
			
		}
$(document).ready(function(){

});		
	</script>
  </head>
  <body>
	<table width="100%">
		<tr>
			<td width="82%" style="color: #ff994c;font-size: 19px;font-weight: bolder;">旗下艺人:</td>
		</tr>
		<tr>
			<td style="padding-top: 5px;" align="left"><div style='background-image:url(<%=request.getContextPath() %>/theme/images2/dot2.gif); background-repeat:repeat; height:1px; width:96%;'></div></td>
		</tr>
		<tr>
			<td>
				<table >
					<s:iterator value="#request.userList" var="item" status="st">
						<s:if test="#st.count%5==1">
							<tr style="padding-top: 15px;">
								<td style="padding-top: 10px;" >
									<table width="100%">
										<tr>
											<td>
												<div style="border:1px solid #e3e3e3; padding:1px;width: 77px;margin-left: 10px;">
							  						<div >
					     								<img  onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#item.id"/>.png" height="70"  title="<s:property value="#item.Introduction"/>" />
					     							</div>
					     							<s:if test="#item.yingzheng==1">
					     								<div style="background-color: #c8c8ff;" >
						     								<table>
						     									<tr>
						     										<td style="color: #ffffff;font-size: 14px;font-weight: bold;width: 70px;height: 20px;" align="center">已应征</td>
						     									</tr>
						     								</table>
						     							</div>
					     							</s:if>
					     							<s:else>
					     								<div style="background-color: #ff8b18;cursor: pointer;" >
						     								<table>
						     									<tr>
						     										<td onclick="addPersonTask(${taskId},<s:property value="#item.id" />)" style="color: #ffffff;font-size: 14px;font-weight: bold;width: 70px;height: 20px;" align="center">应征</td>
						     									</tr>
						     								</table>
						     							</div>
					     							</s:else>
   													
					     						</div>
											</td>
										</tr>
										<tr>
											<td align="center">
												<div style="margin-left: 10px;"><s:property value="#item.nickName" /></div>
											</td>
										</tr>
									</table>
								</td>
						</s:if>
						<s:elseif test="#st.count%5==0">
							<td style="padding-top: 10px;">
								<table width="100%">
										<tr>
											<td>
												<div style="border:1px solid #e3e3e3; padding:1px;width: 77px;margin-left: 10px;">
							  						<div >
					     								<img  onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#item.id"/>.png" height="70"  title="<s:property value="#item.Introduction"/>" />
					     							</div>
					     							<s:if test="#item.yingzheng==1">
					     								<div style="background-color: #c8c8ff;">
						     								<table>
						     									<tr>
						     										<td style="color: #ffffff;font-size: 14px;font-weight: bold;width: 70px;height: 20px;" align="center">已应征</td>
						     									</tr>
						     								</table>
						     							</div>
					     							</s:if>
					     							<s:else>
					     								<div style="background-color: #ff8b18;cursor: pointer;">
						     								<table>
						     									<tr>
						     										<td onclick="addPersonTask(${taskId},<s:property value="#item.id" />)" style="color: #ffffff;font-size: 14px;font-weight: bold;width: 70px;height: 20px;" align="center">应征</td>
						     									</tr>
						     								</table>
						     							</div>
					     							</s:else>
					     							
					     						</div>
											</td>
										</tr>
										<tr>
											<td align="center">
												<div style="margin-left: 10px;"><s:property value="#item.nickName" /></div>
											</td>
										</tr>
								</table>
							</td>
							</tr>
						</s:elseif>
						<s:else>
							<td style="padding-top: 10px;">
							<table width="100%">
								<tr>
									<td>
										<div style="border:1px solid #e3e3e3; padding:1px;width: 77px;margin-left: 10px;">
							  						<div >
					     								<img  onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#item.userId"/>.png" height="70"  title="<s:property value="#item.Introduction"/>" />
					     							</div>
					     							<s:if test="#item.yingzheng==1">
					     								<div style="background-color: #c8c8ff;" >
						     								<table>
						     									<tr>
						     										<td  style="color: #ffffff;font-size: 14px;font-weight: bold;width: 70px;height: 20px;" align="center">应征</td>
						     									</tr>
						     								</table>
						     							</div>
					     							</s:if>
					     							<s:else>
					     								<div style="background-color: #ff8b18;cursor: pointer;" >
						     								<table>
						     									<tr>
						     										<td onclick="addPersonTask(${taskId},<s:property value="#item.id" />)" style="color: #ffffff;font-size: 14px;font-weight: bold;width: 70px;height: 20px;" align="center">已应征</td>
						     									</tr>
						     								</table>
						     							</div>
					     							</s:else>
					     							
					     						</div>
					     						</td>
								</tr>
								<tr>
									<td align="center">
										<div style="margin-left: 10px;"><s:property value="#item.nickName" /></div>
									</td>
								</tr>
							</table>
							</td>
						</s:else>
					</s:iterator>
				</table>
			</td>
		</tr>

	</table>
  </body>
</html>