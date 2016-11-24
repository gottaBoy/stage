<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/followButton.css">
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">
	
		function checknull(){
			var title =$("#growth\\.title").val();
			var startDate=$("#growth\\.startDate").val();
			var endDate=$("#growth\\.endDate").val();
		

			//if(startDate==""){
			//	$("#yzxx").text("");
			//	$("#yzxx").append("【日期】不能为空！");
			//	return false;
			//}
			//if(endDate==""){
			//	$("#yzxx").text("");
			//	$("#yzxx").append("【日期】不能为空！");
			//	return false;
			//}
			
			if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能为空！");
				return false;
			}else if(title.length>200){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能超过200个字符！");
				return false;
			}
			return true;
		}
	
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		
		var isSubmit = false;
        function doSubmit(){
	    	if(checknull()){
				if(!isSubmit){  
	        	   isSubmit = true;   
					$.ajax({
					   url:"<%=request.getContextPath() %>/growth!suGrowth.htm?uid=<s:property value='#request.id'/>",
					   type:'POST',
					   data:$("#growthForm").serialize(),
					   success:function(data1){
						   if(data1 == 1){
						   try{
						   	   parent.getUserInfoGrowth();
							   parent.getUserInfo2();
				   			   parent.showContent(4);
						   }catch(err){
						   		alert("保存成功~");
						   }
							  
							   art.dialog.close();
						   }
					   }
					});
				  
	      	   } 
	        }  
        }
					
	</script>
  </head>
  <body>
	<form id="growthForm" name="growthForm" action="member/growth!suGrowth.htm?uid=<s:property value="#request.id"/>" method="post">
	<input type="hidden" name="growth.id" value="${growth.id }"/> 
	<input type="hidden" name="growth.userId" value="${growth.userId }"/> 
	<input type="hidden" name="growth.creatTime" value="${growth.creatTime }"/> 
	
<div class="content">
<div class="content_left">
<h3>成长经历</h3>
<ul>
<li>
    <div class="name"> 标题：</div>
    <input type="text" name="growth.title" id="growth.title" style="width:370px;"  value="${growth.title }"  />
</li>
<li>
    <div class="name"> 日期：</div>
   <input type="text" name="growth.startDate" id="growth.startDate"  class="duan" style="width:85px;"  value="${growth.startDate }"   onClick="WdatePicker()" />
    <span class="heng">-</span>
    <input type="text" name="growth.endDate"  id="growth.endDate" class="duan" style="width:85px;"   value="${growth.endDate }"  onClick="WdatePicker()" />
</li>
<li>
    <div class="name"> 内容：</div>
    <textarea name="growth.content" id="growth.content" cols="45" rows="5" >${growth.content }</textarea>
</li>

</ul>
</div>
<div class="baocun">
<a href="javascript:doSubmit();">保存</a>
</div>
</div>
	<!-- 
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="360" bgcolor="#FFFFFF">
        
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">成长经历</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
           <tr>
                <td width="20%" align="right"><font color=red></font>日期</td>
                <td  align="left" width="18%">
                	<input type="text" name="growth.startDate" id="growth.startDate"  class="nc_input Wdate" style="width:85px;"  value="${growth.startDate }"   onClick="WdatePicker()" />
                </td>
                <td align="left" width="2%">至</td>
                <td align="left"><input type="text" name="growth.endDate"  id="growth.endDate" class="nc_input Wdate" style="width:85px;"   value="${growth.endDate }"  onClick="WdatePicker()" /></td>
               
            </tr>
		    <tr>
		        <td width="61" align="right"><font color=red>*</font>标题 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="growth.title" id="growth.title" style="width:370px;"  value="${growth.title }"  class="add_popup_input" /></td>
		    </tr>
		    <tr>
		        <td align="right">内容</td>
		        <td colspan="3"><textarea name="growth.content" id="growth.content" cols="45" rows="5" class="add_popup_textarea ">${growth.content }</textarea></td>
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
        
        </td>
    </tr>
</table> -->
	
 
        </form>
  </body>
</html>