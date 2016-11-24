package com.smt.webapp.web.role;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppMenu;
import com.smt.entity.TAppRole;
import com.smt.entity.TAppRoleAuthority;
import com.smt.entity.TAppUser;
import com.smt.webapp.service.role.RoleService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

public class RoleAction extends ActionSupport{

	private TAppRole roleInfo;

	public TAppRole getRoleInfo() {
		return roleInfo;
	}

	public void setRoleInfo(TAppRole roleInfo) {
		this.roleInfo = roleInfo;
	}
	
	@Autowired
	private RoleService service;
	@Autowired
	private UserService userService;
	
	//获取权限列表
	public String getRoleList() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		String roleName=request.getParameter("roleName")==null?"":request.getParameter("roleName");
		
		int total = service.getTotal(rowCount, roleName, 0);
		pageNum=pageNum>total?total:pageNum;
		
		List list = service.getRoleList((pageNum-1)*rowCount, rowCount, roleName);
		
		request.setAttribute("roleName", roleName);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("list", list);
		
		return "getRoleList";
	}
	
	//打开新增角色页面
	public String toAddUpdateRole() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		TAppRole role = service.getRoleById(id);
		
		List authList = service.getRoleAuthList(id);
		List menuList = service.getMenuList();
		
		List list = new ArrayList();
		
		for (int i = 0; i < menuList.size(); i++) {
			TAppMenu menu = (TAppMenu) menuList.get(i);
			Map map = new HashMap();
			map.put("menu", menu);
			
			int flag = 2;
			if(checkListById(authList, menu.getId())) {
				flag = 1;
			}
			map.put("flag", flag);
			list.add(map);
		}
		
		request.setAttribute("role", role);
		request.setAttribute("list", list);
		
		
		return "toAddUpdateRole";
	}
	
	//新增或修改角色
	public void addOrUpdateRole() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		int id = roleInfo.getId() == null ? 0 : roleInfo.getId();
		int userId = HttpSessionHelper.getUserSession(request).getId();
		
		TAppRole role = service.getRoleByName(roleInfo.getRoleName());
		
		if(id == 0) {
			if(role != null) {
				try {
					response.getWriter().print("2");
				} catch (IOException e) {
					e.printStackTrace();
				}
				return;
			}
			roleInfo.setCreater(userId);
			roleInfo.setCreateTime(new Date());
		} else {
			if(role != null && role.getId().intValue() != roleInfo.getId().intValue()) {
				try {
					response.getWriter().print("2");
				} catch (IOException e) {
					e.printStackTrace();
				}
				return;
			}
		}
		service.addOrUpdateRole(roleInfo);
		
		String authStr = request.getParameter("authStr");
		if(authStr != null && !authStr.equals("")) {
			
			service.delForSql("delete from TAppRoleAuthority where roleId=" + roleInfo.getId());
			
			String[] menuArray = authStr.split("_");
			for (int i = 0; i < menuArray.length; i++) {
				TAppRoleAuthority authority = new TAppRoleAuthority();
				authority.setRoleId(roleInfo.getId());
				authority.setMenuId(Integer.parseInt(menuArray[i]));
				
				service.addOrUpdateRoleAuth(authority);
			}
		}
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//删除角色
	public void delRole() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		if(service.getUserByRoleId(id)) {
			try {
				response.getWriter().print("2");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}
		service.delForSql("delete from TAppRole where id=" + id);
		service.delForSql("delete from TAppRoleAuthority where roleId=" + id);
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//打开角色详情
	public String toViewRole() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		TAppRole role = service.getRoleById(id);
		
		List authList = service.getRoleAuthList(id);
		List menuList = service.getMenuList();
		
		List list = new ArrayList();
		
		for (int i = 0; i < menuList.size(); i++) {
			TAppMenu menu = (TAppMenu) menuList.get(i);
			Map map = new HashMap();
			map.put("menu", menu);
			
			int flag = 2;
			if(checkListById(authList, menu.getId())) {
				flag = 1;
			}
			map.put("flag", flag);
			list.add(map);
		}
		
		request.setAttribute("role", role);
		request.setAttribute("list", list);
		
		
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		
		int total = service.getTotal(rowCount, "", id);
		pageNum=pageNum>total?total:pageNum;
		
		List userList = service.getUserListByRoleId((pageNum-1)*rowCount, rowCount, id);
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("userList", userList);
		request.setAttribute("id", id);
		
		return "toViewRole";
	}
	
	public String getUserList() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String keywords = "";
		int isRole = request.getParameter("isRole")==null?1:Integer.parseInt(request.getParameter("isRole"));
		int roleId = request.getParameter("roleId")==null?1:Integer.parseInt(request.getParameter("roleId"));
		
		int flag = request.getParameter("flag")!=null&&!"".equals(request.getParameter("flag"))?Integer.parseInt(request.getParameter("flag")):0;
		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}
		
		if(keywords == null || ("").equals(keywords)){
			keywords = "请输入关键词";
		}

		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = service.getUserTotal(keywords, rowCount, isRole);
		pageNum=pageNum>total?total:pageNum;		
		
		List userInfoList = service.getUserList(keywords, (pageNum-1)*rowCount, rowCount, isRole);	

		List list = new ArrayList();
		
		for (int i = 0; i < userInfoList.size(); i++) {
			
			Map map = new HashMap();
			map.put("userInfoList", userInfoList);
			
			Object[] objects = (Object[]) userInfoList.get(i);
			map.put("user", objects[0]);
			map.put("userInfo", objects[1]);

			TAppUser user = (TAppUser) objects[0];
			TAppRole role = service.getRoleById(user.getRoleId());
			
			if(role == null) {
				map.put("roleName", "无");
			} else {
				map.put("roleName", role.getRoleName());
			}
			
			list.add(map);
		}
		
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("keywords", keywords);
		request.setAttribute("isRole", isRole);
		request.setAttribute("roleId", roleId);
		
		return "getUserList";
	}
	
	//修改用户所属角色单个
	public void updateUserRoleId() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		int roleId = request.getParameter("roleId")==null?0:Integer.parseInt(request.getParameter("roleId"));
		int userId = request.getParameter("userId")==null?0:Integer.parseInt(request.getParameter("userId"));
		
		TAppUser user = userService.getUserById(userId);
		user.setRoleId(roleId);
		userService.updateUser(user);
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//修改用户所属角色多个
	public void updateAllUserRoleId() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		int roleId = request.getParameter("roleId")==null?0:Integer.parseInt(request.getParameter("roleId"));

		String userIdStr = request.getParameter("userIdStr");
		
		if(userIdStr != null && !userIdStr.equals("")) {
			String[] userIdArray = userIdStr.split("_");
			for (int i = 0; i < userIdArray.length; i++) {
				TAppUser user = userService.getUserById(Integer.parseInt(userIdArray[i]));
				user.setRoleId(roleId);
				userService.updateUser(user);
			}
		}
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private boolean checkListById(List list, int id) {
		for (int i = 0; i < list.size(); i++) {
			TAppMenu menu = (TAppMenu) list.get(i);
			if(id == menu.getId()) {
				return true;
			}
		}
		
		return false;
	}
}
