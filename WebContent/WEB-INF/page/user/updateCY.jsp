<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor-all-min.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.js"></script>

<style> 
body,div,ul,li,p{margin:0;padding:0;}
body{color:#666;font:12px/1.5 Arial;}
ul{list-style-type:none;}

</style>
	<script type="text/javascript">
	 $().ready(function(){
	 	var flag = '<s:property value="#request.flag"/>';	
	 	if(flag==4){
	 		document.getElementById("TabTab03Con1").style.display="";
	 	}else if(flag==1){
	 		document.getElementById("TabTab03Con2").style.display="";
	 	}else if(flag==2||flag==3){
	 		document.getElementById("TabTab03Con3").style.display="";
	 	}

	 });
	var isSubmit = false;
	function doSubmit(){ 
		            //执行SUBMIT  
		            $("#infoForm").submit();
		           //form.submit();  
		        
			  
			   //刷新父页面
//	 		   parent.location.href=parent.document.location;
			   //关闭当前页面
	 		   //art.dialog.close();

	}

	function checknull(){
	    var menuName =document.getElementById("purl").value;
	    if(menuName==""){
			alert("【图片路径】不能为空！");
			return false;
		}
		return true;    
	}
	//本地预览
	function readURL(input) {
		
	    var strSrc = $("#purl").val();

	    //验证上传文件格式是否正确  
	    var pos = strSrc.lastIndexOf(".");
	    var lastname = strSrc.substring(pos, strSrc.length);
	    if (lastname.toLowerCase() != ".jpg") {
	        alert("您上传的文件类型为" + lastname + "，图片必须为 JPG 类型");
	        return false;
	    }

	    //验证上传文件是否超出了大小  
	    if (input.files[0].size / 1024 > 1024) {
	        alert("您上传的文件大小超出了1M限制！");
	        return false;
	    }
		

	    if (input.files && input.files[0]) {
	        var reader = new FileReader();


	        reader.onload = function (e) {
	            $('#showImg').attr('src', e.target.result);
	        };

	        reader.readAsDataURL(input.files[0]);
	        if($('#showImg').hide()){
	        	$('#showImg').show();
	        }
	    }
	}
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images2/userBigImage.jpg';
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
		
		function doSubmit1(){
			var isSubmit1 = "true";
			var title =$("#artInfo\\.title").val();
			var urlStr =$("#artInfo\\.url").val();
			if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能为空！");
				isSubmit1 = "false";
			}if(urlStr==""){
				$("#yzxx").text("");
				$("#yzxx").append("【URL】不能为空！");
				isSubmit1 ="false";
			}
			if(isSubmit1=="true"){
				//获取浏览器参数  
					var form = $(document.getElementById('artInfoForm'));
                   //获取浏览器参数
                    var browserName = navigator.userAgent.toLowerCase();

		                //执行SUBMIT  
		                //form.submit();   
			             $.ajax({
						   url:"<%=request.getContextPath() %>/member/artInfo!saveOrUpdateArtInfo.htm?id="+${artId}+"&sign="+${artType},
						   type:'POST',
						   data:$("#artInfoForm").serialize(),
						   success:function(data){
							   if(data=="1"){
										//if(${artInfo.userId}!=0){
											//window.parent.frames[1].location.reload();
										//}else{
											//window.parent.location.reload();
										//}
								   		//
									art.dialog.close();
							   }
						   }
						});
			}
			
			
		}
	
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		}
		
		function openTudou() {
			window.open("<%=request.getContextPath() %>/tudou/tudou.jsp","_blank");	
		}
		function toDelImgs(){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/artInfo!delArtInfo.htm?id=<s:property value="#request.id"/>',
						function(data){
							if(data=="1"){
							//art.dialog.tips("删除成功!");
							art.dialog.close();
						}
					},"html");

					
				},
				cancel: true
		});
		
	}
	 function toDel1(id){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/artInfo!delArtInfo.htm?id='+id,
						function(data){
							if(data=="1"){
							//art.dialog.tips("删除成功!");
							//window.location.reload();
							art.dialog.close();
						}
					},"html");

					
				},
				cancel: true
		});
		
	}
	</script>
  </head>
  <body>
	<!-- 标签页 内容一 -->
  <div id="TabTab03Con1" class="zndx_box01" style="display: none;"> 
  <form id="infoForm" name="infoForm" action="member/artInfo!addIndex1.htm?userId=${id}" method="post" enctype="multipart/form-data">
  <input type="hidden" name="oldURL" id="oldURL" value="${vo.url}"/>
  <input type="hidden" name="aid" id="aid" value="${vo.id}"/>
  	<div>
  		<img style="margin-top: 20px;" onerror="handleImgLoadError(event)" id="showImg" name="showImg" src="<%=request.getContextPath() %>/${vo.url}" width="672" height="292"/>
  	</div>
  	<div style="margin-top: 20px">
  		更换新图片(672x292像素)：&nbsp;<input type="file" id="purl" name="purl" style="width: 500px;" onchange="readURL(this)"/>&nbsp;
  	</div>
  	<div style="margin-top: 20px;">
  		<a href="javascript:doSubmit();"><img  src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
  	</div>
  	</form>
</div>

<!-- 主内容结束 -->
 <div id="TabTab03Con2" class="zndx_box01" style="display: none;">
 <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="800" border="0" align="left" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:0px;">
    <tr>
        <td height="24" align="left"><!-- <a href="javaScript:toAdd('<s:property value="#request.xcId"/>');"  >--><img id="J_selectImage" src="<%=request.getContextPath()%>/theme/images/add_phtoto02.jpg" width="90" height="30" /></td>
    	<td valign="top">
    		<input type="button" value="删除相册" onclick="toDelImgs()"/>
    	</td>
    
    </tr>
</table>

<div class="xiangce_list">
<ul>
 <s:iterator value="#request.lists" var="list">
<li><div class="xc_div"><a href="#"><img onclick="view(this)" onerror="handleImgLoadError(event);" onload="AutoSize(this,140,140)" src="<s:property value="#list.url"/>" /></a></div>
<p><div class="xiangce_name"><a href="javascript:toDel('<s:property value="#list.id"/>');" class="czjl_title_link">删除</a></div>
<a href="javascript:setUpImg('<s:property value="#list.id"/>');"><font style="color:#999;">设为封面</font></a></p>
</li>
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
<div id="TabTab03Con3" style="display: none;">
	
	<form id="artInfoForm" name="artInfoForm" action="member/artInfo!saveOrUpdateArtInfo.htm?id=${artInfo.userId}&sign=${artInfo.type }" method="post">
	<input type="hidden" name="artInfo.id" value="${artInfo.id }"/> 
	<input type="hidden" name="artInfo.userId" value="${artInfo.userId }"/> 
	<input type="hidden" name="artInfo.type" value="${artInfo.type }"/> 
	<input type="hidden" name="artInfo.imgCount" value="${artInfo.imgCount }"/> 
	<table width="100%">
		<tr>
			<td>
				<embed src="${swf}" quality="high" width="560" height="480" align="middle" allowNetworking="all" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
				<div style="width: 560px;color: #ff0000;font-weight: bold;">如果视频无法显示，请检查视频地址是否正确！</div>
			</td>
			<td>
				<table width="330" border="0" align="center" cellpadding="0" cellspacing="0" >
				    <tr>
				        <td height="350" bgcolor="#FFFFFF">
				        <!-- 弹出框内容 开始 -->
				        <div class="add_table_box">
				        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
				            <tr>
				                <td height="18">才艺信息</td>
				            </tr>
				        </table>
				          <%String sign = (String)request.getParameter("flag");%>
				        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
				           <% if(!sign.equals("1")){%>
				           <tr>
				           <td></td>
					           <td style="color: red;line-height: 22px" colspan="3">
					           	1、在优酷视频网站上传视频<br/>
								2、将上传视频播放网页的URL（IE等浏览器中的地址）复制到本页的URL中<br/><b>土豆请复制播放器地址</b><br/>（<a style="color:red;" href="javascript:openTudou()">复制说明</a>）点击复制说明可以提供详细说明<br/>
								3、增加标题与简介<br/>
					           
					           </td>
				           </tr>
				            <%} %>
						    <tr>
						        <td  align="right"><font color=red>*</font>标题 </td>
						        <td colspan="3" >
						       
						        <input type="text" name="artInfo.title" id="artInfo.title" value="${artInfo.title }" style="width:370px;"  class="add_popup_input" /></td>
						    </tr>
						  
						    <% if(!sign.equals("1")){%>
						     <tr>
						        <td  align="right"><font color=red>*</font>URL </td>
						        <td colspan="3" >
						       
						        <input type="text" name="artInfo.url" id="artInfo.url" value="${artInfo.url }" style="width:370px;"  class="add_popup_input" /></td>
						    </tr>
						    <%} %>
						    
						    <tr>
						        <td align="right">简介</td>
						        <td colspan="3"><textarea name="artInfo.intro" id="artInfo.intro" cols="45" rows="5" class="add_popup_textarea ">${artInfo.intro }</textarea></td>
						    </tr>
						     
						    <tr>
						       <td align="right"></td>
						       <td colspan="3" style="color:#F00;" id="yzxx"></td>
						     </tr>
						    <tr>
						        <td colspan="4" align="center">
						        <a href="javascript:doSubmit1();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
						        <a href="javascript:CloseWin();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
						          <% if(!sign.equals("1")){%>
						     <input type="button" value="删除该视频/音频" onclick="toDel1(${artInfo.id })" />
						    <%} %>
						        </td>
						        </tr>
						</table>
			</td>
		</tr>
	</table>
	

        </div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
</form>
</div>
  </body>
</html>