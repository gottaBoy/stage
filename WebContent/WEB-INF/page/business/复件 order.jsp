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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/validate.js"></script>

<script type="text/javascript">
  	    
  	    //表单提交（加入购物车）
  	    function addMyCar(){
  	      	getCostData();
  	    	$("#businessFrom").attr("action","<%=request.getContextPath() %>/member/business!doAddMyCar.htm");
  	    	if(checknull()){
  	       		$("#businessFrom").submit();
  	       		parent.getMyCarCount();
   	       		parent.toMyCar();	//方法写在head.jsp
   	    		CloseWin();
  	       	}
   	    	
  	    }
  	    
		function checkContent(obj) {
			if(obj){
				if(obj.value=="请详细填写您的服务需求") {
					obj.value="";
				}
			}
		}
  	    
  	    
  	    
  	   

$(function(){
		   //setPaymentTimeOnClick();
	//alert("${businessInfo.beginTime}");
	$("#beginTime").val(${businessInfo.beginTime});
	$("#endTime").val(${businessInfo.endTime});
	if("${businessInfo.provice}"!="")
   		initAddress("provice","city","${businessInfo.provice}","${businessInfo.city}");  
	else
   		initAddress("provice","city","上海","${businessInfo.city}");  
	var otherCost1 = "${businessInfo.otherCost1 }";
	var otherCost2 = "${businessInfo.otherCost2 }";
	var otherCost3 = "${businessInfo.otherCost3 }";
	if(otherCost1 != "") {
		$("#otherCost_1").attr("checked", true);
		$("#otherCostSpan1").css("visibility", "visible");
	}
	if(otherCost2 != "") {
		$("#otherCost_2").attr("checked", true);
		$("#otherCostSpan2").css("visibility", "visible");
	}
	if(otherCost3 != "") {
		$("#otherCost_3").attr("checked", true);
		$("#otherCostSpan3").css("visibility", "visible");
	}
	
	$("#price").html("￥${businessInfo.price }元");
	
	var isByStages = "${businessInfo.isByStages}";
	if(isByStages == "2") {
		$("#isByStages_box").attr("checked", true);
		$("#tr_byStages").css("display", "");
	}
	
	var paymentListSize = "${paymentListSize}";
	if(paymentListSize != 0) {
		feiqiCount = paymentListSize;
	}
	
});

//显示职业的价格单位的输入框
function showCost(type, id) {
	if(type == 1) {
		$("#cost_" + id).css("display", "");
		$("#day_" + id).css("display", "");
		$("#price_" + id).css("display", "");
	} else if(type == 2) {
		if(!$("#checkbox_" + id).attr("checked")) {
			$("#cost_" + id).css("display", "none");
			$("#day_" + id).css("display", "none");
			$("#price_" + id).css("display", "none");
		}
	}
}

function setCostPrice(id) {
	if(!$("#checkbox_" + id).attr("checked")) {
		$("#cost_" + id).val("");
		$("#day_" + id).val("");
		$("#price_" + id).html("");
		setPrice(id);
		showCost(2, id);
	} else {
		showCost(1, id);	
	}
}

//计算选择职业的总价格
function setPrice(id) {
	if(!DoWell.Valid.isIntegerUnsigned($("#cost_" + id).val()) && $("#cost_" + id).val() != "") {
		$("#cost_" + id).val(0);
	}
	if(!DoWell.Valid.isIntegerUnsigned($("#day_" + id).val()) && $("#day_" + id).val() != "") {
		$("#day_" + id).val(0);
	}
	
	$("#price_" + id).html($("#cost_" + id).val() * $("#day_" + id).val());
	var totalPrice = 0;
	$(".costPrice").each(function(){
		totalPrice += Number($(this).html());				  
	});
	if($("#otherCost_1").attr("checked")) {
		totalPrice += Number($("#otherCost1").val());
	}

	if($("#otherCost_2").attr("checked")) {
		totalPrice += Number($("#otherCost2").val());
	}
	
	if($("#otherCost_3").attr("checked")) {
		totalPrice += Number($("#otherCost3").val());
	}
	
	$("#price").html(totalPrice + "元");
	var choucheng = Number($("#choucheng").val());
	$("#price_input").val(totalPrice);
}

//输入其他费用后计算总价格
function setTotalPrice(e) {
	if(!DoWell.Valid.isIntegerUnsigned($(e).val())) {
		$(e).val(0);
	}
	
	var totalPrice = 0;
	$(".costPrice").each(function(){
		totalPrice += Number($(this).html());				  
	});
	if($("#otherCost_1").attr("checked")) {
		totalPrice += Number($("#otherCost1").val());
	}

	if($("#otherCost_2").attr("checked")) {
		totalPrice += Number($("#otherCost2").val());
	}
	if($("#otherCost_3").attr("checked")) {
		totalPrice += Number($("#otherCost3").val());
	}
	$("#price").html(totalPrice + "元");
	var choucheng = Number($("#choucheng").val());
	$("#price_input").val(totalPrice);
	
}

//显示其他费用的输入框
function showOtherCost() {
	if($("#otherCost_1").attr("checked")) {
		$("#otherCostSpan1").css("visibility", "visible");
	} else {
		$("#otherCostSpan1").css("visibility", "hidden");
	}
	
	if($("#otherCost_2").attr("checked")) {
		$("#otherCostSpan2").css("visibility", "visible");
	} else {
		$("#otherCostSpan2").css("visibility", "hidden");
	}
	if($("#otherCost_3").attr("checked")) {
		$("#otherCostSpan3").css("visibility", "visible");
	} else {
		$("#otherCostSpan3").css("visibility", "hidden");
	}
}

//显示分期付款的列表
function showCostList() {
	if($("#isByStages_box").attr("checked") == "checked") {
		$("#tr_byStages").css("display", "");
		$("#isByStages").val(2);
	} else {
		$("#tr_byStages").css("display", "none");
		$("#isByStages").val(1);
	}
}
function selectcheckbox(id) {
	document.getElementById(id).checked = !document.getElementById(id).checked;
}

//输入分期付款的比例后计算剩余比例和金额
function setByStagesPrice(ev) {
	var totalRadio = 100;//总的比例
	
	var surplusRadio = 0;//已输入比例
	var tempRadio = 0;//
	var elements = getElementsByClassName("payRatio", "input", "text");
	
	var tempPrice = 0;
	for(var i = 0; i < elements.length; i++) {
		var e = elements[i];
		if(!DoWell.Valid.isIntegerUnsigned($(e).val()) && $(e).val() != "") {
			$(e).val(0);
		}
		if($(e).val() > 100) {
			$(e).val(100);	
		}
		
		surplusRadio += Number($(e).val());
		
		//如果已输入比例大于100，则当前文本框的值设为总比例减去前面和的比例
		if(surplusRadio > 100) {
			$(e).val(totalRadio - tempRadio);	
		}
		
		if(i == elements.length - 1) {
			if(surplusRadio < 100) {
				$(e).val(totalRadio - tempRadio);	
			}
		}
		tempRadio += Number($(e).val());
		
		var payment = Number($("#price_input").val());
			
		var thisId = $(e).attr("id");
		var id = thisId.substring(thisId.lastIndexOf("_") + 1, thisId.length);
		//如果比例之和等于100，说明是最后一条记录，重设最后一条记录的应付金额
		if(tempRadio == 100) {
			if($(e).val() != "" && $(e).val() != 0) {
				$("#payPrice_" + id).html(accSub(payment, tempPrice));
				//$("#payPrice_" + id).html(payment-tempPrice);
			}
		} else {
			
			if($(e).val() != "" && $(e).val() != 0) {
				var price = payment * Number($(e).val()) / 100;
				tempPrice = accAdd(tempPrice, price.toFixed(2));
				$("#payPrice_" + id).html(price.toFixed(2));
			}
		}
		//如果不是最后一个  
		if($(e).attr("id") == $(ev).attr("id")) {
			if(i != elements.length - 1) {
				$(elements[i + 1]).val(totalRadio - tempRadio);
			}
		}
	}
	
	//$("#surplusRadio").html(surplusRadio);
	//$("#surplus").html();
}

//小数相减
function accSub(arg1,arg2){
　　 var r1,r2,m,n;
　　 try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
　　 try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
　　 m=Math.pow(10,Math.max(r1,r2));
　　 //last modify by deeka
　　 //动态控制精度长度
　　 n=(r1>=r2)?r1:r2;
　　 return ((arg1*m-arg2*m)/m).toFixed(n);
}

//小数相加
function accAdd(arg1,arg2){
	var r1,r2,m;
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	m=Math.pow(10,Math.max(r1,r2));
	return (arg1*m+arg2*m)/m;
}

//小数相乘
function accMul(arg1, arg2) {   
	var m = 0, s1 = arg1.toString(), s2 = arg2.toString();   
	try { m += s1.split(".")[1].length } catch (e) { }   
	try { m += s2.split(".")[1].length } catch (e) { }   
	return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
}   



function getElementsByClassName(className,tagName,type) { 
	var all = window.document.getElementsByTagName(tagName||"*"); 
	var elements = new Array(); 
	var x = 0;
	for(var e=0;e<all.length;e++) { 
		if((all[e].className==className)&&(all[e].type==type)) { 
			elements[x++]=all[e]; 
		} 
	} 
	return elements; 
} 

var feiqiCount = 2;
function createFenqi() {
	feiqiCount++;
	var html = "<tr height='40'><td align='center'>第&nbsp;&nbsp;<span style='color:#0096D1; font-size:16px; font-weight:bold;'>"+feiqiCount+"</span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<input type='text' name='paymentList["+(feiqiCount-1)+"].paymentTime' class='paymentTimeClass' id='paymentTime_"+feiqiCount+"' onclick='WdatePicker()' style='width:80px;' readonly='readonly' /></td><td align='center'><input class='payRatio' name='paymentList["+(feiqiCount-1)+"].payRatio' onkeyup='setByStagesPrice(this)' type='text' id='payRatio_"+feiqiCount+"' style='width:30px;' />&nbsp;%</td><td align='center'><span id='payPrice_"+feiqiCount+"'></span></td></tr>";
			
	$("#last_tr").before(html);
	//setPaymentTimeOnClick();
}

function setPaymentTimeOnClick() {
	var elements = getElementsByClassName("paymentTimeClass", "input", "text");
	
	var tempPrice = 0;
	for(var qwer = 0; qwer < elements.length; qwer++) {
		//alert($(elements[i]).attr("id"));
		$(elements[qwer]).unbind("click");
		if(qwer == 0) {
			var id = "paymentTime_" + Number(qwer + 2);
			//alert("#F{$dp.$D('"+id+"',{d:-1})}");
			$(elements[qwer]).bind("click", function(){WdatePicker({maxDate:"#F{$dp.$D('paymentTime_2',{d:-1})}"})});
		} else if(qwer == elements.length - 1) {
			var id = "paymentTime_" + qwer;
			$(elements[qwer]).bind("click", function(){WdatePicker({minDate:"#F{$dp.$D('"+id+"',{d:1})}"})});
		} else {
			alert($(elements[qwer]).attr("id"));
			//$(elements[i]).bind("click", function(){WdatePicker({minDate:"#F{$dp.$D('paymentTime_" + i + "',{d:-1})}"})})});
			var a = "#F{$dp.$D('paymentTime_" + (Number(qwer) + Number(2)) + "',{d:-1})}";
			var b = "#F{$dp.$D('paymentTime_" + (Number(qwer)) + "',{d:1})}";
			//var a = "#F{$dp.$D('paymentTime_',{d:-1})}";
			alert(a);
			//$("#" + $(elements[qwer]).attr("id")).bind("click", function(){WdatePicker({minDate:b,maxDate:a})});
			
			elements[qwer].onclick = function(){WdatePicker({minDate:b,maxDate:a})};
		}
	}
}

function checknull(){
	var content =$("#content").val();
	if(content==""){}else if(content.length>1000){
		art.dialog.tips("任务内容不能超过1000个字符!");
		return false;
	}
	
	var beginDate =$("#beginDate").val();
	if(beginDate==""){
		art.dialog.tips("开始时间不能为空!");
		return false;
	}
	
	var endDate =$("#endDate").val();
	if(endDate==""){
		art.dialog.tips("结束时间不能为空!");
		return false;
	}

	var address =$("#address").val();
	if(address==""){
		art.dialog.tips("地点不能为空!");
		return false;
	}else if(address.length>100){
		art.dialog.tips("地点不能超过100个字符!");
		return false;
	}
	
	var cosrMessage1 = "";
	var cosrMessage2 = "";
	var costState = true;
	$(".costCheckbox").each(function(){
		if($(this).attr("checked")) {
			var thisId = $(this).attr("id");
			var id = thisId.substring(thisId.lastIndexOf("_") + 1, thisId.length);
			if($("#cost_" + id).val() == "" || $("#cost_" + id).val() == 0)	 {
				cosrMessage1 = "选择的职业必须输入价格！";
			}
			
			if($("#day_" + id).val() == "" || $("#day_" + id).val() == 0)	 {
				cosrMessage2 = "选择的职业必须输入单位数量！";
			}
			
			costState = false;
		}
	});
	
	if(costState) {
		art.dialog.tips("请选择职业！");
		return false;
	}
	
	if(cosrMessage1 != "") {
		art.dialog.tips(cosrMessage1);
		return false;
	}
	
	if(cosrMessage2 != "") {
		art.dialog.tips(cosrMessage2);
		return false;
	}
	
	if($("#otherCost_1").attr("checked")) {
		var otherCost1 =$("#otherCost1").val();
		if(otherCost1 == "" || otherCost1 == 0){
			art.dialog.tips("请输入车船费!");
			return false;
		}	
	}
	
	if($("#otherCost_2").attr("checked")) {
		var otherCost2 =$("#otherCost2").val();
		if(otherCost2 == "" || otherCost2 == 0){
			art.dialog.tips("请输入住宿费!");
			return false;
		}	
	}
	
	var message1 = "";
	var message2 = "";
	var message3 = "";
	var byStagesState = true;
	if($("#isByStages_box").attr("checked")) {
		var elements = getElementsByClassName("payRatio", "input", "text");
		for(var i = 0; i < elements.length; i++) {
			var e = elements[i];
			if(($(e).val() == "" || $(e).val() == 0) && ($(elements[i+1]).val() != "" && $(elements[i+1]).val() != 0) && (i != elements.length - 1)) {
				message1 = "请按顺序输入付款比例！";
			}
			
			if($(e).val() != "" && $(e).val() != 0) {
				byStagesState = false;
			}
			
			var thisId = $(e).attr("id");
			var id = thisId.substring(thisId.lastIndexOf("_") + 1, thisId.length);
			if($(e).val() != "" && $(e).val() != 0 && $("#paymentTime_" + id).val() == "") {
				message2 = "请选择付款日期！";
			}
			
			if($(e).val() != "" && $(e).val() != 0 && i != 0) {
				var thisId1 = $(elements[i-1]).attr("id");
				var id1 = thisId1.substring(thisId1.lastIndexOf("_") + 1, thisId1.length);
				if(dateCompare($("#paymentTime_" + id1).val(), $("#paymentTime_" + id).val())) {
					message3 = "付款日期必须比上一次付款日期晚！";
				}
			}
		}
		
		if(message1 != "") {
			art.dialog.tips(message1);
			return false;
		}
		if(byStagesState) {
			art.dialog.tips("请输入付款比例！");
			return false;
		}
		
		if(message2 != "") {
			art.dialog.tips(message2);
			return false;
		}
		if(message3 != "") {
			art.dialog.tips(message3);
			return false;
		}
	}
	
	return true;
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

var dialog;
//表单提交（订单提交）
function orderSubmit(){
	//getCostData();
	//$("#businessFrom").attr("action","<%=request.getContextPath() %>/member/business!orderSubmit.htm");
	//if(checknull()){
		//$("#businessFrom").submit();
		//parent.toMyBusiness();	//方法写在head.jsp
		//CloseWin();
	//}
	
	
	
	
	if(checknull()){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/business!orderSubmit.htm",
		   type:'POST',
		   data:$("#businessFrom").serialize(),
		   success:function(data2){
			   if(data2 > 1){
					window.open('<%=request.getContextPath() %>/member/business!myBuyerList.htm?dfdf=<%=new Date()%>','_self');
			   }
		   }
		});
	}
}

function uploadFile(id) {
	dialog = art.dialog.open('<%=request.getContextPath() %>/member/business!toUploadFile.htm?type=1&id=' + id,{lock:true});	
}

function setSize(width, height) {
	dialog.size(width, height);	
}

//表单提交（后台修改交易）
function updateBusinessInfo(){
	if(checknull()){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/business!updateBusinessInfo.htm",
		   type:'POST',
		   data:$("#businessFrom").serialize(),
		   success:function(data){
			   if(data=="1"){
					window.open('<%=request.getContextPath() %>/member/business!myBuyerList.htm?dfdf=<%=new Date()%>','_self');
			   }
		   }
		});
	}
	
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
</script>

  </head>
 
 
<body >



<form id="businessFrom" action="" method="post">

<input type="hidden" name="businessInfo.id" value="${businessInfo.id }" />
<input type="hidden" name="businessInfo.orderCode" value="${businessInfo.orderCode }" />
<input type="hidden" name="businessInfo.status" value="${businessInfo.status }" />
<input type="hidden" name="businessInfo.buyer" value="${businessInfo.buyer }" />
<input type="hidden" name="businessInfo.sellerCompany" value="${businessInfo.sellerCompany }" />
<input type="hidden" name="businessInfo.buyerRate" value="${businessInfo.buyerRate }" />
<input type="hidden" name="businessInfo.sellerRate" value="${businessInfo.sellerRate }" />
<input type="hidden" name="businessInfo.createTime" value="${businessInfo.createTime }" />
<input type="hidden" name="businessInfo.receipt" value="${businessInfo.receipt }" />
<input type="hidden" name="businessInfo.seller" id="seller" value="<s:property value="#request.bqyUserId"/>" />
<input type="hidden" name="businessInfo.choucheng" id="choucheng" value="<s:property value="#request.choucheng"/>" />
<input type="hidden" name="businessInfo.updatePayTimeCount" value="${businessInfo.updatePayTimeCount }" />
<input type="hidden" name="businessInfo.updatePayTimeStatus" value="${businessInfo.updatePayTimeStatus }" />
<s:if test="#request.businessInfo.isByStages!=null">
  <input type="hidden" name="businessInfo.isByStages" id="isByStages" value="${businessInfo.isByStages }" />
</s:if>
<s:else>
    <input type="hidden" name="businessInfo.isByStages" id="isByStages" value="1" />
</s:else>





<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr height="90">
		<td valign="bottom"><div style="background:url(<%=request.getContextPath() %>/theme/images2/tu02.jpg) no-repeat;height:53px; width:201px; padding-bottom:10px;"></div></td>
	</tr>
	<tr height="45">
		<td style="background-color:#2D3134;"><div style="padding-left:15px; font-size:14px; font-weight:bold; color:#FFF;">填写并核对任务信息</div></td>
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
              <td><textarea name="businessInfo.content" id="content" cols="70" rows="10" onclick="checkContent(this)"><s:if test="#request.businessInfo.content!=null"> ${businessInfo.content } </s:if><s:else>请详细填写您的服务需求</s:else></textarea></td>
              <td rowspan="3" valign="top">
                <div style="padding-left:20px;">商家：<s:property value='#request.shangjia'/></div>
                <s:if test="#request.businessInfo.id!=null"><div style="padding-left:20px; padding-top:20px;">订单号：${businessInfo.orderCode }</div></s:if>
                <div style="padding-left:20px; padding-top:30px;">订单状态：<span style="font-size:20px;">
                  <s:if test="#request.businessInfo.id!=null">
                    <s:if test="#request.businessInfo.status==1">等待确认</s:if>
                    <s:if test="#request.businessInfo.status==2">等待执行任务</s:if>
					<s:if test="#request.businessInfo.status==3">任务已完成-等待付款</s:if>
					<s:if test="#request.businessInfo.status==4">任务确认完成-等待付款</s:if>
					<s:if test="#request.businessInfo.status==5">任务到期完成-等待付款</s:if>
					<s:if test="#request.businessInfo.status==6">已付款-订单已完成</s:if>
                    <s:if test="#request.businessInfo.status==7">退款申请中</s:if>
                    <s:if test="#request.businessInfo.status==8">退款已完成</s:if>
                    <s:if test="#request.businessInfo.status==9">订单已关闭</s:if>
                  </s:if>
                  <s:else>
                  	填写订单
                  </s:else>
                  </span></div>
                <!--<div style="padding-left:20px; padding-top:120px;">任务范例</div>-->
                <div style="padding-left:20px; padding-top:20px;">
                  <s:if test="#request.businessInfo.id!=null">
                    <s:if test="#request.fileList.size>0">
                      <div><input value="上传文件" type="button" onclick="uploadFile(<s:property value='#request.businessInfo.id'/>)" class="control_btn_wide_yellow" /><input value="下载文件" type="button" onclick="downloadFile()" class="control_btn_wide_yellow" /></div>
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
              <td align="left"><input type="text" name="businessInfo.beginDate" id="beginDate" value="${businessInfo.beginDate }" style="width:80px;" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\',{d:0})}'})" readonly="readonly"/>&nbsp;&nbsp;
              	<select name="businessInfo.beginTime" id="beginTime">
                	<option value="0">00:00</option>
                	<option value="1">01:00</option>
                	<option value="2">02:00</option>
                	<option value="3">03:00</option>
                	<option value="4">04:00</option>
                	<option value="5">05:00</option>
                	<option value="6">06:00</option>
                	<option value="7">07:00</option>
                	<option value="8" selected="selected">08:00</option>
                	<option value="9">09:00</option>
                	<option value="10">10:00</option>
                	<option value="11">11:00</option>
                	<option value="12">12:00</option>
                	<option value="13">13:00</option>
                	<option value="14">14:00</option>
                	<option value="15">15:00</option>
                	<option value="16">16:00</option>
                	<option value="17">17:00</option>
                	<option value="18">18:00</option>
                	<option value="19">19:00</option>
                	<option value="20">20:00</option>
                	<option value="21">21:00</option>
                	<option value="22">22:00</option>
                	<option value="23">23:00</option>
                </select>&nbsp;&nbsp;——&nbsp;
                <input type="text" name="businessInfo.endDate" id="endDate" value="${businessInfo.endDate }" style="width:80px;" onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\',{d:0})}'})" readonly="readonly" />&nbsp;&nbsp;	
                <select name="businessInfo.endTime" id="endTime">
                  <option value="0">00:00</option>
                  <option value="1">01:00</option>
                  <option value="2">02:00</option>
                  <option value="3">03:00</option>
                  <option value="4">04:00</option>
                  <option value="5">05:00</option>
                  <option value="6">06:00</option>
                  <option value="7">07:00</option>
                  <option value="8">08:00</option>
                  <option value="9" selected="selected">09:00</option>
                  <option value="10">10:00</option>
                  <option value="11">11:00</option>
                  <option value="12">12:00</option>
                  <option value="13">13:00</option>
                  <option value="14">14:00</option>
                  <option value="15">15:00</option>
                  <option value="16">16:00</option>
                  <option value="17">17:00</option>
                  <option value="18">18:00</option>
                  <option value="19">19:00</option>
                  <option value="20">20:00</option>
                  <option value="21">21:00</option>
                  <option value="22">22:00</option>
                  <option value="23">23:00</option>
                </select>
              </td>
            </tr>
            <tr height="20">
              <td align="right" valign="top">任务地点：</td>
              <td>
                <select name="businessInfo.provice" id="provice" value="${businessInfo.provice }" class="sel_jcxx"></select>
                <select name="businessInfo.city" id="city" value="${businessInfo.city }" class="sel_jcxx"></select>
              </td>
            </tr>
            <tr height="20">
              <td align="right" valign="top">详细地址：</td>
              <td>
                <input name="businessInfo.address" id="address" value="${businessInfo.address }" style="width:280px;" />
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
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="15%">参考价</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="15%">酬金单价（元）</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="30%">购买数量</td>
              <td align="center" style="border-top:3px solid #2D3134; border-bottom:2px solid #c3c3c3;" width="20%">总价（元）</td>
            </tr>
			<s:set var="aIndex" value="0" />
            <s:iterator value="#request.costInfoList" var="item" status="ci">
              <tr height="40" >
                <td align="center">
                  <s:if test="#item[2]!=null">
                    <input name="checkbox" type="checkbox" checked="checked" class="costCheckbox" id="checkbox_<s:property value='#item[0].bcostId'/>" onclick="setCostPrice(<s:property value='#item[0].bcostId'/>)"/>
                  </s:if>
                  <s:else>
                    <input name="checkbox" type="checkbox" class="costCheckbox" id="checkbox_<s:property value='#item[0].bcostId'/>" disabled />(已经失效)
                  </s:else>
                  <span onclick="selectcheckbox('checkbox_<s:property value='#item[0].bcostId'/>');setCostPrice(<s:property value='#item[0].bcostId'/>);" style="cursor:pointer;" ><s:property value="#item[0].keywords" /></span>
                  <input type="hidden" name="costList[<s:property value='#ci.index'/>].costId" value="<s:property value='#item[1].id'/>" />
					<input type="hidden" name="costList[<s:property value='#ci.index'/>].keywords" value="<s:property value="#item[0].keywords" />" />
					<input type="hidden" name="costList[<s:property value='#ci.index'/>].bcostId" value="<s:property value='#item[0].bcostId'/>" />

                </td>
                <td align="center"><s:if test="#item[2].isConsult==1">面议</s:if><s:else><s:property value="#item[2].bprice"/>元/<s:property value="#item[2].unit"/></s:else></td>
                <td align="center">
                    <input name="costList[<s:property value='#ci.index'/>].price" id="cost_<s:property value='#item[0].bcostId'/>" size="12" onkeyup="setPrice(<s:property value='#item[0].bcostId'/>)" value="<s:property value='#item[0].price'/>" />                  
                </td>
                <td align="center">
					<s:if test="#item[2]!=null">
                    <input name="costList[<s:property value='#ci.index'/>].days" id="day_<s:property value='#item[0].bcostId'/>" size="12" onkeyup="setPrice(<s:property value='#item[0].bcostId'/>)" value="<s:property value='#item[0].days'/>" />
					</s:if>
					<s:else>
                    <input name="costList[<s:property value='#ci.index'/>].days" id="day_<s:property value='#item[0].bcostId'/>" size="12"  value="0" />
					</s:else>
                </td>
                <td align="center">
                  	<span class="costPrice" id="price_<s:property value='#item[0].bcostId'/>"></span>
                  <s:if test="#item[2]!=null">
                    <script>setPrice("<s:property value='#item[0].bcostId'/>");</script>
                  </s:if>
                </td>                  
              </tr>
			<s:set var="aIndex" value="#ci.index+1" />
            </s:iterator>

            <s:iterator value="#request.talentList" var="item" status="ci">
              <tr height="40" >
                <td align="center">
                    <input name="checkbox" type="checkbox" class="costCheckbox" id="checkbox_<s:property value='#item[0].id'/>" onclick="setCostPrice(<s:property value='#item[0].id'/>)"/>

                  <span onclick="selectcheckbox('checkbox_<s:property value='#item[0].id'/>');setCostPrice(<s:property value='#item[0].id'/>);" style="cursor:pointer;" title="<s:if test="#item[0].keywords==null || #item[0].keywords.length() == 0"><s:property value="#item[1].typeName"/></s:if><s:else><s:property value="#item[0].keywords" /></s:else>"><s:if test="#item[0].keywords==null || #item[0].keywords.length() == 0"><s:property value="#item[1].typeName"/></s:if>
				  <s:elseif test="#item[0].keywords.length() > 9"><s:property value="#item[0].keywords.substring(0,9)" /></s:elseif>
				  <s:else><s:property value="#item[0].keywords" /></s:else></span>
                  <input type="hidden" name="costList[<s:property value='#ci.index+#aIndex'/>].costId" value="<s:property value='#item[1].id'/>" />
				  <input type="hidden" name="costList[<s:property value='#ci.index+#aIndex'/>].keywords" value="<s:if test="#item[0].keywords==null || #item[0].keywords.length() == 0"><s:property value="#item[1].typeName"/></s:if><s:elseif test="#item[0].keywords.length() > 9"><s:property value="#item[0].keywords.substring(0,9)" /></s:elseif><s:else><s:property value="#item[0].keywords" /></s:else>" />
				  <input type="hidden" name="costList[<s:property value='#ci.index+#aIndex'/>].bcostId" value="<s:property value='#item[0].id'/>" />
                </td>
                <td align="center"><s:if test="#item[0].isConsult==1">面议</s:if><s:else><s:property value="#item[0].bprice"/>元/<s:property value="#item[0].unit"/></s:else></td>
                <td align="center">
                    <input style="display:none;" name="costList[<s:property value='#ci.index+#aIndex'/>].price" id="cost_<s:property value='#item[0].id'/>" size="12" onkeyup="setPrice(<s:property value='#item[0].id'/>)" />
                </td>
                <td align="center">
                    <input style="display:none;" name="costList[<s:property value='#ci.index+#aIndex'/>].days" id="day_<s:property value='#item[0].id'/>" size="12" onkeyup="setPrice(<s:property value='#item[0].id'/>)" value="0" />
                </td>
                <td align="center">
                    <span class="costPrice" style="display:none;" id="price_<s:property value='#item[0].id'/>"></span>
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
          <div style="padding-top:10px; padding-bottom:10px; padding-left:70px;"><input onclick="showOtherCost()" name="otherCost" type="checkbox" id="otherCost_1"/><span onclick="selectcheckbox('otherCost_1');showOtherCost()" style="cursor:pointer;">交通费</span><span style="padding-left:20px; visibility:hidden;" id="otherCostSpan1"><input onkeyup="setTotalPrice(this)" name="businessInfo.otherCost1" type="text" id="otherCost1" value="${businessInfo.otherCost1 }" /></span>元 <span><input name="otherCost" onclick="showOtherCost()" type="checkbox" id="otherCost_2"/></span><span onclick="selectcheckbox('otherCost_2');showOtherCost()" style="cursor:pointer;">住宿费</span><span style="visibility:hidden; padding-left:20px;" id="otherCostSpan2"><input onkeyup="setTotalPrice(this)" name="businessInfo.otherCost2" type="text" id="otherCost2" value="${businessInfo.otherCost2 }" /></span>元
		  <span><input name="otherCost" onclick="showOtherCost()" type="checkbox" id="otherCost_3"/></span><span onclick="selectcheckbox('otherCost_3');showOtherCost()" style="cursor:pointer;">餐饮费</span><span style="visibility:hidden; padding-left:20px;" id="otherCostSpan3"><input onkeyup="setTotalPrice(this)" name="businessInfo.otherCost3" type="text" id="otherCost3" value="${businessInfo.otherCost3 }" /></span>元

		</div>
        </td>
	</tr>
	<tr height="70">
		<td style="border-bottom:2px solid #c3c3c3;border-top:3px solid #2D3134;" bgcolor="#ECECED">
          <div style="float:left; margin-left:20px; cursor:pointer; display:none;">
            <input onclick="showCostList()" name="isByStages_box" type="checkbox" id="isByStages_box" />
            <span onclick="selectcheckbox('isByStages_box');showCostList()">分期支付</span>
          </div>
          <div style="float:right; margin-right:20px;">
            <span>实付总额：</span>
            <span id="price" style="color:red; font-size:16px; font-weight:bold;">￥0元</span>
            <input type="hidden" name="businessInfo.price" id="price_input" value="${businessInfo.price}" />
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
                  <td align="center">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;"><s:property value='#item.pos'/></span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<input type="text" name="paymentList[<s:property value='#ci.index'/>].paymentTime" id="paymentTime_<s:property value='#item.pos'/>" style="width:80px;" onClick="WdatePicker()" readonly="readonly" value="<s:date name='paymentTime' format='yyyy-MM-dd' />" /></td>
                  <td align="center"><input class="payRatio" name="paymentList[<s:property value='#ci.index'/>].payRatio" onkeyup="setByStagesPrice(this)" type="text" id="payRatio_<s:property value='#item.pos'/>" value="<s:property value='#item.payRatio'/>" style="width:30px;" />&nbsp;%</td>
                  <td align="center"><span id="payPrice_<s:property value='#item.pos'/>"><s:property value='#item.price'/></span></td>
                </tr>
              </s:iterator>
            </s:if>
            <s:else>
                <tr height="40">
                  <td align="center">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;">1</span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<input type="text" name="paymentList[0].paymentTime" onclick="WdatePicker()" class="paymentTimeClass" id="paymentTime_1" style="width:80px;"  readonly="readonly" /></td>
                  <td align="center"><input class="payRatio" name="paymentList[0].payRatio" onkeyup="setByStagesPrice(this)" type="text" id="payRatio_1" style="width:30px;" />&nbsp;%</td>
                  <td align="center"><span id="payPrice_1"></span></td>
                </tr>
                <tr height="40">
                  <td align="center">第&nbsp;&nbsp;<span style="color:#0096D1; font-size:16px; font-weight:bold;">2</span>&nbsp;&nbsp;次付款截止时间&nbsp;&nbsp;<input type="text" id="paymentTime_2" onclick="WdatePicker()" class="paymentTimeClass" name="paymentList[1].paymentTime" style="width:80px;" readonly="readonly" /></td>
                  <td align="center"><input class="payRatio" name="paymentList[1].payRatio" onkeyup="setByStagesPrice(this)" type="text" id="payRatio_2" style="width:30px;" />&nbsp;%</td>
                  <td align="center"><span id="payPrice_2"></span></td>
                </tr>
            </s:else>
          
            
            
            <tr height="40" id="last_tr">
              <td align="center" colspan="4"><div style="border-top:#999 1px dashed; width:90%; margin:auto;"></div></td>
            </tr>
            <tr height="40">
              <td align="center"><div onclick="createFenqi()" style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;">+新增分期付款</div></td>
              <td align="center"><!--剩余付款比例：<span id="surplusRadio" style="color:#FD9633; font-size:16px; font-weight:bold;"></span>--></td>
              <td align="center"><!--剩余金额：<span id="surplus" style="color:red; font-size:16px; font-weight:bold;"></span>--></td>
            </tr>
          </table>
        </td>
	</tr>
	<tr height="90">
		<td>
          <div style="float:left; padding-top:30px; margin-left:20px; cursor:pointer; background:url(<%=request.getContextPath() %>/theme/images2/fapiao.png) no-repeat 0px 23px;; height:25px; display:none;"><span style="padding-left:30px;">发票问题请点击</span></div>
          
          
          <s:if test="#request.businessInfo.id!=null">
            <div style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/tjdd.png) no-repeat; width:80px; height:30px; cursor:pointer;" onclick="updateBusinessInfo()"></div>
          </s:if>
          <s:else>
              <div style="float:right; margin-right:20px; background:url(<%=request.getContextPath() %>/theme/images2/tjdd.png) no-repeat; width:80px; height:30px; cursor:pointer;" onclick="orderSubmit()"></div>
          </s:else>
        </td>
	</tr>
</table>




</form>
  </body>
</html>
