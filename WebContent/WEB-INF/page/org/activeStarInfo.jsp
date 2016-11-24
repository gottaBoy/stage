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
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/default.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	
	<script type="text/javascript">
var checkedIndex = 0;
	function toSearch(){
		//var keywords =$("#keywords").val();	alert(keywords)
		//window.location.href="member/newManInfo.htm?keywords="+encodeURI(keywords);	
		var form  = $("#searchForm1"); 
        form.submit(); 
	}

	function toView(userId){
		art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?type=2&&userId='+userId,{width:750,height:570,resize: false});
	}
	
	function view(indexImgUrl){
			art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img onerror="handleImgLoadError(event);" src="/images/indexImg/'+indexImgUrl+'?id=<%=new Date() %>" />',
		    lock: true
		});
	}
	function loadImageWindow(userId){
	//document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block';handleImgLoadError(event);
	art.dialog.open('<%=request.getContextPath() %>/member/evaluate!image3.htm?id='+userId,{width:600,height:500,resize: false});
}
	
	function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
  	    }
  	    
function addNewMan(userId){
	if($("#checkbox_"+userId).attr("checked")=="checked"){//保存
		doAddorUpdate(userId,1);
		 checkedIndex++;
		 if(checkedIndex==4){
		 	$('input[name=checkbox]').each(function(index){
					$(this).attr("disabled","disabled");
			});
		 }
		
	}else{//删除
		
		 document.getElementById("a_"+userId).style.display = "none";
		doAddorUpdate(userId,2);
			 checkedIndex--;
		 window.parent.document.getElementById("pic_"+userId).style.display = "none";
	}
	
}  	  
function delNewMan(userId){
	document.getElementById("pic_"+userId).style.display = "none";
		doAddorUpdate(userId,2);
		 checkedIndex--;
		window.location.reload();
}  
function doAddorUpdate(userId,flag){
	$.ajax({
		   url:"<%=request.getContextPath() %>/member/activeStarInfo!saveActiveStar.htm?userId="+userId+"&flag="+flag,
		   type:'POST',
		   data:$("#searchForm1").serialize(),
		   success:function(data){
			   if(data=="1"){
					if(flag=="1"){
				   		loadImageWindow(userId);
				   		 document.getElementById("pic_"+userId).style.display = "";
				   		 document.getElementById("a_"+userId).style.display = "";
				   }
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
        <!-- 会员 左导航 开始 -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="30"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a href="#">首页</a> > <a href="#">最活跃艺人</a></div>


<span class="clear"></span>
<form name="searchForm1" id="searchForm1" method="post" action='activeStarInfo.htm'>
	<table>
		<tr>
			<td><input name="keywords" type="text"  class="znrz_input" id="keywords" value="" /></td>
			<td><a href="javascript:toSearch();" ><img src="<%=request.getContextPath() %>/theme/images/znrz_search.jpg" width="50" height="26" /></a></td>
		</tr>
	</table>
</form>
<!-- <form name="searchForm" id="searchForm" method="post" action='member/newManInfo!saveNewMan.htm'></form> -->
<table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
        
        <table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:5px;">
</table>



<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td   align="center" class="zyfl_title">&nbsp;<!-- <input type="checkbox" name="selectids"  onclick=selectall(this)> --></td>
		    <td   align="center" class="zyfl_title">&nbsp;</td>
	        <td   align="center" class="zyfl_title">昵称</td>	 
	        <td   align="center" class="zyfl_title">职业</td>       
	        <td   align="center" class="zyfl_title">姓名</td>
	        <td   align="center" class="zyfl_title">地区</td>
			<!--
	        <td   align="center" class="zyfl_title">用户状态</td>
	          -->
	        <td   align="center" class="zyfl_title">人气</td>
	        <td   align="center" class="zyfl_title">关注</td>
	        <td   align="center" class="zyfl_title">加入日期</td>
	        <td   align="center" class="zyfl_title"></td>
	    </tr>
	    <form name="zzjs_net">
	    <%int i = 0; %>
	<s:iterator value="#request.list" var="item" status="st">

		<tr>
		    <td  align="center"><input type="checkbox" name="checkbox" id="checkbox_<s:property value="#item[0].id"/>" onClick="addNewMan(<s:property value="#item[0].id"/>)" value="<s:property value="#item[0].id"/>"/>  </td> 
		    <%++i; %>
		    <td><img id="pic_<s:property value="#item[0].id"/>" style="display:none;" src="<%=request.getContextPath() %>/theme/images2/newman_01.jpg" width="20" height="17" /></td>
		   <td  align="center"  > <a href="javascript:toView('<s:property value="#item[0].id"/>');" class="czjl_title_link"><s:property value="#item[1].nickName"/></a>&nbsp;</td>
		    <td  align="center"  ><s:property value="#item[1].profession"/>&nbsp;</td>        
	         <td  align="center"  ><s:property value="#item[1].name"/>&nbsp;</td>
	        
	         <td  align="center"  ><s:property value="#item[1].provice"/>&nbsp;<s:property value="#item[1].city"/></td>
	         <!-- 
	         	         <td  align="center"  >
	         	<s:if test="#item[0].state==0">停用</s:if>
	         	<s:else>启用</s:else>
	         </td>
	         -->
	         <td  align="center"  ><s:property value="#item[1].popularityTotal"/>
	        </td>
	        <td></td>
	        <td  align="center"  >
	        	<s:property value="#item[0].creatTime"/>
	        </td>
	        <td  align="center" >
	        	<a id="a_<s:property value="#item[0].id"/>" style="display:none;color: #cc0000;" href="javascript:delNewMan(<s:property value="#item[0].id"/>)" >删除</a>
	        </td>
	        
	    </tr>
	</s:iterator>
	</form>

</table>

<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="activeStarInfo.htm" params='keywords=${pageKeywords}'  total='${total}' ></pg:pages></td>
    </tr>
</table>

</td>
    </tr>
</table>

</td>
</tr>
</table>


</td>
</tr>
</table>
<s:iterator value="#request.list1" var="list1">
<script>
	$("#checkbox_"+<s:property value="#list1.yrUserId"/>).attr("checked","checked");
	window.parent.document.getElementById("pic_"+<s:property value="#list1.yrUserId"/>).style.display = "";
	document.getElementById("a_"+<s:property value="#list1.yrUserId"/>).style.display = "";
	
</script>
</s:iterator>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

<script type="text/javascript">
checkedIndex = <s:property value='#request.list1Sum'/>;
if(checkedIndex==4){
		$('input[name=checkbox]').each(function(index){
			$(this).attr("disabled","disabled");
	});
}
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
 
    //全选	
 	function selectall(){
		var ck = arguments[0].checked;
		var obj = document.all("ids");
	
		try{
			if(typeof(obj.length) == "undefined"){
				obj.checked = ck;
				verify();
				return;
			}
			for(var i=0,n=obj.length;i<n;i++){
				obj[i].checked = ck;
				
			}
			verify();
		}catch(e){}
		
	}
		//点击列表中的checkbox时处理全选框显示	
	function selectonly(){
		//var obj = $("selectids");
		var obj = document.getElementsByName('selectids');
		if(!arguments[0].checked) obj.checked = false;
		verify();
		}
	
 </script>
  </body>
</html>