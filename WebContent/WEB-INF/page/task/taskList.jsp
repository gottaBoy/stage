<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
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

 	<script type="text/javascript">
 	
 	
	

	
	function setTab03Syn(i,obj){
		for(var j = 1 ; j<=2 ; j++){
			if(i==j){
				$("#TabTab03Con"+i).show();
				$("#font"+i).addClass("change");
			}else{
				$("#TabTab03Con"+j).hide();
				$("#font"+j).removeClass("change");
			}
		}
	}
	
	$().ready(function(){
   
   		<%String sign = (String)request.getParameter("sign");if(sign != null){%>
   		
   		<%}else{sign = "1";}%>
		setTab03Syn(<%=sign%>);
    });
    
    
    function toDel(id){

		art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/task!delTask.htm?id='+id,
						function(data){
							if(data=="1"){
							//art.dialog.tips("删除成功!");
							window.location.reload();
						}
					},"html");
					
				},
				cancel: true
		});	
	}
	
	
	function toCheck(id,flag){
	   
	   var str="";
	   if(flag==0){
	    	 str="屏蔽当前信息，您确定吗？";
	    }else if(flag==1){
	         str="取消置顶或屏蔽当前信息，您确定吗？";
	    }else if(flag==2){
	         str="置顶当前信息，您确定吗？";
	    }

		art.dialog({
		        icon: 'succeed',
				content: str,
				ok: function () {
				   $.post('<%=request.getContextPath()%>/member/task!checkTask.htm?id='+id+'&flag='+flag,
						function(data){
							if(data=="1"){
							//window.location.reload();
							window.location.href=window.document.location;
				  
						}
					},"html");

					
				},
				cancel: true
		});

		
	}
	
	function toView(id,flag){
		art.dialog.open('<%=request.getContextPath()%>/member/task!toView.htm?id='+id+'&flag='+flag,{width:550,height:400,resize: false});
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
        	<s:param name="menuFlag" value="12"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">需求管理</a></div>


<div class="right_tab_a">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/task!getTaskList.htm?sign=1" id="font1">用户任务</a></li>
<li><a href="<%=request.getContextPath() %>/member/task!getTaskList.htm?sign=2" id="font2">委托需求</a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 标签页 内容一 -->
<div id="TabTab03Con1" style="display:block" class="zndx_box01">


<table width="790" border="0" style="margin-right:10px" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td width="150" align="center" class="zyfl_title">标题</td>
	        <td width="230" align="center" class="zyfl_title">时间</td>	        
	        <td width="120" align="center" class="zyfl_title">地点</td>
	         <td width="80" align="center" class="zyfl_title">赏金</td>
	        <td width="120" align="center" class="zyfl_title">创建时间</td>
	        <td width="80" align="center" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.taskList" var="task">
		<tr>
		    <td  align="center"  ><a href="javascript:toView('<s:property value="#task.id"/>','1');" class="czjl_title_link">
		   <s:if test="#task.title.length()>=10">
	         	<s:property value='#task.title.substring(0,10)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#task.title"/></s:else>	
		    </td>	        
	        <td  align="center"  ><s:property value="#task.startDate"/>-<s:property value="#task.endDate"/>&nbsp;</td>
	       
	        <td  align="center"  ><s:property value="#task.place"/>&nbsp;</td>
	        <td  align="center"  ><s:property value="#task.price"/>&nbsp;元</td>
	        <td  align="center"  ><s:property value="#task.creatTime"/>&nbsp;</td>
	        <td  align="center"  >
	        
	            <s:if test="#task.active==1">
		      		<a href="javascript:toCheck('<s:property value="#task.id"/>','0');" class="czjl_title_link">屏蔽</a>
		      		<a href="javascript:toCheck('<s:property value="#task.id"/>','2');" class="czjl_title_link">置顶</a>	        
		        </s:if>
		        <s:elseif test="#task.active==0">
		        	<a href="javascript:toCheck('<s:property value="#task.id"/>','1');" class="czjl_title_link">取消屏蔽</a>
		        </s:elseif>
		        <s:elseif test="#task.active==2">
		        	<a href="javascript:toCheck('<s:property value="#task.id"/>','1');" class="czjl_title_link">取消置顶</a>
		        </s:elseif>
		        <s:else>
		          任务已结束
		        </s:else>
		       
	        </td>
	    </tr>
	</s:iterator>

</table>


<table width="790"  border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="task!getTaskList.htm" params='sign=1' total='${total}' ></pg:pages></td>
    </tr>
</table>
</div>


<!-- 标签页 内容二 -->
<div id=TabTab03Con2 style="display:none" class="zndx_box01">
<table width="790" border="0"  style="margin-right:10px" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
		<tr>
		    <td width="150" align="center" class="zyfl_title">标题</td>        
	        <td width="330" align="center" class="zyfl_title">内容</td>
	        <td width="100" align="center" class="zyfl_title">联系方式</td>
	        <td width="120" align="center" class="zyfl_title">创建时间</td>
	        <td width="80" align="center" class="zyfl_title">操作</td>
	    </tr>
	<s:iterator value="#request.taskList" var="task">
		<tr>
		    <td  align="center"  >
		    <a href="javascript:toView('<s:property value="#task.id"/>','2');" class="czjl_title_link">
		    <s:if test="#task.title.length()>=20">
	         	<s:property value='#task.title.substring(0,20)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#task.title"/></s:else>	    
		    </a></td>	        
	        <td  align="left"  >
	         <s:if test="#task.content.length()>=26">
	         	<s:property value='#task.content.substring(0,26)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#task.content"/></s:else> &nbsp;	        
	        </td>
	         <td  align="center"  ><s:property value="#task.mobile"/></td>
	        <td  align="center"  ><s:property value="#task.creatTime"/></td>
	        <td  align="center"  >
		        <a href="javascript:toDel('<s:property value="#task.id"/>');" class="czjl_title_link">删除</a>
	        </td> 
	    </tr>
	</s:iterator>

</table>
<table width="790" border="0"   style="margin-right:10px" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="task!getTaskList.htm" params='sign=2' total='${total}' ></pg:pages></td>
    </tr>
</table>
</div>






</td>
</tr>
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>
