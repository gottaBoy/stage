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
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor-all-min.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.js"></script>
	

	<script type="text/javascript">
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	function toAdd(sign){
		art.dialog.open('<%=request.getContextPath()%>/page/imgUp.jsp?sign='+sign,{width:744,height:533,resize: false,lock :true ,close:function(){location.reload();}});
	}
	
	function view(obj){
	//alert(obj.src);
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+obj.src+'" />',
		    lock: true
		});
	}
	function toDel(id){
		art.dialog({
		        icon: 'warning',
				content: '您确定删除当前图片吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/artInfo!delImg.htm?id='+id,
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
	
		function setUpImg(id){
			$.post('<%=request.getContextPath()%>/member/artInfo!setUpImg.htm?id='+id,
						function(data){
							if(data=='1'){
							art.dialog.tips("设置成功!");
							//window.location.reload();
						}
					},"html");
		}
		
		
		KindEditor.ready(function(K) {
				var editor = K.editor({
					uploadJson : '<%=request.getContextPath()%>/servlet/Upload?id=<s:property value="#request.xcId"/>&userId=<s:property value="#request.userId"/>',
					allowFileManager : true
					
				});
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_imageView');
								div.html('');
								K.each(urlList, function(i, data) {
									div.append('<img src="' + data.url + '">');
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
	</script>
		
</head>
  <body>

  <!-- 主内容开始 -->
<table width="680" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="680" align="left" valign="top">


<!-- 标签页 内容一 -->
 <table width="680" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="680" border="0" align="left" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:10px; margin-left:10px;">
    <tr>
        <td height="24" align="left"><!-- <a href="javaScript:toAdd('<s:property value="#request.xcId"/>');"  >--><img id="J_selectImage" src="<%=request.getContextPath()%>/theme/images/add_phtoto02.jpg" width="90" height="30" /></td>
    </tr>
</table>
 <!--  
<div class="xiangce_list">
<ul>
 <s:iterator value="#request.lists" var="list">

<li><div class="xc_div"><a href="#"><img onclick="view(this)" onerror="handleImgLoadError(event);" onload="AutoSize(this,140,140)" src="<s:property value="#list.url"/>" /></a></div>
<p><div class="xiangce_name"><a href="javascript:toDel('<s:property value="#list.id"/>');" class="czjl_title_link">删除</a></div>
<a href="javascript:setUpImg('<s:property value="#list.id"/>');"><font style="color:#999">设为封面</font></a></p>
</li>
</s:iterator>
</ul>
</div>-->
</td>
    </tr>
</table>

<div class="zuopin">

<div class="zuopin_bt">
<a href="#" class="chuang">上传照片</a>
<a href="#">美女相册</a>
<a href="#">设置首页推荐图</a>
<p>（默认为上传第一张照片）</p>
</div>

<div class="zuopin_cont">
<ul>
 <s:iterator value="#request.lists" var="list">
<li>
<img src="<s:property value="#list.url"/>" width="146" height="137" />
<h6></h6>
<a href="#" class="shezhi">设为首页封面图</a>
<a href="javascript:setUpImg('<s:property value="#list.id"/>');" class="bianji">设置封面</a>
<a href="javascript:toDel('<s:property value="#list.id"/>');" class="bianji">删除</a>
</li>
</s:iterator>
</ul>
</div>

</div>

<div>


</div>


</td>
</tr>
</table>
<!-- 主内容结束 -->

  </body>
</html>