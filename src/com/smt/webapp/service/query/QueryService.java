package com.smt.webapp.service.query;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppTalentCategory;
import com.smt.webapp.dao.query.QueryListDao;

@Service
public class QueryService {

	@Autowired
	private QueryListDao queryDao;
	
	public List<TAppTalentCategory> getTalentCategory(){
		return	queryDao.getTalentCategory();
	}
	
	public List getYrInfo(String placeF,String place,int sort,int orderBySign,int orderByDesc,String filterValue,int begin,int rowCount,int bprice,int eprice,String keywords,String headKeywords,String sex,String keyType){
		return queryDao.getYrInfo(placeF,place,sort,orderBySign,orderByDesc,filterValue,begin,rowCount,bprice,eprice,keywords,headKeywords,sex,keyType);
	}
	
	public int getTotal(String placeF,String place,int sort,int orderBySign,int orderByDesc,String filterValue,int begin,int rowCount,int bprice,int eprice,String keywords,String headKeywords,String sex,String keyType){
		return queryDao.getTotal(placeF,place,sort,orderBySign,orderByDesc,filterValue,begin,rowCount,bprice,eprice,keywords,headKeywords,sex,keyType);
	}
	public String getPlace(String placeId){
		return	queryDao.getPlace(placeId);
	}

	public List getFenLei(String place, int sort, String filterValue, int begin, int rowCount, int bprice,int eprice, String sex,String renZheng,String headKeywords2) {
		return queryDao.getFenLei(place,sort,filterValue,begin,rowCount,bprice,eprice,sex,renZheng,headKeywords2);
	}
	public int getFenLeiTotal(String place, int sort, String filterValue, int begin, int rowCount, int bprice,int eprice, String sex,String renZheng,String headKeywords2) {
		return queryDao.getFenLeiTotal(place,sort,filterValue,begin,rowCount,bprice,eprice,sex,renZheng,headKeywords2);
	}

	public TAppTalentCategory getTalentCategory(String filterValue) {
		return	queryDao.getTalentCategory(filterValue);
	}

	public List getOrg(String orgType, String place, int sort, int begin, int length, String renZheng,String headKeywords2) {
		return queryDao.getOrg(orgType, place,sort,begin,length,renZheng,headKeywords2);
	}

	public int getOrgTotal(String orgType, String place, int sort, int begin, int length, String renZheng,String headKeywords2) {
		return queryDao.getOrgTotal(orgType, place,sort,begin,length,renZheng,headKeywords2);
	}

	public List getOrgInfo(int start, int rowCount, String searchContent) {
		return queryDao.getOrgInfo(start, rowCount, searchContent);
	}

	public int getOrgTotal(String searchContent) {
		return queryDao.getOrgTotal(searchContent);
	}	
}
