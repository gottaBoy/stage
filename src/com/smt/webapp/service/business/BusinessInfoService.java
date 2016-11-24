package com.smt.webapp.service.business;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppBusinessCost;
import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppBusinessPay;
import com.smt.entity.TAppCompanyPayRecord;
import com.smt.entity.TAppUploadFile;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.business.BusinessInfoDao;
import com.smt.entity.TAppUserInfo;
@Service
public class BusinessInfoService {

	@Autowired
	private BusinessInfoDao businessInfoDao;
	
	public int getTotalByUserId(int userId, int type){
		return businessInfoDao.getTotalByUserId(userId, type);
	}
	
	public List getMyBusiness(int userId,int  begin,int rowCount,int sign, int type, String costName){
		return businessInfoDao.getMyBusiness(userId, begin, rowCount, sign, type, costName);
	}
	public List getYrDdByBusinessId(int BusinessId){
		return businessInfoDao.getYrDdByBusinessId(BusinessId);
	}
	public List getBusinessPayList(int id, int type){
		return businessInfoDao.getBusinessPayList(id, type);
	}
	public List getBusinessCost(int id, int type){
		return businessInfoDao.getBusinessCost(id, type);
	}
	
	public int checkUserCost(int id){
		return businessInfoDao.checkUserCost(id);
	}
	
	public TAppUserInfo getUserInfoById(int id){
		return businessInfoDao.getUserInfoById(id);
	}
	
	public int getTotal(int userId,int rowCount,int sign, int type, String costName){
		return businessInfoDao.getTotal(userId, rowCount, sign, type, costName);
	}

	public int getCount(int userId, int type){
		return businessInfoDao.getCount(userId, type);
	}
	
	public int getPayCount(int orderNo, int type){
		return businessInfoDao.getPayCount(orderNo, type);
	}
	
	public TAppBusinessInfo getBusinessInfoById(int id){
		return businessInfoDao.getBusinessInfoById(id);
	}

	public TAppBusinessInfo getBusinessInfoByNo(String orderNo){
		return businessInfoDao.getBusinessInfoByNo(orderNo);
	}
	
	public TAppBusinessPay getBusinessPay(int orderId, int pos){
		return businessInfoDao.getBusinessPay(orderId, pos);
	}
	
	public void addOrEditBusinessInfo(TAppBusinessInfo businessInfo){
		businessInfoDao.addOrEditBusinessInfo(businessInfo);
	}
	
	public void addBusinessInfo(TAppBusinessInfo businessInfo){
		businessInfoDao.addBusinessInfo(businessInfo);
	}
	
	public void addOrEditBusinessPay(TAppBusinessPay businessPay){
		businessInfoDao.addOrEditBusinessPay(businessPay);
	}
	
	public void addBusinessPay(TAppBusinessPay businessPay){
		businessInfoDao.addBusinessPay(businessPay);
	}
	
	public void addOrEditBusinessCost(TAppBusinessCost businessCost){
		businessInfoDao.addOrEditBusinessCost(businessCost);
	}
	
	public void addBusinessCost(TAppBusinessCost businessCost){
		businessInfoDao.addBusinessCost(businessCost);
	}
	
	public void addOrEditBusinessFile(TAppUploadFile file){
		businessInfoDao.addOrEditBusinessFile(file);
	}
	
	public void addBusinessFile(TAppUploadFile file){
		businessInfoDao.addBusinessFile(file);
	}

	public List getBusinessFile(int orderId){
	    return businessInfoDao.getBusinessFile(orderId);
	}
	
	public TAppUploadFile getBusinessFileById(int fileId){
	    return businessInfoDao.getBusinessFileById(fileId);
	}
	
	public List getMyCarData(int userId){
	    return businessInfoDao.getMyCarData(userId);
	}
	
	public double getMyCarSumAmount(int userId){
		return businessInfoDao.getMyCarSumAmount(userId);
	}
	
	public void delBusinessInfo(TAppBusinessInfo businessInfo){
		businessInfoDao.delBusinessInfo(businessInfo);
	}
	public void delForSql(String sql){
		businessInfoDao.delForSql(sql);
	}
	
	public int getBqyUserOfOrgUserId(int bqyUserId){
		return businessInfoDao.getBqyUserOfOrgUserId(bqyUserId);
	}
	public List getPayList(){
		return businessInfoDao.getPayList();
	}

	public void addCompanyPayRecord(TAppCompanyPayRecord payRecord){
		businessInfoDao.addCompanyPayRecord(payRecord);
	}

	public List<TAppBusinessInfo> getBusinessInfoByQyUserId(int userId){
		return businessInfoDao.getBusinessInfoByQyUserId(userId);
	}
	public long getDateDifference(String successTime,String nowTime){
		return businessInfoDao.getDateDifference(successTime,nowTime);
	}
	public int getDatecount(int dayCount,int PJType,int userId,int bqyuserId,int orguserId){
		return businessInfoDao.getDatecount(dayCount,PJType,userId,bqyuserId,orguserId);
	}
	public int getDatecount1(int dayCount,int PJType,int orguserId,int bqyuserId,int userId){
		return businessInfoDao.getDatecount(dayCount,PJType,orguserId,bqyuserId,userId);
	}
	public int getBothBealoon(int dayCount,int userType,int PJType,int userId,int bqyuserId,int orguserId,int bussinessId){
		return businessInfoDao.getBothBealoon(dayCount,userType,PJType,userId,bqyuserId,orguserId,bussinessId);
	}
	public int isEvaluateFlag(int qyuserId,int orguserId,int businessId){
		return businessInfoDao.isEvaluateFlag(qyuserId,orguserId,businessId);
	}
	public void upOrdowmLevel(int isOrg,TAppUserInfo userInfo ,int evaluation,int flag){
		businessInfoDao.upOrdowmLevel(isOrg,userInfo,evaluation,flag);
	}
	
	//获取提交订单时自动生成的订单编号2013-04-26
	public String getNewContractNo(String nowDate, int type){
		nowDate=nowDate.substring(0,4)+nowDate.substring(5,7)+nowDate.substring(8,10);
		String newContractNo=nowDate+"000001";
		String maxContractNo=businessInfoDao.getMaxContractNo(nowDate, type);
		if(!maxContractNo.equals("")){
			newContractNo=nowDate+getNumberStr(Integer.parseInt(maxContractNo.substring(8))+1);
		}
		return newContractNo;
	}
	
	private String getNumberStr(int num){
		if(num<10){
			return "00000"+num;
		}else if(num>=10&&num<100){
			return "0000"+num;
		}else if(num>=100&&num<1000){
			return "000"+num;
		}else if(num>=1000&&num<10000){
			return "00"+num;
		}else if(num>=10000&&num<100000){
			return "0"+num;
		}else if(num>=100000){
			return ""+num;
		}else{
			return "000000";	//表示溢出
		}
	}
	
	public int getMyCarCount(int userId){
		return businessInfoDao.getMyCarCount(userId);
	}

	public List getMyBusinessInfo(int id, int begin, int length,int status) {
		return businessInfoDao.getMyBusinessInfo(id,begin,length,status);
	}

	public int getMyBusinessInfoTotal(int id,int status) {
		return businessInfoDao.getMyBusinessInfoTotal(id,status);
	}

	public List getLatestBusinessInfo(int length) {
		return businessInfoDao.getLatestBusinessInfo(length);
	}

	public List getBusinessInfoByCategory(String filterValue) {
		return businessInfoDao.getBusinessInfoByCategory(filterValue);
	}

	public List findBusiCostByBusiId(int businessId) {
		return businessInfoDao.findBusiCostByBusiId(businessId);
	}

	public List getBusinessInfoByService(int id, int status, int serviceId) {
		return businessInfoDao.getBusinessInfoByService(id, status, serviceId);
	}

	public List getEvaluationByService(int id, int serviceId, int starLevel) {
		List list = businessInfoDao.getEvaluationByService(id, serviceId,starLevel);
		if(list==null){
			return new ArrayList();
		}else{
			return list; 
		}
	}

	public List getEvaluationByService2(int id, int serviceId, int starLevel,	int begin, int length) {
		return businessInfoDao.getEvaluationByService2(id, serviceId,starLevel,begin, length);
	}
	
	public List<TAppBusinessInfo> getBusinessInfosByUserIdAndRole(int userId, int sign) {
		return businessInfoDao.getBusinessInfosByUserIdAndRole(userId, sign);
	}
	
	public int countByUserIdAndType(int userId, int type) {
		return businessInfoDao.countByUserIdAndType(userId, type);
	}
	
	public int countByBizBroId(int userId) {
		return businessInfoDao.countByBizBroId(userId);
	}
	
	public List<TAppBusinessInfo> getBusinessInfosByBizBroId(int userId) {
		return businessInfoDao.getBusinessInfosByBizBroId(userId);
	}
	
	public boolean checkRelations(int sellerId, int buyerId) {
		return businessInfoDao.countByBuyerAndSeller(buyerId, sellerId) > 0;
	}
}
