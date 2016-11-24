package com.smt.webapp.service.skillEvaluate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppSkillEvaluate;
import com.smt.webapp.dao.skillEvaluate.SkillEvaluateDao;

@Service
public class SkillEvaluateService {
	@Autowired
	private SkillEvaluateDao skillEvaluateDao;

	
	public void addOrEditEvaluate(TAppSkillEvaluate evaluate){
		skillEvaluateDao.addOrEditEvaluate(evaluate);
	}
	

}
