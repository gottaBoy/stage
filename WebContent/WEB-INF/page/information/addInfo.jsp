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
	
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.js"></script>
	
	

	<script type="text/javascript">
	
		function checknull(){
		    var menuName =document.getElementById("info.menuName").value;
            if(menuName==""){
				$("#yzxx").text("");
				$("#yzxx").append("【模块名称】不能为空！");
				return false;
			}
			
			var orderNo =document.getElementById("info.orderNo").value;
            if(orderNo==""){
				$("#yzxx").text("");
				$("#yzxx").append("【模块序号】不能为空！");
				return false;
			}
			
			
			var title =document.getElementById("info.title").value;
            if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能为空！");
				return false;
			}
			return true;
		}
	
	
		function CloseWin() 
		{ 
		
			art.dialog.close(); 
		 
		} 
        var editor;
		KindEditor.ready(function(K) {
			editor = K.create('textarea[name="info.content"]', {
				cssPath : '<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css',
				uploadJson : '<%=request.getContextPath() %>/theme/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '<%=request.getContextPath() %>/theme/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['infoForm'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['infoForm'].submit();
					});
				}
			});
				
			prettyPrint();
		});
	

		var isSubmit = false;
        function doSubmit(){ 
	    	if(checknull()){

				if(!isSubmit){ 
					isSubmit = true;
				   document.getElementById("info.content").value=editor.html(); 
				   $.ajax({
					   url:"<%=request.getContextPath() %>/member/information!suInfo.htm",
					   type:'POST',
					   data:$("#infoForm").serialize(),
					   success:function(data){
							//刷新父页面
						   parent.location.href=parent.document.location;
						   //关闭当前页面
						   art.dialog.close();
					   }
					});
	      	   } 
	        }  
        }
        
	
	
					
	</script>
  </head>
  <body>
	<form id="infoForm" name="infoForm" action="member/information!suInfo.htm" method="post">
	<input type="hidden" name="info.id" id="info.id" value="${info.id }"/> 
	<input type="hidden" name="info.userId" value="${info.userId }"/> 
	<input type="hidden" name="info.creatTime" value="${info.creatTime }"/> 
    <input type="hidden" name="info.status" value="1"/> 
 
	<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="560" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div style="width:730px" class="add_table_box">
        <table width="710" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">信息发布</td>
            </tr>
        </table>
        <table width="700" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
		    <tr>
		        <td width="80" align="right"><font color=red>*</font>模块名称</td>
		        <td >  
		              <select name="info.parentId" id="info.parentId"   >
					       <s:iterator value="#request.infoParentList" var="item">
					       <option value="<s:property value="#item.id"/>"><s:property value="#item.menuName"/></option>			       
					       </s:iterator>
				       </select>
				       
		          <input type="text" name="info.menuName" id="info.menuName" style="width:250px;"  value="${info.menuName }"  class="add_popup_input" />	        		             
		         </td>
		        <td align="right"  width="80"><font color=red>*</font>模块序号</td>
		        <td >
		       
		        <input type="text" name="info.orderNo" id="info.orderNo" style="width:80px;" onkeydown="checkKeyForInt(this.value,event)"  value="${info.orderNo }"  class="add_popup_input" /></td>
		    </tr>
		     <tr>
		        <td align="right"><font color=red>*</font>标题 </td>
		        <td  colspan="3" >
		       
		        <input type="text" name="info.title" id="info.title" style="width:310px;"  value="${info.title }"  class="add_popup_input" /></td>
		    </tr>
		    <tr>
		        <td colspan="4" align="center">
				 <textarea name="info.content" id="info.content" cols="80" rows="5" style="width:700px;height:350px;visibility:hidden;"></textarea>
		         
		        </td>
		        
		        </tr>
		     <tr>
		       <td align="right"></td>
		       <td  style="color:#F00;" id="yzxx" colspan="3"></td>
		     </tr>
		    <tr>
		        <td colspan="4" align="center">
		        <a href="javascript:doSubmit();"><img  src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
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