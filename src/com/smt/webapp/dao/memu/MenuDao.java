package com.smt.webapp.dao.memu;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppMenu;
import com.smt.entity.TAppUser;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class MenuDao extends BaseDao{

	public List<TAppMenu> getMenusByUserID(int id) {
		// TODO Auto-generated method stub
		SqlAppender hql1 = new SqlAppender("select t from TAppUser t where  1=1 ");
		hql1.append(" and t.id =?",id);
		List<TAppUser> list = executeQuery(hql1.getPsSql(),hql1.getParamsValues());
		
		int roleId = list.get(0).getRoleId();
		SqlAppender hql2 = new SqlAppender("select m from TAppMenu m,TAppRoleAuthority r where m.active ='1' and m.id=r.menuId ");
		
		hql2.append(" and r.roleId=?", roleId);
		hql2.append(" order by m.menuNo");
		
		List<TAppMenu> menus = executeQuery(hql2.getPsSql(),hql2.getParamsValues());					
		return menus;		
	}
	

}
