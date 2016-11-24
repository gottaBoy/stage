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
    
     function toDrawbackView(id){
		art.dialog.open('<%=request.getContextPath()%>/member/drawback!toDrawbackView.htm?id='+id,{resize: false});
	}
    
    function toBusinessView(id){
		window.open('<%=request.getContextPath()%>/member/business!toBusinessView.htm?id='+id);
	}
	
	function confrimOrder(id) {
		
		
		$.post('<%=request.getContextPath() %>/member/drawback!checkDrawback.htm?id='+id,
			function(data){
				if(data=="1"){
					art.dialog.open('<%=request.getContextPath() %>/member/drawback!confirmDrawback.htm?id='+id,{width:550,height:400,resize: false});
				} else {
					art.dialog.tips("请刷新后再试！");
				}
		},"html");
	}
	  
	function editDrawback(id){
		art.dialog.open('<%=request.getContextPath() %>/member/drawback!editDrawback.htm?id='+id,{width:550,height:480,resize: false});
	}
    
    function updateDrawbackStatus(id,status){
	    	art.dialog({
		        icon: 'warning',
				content: '您确认进行此操作吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/drawback!updateDrawbackStatus.htm?id='+id+'&status='+status,
						function(data){
							if(data=="1"){
							//art.dialog.tips("操作成功!");
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
        	<s:param name="menuFlag" value="20"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">退款管理</a></div>


<div class="right_tab">
<ul>
<li><a class="change" href="<%=request.getContextPath() %>/member/drawback!myDrawback.htm?sign=1" id="font1">我申请的</a></li>
<li><a href="<%=request.getContextPath() %>/member/drawback!myDrawback.htm?sign=2" id="font2">我收到的</a></li>
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
    	<td width="100" align="center" class="zyfl_title">退款编号</td>
        <td width="100" align="center" class="zyfl_title">订单编号</td>
        <td width="120" align="center" class="zyfl_title">被签约者</td>
        <td width="80" align="center" class="zyfl_title">交易金额</td>
        <td width="80" align="center" class="zyfl_title">退款金额</td>
        <td width="80" align="center" class="zyfl_title">申请时间</td>
        <td width="80" align="center" class="zyfl_title">退款时间</td>
        <td width="80" align="center" class="zyfl_title">状态</td>
        <td width="80" align="center" class="zyfl_title">操作</td>
    </tr>
     <s:iterator value="#request.drawbackList" var="drawback">
    <tr>
        <td align="center"><a href="javaScript: toDrawbackView(<s:property value="#drawback[0].id"/>);" class="czjl_title_link">
        	<s:property value="#drawback[0].drawbackNo"/></a></td>
        <td align="center"><a href="javaScript: toBusinessView(<s:property value="#drawback[0].businessId"/>);" class="czjl_title_link">
        	<s:property value="#drawback[3].orderCode"/></a></td>
        <td align="center"><a href="javaScript: userView(<s:property value="#drawback[3].seller"/>);" class="czjl_title_link">
        	<s:property value="#drawback[2]"/></a></td>
        <td align="center"><s:property value="#drawback[3].price"/></td>
        <td align="center"><s:property value="#drawback[0].drawbackAmount"/></td>
        <td align="center"><s:property value="#drawback[0].creatTime.substring(0,10)"/></td>
        <td align="center"><s:if test="#drawback[0].drawbackDate==null">&nbsp;</s:if><s:else><s:property value="#drawback[0].drawbackDate.substring(0,10)"/></s:else></td>
        <td align="center">
        	<s:if test="#drawback[0].status==1">等待退款</s:if>
        	<s:if test="#drawback[0].status==2">已付款</s:if>
        	<s:if test="#drawback[0].status==3">退款成功</s:if>
        	<s:if test="#drawback[0].status==4">对方拒绝退款</s:if>
        	<s:if test="#drawback[0].status==5">已关闭</s:if>
        </td>
        <td align="center">
        	<s:if test="#drawback[0].status==1"><a href="javaScript:editDrawback(<s:property value="#drawback[0].id"/>);" class="czjl_title_link">修改</a>&nbsp;&nbsp;<a href="javaScript:updateDrawbackStatus(<s:property value="#drawback[0].id"/>,'5');" class="czjl_title_link">撤销</a></s:if>
        	
        </td>
    </tr>
    </s:iterator>
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="drawback!myDrawback.htm" params='sign=1' total='${total}' ></pg:pages></td>
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
       <td width="100" align="center" class="zyfl_title">退款编号</td>
        <td width="100" align="center" class="zyfl_title">订单编号</td>
        <td width="80" align="center" class="zyfl_title">签约者</td>
        <td width="80" align="center" class="zyfl_title">被签约者</td>
        <td width="70" align="center" class="zyfl_title">交易金额</td>
        <td width="70" align="center" class="zyfl_title">退款金额</td>
        <td width="70" align="center" class="zyfl_title">申请时间</td>
        <td width="70" align="center" class="zyfl_title">退款时间</td>
        <td width="80" align="center" class="zyfl_title">状态</td>
        <td width="80" align="center" class="zyfl_title">操作</td>
    </tr>
   <s:iterator value="#request.drawbackList" var="drawback">
    <tr>
        <td align="center"><a href="javaScript: toDrawbackView(<s:property value="#drawback[0].id"/>);" class="czjl_title_link">
        	<s:property value="#drawback[0].drawbackNo"/></a></td>
        <td align="center"><a href="javaScript: toBusinessView(<s:property value="#drawback[0].businessId"/>);" class="czjl_title_link">
        	<s:property value="#drawback[3].orderCode"/></a></td>
        <td align="center"><a href="javaScript: userView(<s:property value="#drawback[3].buyer"/>);" class="czjl_title_link">
        	<s:property value="#drawback[2]"/></a></td>
        <td align="center"><a href="javaScript: userView(<s:property value="#drawback[3].seller"/>);" class="czjl_title_link">
        	<s:property value="#drawback[4]"/></a></td>
        <td align="center"><s:property value="#drawback[3].price"/></td>
        <td align="center"><s:property value="#drawback[0].drawbackAmount"/></td>
        <td align="center"><s:property value="#drawback[0].creatTime.substring(0,10)"/></td>
        <td align="center"><s:if test="#drawback[0].drawbackDate==null">&nbsp;</s:if><s:else><s:property value="#drawback[0].drawbackDate.substring(0,10)"/></s:else></td>
        <td align="center">
        	<s:if test="#drawback[0].status==1">等待退款</s:if>
        	<s:if test="#drawback[0].status==2">已付款</s:if>
        	<s:if test="#drawback[0].status==3">退款成功</s:if>
        	<s:if test="#drawback[0].status==4">拒绝退款</s:if>
        	<s:if test="#drawback[0].status==5">已关闭</s:if>
        </td>
        <td align="center">
        	<s:if test="#drawback[0].status==1"><a href="javaScript:updateDrawbackStatus(<s:property value="#drawback[0].id"/>,'4');" class="czjl_title_link">拒绝</a>&nbsp;
        										<a href="javaScript:confrimOrder(<s:property value="#drawback[0].id"/>);" class="czjl_title_link">同意</a></s:if>
        </td>
    </tr>
    </s:iterator>
 </table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="drawback!myDrawback.htm" params='sign=2' total='${total}' ></pg:pages></td>
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
