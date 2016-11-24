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
        <!---------user\shipin.jsp    -->
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

 		html, body { height:auto !important; background-color: #ffffff;}
		#flashContent { width:100%; height:100%; }
	</style>
	
<script type="text/javascript">
      

$(document).ready(function(){
		getUserArt(2,1,0,15); 
});
 

function saveCookie(id){
	$.cookie("tempClickType", id);
}
 
 	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
  
//分享页面
function userShare(wzd){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo!toUserShare.htm?wzd='+wzd,{lock:true,resize: false,fixed:true});
}
 
//获取用户才艺（相册视频音频）
function getUserArt(type,currentPage,begin,length) {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserArtList.htm?currentPage="+currentPage+"&length="+length+"&begin="+begin+"&type="+type,
		type:'POST',
		dataType:'json',  
		success:function(data){
			var total = data.total;
			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);
			var htmls = "<ul>";
			
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				htmls += "<li style='text-align:center;width:200px;height:170px;'>";
				var imgTemp = obj.img;
				if(obj.img){
					imgTemp = obj.img;
				}else{
					imgTemp = obj.attachment;
				}
				htmls += "<a href='javaScript:openMovie(\""+obj.attachment+"\",2);' class='czjl_title_link' style='cursor:hand'><img src='"+imgTemp+"'  style='text-align:center;width:198px;height:108px;'/></a>";
				
				if(obj.title){
					htmls += "<h6><a href='javaScript:openMovie(\""+obj.attachment+"\",2);' class='czjl_title_link' style='cursor:hand'>"+obj.title+"</a></h6>";
				}
				if(obj.intro){
					htmls += "<p>"+obj.intro+"</p>";
				}

				htmls += "<a href='javaScript:toUpdateArt(2,"+obj.id+");' class='czjl_title_link'>修改</a>&nbsp;";
				htmls += "<a href='javascript:toDelArt("+obj.id+",2);' class='czjl_title_link'>删除</a>";
				htmls += "</li>";			    
			}
			htmls += "</ul>";
			$("#zuopin_cont_id").empty("");
			$("#zuopin_cont_id").append(htmls);
			var pageLength = 15.0;
			var pages = Math.ceil(total/pageLength);
			
			var pagesCont = "<ul><li>";
			if(currentPage>1){
				pagesCont += "<a class='pre' href='javascript:getUserArt(2,"+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+")'></a>";
			}
			if(pages>1){
				for(var i=1;i<=pages;i++){
					pagesCont += "<a href='javascript:getUserArt(2,"+i+","+((i-1)*pageLength)+","+pageLength+")'>"+i+"</a>";
				}
			}
			if(currentPage<pages){
				pagesCont += "<a class='next' href='javascript:getUserArt(2, "+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+")'></a>";
			}				 
			
			$("#pages").html(pagesCont+"</li></ul>"); 
			 
			//getUserInfo1();
		   //$(document.body).height($("#main_content").height() + 350);
		}
	});
}

function toDelArt(id, type){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/artInfo!delArtInfo.htm?id='+id,
			function(data){
				if(data=="1"){
					getUserArt(type,1,0,15);
				}
			},"html");
		},
		cancel: true
	});
}
 /*
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/temp/photo.jpg';
  	 }
*/


function openMovie(swfurl, type){
	var title = "";
	if(type == 2) {
		title = "视频播放";
	} else {
		title = "音频播放";
	}
	if(swfurl != ''){
		art.dialog({
			padding: 0,
			title: title,
			lock: true,
			content: "<embed src=\""+swfurl+"\" quality=\"high\" width=\"560\" height=\"480\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"
		});
	}
}
/*
var flashvars = {
	"uploadServerUrl":"./userinfo!upLoadIndexHeadImage.htm"
};
var params = {
	wmode:"opaque",
	width:700,
	height:600,
	type:"application/x-shockwave-flash"	
};
var attributes = {
	
};

swfobject.embedSWF("../theme/flex/indexHeadImage.swf", "altContent", "600", "500", "9.0.0", "expressInstall.swf", flashvars, params, attributes);
 */
 
function toAddArt(sign){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign,{width:750,height:450,resize:false,lock:true,close: 
		function () {
			getUserArt(2,1,0,15); 
		}});
}
 
 function toUpdateArt(sign,id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&sign='+sign,{width:750,height:450,lock:true,resize: false,close: 
		function () {
			getUserArt(2,1,0,15); 
		}});
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


		<%if(isIndividual ==0){%>
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="1"></s:param>
        </s:action>		
		<%}else  if(isForOrg >= 0){%>
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="13"></s:param>
        </s:action>
		<%}else{%>
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="14"></s:param>
        </s:action>
		<%}%>

       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">


<!-- 导航 结束 -->

<div class="right_tab">
<ul>

<%if(isIndividual ==0){%>
	<li><a href="<%=request.getContextPath() %>/member/userinfo.htm?<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>
	<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">相册</a></li>
	<li><a   class="change"  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>">视频</a></li>
<!-- 	<li><a href="orginfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li> -->
<%}else if(isForOrg >= 0){%>
	<li><a href="orginfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>
	<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（相册）</a></li>
	<li><a  class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（视频）</a></li>
	<li><a href="<%=request.getContextPath() %>/member/artInfo!toZhaoPin.htm?<%=HttpSessionHelper.getParamData(request)%>">招聘信息</a></li>
<!-- 	<li><a   href="orginfo.htm?sign=4&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li> -->
<%}else{
	//机构下的艺人
	%>
	<li><a href="<%=request.getContextPath() %>/member/orginfo!toAddUser.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>
	<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">相册</a></li>
	<li><a class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>">视频</a></li>
<%}%>



</ul>
</div>
<!-- 基础信息 开始 -->
<div id="TabTab03Con">

<div class="zuopin">

<div class="zuopin_bt">
<a href="javascript:toAddArt(2);" class="chuang">上传视频</a>

</div>

<div class="zuopin_cont" id="zuopin_cont_id" >
</div>

<div class="fenlei" id="pages">

</div>




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