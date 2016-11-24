package com.smt.webapp.service.information;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppInformation;
import com.smt.webapp.dao.information.InformationDao;


@Service
public class InformationService {
	@Autowired
	private InformationDao infoDao;
	public List getInformationList(int  begin,int rowCount){
		return infoDao.getInformationList(begin,rowCount);
	}
	public List getInformationList(){
		return infoDao.getInformationList();
	}
	public List getInformationList(int userId){
		return infoDao.getInformationList(userId);
	}
	public List getInformationList(int userId,int  begin,int rowCount){
		return infoDao.getInformationList(userId,begin,rowCount);
	}
	public int getTotal(int rowCount){
		return infoDao.getTotal(rowCount);
	}
	public int getInformationTotal(int userId){
		return infoDao.getInformationTotal(userId);
	}
	public List<TAppInformation> getInfoByID(int id){
		return infoDao.getInfoByID(id);
	}

    public void suInfo(TAppInformation info){
    	infoDao.suInfo(info);
    }
    public void delInfo(TAppInformation info){
    	infoDao.delInfo(info);
    }
    
    public List getInformationMenu(int level){
    	return infoDao.getInformationMenu(level);
    }
	public List getInformationListForOrg(int rowCount) {
		return infoDao.getInformationListForOrg(rowCount);
	}
	
	public List getInformationList(String city,String searchContent, int begin, int length) {
		return infoDao.getInformationList(city,searchContent,begin,length);
	}
	public int getInformationTotal(String city, String searchContent) {
		return infoDao.getInformationTotal(city,searchContent);
	}
}
