package com.smt.webapp.service.menu;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppMenu;
import com.smt.webapp.dao.memu.MenuDao;

@Service
public class MenuService {

	@Autowired
	private MenuDao menuDao;
	public List<TAppMenu> getMenuByUserID(int id) {
		// TODO Auto-generated method stub
		return menuDao.getMenusByUserID(id);
		
	}

}
