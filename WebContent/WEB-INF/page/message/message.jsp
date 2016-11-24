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
    
    function toView(messageId){
		art.dialog.open('<%=request.getContextPath() %>/member/message!toMessageView.htm?messageId='+messageId,{width:550,height:400,resize: false});
		$("#status_"+messageId).text("已读");
	}
	
	function toAdd(messageId){
		art.dialog.open('<%=request.getContextPath() %>/member/message!toAddMessage.htm?messageId='+messageId,{width:550,height:330,resize: false});
	}
	
	 function delMessage(sign,id){
	    	art.dialog({
		        icon: 'warning',
				content: '您确认删除吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath() %>/member/message!delMessage.htm?sign='+sign+'&id='+id,
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
		var myUserView=null;
		function userView(userId){
			if(myUserView!=null){
				myUserView.close();
				myUserView=window.open("<%=request.getContextPath() %>/presonList.htm?id="+userId,"userView");
			}else{
				myUserView=window.open("<%=request.getContextPath() %>/presonList.htm?id="+userId,"userView");
			}
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
        	<s:param name="menuFlag" value="8"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">站内短信</a></div>


<div class="right_tab">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/message!toMessage.htm?sign=1" id="font1">发送的消息</a></li>
<li><a href="<%=request.getContextPath() %>/member/message!toMessage.htm?sign=2" id="font2">接收的消息</a></li>
</ul>
</div>
<span class="clear"></span>

<!-- 标签页 内容一 -->
 <div id="TabTab03Con1" style="display:block" class="zndx_box01">
  <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
    <tr>
        <td width="107" align="center" class="zyfl_title">接收对象</td>
        <td width="167" align="center" class="zyfl_title">标题</td>
        <td width="300" align="center" class="zyfl_title">内容</td>
        <td width="130" align="center" class="zyfl_title">发送时间</td>
        <td width="86" align="center" class="zyfl_title">操作</td>
    </tr>
     <s:iterator value="#request.messageList" var="message">
    <tr>
        <td align="center"><a href="javaScript: userView(<s:property value="#message[3]"/>);" class="czjl_title_link"><s:property value="#message[2]"/>(<s:property value="#message[1]"/>)</a></td>
        <td align="center" style="line-height: 17px;word-break:break-all;"><a href="javaScript: toView(<s:property value="#message[0].id"/>);" class="czjl_title_link">
        	<s:if test="#message[0].title.length()>=10">
	         	<s:property value='#message[0].title.substring(0,10)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#message[0].title"/></s:else> &nbsp;	  
        </a></td>
        <td align="left" style="line-height: 17px;word-break:break-all;">
        	<s:if test="#message[0].content.length()>=26">
	         	<s:property value='#message[0].content.substring(0,26)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#message[0].content"/></s:else> &nbsp;	  
      	</td>
        <td align="center"><s:property value="#message[0].creatTime"/></td>
        <td align="center"><a href="javascript:delMessage(1,<s:property value="#message[0].id"/>);" class="czjl_title_link">删除</a></td>
    </tr>
    </s:iterator>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="message!toMessage.htm" params='sign=1' total='${total}' ></pg:pages></td>
    </tr>
</table>
</td>
    </tr>
</table>
</div>

<!-- 标签页 内容二 -->
<div id=TabTab03Con2 style="display:none" class="zndx_box01">
  <table width="790" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="zyfl_table">
    <tr>
        <td width="107" align="center" class="zyfl_title">发送人</td>
        <td width="167" align="center" class="zyfl_title">标题</td>
        <td width="220" align="center" class="zyfl_title">内容</td>
        <td width="130" align="center" class="zyfl_title">接收时间</td>
        <td width="80" align="center" class="zyfl_title">阅读状态</td>
        <td width="86" align="center" class="zyfl_title">操作</td>
    </tr>
    <s:iterator value="#request.messageList" var="message">
    <tr>
        <td align="center"><a href="javaScript: userView(<s:property value="#message[3]"/>);" class="czjl_title_link"><s:property value="#message[2]"/>(<s:property value="#message[1]"/>)</a></td>
        <td align="center" style="line-height: 17px;word-break:break-all;"><a href="javaScript: toView(<s:property value="#message[0].id"/>);" class="czjl_title_link">
        	<s:if test="#message[0].title.length()>=10">
	         	<s:property value='#message[0].title.substring(0,10)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#message[0].title"/></s:else> &nbsp;</a>
        </td>
        <td align="left" style="line-height: 17px;word-break:break-all;">
        	<s:if test="#message[0].content.length()>=26">
	         	<s:property value='#message[0].content.substring(0,26)'/><b>...</b>
	         </s:if>     
             <s:else><s:property value="#message[0].content"/></s:else> &nbsp;	
        </td>
        <td align="center"><s:property value="#message[0].creatTime"/></td>
        <td align="center" id="status_<s:property value="#message[0].id"/>"> <s:if test="#message[0].status==1">已读</s:if><s:else><font color="red">未读</font></s:else></td>
        <td align="center">
        	<a href="javaScript: toAdd(<s:property value="#message[0].id"/>);" class="czjl_title_link">回复</a>
        	<a href="javascript:delMessage(2,<s:property value="#message[0].id"/>);" class="czjl_title_link">删除</a></td>
        
    </tr>
    </s:iterator>
 </table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="message!toMessage.htm" params='sign=2' total='${total}' ></pg:pages></td>
    </tr>
</table>
</td>
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
