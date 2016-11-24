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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
   <!--- ------artinfo\imageView.jsp -->
    
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css">


	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/43!register.css" />

	

	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js/main.js"></script>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" id="pagestyle"/>	

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>

 
 
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/followButton.css">

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/login.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">


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
<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>



 	
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/my_kindeditor-all.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/my_zh_CN.js"></script>


 	

	<style type="text/css" media="screen">
#pages ul li{width:780px;}
		html, body { height:auto !important;background-color: #f5f5f5;}
		#flashContent { width:100%; height:100%; }
a.bianji {
font: normal 12px/24px "微软雅黑";
display: block;
float: left;
color: #395AD8;
margin-right: 15px;
line-height:25px;
height:25px;
}		
 

.shangchuang_cont ul li {
	height: auto;
}

	</style>
	
<script type="text/javascript">
      
function mydialogCallback(){
		window.top.location.reload();
}

$(document).ready(function(){
		getUserArtList(1,<%=request.getParameter("id")%>);	
});

function toAddArt(sign){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign+'&<%=HttpSessionHelper.getParamData(request)%>',{width:650,height:450,resize:false,lock:true ,close: 
		function () {
			getUserArtList(1,0);	
		}});
}
function handleImgLoadError2(oEvent) {
	oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
}

function toUpdateImg(id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateImgInfo.htm?id='+id,{width:600,height:300,resize:false,lock:true ,close: 
		function () {
			getUserArt3(0,1,0,16);
		}});
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


//获取用户才艺（相册视频音频）
function getUserArt3(xiangCeId,currentPage,begin,length) {  
	//length = 1;
	if(xiangCeId==0){
		xiangCeId = $("#selectOptions").val();
	}
	
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserImgListByArtId.htm?currentPage="+currentPage+"&length="+length+"&begin="+begin+"&artId="+xiangCeId+"&<%=HttpSessionHelper.getParamData(request)%>&type=1",
		type:'POST',
		dataType:'json',  
		success:function(data){
 
			$("#xiangce_div").html("");
			var total = data.total;
			var currentPage = parseInt(data.currentPage);
			
			
			var d = eval(data.lists);
	

			var html = "";
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				var title = "";
				if(obj.title){
					title = obj.title;
				}

					html +="<li><img   src='"+obj.url+"' width='140' height='140' /><h6 style='text-align:center;font-size:12px;font-weight:normal'>"+title+"</h6><div style='width:100%;height:auto;'>";
					html +="<a href='javascript:setUpImg("+obj.id+");' class='bianji'>设置为相册封面</a></div><div style='float:left;width:140px;margin:auto;text-align:center;'>";
					html +="<a href='javascript:toUpdateImg("+obj.id+");' class='bianji'>编辑</a><a href='javascript:delImg("+obj.id+");' class='bianji'>删除</a></div></li>"
					$("#xiangce_div").html("");
					$("#xiangce_div").html(html);
					//$(document.body).height($("#main_content").height() + 350);
				}
			


			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			
			var pagesCont = "<ul><li>";
			if(currentPage>1){
				pagesCont += "<a class='pre' href='javascript:getUserArt3("+xiangCeId+","+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+")'></a>";
			}
			if(pages>1){
				for(var i=1;i<=pages;i++){
					pagesCont += "<a href='javascript:getUserArt3("+xiangCeId+","+i+","+((i-1)*pageLength)+","+pageLength+")'>"+i+"</a>";
				}
			}
			if(currentPage<pages){
				pagesCont += "<a class='next' href='javascript:getUserArt3("+xiangCeId+", "+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+")'></a>";
			}				 
			
			$("#pages").html(pagesCont+"</li></ul>"); 
 
		}
	});
}


function toUpdateArt(sign,id){
	art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&<%=HttpSessionHelper.getParamData(request)%>&sign='+sign,{width:650,height:450,lock:true,resize: false,close: 
		function () {
			getUserArt3(0,1,0,16);
		}});
}

function delImg(id){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/artInfo!delImg.htm?id='+id,
			function(data){
				if(data=="1"){
					getUserArt3(0,1,0,16);
				}
			},"html");
		},
		cancel: true
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
					getUserArt3(0,1,0,16);
				}
			},"html");
		},
		cancel: true
	});
}



//获取用户才艺（相册视频音频）
function getUserArtList(type,xiangCeId) {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserArtList1.htm?<%=HttpSessionHelper.getParamData(request)%>&type=" + type,
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			
			var html = "";
			
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				
				if(type == 1) {
					var needCheck = "";
					if(xiangCeId==obj.id){
							needCheck = "selected='selected'";
					}
					html +="<option value='"+obj.id+"' "+needCheck+">"+obj.title+"</option>";
				}
				$("#selectOptions").html(html);
			}
			getUserArt3(xiangCeId,1,0,16);
		}
	});
}




var editor = null;
KindEditor.ready(function(K) {
				var val = $("#selectOptions").val();
				editor = K.editor({
					uploadJson : '<%=request.getContextPath()%>/servlet/Upload?id='+val+'&userId=<%=userSession.getId()%>',
					allowFileManager : true,
					imageUploadLimit:10
					//,queueSizeLimit:1
					//,afterChange: function() {					}
					//,afterUpload: function() {					}
				});
				K('#J_selectImage').click(function() {
					if($("#selectOptions").val()==null){
						art.dialog.alert("请先创建相册");
						return; 
					}
					editor.uploadJson = '<%=request.getContextPath()%>/servlet/Upload?id='+$("#selectOptions").val()+'&userId=<%=userSession.getId()%>';

					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							//插入
							clickFn : function(urlList) {
								
								var div = K('#J_imageView');
								div.html('');
								K.each(urlList, function(i, data) {
									//alert(data.url );
									//$("#pic002").attr("src", data.url +"?date=" + new Date().getTime());

									div.append('<img src="' + data.url + '">');
								});
								editor.hideDialog();
							}
						});
					});
				});
			});

		

	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	function toAdd(sign){
		art.dialog.open('<%=request.getContextPath()%>/page/imgUp.jsp?sign='+sign,{width:744,height:533,resize: false,lock :true ,close:function(){window.top.location.reload();}});
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
							window.top.location.reload();
						}
					},"html");

					
				},
				cancel: true
		});
	
	}
	
  

 function openXiangce(){
<%if(isForOrg >= 0){%>
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>');
<%}else{%>
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>');
<%}%>



		//window.location.href ="<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id=-1&userId=<s:property value='#request.userId'/>";
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
	<li><a    class="change"href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">相册</a></li>
	<li><a   href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>">视频</a></li>
	<li><a href="orginfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li>
<%}else if(isForOrg >= 0){%>
	<li><a href="orginfo.htm?sign=1">基本信息</a></li>
	<li><a  class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=5&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（相册）</a></li>
	<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>" id="font2" >相关作品（视频）</a></li>
	<li><a href="<%=request.getContextPath() %>/member/artInfo!toZhaoPin.htm?<%=HttpSessionHelper.getParamData(request)%>">招聘信息</a></li>
	<li><a   href="orginfo.htm?sign=4&<%=HttpSessionHelper.getParamData(request)%>">绑定支付宝</a></li>
<%}else{
	//机构下的艺人
	%>
	<li><a href="<%=request.getContextPath() %>/member/orginfo!toAddUser.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">基本信息</a></li>
	<li><a class="change"  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">相册</a></li>
	<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&<%=HttpSessionHelper.getParamData(request)%>">视频</a></li>
<%}%>


</ul>
</div>
<!-- 基础信息 开始 -->
<div id="TabTab03Con">

<div class="zuopin">

<div class="shangchuang">
<span>上传到：</span>
<select class="shangchuang_ming" id="selectOptions" onchange="getUserArt3(0,1,0,16)">
</select>
<a href="javaScript:toAddArt(1);">新建相册</a>
</div>





<div class="shangchuang_cont">
<ul id="xiangce_div">
</ul>


</div>
<div class="shangchuang_cont" >
<div class="fenlei" id="pages" style="width:700px"></div>
</div>

<div class="shangchuang_icon">
<!-- <a href="#" class="chuang">开始上传</a>-->
<a   style="cursor: pointer;color:white;"  class="chuang"  id="J_selectImage">继续上传</a>
<a   style="cursor: pointer;color:black;"  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&<%=HttpSessionHelper.getParamData(request)%>">返回相册首页</a>

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