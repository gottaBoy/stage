package com.smt.webapp.service.poster;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppPoster;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.dao.poster.PosterDao;

@Service
public class PosterService {
	
	@Autowired
	private PosterDao dao;
	public List getList(int  begin,int rowCount,int sign,String type ){
		
		return dao.getList(begin, rowCount,sign,type);
	}
	
	public List getVOByID(int id,String type){
		return dao.getVOByID(id,type);
	}
	
	public void addOrUpPoster(TAppPoster poster){
		dao.addOrUpPoster(poster);
	}
	
	public void update(TAppPoster poster){
		dao.updateByVO(poster);
	}

}
