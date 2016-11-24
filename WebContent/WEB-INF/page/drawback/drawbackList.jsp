<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	
	
	$().ready(function(){
   
   		$("#TabTab03Con3").show();
		$("#font3").addClass("change");
    });
 
    
	
	function updateAlipay(){
    	art.dialog.open('<%=request.getContextPath()%>/member/userinfo!doUpdateAlipay.htm',{lock:true,resize: false});
	}
	
	
	    
	function toPayPage(id) {
		window.open("<%=request.getContextPath()%>/member/drawback!getPayInfo.htm?id="+id);
		
	}
		
    function toBusinessView(id){
		window.open('<%=request.getContextPath()%>/member/business!toBusinessView.htm?id='+id);
	}
     function toDrawbackView(id){
		art.dialog.open('<%=request.getContextPath()%>/member/drawback!toDrawbackView.htm?id='+id,{resize: false});
	}
	var myUserView=null;
    function userView(userId){
    	if(myUserView!=null){
    		myUserView.close();
    		myUserView=window.open("<%=request.getContextPath() %>/presonList.htm?id="+userId,"userView");
    	}else{
    		myUserView=window.open("<%=request.getContextPath() %>/presonList.htm?id="+userId,"userView");
    	}
    }
		
		
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
        	<s:param name="menuFlag" value="31"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">付款管理</a></div>


<div class="right_tab">
<ul>
<span class="bdzfb_style"><a href="javascript:toPayPage();" class="bdzfb_link">批量支付</a></span>
<li><a class="change" href="#" id="font3">待退款订单</a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 标签页 内容一 -->
 <div id="TabTab03Con3" style="display:block" class="zndx_box01">
  <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
    <tr>
    	<td width="100" align="center" class="zyfl_title">退款编号</td>
        <td width="100" align="center" class="zyfl_title">订单编号</td>
        <td width="120" align="center" class="zyfl_title">被签约者</td>
        <td width="80" align="center" class="zyfl_title">退款金额</td>
        <td width="80" align="center" class="zyfl_title">申请时间</td>
        <td width="80" align="center" class="zyfl_title">操作</td>
    </tr>
     <s:iterator value="#request.drawbackList" var="drawback">
    <tr>
        <td align="center"><a href="javaScript: toDrawbackView(<s:property value="#drawback[0].id"/>);" class="czjl_title_link">
        	<s:property value="#drawback[0].drawbackNo"/></a></td>
        <td align="center"><a href="javaScript: toBusinessView(<s:property value="#drawback[0].businessId"/>);" class="czjl_title_link">
        	<s:property value="#drawback[3].orderCode"/></a></td>
        <td align="center"><a href="javaScript: userView(<s:property value="#drawback[3].seller"/>);" class="czjl_title_link">
        	<s:property value="#drawback[2]"/></a></td>
        <td align="center"><s:property value="#drawback[0].price"/></td>
        <td align="center"><s:property value="#drawback[0].creatTime.substring(0,10)"/></td>
        <td align="center">
        	<a href="javaScript:toPayPage(<s:property value="#drawback[0].id"/>);" class="czjl_title_link">付款</a>
        </td>
    </tr>
    </s:iterator>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="drawback!myDrawback.htm" params='sign=1' total='${total}' ></pg:pages></td>
    </tr>
</table>
</td>
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
