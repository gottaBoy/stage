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

<script type="text/javascript">

$(function() {
		   
});

function updateOrderStatus() {
	var id = $("#orderId").val();
	var pos = 0;
	$(".confirmPay").each(function(){
		if($(this).attr("checked")) {
			pos = $(this).val();
		}
	});
	
	if(pos == 0) {
		art.dialog.tips("请选择一次付款记录!");
		return;
	}
	$.post('<%=request.getContextPath()%>/member/business!updateBusinessInfoStatus.htm?id='+id+'&status=6&pos='+pos,
		function(data){
			if(data=="0"){
				parent.window.location.reload();
			} else if(data=="1"){
				alert("订单已关闭！");
			} else if(data=="2"){
				alert("没有要付款的纪录！");
			} else if(data=="3"){
				alert("对方已确认付款！");
			} else if(data=="4"){
				alert("错误代码：" + data);
			}
	},"html");	
}
</script>
  </head>
  <body>
    <div id="content" style="padding-top:10px; padding-left:10px;">
      <input type="hidden" value="<s:property value="#request.orderId"/>" id="orderId" />
      <fieldset>
        <legend>待确认付款记录</legend>
        <table width="100%" cellpadding="0" cellspacing="0">
        <s:iterator value="#request.payList" var="item" status="ci">
          <tr height="40">
          	<td align="center" width="30"><input type="radio" class="confirmPay" name="confirmPay" value="<s:property value='#item.pos'/>" /></td>
            <td align="center" width="120">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;"><s:property value='#item.pos'/></span>&nbsp;&nbsp;次付款&nbsp;&nbsp;</td>
            <td align="center">金额:<span style="color:#0096D1; font-size:16px; font-weight:bold;"><s:property value='#item.price'/></span></td>
          </tr>
        </s:iterator>
        </table>
      </fieldset>
      
      
    </div>
    <div style="text-align: center; padding-top:10px;" >
        <input value="确认" type="button" onclick="updateOrderStatus()" class="control_btn_wide_yellow" />
    </div>
  </body>
</html>