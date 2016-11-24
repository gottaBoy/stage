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

	<script type="text/javascript">
	
		
		function CloseWin() 
		{  
		    parent.location.href=parent.document.location;
			art.dialog.close(); 
		 
		} 	
	</script>
  </head>
  <body>
	<form id="messageForm" name="messageForm" action="member/message!addMessage.htm" method="post">
	<input type="hidden" name="message.id" value="${message.id }"/> 
	<input type="hidden" name="message.creatTime" value="${message.creatTime }"/> 
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="360" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">站内短信</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
           <tr>
                <td width="13%">收信人</td>
                <td  align="left" width="37%">
                	<span class="text_mc">${toUserName }</span>
                </td>
                <td width="16%">发信人</td>
                <td align="left" width="34%"><span class="text_mc">${fromUserName }</span></td>
               
            </tr>
		    <tr>
		        <td >标题 </td>
		        <td colspan="3" ><span class="text_mc">${message.title }</span></td>
		    </tr>
		    <tr>
		        <td>内容</td>
		        <td colspan="3"><span class="text_mc">${message.content }</span></td>
		    </tr>
		     <tr height="100">
		        <td >创建时间 </td>
		        <td colspan="3"><span class="text_mc">${message.creatTime }</span></td>
		    </tr>
		    <tr>
		        <td colspan="4" align="center">
		        
		        <a href="javascript:CloseWin();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
		        
		        </td>
		        </tr>
		</table>
        

        </div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
	
 
        </form>
  </body>
</html>