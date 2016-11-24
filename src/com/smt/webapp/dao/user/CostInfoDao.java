package com.smt.webapp.dao.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppCostInfo;
import com.smt.webapp.dao.BaseDao;
@Repository
public class CostInfoDao extends BaseDao{

	/**
	 * 通过用户ID获得职业价格信息
	 * @param id
	 * @return
	 */
	public List<TAppCostInfo> getCostInfoByUserID(String id){
		return null;
	}
	
	public void saveOrUpdateCostInfo(TAppCostInfo costInfo){
		
	}
}
