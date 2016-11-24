package com.smt.webapp.service.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.smt.entity.TAppAction;
import com.smt.entity.TBaseArea;
import com.smt.webapp.dao.action.ActionDao;
@Controller
public class ActionService {
	@Autowired
	private ActionDao dao;
	
	public List<TAppAction> getActionForUserId(int userId,String date){
		
		return dao.getActionForUserId(userId,date);
	}
	
	public List<TBaseArea> getProvins(){
		
		return dao.getProvins();
	}
	
	public List<TBaseArea> getCity(int id){
		
		return dao.getCity(id);
	}
}
