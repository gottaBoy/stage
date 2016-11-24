package com.smt.webapp.web.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.tuckey.web.filters.urlrewrite.utils.URLEncoder;
import sun.misc.BASE64Decoder;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.common.VideoUtil;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
@Controller
public class UserInfoAction1 extends ActionSupport{
	
	    // username属性用来封装用户名
		private String username;
		
		// myFile属性用来封装上传的文件
		private File myFile;
		
		// myFileContentType属性用来封装上传文件的类型
		private String myFileContentType;

		// myFileFileName属性用来封装上传文件的文件名
		private String myFileFileName;

		
		//获得username值
		public String getUsername() {
			return username;
		}

		//设置username值
		public void setUsername(String username) {
			this.username = username;
		}

		//获得myFile值
		public File getMyFile() {
			return myFile;
		}

		//设置myFile值
		public void setMyFile(File myFile) {
			this.myFile = myFile;
		}

		//获得myFileContentType值
		public String getMyFileContentType() {
			return myFileContentType;
		}

		//设置myFileContentType值
		public void setMyFileContentType(String myFileContentType) {
			this.myFileContentType = myFileContentType;
		}

		//获得myFileFileName值
		public String getMyFileFileName() {
			return myFileFileName;
		}

		//设置myFileFileName值
		public void setMyFileFileName(String myFileFileName) {
			this.myFileFileName = myFileFileName;
		}

	private String sign ; 
	
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	private TAppUserInfo userInfo;

	public TAppUserInfo getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(TAppUserInfo userInfo) {
		this.userInfo = userInfo;
	}
	private TAppUser user;
	private List costList;
	
	
	public TAppUser getUser() {
		return user;
	}
	public void setUser(TAppUser user) {
		this.user = user;
	}
	public List getCostList() {
		return costList;
	}
	public void setCostList(List costList) {
		this.costList = costList;
	}
	@Autowired
	private UserInfoService uService;
	@Autowired
	private UserService userService;
	@Autowired
	private CostService costService;
	@Autowired
	private GrowthService growthService;
	@Autowired
	private ArtInfoService artInfoService;
	
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
//		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
//		if(usrInfos != null && usrInfos.size() > 0){
//			userInfo = usrInfos.get(0);
//		}
		request.setAttribute("userId", id);
		request.setAttribute("userInfo", userInfo);
		
		TAppUser user = userService.findUser(userSession.getUserName());
		request.setAttribute("user", user);
		String signString=request.getParameter("sign");
		int sign = Integer.parseInt(signString==null?"1":signString);
		switch (sign) {
		case 1:
			
			return SUCCESS;
		case 2:
			
			return "intro";
		case 3:
//			List  costList = costService.getCostInfo(id, 0);
//			request.setAttribute("costList", costList);
			return "vocation";
		case 4:
			return "realName";
		case 5:
			return "protrait";
		case 6:
//			request.setAttribute("userId", id);
			return "indexImg";
		case 7:
//			int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
//			int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
//			int total = growthService.getTotal(userSession.getId(), rowCount);
//			pageNum=pageNum>total?total:pageNum;
//			List<TAppGrowth> growthList =growthService.getGrowthList(userSession.getId(), (pageNum-1)*rowCount, rowCount);	
//
//			ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
//			ServletActionContext.getRequest().setAttribute("total", total);
//			ServletActionContext.getRequest().setAttribute("growthList", growthList);
			return "growth";
		case 8:
			return "xiangce";
		default:
			return SUCCESS;
		}
//		return SUCCESS;
	}
	//快速注册页面
	public String registerSoon() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
//		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
//		if(usrInfos != null && usrInfos.size() > 0){
//			userInfo = usrInfos.get(0);
//		}
		request.setAttribute("userId", id);
		request.setAttribute("userInfo", userInfo);
		
		TAppUser user = userService.findUser(userSession.getUserName());
		request.setAttribute("user", user);
		String signString=request.getParameter("sign");
		int sign = Integer.parseInt(signString==null?"1":signString);
			return "registerSoon";
	}
	public void getUserInfoById() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
		if(usrInfos != null && usrInfos.size() > 0){
			userInfo = usrInfos.get(0);
		}
		TAppUser user = userService.findUser(userSession.getUserName());
		
//		List list = new ArrayList();
//		list.add(userInfo);
//		list.add(user);
		
		Map map = new HashMap();
		map.put("userInfo", userInfo);
		map.put("isOrg", user.getIsOrg());
		map.put("username", user.getUsername());
		map.put("email", user.getEmail());
		
		Gson gson = new Gson();
		String result = gson.toJson(map);// list为要转换为JSON对象的数据
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//获取用户职业技能
	public void getUserInfoCost() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		
		List costList = costService.getCostListByUserId(id);
		
		List newList = new ArrayList();
		for (int i = 0; i < costList.size(); i++) {
			TAppCostInfo cost = (TAppCostInfo) costList.get(i);
			Map map = new HashMap();
			map.put("eprice", cost.getEprice());
			map.put("bprice", cost.getBprice());
			map.put("orderNo", cost.getOrderNo());
			map.put("keywords", cost.getKeywords()==null?"":cost.getKeywords());
			map.put("id", cost.getId());
			map.put("unit", cost.getUnit());
			map.put("isConsult", cost.getIsConsult()==null?"":cost.getIsConsult());
			
			TAppTalentCategory t = costService.getTAppTalentCategory(cost.getProfession());
			map.put("typeName", t.getTypeName());
			newList.add(map);
		}
		
		Gson gson = new Gson();
		String result = gson.toJson(newList);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//获取用户职业技能
	public void getGrowthList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		
		List<TAppGrowth> growthList =growthService.getGrowthList(id, 0, 999999);	
		
		Gson gson = new Gson();
		String result = gson.toJson(growthList);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//获取用户才艺（视频、音频、相册）
	public void getUserArtList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		int type = Integer.parseInt(request.getParameter("type"));
		
		List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, 0, 999999, type);
		
		List<TAppArtInfo> movieOrVoiceList = new ArrayList<TAppArtInfo>();
		Gson gson = new Gson();
		String result = "";
		
		if(type == 2 || type == 3) {
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				//此页面没有用到附件字段，在此借用存放swf，一次解析后，点击第二个音频就无须解析
				tAppArtInfo.setAttachment((String)map.get("swf"));
				movieOrVoiceList.add(tAppArtInfo);
			}
			
			result = gson.toJson(movieOrVoiceList);// list为要转换为JSON对象的数据
		} else {
			result = gson.toJson(artInfoList);// list为要转换为JSON对象的数据
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//删除头像
	public void delHeadImg() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf("\\");
		path = path.substring(0, path.lastIndexOf("\\"))+"\\stageUpload\\headImage\\";

		File file = new File(path+userSession.getId()+".png");
		file.delete();
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String upLoadPic() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf("\\");
		path = path.substring(0, path.lastIndexOf("\\"))+"\\stageUpload\\headImage\\";

		//图1
		try {
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			File file1 = new File(path+userSession.getId()+".png");
			
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
	public String upLoadPic1() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf("\\");
		int userId = Integer.parseInt(request.getParameter("userId"));
		path = path.substring(0, path.lastIndexOf("\\"))+"\\stageUpload\\headImage\\";

		//图1
		try {
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			File file1 = new File(path+userId+".png");
			
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
	
	public String upLoadIndexHeadImage() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf("\\");
		path = path.substring(0, path.lastIndexOf("\\"))+"\\stageUpload\\indexHeadImage\\";

		//图1
		try {
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			File file1 = new File(path+userSession.getId()+".png");
			
			FileOutputStream fout1 = null;
			fout1 = new FileOutputStream(file1);
			fout1.write(new BASE64Decoder().decodeBuffer(pic1));
			fout1.flush();
			fout1.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
		
		TAppUserInfo userInfo = uService.getUserInfoByUserId(userSession.getId());
		userInfo.setSytjIsFinish(1);
		uService.updateUserInfo(userInfo);
		
		//ServletActionContext.getResponse().sendRedirect("userinfo.htm");
		ServletActionContext.getResponse().getWriter().write("success=上传成功");
		//System.out.println("{\"status\":1}");
		return null;
	}
	
	public String upLoadOrgPic() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String userId = request.getParameter("userId");
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf("\\");
		path = path.substring(0, path.lastIndexOf("\\"))+"\\stageUpload\\headImage\\";


		//图1
		try {
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			File file1 = new File(path+userId+".png");
			
			FileOutputStream fout1 = null;
			fout1 = new FileOutputStream(file1);
			fout1.write(new BASE64Decoder().decodeBuffer(pic1));
			fout1.flush();
			fout1.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
		}

		//ServletActionContext.getResponse().sendRedirect("userinfo.htm");
		ServletActionContext.getResponse().getWriter().write("success=上传成功");
		//System.out.println("{\"status\":1}");
		return null;
	}
	/**
	 * 
	 * @Description: 修改或保存用户信息
	 * @author hyl   
	 * @date 2013-2-22 上午11:00:25
	 * @return
	 * @throws IOException 
	 */
	public String saveOrUpdate() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int id = userSession.getId();System.out.println(userInfo.getNickName()+"----");
		userInfo.setUserId(id);
		if(Integer.parseInt(sign) == 1) {
			TAppUserInfo u = uService.findUserInfoByUserId(id);
			
			u.setNickName(userInfo.getNickName());
			u.setName(userInfo.getName());
			u.setSex(userInfo.getSex());
			u.setProvice(userInfo.getProvice());
			u.setCity(userInfo.getCity());
			u.setBirthday(userInfo.getBirthday());
			u.setBooldType(userInfo.getBooldType());
			u.setHeight(userInfo.getHeight());
			u.setWeight(userInfo.getWeight());
			u.setHeartSize(userInfo.getHeartSize());
			u.setWaistSize(userInfo.getWaistSize());
			u.setBottocksSize(userInfo.getBottocksSize());
			u.setMobile(userInfo.getMobile());
			u.setMobileRadio(userInfo.getMobileRadio());
			u.setQq(userInfo.getQq());
			u.setQqRadio(userInfo.getQqRadio());
			u.setTelPhone(userInfo.getTelPhone());
			u.setSchool(userInfo.getSchool());
			u.setMajor(userInfo.getMajor());
			u.setEducation(userInfo.getEducation());
			u.setIntroduction(userInfo.getIntroduction());
			//u.setPlace(userInfo.getPlace());
			
			u.setJcxxIsFinish(1);
			
			uService.saveUserInfo(u);
		} else {
			uService.saveOrUpdateUserInfo(userInfo, Integer.parseInt(sign));
		}
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(1==HttpSessionHelper.getIsOrg(request)){
			response.sendRedirect(request.getContextPath()+"/member/orginfo.htm");
			return null;
		}
		return null;
//		ServletActionContext.getRequest().setAttribute("sign", sign);
//		return "qurey";
	}
	
	public String toUserShare() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		TAppUserInfo u = uService.findUserInfoByUserId(id);
		
		request.setAttribute("user", u);
		request.setAttribute("wzd", request.getParameter("wzd"));
		
		return "toUserShare";
	}
	
	public void setIsShare() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		TAppUserInfo u = uService.findUserInfoByUserId(id);
		int isShare = Integer.parseInt(request.getParameter("isShare"));
		u.setIsShare(isShare);
		uService.updateUserInfo(u);
	}

	/**
	 * 
	* @Title: getUserForAttestation
	* @author huyuanliang
	* @date 2013-4-22 下午3:13:29
	* @Description: TODO 通过关键字查询用户信息
	* @param @return
	* @param @throws Exception    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String getUserForAttestation() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
//		request.setCharacterEncoding("UTF-8");
		String keywords ="";
		int flag = request.getParameter("flag")!=null&&!"".equals(request.getParameter("flag"))?Integer.parseInt(request.getParameter("flag")):0;
		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}
		//System.err.print("===========11====="+keywords);
		
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}

		
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getAttestationTotal(keywords, rowCount,0);
		pageNum=pageNum>total?total:pageNum;		
		
		List userInfoList =uService.getAttestationList(keywords, (pageNum-1)*rowCount, rowCount,0);	

		request.setAttribute("userInfoList", userInfoList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("keywords", keywords);
		
//		String pageKeywords=URLEncoder.encodePathParam(keywords, "UTF-8");
//		ServletActionContext.getRequest().setAttribute("pageKeywords", pageKeywords);
		// TODO Auto-generated method stub
		return "userattestation";
	}
	
	public String getCompanyForAttestation() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
//		request.setCharacterEncoding("UTF-8");
		String keywords ="";
		int flag = request.getParameter("flag")!=null&&!"".equals(request.getParameter("flag"))?Integer.parseInt(request.getParameter("flag")):0;
		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}
		//System.err.print("===========11====="+keywords);
		
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}

		
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getAttestationTotal(keywords, rowCount,1);
		pageNum=pageNum>total?total:pageNum;		
		
		List userInfoList =uService.getAttestationList(keywords, (pageNum-1)*rowCount, rowCount,1);	

		request.setAttribute("userInfoList", userInfoList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("keywords", keywords);
		
		String pageKeywords=URLEncoder.encodePathParam(keywords, "UTF-8");
		ServletActionContext.getRequest().setAttribute("pageKeywords", pageKeywords);
		// TODO Auto-generated method stub
		return "companyattestation";
	}
	
	
	public String getUserForManager() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
//		request.setCharacterEncoding("UTF-8");
		//String  keywords =request.getParameter("keywords")==null?"": new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");// request.getParameter("keywords");
		String keywords ="";
		int flag = request.getParameter("flag")!=null&&!"".equals(request.getParameter("flag"))?Integer.parseInt(request.getParameter("flag")):0;
		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}
		//System.err.print("===========11====="+keywords);
		
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}

		
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getTotal(keywords, rowCount,0);
		pageNum=pageNum>total?total:pageNum;		
		
		List userInfoList =uService.getUserInfoList(keywords, (pageNum-1)*rowCount, rowCount,0);	
		

		request.setAttribute("userInfoList", userInfoList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("game", total);
		request.setAttribute("keywords", keywords);
		
//		String pageKeywords=URLEncoder.encodePathParam(keywords, "UTF-8");
//		ServletActionContext.getRequest().setAttribute("pageKeywords", keywords);
		// TODO Auto-generated method stub
		return "usermanager";
	}
	
	public String getCompanyForManager() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
//		request.setCharacterEncoding("UTF-8");
		String keywords ="";
		int flag = request.getParameter("flag")!=null&&!"".equals(request.getParameter("flag"))?Integer.parseInt(request.getParameter("flag")):0;
		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}
		//System.err.print("===========11====="+keywords);
		
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}

		
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getTotal(keywords, rowCount,1);
		pageNum=pageNum>total?total:pageNum;		
		
		List userInfoList =uService.getUserInfoList(keywords, (pageNum-1)*rowCount, rowCount,1);	

		request.setAttribute("userInfoList", userInfoList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("game", total);
		request.setAttribute("keywords", keywords);
		
//		String pageKeywords=URLEncoder.encodePathParam(keywords, "UTF-8");
//		ServletActionContext.getRequest().setAttribute("pageKeywords", pageKeywords);
		// TODO Auto-generated method stub
		return "companymanager";
	}
	
	public String getIndexCompany(){
		List list =uService.getUserInfoList(null, 0, 10,2);	
		ServletActionContext.getRequest().setAttribute("list", list);
		return "indexCompany";
	}
	
	
	public String updateIsRecommend(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String  idls =request.getParameter("idls");	
		
		String[] ids = idls.split("\\|");           
        for (int i = 0; i < ids.length; i++)
        {
        	TAppUserInfo userInfo = uService.findUserInfoByUserId(Integer.parseInt(ids[i]));
        	userInfo.setIsRecommend("1");
        	userInfo.setRecommendTime(CommonUtil.getTime(new Date()));
        	uService.updateUserInfo(userInfo);        	
        }

		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String updateRecommend(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id =Integer.parseInt(request.getParameter("id"));	
		String flag=request.getParameter("flag");
		TAppUserInfo userInfo = uService.findUserInfoByUserId(id);
    	userInfo.setIsRecommend(flag);
    	userInfo.setRecommendTime(CommonUtil.getTime(new Date()));			
    	uService.updateUserInfo(userInfo);     

		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
	public String updateComRecommend(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id =Integer.parseInt(request.getParameter("id"));	
		String flag=request.getParameter("flag");
		TAppUserInfo userInfo = uService.findUserInfoByUserId(id);
    	userInfo.setComRecommend(flag);
    	userInfo.setComRecommendTime(CommonUtil.getTime(new Date()));			
    	uService.updateUserInfo(userInfo);     

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
	 * @Description:绑定支付宝
	 * @author lllai   
	 * @date 2013-4-22 上午9:38:45
	 * @return
	 */
	public String updateAlipay(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String alipay = request.getParameter("alipay");
		String alipayName = request.getParameter("alipayName");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();		
		TAppUserInfo userInfo = uService.findUserInfoByUserId(id);
		userInfo.setAlipay(alipay);
		userInfo.setAlipayName(alipayName);
		uService.updateUserInfo(userInfo);  
		
		TAppUser user = userService.getUserById(userInfo.getUserId());
		if(user.getIsOrg() == 1) {
			String sql = "update TAppUserInfo set alipay='"+alipay+"', alipayName='"+alipayName+"' where userId in(select id from TAppUser where parentId="+id+")";
			uService.updateUserAlipay(sql);
		}

		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String doUpdateAlipay(){
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		userInfo=uService.findUserInfoByUserId(id);
		request.setAttribute("alipay", userInfo.getAlipay());
		request.setAttribute("alipayName", userInfo.getAlipayName());
		return "toUpdateAlipay";
	}
	
	public String toUserInfoView(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String  type = request.getParameter("type");
		int userId = request.getParameter("userId")==null?0:Integer.parseInt(request.getParameter("userId"));
		user=userService.findUserByUserId(userId);
		userInfo=uService.findUserInfoByUserId(userId);
		costList=costService.getCostInfo(userId, 0);
		request.setAttribute("user", user);
		request.setAttribute("costList", costList);
		if("2".equals(type)){
			return "toUserInfoOrg";
		}
		return "toUserInfoView";
	}
	
	public String toCompanyInfoView(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = request.getParameter("userId")==null?0:Integer.parseInt(request.getParameter("userId"));
		user=userService.findUserByUserId(userId);
		userInfo=uService.findUserInfoByUserId(userId);
		costList=costService.getCostInfo(userId, 0);
		request.setAttribute("user", user);
		request.setAttribute("costList", costList);
		return "toCompanyInfoView";
	}

	public String saveRealName() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String type = request.getParameter("type");
		int id = userSession.getId();
		//基于myFile创建一个文件输入流
		InputStream is = new FileInputStream(myFile);
				
		// 设置上传文件目录
		String uploadPath = ServletActionContext.getServletContext().getRealPath("/");
		String path = uploadPath.substring(0, uploadPath.lastIndexOf("\\"));
		path = path.substring(0, path.lastIndexOf("\\"));
		path = path +"\\stageUpload\\idCard";
		// 设置目标文件
		
		File file = new File(path);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String saveName = id+this.getMyFileFileName().substring(this.getMyFileFileName().lastIndexOf("."));
		File toFile = new File(path, saveName);
		
		File file1 = new File(path+userSession.getId()+".png");
		// 创建一个输出流
		OutputStream os = new FileOutputStream(toFile);
		//设置缓存
		byte[] buffer = new byte[1024];

		int length = 0;

		//读取myFile文件输出到toFile文件中
		while ((length = is.read(buffer)) > 0) {
				os.write(buffer, 0, length);
		}

		is.close();
		os.close();
		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
		TAppUserInfo uInfo = null;
		if(usrInfos != null && usrInfos.size() > 0){
			uInfo = usrInfos.get(0);
		}
		uInfo.setIdCard(userInfo.getIdCard());
		uInfo.setIdCardCopy(saveName);
		uService.saveRealName(uInfo);
		usrInfos = uService.getUserInfos(id);
		if(usrInfos != null && usrInfos.size() > 0){
			userInfo = usrInfos.get(0);
		}
		TAppUser user = userService.findUser(userSession.getUserName());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		if(type!=null&&!"".equals(type)){
			return "orgProtrait";
		}
		return null;
	}

}
