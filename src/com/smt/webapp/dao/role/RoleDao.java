package com.smt.webapp.dao.role;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppBusinessCost;
import com.smt.entity.TAppRole;
import com.smt.entity.TAppRoleAuthority;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class RoleDao extends BaseDao{
	
	public int getTotal(int rowCount, String roleName, int roleId){
		SqlAppender hql = new SqlAppender("");
		if(roleId == 0) {
			hql.append("select t from TAppRole t where 1=1");
				
			if(!roleName.equals("")) {
				hql.append(" and (t.roleName like ?", "%"+roleName+"%");
				hql.append(" or t.roleDescribe like ?)", "%"+roleName+"%");
			}
				
			hql.append(" order by t.createTime desc");
		} else {
			hql.append(" from TAppUser u, TAppUserInfo t where u.id=t.userId ");
			hql.append(" and  u.roleId=?", roleId);
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());	
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	//获取角色列表
	public List getRoleList(int begin,int rowCount, String roleName){
		SqlAppender hql = new SqlAppender("");
		hql.append("select t from TAppRole t where 1=1");
		
		if(!roleName.equals("")) {
			hql.append(" and (t.roleName like ?", "%"+roleName+"%");
			hql.append(" or t.roleDescribe like ?)", "%"+roleName+"%");
		}
			
		hql.append(" order by t.createTime desc");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);

 		return list;
	}
	
	//根据角色ID获取角色
	public TAppRole getRoleById(int id){
		TAppRole role = null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppRole where id=?",id);
		List<TAppRole> roleList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(roleList != null && roleList.size() > 0){
 			role = roleList.get(0);
 		}
 		return role;
	}
	
	//根据角色名获取角色
	public TAppRole getRoleByName(String name){
		TAppRole role = null;
		SqlAppender hql=new SqlAppender("");
		hql.append("from TAppRole where roleName=?", name);
		List<TAppRole> roleList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(roleList != null && roleList.size() > 0){
 			role = roleList.get(0);
 		}
 		return role;
	}
	
	//获取角色下的权限
	public List getRoleAuthList(int id){
		SqlAppender hql = new SqlAppender("select m from TAppMenu m,TAppRoleAuthority r where m.active ='1' and m.id=r.menuId ");
		hql.append(" and r.roleId=?", id);
			
		hql.append(" order by m.menuNo");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());

 		return list;
	}
	
	//获取所有权限
	public List getMenuList(){
		SqlAppender hql = new SqlAppender("select m from TAppMenu m where m.active ='1'");
			
		hql.append(" order by m.menuNo");
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());

 		return list;
	}
	
	//新增或修改角色
	public void addOrUpdateRole(TAppRole role){
		saveOrUpdate(role);
	}
	
	//新增或修改角色下的权限
	public void addOrUpdateRoleAuth(TAppRoleAuthority auth){
		saveOrUpdate(auth);
	}
	
	public void delForSql(String sql){
		executeUpdate(sql);
	}
	
	//检查角色是否被用户使用
	public boolean getUserByRoleId(int id){
		SqlAppender hql = new SqlAppender("select u from TAppUser u where 1=1 ");
		hql.append(" and u.roleId=?", id);
			
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
		if(list == null || list.size() <= 0) {
			return false;
		}
		
 		return true;
	}
	
	public int getUserTotal(String keywords, int rowCount, int isRole){
		SqlAppender hql = new SqlAppender(" from TAppUser u, TAppUserInfo t where u.id=t.userId ");
		
		if(isRole == 1) {
			hql.append(" and  u.roleId=?", -1);
		}
		if(keywords != null && !("请输入关键词").equals(keywords)){
			hql.append(" and( t.name like ?", "%" + keywords + "%");
			hql.append(" or t.nickName like ? ", "%" + keywords + "%");
			hql.append(" or u.username like ? )", "%" + keywords + "%");
		}	
		
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	//获取用户列表
	public List getUserList(String keywords, int begin, int rowCount, int isRole) {
		SqlAppender hql = new SqlAppender(" from TAppUser u, TAppUserInfo t where u.id=t.userId");
		
		if(isRole == 1) {
			hql.append(" and  u.roleId=?", -1);
		}
		if(keywords != null && !("请输入关键词").equals(keywords)){
			hql.append(" and( t.name like ?", "%" + keywords + "%");
			hql.append(" or t.nickName like ? ", "%" + keywords + "%");
			hql.append(" or u.username like ? )", "%" + keywords + "%");
		}	
		hql.append(" order by u.creatTime desc ");

		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return list;
	}
	
	//根据角色获取用户列表
	public List getUserListByRoleId(int begin, int rowCount, int roleId) {
		SqlAppender hql = new SqlAppender(" from TAppUser u, TAppUserInfo t where u.id=t.userId");
		
		hql.append(" and  u.roleId=?", roleId);
		hql.append(" order by u.creatTime desc ");

		List list = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return list;
	}
}
