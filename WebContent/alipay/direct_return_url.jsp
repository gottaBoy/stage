<%
/* *
 功能：买家付款到第一舞台即时到帐异步通知页面
 版本：3.2
 日期：2011-03-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 该页面可在本机电脑测试
 可放入HTML等美化页面的代码、商户业务逻辑程序代码
 TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
 TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="alipay.util.*"%>
<%@ page import="alipay.config.*"%>
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝页面跳转同步通知页面</title>
        
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
  	<script type="text/javascript">
		function closeWin() {
			window.close();	
		}
	</script>
  </head>
  <body>
  <form action="" method="post" id="updateBusiness"></form>
  
  <div style="width:100%; text-align: center;">
  	<table width="1003">
  		<tr>
  			<td style="background: url('<%=request.getContextPath() %>/theme/images2/fklogo.png'); width:289px; height:48px; background-repeat:no-repeat;"></td>
  		</tr>
  		<tr height="25">
  			<td style="background: url('<%=request.getContextPath() %>/theme/images2/fkbg.png'); height:29px;"><span id="opSuccess" style="font-size: 14px; font-weight: bold; color:#FFF; display: none; padding-left:5px;">操作成功！</span><span id="opUnsuccess" style="font-size: 14px; font-weight: bold; color:#FFF; display: none; padding-left:5px;">操作失败！</span></td>
  		</tr>
  		<tr>
  			<td align="left"><div id="divSuccess" style="display:none; height:200px;">
            		<div style="background:url(<%=request.getContextPath() %>/theme/images2/fksuccess.png); width:53px; height:53px; float:left; margin-left:50px; margin-top:20px;"></div>
                    <div style="float:left; line-height:53px; height:53px; margin-top:20px; margin-left:5px;">您已成功付款！</div>
                </div>
                <div id="divUnsuccess" style="display:none; height:200px;">
            		<div style="background:url(<%=request.getContextPath() %>/theme/images2/fkUnsuccess.png); width:53px; height:53px; float:left; margin-left:50px; margin-top:20px;"></div>
                    <div style="float:left; line-height:53px; height:53px; margin-top:20px; margin-left:5px;">付款失败！</div>
                </div>
            </td>
  		</tr>
  		<tr>
  			<td align="center"><div onClick="closeWin()" style="background:url(<%=request.getContextPath() %>/theme/images2/fkreturn.png); width:126px; height:34px; cursor:pointer;"></div></td>
  		</tr>
  		<tr>
  			<td></td>
  		</tr>
  		
  	</table>
  </div>
<%
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号

	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//支付宝交易号

	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//交易状态
	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	
	//计算得出通知验证结果
	boolean verify_result = AlipayNotify.verify(params);
	if(verify_result){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码
		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
		%>		
		<script type="text/javascript">
			function save(){
			   $.ajax({
			       url:"<%=request.getContextPath() %>/member/business!updateBusinessInfoStatus.htm?id=<%=out_trade_no %>&status=3",
			       type:'POST',
			       data:$("#updateBusiness").serialize(),
			       success:function(data){
			           ////不知道java，到底执行完action后返回什么。。自己根据action的返回值判断下data看是否正确执行了    }    ,error:function(){alert('发生错误');
			       }
			   });
			}
			save(); 
			//document.getElementById("updateBusiness").action = "<%=request.getContextPath() %>/member/business!updateBusinessInfoStatus.htm?id=<%=out_trade_no %>&status=4";
			//document.getElementById("updateBusiness").submit();
			
			document.getElementById("opSuccess").style.display = "";
			document.getElementById("opUnsuccess").style.display = "none";
			
			document.getElementById("divSuccess").style.display = "";
			document.getElementById("divUnsuccess").style.display = "none";
		</script>	
				
		<%}
		
		//该页面可做页面美工编辑
		//out.println("验证成功<br />");
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
		//out.println("验证失败");
		%>		
		<script type="text/javascript">
			document.getElementById("opSuccess").style.display = "none";
			document.getElementById("opUnsuccess").style.display = "";
			
			document.getElementById("divSuccess").style.display = "none";
			document.getElementById("divUnsuccess").style.display = "";
		</script>	
				
		<%
	}
%>

  </body>
</html>