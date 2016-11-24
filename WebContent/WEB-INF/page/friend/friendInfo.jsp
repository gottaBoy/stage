<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>

 	<script type="text/javascript">
	function setTab03Syn(i,obj){
		for(var j = 1 ; j<=3 ; j++){
			if(i==j){
				$("#TabTab03Con"+i).show();
				$("#font"+i).addClass("change");
			}else{
				$("#TabTab03Con"+j).hide();
				$("#font"+j).removeClass("change");
			}
		}
	}
	
	$().ready(function(){
   
   		<%String sign = (String)request.getParameter("sign");if(sign != null){%>
   		
   		<%}else{sign = "1";}%>
		setTab03Syn(<%=sign%>);
    });
    
    
</script>

  </head>
  
  <body>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
  <table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="6"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">我的好友</a></div>


<div class="right_tab_a">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/friendInfo!toFriendInfo.htm?sign=1" id="font1">关注</a></li>
<li><a href="<%=request.getContextPath() %>/member/friendInfo!toFriendInfo.htm?sign=2" id="font2">粉丝</a></li>
<!-- <li><a href="<%=request.getContextPath() %>/member/friendInfo!toFriendInfo.htm?sign=3" id="font3">好友</a></li>-->
</ul>
</div>
<span class="clear"></span>

<!-- 标签页 内容一 -->
<div id="TabTab03Con1" style="display:block" class="zndx_box01">
<div class="wdhy_box">
<s:iterator value="#request.friendList" var="friendInfo">
<div class="wdhy_con">
<a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#friendInfo[0].friendId"/>"><img src="/stageUpload/headImage/<s:property value="#friendInfo[0].friendId"/>.png" width="50" height="49" /></a>
<ul>
<li><s:property value="#friendInfo[1].nickName"/></li>
<li class="gz_tb">已关注</li>
<li><a href="<%=request.getContextPath() %>/member/friendInfo!delFriendInfo.htm?sign=1&friendId=<s:property value="#friendInfo[0].friendId"/>">取消</a></li>
</ul>
<span class="clear"></span>
<span class="gz_jj">简介：<s:property value="#friendInfo[1].introduction"/></span>
</div>
</s:iterator>
</div>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="friendInfo!toFriendInfo.htm" params='sign=1' total='${total}' ></pg:pages></td>
    </tr>
</table>
</div>


<!-- 标签页 内容二 -->
<div id=TabTab03Con2 style="display:none" class="zndx_box01">
<div class="wdhy_box">
<s:iterator value="#request.friendList" var="friendInfo">
<div class="wdhy_con">
<a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#friendInfo[0].userId"/>"><img src="/stageUpload/headImage/<s:property value="#friendInfo[0].userId"/>.png" width="50" height="49" /></a>
<ul>
<li><s:property value="#friendInfo[1].nickName"/></li>
<li class="gz_tb">未关注</li>
<li><a href="<%=request.getContextPath() %>/member/friendInfo!addFriendInfo.htm?sign=2&friendId=<s:property value="#friendInfo[0].userId"/>">关注</a></li>
</ul>
<span class="clear"></span>
<span class="gz_jj">简介：<s:property value="#friendInfo[1].introduction"/></span>
</div>
</s:iterator>
</div>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="1"  url="friendInfo!toFriendInfo.htm" params='sign=2' total='${total}' ></pg:pages></td>
    </tr>
</table>
</div>


<!-- 标签页 内容三 -->
<div id=TabTab03Con3 style="display:none" class="zndx_box01">

<div class="wdhy_box">

<s:iterator value="#request.friendList" var="friendInfo">
<div class="wdhy_con">
<a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#friendInfo.friendId"/>"><img src="/stageUpload/headImage/<s:property value="#friendInfo.userId"/>.png" width="50" height="49" /></a>
<ul>
<li><s:property value="#friendInfo.nickName"/></li>
<li class="gz_tb_02">互相关注</li>
<li><a href="<%=request.getContextPath() %>/member/friendInfo!delFriendInfo.htm?sign=3&friendId=<s:property value="#friendInfo.userId"/>">取消</a></li>
</ul>
<span class="clear"></span>
<span class="gz_jj">简介：<s:property value="#friendInfo.introduction"/></span>
</div>
</s:iterator>
</div>

<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="1"  url="friendInfo!toFriendInfo.htm" params='sign=3'  total='${total}' ></pg:pages></td>
    </tr>
</table>

</div>



</td>
</tr>
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>
