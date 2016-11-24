package com.smt.webapp.web.register;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.evaluation.UserEvaluationService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.EMailUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.RandomValidateCode;
import com.smt.webapp.util.UserSession;
@Controller
public class RegisterAction extends ActionSupport {
	private Logger logger = Logger.getLogger("mylog");
	/**
	 * 
	 */

	private TAppUser tappUser;
	
	public TAppUser getTappUser() {
		return tappUser;
	}
	public void setTappUser(TAppUser tappUser) {
		this.tappUser = tappUser;
	}

	
	@Autowired
	UserService userService;
	@Autowired
	UserEvaluationService userEvaluationService;
	private static final long serialVersionUID = 1L;
	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
	public String su2() throws Exception {
		return "su2";
	}

	public String registerSuccess() throws Exception {
		return "SAVE_SUCCESS";
	}
	
	public String success3() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("hasNoMy");
		return "success3";
	}
	
	/**
	 * huyuanliang 2013-02-04
	 * 注册保存
	 * @return
	 */
	public void save(){
		logger.info("............................asdfjsdfkl...................");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");
		int userId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("user"));
		int artId = Integer.parseInt(userService.getMaxUserIdFromSequenceTable("art"));
		tappUser.setId(userId); //*****************

		//取得验证码并在服务器端做验证，防止用户绕过浏览器提交注册
		String verification_code = request.getParameter("verification_code");
		tappUser.setCreatTime(CommonUtil.getTime(new Date()));
		tappUser.setAuthority(0);
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		if(tappUser.getIsOrg() == 0 || tappUser.getIsOrg() == 100) { //个人
			//个人用户还有后面的步骤，先不存数据库
			tappUser.setRoleId(2);
			String userMobile = request.getParameter("mobile");
			
			session.setAttribute("step1_tappUser", tappUser);
			session.setAttribute("step1_mobile", userMobile);
			session.setAttribute("artId", artId);
			
			session.setAttribute("hasNoMy", "true");
		} else if(tappUser.getIsOrg() == 1) {
			session.removeAttribute("hasNoMy");
			
			tappUser.setRoleId(3);
			if(verification_code(verification_code)){
				String userMobile = request.getParameter("mobile");
				userService.saveUser(tappUser,userMobile);
			}
		}
		

		//TAppUser userData = userService.findUser(tappUser.getUsername());
		UserSession sessionInfo = new UserSession();
		
		
		sessionInfo.setId(userId);
		sessionInfo.setUserName(tappUser.getUsername());
		sessionInfo.setEmail(tappUser.getEmail());
		
		sessionInfo.setState(tappUser.getState());
		sessionInfo.setIsOrg(tappUser.getIsOrg());
		sessionInfo.setAuthority(tappUser.getAuthority().toString());
		HttpSessionHelper.setHttpSession(sessionInfo);
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//return "SAVE_SUCCESS";
	}
	
	/**
	 * huyuanliang 2013-02-04
	 * 查看用户名是否存在或者通过用户名查找用户信息
	 * @return
	 */
	
	public String findUserByUserName(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String userName = request.getParameter("tappUser.username");
		TAppUser user = userService.findUser(userName);
		String flag = "true";
		if(user != null){
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
	
	public String findUserByNickName(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		
		String nickName = request.getParameter("userInfo.nickName");
		String userId = request.getParameter("userId");
		
		TAppUserInfo user = userService.findUserByNickName(nickName,userId);
		String flag = "true";
		if(user != null){
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
	 * huyuanliang 2013-02-04
	 * 查看验证码是否正确
	 * @return
	 */
	public String checkVerification_code(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String flag = "false";
		//取得验证码，查看验证码是否正确,正确返回true,否则返回false
		String verification_code = request.getParameter("verification_code");
		if(verification_code(verification_code)){
			flag = "true";
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
	 * huyuanliang
	 * 验证码验证
	 * @param code
	 * @return
	 */
	private boolean verification_code(String code){
		HttpSession session =  ServletActionContext.getRequest().getSession();
		String codeString = (String)session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(code.toUpperCase().equals(codeString.toUpperCase())){
			return true;
		}
		return false;
	}
	
	/**
	 * 检查邮箱是否存在
	 * @return
	 */
	public String checkEmail(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String email = request.getParameter("tappUser.email");
		if(email==null){
			email = request.getParameter("new_email");
		}
		TAppUser user = userService.findUserByEmail(email);
		String flag = "true";
		if(user != null){
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
	 * 检查手机是否存在
	 * @return
	 */
	public String checkMobile(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String flag = "true";
		String mobile = request.getParameter("mobile");
		if(StringUtils.isNotEmpty(mobile)){
			TAppUser user = userService.findUserByMobile(mobile);
			if(user != null){
				flag = "false";
			}
		}
		
		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
		
	}
	public String toFindPassword(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String userName=request.getParameter("userName")==null?"":request.getParameter("userName");
		request.setAttribute("userName", userName);
		return "toFindPassword";
	}
	
	public String toRegProtocol(){
		return "reg";
	}
	
	public String findPassword(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String email = request.getParameter("email")==null?"":request.getParameter("email");
		//String userName=request.getParameter("userName")==null?"":request.getParameter("userName");
		TAppUser user = userService.findUserByEmail(email);
		String password=user.getUserPsd();
		if(user!=null){ 
            try {
              String userNameHtml="<li>您的用户名：<span class='email_red'>"+user.getUsername()+"</span></li>";
              String strRHtml="<li>您的密码：<span class='email_red'>"+password+"</span></li>";
              StringBuffer textbuf= new StringBuffer();
              textbuf.append("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>");
              textbuf.append("<html xmlns='http://www.w3.org/1999/xhtml'><head>");
              textbuf.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />");
              textbuf.append("<title>第1舞台</title>");
              textbuf.append("<link href='css/layout.css' rel='stylesheet' type='text/css' />");
              textbuf.append("</head><body>");
              textbuf.append("<div class='email_main'>");

              textbuf.append("<h2>找回密码</h2>");
              textbuf.append("<ul><li class='email_bold'>尊敬的“第1舞台”用户您好：</li>");
              textbuf.append("<li>系统为您重新设置了安全密码，为了您的信息安全，请登录后立即修改密码。</li>");
              textbuf.append("<li>------------------------------------------------------------------------------------</li>");
              textbuf.append(userNameHtml);
              textbuf.append(strRHtml);
              textbuf.append("<li>------------------------------------------------------------------------------------</li>");
              textbuf.append(" <li>感谢您对第1舞台的支持！<br />第1舞台，为机构及个人提供优质专业的服务。<br />如有疑问或建议，请联系第1舞台客服。电话：400-999-9999");
              textbuf.append("</li></ul></div></body></html>");
             
              String sendcode =  EMailUtil.send(email, "support@shimaotong.com", "第1舞台","您在第1舞台的注册用户名和密码",textbuf.toString());
              if("0".equals(sendcode)){
                  return "findPassword_error";
              }
            }
            catch (Exception e) {
                e.printStackTrace();
                return "findPassword_error";
            }
        }
		return "findPassword_ok";
	}
	
	/**
	 * 检查邮箱是否为注册时的邮箱
	 * @return
	 */
	public String checkUserEmailOld(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String email = request.getParameter("email")==null?"":request.getParameter("email");
		String userName=request.getParameter("userName")==null?"":request.getParameter("userName");
		TAppUser user = userService.findUser(userName);
		
		String flag ="";
		if(user!=null&&user.getEmail().equals(email)){
			flag = "2";
		}else if(user==null){
			flag = "1";
		}else if(!user.getEmail().equals(email)){
			flag = "0";
		}
		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
		
	}
	public String checkUserEmail(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		
		String email = request.getParameter("email")==null?"":request.getParameter("email");
		TAppUser user = userService.findUserByEmail(email);
		
		String flag ="";
		if(user!=null){
			flag = "2";
		}else if(user==null){
			flag = "1";
		}

		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
		
	}
	

}
