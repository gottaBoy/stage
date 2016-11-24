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
		
        function doSubmit(){
        	var title =$("#message\\.title").val();
        	var content =$("#message\\.content").val();
        	var toUserId =$("#message\\.toUserId").val();
        	if(title == null||""==title){
         	   art.dialog.tips("标题不能为空!");
         	   return;
         	}
         	 
         	 if(content == null||""==content){
         	   art.dialog.tips("内容不能为空!");
         	   return;
         	 }
         	 
         	 if(title.length>20){
         	 	art.dialog.tips("标题为20个字以内!");
         	   return;
         	 }
      
         	 if(content.length>140){
         	 	art.dialog.tips("内容为140个字以内!");
         	   return;
         	 }
        	
	    	
				   $.post("<%=request.getContextPath()%>/messageSend!sendMessage.htm?id="+encodeURIComponent(toUserId)+"&content="+encodeURIComponent(encodeURIComponent(content))+"&title="+encodeURIComponent(encodeURIComponent(title)),function(data){
				      	if(data==1){
				      	
				      		art.dialog({
							    icon: 'succeed',
							    content: '发送成功',
							    ok:function(){
							     CloseWin();
							    }
							});
				      	}
				      });
	      	   
	       
        }
					
	</script>
  </head>
  <body>
	<form id="messageForm" name="messageForm" action="member/message!addMessage.htm" method="post">
	<input type="hidden" name="message.toUserId" id="message.toUserId" value="${message.fromUserId }"/> 
	<input type="hidden" name="message.fromUserId" id="message.fromUserId" value="${message.toUserId }"/> 
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="300" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">站内短信</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
           
		    <tr>
		        <td  align="right"><font color=red>*</font>标题 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="message.title" id="message.title" style="width:370px;"  class="add_popup_input" /></td>
		    </tr>
		    <tr>
		        <td align="right"><font color=red>*</font>内容</td>
		        <td colspan="3"><textarea name="message.content" id="message.content" cols="45" rows="5" class="add_popup_textarea "></textarea></td>
		        </tr>
		     <tr>
		       <td align="right"></td>
		       <td colspan="3" style="color:#F00;" id="yzxx"></td>
		     </tr>
		    <tr>
		        <td colspan="4" align="center">
		        <a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
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