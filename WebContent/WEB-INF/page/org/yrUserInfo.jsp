<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
        <!---------org\yrUserInfo.jsp -->
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/default.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
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
	
	function toAdd(id){
		art.dialog.open('<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign=1&addUser=true&id='+id,{
			width: 800,
			height: 800,
			title:"艺人信息维护",
			//lock:true,
			close: function () { location.reload();	}
		});
	}
	function toCheck(id,flag){
	   
	   var str1="删除用户，您确定吗？";
	   var str2="删除用户，您确定吗？";
	   if(flag==0){
	       str1="删除用户，您确定吗？";
	   	   str2="删除用户，您确定吗？";
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
	
	function toCheckRecommend(id,flag){
	    var content = "取消首页推荐，您确定吗？";
	    if(flag==1){
	    	 content = "首页推荐，您确定吗？";
	    }
		art.dialog({
		        icon: 'succeed',
				content:content,
				ok: function () {
				   $.post('<%=request.getContextPath()%>/member/userinfo!updateComRecommend.htm?id='+id+'&flag='+flag,
						function(data){
							if(data=="1"){
							
							//art.dialog.tips("取消推荐成功!");
							//window.location.reload();
							window.location.href=window.document.location;
						}
					},"html");
				},
				cancel: true
		});
	}
	
	function toView(userId){
		art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?type=2&&userId='+userId,{width:750,height:570,resize: false});
	}
	
	function view(id){
			art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img width="242" height="222" onerror="handleImgLoadError(event);" src="/stageUpload/indexHeadImage/'+id+'.png" complete="complete" />',
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
        	<s:param name="menuFlag" value="14"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position">您的位置：<a>首页</a> > <a>艺人管理</a></div>


<span class="clear"></span>



<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table" style="display: none;">
		<tr>
		    <td   align="center" class="zyfl_title">&nbsp;<!-- <input type="checkbox" name="selectids"  onclick=selectall(this)> --></td>
	        <td   align="center" class="zyfl_title">昵称</td>	 
	        <td   align="center" class="zyfl_title">职业</td>       
	        <td   align="center" class="zyfl_title">姓名</td>
	        <td   align="center" class="zyfl_title">地区</td>
			<!--
	        <td   align="center" class="zyfl_title">用户状态</td>
	          -->
	        <td   align="center" class="zyfl_title">首页照片</td>
	        <td   align="center" class="zyfl_title">操作</td>
	    </tr>
	    <form name="zzjs_net">
	    <%int i = 0; %>
	<s:iterator value="#request.list" var="item" status="st">

		<tr>
		    <td  align="center"><input type="checkbox" name="www_zzjs_net" onClick="javascript:chewww_zzjs_netValidate('<%=i%>')" value="<s:property value="#item[0].id"/>"/>  </td> 
		    <%++i; %>
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
	         <td  align="center"  >
	         	<table><tr>
	          	<s:if test="#item[1].comRecommend==1">
		      		<td style="border-bottom:0px" >已推荐	</td>   
		        </s:if>
		        <s:else>
		        	<td style="border-bottom:0px">未推荐</td>
				</s:else>	
				<td style="border-bottom:0px">
		        <div id="tuijian_<s:property value="#item[0].id"/>"><a  style="color: #009900;"  href="javaScript:view('<s:property value="#item[0].id"/>');" class="czjl_title_link">(推荐图)</a> </div>
		      	<div id="tuijian1_<s:property value="#item[0].id"/>" style="color: #ff0000;display: none;">(暂无推荐图)</div>
		      <img style="display: none;" onerror="$('#tuijian_'+<s:property value="#item[0].id"/>).css('display','none');$('#tuijian1_'+<s:property value="#item[0].id"/>).css('display','');" src="/stageUpload/indexHeadImage/<s:property value="#item[0].id"/>.png" />
	        	</td>
	        	</tr>
	        	</table>
	        </td>
	        <td  align="center"  >
	        	<!--  
        	    <s:if test="#item[0].state==1">-->
		      		<a href="javascript:toCheck('<s:property value="#item[0].id"/>','0');" class="czjl_title_link">删除</a>	 
		      		<a href="javascript:toAdd('<s:property value="#item[0].id"/>');" class="czjl_title_link">修改</a>	
		      		<a href="javascript:toOrgArtMangeer('<s:property value="#item[0].id"/>');" class="czjl_title_link">才艺管理</a>
		      		<a href="javascript:toDqManager('<s:property value="#item[0].id"/>');" class="czjl_title_link">档期管理</a>               
		       <!-- 
		        </s:if>
		        <s:else>
		        	<a href="javascript:toCheck('<s:property value="#item[0].id"/>','1');" class="czjl_title_link">启用</a>	   
				</s:else>
				 
	            <s:if test="#item[1].comRecommend==1">
		      		<a href="javascript:toCheckRecommend('<s:property value="#item[0].id"/>','0');" class="czjl_title_link">取消推荐</a>		        
		        </s:if>
	         <s:else>
		        	<a href="javascript:toCheckRecommend('<s:property value="#item[0].id"/>','1');" class="czjl_title_link">推荐</a>		          
				</s:else>-->
	        </td>
	        
	    </tr>
	</s:iterator>
	</form>

</table>
<!-- <form name="searchForm" id="searchForm" method="post" action='yrinfo.htm'>
<table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
        
        <table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_add" style="margin-bottom:8px; margin-top:5px;">
    <tr>
        <td width="145" height="24" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;">
         <input name="keywords" type="text" class="znrz_input" id="keywords" value="${keywords}" /></td>
        <td width="585" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toSearch();" ><img src="<%=request.getContextPath() %>/theme/images/znrz_search.jpg" width="50" height="26" /></a></td>
        <td width="80" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:toAdd('0');"><img src="<%=request.getContextPath() %>/theme/images/cy_xz.jpg"  /></a></td>
          </tr>
</table>
</form> -->
<div id="TabTab03Con">
<div class="yiren_list">
   <div class="yiren_listbt">
      <h3>艺人管理</h3>
      <a href="javascript:toAdd('0');">创建添加</a>  
   </div>
   
   <ul class="yiren_listcont_name">
      <li class="kuang1"><h3>昵称</h3></li>
      <li class="kuang2"><h3>职业</h3></li>
      <li class="kuang3"><h3>姓名</h3></li>
      <li class="kuang4"><h3>地区</h3></li>
      <li class="kuang5"><h3>操作</h3></li>
   </ul>
   <s:iterator value="#request.list" var="item" status="st">
   <ul class="yiren_listcont">
      <li class="kuang1"><a href="javascript:toView('<s:property value="#item[0].id"/>');" class="czjl_title_link"><s:property value="#item[1].nickName"/></a>&nbsp;</li>
      <li class="kuang2"><s:property value="#item[1].profession"/>&nbsp;</li>
      <li class="kuang3"><s:property value="#item[1].name"/>&nbsp;</li>
      <li class="kuang4"><s:property value="#item[1].provice"/>&nbsp;<s:property value="#item[1].city"/></li>
      <li class="kuang5"><a href="javascript:toCheck('<s:property value="#item[0].id"/>','0');" class="czjl_title_link">删除</a>	 
		   <a href="javascript:toAdd('<s:property value="#item[0].id"/>');" class="czjl_title_link">修改</a>
		   <a href="javascript:toOrgArtMangeer('<s:property value="#item[0].id"/>');" class="czjl_title_link">才艺管理</a>
		   </li>
   </ul>
   </s:iterator>
  
</div>

<div>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="7"  url="yrinfo.htm" params='keywords=${pageKeywords}'  total='${game}' ></pg:pages></td>
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
	function toOrgArtMangeer(id){
	
	    //var myids= document.getElementsByName('www_zzjs_net');
	    
		//if(myids != null ){
			//for(var i=0;i<myids.length;i++){
				//if(myids[i].checked){
					var returnStr = id; //myids[i].value;
					/*art.dialog.open('<%=request.getContextPath()%>/member/orginfo!toAddUser.htm?sign=1&&id='+returnStr,
						{
							width: 800,
					    	height: 550,
					    	title:"艺人信息维护",
					   		//lock:true,
							close: function () {
					     		 location.reload();
					  		}
						}
					);*/
					art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toArtInfo.htm?sign=1&&userId='+returnStr,
					{
						width: 1050,
				    	height: 650,
				    	title:"才艺信息维护",
						close: function () {
				     		 location.reload();
				  		}
					});
					//return;
				//}
			//}
				//alert("请选择要维护的艺人！");
		//}
	
	}
	function toDqManager(id){
		//var  myids= document.all("ids");
	    //var myids= document.getElementsByName('www_zzjs_net');
	    
		//if(myids != null ){
			//for(var i=0;i<myids.length;i++){
				//if(myids[i].checked){
					var returnStr = id; //myids[i].value;
					art.dialog.open('<%=request.getContextPath()%>/member/scheduleInfo!toScheduleInfo.htm?id='+returnStr,
					{
						width: 850,
				    	height: 670,
				    	title:"艺人档期维护",
				   		//left: '0%',
				   		//top: '0%',
				   		//lock:true,
						close: function () {
				     		 location.reload();
				  		}
					});
					//return;
				//}
			//}
			//alert("请选择要维护的艺人！");
		//}
	
	}
	function chewww_zzjs_netValidate(cb) {
		for (var j = 0; j < 10; j++) {
			if (eval("document.zzjs_net.www_zzjs_net[" + j + "].checked") == true) {
			document.zzjs_net.www_zzjs_net[j].checked = false;
			if (j == cb) {
				document.zzjs_net.www_zzjs_net[j].checked = true;
				}
			}
		}
	}
 </script>
  </body>
</html>