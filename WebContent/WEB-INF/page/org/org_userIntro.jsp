<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
<script type="text/javascript">

	function tishi(content){
		art.dialog.tips(content);
	}
	function grjs_submit(){

	    var introduction=$("#userInfo\\.introduction").val();
	    if(introduction.length>500){
			    $("#yzxx").text("");
				$("#yzxx").append("【个人介绍】不能超过500个字符！");
				return ;
	      }
		
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/orginfo!saveOrupdateOrgUser.htm?sign=2",
		   type:'POST',
		   data:$("#grjsForm").serialize(),
		   success:function(data){
			   tishi('保存成功！');
			   location.reload();
		   }
		}); 
		
	}
</script>
  </head>
  <body style="overflow: hidden;">
  <!-- 主内容开始 -->
<table border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>

    
        <td  align="left" valign="top">

<div class="right_tab">
<ul>
<li><a href="orginfo!toAddUser.htm?sign=1&&id=<s:property value="#request.id"/>">基础信息</a></li>
<li><a  class="change"  href="orginfo!toAddUser.htm?sign=2&&id=<s:property value="#request.id"/>">个人介绍</a></li>
<li><a href="orginfo!toAddUser.htm?sign=3&&id=<s:property value="#request.id"/>">职业技能</a></li>
<li><a href="orginfo!toAddUser.htm?sign=4&&id=<s:property value="#request.id"/>">成长经历</a></li>
<li><a href="orginfo!toAddUser.htm?sign=5&&id=<s:property value="#request.id"/>">头像修改</a></li>
<li><a href="orginfo!toAddUser.htm?sign=6&&id=<s:property value="#request.id"/>">首页照片<img src="<%=request.getContextPath() %>/theme/images2/tu_xb.png" /></a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 个人介绍 开始 -->
<form name="grjsForm" id="grjsForm" action="<%=request.getContextPath()%>/member/orginfo!saveOrupdateOrgUser.htm?sign=2" method="post">
<input type="hidden" name="userInfo.id" value="${userInfo.id }"/> 
 <div id=TabTab03Con>
 <div class="content">
<div class="content_left">
<!-- 
 <table  border="0" align="center" cellpadding="0" cellspacing="0" class="box_01">
    <tr>
        <td width="129" align="right">学历</td>
        <td width="371" align="left" class="in_jz"><input type="text" class="input_xl" name="userInfo.education"   maxlength="100" id="userInfo.education" value="${userInfo.education }"/></td>
    </tr>
    <tr>
        <td align="right">毕业院校</td>
        <td align="left" class="in_jz"><input type="text" class="input_xl" name="userInfo.school" id="userInfo.school"  maxlength="100" value="${userInfo.school }"/></td>
    </tr>
    <tr>
        <td align="right">所学专业</td>
        <td align="left" class="in_jz"><input type="text" class="input_xl" name="userInfo.major" id="userInfo.major"  maxlength="100"  value="${userInfo.major }" /></td>
    </tr>
    <tr>
        <td align="right" class="in_jz"> 个人介绍</td>
        <td height="180" align="left"><textarea name="userInfo.introduction" id="userInfo.introduction" cols="45" rows="5" class="wby_box">${userInfo.introduction }</textarea></td>
    </tr>
    <tr>
                <td>&nbsp;</td>
                <td  style="height:26px; line-height:26px; color:#F00;" id="yzxx"></td>
            </tr>
    <tr>
        <td>&nbsp;</td>
        <td  align="center" class="save"><a href="javascript:grjs_submit()"><img src="<%=request.getContextPath() %>/theme/images/save.jpg" width="115" height="40" /></a></td>
   
    </tr>
     <tr>
        <td colspan=2>&nbsp;</td>
        
    </tr>
</table>      -->    
<ul>  
<li>
    <div class="name"> 毕业院校：</div>
   <input type="text" name="userInfo.school" id="userInfo.school"  maxlength="100" value="${userInfo.school }"/>
</li>

<li>
    <div class="name"> 个人介绍：</div>
   <textarea name="userInfo.introduction" id="userInfo.introduction" cols="45" rows="5" >${userInfo.introduction }</textarea>
</li>

</ul>
</div>
<div class="baocun">
<a href="javascript:grjs_submit()">保存</a>
</div>
</div>      
</div>
</form>
</td>
</tr>
</table>

<!-- 主内容结束 -->

  </body>
</html>