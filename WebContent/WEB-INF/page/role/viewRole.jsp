<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%> 
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
<style type="text/css">
.comment_title1{
	width:160px;
	display:block;
	float:left;
	
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow: hidden;
}
.comment_title2{
	width:190px;
	display:block;
	float:left;
	
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow: hidden;
}
.comment_title3{
	width:90px;
	display:block;
	float:left;
	
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow: hidden;
}
</style>
<script type="text/javascript">

function toView(userId){
	art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?userId='+userId,{width:750,height:750,resize: false});
}

</script>	

  </head>
 
 
<body >

<table width="620" border="0" align="center" cellpadding="0" cellspacing="0" style="padding:10px;">
	<tr>
		<td width="120">角 色 名：</td>
		<td width="500"><s:property value='#request.role.roleName'/></td>
	</tr>
    <tr height="10">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td>角色描述：</td>
		<td><textarea readonly="readonly" cols="45" rows="5"><s:property value='#request.role.roleDescribe'/></textarea></td>
	</tr>
    <tr height="10">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td colspan="2">
          <fieldset>
            <legend>拥有权限</legend>
            <div>
              <s:iterator value="#request.list" var="menu" status="ci">
                <div style="float:left; width:100px; padding-left:10px; padding-top:10px;">
                  <input type="checkbox" disabled="disabled" <s:if test="#menu.flag==1"><s:property value="checked='checked'"/></s:if> />
                  <s:property value="#menu.menu.menuName"/>
                </div>
              </s:iterator>
            </div>
          </fieldset>
        </td>
	</tr>
    <tr height="10">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td colspan="2">
          <fieldset>
            <legend>角色下人员</legend>
              <table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
                <tr>
                  <td align="center" width="30" class="zyfl_title">序号</td>
                  <td align="center" width="170" class="zyfl_title">账号</td>
                  <td align="center" width="200" class="zyfl_title">昵称</td>	        
                  <td align="center" width="100" class="zyfl_title">姓名</td>
                  <td align="center" width="70" class="zyfl_title">账号类型</td>
                </tr>
                <s:iterator value="#request.userList" var="item" status="st">
                <tr>
                  <td align="center" ><s:property value="#st.index+1"/></td> 
                  <td align="center"><div class="comment_title1"><a href="javascript:toView('<s:property value='#item[0].id'/>');" class="czjl_title_link"><s:property value="#item[0].username"/></a></div></td>	      
                  <td align="center"><div class="comment_title2"><s:property value="#item[1].nickName"/>&nbsp;</div></td>
                  <td align="center"><div class="comment_title3"><s:property value="#item[1].name"/>&nbsp;</div></td>	        
                  <td align="center"  >
                  <s:if test="#item[0].isOrg==0">个人</s:if>
                  <s:else>企业</s:else>
                  </td>
                </tr>
                </s:iterator>
              
              </table>
              
              <table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
                <tr>
                  <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10" url="member/role!toViewRole.htm" params='id=${id}'  total='${total}' ></pg:pages></td>
                </tr>
              </table>
          </fieldset>
        </td>
	</tr>
    <tr height="10">
		<td colspan="2"></td>
	</tr>
</table>

  </body>
</html>
