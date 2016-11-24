<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.getUrlParam.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>

    <style>
	.opDiv {
		padding-top:5px;
	}
	</style>
    
 	<script type="text/javascript">

	$().ready(function(){
   		
   		
    });
 
    function toBusinessView(id){
		window.open('<%=request.getContextPath()%>/member/business!toBusinessView.htm?id='+id);
	}
	
	 function toBusinessUpdate(bqyUserId,id){
		window.open('<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId='+bqyUserId+'&id='+id);
	}
	
	
	function addEvaluate(id){alert("功能待测试");
		//art.dialog.open('<%=request.getContextPath() %>/member/evaluate!addEvaluate.htm?id='+id+'&flag=0',{width:550,height:450,resize: false});
	}
	function updateEvaluate(id){alert("功能待测试");
		//art.dialog.open('<%=request.getContextPath() %>/member/evaluate!addEvaluate.htm?id='+id+'&flag=1',{width:550,height:450,resize: false});
	}
	
	function addYrEvaluate(id){//alert("功能待测试");
		art.dialog.open('<%=request.getContextPath() %>/member/evaluate!addYrEvaluate.htm?id='+id+'&flag=0',{width:550,height:350,resize: false});
	}
	function updateYrEvaluate(id){//alert("功能待测试");
		art.dialog.open('<%=request.getContextPath() %>/member/evaluate!addYrEvaluate.htm?id='+id+'&flag=1',{width:550,height:350,resize: false});
	}
	function viewYrEvaluate(id){
		art.dialog.open('<%=request.getContextPath() %>/member/evaluate!addYrEvaluate.htm?id='+id+'&flag=2',{width:550,height:350,resize: false});
	}
	
	function addDrawback(id){
		art.dialog.open('<%=request.getContextPath() %>/member/drawback!addDrawback.htm?id='+id,{width:550,height:480,resize: false});
	}
	
	function updateAlipay(){
    	art.dialog.open('<%=request.getContextPath()%>/member/userinfo!doUpdateAlipay.htm',{lock:true,resize: false});
	}
	
	function updateBusinessInfoStatus(id,status){
	    	art.dialog({
		        icon: 'warning',
				content: '您确认进行此操作吗？',
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
	    
	  function confrimOrder(id) {
		  
		  window.open('<%=request.getContextPath() %>/member/business!confirmOrder.htm?id='+id);
	  }
	  
	  function getConfirmPay(id){
		  art.dialog.open('<%=request.getContextPath() %>/member/business!getConfirmPay.htm?orderId='+id,{width:350,height:280,resize: false});
	  }
	  
	  function updatePayTime(id, type){
		  art.dialog.open('<%=request.getContextPath() %>/member/business!updatePayTime.htm?orderId='+id+"&type="+type,{width:550,height:280,resize: false});
	  }
	  
	  function tishi(content){
	   		window.location.href=window.location.href;
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
    
	function sendMessage(id){
		art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id='+id,{width:550,height:300,resize: false});
	}
	
    function goAgreement(id){
    	window.open("<%=request.getContextPath() %>/member/business!goAgreement.htm?id="+id);
    }
	
	function search(type) {
		if(type == 5) {
			$("#searchForm").submit();
		} else {
			var pageNo = $("#pageNum").val();
			var rowCount = $("#rowCount").val();
			window.location.href= "<%=request.getContextPath() %>/member/business!mySellerList.htm?pageNo="+pageNo+"&rowCount="+rowCount+"&type="+type;
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
        	<s:param name="menuFlag" value="32"></s:param>
        </s:action>
       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">
        <div class="your_position
">您的位置：<a href="#">首页</a> > <a href="#">我的交易</a></div>

<div style="border:#f9dfb2 1px solid; background-color:#ffffe0; height:25px; margin-right:15px; padding-top:5px;">
  <span style="padding-left:10px;">我的交易提醒：</span>
  <span style="color:#36c;padding-left:10px; cursor:pointer;" onclick="search(1)">待确认<span style="color:#c33;">(<s:property value="#request.confirmCount"/>)</span></span>
  <span style="color:#36c;padding-left:10px; cursor:pointer;" onclick="search(2)">待完成任务<span style="color:#c33;">(<s:property value="#request.waitCount"/>)</span></span>
  <span style="color:#36c;padding-left:10px; cursor:pointer;" onclick="search(3)">待确认收款<span style="color:#c33;">(<s:property value="#request.payCount"/>)</span></span>
  <span style="color:#36c;padding-left:10px; cursor:pointer;" onclick="search(4)">待评价<span style="color:#c33;">(<s:property value="#request.rateCount"/>)</span></span>  
  
  <span style="float:right; margin-right:15px; margin-top:4px;"><a href="javascript:updateAlipay();" class="bdzfb_link">绑定支付宝</a></span>
  <span style="float:right; margin-right:15px;">第一舞台 守护您的信任</span>
  
</div>

<div style="border-top:#c3d8e5 1px solid;border-bottom:#c3d8e5 1px solid; height:25px; margin-right:15px; margin-top:5px; height:35px; line-height:35px;">
  <form action="" method="post" id="searchForm">
  <input type="hidden" value="<s:property value='#request.pageNum'/>" id="pageNum" name="pageNum" />
  <input type="hidden" value="10" id="rowCount" name="rowCount" />
  <span style="padding-left:10px;">宝贝名称：</span>
  <span style="color:#36c;padding-left:10px;"><input type="text" style="width:200px; border:#8ab6dd solid 1px;" value="<s:property value='#request.costName'/>" name="costName" id="costName" /></span>
  <span style="color:#36c;padding-left:10px;"><input type="button" value="搜索" onclick="search(5)" style="background:url(<%=request.getContextPath() %>/theme/images2/business_bg.png) 0px -52px; width:52px; height:25px;" /></span>
  </form>
</div>

<table width="795">
  <tr style="background:url(<%=request.getContextPath() %>/theme/images2/business_bg.png); height:32px;">
    <td width="110" align="center">艺人</td>
    <td width="100" align="center">职业</td>
    <td width="80" align="center">单价</td>
    <td width="70" align="center">数量</td>
    <td width="80" align="center">应收款</td>
    <td width="80" align="center">已收款</td>
    <td width="85" align="center">交易状态</td>
    <td width="85" align="center">交易操作</td>
    <td width="85" align="center">其他操作</td>
  </tr>
  <tr><td colspan="9"></td></tr>
  <s:iterator value="#request.businessInfoList" var="businessInfo" >
    <tr style="background-color:#e8f2ff; border:#d4e7ff solid 1px;" height="35">
      
      <td colspan="9">  
        <span style="padding-left:10px;">订单编号：<s:property value="#businessInfo.business.orderCode"/></span>
        <span style="padding-left:20px;">成交时间：<s:date name="#businessInfo.business.createTime" format="yyyy-MM-dd HH:mm:ss" /></span>
        <span style="color:#36c;padding-left:10px; cursor:pointer;" onclick="sendMessage(<s:property value='#businessInfo.userInfo1.userId'/>)">联系他&nbsp;&nbsp;<s:property value="#businessInfo.userInfo1.nickName"/></span>
      </td>
    </tr>
    <tr style="border-left:#d4e7ff solid 1px;border-right:#d4e7ff solid 1px;border-bottom:#d4e7ff solid 1px;">
      <td align="left" valign="top">
        <img style="border:1px solid #e3e3e3; padding:2px; cursor:pointer;" onerror="indexImgLoadError(event);" src="/stageUpload/headImage/<s:property value='#businessInfo.userInfo.userId'/>.png" width="110" height="100" onclick="userView(<s:property value='#businessInfo.userInfo.userId'/>)" />
      </td>
      <td align="left" valign="top" style="border-right:#e6e6e6 solid 1px;">
        <s:iterator value="#businessInfo.costList" var="cost" >
          <div style="font-size:16px; font-weight:bold; line-height:25px; padding-left:5px;"><s:property value="#cost[1]"/></div>
        </s:iterator>
        <div>
          <s:if test="#businessInfo.user.rzState==3">
            <a style="color:#37bc07;font-size:12px;margin:0 10px"><img src="../theme/images2/tu95.jpg" width="15" height="17" />&nbsp;实名认证</a>
            &nbsp;&nbsp;&nbsp;
          </s:if>
          <s:else>
            <a style="color:#cc0000;font-size:12px;margin:0 10px"><img src="../theme/images2/tu95_1.jpg" width="15" height="17" />&nbsp;未认证</a>
            &nbsp;&nbsp;&nbsp;
          </s:else>
        </div>
      </td>
      <td align="center" valign="top" style="border-right:#e6e6e6 solid 1px;">
        <s:iterator value="#businessInfo.costList" var="cost" >
          <div style="line-height:25px;">￥<fmt:formatNumber pattern="0.00"><s:property value="#cost[0].price"/></fmt:formatNumber></div>
        </s:iterator>
      </td>
      <td align="center" valign="top" style="border-right:#e6e6e6 solid 1px;">
        <s:iterator value="#businessInfo.costList" var="cost" >
          <div style="line-height:25px;"><s:property value="#cost[0].days"/></div>
        </s:iterator>
      </td>
      <td align="center" style="border-right:#e6e6e6 solid 1px;">
          <div>￥<fmt:formatNumber pattern="0.00"><s:property value="#businessInfo.business.price"/></fmt:formatNumber></div>
      </td>
      <td align="center" style="border-right:#e6e6e6 solid 1px;">
          <div>￥<fmt:formatNumber pattern="0.00"><s:property value="#businessInfo.payment"/></fmt:formatNumber></div>
      </td>
      <td align="center" valign="top" style="border-right:#e6e6e6 solid 1px;">
          <div style="height:10px;"></div>
          <div>
            <s:if test="#businessInfo.business.status==1">等待确认</s:if>
        	<s:if test="#businessInfo.business.status==2">订单已确认</s:if>
        	<s:if test="#businessInfo.business.status==3">任务已完成</s:if>
        	<s:if test="#businessInfo.business.status==4">任务确认完成</s:if>
        	<s:if test="#businessInfo.business.status==5">任务到期完成</s:if>
        	<s:if test="#businessInfo.business.status==6">已确认付款</s:if>
        	<s:if test="#businessInfo.business.status==7">申请退款中</s:if>
        	<s:if test="#businessInfo.business.status==8">退款已完成</s:if>
        	<s:if test="#businessInfo.business.status==9">订单关闭</s:if>
        	<s:if test="#businessInfo.business.status==10">交易成功</s:if>
          </div>
          <s:if test="#businessInfo.business.updatePayTimeCount<3">
             <s:if test="#businessInfo.business.updatePayTimeStatus==1"><div class="opDiv">延后付款中</div></s:if>
          </s:if>
          <div class="opDiv"><a href="javaScript: toBusinessView(<s:property value="#businessInfo.business.id"/>);" class="czjl_title_link">订单详情</a></div>										
          <s:if test="#businessInfo.business.status==10">
            <s:if test="#businessInfo.business.sellerRate==2 && #businessInfo.business.buyerRate==2"><div class="opDiv">双方已评</div>
            </s:if>
            <s:elseif test="#businessInfo.business.sellerRate==2"><div class="opDiv">已评价</div>
            </s:elseif>
            <s:elseif test="#businessInfo.business.buyerRate==2"><div class="opDiv">买家已评价</div>
            </s:elseif>
          </s:if>
      </td>
      <td align="center" valign="top" style="border-right:#e6e6e6 solid 1px;">
          <div style="height:10px;"></div>
          <s:if test="#businessInfo.business.status==1">
            <div class="opDiv"><a href="javascript:updateBusinessInfoStatus(<s:property value="#businessInfo.business.id"/>,2);" class="czjl_title_link">接受订单</a></div>
            <div class="opDiv"><a href="javascript:updateBusinessInfoStatus(<s:property value="#businessInfo.business.id"/>,9);" class="czjl_title_link">拒接订单</a></div>
          </s:if>
                                                    
          <s:if test="#businessInfo.business.status==2">
             <div class="opDiv"><a href="javascript:updateBusinessInfoStatus(<s:property value="#businessInfo.business.id"/>,3);" class="czjl_title_link">已完成任务</a></div>
            <s:if test="#businessInfo.business.updatePayTimeStatus==1">
              <div class="opDiv"><a href="javascript:updatePayTime(<s:property value="#businessInfo.business.id"/>,2);" class="czjl_title_link">查看延期</a></div>
            </s:if>
          </s:if>
          
          <s:if test="#businessInfo.business.status==4 || #businessInfo.business.status==3 || #businessInfo.business.status==5">
            <div class="opDiv"><a href="javascript:updateBusinessInfoStatus(<s:property value="#businessInfo.business.id"/>,6);" class="czjl_title_link">确认已付款</a></div>
          </s:if>
                                                  
          <s:if test="#businessInfo.business.status==10 || #businessInfo.business.status==6 ">
            <s:if test="#businessInfo.business.sellerRate==1"><div class="opDiv"><a href="javascript:addYrEvaluate(<s:property value="#businessInfo.business.id"/>);" class="czjl_title_link">评价</a></div>
            </s:if>
            <s:else>
				<div class="opDiv"><a href="javascript:viewYrEvaluate(<s:property value="#businessInfo.business.id"/>);" class="czjl_title_link">已评价</a></div>
              <s:iterator value="#request.infoToEvaluateList" var="infoToEvaluateList" >
                  <s:if test="#infoToEvaluateList.businessId==#businessInfo.business.id"><div class="opDiv"><a href="javascript:updateYrEvaluate(<s:property value="#businessInfo.business.id"/>);" class="czjl_title_link">修改评价</a></div></s:if>  
              </s:iterator> 
            </s:else>
          </s:if>
      </td>
      <td align="center">
          <div>备忘</div>
          <div>分享</div>
      </td>
    </tr>
    <tr><td colspan="9"><div style="height:10px;"></div></td></tr>
    
  </s:iterator>
  
</table>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="business!mySellerList.htm" total='${total}' ></pg:pages></td>
    </tr>
</table>



</td>
</tr>
</table>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>
