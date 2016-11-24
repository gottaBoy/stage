package com.smt.webapp.service.evaluation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppUserEvaluation;
import com.smt.webapp.dao.evaluation.UserEvaluationDao;

@Service
public class UserEvaluationService {

	@Autowired
	private UserEvaluationDao userEvaluationDao;
	
	/****/
	public TAppUserEvaluation getUserEvaluationById(int userId){
		return userEvaluationDao.getUserEvaluationById(userId);
	}
	public void addOrEdituserEvaluation(TAppUserEvaluation evaluation){
		userEvaluationDao.addOrEdituserEvaluation(evaluation);
	}
	public void saveGradeValue(TAppBusinessEvaluate evaluatie,int userId){
		userEvaluationDao.saveGradeValue(evaluatie,userId);
	}
	/****/
	
}
