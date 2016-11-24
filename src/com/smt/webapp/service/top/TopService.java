package com.smt.webapp.service.top;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppTop;
import com.smt.entity.TAppTopImg;
import com.smt.webapp.dao.top.TopDao;

@Service
public class TopService {
	@Autowired
	private TopDao dao;
	public  List<TAppTop> getListForTop(int  begin,int rowCount){
		return dao.getListForTop(begin, rowCount);
	}
	
	public TAppTop getTopById(Integer id){
		return dao.getTopById(id);
	}
	
	public  List<TAppTopImg> getListForTopImg(int  begin,int rowCount){
		return dao.getListForTopImg(begin, rowCount);
	}
	
	public void addTop(TAppTop top,List<TAppTopImg> imgs){
		 dao.addTop(top, imgs);
	}
	
	public void updateTop(TAppTop top,List<TAppTopImg> img){
		dao.updateTop(top, img);
	}
}
