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
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
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

	function toAdd(){
		art.dialog.open('<%=request.getContextPath()%>/member/information!toInfo.htm',{width:850,height:650,resize: false});
	}
	function toEdit(id){
		art.dialog.open('<%=request.getContextPath()%>/member/information!toInfo.htm?id='+id,{width:750,height:600,resize: false});
	}
	function toView(id){
		art.dialog.open('<%=request.getContextPath()%>/member/information!toViewInfo.htm?id='+id,{width:750,height:600,resize: false});
	}
	function toDel(id){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/information!delInfo.htm?id='+id,
						function(data){
							if(data=="1"){
							//art.dialog.tips("删除成功!");
							window.location.reload();
						}
					},"html");

					
				},
				cancel: true
		});

		
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
        <!-- 会员 左导航 开始 -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="11"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a href="#">首页</a> > <a href="#">信息发布</a></div>


<span class="clear"></span>

<table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
    <tr>
        <td height="24" align="right"><a href="javascript:toAdd();" class="a_link"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
    </tr>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td  width="80" align="center" class="zyfl_title">分类</td>
		    <td  width="80" align="center" class="zyfl_title">模块名称</td> 
		    <td  width="60" align="center" class="zyfl_title">模块序号</td> 
		    <td  align="center" class="zyfl_title">标题</td>     
	        
	        <td width="120" align="center" class="zyfl_title">创建时间</td>
	        <td width="100" align="center" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.infoList" var="info">
		<tr>
		    <td  align="center"  >
		    	<a href="javascript:toEdit('<s:property value="#info[0].id"/>');" class="czjl_title_link"><s:property value="#info[0].menuName"/>&nbsp;</a>
		    </td>	        
	        <td  align="center"  ><s:property value="#info[1].menuName"/>&nbsp;</td>
	        <td  align="center"  ><s:property value="#info[0].orderNo"/>&nbsp;</td>
	        <td  align="center"  ><s:property value="#info[0].title"/>&nbsp;</td>
	        <td  width="120" align="center"  ><s:property value="#info[0].creatTime"/>&nbsp;</td>
	        <td  align="center"  ><a href="javascript:toDel('<s:property value="#info[0].id"/>');" class="czjl_title_link">删除</a>&nbsp;<a href="javascript:toView('<s:property value="#info[0].id"/>');" class="czjl_title_link">预览</a></td>
	    </tr>
	</s:iterator>

</table>

<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="information.htm" total='${total}' ></pg:pages></td>
    </tr>
</table>

</td>
    </tr>
</table>

</td>
</tr>
</table>


</td>
</tr>
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

  </body>
</html>