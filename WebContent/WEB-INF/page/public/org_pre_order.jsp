<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.entity.TAppBusinessInfo"%>


<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	TAppBusinessInfo businessInfo = (TAppBusinessInfo)request.getAttribute("businessInfo");
	int startTime = 0;
	int endTime = 0 ;
	if(businessInfo!=null){
		startTime = Integer.parseInt(businessInfo.getBeginTime());
		endTime = Integer.parseInt(businessInfo.getEndTime());
	}
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--  public/jobChance.jsp-->
<title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<link rel="stylesheet" href="<%=path%>/theme/job/css/style2.css" />
<script type="text/javascript" src="<%=path%>/theme/job/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/xsgd.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select2.js"></script>


<script type="text/javascript" src="<%=path%>/theme/js2/common.js"></script>

<script type="text/javascript" src="<%=path%>/theme/fenlei/js/common.js"></script>

<script type="text/javascript" src="<%=path%>/theme/js/address.js"></script>
<script type="text/javascript" src="<%=path%>/theme/stageDate/WdatePicker.js"></script>

<script type="text/javascript" src="<%=path%>/theme/job/js/jquery.easydropdown.js"></script>


</head>
<body>
<style>
	.dropdown21{
		border:1px solid#cccccc;float:left;display:inline;
		width: 55px;
		height: 35px;
	}
</style>

<script language="javascript">
function round2(number,fractionDigits){  
    with(Math){  
        var f = round(number*pow(10,fractionDigits))/pow(10,fractionDigits);  
		var s = f.toString();
		var rs = s.indexOf('.');
		if (rs < 0) {   
				rs = s.length;
				s += '.';   
		}
		while (s.length <= rs + 2) {
			s += '0';
		}
		return s;   
    }
}

function publishTask(){
	<%if(userSession != null){%>
		this.location = "<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>";
	<%}else{
		//art.dialog.alert("请先登录！");

			
		String url ="?r="+HttpSessionHelper.urlEncode("/member/task.htm?userId=@{loginUserId}");
		%>
		parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}

$(document).ready(function(){
	if("${businessInfo.provice}"!=""){
		initAddress('provice','city','${businessInfo.provice}','${businessInfo.city}');
	}else{
		initAddress("provice","city","上海","");  
	}
	recalculateTotal(-1);
});

function replaceImg(obj){
		obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
}

function pinfen(){
}
function recalculate(id){
	var price = parseFloat($("#price_"+id).val());
	var units = parseFloat($("#units_"+id).val());
	if(price && units){
		if(price*units>0){
			$("#subtotal_"+id).val(round2(price*units,2));
		}else{
			$("#subtotal_"+id).val('');
		}
	}

	recalculateTotal(-1);
}
function recalculateTotal(index){
	var wt = $('input[name="items"]');
	var total = 0;
	wt.each(function(i){
		if($(this).is(":checked")){

			if(index>=0 && i==index){
				$("#priceDiv_"+index).show();
				$("#daysDiv_"+index).show();
				$("#subtotalDiv_"+index).show();
			}

			var id = $(this).val();
			if($("#subtotal_"+id).val()){
				var subTotal = 	parseFloat($("#subtotal_"+id).val());
				total += subTotal;
			}
		}else{
			if(index>=0 && i==index){
				$("#priceDiv_"+index).val('');
				$("#priceDiv_"+index).hide();
				$("#daysDiv_"+index).hide();
				$("#subtotalDiv_"+index).val('');
				$("#subtotalDiv_"+index).hide();
			}
		}
	});

	if($("#otherFee1Checkbox").is(":checked")){
		$("#jtDiv").show();

		if($("#otherFee1").val()){
			total += parseFloat($("#otherFee1").val());
		}
	}else{
		$("#jtDiv").hide();
	}


	if($("#otherFee2Checkbox").is(":checked")){
		$("#zsDiv").show();

		if($("#otherFee2").val()){
			total += parseFloat($("#otherFee2").val());
		}
	}else{
		$("#zsDiv").hide();
	}


	if($("#otherFee3Checkbox").is(":checked")){
		$("#cyDiv").show();
		if($("#otherFee3").val()){
			total += parseFloat($("#otherFee3").val());
		}
	}else{
		$("#cyDiv").hide();
	}



	if(total>0){
		$("#total").html("￥"+round2(total,2));
	}else{
		$("#total").html("");
	}
	

	//alert(total);
	$("#businessInfoPrice").val(total);
	//alert($("#businessInfoPrice").val());
}



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



function checknull(){

	var content =$("#content").val();
	if(content==""){
		//
	}else if(content.length>1000){
		art.dialog.tips("任务内容不能超过1000个字符!");
		return ;
	}
	
	var beginDate =$("#beginDate").val();
	var beginTime =parseInt($("#beginTime").val());
	if(beginDate==""){
		art.dialog.tips("开始时间不能为空!");
		return ;
	}
	
	var endDate =$("#endDate").val();
	var endTime =parseInt($("#endTime").val());
	if(endDate==""){
		art.dialog.tips("结束时间不能为空!");
		return ;
	}

	//alert(  (stringToTime(endDate+' '+((endTime>9)?endTime:'0'+endTime)+':00:00')-stringToTime(beginDate+' '+((beginTime>9)?beginTime:'0'+beginTime)+':00:00'))  );
	var timeDiff = (stringToTime(endDate+' '+((endTime>9)?endTime:'0'+endTime)+':00:00')-stringToTime(beginDate+' '+((beginTime>9)?beginTime:'0'+beginTime)+':00:00')) ;

	if(timeDiff < 0){
		art.dialog.tips("结束时间不能早于开始时间!");
		return ;
	}else if(timeDiff < 3600*1000){
		art.dialog.tips("结束时间至少设置在开始一个小时后!");
		return ;
	}

	var address =$("#address").val();
	if(address==""){
		art.dialog.tips("地点不能为空!");
		return ;
	}else if(address.length>100){
		art.dialog.tips("地点不能超过100个字符!");
		return ;
	}


	if($("#otherFee1Checkbox").is(":checked")){
		var otherCost1 =$("#otherFee1").val();
		if(otherCost1 == "" || otherCost1 == 0){
			art.dialog.tips("请输入交通费!");
			return ;
		}	
	}
	
	if($("#otherFee2Checkbox").is(":checked")){
		var otherCost2 =$("#otherFee2").val();
		if(otherCost2 == "" || otherCost2 == 0){
			art.dialog.tips("请输入住宿费!");
			return ;
		}	
	}
	if($("#otherFee3Checkbox").is(":checked")){
		var otherCost2 =$("#otherFee3").val();
		if(otherCost2 == "" || otherCost2 == 0){
			art.dialog.tips("请输入餐饮费!");
			return ;
		}	
	}



	var cosrMessage1 = "";
	var cosrMessage2 = "";
	var costState = true;


	var wt = $('input[name="items"]');
	var total = 0;
	wt.each(function(i){
		if($(this).is(":checked")){
			var thisId = $(this).attr("id"); //items_${item.id}
			var id = thisId.substring(thisId.lastIndexOf("_") + 1, thisId.length);
			if($("#price_" + id).val() == "" || $("#price_" + id).val() == 0)	 {
				cosrMessage1 = "选择的职业必须输入价格！";
			}
			
			if($("#units_" + id).val() == "" || $("#units_" + id).val() == 0)	 {
				cosrMessage2 = "选择的职业必须输入单位数量！";
			}
			
			costState = false;
		}
	});
	if(costState) {
		art.dialog.tips("请选择职业！");
		return ;
	}
	
	if(cosrMessage1 != "") {
		art.dialog.tips(cosrMessage1);
		return ;
	}
	
	if(cosrMessage2 != "") {
		art.dialog.tips(cosrMessage2);
		return ;
	}

	
		/*

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
			return ;
		}
		if(byStagesState) {
			art.dialog.tips("请输入付款比例！");
			return ;
		}
		
		if(message2 != "") {
			art.dialog.tips(message2);
			return ;
		}
		if(message3 != "") {
			art.dialog.tips(message3);
			return ;
		}
	}
	*/
	return true;
	
}





function stringToTime(string) {
    var f = string.split(' ', 2);
    var d = (f[0] ? f[0] : '').split('-', 3);
    var t = (f[1] ? f[1] : '').split(':', 3);
    return (new Date(
	   parseInt(d[0], 10) || null,
		(parseInt(d[1], 10) || 1) - 1,
		parseInt(d[2], 10) || null,
		parseInt(t[0], 10) || null,
		parseInt(t[1], 10) || null,
		parseInt(t[2], 10) || null
		)).getTime();
}



</script>

<div class="top Layout">
<div class="top_t">

<%@include file= "/WEB-INF/page/public/top3.jsp"%>

</div>
<div class="top_c">
	<div class="top_c_nav mian Layout">
   	  <div class="top_c_nav_l fl" style="margin-left:-34px;">
      	<ul>
        	<li class="fwfl"><a >全部服务分类</a><div class="arrow_Downward"></div>
              <div class="Cnav" id="fwfl_c">


<%@include file= "/WEB-INF/page/public/menu.jsp"%>



<form id="businessFrom" action="" method="post">

<input type="hidden" name="businessInfo.id" value="${businessInfo.id}"/>
<input type="hidden" name="businessInfo.orderCode" value="${businessInfo.orderCode}"/>
<input type="hidden" name="businessInfo.status" value="${businessInfo.status}"/>
<input type="hidden" name="businessInfo.buyer" value="${businessInfo.buyer}"/>
<input type="hidden" name="businessInfo.sellerCompany" value="${businessInfo.sellerCompany}"/>
<input type="hidden" name="businessInfo.buyerRate" value="${businessInfo.buyerRate }"/>
<input type="hidden" name="businessInfo.sellerRate" value="${businessInfo.sellerRate }"/>
<input type="hidden" name="businessInfo.createTime" value="${businessInfo.createTime}"/>
<input type="hidden" name="businessInfo.receipt" value="${businessInfo.receipt }"/>

<input type="hidden" name="businessInfo.price" id="businessInfoPrice" value="${businessInfo.price}"/>


<input type="hidden" name="businessInfo.seller" id="seller" value="<s:property value="#request.bqyUserId"/>"/>
<input type="hidden" name="businessInfo.choucheng" id="choucheng" value="<s:property value="#request.choucheng"/>"/>
<input type="hidden" name="businessInfo.updatePayTimeCount" value="${businessInfo.updatePayTimeCount }"/>
<input type="hidden" name="businessInfo.updatePayTimeStatus" value="${businessInfo.updatePayTimeStatus }"/>
<s:if test="#request.businessInfo.isByStages!=null">
  <input type="hidden" name="businessInfo.isByStages" id="isByStages" value="${businessInfo.isByStages }"/>
</s:if>
<s:else>
    <input type="hidden" name="businessInfo.isByStages" id="isByStages" value="1"/>
</s:else>




<div class="mian3 Layout">
  	<div class="xzrw_lc Layout">
    	<dl>
        	<dd class="on">
            	<div>填写任务信息</div>
                <div class="xzrw_lc_wz">1</div>
                <div><%
				
				java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
				String time = formatter.format(new java.util.Date());
				out.print(time);

				%></div>
            </dd>
            <dt class="on">
            	<p></p>
            </dt>
            <dd class="xzrw_lc_margin">
            	<div>任务确认</div>
                <div class="xzrw_lc_wz">2</div>
                <div><!-- 2014,10,24&nbsp;&nbsp;09:12:27 --> </div>
            </dd>
            <dt>
            	<p></p>
            </dt>
            <dd class="xzrw_lc_margin">
            	<div>执行任务</div>
                <div class="xzrw_lc_wz">3</div>
                <div><!-- 2014,10,24&nbsp;&nbsp;09:12:27 --> </div>
            </dd>
            <dt>
            	<p></p>
            </dt>
            <dd class="xzrw_lc_margin">
            	<div>完成任务</div>
                <div class="xzrw_lc_wz">4</div>
                <div> </div>
            </dd>
            <dt>
            	<p></p>
            </dt>
            <dd class="xzrw_lc_margin">
            	<div>线下付款</div>
                <div class="xzrw_lc_wz">5</div>
                <div> </div>
            </dd>
            <dt><!--  class="on" -->
            	<p></p>
            </dt>
            <dd class="xzrw_lc_margin">
            	<div>评价</div>
                <div class="xzrw_lc_wz">6</div>
                <div> </div>
            </dd>
        </dl>
    </div>
 	<div class="xzrw_time Layout">
    	<div class="xzrw_time_title"><img src="<%=path %>/theme/job/images/xzrw_time_title.png" width="25" height="24" /><span>选择时间</span></div>
        <div class="xzrw_time_c Layout">
        	<div class="xzrw_time_c_l">选择任务时间：</div>
            <div class="xzrw_time_c_r">
            	<input type="text" class="xzrw_time_c_r_text" name="businessInfo.beginDate" id="beginDate" value="${businessInfo.beginDate}" onClick="WdatePicker()" />
                  <div class="xzrw_time_c_r_xl">
                  <select class="dropdown" name="businessInfo.beginTime"  id="beginTime">
				  <%for(int i=0;i<=23;i++){%>
                      <option value="<%=i%>" <% if(startTime==i) out.print("selected='selected'");%>><%=i%>:00</option>
					 <%}%>
                  </select>
                  </div>
                  <span class="xzrw_time_c_r_yx">——</span>
                  <input type="text" class="xzrw_time_c_r_text"  name="businessInfo.endDate"   id="endDate"  value="${businessInfo.endDate}"  onClick="WdatePicker()"/>
                  <div class="xzrw_time_c_r_xl">
                  <select class="dropdown" name="businessInfo.endTime"   id="endTime" >
				  <%for(int i=0;i<=23;i++){%>
                      <option value="<%=i%>" <% if(endTime==i) out.print("selected='selected'");%>><%=i%>:00</option>
					 <%}%>
                  </select>
                  </div>
            </div>
        </div>
        <div class="xzrw_time_c Layout">
        	<div class="xzrw_time_c_l">选择任务地点：</div>
            <div class="xzrw_time_c_r">
            	  <div class="xzrw_time_c_r_xl2">
                  <select  class="dropdown2"  style="border:solid 1px #ccc"  name="businessInfo.provice" id="provice"></select>
                  </div>
                  <div class="xzrw_time_c_r_xl2">

                  <select  class="dropdown2"  style="border:solid 1px #ccc"  name="businessInfo.city" id="city"></select>
 
                  </div>
            </div>
        </div>
        <div class="xzrw_time_c">
        	<div class="xzrw_time_c_l">详细地址：</div>
            <div class="xzrw_time_c_r">
            	<input type="text" name="businessInfo.address" id="address"  value="${businessInfo.address}"  class="xzrw_time_c_r_text2"/>
            </div>
        </div>
  	</div>
  	<div class="xzrw_fwxm Layout">
    	<div class="xzrw_fwxm_title"><img src="<%=path %>/theme/job/images/xzrw_fwxm_title.png" width="19" height="25" /><span>选择服务项目</span></div>
        <div class="xzrw_fwxm_table">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <th width="30" scope="col">&nbsp;</th>
            <th scope="col">服务项目</th>
            <th scope="col">参考价</th>
            <th scope="col">酬金单价（元）</th>
            <th scope="col">购买数量</th>
            <th scope="col">总价（元）</th>
            </tr>


			<s:iterator value="#request.costList" var="item" status="ci">
                 <input type="hidden" name="costList[<s:property value='#ci.index'/>].costId" value="<s:property value='#item.id'/>" />
				 <input type="hidden" name="costList[<s:property value='#ci.index'/>].keywords" value="<s:property value="#item.keywords" />" />
				 <input type="hidden" name="costList[<s:property value='#ci.index'/>].bcostId" value="<s:property value='#item.bcostId'/>" />


            <tr>
				<td>
				<input type="checkbox" name="items" id="items_${item.id}" value="${item.id}"  onclick="recalculateTotal(<s:property value='#ci.index'/>)"
				<s:if test="#item.days!=''">checked="checked"</s:if>
				/>
				</td>
				<td>${item.keywords}</td>
				<td>${item.bprice}元/${item.unit}</td>
				
				<td><div 
				
				<s:if test="#item.days==''">style="display:none"</s:if>

				id="priceDiv_<s:property value='#ci.index'/>"><input type="text" class="xzrw_fwxm_table_text"  
				  value='<s:property value="@com.smt.webapp.util.CommonUtil@numberFormat(#item.price)"/>'  
				name="costList[<s:property value='#ci.index'/>].price" id="price_${item.id}" onkeyup="recalculate(${item.id})"/></div></td>

				<td>
				<div class="xzrw_fwxm_table_xl"  id="daysDiv_<s:property value='#ci.index'/>"  <s:if test="#item.days==''">style="display:none"</s:if> >
					<select  style="border:solid 1px #ccc" name="costList[<s:property value='#ci.index'/>].days" id="units_${item.id}" onchange="recalculate(${item.id})">
					<s:set name="days" value="#item.days" scope="request"/>

					  <%for(int i=1;i<=10;i++){%>
						  <option value="<%=i%>"   <% Integer days = (Integer)request.getAttribute("days"); if(days!=null && days==i){out.print("selected='selected'");}%>><%=i%></option>
						 <%}%>
					</select>
				</div>
				</td>

				<td><div  <s:if test="#item.days==''">style="display:none"</s:if>
				id="subtotalDiv_<s:property value='#ci.index'/>"><input type="text" class="xzrw_fwxm_table_text"  name="subtotal" 
value='<s:property value="@com.smt.webapp.util.CommonUtil@multipleAndNumberFormat(#item.price,#item.days)"/>'

 id="subtotal_${item.id}" readonly/></div></td>

            </tr>
			</s:iterator>



            </table>
        </div>
        <div class="xzrw_fwxm_nr Layout">
        	<div class="xzrw_fwxm_nr_l fl">
            	任务详细内容：
            </div>
            <div class="xzrw_fwxm_nr_r fl">
            	<textarea name="businessInfo.content" id="content" cols="" rows=""  class="xzrw_fwxm_nr_r_textarea">${businessInfo.content}</textarea>
            </div>
        </div>
  </div>
  	<div class="xzrw_qtfy">
    	<div class="xzrw_qtfy_title"><img src="<%=path %>/theme/job/images/xzrw_qtfy_title.png" width="24" height="29" /><span>其他费用</span></div>
        <div class="xzrw_qtfy_c">
        	<ul>
            	<!-- <li><input type="checkbox" /><span class="xzrw_qtfy_c_title">交通费</span></li> -->
                <li><input type="checkbox" id="otherFee1Checkbox" onclick="recalculateTotal(-100)"
				<s:if test="#request.businessInfo.otherCost1!=''">checked="checked"</s:if>
				/><span class="xzrw_qtfy_c_title">交通费</span><span id="jtDiv" 
				<s:if test="#request.businessInfo.otherCost1==''">style="display:none"</s:if>				
				><input type="text" class="xzrw_qtfy_c_text" id="otherFee1" name="businessInfo.otherCost1"    value='<s:property value="@com.smt.webapp.util.CommonUtil@numberFormat(#request.businessInfo.otherCost1)"/>'  onkeyup="recalculateTotal(-1)"/><u class="xzrw_qtfy_c_u">元</u></span></li>
                <li><input type="checkbox" id="otherFee2Checkbox" onclick="recalculateTotal(-101)"
				<s:if test="#request.businessInfo.otherCost2!=''">checked="checked"</s:if>
				/><span class="xzrw_qtfy_c_title">住宿费</span><span id="zsDiv" 
				<s:if test="#request.businessInfo.otherCost2==''">style="display:none"</s:if>
				><input type="text" class="xzrw_qtfy_c_text" id="otherFee2" name="businessInfo.otherCost2"   value='<s:property value="@com.smt.webapp.util.CommonUtil@numberFormat(#request.businessInfo.otherCost2)"/>'  onkeyup="recalculateTotal(-1)"/><u class="xzrw_qtfy_c_u">元</u></span></li>

                <li><input type="checkbox" id="otherFee3Checkbox" onclick="recalculateTotal(-102)"
				<s:if test="#request.businessInfo.otherCost3!=''">checked="checked"</s:if>
				/><span class="xzrw_qtfy_c_title">餐饮费</span><span id="cyDiv" 
				<s:if test="#request.businessInfo.otherCost3==''">style="display:none"</s:if>
				><input type="text" class="xzrw_qtfy_c_text" id="otherFee3" name="businessInfo.otherCost3"   value='<s:property value="@com.smt.webapp.util.CommonUtil@numberFormat(#request.businessInfo.otherCost3)"/>' onkeyup="recalculateTotal(-1)"/><u class="xzrw_qtfy_c_u">元</u></span></li>

                <!-- <li><input type="checkbox" /><span class="xzrw_qtfy_c_title">交通费</span></li> -->
            </ul>
        </div>
    </div>
    <div class="xzrw_sfze">
    	<div class="xzrw_sfze_c Layout">
        	<div class="xzrw_sfze_c_c">
        		<div class="xzrw_sfze_c_c_l">实付总额：</div>
                <div class="xzrw_sfze_c_c_r"><span class="xzrw_sfze_c_c_r_sf"><span id="total">
				<s:if test="#request.businessInfo.price!=''">
				￥<s:property value="@com.smt.webapp.util.CommonUtil@numberFormat(#request.businessInfo.price)"/>
				</s:if>
				</span></span></div>
            </div>
            <div class="xzrw_sfze_c_c">
        		<div class="xzrw_sfze_c_c_l">服务者：</div>
                <div class="xzrw_sfze_c_c_c">
				
			
				<s:if test="#request.user1.isOrg==1">
					<a href="<%=path %>/index/orgListAction.htm?id=${ui1.userId}" target="_blank">${ui1.nickName}</a>
				</s:if>
				<s:else>
					<a href="<%=path %>/index/presonList.htm?id=${ui1.userId}">${ui1.nickName}</a>
				</s:else>



				</div>
                <div class="xzrw_sfze_c_c_r">${ui1.mobile}</div>
            </div>
            <div class="xzrw_sfze_c_c">
        		<div class="xzrw_sfze_c_c_l">联系人：</div>
                <div class="xzrw_sfze_c_c_c">
				<s:if test="#request.isOrg==1">
					<a href="<%=path %>/index/orgListAction.htm?id=${ui2.userId}" target="_blank">${ui2.nickName}</a>
				</s:if>
				<s:else>
					<a href="<%=path %>/index/presonList.htm?id=${ui2.userId}">${ui2.nickName}</a>
				</s:else>
				</div>
                <div class="xzrw_sfze_c_c_r">${ui2.mobile}</div>
            </div>
        </div>
        <div class="xzrw_sfze_b">
        	<a href="javascript:orderSubmit()" title="">确认信息 提交预约</a>
        </div>
    </div>
</div>









<!-- foot  -->
<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
