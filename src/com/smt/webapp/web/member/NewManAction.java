package com.smt.webapp.web.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.tuckey.web.filters.urlrewrite.utils.URLEncoder;
import sun.misc.BASE64Decoder;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.company.CompanyInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
@Controller
public class NewManAction extends ActionSupport{
	private List list ;
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}

	@Autowired
	private UserInfoService uService;
	@Autowired
	private UserService userService;
	@Autowired
	private CompanyInfoService companyInfoService;
	@Override
	/**
	 * 
	 */
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		String  keywords = request.getParameter("keywords");
		//System.err.print("===========11====="+keywords);
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getUserTotalByorgId(id, keywords);
		pageNum=pageNum>total?total:pageNum;
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		//System.out.println(pageNum+"----------");
		list = uService.getUserInfoByorgId(id, (pageNum-1)*rowCount, rowCount, keywords);
		List<TAppCompanyInfo> list1 = companyInfoService.getXrjrByBusinessId(id);
		request.setAttribute("keywords", keywords);
		request.setAttribute("list1", list1);
		request.setAttribute("list1Sum", list1.size());
		request.setAttribute("pageNum", pageNum);
		//System.out.println(total);
		request.setAttribute("game", total);
		return SUCCESS;
	}
	public void saveNewMan() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/plain");

		try {
		String userId  = request.getParameter("userId");
		String flag  = request.getParameter("flag");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		TAppCompanyInfo companyInfo = new TAppCompanyInfo();
		companyInfo.setBusinessId(id);
		companyInfo.setYrUserId(Integer.parseInt(userId));
		companyInfo.setType(2);
		companyInfoService.saveInfo2(companyInfo,2,flag);
		response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	public String upLoadPic() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		String userId  = request.getParameter("userId");
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\newManInfoImage\\";

		path = path.replace("\\", System.getProperty("file.separator"));

		
		//图1
		try {
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			File file1 = new File(path+id+"_"+userId+".png");
			FileOutputStream fout1 = null;
			fout1 = new FileOutputStream(file1);
			fout1.write(new BASE64Decoder().decodeBuffer(pic1));
			fout1.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
		}

		//ServletActionContext.getResponse().sendRedirect("userinfo.htm");
		ServletActionContext.getResponse().getWriter().write("success=上传成功");
		//System.out.println("{\"status\":1}");
		return null;
	}


	
}
