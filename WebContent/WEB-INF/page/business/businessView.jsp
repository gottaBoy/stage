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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/validate.js"></script>

<script type="text/javascript">

$(function(){
	//alert("${businessInfo.beginTime}");
	var otherCost1 = "${businessInfo.otherCost1 }";
	var otherCost2 = "${businessInfo.otherCost2 }";
	var otherCost3 = "${businessInfo.otherCost3 }";
	if(otherCost1 != "") {
		$("#otherCost_1").attr("checked", true);
	}
	if(otherCost2 != "") {
		$("#otherCost_2").attr("checked", true);
	}
	if(otherCost3 != "") {
		$("#otherCost_3").attr("checked", true);
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

function downloadFile() {
	$(".orderFileClass").each(function(){
		var a = document.createElement("a");
		a.setAttribute("href", "<%=request.getContextPath() %>/download.htm?fileName=" + $(this).val());
		a.setAttribute("target", "_blank");
		a.setAttribute("id", "openwin");
		document.body.appendChild(a);
		a.click();  		
	});	
}
	
function confrim() {
	document.getElementById("alipayment").submit();
}

function updateBusinessInfoStatus(id,status, oldS){
	var info="";	
	if(oldS && oldS>1 && status==9 ) {
		if(oldS ==2) {
			info="订单已经确认，如果取消订单会降低您的评价！";
		} else if (oldS ==3) {
			info="订单已经完成，如果取消订单会降低您的评价！";
		} else if (oldS ==4) {
			info="订单已经确认完成，如果取消订单会降低您的评价！";
		} else if (oldS ==5) {
			info="订单已经到期完成，如果取消订单会降低您的评价！";
		} 
	}	
	art.dialog({
		icon: 'warning',
		content: '您确认进行此操作吗？'+info,
		ok: function () {
			$.post('<%=request.getContextPath()%>/member/business!updateBusinessInfoStatus.htm?id='+id+'&status='+status,
				function(data){
					if(data=="0"){
						window.location.reload();
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
		},
		cancel: true
	});
}


function addDrawback(id){
	art.dialog.open('<%=request.getContextPath() %>/member/drawback!addDrawback.htm?id='+id,{width:550,height:480,resize: false});
}
</script>

  </head>
 
 
<body >

<form id="alipayment" action="<%=request.getContextPath() %>/alipay/goAlipay.jsp" method=post target="_self">
<input type="hidden" name="orderNo" value="${businessInfo.orderCode }" />
</form>
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
                <td width="160" align="center">执行任务</td>
                <td width="160" align="center">任务完成</td>
                <td width="170" align="center">线下付款</td>
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
                <td width="160" align="center"><s:date name="businessInfo.createTime6" format="yyyy-MM-dd HH:mm:ss" /></td>
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
              <td><textarea name="businessInfo.content" id="content" cols="70" readonly="readonly" rows="10">${businessInfo.content }</textarea></td>
              <td rowspan="3" valign="top">
                <div style="padding-left:20px;">商家：<s:property value='#request.shangjia'/></div>
                <div style="padding-left:20px; padding-top:20px;">订单号：${businessInfo.orderCode }</div>
                <div style="padding-left:20px; padding-top:30px;">订单状态：<span style="font-size:20px;">
                  <s:if test="#request.businessInfo.status==1">等待确认</s:if>
                  <s:if test="#request.businessInfo.status==2">等待执行任务</s:if>
                  <s:if test="#request.businessInfo.status==3">任务已完成-等待付款</s:if>
                  <s:if test="#request.businessInfo.status==4">任务确认完成-等待付款</s:if>
                  <s:if test="#request.businessInfo.status==5">任务到期完成-等待付款</s:if>
                  <s:if test="#request.businessInfo.status==6">已付款-订单已完成</s:if>
                  <s:if test="#request.businessInfo.status==7">退款申请中</s:if>
                  <s:if test="#request.businessInfo.status==8">退款已完成</s:if>
                  <s:if test="#request.businessInfo.status==9">订单已关闭</s:if></span></div>
                  <div style="padding-left:20px; padding-top:20px;">
                    <s:if test="#request.businessInfo.id!=null">
                    <s:if test="#request.fileList.size>0">
                      <div><input value="下载文件" type="button" onclick="downloadFile()" class="control_btn_wide_yellow" /></div>
                      <s:iterator value="#request.fileList" var="item" status="ci">
                        <input class="orderFileClass" type="hidden" value="<s:property value='#item.id'/>.<s:property value='#item.suffix'/>" />
                        <div style="line-height:25px; font-size:16px;"><s:property value='#item.attachName'/></div>
                      </s:iterator>
                    </s:if>
                  </s:if>
                  </div>
              </td>
            </tr>
            <tr height="40">
              <td align="right">任务时间：</td>
              <td align="left">${businessInfo.beginDate }&nbsp;${businessInfo.beginTime }点&nbsp;&nbsp;——&nbsp;
                ${businessInfo.endDate }&nbsp;${businessInfo.endTime }点
              </td>
            </tr>
            <tr height="40">
              <td align="right" valign="top">任务地点：</td>
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
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="20%">酬金单价（元）</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="30%">购买数量</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="20%">总价（元）</td>
            </tr>
            <s:iterator value="#request.costList" var="item" status="ci">
              <tr height="40">
                <td align="center">
                  <span><s:property value="#item[1]"/> <s:property value="#item[0].keywords"/></span>
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
          <div style="padding-top:10px; padding-bottom:10px; padding-left:70px;"><input disabled="disabled" name="otherCost" type="checkbox" id="otherCost_1"/>交通费<span style="padding-left:20px;" id="otherCostSpan1">${businessInfo.otherCost1 }</span>
            <span><input name="otherCost" disabled="disabled" type="checkbox" id="otherCost_2"/></span>住宿费<span style="padding-left:20px;" id="otherCostSpan2">${businessInfo.otherCost2 }</span>    
            <span><input name="otherCost" disabled="disabled" type="checkbox" id="otherCost_3"/></span>餐饮费<span style="padding-left:20px;" id="otherCostSpan3">${businessInfo.otherCost3 }</span>        
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
          <div style="float:left; padding-top:30px; margin-left:20px; cursor:pointer; background:url(<%=request.getContextPath() %>/theme/images2/fapiao.png) no-repeat 0px 23px;; height:25px; display:none;"><span style="padding-left:30px;">发票问题请点击</span></div>
          
          <!--我是老板-->
          <s:if test="#request.businessInfo.buyer==#request.loginUserId">
            <s:if test="#request.businessInfo.status<6 ">
				<div onclick="javascript:updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,9,<s:property value='#request.businessInfo.status'/>);" style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;text-align:center;">取消订单</div>
            </s:if>
            <s:if test="#request.businessInfo.status==2 || #request.businessInfo.status==3 ">
              <div onclick="javascript:updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,4);"  style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;text-align:center;">确认任务完成</div>
            </s:if>
          </s:if>
          <!--我是艺人-->
          <s:else>
            <s:if test="#request.businessInfo.status==1">
              <div style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/jjdd.png) no-repeat; width:80px; height:30px; cursor:pointer;" onclick="updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,9);"></div>
              <div style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/jsdd.png) no-repeat; width:80px; height:30px; cursor:pointer;" onclick="updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,2);"></div>
			</s:if>
			<s:else>
				<s:if test="#request.businessInfo.status<6 ">
					<div onclick="javascript:updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,9,<s:property value='#request.businessInfo.status'/>);" style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;text-align:center;">取消订单</div>
				</s:if>            
			</s:else>
            <s:if test="#request.businessInfo.status==2 ">
              <div onclick="javascript:updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,3);"  style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;text-align:center;">任务完成</div>
            </s:if>
            <s:if test="#request.businessInfo.status==4 ">
              <div onclick="javascript:updateBusinessInfoStatus(<s:property value='#request.businessInfo.id'/>,6);"  style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;text-align:center;">确认付款完成</div>
            </s:if>
          </s:else>
		<div onclick="javascript:window.close();" style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;text-align:center;">关闭</div>
          
        </td>
	</tr>
</table>



  </body>
</html>
