package com.smt.webapp.service.company;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppCompanyInfo;
import com.smt.webapp.dao.company.CompanyInfoDao;

@Service
public class CompanyInfoService {

	@Autowired
	private CompanyInfoDao companyInfoDao;
	
	public void saveInfo1(TAppCompanyInfo companyInfo,int type){
		companyInfoDao.saveInfo1(companyInfo,type);
	}
	public void saveInfo2(TAppCompanyInfo companyInfo,int type,String flag){
		companyInfoDao.saveInfo2(companyInfo,type,flag);
	}
	public List getQyzxByBusinessId(int id){
		return companyInfoDao.getQyzxByBusinessId(id);
	}
	public List<TAppCompanyInfo> getXrjrByBusinessId(int id){
		return companyInfoDao.getXrjrByBusinessId(id);
	}
	public List<TAppCompanyInfo> getActiveByBusinessId(int id){
		return companyInfoDao.getActiveByBusinessId(id);
	}
	
}
