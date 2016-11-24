package com.smt.webapp.dao.skillEvaluate;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.config.TxNamespaceHandler;

import com.smt.entity.TAppBusinessEvaluate;
import com.smt.entity.TAppSkillEvaluate;
import com.smt.entity.TAppUserEvaluation;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.service.evaluate.BusinessEvaluateService;

@Repository
public class SkillEvaluateDao extends BaseDao {
	
	
	
	public void addOrEditEvaluate(TAppSkillEvaluate skillEvaluate){
		saveOrUpdate(skillEvaluate);
	}

	

}
