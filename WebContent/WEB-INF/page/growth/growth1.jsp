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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
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
		function toAdd(){
		art.dialog.open('<%=request.getContextPath()%>/member/growth!toGrowth.htm',{width:550,height:400,resize: false});
	}
	function toEdit(id){
		art.dialog.open('<%=request.getContextPath()%>/member/growth!toGrowth.htm?id='+id,{width:550,height:400,resize: false});
	}
	function toDel(id){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/growth!delGrowth.htm?id='+id,
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
	
	function tishi(content){
		alert(content);
   		window.location.href=window.document.location;
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
        	<s:param name="menuFlag" value="1"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">个人信息</a></div>
<div class="right_tab">
<ul>
<li><a href="userinfo.htm?sign=1">基础信息</a></li>
<li><a href="userinfo.htm?sign=2"><%if(1==HttpSessionHelper.getIsOrg(request)){%>公司介绍<%}else{ %>个人介绍<%} %></a></li>
<li><a href="userinfo.htm?sign=3">职业技能</a></li>
<li><a class="change" href="userinfo.htm?sign=7">成长经历</a></li>
<li><a href="userinfo.htm?sign=4">实名认证</a></li>
<li><a href="userinfo.htm?sign=5">头像修改</a></li>
<li><a href="userinfo.htm?sign=6">首页照片<img src="<%=request.getContextPath() %>/theme/images2/tu_xb.png" /></a></li>
</ul>
</div>
<span class="clear"></span>
<!-- 基础信息 开始 -->
<form name="jcxxForm" id="jcxxForm" action="userinfo!saveOrUpdate.htm?sign=1" method="post">
<input type="hidden" name="userInfo.id" value="${userInfo.id }"/> 
 <div id=TabTab03Con>

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
		    <td width="167" align="center" class="zyfl_title">标题</td>
	        <td width="167" align="center" class="zyfl_title">日期</td>	        
	        <td width="231" align="center" class="zyfl_title">内容</td>
	        <td width="115" align="center" class="zyfl_title">创建时间</td>
	        <td width="80" align="center" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.growthList" var="growth">
		<tr>
		    <td  align="center"  ><a href="javascript:toEdit('<s:property value="#growth.id"/>');" class="czjl_title_link"><s:property value="#growth.title"/></a></td>	        
	        <td  align="center"  ><s:property value="#growth.startDate"/>&nbsp;-&nbsp;<s:property value="#growth.endDate"/></td>
	        <td  align="left"  >
	         <s:if test="#growth.content.length()>=30">
	         	<s:property value='#growth.content.substring(0,30)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#growth.content"/></s:else> &nbsp;	        
	        </td>
	        <td  align="center"  ><s:property value="#growth.creatTime"/></td>
	        <td  align="center"  ><a href="javascript:toDel('<s:property value="#growth.id"/>');" class="czjl_title_link">删除</a></td>
	    </tr>
	</s:iterator>

</table>

<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="userinfo.htm" params="sign=7" total='${total}' ></pg:pages></td>
    </tr>
</table>

</td>
    </tr>
</table>


 </div>
 </form>

                    
</div>
</td>
</tr>
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>