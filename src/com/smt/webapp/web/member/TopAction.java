package com.smt.webapp.web.member;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppTop;
import com.smt.entity.TAppTopImg;
import com.smt.entity.TAppUserInfo;
import com.smt.entity.UserParameter;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.top.TopService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.imageUploader.MyUtils;
@Controller
public class TopAction extends ActionSupport {
	private File turl1,turl2;
	private TAppUserInfo info;
	@Autowired
	private TopService service;
	private String turl1FileName,turl2FileName,turl1ContextType,turl2ContextType;
	private TAppTop vo;
	private TAppTopImg imgs1;
	private TAppTopImg imgs2;
	@Autowired
	private CostService costService;
	@Autowired
	private UserInfoService userInfoService;

	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		List<TAppTop> list = service.getListForTop(0, 20);
		request.setAttribute("list", list);
		return SUCCESS;
	}
	

	
	public String doEdit()throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		Integer id = Integer.parseInt(request.getParameter("id"));
		TAppTop top = service.getTopById(id);
		request.setAttribute("vo", top);
//		request.setAttribute("img1", top.getImgs());
//		request.setAttribute("vo", top);
		return "edit";
	}
	
	public String doIndex(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List<TAppTop> list = service.getListForTop(0, 7);
//		List costList = new ArrayList();
		List<TAppTopImg> imgs = service.getListForTopImg(0, 14);
//		for (TAppTop top : list) {
//			List list2 = costService.getTop3CastByUserID(top.getUserid().getId());
//			System.out.println(top.getUserid());
//			costList.add(list2);
//		}
		List costList = new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			TAppTop toplist = list.get(i);
			List list2 = costService.getTop3CastByUserID(toplist.getUserid().getUserId());
			costList.add(list2);
		}
		request.setAttribute("list", list);
		request.setAttribute("costList",costList);
		request.setAttribute("imgs", imgs);
		return "index";
	}
	
	public String doUserIndex() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		request.setCharacterEncoding("gbk");  
		response.setContentType("text/html;charset=gbk");
		String keywords = new String(request.getParameter("keyword").getBytes("iso-8859-1"),"gbk");
		//String queryString = "select userid,name,nickname from t_app_user_info where name like '%"+val+"%' or nickname like '%"+val+"%'";
		List list = userInfoService.findObjectBySql(keywords);
		//JSONArray array = JSONArray.fromObject(list);
		StringBuffer buf = new StringBuffer();
		buf.append("[ \n");
		
		for (int i = 0; i < list.size(); i++) {
			TAppUserInfo userParameter = (TAppUserInfo) list.get(i);
			buf.append("{");
			buf.append("name:'" + userParameter.getName() + "',");
			buf.append("nickname:'" + userParameter.getNickName() + "',");
			buf.append("provice:'" + userParameter.getProvice() + "',");
			buf.append("city:'" + userParameter.getCity() + "',");
			buf.append("profession:'" + userParameter.getProfession() + "',");
			buf.append("userId:'" + userParameter.getUserId() + "',");
			buf.append("popularityTotal:'" + userParameter.getPopularityTotal() + "'");
			buf.append("}\n");
			if (i != (list.size() - 1)) {
				buf.append(",");
			}
		}
		buf.append("]\n");
		response.getWriter().print(buf.toString());
		System.err.println(buf.toString());
		response.getWriter().close();
		return null;
	}
	public String doqyStarIndex() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		request.setCharacterEncoding("gbk");  
		response.setContentType("text/html;charset=gbk");
		//String keywords = new String(request.getParameter("keyword").getBytes("iso-8859-1"),"gbk");
		String keywords = request.getParameter("username");
		//String queryString = "select userid,name,nickname from t_app_user_info where name like '%"+val+"%' or nickname like '%"+val+"%'";
		List list = userInfoService.findObjectBySql1(keywords);
		//JSONArray array = JSONArray.fromObject(list);
		StringBuffer buf = new StringBuffer();
		buf.append("[ \n");
		
		for (int i = 0; i < list.size(); i++) {
			TAppUserInfo userParameter = (TAppUserInfo) list.get(i);
			buf.append("{");
			buf.append("name:'" + userParameter.getName() + "',");
			buf.append("nickname:'" + userParameter.getNickName() + "',");
			buf.append("provice:'" + userParameter.getProvice() + "',");
			buf.append("city:'" + userParameter.getCity() + "',");
			buf.append("profession:'" + userParameter.getProfession() + "',");
			buf.append("userId:'" + userParameter.getUserId() + "',");
			buf.append("popularityTotal:'" + userParameter.getPopularityTotal() + "'");
			buf.append("}\n");
			if (i != (list.size() - 1)) {
				buf.append(",");
			}
		}
		buf.append("]\n");
		response.getWriter().print(buf.toString());
		response.getWriter().close();
		return null;
	}
	
	public String showAddView(){
		
		return "showAddView";
	}
	
	public String doAddTop() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		// 把上传的文件放到指定的路径下  
		String path = ServletActionContext.getServletContext().getRealPath("tab\\images\\");
		// 写到指定的路径中  
		
		path = path.replace("\\", System.getProperty("file.separator"));
		
		File file = new File(path);
		String newFileName1=null,newFileName2=null;
		// 如果指定的路径没有就创建  
		if(!file.exists()){
			file.mkdirs();
		}
				try {
					newFileName1 = MyUtils.randomRename(turl1FileName,  path);
					FileUtils.copyFile(turl1, new File(file, newFileName1));
					newFileName2 = MyUtils.randomRename(turl2FileName,  path);
					FileUtils.copyFile(turl2, new File(file, newFileName2));
					
				} catch (IOException e) {
					e.printStackTrace();
			}
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		List<TAppTopImg> imgs = new ArrayList<TAppTopImg>();
		vo.setTdate(CommonUtil.getDate(new Date()));
		vo.setUserid(info);
		vo.setStatus("1");
		imgs1.setTpid(vo);
		imgs1.setTurl("tab/images/"+newFileName1);
		imgs2.setTpid(vo);
		imgs2.setTurl("tab/images/"+newFileName2);
		imgs.add(imgs1);
		imgs.add(imgs2);
		service.addTop(vo, imgs);
		return "save";
	}
	
	public String doUpdateTop() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		// 把上传的文件放到指定的路径下  
		String path = ServletActionContext.getServletContext().getRealPath("tab\\images\\");
		// 写到指定的路径中  
		File file = new File(path);
		String newFileName1=null,newFileName2=null;
		// 如果指定的路径没有就创建  
		if(!file.exists()){
			file.mkdirs();
		}
		if(turl1 != null){
			try {
				newFileName1 = MyUtils.randomRename(turl1FileName,  path);
				FileUtils.copyFile(turl1, new File(file, newFileName1));
			} catch (IOException e) {
				e.printStackTrace();
		}}
			if(turl2 != null){
				try {
					newFileName2 = MyUtils.randomRename(turl2FileName,  path);
					FileUtils.copyFile(turl2, new File(file, newFileName2));
					
				} catch (IOException e) {
					e.printStackTrace();
			}
		}
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		vo.setTdate(CommonUtil.getDate(new Date()));
		vo.setUserid(info);
		System.err.println("user.id:"+info.getUserId());
		vo.setStatus("1");
		imgs1.setTpid(vo);
		List<TAppTopImg> imgs = new ArrayList<TAppTopImg>();
		if(turl1FileName!=null){
				imgs1.setTurl("tab/images/"+newFileName1);
			}
		if (turl2FileName!=null){
				imgs2.setTurl("tab/images/"+newFileName2);
			}
		imgs2.setTpid(vo);
		imgs.add(imgs1);
		imgs.add(imgs2);
		service.updateTop(vo, imgs);
		return "save";
	}
	
	public TAppTop getVo() {
		return vo;
	}

	public void setVo(TAppTop vo) {
		this.vo = vo;
	}

	public TAppUserInfo getInfo() {
		return info;
	}

	public void setInfo(TAppUserInfo info) {
		this.info = info;
	}
	

	public TAppTopImg getImgs1() {
		return imgs1;
	}

	public void setImgs1(TAppTopImg imgs1) {
		this.imgs1 = imgs1;
	}

	public TAppTopImg getImgs2() {
		return imgs2;
	}

	public void setImgs2(TAppTopImg imgs2) {
		this.imgs2 = imgs2;
	}

	public String getTurl1FileName() {
		return turl1FileName;
	}
	
	public File getTurl1() {
		return turl1;
	}

	public void setTurl1(File turl1) {
		this.turl1 = turl1;
	}

	public File getTurl2() {
		return turl2;
	}

	public void setTurl2(File turl2) {
		this.turl2 = turl2;
	}

	public void setTurl1FileName(String turl1FileName) {
		this.turl1FileName = turl1FileName;
	}

	public String getTurl2FileName() {
		return turl2FileName;
	}

	public void setTurl2FileName(String turl2FileName) {
		this.turl2FileName = turl2FileName;
	}

	public String getTurl1ContextType() {
		return turl1ContextType;
	}

	public void setTurl1ContextType(String turl1ContextType) {
		this.turl1ContextType = turl1ContextType;
	}

	public String getTurl2ContextType() {
		return turl2ContextType;
	}

	public void setTurl2ContextType(String turl2ContextType) {
		this.turl2ContextType = turl2ContextType;
	}
	
}
