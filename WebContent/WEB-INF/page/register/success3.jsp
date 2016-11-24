<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	//UserSession userSession = HttpSessionHelper.getUserSession(request);
	//int isForOrg = HttpSessionHelper.getOrgData(request); //0:no  1:yes
	//int isIndividual = HttpSessionHelper.getIsOrg(request);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
        <!---------register\success3.jsp -->
    <title><%=StageVariale.title%></title>
 	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css" />
 
 	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript">
 
	</script>
  </head>
  <body>
 
 
	<div  style="width:580px; height:380px;margin:15px;">

  <span class="zhezhaoClose" title="关闭"></span>
    
  <div class="gongxi">
     <div class="gongxi1">
     <h3>恭喜！</h3>
     <span>您的个人资料已完成30%</span>
     </div>
     <div class="gongxi2">
        <div style="float:left;width:97px;"><img src="<%=request.getContextPath() %>/theme/images/tu20.jpg" /></div>
        <div style="float:right;">
        <h3>个人资料越完善，您获得演出机会的可能性越大！<br />
您可以选择继续完善个人资料或查看您的个人页面。</h3>
        <a href="javascript:toInfo()">继续完善资料</a>
        <!-- <a href="javascript:toViewInfo()">查看我的页面</a> -->
        </div>
     </div>
  </div>
</div>
 <SCRIPT LANGUAGE="JavaScript">
 function toInfo(){
	 art.dialog.close();
	// window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
	 //art.dialog.parent.toInfo();
  }
 function toViewInfo(){
	 art.dialog.close();
	 //window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
	 //art.dialog.parent.toViewInfo();
  }
 </SCRIPT>
  </body>
</html>