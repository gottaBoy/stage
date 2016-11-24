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

<style type="text/css">
.comment_title1{
	width:140px;
	display:block;
	float:left;
	
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow: hidden;
}
.comment_title2{
	width:170px;
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

function toSearch(){
	var form  = $("#searchForm"); 
	form.submit(); 
}

function toCheck(userId, roleId){
	var str1="选择当前用户，您确定吗？";
	var str2="设置成功!";
	
	art.dialog({
		icon: 'succeed',
		content: str1,
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/role!updateUserRoleId.htm?userId='+userId+'&roleId='+roleId,
				function(data){
					if(data=="1"){
						art.dialog.tips(str2);
						//window.location.reload();
						window.location.href=window.document.location;
						
					}
				},"html");
			},
		cancel: true
	});
}
	
function toCheckAll(roleId){alert(roleId);
	var userIdStr = getCheckList();
	if(userIdStr=="") {
		art.dialog.tips("请选择要设置角色的用户！");
	} else {
		art.dialog({
			icon: 'succeed',
			content:"设置选择用户的角色，您确定吗？",
			ok: function () {
				var params={}; 
				params.userIdStr=userIdStr;
				params.roleId=roleId;
				$.post('<%=request.getContextPath()%>/member/role!updateAllUserRoleId.htm?',params,
					function(data){
						if(data=="1"){
							art.dialog.tips("批量设置用户角色成功!");
							window.location.href=window.document.location;
						}
					},"html");
			},
			cancel: true
		});
	}
}
	
function toView(userId){
	art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?userId='+userId,{width:750,height:750,resize: false});
}

function setValue(e) {
	if($(e).attr("checked")) {
		$(e).val(1);
		$("#isRole").val(1);
	} else {
		$(e).val(2);
		$("#isRole").val(2);
	}
}

//全选	
function selectall(){
	var ck = arguments[0].checked;
	var obj = document.all("ids");

	try{
		if(typeof(obj.length) == "undefined"){
			obj.checked = ck;
			return;
		}
		for(var i=0,n=obj.length;i<n;i++){
			obj[i].checked = ck;
			
		}
	}catch(e){}
}
	//点击列表中的checkbox时处理全选框显示	
function selectonly(){
	//var obj = $("selectids");
	var obj = document.getElementsByName('selectids');
	if(!arguments[0].checked) obj.checked = false;
}
	
	//============获取选中的数据ID=================================
function getCheckList(){
	//var  myids= document.all("ids");
	var myids= document.getElementsByName('ids');
	if(myids == null) return "";
	var returnStr="";
	for(i=0;i<myids.length;i++)
	{
		if(myids[i].checked) 
		{
			returnStr += myids[i].value+"_";
		}
	}
	return returnStr;
}
</script>		
</head>
  <body>
 

  <!-- 主内容开始 -->
<table width="710" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>

        <td width="710" align="left" valign="top">

<form name="searchForm" id="searchForm" method="post" action='member/role!getUserList.htm'>
<table width="690" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:5px;">
    <tr>
        <td width="265" height="24" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;">
         <input name="keywords" type="text" class="znrz_input" id="keywords" value="${keywords}" />&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="hidden" name="isRole" id="isRole" value="${isRole}"  />
         <input type="hidden" name="roleId" id="roleId" value="${roleId}"  />
         <input type="checkbox" value="${isRole}" <s:if test="#request.isRole==1"><s:property value="checked='checked'"/></s:if>  onclick="setValue(this)" />无角色用户</td>
        <td width="465" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toSearch();" ><img src="<%=request.getContextPath() %>/theme/images/znrz_search.jpg" width="50" height="26" /></a></td>
        <td width="60" align="right" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toCheckAll(${roleId});"><img src="<%=request.getContextPath() %>/theme/images/nav_qrimg.jpg" width="60" height="28" /></a></td>
    </tr>
</table>
</form>


<table width="690" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td align="center" width="20" class="zyfl_title"><input type="checkbox" name="selectids" onclick="selectall(this)"></td>
		    <td align="center" width="150" class="zyfl_title">账号</td>
	        <td align="center" width="180" class="zyfl_title">昵称</td>	        
	        <td align="center" width="100" class="zyfl_title">姓名</td>
	        <td align="center" width="100" class="zyfl_title">所属角色</td>
	        <td align="center" width="70" class="zyfl_title">账号类型</td>
	        <td align="center" width="70" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.list" var="item" status="st">
		<tr>
		    <td align="center"  ><input type="checkbox" name="ids" value="<s:property value='#item.user.id'/>">  </td> 
		    <td align="center"><div class="comment_title1">
		    <a href="javascript:toView('<s:property value='#item.user.id'/>');" class="czjl_title_link">
		    <s:property value="#item.user.username"/></a></div>
		    </td>	      
	        <td align="center"><div class="comment_title2"><s:property value="#item.userInfo.nickName"/>&nbsp;</div></td>
	        <td align="center"><div class="comment_title3"><s:property value="#item.userInfo.name"/>&nbsp;</div></td>	        
	        <td align="center"><s:property value="#item.roleName"/></td>
	        <td align="center"  >
	         	<s:if test="#item.user.isOrg==0">个人</s:if>
	         	<s:else>企业</s:else>
	        </td>
	        <td align="center">
		        <a href="javascript:toCheck(<s:property value='#item.user.id'/>, ${roleId});" class="czjl_title_link">选择</a>	   
	        </td>
	    </tr>
	</s:iterator>

</table>

<table width="690" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10" url="member/role!getUserList.htm" params='keywords=${keywords}&flag=1&isRole=${isRole}&roleId=${roleId}'  total='${total}' ></pg:pages></td>
    </tr>
</table>




</td>
</tr>
</table>
<!-- 主内容结束 -->

<script type="text/javascript">

//用户名框鼠标焦点移进，文字消失
$("#keywords").click(function () {
	var check1 = $(this).val();
	if (check1 == "请输入关键词") {
		$(this).val("");
	}
});
//用户名框鼠标焦点移出，默认文字显示
$("#keywords").blur(function () {
	var check1 = $(this).val();
	if (check1 == "") {
		$(this).val("请输入关键词");
	}
});
 </script>
  </body>
</html>