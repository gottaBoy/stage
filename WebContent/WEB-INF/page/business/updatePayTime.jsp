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

function closeDialog() {
	if($("#type").val() == 2) {
		parent.window.location.href = '<%=request.getContextPath() %>/member/business!mySellerList.htm?dfdf=<%=new Date()%>';
	}
}

function getElementsByClassName(className,tagName,type1,type2) { 
	var all = window.document.getElementsByTagName(tagName||"*"); 
	var elements = new Array(); 
	var x = 0;
	for(var e=0;e<all.length;e++) { 
		if((all[e].className==className)&&(all[e].type==type1||all[e].type==type2)) { 
			elements[x++]=all[e]; 
		} 
	} 
	return elements; 
} 

function dateCompare(startdate,enddate) {   
	var arr = startdate.split("-");    
	var starttime = new Date(arr[0],arr[1],arr[2]);    
	var starttimes = starttime.getTime();
	
	var arrs = enddate.split("-");    
	var lktime = new Date(arrs[0],arrs[1],arrs[2]);    
	var lktimes = lktime.getTime();
	
	if(starttimes >= lktimes) {   
		return true;   
	} else { 
		return false;
	}
} 

function updatePayTime(status) {
	var id = $("#orderId").val();
	var type = $("#type").val();
	
	if(type == 1) {
		
		var elements = getElementsByClassName("updateTimeClass", "input", "text", "hidden");
		for(var i = 0; i < elements.length; i++) {
			var e = elements[i];
			if($(e).val() == "" ) {
				message1 = "请选择修改日期！";
				art.dialog.tips("请选择修改日期！");
				return;
			}
			
			if(i != 0) {
				var thisId1 = $(elements[i-1]).attr("id");
				var id1 = thisId1.substring(thisId1.lastIndexOf("_") + 1, thisId1.length);
				if(dateCompare($("#updatePayTime_" + id1).val(), $(e).val())) {
					art.dialog.tips("付款日期必须比上一次付款日期晚！");
					return;
				}
			}
		}
		
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/business!doUpdatePayTime.htm",
		   type:'POST',
		   data:$("#updateTimeForm").serialize(),
		   success:function(data){
			   if(data=="1"){
					parent.window.location.reload();
			   }
		   }
		});
		
		/*$.post('<%=request.getContextPath()%>/member/business!doUpdatePayTime.htm?orderId='+id,
			function(data){
				if(data=="1"){
					parent.window.location.reload();
				}
		},"html");*/
	} else {
		$.post('<%=request.getContextPath()%>/member/business!updatePayTimeStatus.htm?status='+status+'&orderId='+id,
			function(data){
				if(data=="1"){
					parent.window.location.reload();
				}
		},"html");
	}
	
}

</script>
  </head>
  <body>
<form id="updateTimeForm" action="" method="post">
    <div id="content" style="padding-top:10px; padding-left:10px;">
      <input type="hidden" value="<s:property value='#request.orderId'/>" name="orderId" id="orderId" />
      <input type="hidden" value="<s:property value='#request.type'/>" id="type" />
      <fieldset>
        <legend>修改付款时间</legend>
        <table width="100%" cellpadding="0" cellspacing="0">
        	<tr height="40" bgcolor="#ECECED">
              <td align="center" width="40%">付款日期</td>
              <td align="center" width="20%">修改日期</td>
            </tr>
          <s:if test="#request.type==1">
            <s:iterator value="#request.payList" var="item" status="ci">
              <input type="hidden" value="<s:property value='#item.id'/>" name="paymentList[<s:property value='#ci.index'/>].id" />
              <input type="hidden" value="<s:property value='#item.orderId'/>" name="paymentList[<s:property value='#ci.index'/>].orderId" />
              <input type="hidden" value="<s:property value='#item.price'/>" name="paymentList[<s:property value='#ci.index'/>].price" />
              <input type="hidden" value="<s:property value='#item.price1'/>" name="paymentList[<s:property value='#ci.index'/>].price1" />
              <input type="hidden" value="<s:property value='#item.payRatio'/>" name="paymentList[<s:property value='#ci.index'/>].payRatio" />
              <input type="hidden" value="<s:property value='#item.actualPayTime'/>" name="paymentList[<s:property value='#ci.index'/>].actualPayTime" />
              <input type="hidden" value="<s:property value='#item.pos'/>" name="paymentList[<s:property value='#ci.index'/>].pos" />
              <input type="hidden" value="<s:property value='#item.isPay'/>" name="paymentList[<s:property value='#ci.index'/>].isPay" />
              <input type="hidden" value="<s:property value='#item.payTime'/>" name="paymentList[<s:property value='#ci.index'/>].payTime" />
              <input type="hidden" value="<s:property value='#item.isPayment'/>" name="paymentList[<s:property value='#ci.index'/>].isPayment" />
              <input type="hidden" value="<s:property value='#item.confrimPay'/>" name="paymentList[<s:property value='#ci.index'/>].confrimPay" />
              <tr height="40">
                <td align="center">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;"><s:property value='#item.pos'/></span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<s:date name='paymentTime' format='yyyy-MM-dd' />
                <input type="hidden" value="<s:date name='paymentTime' format='yyyy-MM-dd' />" name="paymentList[<s:property value='#ci.index'/>].paymentTime" />
                
                </td>
                <td align="center">
                <s:if test="#item.isPayment == 2">
                  已付款不能修改
                  <input type="hidden" class="updateTimeClass" value="<s:date name='paymentTime' format='yyyy-MM-dd' />" name="paymentList[<s:property value='#ci.index'/>].updatePayTime" id="updatePayTime_<s:property value='#item.pos'/>" />
                </s:if>
                <s:else>
                <input type="text" class="updateTimeClass" name="paymentList[<s:property value='#ci.index'/>].updatePayTime" id="updatePayTime_<s:property value='#item.pos'/>" style="width:80px;" onClick="WdatePicker()" readonly="readonly" />
                </s:else>
                </td>
              </tr>
            </s:iterator>
          </s:if>
          <s:else>
            <s:iterator value="#request.payList" var="item" status="ci">
              <tr height="40">
                <td align="center">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;"><s:property value='#item.pos'/></span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<s:date name='paymentTime' format='yyyy-MM-dd' />
                </td>
                <td align="center">
                <s:if test="#item.isPayment == 2">
                  已付款不能修改
                </s:if>
                <s:else>
                <s:date name='updatePayTime' format='yyyy-MM-dd' />
                </s:else>
                </td>
              </tr>
            </s:iterator>
          </s:else>
        </table>
      </fieldset>
      
      
    </div>
    <div style="text-align: center; padding-top:10px;" >
        
        <s:if test="#request.type==2">
        	<input value="同意" type="button" onclick="updatePayTime(2)" class="control_btn_wide_yellow" />
        	<input value="不同意" type="button" onclick="updatePayTime(3)" class="control_btn_wide_yellow" />
        </s:if>
        <s:else>
        	<input value="确认" type="button" onclick="updatePayTime()" class="control_btn_wide_yellow" />
        </s:else>
    </div>
</form>
  </body>
</html>