<%
/* *
 功能：支付宝服务器异步通知页面
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
	//批量付款数据中转账成功的详细信息

	//String success_details = new String(request.getParameter("success_details").getBytes("ISO-8859-1"),"UTF-8");
	String success_details = request.getParameter("success_details");
	//System.out.println(success_details);
	String batch_no = request.getParameter("batch_no");
	//批量付款数据中转账失败的详细信息
	//String fail_details = new String(request.getParameter("fail_details").getBytes("ISO-8859-1"),"UTF-8");
	String fail_details = request.getParameter("fail_details");
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

	if(AlipayNotify.verify(params)){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码

		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		
		//判断是否在商户网站中已经做过了这次通知返回的处理
			//如果没有做过处理，那么执行商户的业务程序
			//如果有做过处理，那么不执行商户的业务程序
		try {
			Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
			String url = AlipayConfig.databaseUrl;
			Connection conn= DriverManager.getConnection(url); 
			Statement stmt =conn.createStatement(); 
			Statement stmt1 =conn.createStatement(); 
			if(success_details != null) {
				String[] orderArray = success_details.split("\\|");
				orderArray = AlipayConfig.removeTrim(orderArray);
				for(int i = 0; i < orderArray.length; i++) {
					String batchOrder = orderArray[i];
					String[] batchArray = batchOrder.split("\\^");
					String orderNo = batchArray[0];//订单编号和付款序号
					
					String sql = "select * from t_app_company_pay_record where batchNo='"+batch_no+"' and orderNo='"+orderNo+"'"; 
					ResultSet rs = stmt.executeQuery(sql); 
					while(rs.next()) {
						if(rs.getString("status").equals("1")) {
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
							String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
							
							stmt1.executeUpdate("UPDATE t_app_company_pay_record SET status=2 WHERE id=" + rs.getString("id"));
							stmt1.executeUpdate("UPDATE t_app_drawback_info SET Status=3 WHERE DrawbackNo='"+orderNo+"'");
							stmt1.executeUpdate("UPDATE t_app_business_info SET Status=8 WHERE id=(select BusinessId from t_app_drawback_info where DrawbackNo='"+orderNo+"')");
						}
					}
				}
			}
			if(fail_details != null) {
				String orderArray[] = fail_details.split("\\|");
				orderArray = AlipayConfig.removeTrim(orderArray);
				for(int i = 0; i < orderArray.length; i++) {
					String batchOrder = orderArray[i];
					String[] batchArray = batchOrder.split("\\^");
					String orderNo = batchArray[0];//订单编号和付款序号
					
					String sql = "select * from t_app_company_pay_record where batchNo='"+batch_no+"' and orderNo='"+orderNo+"'"; 
					ResultSet rs = stmt.executeQuery(sql); 
					while(rs.next()) {
						if(rs.getString("status").equals("1")) {
							stmt1.executeUpdate("UPDATE t_app_company_pay_record SET status=3 WHERE id=" + rs.getString("id"));
						}
					}
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
		out.println("success");	//请不要修改或删除

		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{//验证失败
		out.println("fail");
	}
%>
