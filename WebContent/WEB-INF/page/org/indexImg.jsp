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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>

	<script type="text/javascript">
	function handleImgLoadError(oEvent)
		   	{
		       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
		       
			}
	
			var flashvars = {
			  "uploadServerUrl":"./starInfo!upLoadPic.htm?userId="+'${userId}'+"_"+'${index}'+""
			};
			var params = {
				wmode:"opaque",
				width:800,
				height:600,
				type:"application/x-shockwave-flash"	
			};
			var attributes = {
			};
			if('${index}'=='1'){
				swfobject.embedSWF("../theme/flex/indexHeadImage.swf", "altContent", "600", "500", "9.0.0", "expressInstall.swf", flashvars, params, attributes);
				
			}else{
				swfobject.embedSWF("../theme/flex/starinfo.swf", "altContent", "600", "500", "9.0.0", "expressInstall.swf", flashvars, params, attributes);
			}
			

			function avatar_success()
			{
				//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
				alert("图片保存成功"); 
				//window.location.reload();
				window.parent.document.getElementById("no1StarImage"+'${index}').src="/stageUpload/starInfoImage/"+'${id}'+"_"+'${userId}'+"_"+'${index}'+".png?size="+parseInt(100*Math.random());
				art.dialog.close(); 
			}

	</script>
  </head>
  <body>
	<div id="altContent"></div>
  </body>
</html>