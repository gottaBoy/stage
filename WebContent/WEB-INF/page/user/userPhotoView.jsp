<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript">  
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/temp/photo.jpg';
  	 }

	</script>
	
  </head>
  <body>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
  
  <!-- 会员详情 上 信息 开始 -->
<s:action name="userViewTop" namespace="" executeResult="true">
	<s:param name="userIdParam"><s:property value="#request.id"/></s:param>
</s:action>
<div class="clear"></div>
<!-- 会员详情 上 信息 结束 -->

<div id="member_introduces_center_box">
<div class="member_down_left">
<!-- 会员详情 下 信息 开始 -->

<s:action name="userViewLeft" namespace="" executeResult="true">
	<s:param name="userIdParam"><s:property value="#request.id"/></s:param>
</s:action>

<!-- 会员详情 下 信息 结束 -->
<!-- 成长历程（奖励、经历） 开始 -->
<!--  
<div class="member_down_left_top02">
<h2 class="member_down_left_top_tit">成长历程（奖励、经历）</h2>
<ul>
<s:iterator value="#request.listGrow" var="item">
<li><a href="#"><s:property value="#item.content"/></a></li>
</s:iterator>
</ul>


</div>
-->
</div>

<!-- 会员相册 视频 音频  开始 -->
<div class="member_det_img_list">
<table width="768" border="0" cellspacing="0" cellpadding="0" id="list_photo_img" >
    <tr>
        <td height="500">
<div class="list_contitle"><ul>
<li><span class="list_contitle_01">这里显示图片列表名称</span></li></ul></div>

<!-- 图片列表  开始 -->
<div class="member_photo_listimg">
<ul>
<s:iterator value="#request.artInfoList" var="item">
<li>
<a href="#"><img src="<s:property value="#item.url" />" width="135" height="135" /></a>
<p><a href="#"><s:property value="#item.title" /></a><br><span><s:property value="#item.creatTime.substring(0,10)" /></span><s:property value="#item.imgCount" />张</p></li>
</s:iterator>


</ul>
</div>
<div class="list_content_page" style="margin-top:10px;margin-right: 18px;"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="presonList!userPhoto.htm" params="id=${id }&&sign=1"  total='${total}' ></pg:pages></div>

<div class="clear"></div>

</td>
</tr>
</table>




</div>


</div><!-- 会员 相册 视频 音频 下 信息 结束 -->


</div>
<div class="clear"></div>






<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>