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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript">
	
		function checknull(){

			var title =$("#task\\.title").val();
			var place=$("#task\\.place").val();
			var content=$("#task\\.content").val();
			var mobile=$("#task\\.mobile").val();
			
			if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能为空！");
				return false;
			}else if(title.length>200){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能超过200个字符！");
				return false;
			}
			
			if(place==""){
				$("#yzxx").text("");
				$("#yzxx").append("【地点】不能为空！");
				return false;
			}else if(place.length>256){
				$("#yzxx").text("");
				$("#yzxx").append("【地址】不能超过256个字符！");
				return false;
			}
			
			if(mobile==""){
				$("#yzxx").text("");
				$("#yzxx").append("【联系方式】不能为空！");
				return false;
			}else if(mobile.length>11){
				$("#yzxx").text("");
				$("#yzxx").append("【联系方式】不能超过11个字符！");
				return false;
			}
			
			if(content==""){
				$("#yzxx").text("");
				$("#yzxx").append("【内容】不能为空！");
				return false;
			}else if(content.length>1000){
			    $("#yzxx").text("");
				$("#yzxx").append("【内容】不能超过1000个字符！");
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
	        	   var form = $(document.getElementById('taskForm'));
			        //获取浏览器参数
			        var browserName = navigator.userAgent.toLowerCase();
			        if (/chrome/i.test(browserName) && /webkit/i.test(browserName) && /mozilla/i.test(browserName)) {
			        //chrome浏览器
			        var tmp = form.attr('action');
			            $.post(tmp, form.serialize());
			        }else {
			            //执行SUBMIT  
			           form.submit();   
			    	} 
	      	   } 
	        }  
        }
					
	</script>
  </head>
  <body>
	<form id="taskForm" name="taskForm" action="member/task!wtwmTask.htm" method="post">
	<input type="hidden" name="task.id" value="${task.id }"/> 
	<input type="hidden" name="task.userId" value="${task.userId }"/> 
	<input type="hidden" name="task.creatTime" value="${task.creatTime }"/> 
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="480" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">委托我们</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
		    <tr>
           <td></td>
	           <td style="color: red;line-height: 22px" colspan="3">
	           	找不到专业编剧？找不到灯光设计？找不到整包团队？找不到......心里没谱还是嫌麻烦？那就委托第1舞台吧。写下你的需求。留下您的联系方式，我们会尽快联系您滴。
<br/>
	           
	           </td>
           </tr>
		    <tr>
		        <td width="61" align="right"><font color=red>*</font>标题 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="task.title" id="task.title" style="width:370px;"  value="${task.title }"  class="add_popup_input" /></td>
		    </tr>
		    <tr>
		        <td width="61" align="right"><font color=red>*</font>地点 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="task.place" id="task.place" style="width:370px;"  value="${task.place }"  class="add_popup_input" /></td>
		    </tr>
		     <tr>
		        <td width="61" align="right"><font color=red>*</font>联系方式 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="task.mobile" id="task.mobile" style="width:370px;"  value="${task.mobile }"  class="add_popup_input" onkeydown="checkKeyForFloat(this.value,event)"/></td>
		    </tr>
		    <tr>
		        <td align="right"><font color=red>*</font>内容</td>
		        <td colspan="3"><textarea name="task.content" id="task.content" cols="45" rows="5" class="add_popup_textarea ">${task.content }</textarea></td>
		        </tr>
		       <tr>
		        <td width="61" align="right"><font color=red>*</font>价格区间 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="task.mobile" id="task.mobile" style="width:150px;"  value="${task.mobile }"  class="add_popup_input" onkeydown="checkKeyForFloat(this.value,event)"/>&nbsp;-&nbsp;
		        <input type="text" name="task.mobile" id="task.mobile" style="width:150px;"  value="${task.mobile }"  class="add_popup_input" onkeydown="checkKeyForFloat(this.value,event)"/>
		        </td>
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