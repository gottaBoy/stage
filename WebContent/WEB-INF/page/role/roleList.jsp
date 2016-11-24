<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
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
	
<style type="text/css">
.comment_title{
	width:460px;
	display:block;
	float:left;
	
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow: hidden;
}
</style>

<script type="text/javascript">


$().ready(function(){

});

function toSearch(){
	//var keywords =$("#keywords").val();	
	//window.location.href="userinfo!getUserInfoList.htm?keywords="+encodeURI(keywords);	
	var form  = $("#searchForm"); 
	form.submit(); 
}


function toAddRole(){
	art.dialog.open('<%=request.getContextPath()%>/member/role!toAddUpdateRole.htm',{lock:true,resize: false});
}
	
function toUpdateRole(id){
	art.dialog.open('<%=request.getContextPath()%>/member/role!toAddUpdateRole.htm?id=' + id,{lock:true,resize: false});
}

function toRoleView(id){
	art.dialog.open('<%=request.getContextPath()%>/member/role!toViewRole.htm?id=' + id,{lock:true,resize: false});
}

function selectUser(roleId){
	art.dialog.open('<%=request.getContextPath()%>/member/role!getUserList.htm?roleId=' + roleId,{lock:true,resize: false});
}

function delRole(id){
	$.ajax({
		url:"<%=request.getContextPath() %>/member/role!delRole.htm?id=" + id,
		type:'POST',
		success:function(data){
			if(data == 1){
				art.dialog.tips("删除成功!", 1);
				window.location.reload();
			} else if(data == 2) {
				art.dialog.tips("该角色正在被使用，无法删除!");
			}
		}
	});
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
        	<s:param name="menuFlag" value="33"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
		</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">权限管理</a></div>


<span class="clear"></span>

<form name="searchForm" id="searchForm" method="post" action='member/role!getRoleList.htm'>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:5px;">
  <tr>
    <td width="145" height="24" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;">
     <input name="roleName" type="text" class="znrz_input" id="roleName" value="${roleName}" /></td>
    <td width="585" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toSearch();" ><img src="<%=request.getContextPath() %>/theme/images/znrz_search.jpg" width="50" height="26" /></a></td>
    <td width="60" align="right" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toAddRole();"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
  </tr>
</table>
</form>

<!-- 标签页 内容一 -->
<table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
          <table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
              <tr>
                  <td width="50" align="center" class="zyfl_title">序号</td>
                  <td width="150" align="center" class="zyfl_title">角色名</td>
                  <td width="470" align="center" class="zyfl_title">角色描述</td>
                  <td width="120" align="center" class="zyfl_title">操作</td>
              </tr>
               <s:iterator value="#request.list" var="role" status="r">
              <tr>
                  <td align="center"><s:property value="#r.index+1"/></td>
                  <td align="center"><a href="javaScript: toRoleView(<s:property value='#role.id'/>);" class="czjl_title_link">
                      <s:property value="#role.roleName"/></a></td>
                  <td align="center"><div class="comment_title" title="<s:property value='#role.roleDescribe'/>"><s:property value="#role.roleDescribe"/></div></td>
                  <td align="center">
                      <a href="javaScript:toUpdateRole(<s:property value='#role.id'/>);" class="czjl_title_link">修改</a>
                      <a href="javaScript:delRole(<s:property value='#role.id'/>);" class="czjl_title_link">删除</a>
                      <a href="javaScript:selectUser(<s:property value='#role.id'/>);" class="czjl_title_link">选择用户</a>
                  </td>
              </tr>
              </s:iterator>
          </table>
          <table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
              <tr>
                  <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="member/role!getRoleList.htm" params='sign=1' total='${total}' ></pg:pages></td>
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
