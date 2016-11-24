package com.smt.webapp.web.member;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppMessage;
import com.smt.entity.TAppUser;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

@Controller
public class MessageAction extends ActionSupport {

	@Autowired
	private MessageService messageService;
	@Autowired
	private UserService userService;
	
	private TAppMessage message=new TAppMessage();
	private String toUserName;
	private String fromUserName;
	
	public String getToUserName() {
		return toUserName;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}

	public String getFromUserName() {
		return fromUserName;
	}

	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}

	public TAppMessage getMessage() {
		return message;
	}

	public void setMessage(TAppMessage message) {
		this.message = message;
	}

	public String toMessage(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		
		int total = messageService.getTotal(userId, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;

		List messageList=messageService.getMessageList(userId, (pageNum-1)*rowCount, rowCount, sign);

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("messageList", messageList);
		
		return SUCCESS;
	}
	
	public String toMessageView(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int messageId = request.getParameter("messageId")==null?1:Integer.parseInt(request.getParameter("messageId"));
		message=messageService.getMessageByID(messageId);
		if(userId==message.getToUserId()){
			message.setStatus("1");	//点击自己的短信，阅读状态改为1-已读
			messageService.addMessage(message);
		}
		toUserName=userService.findUserById(message.getToUserId()).getUsername();
		fromUserName=userService.findUserById(message.getFromUserId()).getUsername();
		return "toMessageView";
	}
	
	public String toAddMessage(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int messageId = request.getParameter("messageId")==null?1:Integer.parseInt(request.getParameter("messageId"));
		message=messageService.getMessageByID(messageId);
		return "toAddMessage";
	}

	public void delMessage(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")==null?1:Integer.parseInt(request.getParameter("id"));
		//int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		message.setId(id);
		messageService.delMessage(message);
		//request.setAttribute("sign", sign);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String send(){
		
		HttpServletRequest request=ServletActionContext.getRequest();
		String id = request.getParameter("id");
		request.setAttribute("id", id);
		return "send";
	}
	
	//此方法用到3处地方：
	//	1、userViewTop.jsp页面的联系他
	//	2、taskMoreDetail.jsp页面的应征任务
	//	3、用户登录后台的站内短信回复页面addMesage.jsp
	public void sendMessage() throws IOException{
		TAppMessage mess=new TAppMessage();
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		int toUserId = Integer.parseInt(request.getParameter("id"));
		TAppUser user = userService.findUserById(toUserId);
		if(user.getParentID() !=null&&!"".equals(user.getParentID())){
			toUserId = user.getParentID();
		}
		String content = URLDecoder.decode(request.getParameter("content"), "utf-8");
		String title = URLDecoder.decode(request.getParameter("title"), "utf-8");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int fromUserId = userSession.getId();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
		mess.setCreatTime(createDateTime);
		mess.setContent(content);
		mess.setFromUserId(fromUserId);
		mess.setToUserId(toUserId);
		mess.setTitle(title);
		mess.setStatus("0");	//发送短信后默认为未读
		mess.setType(1);
		mess.setSendType((short)1);//手动发送
		messageService.addMessage(mess);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");
		try {
			response.getWriter().print("1");
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//查询用户未读短信条数
	public void getUnreadMessageCount() throws IOException{
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		int unreadMessageCount= messageService.getUnreadMessageCount(userId);
		ServletActionContext.getResponse().getWriter().write(Integer.toString(unreadMessageCount));
	}
	
		
}
