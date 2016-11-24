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
	
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		

        function doSubmit(){
        	var drawbackAmount=$("#drawbackAmount").val();
        	var drawbackCause=$("#drawbackCause").val();
        	var returnPrice=$("#returnPrice").text();
        	
        	if(drawbackAmount==""){
        		art.dialog.tips("退款金额不能为空！");
            	return;
        	}
        	if(drawbackCause==""){
        		art.dialog.tips("退款原因不能为空！");
            	return;
        	}
			if(drawbackAmount*1>returnPrice*1){
        		art.dialog.tips("退款金额超出交易金额！");
        		$("#drawbackAmount").val(returnPrice);
				
				var price = accMul(returnPrice, $("#choucheng").val());
				price = accDiv(price, 100);
				price = Number(returnPrice) - Number(price);
				$("#price").html(price.toFixed(2));
        		return;
        	}
        	
 			
			$.ajax({
			   url:"<%=request.getContextPath() %>/member/drawback!doAddDrawback.htm",
			   type:'POST',
			   data:$("#drawBackForm").serialize(),
			   success:function(data){
				   if(data == 1){
						parent.window.location.href = "<%=request.getContextPath() %>/member/drawback!myDrawback.htm";
				   }
			   }
			});
	        
        }
        
        function clickRadio(radioValue){
         	 $("#pjGrade").val(radioValue);
		}
		
		function allBackAmount(){
			var businessAmount=$("#returnPrice").text();
			$("#drawbackAmount").val(businessAmount);
			
			var price = accMul(businessAmount, $("#choucheng").val());
			price = accDiv(price, 100);
			price = Number(businessAmount) - Number(price);
			$("#price").html(price.toFixed(2));
		}
		
		function calPrice() {
			if(!DoWell.Valid.isIntegerUnsigned($("#drawbackAmount").val()) && $("#drawbackAmount").val() != "") {
				$("#drawbackAmount").val(1);
			}
			var businessAmount = $("#drawbackAmount").val();
			
			var price = accMul(businessAmount, $("#choucheng").val());
			price = accDiv(price, 100);
			price = Number(businessAmount) - Number(price);
			$("#price").html(price.toFixed(2));
		}
		//小数相乘
		function accMul(arg1, arg2) {   
			var m = 0, s1 = arg1.toString(), s2 = arg2.toString();   
			try { m += s1.split(".")[1].length } catch (e) { }   
			try { m += s2.split(".")[1].length } catch (e) { }   
			return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
		} 
		//小数相除
		function accDiv(arg1, arg2) {
            var t1 = 0, t2 = 0, r1, r2;
            try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
            try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
            with (Math) {
                r1 = Number(arg1.toString().replace(".", ""))
                r2 = Number(arg2.toString().replace(".", ""))
                return (r1 / r2) * pow(10, t2 - t1);
            }
        }
	</script>
  </head>
  <body>
	<form id="drawBackForm" name="drawBackForm" action="member/drawback!doAddDrawback.htm" method="post">
	<input type="hidden" name="drawback.businessId" value="${businessId }"/> 
	<input type="hidden" name="drawback.choucheng" id="choucheng" value="<s:property value="#request.choucheng"/>" />
	
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="340" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">申请退款</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
           	<tr>
                <td  align="right" width="150px">交易编号：</td>
                <td  align="left" colspan="3"><span>${businessNo }</span></td>
            </tr>
            <tr>
                 <td  align="right" width="150px">交易金额：</td>
                <td  align="left" colspan="3"><span id="businessAmount">${businessAmount }</span></td>
            </tr>
            <tr>
                 <td  align="right" width="150px">可退款金额：</td>
                <td  align="left" colspan="3"><span id="returnPrice">${returnPrice }</span></td>
            </tr>
            <tr>
                <td  align="right" ><font color="red">*</font>退款金额：</td>
                <td  align="left" colspan="3" ><input type="text" name="drawback.drawbackAmount" id="drawbackAmount" onkeyup="calPrice()" />
                		<input type="button" name="allBack" id="allBack" value="全额退款" onclick="allBackAmount();"/></td>
             </tr>
            <tr>
                <td  align="right" >实际退款金额：</td>
                <td  align="left" colspan="3" ><span id="price"></span><span style="color:red;">(扣除手续费<s:property value="#request.choucheng"/>%)</span></td>
             </tr>
		    <tr>
		        <td align="right"><font color="red">*</font>退款原因：</td>
		        <td align="left" colspan="3"><textarea name="drawback.drawbackCause" id="drawbackCause" cols="20" rows="4" class="add_popup_textarea " style="width:350px;"></textarea></td>
		     </tr>
		     <tr>
		       <td align="right"></td>
		       <td colspan="3" style="color:#F00;" id="yzxx"></td>
		     </tr>
		    <tr>
		        <td colspan="4" align="center">
		        <a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
		        <a href="javascript:CloseWin();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
		        </td>
		        </tr>
		</table>
        

        </div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
	
 
        </form>
  </body>
</html>