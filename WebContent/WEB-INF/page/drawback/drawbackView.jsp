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
			art.dialog.close(); 
		 
		} 
		
		
		
	</script>
  </head>
  <body>
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="360" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box" style="height: 400px">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">退款信息</td>
                
                <td  align="right" style="color: red;">状态:
		            <s:if test="#request.drawback.status==1">等待退款</s:if>
			        <s:if test="#request.drawback.status==2">拒绝退款</s:if>
			        <s:if test="#request.drawback.status==3">再次退款</s:if>
			        <s:if test="#request.drawback.status==4">退款成功</s:if>
			        <s:if test="#request.drawback.status==5">退款关闭</s:if>
                </td>
            </tr>
        </table>
        <table width="460"  border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
             <tr>
                <td width="80" align="center" >退款编号：</td>
                <td width="380" height="90" align="left">${drawback.drawbackNo }</td>
            </tr>
            <tr>
                <td align="center" >退款金额：</td>
                <td align="left">${drawback.drawbackAmount }&nbsp;元</td>
            </tr>
            <tr>
                <td align="center" >申请时间：</td>
                <td align="left">${drawback.creatTime }</td>
            </tr>
            <tr>
                <td align="center" >退款时间：</td>
                <td align="left">${drawback.drawbackDate }</td>
            </tr>
            <tr>
                <td align="center" style="vertical-align: top;">退款原因：</td>
                <td align="left">${drawback.drawbackCause }</td>
            </tr>
            <tr>
		       <td align="right"></td>
		       <td colspan="3" style="color:#F00;" id="yzxx"></td>
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

  </body>
</html>