package com.smt.webapp.service.evaluate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import z.B.u;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppSkillEvaluate;
import com.smt.webapp.dao.evaluate.BusinessEvaluateDao;

@Service
public class BusinessEvaluateService {
	@Autowired
	private BusinessEvaluateDao businessEvaluateDao;

	public List getMyBusinessEvaluate(int userId,int  begin,int rowCount,int sign){
		return businessEvaluateDao.getMyBusinessEvaluate(userId, begin, rowCount, sign);
	} 
	public List getMyBusinessEvaluate(int userId,int  begin,int rowCount,int sign,int starLevel){
		return businessEvaluateDao.getMyBusinessEvaluate(userId, begin, rowCount, sign,starLevel);
	}
	public List getSkillEvaluate(int skillId,int  begin,int rowCount,int sign){
		return businessEvaluateDao.getSkillEvaluate(skillId, begin, rowCount, sign);
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		return businessEvaluateDao.getTotal(userId, rowCount, sign);
	}
	public int getUnreadTotal(int userId,int rowCount,int sign){
		return businessEvaluateDao.getUnreadTotal(userId, rowCount, sign);
	}
	public void updateUnread(int userId,int rowCount, int page) {
		businessEvaluateDao.updateUnread(userId, rowCount, page);
	}
	public int getTotal(int userId,int sign){
		return businessEvaluateDao.getTotal(userId, sign);
	}
	public int getMyBusinessEvaluateTotal(int userId,int sign,int starLevel){
		return businessEvaluateDao.getMyBusinessEvaluateTotal(userId, sign,starLevel);
	}
	public int getSkillEvaluateTotal(int skillId,int rowCount,int sign){
		return businessEvaluateDao.getSkillEvaluateTotal(skillId, rowCount, sign);
	}
	public int getSkillEvaluateTotalAll(int skillId){
		return businessEvaluateDao.getSkillEvaluateTotalAll(skillId);
	}
	public void addOrEditEvaluate(TAppBusinessEvaluate evaluate){
		businessEvaluateDao.addOrEditEvaluate(evaluate);
	}
	public String getMyBusinessEvaluateByCreatId(int creatId,int bussinessId){
		return businessEvaluateDao.getMyBusinessEvaluateByCreatId(creatId,bussinessId);
	}
	public TAppBusinessEvaluate getBusinessEvaluateByCreatId(int creatId,int bussinessId){
		return businessEvaluateDao.getBusinessEvaluateByCreatId(creatId,bussinessId);
	}
	public int deleteEvalute(int userId,int bussinessId){
		return businessEvaluateDao.deleteEvalute(userId,bussinessId);
	}
	public List<TAppBusinessEvaluate> getInfoToEvaluate(int userId){
		return businessEvaluateDao.getInfoToEvaluate(userId);
	}
}
