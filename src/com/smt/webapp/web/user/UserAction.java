package com.smt.webapp.web.user;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;


import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppPoster;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.company.CompanyInfoService;
import com.smt.webapp.service.information.InformationService;
import com.smt.webapp.service.poster.PosterService;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.OnlineUser;
import com.smt.webapp.util.UserSession;
@Controller
public class UserAction extends ActionSupport{
	private TAppUser user;
	public TAppUser getUser() {
		return user;
	}

	public void setUser(TAppUser user) {
		this.user = user;
	}

	private static final long serialVersionUID = 1L;
	@Autowired
	private UserService userService;
	@Autowired
	private CompanyInfoService companyInfoService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private PosterService posterService;
	@Autowired
	private InformationService informationService;
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private TaskService taskService;
	
	public String doTestIndex(){
		HttpServletRequest request = ServletActionContext.getRequest();

		
		//演艺机会
		List taskList = taskService.getTasks(0, 10, 3,null);
		request.setAttribute("taskList", taskList);
		
		//通告市集,fromWeb=1
		List tgsjList = taskService.getTasks(0, 10, 3,"1");
		request.setAttribute("tgsjList", tgsjList);
		
		//企业招聘
		List zhaopinList = informationService.getInformationListForOrg(10);
		request.setAttribute("zhaopinList", zhaopinList);
		//签约榜
		
		List businessList = businessInfoService.getLatestBusinessInfo(10);
		request.setAttribute("businessList", businessList);
		
		//幻灯片
		List<TAppPoster> list = posterService.getList(0, 5, 0,"1");
		request.setAttribute("posterList", list);
		
		return "goTestIndex";
	}
	/**
	 * 
	 * @Description: 登录方法
	 * @author hyl   
	 * @date 2013-2-22 上午9:39:06
	 * @return
	 * @throws IOException 
	 */
	public String doLogin() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		TAppUser userData = userService.findUser(user.getUsername());
		//登录成功时把相关数据放到session中
		UserSession sessionInfo = new UserSession();
		sessionInfo.setId(userData.getId());
		sessionInfo.setUserName(userData.getUsername());
		sessionInfo.setEmail(userData.getEmail());
		//OnlineUser onlineUser = new OnlineUser(userData.getUsername());
		sessionInfo.setState(userData.getState());
		sessionInfo.setIsOrg(userData.getIsOrg());
		sessionInfo.setAuthority(userData.getAuthority().toString());
		HttpSessionHelper.setHttpSession(sessionInfo);
		if(userSession!=null && userSession.getRedirect()!=null && userSession.getRedirect().length()>0) {
			sessionInfo.setRedirect(sessionInfo.getRedirect());
		}
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.removeAttribute("hasNoMy");
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		 //登录时计算用户的年龄
		TAppUserInfo userInfo =  userInfoService.findUserInfoByUserId(userData.getId());
		SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance(); 
		int yearNow = cal.get(Calendar.YEAR); 
        int monthNow = cal.get(Calendar.MONTH)+1; 
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH); 
        String  birthDay = userInfo.getBirthday();
        if (birthDay!=null&&!birthDay.equals("")) {
        	 try {
     			Date birthday=sim.parse(birthDay);
     			cal.setTime(birthday); 
     		} catch (ParseException e1) {
     			// TODO Auto-generated catch block
     			e1.printStackTrace();
     		}
             int yearBirth = cal.get(Calendar.YEAR); 
             int monthBirth = cal.get(Calendar.MONTH); 
             int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH); 
             int age = yearNow - yearBirth; 
             if (monthNow <= monthBirth) { 
                 if (monthNow == monthBirth) { 
                     //monthNow==monthBirth 
                     if (dayOfMonthNow < dayOfMonthBirth) { 
                         age--; 
                     } 
                 } else { 
                     //monthNow>monthBirth 
                     age--; 
                 } 
             } 
             if(age!=userInfo.getAge()){
             	userInfo.setAge(age);
             	userInfoService.saveUserInfo(userInfo);
             }
		}
       // 登录时计算用户的年龄*end*/
		//登录后跳转到相应的页面
		
		String urlRewriteUrl = request.getParameter("urlRewriteUrl");
		String urlRewriteParam = request.getParameter("urlRewriteParam");
		if(!"0".equals(urlRewriteUrl) && urlRewriteUrl != null){
			String url = request.getContextPath()+"/"+urlRewriteUrl+".htm?id="+urlRewriteParam;
			response.sendRedirect(url);
			return null;
		}
		try {
			if(StringUtils.isNotBlank((String)request.getSession().getAttribute("needUserId"))){
				request.getSession().removeAttribute("needUserId");
				response.getWriter().print(sessionInfo.getId());
			}else{
				response.getWriter().print(1);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void doWindowLogin() throws IOException{
		TAppUser userData = userService.findUser(user.getUsername());
		//登录成功时把相关数据放到session中
		UserSession sessionInfo = new UserSession();
		sessionInfo.setId(userData.getId());
		sessionInfo.setUserName(userData.getUsername());
		sessionInfo.setEmail(userData.getEmail());
		//OnlineUser onlineUser = new OnlineUser(userData.getUsername());
		sessionInfo.setState(userData.getState());
		sessionInfo.setIsOrg(userData.getIsOrg());
		sessionInfo.setAuthority(userData.getAuthority().toString());
		HttpSessionHelper.setHttpSession(sessionInfo);
	}
	
	
	/**
	 * 
	* @Title: doOut
	* @author huyuanliang
	* @date 2013-4-10 上午9:50:30
	* @Description: TODO 退出登录方法
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String doOut() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSessionHelper.removeUserSession(request);
		try {
			response.sendRedirect(request.getContextPath() + "/index.html");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	* @Title: check
	* @author huyuanliang
	* @date 2013-4-10 上午9:51:26
	* @Description: TODO 检查用户名方法
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String check(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String userName=request.getParameter("user.username");
		String userPsd=request.getParameter("user.userPsd");
		TAppUser userData = userService.findUser(userName);
		try {
			if(userData != null){
				if(userPsd.equals(userData.getUserPsd())){
					response.getWriter().print("2");	  //密码相同，通过验证
				}else{
					response.getWriter().print("0");	//密码错误
				}
			}else{
				response.getWriter().print("1");		//用户名不存在
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	/**
	 * @Description: 修改密码事件
	 * @author hyl   
	 * @date 2013-2-22 上午9:38:20
	 * @return
	 */
	public String doUpdatePassWord(){
		
		return "passWord";
	}
	
	public String doUpdateEmail(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		String flag = request.getParameter("flag");
		
		//可以根据传入的userId来判断，没有值的默认登录用户
		//String userName = "";
		int userId = 0;
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			userId = Integer.parseInt(request.getParameter("userId"));
			//TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
			//userName = userInfo.getName();
		}else{
			//userName = HttpSessionHelper.getUserSession(request).getUserName();
			userId = HttpSessionHelper.getUserSession(request).getId();
		}
		//TAppUser user = userService.findUser(userName);
		TAppUser user = userService.findUserById(userId);
		if (flag.equals("1")) {
			request.setAttribute("Email", user.getEmail());
		}else if (flag.equals("2")) {
			TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(user.getId());
			request.setAttribute("Mobile", userInfo.getMobile());
		}
		request.setAttribute("flag", flag);
		return "email";
	}
	
	/**
	 * 
	 * @Description:修改密码
	 * @author hyl   
	 * @date 2013-2-22 上午9:38:45
	 * @return
	 */
	public String updatePwd(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String newPwd = request.getParameter("new_pass");
		
		
		int userId = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(userId<=0){
			userId = HttpSessionHelper.getUserSession(request).getId();	
		}
		TAppUser user = userService.getUserById(userId);
		
		
		//int userID = HttpSessionHelper.getUserSession(request).getId();
		//String userName = HttpSessionHelper.getUserSession(request).getUserName();
		//TAppUser user = userService.findUser(userName);
		user.setId(userId);
		user.setUserPsd(newPwd);
		userService.updateUser(user);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	

	/**
	 * 
	 * @Description: 修改密码时，查看填写的密码是否正确
	 * @author hyl   
	 * @date 2013-2-22 上午9:37:58
	 * @return
	 */
	public String checkPassWord(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int userId = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(userId<=0){
			userId = HttpSessionHelper.getUserSession(request).getId();	
		}
		TAppUser user = userService.getUserById(userId);
		
		
		
		//String userName = HttpSessionHelper.getUserSession(request).getUserName();
		//TAppUser user = userService.findUser(userName);
		String passWord = request.getParameter("old_pass");
		String flag = "true";
		if(user != null && !passWord.equals(user.getUserPsd())){
			flag = "false";
		}
		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * @Description: 修改邮箱时，检查邮箱是否正确
	 * @author hyl   
	 * @date 2013-2-22 上午9:36:51
	 * @return
	 */
	public String checkEmail(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int userId = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(userId<=0){
			userId = HttpSessionHelper.getUserSession(request).getId();	
		}
		TAppUser user = userService.getUserById(userId);
		
		//TAppUser user = userService.findUser(userName);
		String email = request.getParameter("old_email");
		String flag = "true";
		if(user != null && !email.equals(user.getEmail())){
			flag = "false";
		}
		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	 * @Description:修改邮箱
	 * @author hyl   
	 * @date 2013-2-22 上午9:38:45
	 * @return
	 */
	public String updateEmail(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String email = request.getParameter("new_email");
		int userId = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(userId<=0){
			userId = HttpSessionHelper.getUserSession(request).getId();	
		}
		
		TAppUser user = userService.findUserById(userId);
		user.setId(userId);
		user.setEmail(email);
		userService.updateUser(user);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public String updateMobile(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String mobile = request.getParameter("new_mobile");
		
		int userId = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		//String userName = HttpSessionHelper.getUserSession(request).getUserName();
		//TAppUser user = userService.findUser(userName);
		if(userId<=0){
			userId = HttpSessionHelper.getUserSession(request).getId();	
		}
		TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
		userInfo.setId(userInfo.getId());
		userInfo.setMobile(mobile);
		userInfoService.updateUserInfo(userInfo);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	 * @Description:修改认证状态
	 * @author lllai 
	 * @date 2013-3-2 上午9:38:45
	 * @return
	 */
	public String updateRzState(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id =Integer.parseInt(request.getParameter("id"));	
		String flag=request.getParameter("flag");	
		TAppUser user = userService.findUserByUserId(id);
		user.setRzState(flag);
		userService.updateUser(user);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	* @Title: updateRzStateAll
	* @author huyuanliang
	* @date 2013-4-10 上午9:52:35
	* @Description: TODO 批量修改认证状态方法
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String updateRzStateAll(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String  idls =request.getParameter("idls");	
		
		String[] ids = idls.split("\\|");           
        for (int i = 0; i < ids.length; i++)
        {
        	TAppUser user = userService.findUserByUserId(Integer.parseInt(ids[i]));
    		user.setRzState("3");
    		userService.updateUser(user);        	
        }

		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	* @Title: updateState
	* @author huyuanliang
	* @date 2013-4-10 上午9:54:43
	* @Description: TODO 禁用或启用用户的方法
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String updateState(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int orgid = userSession.getId();
		int id =Integer.parseInt(request.getParameter("id"));	
		String flag=request.getParameter("flag");	
		TAppUser user = userService.findUserByUserId(id);
		user.setState(flag);
		userService.updateUser(user);
		TAppCompanyInfo companyInfo = new TAppCompanyInfo();
		companyInfo.setBusinessId(orgid);
		companyInfo.setYrUserId(id);
		companyInfo.setType(2);
		companyInfoService.saveInfo2(companyInfo,2,"-1");
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 
	 * @Title: updateState
	 * @author huyuanliang
	 * @date 2013-4-10 上午9:54:43
	 * @Description: TODO 禁用或启用用户的方法
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 */
	public String deleteUser(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int orgid = userSession.getId();
		int id =Integer.parseInt(request.getParameter("id"));	
		String flag=request.getParameter("flag");	
		TAppUser user = userService.findUserByUserId(id);
		user.setState("2"); //0,停用 1：启用 2企业用户作废指定艺人
		userService.updateUser(user);
		TAppCompanyInfo companyInfo = new TAppCompanyInfo();
		companyInfo.setBusinessId(orgid);
		companyInfo.setYrUserId(id);
		companyInfo.setType(2);
		companyInfoService.saveInfo2(companyInfo,2,"-1");
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	

}
