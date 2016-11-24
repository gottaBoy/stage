package com.smt.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimerTask;

import alipay.config.AlipayConfig;

public class MyTimerTask extends TimerTask {

	@Override
	public void run() {
		System.out.println("-------------");
		
		Connection conn;
		try {
			Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
			String url = AlipayConfig.databaseUrl;
			conn = DriverManager.getConnection(url);
		} catch (Exception e1) {
			System.out.println("不能连接数据库");
			return;
		} 
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		try {
			stmt = conn.createStatement(); 
			stmt1 = conn.createStatement(); 
			stmt2 = conn.createStatement(); 
			stmt3 = conn.createStatement(); 
			stmt4 = conn.createStatement(); 
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			
			//获取所有不是分期付款，订单状态为已付款或演出已完成的订单
			String sql = "select * from t_app_business_info where (status=4 or status=5) and isByStages=1";
			ResultSet rs = stmt.executeQuery(sql); 
			while(rs.next()) {
				String endDate = rs.getString("endDate");
				int time = rs.getInt("endTime");
				if(time < 10) {
					endDate = endDate + " 0" + time + ":00:00";
				} else {
					endDate = endDate + " " + time + ":00:00";
				}
				int day = DateFormatUtil.getTwoDay(df.format(new Date()), endDate);
				if(day > 10) {
					stmt1.executeUpdate("UPDATE t_app_business_info SET status=6,createTime5=NOW() WHERE id=" + rs.getInt("id"));
					stmt1.executeUpdate("UPDATE t_app_business_pay SET confrimPay=2 WHERE orderId=" + rs.getInt("id"));
				}
			}
			
			//获取所有不是分期付款，订单状态为部分付款或已付款或演出已完成的订单
			//超过约定付款时间10天，自动支付给乙方
			String sql1 = "select * from t_app_business_pay where isPayment=2 and confrimPay=1 and orderId in(select id from t_app_business_info where (status=3 or status=4 or status=5) and isByStages=2)";
			ResultSet rs1 = stmt.executeQuery(sql1); 
			while(rs1.next()) {
				int day = DateFormatUtil.getTwoDay(df.format(new Date()), rs1.getString("paymentTime"));
				if(day > 10) {
					stmt1.executeUpdate("UPDATE t_app_business_pay SET confrimPay=2 WHERE id=" + rs1.getInt("id"));
					
					ResultSet rs2 = stmt2.executeQuery("select count(*) a from t_app_business_pay where orderId=" + rs1.getInt("orderId") + " and confrimPay=1"); 
					int count = 0;
					while(rs2.next()) {
						count = rs2.getInt("a");
					}
					if(count == 0) {
						stmt1.executeUpdate("UPDATE t_app_business_info SET status=6,createTime5=NOW() WHERE id=" + rs1.getInt("orderId"));
					}
				}
			}
			
			
			//到演出时间没确认的订单自动关闭
			String sql2 = "select * from t_app_business_info where status=1";
			ResultSet rs2 = stmt.executeQuery(sql2); 
			while(rs2.next()) {
				String endDate = rs2.getString("endDate");
				int time = rs2.getInt("endTime");
				if(time < 10) {
					endDate = endDate + " 0" + time + ":00:00";
				} else {
					endDate = endDate + " " + time + ":00:00";
				}
				long minutes = DateFormatUtil.getTwoDayByMinutes(df.format(new Date()), endDate);
				if(minutes >= 0) {
					stmt1.executeUpdate("UPDATE t_app_business_info SET status=9,createTime8=NOW() WHERE id=" + rs2.getInt("id"));
				}
			}
			
			//一次性支付的订单，到演出时间未付款，订单关闭，买家扣分
			String sql3 = "select * from t_app_business_info where status=2 and isByStages=1";
			ResultSet rs3 = stmt.executeQuery(sql3); 
			while(rs3.next()) {
				String endDate = rs3.getString("endDate");
				int time = rs3.getInt("endTime");
				if(time < 10) {
					endDate = endDate + " 0" + time + ":00:00";
				} else {
					endDate = endDate + " " + time + ":00:00";
				}
				long minutes = DateFormatUtil.getTwoDayByMinutes(df.format(new Date()), endDate);
				if(minutes >= 0) {
					stmt1.executeUpdate("UPDATE t_app_business_info SET status=9,createTime8=NOW() WHERE id=" + rs3.getInt("id"));
					
					stmt1.executeUpdate("insert into t_app_business_evaluate(BusinessId,CreatId,PjContent,CreatTime,PjGrade,MsGrade,TdGrade,ZlGrade) values ("+rs3.getInt("id")+",2,'逾期付款',now(),'-1','0','0','0')");
					
					String sql4 = "select * from t_app_user where id=" + rs3.getInt("buyer");
					ResultSet rs4 = stmt2.executeQuery(sql4); 
					while(rs4.next()) {
						if(rs4.getInt("isORG") == 1) {
							stmt1.executeUpdate("UPDATE t_app_user_evaluation SET evaluation=evaluation-3 WHERE userId=" + rs3.getInt("buyer"));
							
							String sql5 = "select * from t_app_user_evaluation where userId=" + rs3.getInt("buyer");
							ResultSet rs5 = stmt3.executeQuery(sql5); 
							while(rs5.next()) {
								int evalution = rs5.getInt("evaluation");
								String level = "0";
								if(evalution>0&&evalution<=10)
									level = "1";
								else if(evalution>10&&evalution<=100)
									level = "2";
								else if(evalution>100&&evalution<=500)
									level = "3";
								else if(evalution>500&&evalution<=2000)
									level = "4";
								else if(evalution>2000&&evalution<=5000)
									level = "5";
								else if(evalution>5000&&evalution<=10000)
									level = "6";
								else if(evalution>10000&&evalution<=20000)
									level = "7";
								else if(evalution>20000&&evalution<=40000)
									level = "8";
								else if(evalution>40000&&evalution<=100000)
									level = "9";
								
								stmt1.executeUpdate("UPDATE t_app_user_info SET Grade='"+level+"' WHERE userId=" + rs3.getInt("buyer"));
							}
						} else {
							stmt1.executeUpdate("UPDATE t_app_user_evaluation SET evaluation=evaluation-1 WHERE userId=" + rs3.getInt("buyer"));
							
							String sql5 = "select * from t_app_user_evaluation where userId=" + rs3.getInt("buyer");
							ResultSet rs5 = stmt3.executeQuery(sql5); 
							while(rs5.next()) {
								int evalution = rs5.getInt("evaluation");
								String level = "0";
								if(evalution>0&&evalution<=10)
									level = "1";
								else if(evalution>10&&evalution<=50)
									level = "2";
								else if(evalution>50&&evalution<=200)
									level = "3";
								else if(evalution>200&&evalution<=600)
									level = "4";
								else if(evalution>600&&evalution<=1200)
									level = "5";
								else if(evalution>1200&&evalution<=2500)
									level = "6";
								else if(evalution>2500&&evalution<=4500)
									level = "7";
								else if(evalution>4500&&evalution<=7500)
									level = "8";
								else if(evalution>7500&&evalution<=9999)
									level = "9";
								
								stmt1.executeUpdate("UPDATE t_app_user_info SET Grade='"+level+"' WHERE userId=" + rs3.getInt("buyer"));
							}
						}
					}
					
					
				}
			}
			
			
			//分期支付的订单，到付款时间未付款，订单关闭，买家扣分
			String sql4 = "select * from t_app_business_pay where isPayment=1 and orderId in(select id from t_app_business_info where (status=2 or status=3) and isByStages=2)";
			ResultSet rs4 = stmt.executeQuery(sql4); 
			while(rs4.next()) {
				long minutes = DateFormatUtil.getTwoDayByMinutes(df.format(new Date()), rs4.getString("paymentTime"));
				if(minutes > 0) {
					stmt1.executeUpdate("UPDATE t_app_business_info SET status=9,createTime8=NOW() WHERE id=" + rs4.getInt("orderId"));
					
					String sql5 = "select * from t_app_business_info where id=" + rs4.getInt("orderId");
					ResultSet rs5 = stmt2.executeQuery(sql5); 
					while(rs5.next()) {
						stmt1.executeUpdate("insert into t_app_business_evaluate(BusinessId,CreatId,PjContent,CreatTime,PjGrade,MsGrade,TdGrade,ZlGrade) values ("+rs5.getInt("id")+",2,'逾期付款',now(),'-1','0','0','0')");
						
						String sql6 = "select * from t_app_user where id=" + rs5.getInt("buyer");
						ResultSet rs6 = stmt3.executeQuery(sql6); 
						while(rs6.next()) {
							if(rs6.getInt("isORG") == 1) {
								stmt1.executeUpdate("UPDATE t_app_user_evaluation SET evaluation=evaluation-3 WHERE userId=" + rs5.getInt("buyer"));
								
								String sql7 = "select * from t_app_user_evaluation where userId=" + rs5.getInt("buyer");
								ResultSet rs7 = stmt4.executeQuery(sql7); 
								while(rs7.next()) {
									int evalution = rs7.getInt("evaluation");
									String level = "0";
									if(evalution>0&&evalution<=10)
										level = "1";
									else if(evalution>10&&evalution<=100)
										level = "2";
									else if(evalution>100&&evalution<=500)
										level = "3";
									else if(evalution>500&&evalution<=2000)
										level = "4";
									else if(evalution>2000&&evalution<=5000)
										level = "5";
									else if(evalution>5000&&evalution<=10000)
										level = "6";
									else if(evalution>10000&&evalution<=20000)
										level = "7";
									else if(evalution>20000&&evalution<=40000)
										level = "8";
									else if(evalution>40000&&evalution<=100000)
										level = "9";
									
									stmt1.executeUpdate("UPDATE t_app_user_info SET Grade='"+level+"' WHERE userId=" + rs5.getInt("buyer"));
								}
							} else {
								stmt1.executeUpdate("UPDATE t_app_user_evaluation SET evaluation=evaluation-1 WHERE userId=" + rs5.getInt("buyer"));
								
								String sql7 = "select * from t_app_user_evaluation where userId=" + rs5.getInt("buyer");
								ResultSet rs7 = stmt4.executeQuery(sql7); 
								while(rs7.next()) {
									int evalution = rs7.getInt("evaluation");
									String level = "0";
									if(evalution>0&&evalution<=10)
										level = "1";
									else if(evalution>10&&evalution<=50)
										level = "2";
									else if(evalution>50&&evalution<=200)
										level = "3";
									else if(evalution>200&&evalution<=600)
										level = "4";
									else if(evalution>600&&evalution<=1200)
										level = "5";
									else if(evalution>1200&&evalution<=2500)
										level = "6";
									else if(evalution>2500&&evalution<=4500)
										level = "7";
									else if(evalution>4500&&evalution<=7500)
										level = "8";
									else if(evalution>7500&&evalution<=9999)
										level = "9";
									
									stmt1.executeUpdate("UPDATE t_app_user_info SET Grade='"+level+"' WHERE userId=" + rs5.getInt("buyer"));
								}
							}
						}
					}
					
					
				}
			}
			
			
		} catch (SQLException e1) {
			e1.printStackTrace();
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
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
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
	}

}
