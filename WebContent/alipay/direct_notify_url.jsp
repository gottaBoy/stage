<%
/* *
 功能：买家付款到第一舞台即时到帐同步通知页面
 版本：3.3
 日期：2012-08-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
 该页面调试工具请使用写文本函数logResult，该函数在com.alipay.util文件夹的AlipayNotify.java类文件中
 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="alipay.util.*"%>
<%@ page import="alipay.config.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	//获取支付宝POST过来反馈信息
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
		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
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
	if(AlipayNotify.verify(params)){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码
		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		if(trade_status.equals("TRADE_FINISHED")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			//注意：
			//该种交易状态只在两种情况下出现
			//1、开通了普通即时到账，买家付款成功后。
			//2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
		} else if (trade_status.equals("TRADE_SUCCESS")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			try {
				Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
				String url = AlipayConfig.databaseUrl;
				Connection conn= DriverManager.getConnection(url); 
				Statement stmt =conn.createStatement(); 
				Statement stmt1 =conn.createStatement(); 
				Statement stmt2 =conn.createStatement(); 
				String orderCode = out_trade_no.substring(0, out_trade_no.length() - 3);
				String posStr = out_trade_no.substring(out_trade_no.length() - 3, out_trade_no.length());
				int pos = Integer.parseInt(posStr);
				String sql = "select * from t_app_business_info where orderCode='"+orderCode+"'"; 
				ResultSet rs = stmt.executeQuery(sql); 
				while(rs.next()) {
					ResultSet rs1 = stmt2.executeQuery("select count(*) a from t_app_business_pay where orderId=" + rs.getInt("id") + " and isPayment=1"); 
					int count = 0;
					while(rs1.next()) {
						count = rs1.getInt("a");
					}
					if(count == 1) {
						if(!rs.getString("status").equals("4")) {
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
							String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
							stmt1.executeUpdate("UPDATE t_app_business_info SET status=4 WHERE orderCode='" + rs.getString("orderCode")+"'");
							stmt1.executeUpdate("UPDATE t_app_business_pay SET actualPayTime='"+createDateTime+"',isPayment=2,confrimPay=2 WHERE orderId=" + rs.getInt("id")+" and pos=" + pos);
							stmt1.executeUpdate("insert into t_app_message(Status,ToUserId,FromUserId,Title,Content,CreatTime,type) values (0,"+rs.getInt("seller")+","+rs.getInt("buyer")+",'订单已经付款','订单("+rs.getString("orderCode")+")已经付款，请按时间去演出。','"+createDateTime+"',2)");
						}
					} else if(count > 1) {
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
						String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
						stmt1.executeUpdate("UPDATE t_app_business_info SET status=3 WHERE orderCode='" + rs.getString("orderCode")+"'");
						stmt1.executeUpdate("UPDATE t_app_business_pay SET actualPayTime='"+createDateTime+"',isPayment=2,confrimPay=2 WHERE orderId=" + rs.getInt("id")+" and pos=" + pos);
						stmt1.executeUpdate("insert into t_app_message(Status,ToUserId,FromUserId,Title,Content,CreatTime,type) values (0,"+rs.getInt("seller")+","+rs.getInt("buyer")+",'订单已经付款','订单("+rs.getString("orderCode")+")已经部分付款，请注意查收。','"+createDateTime+"',2)");
					}
					
				}
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (stmt1 != null) {
					try {
						stmt1.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (stmt2 != null) {
					try {
						stmt2.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch(Exception e){
				e.printStackTrace();
			}
			//注意：
			//该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
		}
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
		out.println("success");	//请不要修改或删除
		//////////////////////////////////////////////////////////////////////////////////////////
	}else{//验证失败
		out.println("fail");
	}
%>