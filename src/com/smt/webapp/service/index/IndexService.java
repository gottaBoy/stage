package com.smt.webapp.service.index;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.webapp.dao.index.IndexDao;

@Service
public class IndexService {

@Autowired
private IndexDao dao;
	public int getCountForUser(){
		return dao.getCountForUser();
	}
}
