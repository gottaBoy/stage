<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragrma","no-cache");
response.setDateHeader("Expires",0);

String saveSuccess = (String)session.getAttribute("saveSuccess");
session.removeAttribute("saveSuccess");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!--    user/real-name.jsp  <%=request.getParameter("userId")%>   -->
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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css2/zhezhao.css" />



	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript">


	<% if(saveSuccess!=null){%>
		art.dialog.confirm("提交成功，等待审核！",function () {    art.dialog.parent.reloadPage();  art.dialog.close();   },    function () {    art.dialog.close();  });
		//art.dialog.confirm("认证成功！",function () {    art.dialog.parent.reloadPage();  art.dialog.close(); },    function () {   art.dialog.close(); });
	<%}%>

	function handleImgLoadError(oEvent)	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }

	function doSubmit(){
	    if($("#userInfo\\.name").val()==""){
			art.dialog.alert('请输入真实姓名');	    
			$("#userInfo\\.name").focus();
			return;
	    }
	    if($("#userInfo\\.idCard").val()==""){
			art.dialog.alert('请输入身份证号码');	    
			$("#userInfo\\.idCard").focus();
			return;
	    }

		if(!$("#imgFile").attr("src")){
			if(!checkFileName("myFile","身份证正面照")){ 
				return;
			}
		}
		if(!$("#imgFile2").attr("src")){
			if(!checkFileName("myFile2","身份证正面头部照")){ 
				return;
			}
		}

		$("#realNameForm").submit();
		//art.dialog.alert("保存成功！");

		//art.dialog.close();
	}
	
	function view(obj){
		art.dialog({
		    padding: 20,
		    title: '图片',
		    content: '<img src="'+obj.src+'" />',
		    lock: true
		});
	}
		
	 function checkFileName(fileName,msg) {
		 var okText = /png|jpg|gif/i;//这里是允许的扩展名
		 var filename = $("#"+fileName).val();//得到当前file文件域的值
		 var newFileName = filename.split('.'); //这是将文件名以点分开,因为后缀肯定是以点什么结尾的.
		 newFileName = newFileName[newFileName.length-1];//这个是得到文件后缀,因为split后是一个数组所以最后的那个数组就是文件的后缀名.newFileName.length为当前的长度，-1则为后缀的位置，因为是从0开始的
		 //开始检查后缀
		 if (newFileName.search(okText) == -1) {//search如果没有刚返回-1.这个如果newFileName在okText里没有,则为不允许上传的类型. .
			 var err=okText.toString();//将正则转为字符
			 var errText=err.replace(/^\/|\/+(.*)/g,"");//用正则替换 / 开头和 /i结束
			 var errText=errText.replace(/\|/g,",");//用正则把 | 替换成 ,
			 
			 art.dialog.alert(msg+'，请上传为'+errText+'格式的文件');
			// $("#myFile").val("");
			// alert();
			 return false;
		 }
		return true;
	 }
	
function clearAction(){
	art.dialog.close();
}



	</script>
  </head>
  <body>
  <!-- 主内容开始 -->

<div class="zhezhao" style="height:660px;">
  <span class="zhezhaoClose" title="关闭"></span>
    
  <div class="shiming">
     <h3>实名认证</h3>
<!-- 实名认证 开始 -->
<form id="realNameForm" name="realNameForm" action="<%=request.getContextPath() %>/member/userinfo!saveRealName.htm?userId=<%=request.getParameter("userId")%>" method="post" enctype="multipart/form-data">

<div class="renzheng">    
<table>
  <tbody>
  <tr>
    <th><span style="color:red">*</span>真实姓名</th>
    <td><input id="userInfo.name" class="inw inp" name="userInfo.name" value="${userInfo.name}" size="25" type="text"><span id="txtTrueName_Tip"></span></td></tr>
    <tr>
    <th><span style="color:red">*</span>证件号码</th>
    <td><input id="userInfo.idCard" class="inw inp" name="userInfo.idCard" value="${userInfo.idCard}"  size="25" type="text"><span id="txtIDNO_Tip"></span></td></tr>
<c:choose>
<c:when test="${userInfo.idCardCopy == null}">
  <tr>
    <th><span style="color:red">*</span>上传证件</th>
    <td>
      <div class="themodel">
      <ul>
        <li class="thmodel-zm">上传身份证正面照<br><br><input type="file" name="myFile"  id="myFile" style="width:200px;height:27px;" onChange="checkFileName('myFile','身份证正面照')"/>
		</li>
        <li class="thmodel-face">上传身份证正面头部照<br><br><input type="file" name="myFile2"  id="myFile2" style="width:200px;height:27px;" onChange="checkFileName('myFile2','身份证正面头部照')"/></li>
      </ul>
      </div>
	  </td>
	</tr>
</c:when>	 
<c:otherwise>
  <tr>
    <th><span style="color:red">*</span>修改证件</th>
    <td>
      <div class="themodel2">
      <ul>
        <li>
		<img onerror="handleImgLoadError(event);"   id="imgFile"   onclick="view(this)" src="/stageUpload/idCard/${userInfo.idCardCopy}?id=<%=new Date() %>"  />

		&nbsp;上传身份证正面照<br><br>&nbsp;<input type="file" name="myFile"  id="myFile" style="width:200px;height:27px;" onChange="checkFileName('myFile','身份证正面照')"/>
		</li>
        <li class="thmodel-face2">
		<img onerror="handleImgLoadError(event);"   id="imgFile2"  onclick="view(this)" src="/stageUpload/idCard/${userInfo.idCardCopy2}?id=<%=new Date() %>" />
		&nbsp;上传身份证正面头部照<br><br>&nbsp;<input type="file" name="myFile2"  id="myFile2" style="width:200px;height:27px;" onChange="checkFileName('myFile2','身份证正面头部照')"/></li>
      </ul>
      </div>
	  </td>
	</tr>
</c:otherwise>
</c:choose>
	  </tbody></table>
</div>
     
     <div class="shiming6" style="width:100%">
     <div style="float:left;width:200px">
	 <a href="javascript:doSubmit();" id="saveBtn">确认保存</a>
	 </div><div style="float:left;width:200px"><a href="javascript:clearAction();">关闭</a></div>
     </div>
     
     <div class="shiming7" style="float:left;width:100%">
         <h6>特别注意</h6>
         <img src="<%=request.getContextPath() %>/theme/images/small_star.jpg" width="10" height="10">
         （身份证）用相机拍下来，照片清晰无遮挡。<br /> 
   <img src="<%=request.getContextPath() %>/theme/images/small_star.jpg" width="10" height="10">&nbsp;您的证件仅在审核人员审核时可以看见，第1舞台严格保护您的隐私，请放心。<br /> 
   <img src="<%=request.getContextPath() %>/theme/images/small_star.jpg" width="10" height="10">&nbsp;身份证相片必须与个人相片吻合，否则视无效申请！ 
     </div>
</form>


  </div>
  
  
</div>

 
  </body>
</html>