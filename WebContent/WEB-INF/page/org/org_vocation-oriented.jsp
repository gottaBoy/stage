<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!--  org/org_vocation-oriented.jsp-->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>

<script type="text/javascript" >
	function toAdd(){
		if(<s:property value="#request.costList.size+1"/> > 5){
				alert("最多只能添加5个职业！");
				return;
		}
		art.dialog.open("<%=request.getContextPath()%>/member/cost!toAddOrUpdateByJs.htm?costId=0&save=true&add=true&index="+'<s:property value="#request.costList.size+1"/>',{width:700,height:450,close: function () {
     		 location.reload();
  		},title:''});
	}

	function toEdit(costId,index){
		art.dialog.open("<%=request.getContextPath()%>/member/cost!toAddOrUpdateByJs.htm?costId="+costId+"&save=true&index="+index,{width:700,height:450,close: function () {
     		 location.reload();
  		},title:''});
	}

 function getUserInfoCost() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getUserInfoCost.htm",
		type:'POST',
		dataType:'json',  
		success:function(data){
			var d = eval(data);
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				//onlyShowContent((i+1), obj.bprice,obj.unit,obj.keywords,obj.profession,obj.id);
			}
		}
	});
}
getUserInfoCost();


/*
	function toAdd(){
		art.dialog.open('<%=request.getContextPath()%>/member/cost!toOrgAddorUpdate.htm?userId=<s:property value="#request.id"/>',{width:550,height:400,close: function () {
     		 location.reload();
  		},title:''});
	}
	function toEdit(id){
		art.dialog.open('<%=request.getContextPath()%>/member/cost!toOrgAddorUpdate.htm?userId=<s:property value="#request.id"/>&&id='+id,{width:550,height:400,close: function () {
     		 location.reload();
  		},resize: false,title:''});
	}
*/
	function toDel(id){
		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/cost!delCost.htm?userId=<s:property value="#request.id"/>&&id='+id,
						function(data){
							if(data=="1"){
								//art.dialog.tips("删除成功!");
								window.location.reload();
							}else if(data=="2"){
								 art.dialog.tips("请至少保留一项职业!");
							}else{
								 art.dialog.tips("请按职业顺序来删除职业!");
							}
					},"html");

					
				},
				cancel: true
		});
	}
	
	 function tishi(content){
   		alert(content);
   		window.location.href=window.document.location;
	}
</script>
  </head>
  <body style="overflow: hidden;">
  <!-- 主内容开始 -->
<table   border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td  align="left" valign="top">

<div class="right_tab">
<ul>
<li><a href="orginfo!toAddUser.htm?sign=1&&id=<s:property value="#request.id"/>">基础信息</a></li>
<li><a href="orginfo!toAddUser.htm?sign=2&&id=<s:property value="#request.id"/>">个人介绍</a></li>
<li><a class="change" href="orginfo!toAddUser.htm?sign=3&&id=<s:property value="#request.id"/>">职业技能</a></li>
<li><a href="orginfo!toAddUser.htm?sign=4&&id=<s:property value="#request.id"/>">成长经历</a></li>
<li><a href="orginfo!toAddUser.htm?sign=5&&id=<s:property value="#request.id"/>">头像修改</a></li>
<li><a href="orginfo!toAddUser.htm?sign=6&&id=<s:property value="#request.id"/>">首页照片<img src="<%=request.getContextPath() %>/theme/images2/tu_xb.png" /></a></li>
</ul>
</div>
<span class="clear"></span>
<!-- 职业技能 开始 -->
<div id=TabTab03Con>
<table   border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px;">
    <tr>
        <td height="24" align="right"><a href="javascript:toAdd();" class="a_link"><img src="<%=request.getContextPath() %>/theme/images/tj_nav.jpg" width="60" height="24" /></a></td>
    </tr>
</table>
<table  border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td width="167" align="center" class="zyfl_title">职业排序</td>
	        <td width="167" align="center" class="zyfl_title">职业</td>	        
	        <td width="115" align="center" class="zyfl_title">关键字</td>
	        <td width="231" align="center" class="zyfl_title">价格区间</td>
	        <td width="80" align="center" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.costList" var="cost">
		<tr>
		    <td  align="center"  ><a href="javascript:toEdit('<s:property value="#cost[0].id"/>','<s:property value="#cost[0].orderNo"/>');" class="czjl_title_link">第<s:property value="#cost[0].orderNo"/>职业</a></td>	        
	        <td  align="center"  ><s:property value="#cost[1].typeName"/></td>
	        <td  align="center"><s:property value="#cost[0].keywords"/>&nbsp;</td>
	        <td  align="center"  >
	        <s:if test="#cost[0].isConsult==1">面议</s:if>
	        <s:else><s:property value="#cost[0].bprice"/>-<s:property value="#cost[0].eprice"/>&nbsp;（元/<s:property value="#cost[0].unit"/>）</s:else>	        
	        </td>
	        <td  align="center"  ><a href="javascript:toDel('<s:property value="#cost[0].id"/>');" class="czjl_title_link">删除</a></td>
	    </tr>
	</s:iterator>

</table>

</td>
    </tr>
</table>                
</div>


</td>
</tr>
</table>

<!-- 主内容结束 -->

  </body>
</html>