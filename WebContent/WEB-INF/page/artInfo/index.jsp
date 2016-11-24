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
	
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign='+sign+'&userId='+${user_Id},{width:550,height:380,close: function () {
				     		 location.reload();
				  		}});
	}
	function toUpdate(sign,id){
	
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toUpdateArtInfo.htm?id='+id+'&sign='+sign,{width:550,height:380,resize: false});
	}
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	var isSubmit = false;
	function doSubmit(){
		            //执行SUBMIT  
		            $("#infoForm").submit();
			  
			   //刷新父页面
//	 		   parent.location.href=parent.document.location;
			   //关闭当前页面
//	 		   art.dialog.close();

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
        	<s:param name="menuFlag" value="2"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">才艺信息</a></div>

<div class="right_tab">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=4&userId=${user_Id}" id="font1" >宣传大图</a></li>
<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=1&userId=${user_Id}" id="font2" >相册</a></li>
<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&userId=${user_Id}" id="font3" >视频</a></li>
<li><a href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=3&userId=${user_Id}" id="font4" >音频</a></li>
</ul>
</div>
<span class="clear"></span>
<!-- 标签页 内容一 -->
  <div id="TabTab03Con1" class="zndx_box01">
  <form id="infoForm" name="infoForm" action="member/artInfo!addIndex.htm?userId=${user_Id}" method="post" enctype="multipart/form-data">
  <input type="hidden" name="oldURL" id="oldURL" value="${vo.url}"/>
  <input type="hidden" name="aid" id="aid" value="${vo.id}"/>
  	<div>
  		<img style="margin-top: 20px;" onerror="handleImgLoadError(event)" id="showImg" name="showImg" 
  		src="<%=request.getContextPath() %>/${vo.url}" alt="" width="672" height="292"/>
  	</div>
  	<div style="margin-top: 20px">
  		更换新图片(672x292像素)：&nbsp;<input type="file" id="purl" name="purl" style="width: 500px;" onchange="readURL(this)"/>&nbsp;
  	</div>
  	<div style="margin-top: 20px;">
  		<a href="javascript:doSubmit();"><img  src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
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