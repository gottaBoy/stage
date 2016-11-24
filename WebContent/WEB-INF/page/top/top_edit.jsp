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
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/jquery.autocomplete.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.autocomplete.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
			<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/menuService.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.js"></script>
	<script type="text/javascript">
	
	function toAdd(){
		art.dialog.open('<%=request.getContextPath()%>/member/information!toInfo.htm',{width:750,height:600,resize: false});
	}
	function toEdit(id){
		art.dialog.open('<%=request.getContextPath()%>/member/information!toInfo.htm?id='+id,{width:750,height:600,resize: false});
	}
	function toView(id){
		art.dialog.open('<%=request.getContextPath()%>/member/information!toViewInfo.htm?id='+id,{width:750,height:600,resize: false});
	}
	function toDel(id){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/information!delInfo.htm?id='+id,
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
	
	var afterMethod = function (){
	}
	$(document).ready(function(){
		
		dyncSearchToolkit.initial("","160px");//下拉框提示初始化
		bindQueryToolkit(document.getElementById("username"),
				{url:'<%=request.getContextPath()%>/member/top!doUserIndex.htm',
			afterCall:afterMethod,labelField:"username",hiddenValueObj:document.getElementById("info.userId")});	
	});
	
</script>		

<style>
.b{
	padding-left:18px; }
.b1{
	padding-left:18px;
   color:#999999 }

</style>
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
        	<s:param name="menuFlag" value="25"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a href="#">首页</a> > <a href="#">添加推广</a></div>

<script type="text/javascript">
var editor;
KindEditor.ready(function(K) {
	editor = K.create('textarea[name="info.content"]', {
		cssPath : '<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css',
		uploadJson : '<%=request.getContextPath() %>/theme/kindeditor/jsp/upload_json.jsp',
		fileManagerJson : '<%=request.getContextPath() %>/theme/kindeditor/jsp/file_manager_json.jsp',
		allowFileManager : true,
		afterCreate : function() {
			var self = this;
			K.ctrl(document, 13, function() {
				self.sync();
				document.forms['infoForm'].submit();
			});
			K.ctrl(self.edit.doc, 13, function() {
				self.sync();
				document.forms['infoForm'].submit();
			});
		}
	});
		
	prettyPrint();
});

var isSubmit = false;
function doSubmit(){ 
	if(checknull()){

		if(!isSubmit){ 
    	   isSubmit = true;   
    	   var form = $(document.getElementById('infoForm'));
	        //获取浏览器参数
	        var browserName = navigator.userAgent.toLowerCase();
	        if (/chrome/i.test(browserName) && /webkit/i.test(browserName) && /mozilla/i.test(browserName)) {
	        //chrome浏览器
	        var tmp = form.attr('action');
	            $.post(tmp, form.serialize());
	        }else {
	            //执行SUBMIT  
	           form.submit();   
	    	} 	
		 // $("#infoForm").submit();
		   //刷新父页面
// 		   parent.location.href=parent.document.location;
		   //关闭当前页面
// 		   art.dialog.close();
  	   } 
    }  
}

function checknull(){
//     var menuName =document.getElementById("turl").value;
//     if(menuName==""){
// 		alert("【图片路径】不能为空！");
// 		return false;
// 	}
	
// 	var title =document.getElementById("info.title").value;
//     if(title==""){
//     	alert("【标题】不能为空！");
// 		return false;
// 	}
	return true;
}
function CloseWin() 
{ 
	window.location.href="<%=request.getContextPath()%>/member/top.htm";
} 

//本地预览
function readURL(input,flag) {
    var strSrc = $(input).val();
    var _showImg = document.getElementById(flag);
    _showImg = $(_showImg);
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
        	_showImg.attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
        if(_showImg.hide()){
        	_showImg.show();
        }
    }
}

</script>
<span class="clear"></span>
<div style="padding-top:15px; ">
<form id="infoForm" name="infoForm" action="member/top!doUpdateTop.htm" method="post" enctype="multipart/form-data">
<input type="hidden" value="${vo.tid}" id="vo.tid" name="vo.tid"/>
<input type="hidden" value="${vo.imgs[1].tid}" id="imgs2.tid" name="imgs2.tid"/>
<input type="hidden" value="${vo.imgs[0].tid}" id="imgs1.tid" name="imgs1.tid"/>
<input type="hidden" value="${vo.imgs[1].turl}" id="imgs2.turl" name="imgs2.turl"/>
<input type="hidden" value="${vo.imgs[0].turl}" id="imgs1.turl" name="imgs1.turl"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="50%" height="70"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>&nbsp;名称
        <input class="input_xl" type="text" value="${vo.name}" name="vo.name" id="vo.name"  style="width:300px; height:25px ;">     </td>
    <td width="50%"style="color:#999999; "><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>小编点评</td>
  </tr>
  <tr>
    <td><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>&nbsp;昵称/艺名
        <input class="input_xl" type="text" value="${vo.userid.nickName}" name="username" id="username" style="width:300px; height:25px ;">
        <input type="hidden" id="info.userId" name="info.userId" value="${vo.userid.userId}"/>
    </td>
    <td height="100"><textarea name="vo.comment" id="vo.comment" style="width:300px; height:80px; ">${vo.comment}</textarea></td>
  </tr>
  <tr>
    <td height="20"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>第一图片</td>
    <td height="20"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>第二图片</td>
  </tr>
  <tr>
    <td class="b" height="40"><input type="file" onchange="readURL(this,'showImg1')" name="turl1" id="turl1" style="width:300px; height:25px ;"></td>
    <td><input class="input_xl" id="turl2" onchange="readURL(this,'showImg2')" type="file" name="turl2" style="width:300px; height:25px ;"></td>
  </tr>
  <tr>
    <td height="320" class="b"><img src="<%=request.getContextPath() %>/${vo.imgs[0].turl}" width="236" height="312" name="showImg1" id="showImg1"/></td>
    <td><img src="<%=request.getContextPath() %>/${vo.imgs[1].turl}" width="236" height="312" id="showImg2"/></td>
  </tr>
  <tr>
    <td height="40"><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>&nbsp;图片描述 
      <input class="input_xl" value="${vo.imgs[0].tmemo}" type="text" name="imgs1.tmemo" id="imgs1.tmemo" style="width:300px; height:25px ;">  </td>
    <td><img src="<%=request.getContextPath() %>/theme/images2/circle.png"/>&nbsp;图片描述 
      <input value="${vo.imgs[1].tmemo}" class="input_xl" type="text" name="imgs2.tmemo" id="imgs2.tmemo" style="width:300px; height:25px ;">  </td>
  </tr>
  <tr>
    <td height="35" class="b">链&nbsp;&nbsp;接：
      <input class="input_xl" type="text" value="${vo.imgs[0].tlink}" name="imgs1.tlink" id="imgs1.tlink" style="width:300px; height:25px ;"></td>
    <td class="b">链&nbsp;&nbsp;接：
      <input class="input_xl" value="${vo.imgs[1].tlink}" type="text" name="imgs2.tlink" id="imgs2.tlink" style="width:300px; height:25px ;"></td>
  </tr>
  <tr>
    <td height="41">&nbsp;</td>
    <td><div style="float:left; margin-right:20px;  "><a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg"/></a></div><div><a href="javascript:CloseWin();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg"/></a></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</div>
</td>
    </tr>
</table>

</td>
</tr>
</table>


</td>
</tr>
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

  </body>
</html>