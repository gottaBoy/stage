<%
/* *
 *功能：批量付款到支付宝账户有密接口接入页
 *版本：3.3
 *日期：2012-08-14
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 *************************注意*****************
 *如果您在接口集成过程中遇到问题，可以按照下面的途径来解决
 *1、商户服务中心（https://b.alipay.com/support/helperApply.htm?action=consultationApply），提交申请集成协助，我们会有专业的技术工程师主动联系您协助解决
 *2、商户帮助中心（http://help.alipay.com/support/232511-16307/0-16307.htm?sh=Y&info_type=9）
 *3、支付宝论坛（http://club.alipay.com/read-htm-tid-8681712.html）
 *如果不想使用扩展功能请把扩展功能参数赋空值。
 **********************************************
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="alipay.config.*"%>
<%@ page import="alipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝批量付款到支付宝账户有密接口</title>
	</head>
	<%
		////////////////////////////////////请求参数//////////////////////////////////////

		//服务器异步通知页面路径
		String notify_url = AlipayConfig.batchNotifyUrl;
		//需http://格式的完整路径，不允许加?id=123这类自定义参数

		//System.out.println(request.getAttribute("date"));
		//付款账号
		String email = AlipayConfig.sellerEmail;
		//String email = new String(AlipayConfig.sellerEmail.getBytes("ISO-8859-1"),"UTF-8");
		//必填
		
		//付款账户名
		String account_name = AlipayConfig.sellerName;
		//String account_name = new String(AlipayConfig.sellerName.getBytes("ISO-8859-1"),"UTF-8");
		//必填，个人支付宝账号是真实姓名公司支付宝账号是公司名称

		//付款当天日期
		String pay_date = request.getAttribute("date").toString();
		//String pay_date = new String(date.getBytes("ISO-8859-1"),"UTF-8");
		//必填，格式：年[4位]月[2位]日[2位]，如：20100801

		//批次号
		String batch_no = request.getAttribute("batchNo").toString();
		//String batch_no = new String(orderNo.getBytes("ISO-8859-1"),"UTF-8");
		//必填，格式：当天日期[8位]+序列号[3至16位]，如：201008010000001

		//付款总金额
		String batch_fee = request.getAttribute("priceTotal").toString();
		//String batch_fee = new String(priceTotal.getBytes("ISO-8859-1"),"UTF-8");
		//必填，即参数detail_data的值中所有金额的总和

		//付款笔数
		String batch_num = request.getAttribute("payCount").toString();
		//String batch_num = new String(payCount.getBytes("ISO-8859-1"),"UTF-8");
		//必填，即参数detail_data的值中，“|”字符出现的数量加1，最大支持1000笔（即“|”字符出现的数量999个）

		//付款详细数据
		String detail_data = request.getAttribute("detail").toString();
		//String detail_data = new String(detail.getBytes("ISO-8859-1"),"UTF-8");
		
		//必填，格式：流水号1^收款方帐号1^真实姓名^付款金额1^备注说明1|流水号2^收款方帐号2^真实姓名^付款金额2^备注说明2....
		
		
		//////////////////////////////////////////////////////////////////////////////////
		
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "batch_trans_notify");
        sParaTemp.put("partner", AlipayConfig.partner);
        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("email", email);
		sParaTemp.put("account_name", account_name);
		sParaTemp.put("pay_date", pay_date);
		sParaTemp.put("batch_no", batch_no);
		sParaTemp.put("batch_fee", batch_fee);
		sParaTemp.put("batch_num", batch_num);
		sParaTemp.put("detail_data", detail_data);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
		out.println(sHtmlText);
	%>
	<body>
	</body>
</html>
