package com.smt.webapp.service.cost;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppTalentCategory;
import com.smt.webapp.dao.cost.CostDao;

@Controller
public class CostService {

	@Autowired
	private CostDao  costDao;
	public List getCostInfo(int userId, int orderId){
		return costDao.getCostInfooByUserId(userId, orderId);
	}

	public List getCostListByUserId(int userId){
		return costDao.getCostListByUserId(userId);
	}
	public List getCostListByUserId(int userId,int begin, int rowCount){
		return costDao.getCostListByUserId(userId,begin, rowCount);
	}

	public TAppTalentCategory getTAppTalentCategory(int id){
		return costDao.getTAppTalentCategory(id);
	}
	
	public List<TAppCostInfo> getCostInfoByID(int id) {
		return costDao.getCostInfoByID(id);
	}
	public void saveCost(TAppCostInfo costInfo) {
		// TODO Auto-generated method stub
		costDao.saveCost(costInfo);
	}

	public List getTalent (int flag,int userId){
		List list = costDao.getTalentByFlag(flag,userId);
		return list ;
	}
	public void delCostInfo(TAppCostInfo costInfo){
		 costDao.delCostInfo(costInfo);
	}
	public int getMaxOrderNo(int userId){
		return costDao.getMaxOrderNo(userId);
	}
	public int getOrderNoById(int id){
		return costDao.getOrderNoById(id);
	}
	public String getCostForUpdate(String profession){
		return costDao.getCostForUpdate(profession);
	}
	public Integer getParentCostId(String profession) {
		return costDao.getParentCostId(profession);
	}
	public String getParentCostId(String profession,int flag) {
		// TODO Auto-generated method stub
		return costDao.getParentCostId(profession,flag);
	}
	public String checkCostId(int userId,int costId) {
		// TODO Auto-generated method stub
		return costDao.checkCostId(userId,costId);
	}
	public List getTop3CastByUserID(int userID){
		return  costDao.getTop3CastByUserID(userID);
	}
	public String getProfessionName(String profession){
		 return  costDao.getProfessionName(profession);
	}
	public List getCostInfoByBusinessId(int id){
		 return  costDao.getCostInfoByBusinessId(id);
	}
	public String getCostName(int userId){
		 return  costDao.getCostName(userId);
	}
 
	public int getCostListByUserIdTotal(int id) {
		return  costDao.getCostListByUserIdTotal(id);
	}
	
	public int findTalentIdByTypeName(String typeName){
		return costDao.findTalentIdByTypeName(typeName);
	}
}
