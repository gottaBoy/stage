package com.smt.webapp.dao.business;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppBusinessCost;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppBusinessPay;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppCompanyPayRecord;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUploadFile;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class BusinessInfoDao extends BaseDao {

	//获取我的交易（sign=1为我是签约者，sign=2为我是被签约者）
	public List getMyBusiness(int userId,int  begin,int rowCount,int sign, int type, String costName){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//我是签约者 老板
			//hql.append("select t,u.username,ui.nickName from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui where t.seller=u.id and u.id=ui.userId");
			hql.append("select t from TAppBusinessInfo t where 1=1");
			hql.append(" and t.buyer=?",userId);

			if(type == 1) {
				hql.append(" and (t.status=2 )");
			} else if(type == 2) {
				hql.append(" and (t.status=3 )");
			} else if(type == 3) {
				hql.append(" and (t.status=10 or t.status=6 ) and t.buyerRate=1 ");
			}
			
			
			if(!costName.equals("")) {
				hql.append(" and t.id in(select orderId from TAppBusinessCost where costId in(select id from TAppTalentCategory where typeName like ?))", "%"+costName+"%");
			}
			
			hql.append(" order by t.createTime desc");
		}else if(sign==2){ 	//我是被签约者 艺人
			//hql.append("select t,u.username,ui.nickName,(select nickName from TAppUserInfo where userId=t.seller) from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui  where t.buyer=u.id and u.id=ui.userId ");
			hql.append("select t from TAppBusinessInfo t where 1=1");
			hql.append(" and (t.seller=?",userId);
			hql.append(" or t.sellerCompany=?)",userId);

			if(type == 1) {
				hql.append(" and t.status=1");
			} else if(type == 2) {
				hql.append(" and t.status=2");
			} else if(type == 3) {
				hql.append(" and(t.status=3 or t.status=4 or t.status=5 )");
			} else if(type == 4) {
				hql.append(" and (t.status=10 or t.status=6 ) and t.sellerRate=1");
			}
			
			if(!costName.equals("")) {
				hql.append(" and t.id in(select orderId from TAppBusinessCost where costId in(select id from TAppTalentCategory where typeName like ?))", "%"+costName+"%");
			}
			hql.append(" order by t.createTime desc");
		} else if(sign==3){ 	//公司要付款的记录
			hql.append("select t,u.username,ui.nickName,ui1.name as name,ui1.nickName as nickName1,(select sum(price1) from TAppBusinessPay where isPay=1 and confrimPay=2 and isPayment=2 and orderId=t.id) from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui,TAppUser u1,TAppUserInfo ui1 where t.buyer=u.id and u.id=ui.userId and t.seller=u1.id and u1.id=ui1.userId and t.id in(select orderId from TAppBusinessPay where isPay=1 and confrimPay=2 and isPayment=2)");
			hql.append(" order by t.createTime desc");
		}
		List businessInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);

 		return businessInfoList;
	}
	
	public List getBusinessPayList(int id, int type){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t from TAppBusinessPay t where ");
		hql.append(" t.orderId=?",id);
		if(type == 2) {//获取所有需要确认付款给乙方的记录
			hql.append(" and t.isPayment=2 and t.confrimPay=1");
		}
		hql.append(" order by t.pos");
		List payList = executeQuery(hql.getPsSql(),hql.getParamsValues());

 		return payList;
	}
	public List getBusinessCost(int id, int type){
		SqlAppender hql = new SqlAppender("");
		if(type == 1) {
			hql.append("select t,(select typeName from TAppTalentCategory where id=t.costId) from TAppBusinessCost t where ");
		} else {
			hql.append("select t from TAppBusinessCost t where ");
		}
		hql.append(" t.orderId=?",id);
		hql.append(" order by t.id");
		List costList = executeQuery(hql.getPsSql(),hql.getParamsValues());

 		return costList;
	}
	
	//获取要支付的订单
	public List getPayList(){
		SqlAppender hql = new SqlAppender("");
		
		hql.append("select t from TAppBusinessPay t where isPay=1 and confrimPay=2 and isPayment=2");
		hql.append(" order by t.id desc limit 999");
		
//		hql.append("select t from TAppBusinessInfo t where id in(select orderId from TAppBusinessPay where isPay=1 and confrimPay=2 and isPayment=2)");
//		hql.append(" order by t.createTime desc limit 999");
			
		List businessInfoList = executeQuery(hql.getPsSql());
 		return businessInfoList;
	}
	
	public int getTotalByUserId(int userId, int type){
		SqlAppender hql = new SqlAppender("");
		//获取登录用户我的交易中要做的订单条数
		if(type == 1) {//我是签约者和被签约者的总条数
			hql.append("from TAppBusinessInfo where (buyer=?", userId);
			hql.append(" and (status=3 or status=4 or status=8 or status=11))");
			hql.append(" or (seller=?", userId);
			hql.append(" and (status=2 or status=4 or status=7))");
		} else if(type == 2) {//我是签约者
			hql.append("from TAppBusinessInfo where (buyer=?", userId);
			hql.append(" and (status=3 or status=4 or status=8 or status=11))");
		} else if(type == 3) {//我是被签约者
			hql.append("from TAppBusinessInfo where ");
			hql.append(" (seller=?", userId);
			hql.append(" and (status=2 or status=4 or status=7))");
		}
		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
	
	public int getTotal(int userId,int rowCount,int sign, int type, String costName){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//我是签约者 老板 
			hql.append("select t,u.username,ui.nickName from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui where t.seller=u.id and u.id=ui.userId");
			hql.append(" and t.buyer=?",userId);
			
			if(type == 1) {
				hql.append(" and (t.status=2 )");
			} else if(type == 2) {
				hql.append(" and (t.status=3 )");
			} else if(type == 3) {
				hql.append(" and (t.status=10 or t.status=6 ) and t.buyerRate=1 ");
			}
			
			if(!costName.equals("")) {
				hql.append(" and t.id in(select orderId from TAppBusinessCost where costId in(select id from TAppTalentCategory where typeName like ?))", "%"+costName+"%");
			}
			
			hql.append(" order by t.createTime desc");
		}else if(sign==2){ 	//我是被签约者  艺人
			hql.append("select t,u.username,ui.nickName from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui where t.buyer=u.id and u.id=ui.userId ");
			hql.append(" and t.seller=?",userId);
			
			if(type == 1) {
				hql.append(" and t.status=1");
			} else if(type == 2) {
				hql.append(" and t.status=2");
			} else if(type == 3) {
				hql.append(" and(t.status=3 or t.status=4 or t.status=5 )");
			} else if(type == 4) {
				hql.append(" and (t.status=10 or t.status=6 ) and t.sellerRate=1");
			}
			
			if(!costName.equals("")) {
				hql.append(" and t.id in(select orderId from TAppBusinessCost where costId in(select id from TAppTalentCategory where typeName like ?))", "%"+costName+"%");
			}
			
			hql.append(" order by t.createTime desc");
//			hql.append("select t,u.username,ui.nickName from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui where t.buyer=u.id and u.id=ui.userId ");
//			hql.append(" and t.sellerCompany=?",userId);
//			hql.append(" order by t.createTime desc");
		} else if(sign == 3){//公司要付款的记录
			hql.append("select t from TAppBusinessInfo t where id in(select orderId from TAppBusinessPay where isPay=1 and confrimPay=2 and isPayment=2)");
			hql.append(" order by t.createTime desc");
		} else if(sign == 4){//获取登录用户我的交易中要做的订单条数
//			hql.append("from TAppBusinessInfo where (qyUserId=?", userId);
//			hql.append(" or bqyUserId=?", userId);
//			hql.append(" ) and (status=2 or status=3 or status=4 or status=6 or  status=7)");
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public int getPayCount(int orderId, int type){
		SqlAppender hql = new SqlAppender("");
		if(type == 1) {//获取订单分期付款中未付款的条数
			hql.append("select t from TAppBusinessPay t where t.isPayment=1");
			hql.append(" and t.orderId=?",orderId);
		} else if(type == 2) {//获取订单分期付款中未确认付款给乙方的条数
			hql.append("select t from TAppBusinessPay t where t.confrimPay=1");
			hql.append(" and t.orderId=?",orderId);
		}
		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		return total;
	}

	public int getCount(int userId, int type){
		SqlAppender hql = new SqlAppender("");
		if(type == 1) {//我是老板 待完成订单条数
			hql.append("select t from TAppBusinessInfo t where (status=2 )");
			hql.append(" and buyer=?", userId);
		} else if(type == 2) {//我是老板待确认 完成订单
			hql.append("select t from TAppBusinessInfo t where (status=3 or status=2)");
			hql.append(" and buyer=?", userId);
		} else if(type == 3) {//我是老板待评价
			hql.append("select t from TAppBusinessInfo t where (status=6 or status=10) and t.buyerRate=1 ");
			hql.append(" and buyer=?", userId);
		} else if(type == 4) {//我是艺人待确认
			hql.append("select t from TAppBusinessInfo t where status=1");
			hql.append(" and seller=?", userId);
		} else if(type == 5) {//我是艺人待收款
			hql.append("select t from TAppBusinessInfo t where (status=3 or status=4 or status=5)");
			hql.append(" and seller=?", userId);
		} else if(type == 6) {//我是艺人待评价
			hql.append("select t from TAppBusinessInfo t where  (status=6 or status=10)  and t.sellerRate=1");
			hql.append(" and seller=?", userId);
		} else if(type == 7) {//我是艺人待完成热任务
			hql.append("select t from TAppBusinessInfo t where  status=2 ");
			hql.append(" and seller=?", userId);
		}
		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		return total;
	}
	
	//根据交易id查交易信息
	public TAppBusinessInfo getBusinessInfoById(int id){
		TAppBusinessInfo businessInfo=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppBusinessInfo where id=?",id);
		List<TAppBusinessInfo> businessInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(businessInfoList!=null&&businessInfoList.size()>0){
 			businessInfo=businessInfoList.get(0);
 		}
 		return businessInfo;
	}
	//根据交易qyuserid(签约人)查交易信息
	public List<TAppBusinessInfo> getBusinessInfoByQyUserId(int userId){
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppBusinessInfo bi where bi.buyer=?",userId);
		
		List<TAppBusinessInfo> businessInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());

 		return businessInfoList;
	}
	//计算日期差
	public long  getDateDifference(String successTime,String nowTime){ 
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		long nd = 1000*24*60*60;//一天的毫秒数
		
		long nh = 1000*60*60;//一小时的毫秒数

		long nm = 1000*60;//一分钟的毫秒数

		long ns = 1000;//一秒钟的毫秒数

		long diff;
		long day = 0;
		//获得两个时间的毫秒时间差异
		try {
			diff = sd.parse(nowTime).getTime() - sd.parse(successTime).getTime();

			day = diff/nd;//计算差多少天

//			long hour = diff%nd/nh;//计算差多少小时
//
//			long min = diff%nd%nh/nm;//计算差多少分钟
//
//			long sec = diff%nd%nh%nm/ns;//计算差多少秒

			//输出结果

//			System.out.println("时间相差："+day+"天"+hour+"小时"+min+"分钟"+sec+"秒。==============================");
	 		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return day;
	}
	
	//计算30天内相同买卖家好差评的个数
	public int  getDatecount(int dayCount,int PJType,int userId,int bqyuserId,int orguserId){ //当前时间，天数，评价类型（1为好评，2为差评）
		int count = 0;
//		System.out.println(userId+" "+orguserId);
		try {
			
			Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
	        calendar.add(Calendar.DATE, -30);    //得到前30天
	        String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
				List<TAppBusinessEvaluate> list = getSession().createSQLQuery("SELECT * FROM(SELECT t.BusinessId FROM t_app_business_evaluate t WHERE creatId = "+userId+" AND PJGrade = '"+PJType+"' and BusinessId IN (SELECT id FROM t_app_business_info WHERE buyer = "+userId+" and seller = "+bqyuserId+" AND  createTime5 > '"+yestedayDate+"') ORDER BY creattime DESC)AS a  GROUP BY a.businessId").list();
				count = list.size();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}
	public int  getDatecount1(int dayCount,int PJType,int userId,int bqyuserId,int orguserId){ //当前时间，天数，评价类型（1为好评，2为差评）
		int count = 0;
//		System.out.println(userId+" "+orguserId);
		try {
			
			Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
	        calendar.add(Calendar.DATE, -30);    //得到前30天
	        String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
				List<TAppBusinessEvaluate> list = getSession().createSQLQuery("SELECT * FROM(SELECT t.BusinessId FROM t_app_business_evaluate t WHERE creatId = "+bqyuserId+" AND PJGrade = '"+PJType+"' and BusinessId IN (SELECT id FROM t_app_business_info WHERE qyuserId = "+userId+" and bqyuserId = "+bqyuserId+" AND orguserId = "+orguserId+" AND finishTime > '"+yestedayDate+"') ORDER BY creattime DESC)AS a  GROUP BY a.businessId").list();
				count = list.size();
	        
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}
	//10天内，相同买卖家之间同一“技能”计分不能超过三分
	public int  getBothBealoon(int dayCount,int userType,int PJType,int userId,int bqyuserId,int orguserId,int bussinessId){ //天数，用户类型，评价类型（1为好评，2为差评），评价人id，被签约人id，被签约公司id
		int flag = 0;
//		System.out.println(userId+" "+orguserId);
		try {
			SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
	        calendar.add(Calendar.DATE, -10);    //得到前10天
	        String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
	        Date yesteday=sim.parse(yestedayDate);
	        //订单信息
			TAppBusinessInfo bInfo = null;
			SqlAppender hql=new SqlAppender("");
			hql.append("FROM TAppBusinessInfo WHERE id = ?",bussinessId);
			List<TAppBusinessInfo> businessInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
	 		if(businessInfoList!=null&&businessInfoList.size()>0){
	 			bInfo=businessInfoList.get(0);
	 		}
			
			String biArray[] = bInfo.getOrderCode().split(",");
	        if (userType==1) {//签约方评价时
	        	//获取10天内的订单
	        	
				SqlAppender hql1=new SqlAppender("");
				hql1.append(" FROM TAppBusinessInfo WHERE buyer = ?",userId);
				hql1.append(" and seller = ?",bqyuserId);
				hql1.append("  AND createTime5 > ?",yesteday);
				hql1.append(" AND sellerCompany = ?",orguserId);
				List<TAppBusinessInfo> list1 = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
				for (int i = 0; i < list1.size(); i++) {
					TAppBusinessInfo bInfo1 = null;
					bInfo1 = list1.get(i);
					String biArray1[] = bInfo1.getOrderCode().split(",");
					
					if(biArray.length==biArray1.length){//集合里的元素个数相同，且一一对应，那么这两天订单的技能完全一样
						int flagI = 0;
						for (int j = 0; j < biArray.length; j++) {
							int flagK = 0;
							for (int k = 0; k < biArray1.length; k++) {
								if (biArray[j].equals(biArray1[k])) {
									flagK=1;
								}
							}
							if (flagK==0) {
								flagI = -1;
								break;
							}
						}
						if (flagI==0) {//完全相同
//							List<TAppBusinessEvaluate> list2 = getSession().createSQLQuery("SELECT * FROM(SELECT * FROM t_app_business_evaluate WHERE businessId = "+bInfo1.getId()+"  AND creatId= "+userId+")AS a GROUP BY a.businessId").list();
							TAppBusinessEvaluate bEvaluate = null;
							SqlAppender hql2=new SqlAppender("");
							hql2.append("FROM TAppBusinessEvaluate WHERE  CreatId=?",userId);
							hql2.append(" AND BusinessId=?",bInfo1.getId());
							hql2.append(" ORDER BY creatTime DESC LIMIT 1");
							List<TAppBusinessEvaluate> list2 = getHibernateTemplate().find(hql2.getPsSql(),hql2.getParamsValues());
							if(list2!=null&&list2.size()>0){
								bEvaluate=list2.get(0);
								if (Integer.parseInt(bEvaluate.getPjGrade())==PJType) {
									flag ++; 
								}
					 		}
						}
					}
				}
			}else if (userType==2) {//被签约方评价时
				//获取10天内的订单
				SqlAppender hql1=new SqlAppender("");
				hql1.append(" FROM TAppBusinessInfo WHERE buyer = ?",userId);
				hql1.append(" and seller = ?",bqyuserId);
				hql1.append("  AND createTime5 > ?",yesteday);
				hql1.append(" AND sellerCompany = ?",orguserId);
				List<TAppBusinessInfo> list1 = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
				for (int i = 0; i < list1.size(); i++) {
					TAppBusinessInfo bInfo1 = null;
					bInfo1 = list1.get(i);
					String biArray1[] = bInfo1.getOrderCode().split(",");
					
					if(biArray.length==biArray1.length){//集合里的元素个数相同，且一一对应，那么这两天订单的技能完全一样
						int flagI = 0;
						for (int j = 0; j < biArray.length; j++) {
							int flagK = 0;
							for (int k = 0; k < biArray1.length; k++) {
								if (biArray[j].equals(biArray1[k])) {
									flagK=1;
								}
							}
							if (flagK==0) {
								flagI = -1;
								break;
							}
						}
						if (flagI==0) {//完全相同
							TAppBusinessEvaluate bEvaluate = null;
							SqlAppender hql2=new SqlAppender("");
							hql2.append("FROM TAppBusinessEvaluate WHERE  CreatId=?",orguserId);
							hql2.append(" AND BusinessId=?",bInfo1.getId());
							hql2.append(" ORDER BY creatTime DESC LIMIT 1");
							List<TAppBusinessEvaluate> list2 = getHibernateTemplate().find(hql2.getPsSql(),hql2.getParamsValues());
							if(list2!=null&&list2.size()>0){
								bEvaluate=list2.get(0);
								if (Integer.parseInt(bEvaluate.getPjGrade())==PJType) {
									flag ++; 
								}
					 		}
						}
					}
				}
			}
	        
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}
	
	public int isEvaluateFlag(int qyuserId,int orguserId,int id) {
		int flag = 0;
		TAppBusinessEvaluate ue=null;
		TAppBusinessEvaluate ue1=null;
		//签约者的评价
		SqlAppender hql=new SqlAppender("");
		hql.append("FROM TAppBusinessEvaluate WHERE  CreatId=?",qyuserId);
		hql.append(" AND BusinessId=?",id);
		hql.append(" ORDER BY creatTime DESC LIMIT 1");
		List<TAppBusinessEvaluate> buEvaluate = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		if(buEvaluate!=null&&buEvaluate.size()>0){
 			ue=buEvaluate.get(0);
 		}
		//被签约者的评价
		SqlAppender hql1=new SqlAppender("");
		hql1.append("FROM TAppBusinessEvaluate WHERE  CreatId = ?",orguserId);
		hql1.append(" AND BusinessId = ?",id);
		hql1.append(" ORDER BY creatTime DESC LIMIT 1");
		List<TAppBusinessEvaluate> buEvaluate1 = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
		if(buEvaluate1!=null&&buEvaluate1.size()>0){
 			ue1=buEvaluate1.get(0);
 		}
		if (ue==null&&ue1==null) {//双方未评
			flag = 0;
		}else if (ue!=null&&ue1==null) {
			if(ue.getPjGrade().equals("1")){//签约方好评，被签约方未评
				flag = 1;
			}else{//签约方中评或差评，被签约方未评
				flag = 2;
			}
		}else if (ue==null&&ue1!=null) {
			if(ue1.getPjGrade().equals("1")){//签约方未评，被签约方好评
				flag = 3;
			}else{//签约方未评，被签约方中评或差评
				flag = 4;
			}
		}else{//双方已评
			flag = -1;
		}
		
		return flag;
	}
	
	public void upOrdowmLevel(int isOrg,TAppUserInfo userInfo,int evalution,int flag){
		String level = "0";
		if(isOrg==0){
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
		}else if(isOrg==1){
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
		}
		if (flag==1) {//买家评论，卖家
			userInfo.setSellerGrade(level);
		}else {
			userInfo.setGrade(level);
		}
		saveOrUpdate(userInfo);
	}
	
	//根据订单号查交易信息
	public TAppBusinessInfo getBusinessInfoByNo(String orderNo){
		TAppBusinessInfo businessInfo=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppBusinessInfo where orderCode=?",orderNo);
		List<TAppBusinessInfo> businessInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(businessInfoList!=null&&businessInfoList.size()>0){
 			businessInfo=businessInfoList.get(0);
 		}
 		return businessInfo;
	}
	
	//根据订单号和分期序号查询分期信息
	public TAppBusinessPay getBusinessPay(int orderId, int pos){
		TAppBusinessPay businessPay=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppBusinessPay where orderId=?",orderId);
		hql.append(" and pos=?", pos);
		List<TAppBusinessPay> payList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(payList!=null&&payList.size()>0){
 			businessPay=payList.get(0);
 		}
 		return businessPay;
	}
	
	//添加或者修改交易订单
	public void addOrEditBusinessInfo(TAppBusinessInfo businessInfo){
		saveOrUpdate(businessInfo);
	}
	public void addBusinessInfo(TAppBusinessInfo businessInfo){
		save(businessInfo);
	}
	//添加或者修改订单分期付款的记录
	public void addOrEditBusinessPay(TAppBusinessPay businessPay){
		saveOrUpdate(businessPay);
	}
	public void addBusinessPay(TAppBusinessPay businessPay){
		save(businessPay);
	}
	//添加或者修改订单中签约的艺人技能信息
	public void addOrEditBusinessCost(TAppBusinessCost businessCost){
		saveOrUpdate(businessCost);
	}
	public void addBusinessCost(TAppBusinessCost businessCost){
		save(businessCost);
	}
	//上传订单附件
	public void addOrEditBusinessFile(TAppUploadFile file){
		saveOrUpdate(file);
	}
	public void addBusinessFile(TAppUploadFile file){
		save(file);
	}
	
	//获取订单附件列表
	public List getBusinessFile(int orderId){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t from TAppUploadFile t where ");
		hql.append(" t.orderId=?",orderId);
		hql.append(" order by t.uploadDate desc");
		List<TAppUploadFile> fileList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return fileList;
	}
	
	//根据附件ID获取附件信息
	public TAppUploadFile getBusinessFileById(int id){
		TAppUploadFile businessFile = null;
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppUploadFile where id=?", id);
		List<TAppUploadFile> fileList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(fileList != null && fileList.size() > 0){
 			businessFile = fileList.get(0);
 		}
 		return businessFile;
	}
	
	//添加公司付款记录
	public void addCompanyPayRecord(TAppCompanyPayRecord payRecord){
		saveOrUpdate(payRecord);
	}
	
	//在购物车中删除订单
	public void delBusinessInfo(TAppBusinessInfo businessInfo){
		delete(businessInfo);
	}
	//在购物车中删除订单
	public void delForSql(String sql){
		executeUpdate(sql);
	}
	
	//获得购物车数据
	public List getMyCarData(int userId){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t,u.username,ui.nickName from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui where t.seller=u.id and u.id=ui.userId and t.status=1");
		hql.append(" and t.buyer=?",userId);
		hql.append(" order by t.createTime desc");
		List<TAppBusinessInfo> myCarList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return myCarList;
	}
	
	//获得购物车金额合计
	public double getMyCarSumAmount(int userId){
		SqlAppender hql = new SqlAppender("");
		hql.append("select sum(t.price) from TAppBusinessInfo t where t.status=1");
		hql.append(" and t.qyUserId=?",userId);
		List myCarList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		double myCarSumAmount=myCarList.get(0)==null?0.00:Double.parseDouble(myCarList.get(0).toString());
		return myCarSumAmount;
	}
	
	//获取被签约者的企业用户Id(无公司艺人的OrgUserId保存艺人Id）
	public int getBqyUserOfOrgUserId(int bqyUserId){
		SqlAppender hql=new SqlAppender("");
		hql.append("select t.parentID from TAppUser t where t.id=?",bqyUserId);
		List list = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		int bqyUserOfOrgUserId=list.get(0)==null?bqyUserId:Integer.parseInt(list.get(0).toString());
		return bqyUserOfOrgUserId;
	}
	
	//获取当日最大订单编号type为1是订单  2是公司支付记录
	public String getMaxContractNo(String nowDate, int type){
		SqlAppender hql=new SqlAppender("");
		if(type == 1) {
			hql.append("select max(orderCode) from TAppBusinessInfo where orderCode like '"+nowDate+"%'");
		} else if(type == 2) {
			hql.append("select max(batchNo) from TAppCompanyPayRecord where batchNo like '"+nowDate+"%'");
		}
		
		List list = getHibernateTemplate().find(hql.getPsSql());
		String maxContractNo=list.get(0)==null?"":list.get(0).toString();
		return maxContractNo;
	}
	
	//获取购物车订单条数
	public int getMyCarCount(int userId){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t from TAppBusinessInfo t where t.status=1");
		hql.append(" and t.qyUserId=?",userId);
		List myCarList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return myCarList.size();
	}
	
	//检查被签约者是否添加职业
	public int checkUserCost(int userId){
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppCostInfo where userId=?", userId);
		List<TAppUserInfo> userInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(userInfoList!=null&&userInfoList.size()>0){
 			return 1;
 		}
 		return 2;
	}
	
	//根据用户ID获取用户信息
	public TAppUserInfo getUserInfoById(int userId){
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppUserInfo where userId=?", userId);
		TAppUserInfo userInfo = null;
		List<TAppUserInfo> userInfoList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(userInfoList!=null&&userInfoList.size()>0){
 			userInfo=userInfoList.get(0);
 		}
 		return userInfo;
	}
	//根据用户ID获取用户信息
	public List getYrDdByBusinessId(int businessId){
		List a = (List)new java.util.ArrayList();
		SqlAppender hql = new SqlAppender("FROM TAppCompanyInfo WHERE  type = 3");
		hql.append(" and businessId = ?",businessId);
		List<TAppCompanyInfo> comList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		for (int i = 0; i < comList.size(); i++) {
			HashMap<String, String> map = new HashMap<String, String>();
			//能力（职业）
			TAppCompanyInfo companyInfo = comList.get(i);
			SqlAppender hql1 = new SqlAppender(" FROM TAppCostInfo WHERE orderNo = 1");
			hql1.append(" and userId =  ?",companyInfo.getYrUserId());
			map.put("userId", companyInfo.getYrUserId()+"");
			List<TAppCostInfo> costList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			if (costList!=null&&costList.size()>0) {
				TAppCostInfo costInfo = costList.get(0);
				hql1 = new SqlAppender(" FROM TAppTalentCategory WHERE ");
				hql1.append(" id =  ?",costInfo.getProfession());
				List<TAppTalentCategory> talentList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
				TAppTalentCategory talentCategory = talentList.get(0);
				map.put("profession", talentCategory.getTypeName());
				
			}
			
			//签约次数和签约收入
			hql1 = new SqlAppender(" FROM TAppBusinessInfo WHERE (STATUS ='5' OR STATUS >='7') AND STATUS !='10' ");
			hql1.append(" and seller =  ?",companyInfo.getYrUserId());
			List<TAppBusinessInfo> busList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			if (busList!=null) {
				map.put("qyTimes",busList.size()+"");
				int maney = 0;
				for (int j = 0; j < busList.size(); j++) {
					TAppBusinessInfo businessInfo = busList.get(j);
					maney +=Double.parseDouble(businessInfo.getPrice());
				}
				map.put("tatolPrice", maney+"");
			}else {
				map.put("qyTimes", "0");
			}
			
			a.add(map);
		}
		
		

 		return a;
	}

	public List getMyBusinessInfo(int userId, int begin, int length,int status) {
		SqlAppender hql = new SqlAppender("");
		
		if(userId >= 0){
			hql.append("select t,ui.nickName from TAppBusinessInfo t,TAppUserInfo ui where t.buyer = ui.userId ");
			hql.append(" and (t.seller=?",userId);
			hql.append(" or t.sellerCompany=?)",userId);
		}else{
			hql.append("select t, ui from TAppBusinessInfo t,TAppUserInfo ui where t.buyer = ui.userId ");
			//hql.append(" and t.buyer=?",userId);
		}
		hql.append(" and t.status>=?",status);
		
		hql.append(" order by t.createTime desc");
 
		List businessInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, length);

		return businessInfoList;
	}

	public int getMyBusinessInfoTotal(int userId,int status) {
		SqlAppender hql = new SqlAppender("");
		hql.append("select t from TAppBusinessInfo t,TAppUserInfo ui where t.buyer = ui.userId  ");
		hql.append(" and (t.seller=?",userId);
		hql.append(" or t.sellerCompany=?)",userId);
 
		hql.append(" and t.status>=?",status);
		
		hql.append(" order by t.createTime desc");
 
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		return total;
	}

	public List getLatestBusinessInfo(int length) {
		SqlAppender hql = new SqlAppender("");
	
		hql.append("select t,ui.nickName,ui.userId,tc.typeName,tc.id,tc.alias,u.isOrg from TAppBusinessInfo t,TAppUserInfo ui,TAppBusinessCost c, TAppTalentCategory tc, TAppUser u where ");
		hql.append(" t.seller=ui.userId");
		hql.append(" and u.id=ui.userId");
		hql.append(" and t.id=c.orderId");
		hql.append(" and c.costId=tc.id");
		hql.append(" and t.status>=?",3);
		
				
		hql.append(" order by t.createTime desc");
 
		List businessInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), 0, length);

		return businessInfoList;
	}

	public List getBusinessInfoByCategory(String filterValue) {
		SqlAppender hql = new SqlAppender("");
		
		hql.append("select t,ui.nickName,ui.userId,tc.typeName,tc.id,tc.alias,u.isOrg,bui.nickName,bui.userId,bu.isOrg from TAppBusinessInfo t,TAppUserInfo ui,TAppUserInfo bui,TAppUser bu,TAppBusinessCost c, TAppTalentCategory tc, TAppUser u  ");
		hql.append(" where t.seller=ui.userId");
		hql.append(" and t.buyer=bui.userId");
		hql.append(" and u.id=ui.userId");
		hql.append(" and bu.id=bui.userId");
		hql.append(" and t.id=c.orderId");
		hql.append(" and c.costId=tc.id");
		
		if(!filterValue.equals("newUserAdd")){
			hql.append(" and (tc.alias=?",filterValue);
			hql.append(" or (tc.parentId in (select e.id from TAppTalentCategory e where e.alias=?)) ",filterValue);
			hql.append(" or (tc.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.alias=?)) ) ",filterValue);
			hql.append(" or (tc.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.parentId in(select h.id from TAppTalentCategory h where h.alias=?)) )) )",filterValue);
		}
		
		hql.append(" and t.status>=?",3);
		
				
		hql.append(" order by t.createTime desc");
 
		List businessInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), 0, 20);

		return businessInfoList;
	}

	public List findBusiCostByBusiId(int businessId) {
		SqlAppender hql = new SqlAppender("");
		
		hql.append(" from TAppBusinessCost t  ");
		hql.append(" where t.orderId=?",businessId);
		
		//hql.append(" order by t.id desc");
 
		List businessCostList = executeQuery(hql.getPsSql(),hql.getParamsValues());

		return businessCostList;
	}

	public List getBusinessInfoByService(int id, int status, int serviceId) {
		SqlAppender hql = new SqlAppender("");
		
		hql.append(" select t,ui.nickName from TAppBusinessCost t, TAppBusinessInfo i,TAppUserInfo ui where i.buyer = ui.userId  ");
		hql.append(" and t.orderId = i.id");
		hql.append(" and i.sellerCompany = ?",id);
		hql.append(" and i.status > ? ",status);
		hql.append(" and t.costId = ? ",serviceId);
		
		hql.append(" order by i.createTime desc");
		
		List businessCostList = executeQuery(hql.getPsSql(),hql.getParamsValues());

		return businessCostList;
	}

	public List getEvaluationByService(int id, int serviceId,int starLevel) {
		SqlAppender hql = new SqlAppender("");
		
		hql.append(" from TAppBusinessCost t, TAppBusinessEvaluate i,TAppUserInfo ui where i.creatId = ui.userId  ");
		hql.append(" and t.orderId = i.businessId");
		hql.append(" and t.costId = ? ",serviceId);
		
		if(starLevel >= -1){
			hql.append(" and i.pjGrade = ? ",starLevel);
		}
		
		hql.append(" order by i.creatTime desc");
		
		List remarkList = executeQuery(hql.getPsSql(),hql.getParamsValues());

		return remarkList;
	}

	public List getEvaluationByService2(int id, int serviceId, int starLevel,int begin, int length) {
		SqlAppender hql = new SqlAppender("");
		
		hql.append(" from TAppBusinessCost t, TAppBusinessEvaluate i,TAppUserInfo ui where i.creatId = ui.userId  ");
		hql.append(" and t.orderId = i.businessId");
		hql.append(" and t.costId = ? ",serviceId);
		
		if(starLevel >= -1){
			hql.append(" and i.pjGrade = ? ",starLevel);
		}
		
		hql.append(" order by i.creatTime desc");
		
		List remarkList = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,length);

		return remarkList;
	}

	// 获取我的交易（sign=1为我是签约者，sign=2为我是被签约者）
	public List<TAppBusinessInfo> getBusinessInfosByUserIdAndRole(int userId, int sign) {
		SqlAppender hql = new SqlAppender("");
		if (sign == 1) { // 我是签约者 老板
			// hql.append("select t,u.username,ui.nickName from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui where t.seller=u.id and u.id=ui.userId");
			hql.append("select t from TAppBusinessInfo t where 1=1");
			hql.append(" and t.buyer=?", userId);
			hql.append(" order by t.createTime desc");
		} else if (sign == 2) { // 我是被签约者 艺人
			// hql.append("select t,u.username,ui.nickName,(select nickName from TAppUserInfo where userId=t.seller) from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui  where t.buyer=u.id and u.id=ui.userId ");
			hql.append("select t from TAppBusinessInfo t where 1=1");
			hql.append(" and (t.seller=?", userId);
			hql.append(" or t.sellerCompany=?)", userId);
			hql.append(" order by t.createTime desc");
		} else if (sign == 3) { // 公司要付款的记录
			hql.append("select t,u.username,ui.nickName,ui1.name as name,ui1.nickName as nickName1,(select sum(price1) from TAppBusinessPay where isPay=1 and confrimPay=2 and isPayment=2 and orderId=t.id) from TAppBusinessInfo t,TAppUser u,TAppUserInfo ui,TAppUser u1,TAppUserInfo ui1 where t.buyer=u.id and u.id=ui.userId and t.seller=u1.id and u1.id=ui1.userId and t.id in(select orderId from TAppBusinessPay where isPay=1 and confrimPay=2 and isPayment=2)");
			hql.append(" order by t.createTime desc");
		}
		List<TAppBusinessInfo> businessInfoList = executeQuery(hql.getPsSql(), hql.getParamsValues());
		return businessInfoList;
	}
	
	public int countByUserIdAndType(int userId, int type){
		SqlAppender hql = new SqlAppender("");
		//获取登录用户我的交易中要做的订单条数
		if(type == 1) {//我是签约者和被签约者的总条数
			hql.append("from TAppBusinessInfo where buyer=?", userId);
			hql.append(" or (seller=?", userId);
		} else if(type == 2) {//我是签约者
			hql.append("from TAppBusinessInfo where buyer=?", userId);
		} else if(type == 3) {//我是被签约者
			hql.append("from TAppBusinessInfo where ");
			hql.append(" seller=?", userId);
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		return total;
	}
	
	public int countByBizBroId(int userId) {
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppBusinessInfo where sellerCompany=?", userId);
		int total = getRowCount(hql.getPsSql(), hql.getParamsValues());
		return total;
	}
	
	public List<TAppBusinessInfo> getBusinessInfosByBizBroId(int userId) {
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppBusinessInfo where sellerCompany=?)", userId);
		List<TAppBusinessInfo> businessInfoList = executeQuery(hql.getPsSql(), hql.getParamsValues());
		return businessInfoList;
	}
	
	public int countByBuyerAndSeller(int buyerId, int sellerId) {
		SqlAppender hql = new SqlAppender("");
		hql.append("from TAppBusinessInfo where buyer=?", buyerId);
		hql.append(" and seller=?", sellerId);
		int total = getRowCount(hql.getPsSql(), hql.getParamsValues());
		return total;
	}
}
