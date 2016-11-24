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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
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
</script>	
<style>
#b a{
	display:block;
	background: url(images/b-down.png) 0 0 no-repeat;
	width:106px;
	height:27px;
	text-decoration:none;
	text-align:center;
}
#b a:hover{ 
	background: url(images/b-up.png) 0 0 no-repeat;
	color:#444444;
	background-color:inherit;
}
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
        	<s:param name="menuFlag" value="24"></s:param>
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


var editor2;
KindEditor.ready(function(K) {
	editor2 = K.create('textarea[name="info.purl"]', {
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
		   document.getElementById("info.content").value=editor.html(); 
		   document.getElementById("info.purl").value=editor2.html(); 
    	   isSubmit = true;   
    	   var form = $(document.getElementById('infoForm'));
	        //获取浏览器参数
	        var browserName = navigator.userAgent.toLowerCase();
	       // if (/chrome/i.test(browserName) && /webkit/i.test(browserName) && /mozilla/i.test(browserName)) {
	        //chrome浏览器
	        //var tmp = form.attr('action');
	           // $.post(tmp, form.serialize());
	       // }else {
	            //执行SUBMIT  
	           form.submit();   
	    //	} 	
		 // $("#infoForm").submit();
		   //刷新父页面
// 		   parent.location.href=parent.document.location;
		   //关闭当前页面
// 		   art.dialog.close();
  	   } 
    }  
}

function checknull(){
//     var menuName =document.getElementById("purl").value;
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
	if("${type}"=="1"){
	window.location.href="<%=request.getContextPath()%>/member/poster.htm?type=${type}";
	}else{
		window.location.href="<%=request.getContextPath()%>/member/poster!paging.htm?type=${type}";
	}
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
</script>
<span class="clear"></span>
<div style="font-size: 12px;">
<input type="hidden" name="info.pid" id="info.pid" />
<form id="infoForm" name="infoForm" action="member/poster!doAdd.htm" method="post" >
<input type="hidden" id="info.pid" name="info.pid" value="${info.pid}" />
<input type="hidden" name="type" id="type"  value="${type}"/>

<div style="margin-top: 20px"><textarea name="info.purl" id="info.purl" cols="120" rows="5" style="width:700px;height:350px;visibility:hidden;">${info.purl}</textarea></div>



		地址：<input type="text" name="info.plink" id="info.plink" style="width:310px;margin-top: 20px" value="${info.plink}" class="input_xl" /><br/>
		标题：<input type="text" name="info.title" id="info.title" style="width:310px;margin-top: 20px" value="${info.title}"  class="input_xl" />
		<div style="margin-top: 20px"><textarea name="info.content" id="info.content" cols="120" rows="5" style="width:700px;height:350px;visibility:hidden;">${info.content}</textarea></div>
		<div style="margin-top: 20px;float: right;">
		<a href="javascript:doSubmit();"><img  src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
		<a href="javascript:CloseWin();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
		</div>
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