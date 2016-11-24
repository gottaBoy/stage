<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	UserSession userSession = HttpSessionHelper.getUserSession(request);
	int isForOrg = HttpSessionHelper.getOrgData(request); //0:no  1:yes
	int isIndividual = HttpSessionHelper.getIsOrg(request);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
   <!-- -----org/zupin.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/WdatePicker.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link href="<%=request.getContextPath() %>/theme/css/style.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/theme/css/hg.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">  

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/43!register.css" />

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
	<style type="text/css" media="screen">
		html, body { height:auto !important;background-color: #f5f5f5;}
 
	</style>
	
<script type="text/javascript">
      

$(document).ready(function(){
	getUserArt(1);
});

function toAddArt(sign){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign,{width:650,height:450,resize:false,lock:true ,close: 
		function () {
			getUserArt(1);
		}});
}
function handleImgLoadError2(oEvent) {
	oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
}

function toDelArt(id, type){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/artInfo!delArtInfo.htm?id='+id,
			function(data){
				if(data=="1"){
					//getUserArt(type);
					window.location.reload();
				}
			},"html");
		},
		cancel: true
	});
}
function openXiangce(id){

<%if(isForOrg >= 0){%>
	window.location.href ="<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id="+id+"&<%=HttpSessionHelper.getParamData(request)%>";
<%}else{%>
	window.location.href ="<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id="+id+"&<%=HttpSessionHelper.getParamData(request)%>";
<%}%>

}
function toUpdateArt(sign,id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&sign='+sign+'&<%=HttpSessionHelper.getParamData(request)%>',{width:650,height:550,lock:true,resize: false,close: 
		function () {
			getUserArt(1);
		}});
}

//获取用户才艺（相册视频音频）
function getUserArt(type) {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserArtList1.htm?<%=HttpSessionHelper.getParamData(request)%>&type=" + type,
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			
			var html = "";
			if(d.length==0){
				$("#xxyy").html('');
					html +="<li style='border:0px;width:830px;'><div style='margin:100px 330px 0px 0px;float:right;font-size:14px;font-weight:bold;border:0px;color:gray;cursor:pointer' onclick=\"jumpPage()\"> <img src=\"/theme/art/img/128x128.png\" width=\"120\" height=\"120\"> <br>没有照片? 我们帮你搞定! </div></li>"
					$("#xiangce_div").html(html);
			}else{
				$("#xxyy").html('<img src="/theme/art/img/128x128.png" width="20" height="20"> 没有拿得出手的照片? 我们帮你搞定-> ');
				for(var i = 0; i < d.length; i++) {
					var obj = d[i];
					
					if(type == 1) {
						html +="<li><img onclick='openXiangce("+obj.id+")' onerror='handleImgLoadError2(event);' src='"+obj.url+"' width='140' height='140' /><h6 >"+obj.title+"</h6><h6 style='margin:0 auto'><a href='javascript:toUpdateArt(1,"+obj.id+");' class='bianji'>编辑</a><a href='javascript:toDelArt("+obj.id+",1);' class='bianji'>删除</a></h6></li>"
					}
					if(type == 1) {
						$("#xiangce_div").html("");
						
					} 
					$("#xiangce_div").html(html);
					$(document.body).height($("#main_content").height() + 350);
				}
			}
			}
	});
}


</script>
  </head>
  <body  style="background: #ffffff;">
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>

<div style="height:auto !important; width:100%; margin:0;overflow:hidden;" id="main_content">

 <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tbody><tr>
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


<!-- 导航 结束 -->

<div class="right_tab">
<ul>
<li><a href="orginfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>

<li><a  class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（相册）</a></li>
<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（视频）</a></li>

<li><a href="<%=request.getContextPath() %>/member/artInfo!toZhaoPin.htm?<%=HttpSessionHelper.getParamData(request)%>">招聘信息</a></li>
<!-- <li><a href="orginfo.htm?sign=4&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li> -->
</ul>
</div>
<!-- 基础信息 开始 -->
<div id="TabTab03Con">

<div class="zuopin">

<div class="zuopin_bt">
<a href="#" class="chuang"  onclick='openXiangce(0)' >上传照片</a>
<a href="javaScript:toAddArt(1);">创建相册</a>
<div style="float:right;font-size:14px;font-weight:bold;color:gray;cursor:pointer" onclick="jumpPage()" id='xxyy'> </div>
</div>

<SCRIPT LANGUAGE="JavaScript">
	function jumpPage(){
		window.open("http://192.168.1.100/index/banner!topic.htm");
	}
</SCRIPT>
<div class="zuopin_cont">
<ul id="xiangce_div">
</ul>
</div>



<!--
<div class="fenlei">
<ul>
<li>

<a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=8" class="pre"></a>
<a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=8">1</a>
<a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=8">2</a>
<a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=8">3</a>
<a href="<%=request.getContextPath() %>/member/userinfo.htm?sign=8" class="next"></a>

</li>
</ul>
</div>
-->
</div>

<div>


</div>


</div>
</td>

</tr>
</tbody></table>
<!-- 主内容结束 -->













<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>
<!-- 底部结束 --> 




  </body>
</html>