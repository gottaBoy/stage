<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragrma","no-cache");
response.setDateHeader("Expires",0);
%>

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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript">
		function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	function doSubmit(){

	    if(!checkFileName())return;
	    if($("#userInfo\\.idCard").val()==""){
	    
	    art.dialog({
		    content: '请输入身份证号码',
		    lock: true
		 });
	    return;
	    }
		$("#realNameForm").submit();
	}
	
	function view(obj){
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+obj.src+'" />',
		    lock: true
		});
	}
	
	 function checkFileName() {
     var okText = /png|jpg|gif/i;//这里是允许的扩展名
     var filename = $("#myFile").val();//得到当前file文件域的值
     var newFileName = filename.split('.'); //这是将文件名以点分开,因为后缀肯定是以点什么结尾的.
     newFileName = newFileName[newFileName.length-1];//这个是得到文件后缀,因为split后是一个数组所以最后的那个数组就是文件的后缀名.newFileName.length为当前的长度，-1则为后缀的位置，因为是从0开始的
     //开始检查后缀
     if (newFileName.search(okText) == -1) {//search如果没有刚返回-1.这个如果newFileName在okText里没有,则为不允许上传的类型. .
         var err=okText.toString();//将正则转为字符
         var errText=err.replace(/^\/|\/+(.*)/g,"");//用正则替换 / 开头和 /i结束
         var errText=errText.replace(/\|/g,",");//用正则把 | 替换成 ,
         
         art.dialog({
		    content: '请上传为'+errText+'的文件',
		    lock: true
		 });
		// $("#myFile").val("");
		// alert();
         return false;
     }
	return true;
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
        <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="13"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">企业信息</a></div>

<div class="right_tab">
<ul>
<li><a href="orginfo.htm?sign=1">基本信息</a></li>
<li><a class="change"  href="orginfo.htm?sign=2">企业认证</a></li>
<li><a href="orginfo.htm?sign=3">头像修改</a></li>
</ul>
</div>
<span class="clear"></span>
<!-- 实名认证 开始 -->
<div id=TabTab03Con>

<form id="realNameForm" name="realNameForm" action="userinfo!saveRealName.htm?type=org" method="post" enctype="multipart/form-data">


<table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="smrz_table">
<tr>
        <td colspan="2" height="15"></td>
    </tr>    

<tr>
        <td width="22" align="left"><img  src="<%=request.getContextPath() %>/theme/images/star.jpg" width="15" height="15" /></td>
        <td width="478">申请成为<span>第1舞台认证会员</span>，获得更多机会。</td>
    </tr>
</table>
<s:if test="#request.user.rzState!=3">
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="rznr_box">
    <tr>
        <td colspan="2" align="left">上传营业执照<span>(必传)</span></td>
        <td rowspan="6" align="left">
    <div  class="xc_div"><img onerror="handleImgLoadError(event);" onclick="view(this)" src="/stageUpload/idCard/<s:property value="#request.userInfo.idCardCopy"/>?id=<%=new Date() %>" style="max-width: 140px;max-height: 140px;"/></div>

        </td>
        </tr>
    <tr>
        <td colspan="2" width="294" align="left"><s:file onChange="checkFileName()" style="width:288px;height:27px;" name="myFile"></s:file></td>
    </tr>
    <tr>
        <td colspan="2" align="left" style="height:10px;"></td>
        </tr>
    <tr>
        <td colspan="2" align="left">营业执照号码<span>(必填且必须与提交的营业执照号码一致)</span></td>
        </tr>
    <tr>
        <td colspan="2" align="left"><input type="text" name="userInfo.idCard" id="userInfo.idCard" class="id_input" /></td>
        </tr>
    <tr>
        <td colspan="2" align="left" class="save_02"><a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/save.jpg" width="115" height="40" /></a></td>
        </tr>
</table>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="rz_smtext">
    <tr>
        <td><span>特别注意：</span></td>
    </tr>
    <tr>
        <td><img src="<%=request.getContextPath() %>/theme/images/small_star.jpg" width="10" height="10" />&nbsp;营业执照用相机拍下来，照片清晰无遮挡。</td>
    </tr>
    <tr>
        <td><img src="<%=request.getContextPath() %>/theme/images/small_star.jpg" width="10" height="10" />&nbsp;您的证件仅在审核人员审核时可以看见，第1舞台严格保护您的隐私，请放心。</td>
    </tr>
</table>
</s:if>
<s:if test="#request.user.rzState==3">
<table width="230" border="0" align="center" cellpadding="0" cellspacing="0" class="rz_smtext">
    <tr>
        <td><img onerror="handleImgLoadError(event);" onclick="view(this)" style="max-width: 150px;max-height: 150px;" src="/stageUpload/idCard/<s:property value="#request.userInfo.idCardCopy" />?id=<%=new Date() %>"/></td>
    </tr>
</table>

</s:if>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="smrz_table">
    <tr>
        <td colspan="1"  width="22" align="left"><a href="#"><img  src="<%=request.getContextPath() %>/theme/images/rzxx_0<s:property value="#request.user.rzState" />.jpg?id=<%=new Date() %>" width="410" height="110" /></a></td>
       
    </tr>
</table>

</form>                        
</div>


</td>
</tr>
</table>

<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>