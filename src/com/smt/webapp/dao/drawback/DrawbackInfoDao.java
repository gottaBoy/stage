package com.smt.webapp.dao.drawback;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppDrawbackInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class DrawbackInfoDao extends BaseDao {

	public List getMyDrawback(int userId,int  begin,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//我申请的退款
			hql.append("select t,u.username,ui.nickName,bi from TAppDrawbackInfo t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and bi.seller=u.id");
			hql.append(" and bi.buyer=?",userId);
			hql.append(" order by bi.orderCode desc");
		}else if(sign==2){ 	//我收到的退款
			hql.append("select t,u.username,ui.nickName,bi,(select nickName from TAppUserInfo where userId=bi.seller) from TAppDrawbackInfo t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and bi.buyer=u.id");
			hql.append(" and bi.sellerCompany=?",userId);
			hql.append(" order by bi.orderCode desc");
		}else if(sign==3){ 	//后台要退款的列表
			hql.append("select t,u.username,ui.nickName,bi from TAppDrawbackInfo t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and bi.seller=u.id");
			hql.append(" and t.status=2");
			hql.append(" order by bi.orderCode desc");
		}
		List drawbackInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
 		return drawbackInfoList;
	}
	
	//获取要支付的退款单
	public List getPayList(){
		SqlAppender hql = new SqlAppender("");
		
		hql.append("select t from TAppDrawbackInfo t where status=2");
		hql.append(" order by t.id desc limit 999");
			
		List list = executeQuery(hql.getPsSql());
 		return list;
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//我申请的退款
			hql.append("select t,u.username,ui.nickName,bi from TAppDrawbackInfo t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and bi.seller=u.id");
			hql.append(" and bi.buyer=?",userId);
		}else if(sign==2){ 	//我收到的退款
			hql.append("select t,u.username,ui.nickName,bi from TAppDrawbackInfo t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and bi.buyer=u.id");
			hql.append(" and bi.sellerCompany=?",userId);
		}else if(sign==3){ 	//后台要退款的列表
			hql.append("select t,u.username,ui.nickName,bi from TAppDrawbackInfo t,TAppBusinessInfo bi,TAppUser u,TAppUserInfo ui");
			hql.append(" where bi.id=t.businessId and u.id=ui.userId and bi.buyer=u.id");
			hql.append(" and t.status=2");
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public double getReturnPrice(int orderId, int type){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t from TAppBusinessPay t where isPayment=2");
		if(type == 1) {//获取可退款金额
			hql.append(" and isPay=1");
		} else if(type == 2) {//买家已付款
			
		} else if(type == 3) {//卖家已收款
			hql.append(" and isPay=2 and confrimPay=2");
		}
		hql.append(" and t.orderId=?", orderId);
		double sum = getSum(hql.getPsSql(),hql.getParamsValues(), "price");		
		return sum;
	}
	
	public void saveOrEditDrawback(TAppDrawbackInfo drawback){
		saveOrUpdate(drawback);
	}
	
	//获取当日最大退款编号
	public String getMaxDrawbackNo(String nowDate){
		SqlAppender hql=new SqlAppender("");
		hql.append("select max(drawbackNo) from TAppDrawbackInfo where drawbackNo like 'TK"+nowDate+"%'");
		List list = getHibernateTemplate().find(hql.getPsSql());
		String maxContractNo=list.get(0)==null?"":list.get(0).toString();
		return maxContractNo;
	}
	
	//根据退款Id查询退款记录
	public TAppDrawbackInfo getDrawbackById(int id){
		TAppDrawbackInfo drawback=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppDrawbackInfo where id=?",id);
		List<TAppDrawbackInfo> drawbackList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(drawbackList!=null&&drawbackList.size()>0){
 			drawback=drawbackList.get(0);
 		}
 		return drawback;
	}

	//根据退款编号查询退款记录
	public TAppDrawbackInfo getDrawbackByCode(String orderCode){
		TAppDrawbackInfo drawback=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppDrawbackInfo where DrawbackNo=?",orderCode);
		List<TAppDrawbackInfo> drawbackList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(drawbackList!=null&&drawbackList.size()>0){
 			drawback=drawbackList.get(0);
 		}
 		return drawback;
	}
	
	//根据交易id查询退款记录
	public TAppDrawbackInfo getDrawbackByBusinessId(int businessId){
		TAppDrawbackInfo drawback=null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppDrawbackInfo where businessId=?",businessId);
		List<TAppDrawbackInfo> drawbackList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(drawbackList!=null&&drawbackList.size()>0){
 			drawback=drawbackList.get(0);
 		}
 		return drawback;
	}
}
