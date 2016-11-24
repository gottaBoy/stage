<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>

<script type="text/javascript">

function selectcheckbox(id) {
	document.getElementById(id).checked = !document.getElementById(id).checked;
}

var authStr = "";//选择的权限的ID
function checknull(){
	var roleName = $("#roleName").val();
	if(roleName == "") {
		art.dialog.tips("角色名不能为空!");
		return false;
	}
	if(roleName.length > 50){
		art.dialog.tips("角色名不能超过50个字符!");
		return false;
	}
	
	var roleDescribe = $("#roleDescribe").html();
	
	if(roleDescribe.length > 200){
		art.dialog.tips("地点不能超过200个字符!");
		return false;
	}
	
	var authFlag = true;
	$(".authCheckbox").each(function(){
		if($(this).attr("checked")) {
			authFlag = false;
			authStr += $(this).val() + "_";
		}
	});
	
	if(authFlag) {
		art.dialog.tips("请选择权限!");
		return false;
	}
	
	return true;
}

var dialog;
//表单提交（订单提交）
function doSubmit(){
	if(checknull()){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/role!addOrUpdateRole.htm?authStr=" + authStr,
		   type:'POST',
		   data:$("#roleFrom").serialize(),
		   success:function(data){
			   if(data == 1){
				    art.dialog.tips("保存成功!", 1);
					parent.window.location.reload();
					art.dialog.close();
			   } else if(data == 2) {
				   art.dialog.tips("角色名已存在!");
			   }
		   }
		});
	}
}
</script>

  </head>
 
 
<body >

<form id="roleFrom" action="" method="post">

<input type="hidden" name="roleInfo.id" value="${role.id }" />
<input type="hidden" name="roleInfo.creater" value="${role.creater }" />
<input type="hidden" name="roleInfo.createTime" value="${role.createTime }" />


<table width="620" border="0" align="center" cellpadding="0" cellspacing="0" style="padding:10px;">
	<tr>
		<td width="120"><span style="color:red;">*</span>角 色 名：</td>
		<td width="500"><input type="text" name="roleInfo.roleName" id="roleName" style="width:200px;" value="<s:property value='#request.role.roleName'/>" /></td>
	</tr>
    <tr height="10">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td>角色描述：</td>
		<td><textarea name="roleInfo.roleDescribe" id="roleDescribe" cols="45" rows="5"><s:property value='#request.role.roleDescribe'/></textarea></td>
	</tr>
    <tr height="10">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td colspan="2">
          <fieldset>
            <legend>选择权限</legend>
            <div>
              <s:iterator value="#request.list" var="menu" status="ci">
                <div style="float:left; width:100px; padding-left:10px; padding-top:10px;">
                  <input class="authCheckbox" type="checkbox" id="checkbox_<s:property value='#menu.menu.id'/>" <s:if test="#menu.flag==1"><s:property value="checked='checked'"/></s:if> value="<s:property value='#menu.menu.id'/>"/>
                  <span onclick="selectcheckbox('checkbox_<s:property value='#menu.menu.id'/>');" style="cursor:pointer;"><s:property value="#menu.menu.menuName"/></span>
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
		<td colspan="2" align="center">
          <a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
          &nbsp;&nbsp;&nbsp;&nbsp;
          <a href="javascript:art.dialog.close();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
        </td>
	</tr>
</table>




</form>
  </body>
</html>
