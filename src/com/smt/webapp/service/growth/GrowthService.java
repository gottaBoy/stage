package com.smt.webapp.service.growth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppGrowth;
import com.smt.webapp.dao.growth.GrowthDao;


@Service
public class GrowthService {
	@Autowired
	private GrowthDao growthDao;
	public List<TAppGrowth> getGrowthList(int id,int  begin,int rowCount){
		return growthDao.getGrowthListByUserID(id,begin,rowCount);
	}
	public int getTotal(int userID,int rowCount){
		return growthDao.getTotal(userID, rowCount);
	}
	public int getGrowthTotal(int userID){
		return growthDao.getTotal(userID);
	}
	public List<TAppGrowth> getGrowth(int id){
		return growthDao.getGrowthByID(id);
	}
	/**
     * 保存成长经历
     * @param user
     */
    public void suGrowth(TAppGrowth growth){
    	growthDao.suGrowth(growth);
    }
    public void delGrowth(TAppGrowth growth){
    	growthDao.delGrowth(growth);
    }
	public void updateGrowth(TAppGrowth growthUp) {
		growthDao.updateGrowth(growthUp);
	}
}
