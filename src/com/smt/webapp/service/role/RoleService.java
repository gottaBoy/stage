package com.smt.webapp.service.role;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.smt.entity.TAppRole;
import com.smt.entity.TAppRoleAuthority;
import com.smt.webapp.dao.role.RoleDao;
@Controller
public class RoleService {
	@Autowired
	private RoleDao dao;
	
	
	public int getTotal(int rowCount, String roleName, int roleId){
		return dao.getTotal(rowCount, roleName, roleId);
	}

	public List getRoleList(int begin,int rowCount, String roleName){
		return dao.getRoleList(begin, rowCount, roleName);
	}

	public TAppRole getRoleById(int id){
		return dao.getRoleById(id);
	}

	public TAppRole getRoleByName(String name){
		return dao.getRoleByName(name);
	}

	public List getRoleAuthList(int id){
		return dao.getRoleAuthList(id);
	}

	public List getMenuList(){
		return dao.getMenuList();
	}

	public void addOrUpdateRole(TAppRole role){
		dao.addOrUpdateRole(role);
	}

	public void addOrUpdateRoleAuth(TAppRoleAuthority auth){
		dao.addOrUpdateRoleAuth(auth);
	}
	
	public void delForSql(String sql){
		dao.delForSql(sql);
	}

	public boolean getUserByRoleId(int roleId){
		return dao.getUserByRoleId(roleId);
	}

	public int getUserTotal(String  keywords,int rowCount, int isRole){
		return dao.getUserTotal(keywords, rowCount, isRole);
	}

	public List getUserList(String keywords, int begin, int rowCount, int isRole) {
		return dao.getUserList(keywords, begin, rowCount, isRole);
	}

	public List getUserListByRoleId(int begin, int rowCount, int roleId) {
		return dao.getUserListByRoleId(begin, rowCount, roleId);
	}
}
