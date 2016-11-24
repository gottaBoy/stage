<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
            <!---------artinfo\addImgInfo.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">
	
		function checknull(){
			var title =$("#title").val();
	
			if(title==""){
				art.dialog.tips("【照片名称】不能为空！");
				return false;
			}
			/*
			var remark =$("#remark").val();
	
			if(remark==""){
				art.dialog.tips("【简介】不能为空！");
				return false;
			}
			*/
			
			
			
			return true;
		}
	
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		
        function doSubmit(){
			if(checknull()){
			             $.ajax({
						   url:"<%=request.getContextPath() %>/member/artInfo!saveOrUpdateImgInfo.htm?id=<%=request.getParameter("id")%>",
						   type:'POST',
						   data:$("#artInfoForm").serialize(),
						   success:function(data){
							   if(data=="1"){
									art.dialog.close();
							   }
						   }
						});
			}
			
        }
		
		function openTudou() {
			window.open("<%=request.getContextPath() %>/tudou/tudou.jsp","_blank");	
		}
	</script>
  </head>
  <body>
	 
  <form id="artInfoForm" name="artInfoForm" action="member/artInfo!saveOrUpdateImgInfo.htm?id=<%=request.getParameter("id")%>" method="post">
	<input type="hidden" name="artInfo.id" value="${artInfo.id }"/> 
	<input type="hidden" name="artInfo.userId" value="${artInfo.userId }"/> 
	<input type="hidden" name="artInfo.type" value="${artInfo.type }"/> 
	<input type="hidden" name="artInfo.imgCount" value="${artInfo.imgCount }"/> 
<div  style="height:280px;">
  <span class="zhezhaoClose" title="关闭"></span>
    
  <div class="zhezhaoxiangce">
     <h3>照片信息</h3>
     <div class="zhezhaoxiangce_a">
     
   </div>
     <ul>
        <li>
           <div class="name"><span>*</span>照片名称:</div>
           <input type="text" name="title" id="title" value="${appImagesInfo.title }" />
        </li>

		<!--
        <li>
           <div class="name"><span>*</span>简介:</div>
<textarea name="remark" id="remark" cols="45">${appImagesInfo.remark }</textarea>
        </li>
		-->

        <li>
           <a href="javascript:doSubmit();" class="baocun01">保存</a>
           <a href="javascript:CloseWin();">取消</a>
        </li>
     </ul>
  </div>
  
  
</div></form>
  </body>
</html>