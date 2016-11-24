package com.smt.webapp.service.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppBusinessInfo;
import com.smt.entity.TAppScheduleInfo;
import com.smt.webapp.dao.schedule.ScheduleInfoDao;

@Service
public class ScheduleInfoService {

	@Autowired
	private ScheduleInfoDao scheduleInfoDao;
	
	public List<TAppScheduleInfo> getScheduleInfoByUserId(int userId){
		return scheduleInfoDao.getScheduleInfoByUserId(userId);
	}
	
	public TAppScheduleInfo getScheduleInfoById(int id){
		return scheduleInfoDao.getScheduleInfoById(id);
	}
	
	public void addScheduleInfo(TAppScheduleInfo item){
		scheduleInfoDao.addScheduleInfo(item);
	}
	
	public void updateScheduleInfo(TAppScheduleInfo item){
		scheduleInfoDao.updateScheduleInfo(item);
	}
	
	public void delScheduleInfo(TAppScheduleInfo item){
		scheduleInfoDao.delScheduleInfo(item);
	}
	
	public boolean checkStartDate(String startDate,String endDate,int id,int userId){
		List<TAppScheduleInfo> list=scheduleInfoDao.checkStartDate(startDate,endDate,id,userId);
		if(list!=null&&list.size()>0){
			return false;	 //档期时间重叠，不允许添加
		}else{
			return true;	//档期时间不重叠，可以添加
		}
	}

	public List<TAppScheduleInfo> getScheLikeYm(String ym,int id) {
		// TODO Auto-generated method stub
		return scheduleInfoDao.getScheLikeYm(ym,id);
	}
	
	public List<TAppBusinessInfo> getSchedxYm(String ym,int id){
		
		return scheduleInfoDao.getSchedxYm(ym, id);
	}
}
