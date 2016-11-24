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
	
	/*var time = 0;
	var timer = setInterval(function(){			  
		time++;
		if(time == 4) {
			clearInterval(timer);
			$("#contentTable").css("display", "none");
			$("#comfirmTable").css("display", "");
		}
	},1000);*/
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
  
<form id="alipayment" action="<%=request.getContextPath() %>/alipay/goAlipay.jsp" method=post target="_self">
<input type="hidden" name="orderNo" value="${businessInfo.orderCode }" />
<!-- 
<input type="hidden" name="total_fee" value="${total_fee}" />
<input type="hidden" name="out_trade_no" value="${out_trade_no}" /> -->
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr height="90">
		<td valign="bottom"><div style="background:url(<%=request.getContextPath() %>/theme/images2/tu02.jpg) no-repeat;height:53px; width:201px; padding-bottom:10px;"></div></td>
	</tr>
	<tr height="45">
		<td style="background-color:#2D3134;"><div style="padding-left:15px; font-size:14px; font-weight:bold; color:#FFF;">订单详细信息</div></td>
	</tr>
	<tr height="80">
		<td align="center">
            <table border="0" width="100%" style="border:0px solid red;">
              <tr>
                <td width="160" align="center">填写任务信息</td>
                <td width="160" align="center">任务确认</td>
                <td width="170" align="center">付款</td>
                <td width="160" align="center">执行任务</td>
                <td width="160" align="center">任务完成</td>
                <td width="" align="center">评价</td>
              </tr>
            </table>
            <s:if test="#request.businessInfo.id!=null">
              <s:if test="#request.businessInfo.status==1">
                <div style="padding-top:10px; padding-left:66px;">
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_1-2.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_3-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                </div>
              </s:if>
              <s:elseif test="#request.businessInfo.status==2">
                <div style="padding-top:10px; padding-left:66px;">
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_1-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-2.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_3-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                </div>
              </s:elseif>
              <s:elseif test="#request.businessInfo.status==3 || #request.businessInfo.status==4">
                <div style="padding-top:10px; padding-left:66px;">
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_1-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-2.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_3-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                </div>
              </s:elseif>
              <s:elseif test="#request.businessInfo.status==5">
                <div style="padding-top:10px; padding-left:66px;">
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_1-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-2.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_3-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                </div>
              </s:elseif>
              <s:elseif test="#request.businessInfo.status==6">
                <div style="padding-top:10px; padding-left:66px;">
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_1-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-2.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_3-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                </div>
              </s:elseif>
              <s:elseif test="#request.businessInfo.status==10||#request.businessInfo.status==11||#request.businessInfo.status==12">
                <div style="padding-top:10px; padding-left:66px;">
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_1-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_2-1.png) no-repeat;height:32px; width:32px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_4.png) repeat-x;height:32px; width:135px; float:left;"></div>
                  <div style="background:url(<%=request.getContextPath() %>/theme/images2/bz_3-2.png) no-repeat;height:32px; width:32px; float:left;"></div>
                </div>
              </s:elseif>
            </s:if>
          <s:if test="#request.businessInfo.id!=null">
            <table border="0" width="100%" style="border:0px solid red; height:40px;">
              <tr>
                <td width="160" align="center"><s:date name="businessInfo.createTime" format="yyyy-MM-dd HH:mm:ss" /></td>
                <td width="160" align="center"><s:date name="businessInfo.createTime2" format="yyyy-MM-dd HH:mm:ss" /></td>
                <td width="170" align="center"><s:date name="businessInfo.createTime3" format="yyyy-MM-dd HH:mm:ss" /></td>
                <td width="160" align="center"><s:date name="businessInfo.createTime4" format="yyyy-MM-dd HH:mm:ss" /></td>
                <td width="160" align="center"><s:date name="businessInfo.createTime5" format="yyyy-MM-dd HH:mm:ss" /></td>
                <td width="" align="center"><s:date name="businessInfo.createTime9" format="yyyy-MM-dd HH:mm:ss" /></td>
              </tr>
            </table>
          </s:if>
        </td>
	</tr>
	<tr>
		<td style="border-bottom:3px solid #2D3134;"></td>
	</tr>
	<tr>
		<td>
          <table style="padding-top:10px;padding-bottom:10px;">
            <tr>
              <td width="100" valign="top" align="right">任务内容：</td>
              <td><textarea name="orderRemark" id="content" cols="70" readonly="readonly" rows="10">${businessInfo.content }</textarea></td>
              <td rowspan="3" valign="top">
                <div style="padding-left:20px;">商家：<s:property value='#request.shangjia'/></div>
                <div style="padding-left:20px; padding-top:20px;">订单号：${businessInfo.orderCode }</div>
                <div style="padding-left:20px; padding-top:50px;">订单状态：<span style="font-size:20px;">
                  <s:if test="#request.businessInfo.status==1">等待确认</s:if>
                  <s:if test="#request.businessInfo.status==2">等待付款</s:if>
                  <s:if test="#request.businessInfo.status==3">已部分付款</s:if>
                  <s:if test="#request.businessInfo.status==4">已付款</s:if>
                  <s:if test="#request.businessInfo.status==5">演出已完成</s:if>
                  <s:if test="#request.businessInfo.status==6">订单已完成</s:if>
                  <s:if test="#request.businessInfo.status==7">退款申请中</s:if>
                  <s:if test="#request.businessInfo.status==8">退款已完成</s:if>
                  <s:if test="#request.businessInfo.status==9">订单已关闭</s:if></span></div>
              </td>
            </tr>
            <tr height="40">
              <td align="right">时间：</td>
              <td align="left">${businessInfo.beginDate }&nbsp;${businessInfo.beginTime }点&nbsp;&nbsp;——&nbsp;
                ${businessInfo.endDate }&nbsp;${businessInfo.endTime }点
              </td>
            </tr>
            <tr height="40">
              <td align="right" valign="top">地点：</td>
              <td>
                ${businessInfo.provice }&nbsp;${businessInfo.city }<br /><br />
                ${businessInfo.address }
              </td>
            </tr>
          </table>
		</td>
	</tr>
	<tr>
		<td>
          <table width="100%" cellpadding="0" cellspacing="0">
            <tr height="40" bgcolor="#ECECED">
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="30%">职业</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="20%">单价/元</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="30%">单位</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="20%">价格/元</td>
            </tr>
            <s:iterator value="#request.costList" var="item" status="ci">
              <tr height="40">
                <td align="center">
                  <span><s:property value="#item[1]"/></span>
                </td>
                <td align="center">
                  <span id="cost_<s:property value='#item[0].id'/>"><s:property value="#item[0].price"/></span>
                </td>
                <td align="center">
                  <span id="day_<s:property value='#item[0].id'/>"><s:property value="#item[0].days"/></span>
                </td>
                <td align="center">
                  <span id="price_<s:property value='#item[0].id'/>"></span>
                  <script>setPrice("<s:property value='#item[0].id'/>");</script>
                </td>
                  
              </tr>
            </s:iterator>
          </table>
        </td>
	</tr>
	<tr>
		<td><div style="border-top:#999 1px dashed; width:90%; margin:auto;"></div></td>
	</tr>
	<tr>
		<td>
          <div style="padding-top:10px; padding-left:50px;">其他费用：</div>
          <div style="padding-top:10px; padding-bottom:10px; padding-left:70px;"><input disabled="disabled" name="otherCost" type="checkbox" id="otherCost_1"/>车船费<span style="padding-left:20px;" id="otherCostSpan1">${businessInfo.otherCost1 }</span>
            <span><input name="otherCost" disabled="disabled" type="checkbox" id="otherCost_2"/></span>住宿费<span style="padding-left:20px;" id="otherCostSpan2">${businessInfo.otherCost2 }</span>          
          </div>
        </td>
	</tr>
	<tr height="70">
		<td style="border-bottom:2px solid #c3c3c3;border-top:3px solid #2D3134;" bgcolor="#ECECED">
          <div style="float:left; margin-left:20px; cursor:pointer; display:none;">
            <input disabled="disabled" name="isByStages_box" type="checkbox" id="isByStages_box" />分期支付
          </div>
          <div style="float:right; margin-right:20px;">
            <span>实付总额：</span>
            <span id="price" style="color:red; font-size:16px; font-weight:bold;">￥${businessInfo.price}元</span>
          </div>
        </td>
	</tr>
	<tr height="40" style="display:none;" id="tr_byStages">
		<td>
          <table width="100%" cellpadding="0" cellspacing="0">
            <tr height="40" bgcolor="#ECECED">
              <td align="center" width="40%">付款日期</td>
              <td align="center" width="20%">付款比例</td>
              <td align="center" width="45%">实付金额</td>
            </tr>
            
            <s:if test="#request.paymentList.size>0">
              <s:iterator value="#request.paymentList" var="item" status="ci">
                <tr height="40">
                  <td align="center">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;"><s:property value='#item.pos'/></span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<s:date name='paymentTime' format='yyyy-MM-dd' /></td>
                  <td align="center"><s:property value='#item.payRatio'/>&nbsp;%</td>
                  <td align="center"><span><s:property value='#item.price'/></span></td>
                </tr>
              </s:iterator>
            </s:if>
            
            <tr height="40" id="last_tr">
              <td align="center" colspan="4"><div style="border-top:#999 1px dashed; width:90%; margin:auto;"></div></td>
            </tr>
          </table>
        </td>
	</tr>
	<tr height="90">
		<td>
          <div style="float:right; padding-top:30px; margin-right:20px; cursor:pointer; background:url(<%=request.getContextPath() %>/theme/images2/fk.png) no-repeat; height:30px; width:80px;" onclick="confrim()"></div>
          
        </td>
	</tr>
</table>

</form>


	
 
  </body>
</html>
