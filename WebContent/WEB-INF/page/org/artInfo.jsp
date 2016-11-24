<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!---------org\artInfo.jsp     -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/hg.css">
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>

	<script type="text/javascript">
    $().ready(function(){
			
		});
    
    function toDel(id){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/artInfo!delArtInfo.htm?id='+id,
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

	function toAdd(sign,artId){
			alert("org\artinfo.jsp");
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign+'&artId='+artId+'&userId='+${user_Id},
		{width:700,height:650,close: function () {
				     		 location.reload();
				  		}});
	}
	function toUpdate(sign,id){
	
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&sign='+sign,{width:700,height:650,resize: false});
	}
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	
	
	</script>
		
</head>
  <body>

  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
 <table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="13"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">企业信息</a></div>



<!-- 导航 结束 -->

<div class="right_tab">
<ul>
<li><a href="orginfo.htm?sign=1">基本信息</a></li>
<!-- <li><a href="orginfo.htm?sign=2">企业认证</a></li>
<li><a href="orginfo.htm?sign=3">头像修改</a></li> -->
<li><a class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=5&userId=${userInfo.id }" id="font2" >相关作品</a></li>
<!-- <li><a href="orginfo.htm?sign=4">绑定支付宝</a></li> -->
</ul>
</div>
<!-- 标签页 内容一 -->
  <div id="TabTab03Con1" class="zndx_box01">

 <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
        
          <div class="zuopin_bt">
			<!-- <a href="#" class="chuang">上传照片</a> -->
			<a href="javaScript:toAdd(1,0);">创建相册</a>
			</div>

			<div class="zuopin_cont">
			<ul>
			 <s:iterator value="#request.artInfoList" var="artInfo">
			<li><div class="xc_div"><a href="<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id=<s:property value="#artInfo.id"/>&userId=<s:property value="#request.userId"/>"><img onerror="handleImgLoadError(event);" onload="AutoSize(this,140,140)" src="<s:property value="#artInfo.url"/>" width="140" height="140" /></a></div>
			<p><div class="xiangce_name"><s:property value="#artInfo.imgCount"/> 张</div>
			<a href="javaScript:toUpdate(1,'<s:property value="#artInfo.id"/>');" class="xiangce_sl"><s:property value="#artInfo.title"/></a>
			<p><div class="xiangce_name"><a href="javascript:toUpdate(1,'<s:property value="#artInfo.id"/>');" class="czjl_title_link">编辑</a>&nbsp;<a href="javascript:toDel('<s:property value="#artInfo.id"/>');" class="czjl_title_link">删除</a></div>
			<font style="color: #999"><s:property value="#artInfo.creatTime.substring(0,10)"/></font></p></li>
			</s:iterator>
			</ul>
			</div>
</td>
    </tr>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="artInfo!toArtInfo.htm" params='sign=1' total='${total}' ></pg:pages></td>
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