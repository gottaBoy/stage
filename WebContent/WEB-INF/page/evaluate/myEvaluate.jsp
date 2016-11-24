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
		for(var j = 1 ; j<=2 ; j++){
			if(i==j){
				$("#TabTab03Con"+i).show();
				$("#font"+i).addClass("change");
			}else{
				$("#TabTab03Con"+j).hide();
				$("#font"+j).removeClass("change");
			}
		}
	}
	
	 function toBusinessView(id){
		art.dialog.open('<%=request.getContextPath()%>/member/business!toBusinessView.htm?id='+id,{resize: false});
	}
	
	$().ready(function(){
   
   		<%String sign = (String)request.getParameter("sign");if(sign != null){%>
   		
   		<%}else{sign = "1";}%>
		setTab03Syn(<%=sign%>);
    });
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
        	<s:param name="menuFlag" value="21"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">评价管理</a></div>


<div class="right_tab">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/evaluate!myEvaluate.htm?sign=1" id="font1">我评价的</a></li>
<li><a href="<%=request.getContextPath() %>/member/evaluate!myEvaluate.htm?sign=2" id="font2">评价我的</a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 标签页 内容一 -->
 <div id="TabTab03Con1" style="display:block" class="zndx_box01">
  <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
    <tr>
        <td width="120" align="center" class="zyfl_title">评价</td>
        <td width="430" align="center" class="zyfl_title">评论</td>
        <td width="120" align="center" class="zyfl_title">被评价人</td>
        <td width="120" align="center" class="zyfl_title">订单编号</td>
     </tr>
     <s:iterator value="#request.businessEvaluateList" var="evaluate">
    <tr>
        <td align="center">
        	<s:if test='#evaluate[0].pjGrade=="1"'>好评</s:if>
        	<s:if test='#evaluate[0].pjGrade=="0"'>中评</s:if>
        	<s:if test='#evaluate[0].pjGrade=="-1"'><font color="red">差评</font></s:if>
        </td>
        <td align="left" style="line-height: 17px;word-break:break-all;"><s:property value="#evaluate[0].pjContent"/></td>
        <td align="center"><a href="javaScript:userView(<s:property value="#evaluate[4]" />)" class="czjl_title_link"><s:property value="#evaluate[2]"/></a></td>
        <td align="center"><a href="javaScript:toBusinessView(<s:property value="#evaluate[0].businessId"/>);" class="czjl_title_link"><s:property value="#evaluate[3]"/></a></td>
     </tr>
    </s:iterator>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="evaluate!myEvaluate.htm" params='sign=1' total='${total}' ></pg:pages></td>
    </tr>
</table>
</td>
    </tr>
</table>
</div>

<!-- 标签页 内容二 -->
<div id=TabTab03Con2 style="display:none" class="zndx_box01">
  <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
    <tr>
        <td width="120" align="center" class="zyfl_title">评价</td>
        <td width="430" align="center" class="zyfl_title">评论</td>
        <td width="120" align="center" class="zyfl_title">评价人</td>
        <td width="120" align="center" class="zyfl_title">订单编号</td>
    </tr>
     <s:iterator value="#request.businessEvaluateList" var="evaluate">
    <tr>
        <td align="center">
        	<s:if test='#evaluate[0].pjGrade=="1"'>好评</s:if>
        	<s:if test='#evaluate[0].pjGrade=="0"'>中评</s:if>
        	<s:if test='#evaluate[0].pjGrade=="-1"'><font color="red">差评</font></s:if>
        </td>
        <td align="left" style="line-height: 17px;word-break:break-all;"><s:property value="#evaluate[0].pjContent"/></td>
        <td align="center"><a href="javaScript:userView(<s:property value="#evaluate[0].creatId"/>)" class="czjl_title_link"><s:property value="#evaluate[2]"/></a></td>
        <td align="center"><a href="javaScript:toBusinessView(<s:property value="#evaluate[0].businessId"/>);" class="czjl_title_link"><s:property value="#evaluate[3]"/></a></td>
    </tr>
    </tr>
    </s:iterator>
 </table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="evaluate!myEvaluate.htm" params='sign=2' total='${total}' ></pg:pages></td>
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
