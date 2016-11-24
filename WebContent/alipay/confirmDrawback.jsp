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

function confrim() {
	document.getElementById("alipayment").submit();
	
	var time = 0;
	var timer = setInterval(function(){			  
		time++;
		if(time == 4) {
			clearInterval(timer);
			$("#contentTable").css("display", "none");
			$("#comfirmTable").css("display", "");
		}
	},1000);
}

function reloadPage() {
	//alert(window.location.href);
	//window.location.href=window.location.href;
	parent.location.reload();
}

$(function(){
	var otherCost1 = "${businessInfo.otherCost1 }";
	var otherCost2 = "${businessInfo.otherCost2 }";
	if(otherCost1 != "") {
		$("#otherCost_1").attr("checked", true);
	}
	if(otherCost2 != "") {
		$("#otherCost_2").attr("checked", true);
	}
	
	var isByStages = "${businessInfo.isByStages}";
	if(isByStages == "2") {
		$("#isByStages_box").attr("checked", true);
		$("#tr_byStages").css("display", "");
	}
});

//计算选择职业的总价格
function setPrice(id) {
	$("#price_" + id).html($("#cost_" + id).html() * $("#day_" + id).html());
}

</script>
  </head>
  <body>
  
<form id="alipayment" action="<%=request.getContextPath() %>/alipay/goAlipay1.jsp" method=post target="_blank">
<input type="hidden" name="orderNo" value="${drawback.drawbackNo }" />

</form>
<table id="comfirmTable" style="display:none; margin-top:100px;" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr height="80">
        <td algin="center" colspan="2" style="font-size:18px; font-weight:bold;">请您在新打开的页面上完成付款</td>
    </tr>
    <tr height="50">
        <td algin="center" colspan="2" style="font-size:16px;">付款完成前请不要关闭此窗口
            <br />
            完成付款后请根据您的情况点击下面按钮</td>
    </tr>
    <tr height="80">
        <td algin="center" colspan="2" style="font-size:16px;">&nbsp;</td>
    </tr>
    <tr>
        <td algin="center" width="100"><a href="javascript:reloadPage();"><img src="<%=request.getContextPath() %>/theme/images2/paySuccess.png" width="129" height="34" /></a></td>
        <td algin="center" width="100"><a href="javascript:reloadPage();"><img src="<%=request.getContextPath() %>/theme/images2/payUnsuccess.png" width="130" height="34" /></a></td>
    </tr>
</table>
    
<table id="contentTable" width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="360" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box" style="height: 280px">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">退款信息</td>
                
                <td  align="right" style="color: red;">状态:
		            <s:if test="#request.drawback.status==1">等待退款</s:if>
                </td>
            </tr>
        </table>
        <table width="460"  border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
             <tr>
                <td width="80" align="center" >退款编号：</td>
                <td width="380" height="90" align="left">${drawback.drawbackNo }</td>
            </tr>
            <tr>
                <td align="center" >退款金额：</td>
                <td align="left">${drawback.drawbackAmount }&nbsp;元</td>
            </tr>
            <tr>
                <td align="center" >申请时间：</td>
                <td align="left">${drawback.creatTime }</td>
            </tr>
            <tr>
                <td align="center" style="vertical-align: top;">退款原因：</td>
                <td align="left">${drawback.drawbackCause }</td>
            </tr>
            <tr>
		       <td align="right"></td>
		       <td colspan="3" style="color:#F00;" id="yzxx"></td>
		     </tr>
            <tr>
                <td colspan="4" align="center">
 		        	<div style="cursor:pointer; background:url(<%=request.getContextPath() %>/theme/images/nav_qrimg.jpg) no-repeat; height:28px; width:60px;" onclick="confrim()"></div>
		        </td>
            </tr>
        </table>
        

        </div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
	
 
  </body>
</html>
