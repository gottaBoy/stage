<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  

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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>

	<script type="text/javascript">

    
    
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

	function toAdd(sign){
	
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?id=<s:property value="#request.userId"/>&&sign='+sign,{width:550,height:450,resize: false});
	}
	function toUpdate(sign,id){
	
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?userId=<s:property value="#request.userId"/>&&id='+id+'&sign='+sign,{width:550,height:450,resize: false});
	}
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
  	 
  	 
  	function openMovie(swfurl){
			if(swfurl != ''){
				art.dialog({
			    padding: 0,
			    title: '视频播放',
			    content: "<embed src=\""+swfurl+"\" quality=\"high\" width=\"560\" height=\"480\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"
	
			});
		}
	}
	
	
	</script>
		
</head>
  <body>


  <!-- 主内容开始 -->
<table width="810" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
      
        <td width="810" align="left" valign="top">
    
<div class="right_tab">
<ul>
<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&&id=<s:property value="#request.userId"/>" id="font1" >相册</a></li>
<li><a class="change"  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&&id=<s:property value="#request.userId"/>" id="font2" >视频</a></li>
<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=3&&id=<s:property value="#request.userId"/>" id="font3" >音频</a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 标签页 内容二 -->
<div id=TabTab03Con2  class="zndx_box01">
<table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:0px;">
    <tr>
        <td height="24" align="right"><a href="javaScript:toAdd(2);"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
    </tr>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
    <tr>
        <td width="180" align="center" class="zyfl_title">标题</td>
        <td width="280" align="center" class="zyfl_title">简介</td>
        <td width="180" align="center" class="zyfl_title">创建时间</td>
        <td width="120" align="center" class="zyfl_title">操作</td>
    </tr>
    
    <s:iterator value="#request.movieOrVoiceList" var="artInfo">
    <tr>
        <td align="center"><a href="javaScript:openMovie('<s:property value="#artInfo.attachment" />');" class="czjl_title_link"><s:property value="#artInfo.title"/></a></td>
        <td align="left"><s:property value="#artInfo.intro"/></td>
        <td align="center"><s:property value="#artInfo.creatTime"/></td>  
        <td align="center">
        	<a href="javaScript:toUpdate(2,'<s:property value="#artInfo.id"/>');" class="czjl_title_link">修改</a>&nbsp;
        	<a href="javascript:toDel('<s:property value="#artInfo.id"/>');" class="czjl_title_link">删除</a>
        </td>
    </tr>
     </s:iterator>
 </table>

</td>
    </tr>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="artInfo!toArtInfo.htm" params='sign=2&&id=${ userId}' total='${total}' ></pg:pages></td>
    </tr>
</table>
</div>




</td>
</tr>
</table>
<!-- 主内容结束 -->
  </body>
</html>