<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<style type="text/css" media="screen">
		html, body { height:100%; background-color: #ffffff;}
		#flashContent { width:100%; height:100%; }
	</style>

		<script type="text/javascript">
			var flashvars = {
			  "uploadServerUrl":"./userinfo!upLoadPic.htm"
			};
			var params = {
				wmode:"opaque",
				width:600,
				height:600,
				type:"application/x-shockwave-flash"	
			};
			var attributes = {
			};

			swfobject.embedSWF("../theme/flex/headImage.swf", "altContent", "650", "500", "9.0.0", "expressInstall.swf", flashvars, params, attributes);

			function avatar_success()
			{
				//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
				parent.getUserInfo();
				art.dialog.close();
			}
</script>
  </head>
  <body>
  <!-- 主内容开始 -->
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td align="left" valign="top">

<div style="width:500px; height:34px; float:left; margin-top:5px; border-bottom:2px #BD0000 solid; margin-top:10px; margin-left:10px;">
<div style="line-height:34px; text-align:center; background-color:#BD0000; width:90px;font-family:'宋体'; font-size:14px; color:#fff; font-weight:bold;">头像修改</div>
</div>

<div style="height:15px;"></div>
<div id="altContent"></div>
<div id="avatar_priview"></div>        

</td>
</tr>
</table>


  </body>
</html>