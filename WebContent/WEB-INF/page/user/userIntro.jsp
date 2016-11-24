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
		var form = $(document.getElementById('grjsForm'));
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
		//$("#grjsForm").submit();
		tishi('保存成功！');
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
        	<s:param name="menuFlag" value="1"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">个人信息</a></div>

<div class="right_tab">
<ul>
<li><a href="userinfo.htm?sign=1">基础信息</a></li>
<li><a class="change" href="userinfo.htm?sign=2"><%if(1==HttpSessionHelper.getIsOrg(request)){%>公司介绍<%}else{ %>个人介绍<%} %></a></li>
<li><a href="userinfo.htm?sign=3">职业技能</a></li>
<li><a href="userinfo.htm?sign=7">成长经历</a></li>
<li><a href="userinfo.htm?sign=4">实名认证</a></li>
<li><a href="userinfo.htm?sign=5">头像修改</a></li>
<li><a href="userinfo.htm?sign=6">首页照片<img src="<%=request.getContextPath() %>/theme/images2/tu_xb.png" /></a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 个人介绍 开始 -->
<form name="grjsForm" id="grjsForm" action="userinfo!saveOrUpdate.htm?sign=2" method="post">
<input type="hidden" name="userInfo.id" value="${userInfo.id }"/> 
 <div id=TabTab03Con>
 <table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="box_01">
   <%if(1==HttpSessionHelper.getIsOrg(request)){%><%}else{ %> 
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
    <%} %>
    <tr>
        <td align="right" class="in_jz"><%if(1==HttpSessionHelper.getIsOrg(request)){%>公司介绍<%}else{ %> 个人介绍<% }%></td>
        <td height="180" align="left"><textarea name="userInfo.introduction" id="userInfo.introduction" cols="45" rows="5" class="wby_box">${userInfo.introduction }</textarea></td>
    </tr>
    <tr>
                <td>&nbsp;</td>
                <td  style="height:26px; line-height:26px; color:#F00;" id="yzxx"></td>
            </tr>
    <tr>
        <td>&nbsp;</td>
        <td height="60" align="center" class="save"><a href="javascript:grjs_submit()"><img src="<%=request.getContextPath() %>/theme/images/save.jpg" width="115" height="40" /></a></td>
    </tr>
</table>                       
</div>
</form>
</td>
</tr>
</table>

<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

  </body>
</html>