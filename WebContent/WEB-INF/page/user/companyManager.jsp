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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	
	<script type="text/javascript">

	function toSearch(){
		//var keywords =$("#keywords").val();	
		//window.location.href="userinfo!getUserInfoList.htm?keywords="+encodeURI(keywords);	
		var form  = $("#searchForm"); 
       
        form.submit(); 
   
	}
	
	
	function toCheck(id,flag){
	   
	   var str1="启用当前用户账号，您确定吗？";
	   var str2="启用成功!";
	   if(flag==0){
	     str1="停用当前用户账号，您确定吗？";
	   	 str2="停用用户账号成功!";
	   }

		art.dialog({
		        icon: 'succeed',
				content: str1,
				ok: function () {
				   $.post('<%=request.getContextPath()%>/user/userAction!updateState.htm?id='+id+'&flag='+flag,
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
	
	function toCheckAll(){
	
	  var idls = getCheckList();
	  if(idls=="") {art.dialog.tips("请您选择需要推荐首页的公司！");}
	  else
	  {
	  		art.dialog({
		        icon: 'succeed',
				content:"首页推荐所选公司，您确定吗？",
				ok: function () {
				   var params={}; 
		           params.idls=idls;
				   $.post('<%=request.getContextPath()%>/member/userinfo!updateIsRecommend.htm?',params,
						function(data){
							if(data=="1"){
							
							art.dialog.tips("批量推荐成功!");
							window.location.href=window.document.location;
				  
						}
					},"html");

					
				},
				cancel: true
		});
	  }

	}
	
	function toCheckRecommend(id,flag){
	   
		art.dialog({
		        icon: 'succeed',
				content:"取消首页推荐公司，您确定吗？",
				ok: function () {
				   $.post('<%=request.getContextPath()%>/member/userinfo!updateRecommend.htm?id='+id+'&flag='+flag,
						function(data){
							if(data=="1"){
							
							art.dialog.tips("取消推荐成功!");
							//window.location.reload();
							window.location.href=window.document.location;
				  
						}
					},"html");

					
				},
				cancel: true
		});

		
	}
	
	function toView(userId){
		art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toCompanyInfoView.htm?userId='+userId,{width:750,height:500,resize: false});
	}
	
	function view(indexImgUrl){
			art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img onerror="handleImgLoadError(event);" src="/images/indexImg/'+indexImgUrl+'?id=<%=new Date() %>" />',
		    lock: true
		});
	}
	
	function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
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
        	<s:param name="menuFlag" value="22"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a href="#">首页</a> > <a href="#">公司管理</a></div>


<span class="clear"></span>
<form name="searchForm" id="searchForm" method="post" action='userinfo!getCompanyForManager.htm'>
<table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
        
        <table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:5px;">
    <tr>
        <td width="145" height="24" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;">
         <input name="keywords" type="text" class="znrz_input" id="keywords" value="${keywords}" /></td>
        <td width="585" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toSearch();" ><img src="<%=request.getContextPath() %>/theme/images/znrz_search.jpg" width="50" height="26" /></a></td>
        <td width="60" align="right" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toCheckAll();"><img src="<%=request.getContextPath() %>/theme/images/rz_icoimg.jpg" width="60" height="24" /></a></td>
    </tr>
</table>
</form>


<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td   align="center" class="zyfl_title"><input type="checkbox" name="selectids"  onclick=selectall(this)></td>
		    <td   align="center" class="zyfl_title">账号</td>
	        <td   align="center" class="zyfl_title">公司名称</td>	        
	        <td   align="center" class="zyfl_title">地区</td>
	        <td   align="center" class="zyfl_title">账号状态</td>
	        <td   align="center" class="zyfl_title">首页照片</td>
	        <td   align="center" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.userInfoList" var="item" status="st">
		<tr>
		    <td  align="center"  ><input type="checkbox" name="ids"  value="<s:property value="#item[0].id"/>"   onclick=selectonly(this)>  </td> 
		    <td  align="center"  >
		    <a href='<%=request.getContextPath() %>/index/orgListAction.htm?id=<s:property value="#item[0].id"/>' class="czjl_title_link">
		    <s:property value="#item[0].username"/></a><a href="javascript:toView('<s:property value="#item[0].id"/>');" class="czjl_title_link">
		    (查看)</a>
		    </td>	
	        <td  align="center"  ><s:property value="#item[1].nickName"/>&nbsp;</td>	        
	         <td  align="center"  ><s:property value="#item[1].provice"/>&nbsp;<s:property value="#item[1].city"/></td>
	         <td  align="center"  >
	         	<s:if test="#item[0].state==0">停用</s:if>
	         	<s:else>启用</s:else>
	         </td>
	         <td  align="left"  >
		        <s:if test="#item[1].isRecommend==1">
		      		已推荐	        
		        </s:if>
		        <s:else>
		        	未推荐
				</s:else>	
	        </td>
	        <td  align="center"  >
	        	
        	    <s:if test="#item[0].state==1">
		      		<a href="javascript:toCheck('<s:property value="#item[0].id"/>','0');" class="czjl_title_link">停用</a>	        
		        </s:if>
		        <s:else>
		        	<a href="javascript:toCheck('<s:property value="#item[0].id"/>','1');" class="czjl_title_link">启用</a>	   
				</s:else>
	            <s:if test="#item[1].isRecommend==1">
		      		<a href="javascript:toCheckRecommend('<s:property value="#item[0].id"/>','0');" class="czjl_title_link">取消推荐</a>		        
		        </s:if>
	        
	        </td>
	        
	    </tr>
	</s:iterator>

</table>

<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="userinfo!getCompanyForManager.htm" params='keywords=${keywords}&flag=1'  total='${game}' ></pg:pages></td>
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
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

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
				returnStr += "|"+myids[i].value;
			}
		}
		return returnStr!=""?returnStr.substring(1):"";
	}
 </script>
  </body>
</html>