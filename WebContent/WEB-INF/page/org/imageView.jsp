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
					uploadJson : '<%=request.getContextPath()%>/servlet/Upload?id=<s:property value="#request.xcId"/>',
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

 
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 -->
         <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="14"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a href="#">首页</a> > <a href="<%=request.getContextPath() %>/member/yrinfo.htm?userId=0">才艺信息</a></div>

<div class="right_tab">
<ul>
<li><a  href='<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign=1&&id=<s:property value='#request.userId'/>'>基本信息</a></li>
<li><a class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&userId=<s:property value='#request.userId'/>" id="font2" >相册</a></li>
<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&userId=${user_Id}" id="font3" >视频</a></li>
</ul>
</div>
<span class="clear"></span>
<!-- 标签页 内容一 -->
  <div id="TabTab03Con1" class="zndx_box01">
 <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>

<div class="zuopin">

<div class="zuopin_bt">
<a  id="J_selectImage" style="cursor: pointer;" class="chuang">上传照片</a>
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




</td>
</tr>
</table>
</div>
</td>
</tr>
</table>
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>