package com.smt.webapp.web.member;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.common.VideoUtil;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppImagesInfo;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
import com.smt.webapp.util.imageUploader.MyUtils;

public class ArtInfoAction extends ActionSupport{
	private Logger logger = Logger.getLogger("mylog");
	private File purl;
	private String purlFileName;
	@Autowired
	private ArtInfoService artInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	
	private TAppArtInfo artInfo=new TAppArtInfo();
	
	public TAppArtInfo getArtInfo() {
		return artInfo;
	}

	public void setArtInfo(TAppArtInfo artInfo) {
		this.artInfo = artInfo;
	}
	
	/**
	 * 宣传大图
	 * @return
	 */
	public String toTab5(){
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		List<TAppArtInfo> artInfoList= new ArrayList<TAppArtInfo>();
		artInfoList = artInfoService.getArtInfoList(id, 0,1,4);
		if(artInfoList != null && !artInfoList.isEmpty()){
			request.setAttribute("vo", artInfoList.get(0));
			
		}
		TAppUser user = userService.findUserByUserId(id);
		if (user.getParentID()!=null&&user.getParentID()!=0&&user.getParentID()!=user.getId()) {
			request.setAttribute("nowId", user.getParentID());
		}else {
			request.setAttribute("nowId", id);
		}
		request.setAttribute("id", id);
		if (userSession==null) {
			request.setAttribute("userId", 0);
		}else {
			request.setAttribute("userId", userSession.getId());
		}
		return "toTab5";
	}
	
	public String showList() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		
		response.setContentType("text/html;charset=utf-8");
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		int begin=request.getParameter("begin")==null?0:Integer.parseInt(request.getParameter("begin"));
		int rowCount=request.getParameter("rowCount")==null?6:Integer.parseInt(request.getParameter("rowCount"));
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, (pageNum-1)*6, rowCount, sign);
		int total = artInfoService.getArtInfoList1(id, (pageNum-1), rowCount, sign);
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		pageNum=pageNum>total?total:pageNum;
		List<TAppArtInfo> list = new ArrayList<TAppArtInfo>();
		List<TAppArtInfo> artInfoList1=artInfoService.getArtInfoList(id, 0, 6, 4);
		if(artInfoList1 != null && !artInfoList1.isEmpty()){
			request.setAttribute("vo", artInfoList1.get(0));
			
		}
		String res = null;
		switch (sign) {
		case 1:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				//
				tAppArtInfo.setUserId(pageNum);
				tAppArtInfo.setImgCount(total);
				list.add(tAppArtInfo);
			}
			if(!artInfoList.isEmpty()){
				JSONArray array = JSONArray.fromObject(artInfoList);
				response.getWriter().print(array.toString());
				response.getWriter().close();
				logger.debug(array.toString());
				return null;
			}
		case 2:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				//获取优酷的视频缩略图
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				tAppArtInfo.setIntro((String)map.get("img"));
				
				tAppArtInfo.setAttachment((String)map.get("swf"));
				if (((String)map.get("swf"))==null) {
					tAppArtInfo.setAttachment(tAppArtInfo.getUrl());
				}
				tAppArtInfo.setUserId(pageNum);
				tAppArtInfo.setImgCount(total);
				list.add(tAppArtInfo);
			}
			//把相应信息保存到页面
			res = JSONArray.fromObject(list).toString();
			response.getWriter().print(res);
			response.getWriter().close();
			logger.debug(res);
			return null;
		case 3:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				//获取优酷的视频缩略图
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				tAppArtInfo.setIntro((String)map.get("img"));
				tAppArtInfo.setAttachment((String)map.get("swf"));
				if (((String)map.get("swf"))==null) {
					tAppArtInfo.setAttachment(tAppArtInfo.getUrl());
				}
				tAppArtInfo.setUserId(pageNum);
				tAppArtInfo.setImgCount(total);
				list.add(tAppArtInfo);
			}
			//把相应信息保存到页面
			res = JSONArray.fromObject(list).toString();
			response.getWriter().print(res);
			response.getWriter().close();
			logger.debug(res);
			return null;
			default:
			response.getWriter().print("null");
		}
		return null;
	}
	public String toZhaoPin(){
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("userId", request.getParameter("userId"));
		return "zhaoPin";
	}
	public String toArtInfo() {
		logger.info(".................................... toArtInfo=");
		HttpServletRequest request=ServletActionContext.getRequest();
		
		int id = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(id<=0){
			id = HttpSessionHelper.getUserSession(request).getId();
		}
		 
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		int sign=request.getParameter("sign")==null?1:Integer.parseInt(request.getParameter("sign"));
		
		int total = artInfoService.getTotal(id, rowCount, sign);
		pageNum=pageNum>total?total:pageNum;

		List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, (pageNum-1)*rowCount, rowCount, sign);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("artInfoList", artInfoList);
		List<TAppArtInfo> movieOrVoiceList = new ArrayList<TAppArtInfo>();
		switch (sign) {
		case 4:
/*			if(id != null && !"".equals(id)){
				return "ORGSUCCESS";
			}*/
			if(artInfoList != null && !artInfoList.isEmpty()){
				request.setAttribute("vo", artInfoList.get(0));
			}
			return SUCCESS;
		case 1:
			return "photo";
		case 5://企业相关作品
			return "photo1";
		case 2:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				tAppArtInfo.setIntro((String)map.get("img"));
				//此页面没有用到附件字段，在此借用存放swf，一次解析后，点击第二个视频就无须解析
				if (null != map) {
					tAppArtInfo.setAttachment((String)map.get("swf"));
					movieOrVoiceList.add(tAppArtInfo);
				}
				else {
					//error log todo, changed by yzf 2012-9-19
				}
			}
			
			//把相应信息保存到页面
			request.setAttribute("movieOrVoiceList", movieOrVoiceList);		
/*			if(id != null && !"".equals(id)){
				return "ORGmovie";
			}*/
			return "movie";
		case 3:
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				Map map = VideoUtil.getYoukuContent(tAppArtInfo.getUrl());
				//此页面没有用到附件字段，在此借用存放swf，一次解析后，点击第二个音频就无须解析
				tAppArtInfo.setAttachment((String)map.get("swf"));
				movieOrVoiceList.add(tAppArtInfo);
			}
			//把相应信息保存到页面
			request.setAttribute("movieOrVoiceList", movieOrVoiceList);		
			/*if(id != null && !"".equals(id)){
				return "ORGvoice";
			}*/
			return "voice";
		default:
			/*if(id != null && !"".equals(id)){
				return "ORGSUCCESS";
			}*/
			return SUCCESS;
		}
		
	}
	
	public String toAddArtInfo(){
		logger.info(".................................... toAddArtInfo=");
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId=HttpSessionHelper.getUserSession(request).getId();
		
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			userId = Integer.parseInt(request.getParameter("userId"));
		}	
		
		String sign=request.getParameter("sign")==null?"":request.getParameter("sign");
		String flag=request.getParameter("flag")==null?"1":request.getParameter("flag");
		artInfo.setUserId(userId);
		
		request.setAttribute("sign", sign);
		request.setAttribute("flag", flag);
		artInfo.setType(sign);
		return "toAddArtInfo";
	}
	
	public String addIndex(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String result = request.getParameter("aid");
		int id = result==null || result.equals("")?0:Integer.parseInt(request.getParameter("aid"));

		int userId=Integer.parseInt(request.getParameter("userId")==null?"0":request.getParameter("userId"));
		String storagePath = "tab\\images\\"+userId+"\\1\\";
		String realPath = ServletActionContext.getServletContext()
				.getRealPath(storagePath);// 实际路径
		String newFileName = MyUtils.randomRename(purlFileName, realPath);
		File saveFile = new File(new File(realPath), newFileName); // 在该实际路径下实例化一个文件
		// 判断父目录是否存在
		if (!saveFile.getParentFile().exists()) {
			saveFile.getParentFile().mkdirs();
		}
		try {
			FileUtils.copyFile(purl, saveFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		TAppArtInfo info = new TAppArtInfo();
		info.setType("4");
		info.setUserId(userId);
		info.setUrl(storagePath+newFileName);
		if(id != 0){
			info.setId(id);
		}
		artInfoService.saveOrUpdateArtInfo(info);
		return "saveOrUpdateArtInfo";
	}
	public String addIndex1(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String result = request.getParameter("aid");
		int id = result==null || result.equals("")?0:Integer.parseInt(request.getParameter("aid"));

		int userId=Integer.parseInt(request.getParameter("userId")==null?"0":request.getParameter("userId"));
		String storagePath = "tab\\images\\"+userId+"\\1\\";
		storagePath = storagePath.replace("\\", System.getProperty("file.separator"));
		String realPath = ServletActionContext.getServletContext()
				.getRealPath(storagePath);// 实际路径
		String newFileName = MyUtils.randomRename(purlFileName, realPath);
		newFileName = newFileName.replace("\\", System.getProperty("file.separator"));
		File saveFile = new File(new File(realPath), newFileName); // 在该实际路径下实例化一个文件
		// 判断父目录是否存在
		if (!saveFile.getParentFile().exists()) {
			saveFile.getParentFile().mkdirs();
		}
		try {
			FileUtils.copyFile(purl, saveFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		TAppArtInfo info = new TAppArtInfo();
		info.setType("4");
		info.setUserId(userId);
		info.setUrl(storagePath+newFileName);
		if(id != 0){
			info.setId(id);
		}
		artInfoService.saveOrUpdateArtInfo(info);
		return "saveOrUpdateArtInfo1";
	}
	
	public String toUpdateArtInfo(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		String userId = request.getParameter("userId");
		request.setAttribute("userId", userId);
		artInfo=artInfoService.getArtInfoByID(id);
		return "toUpdateArtInfo";
		
	}

	
	public String toUpdateImgInfo(){
		HttpServletRequest request=ServletActionContext.getRequest();
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		String userId = request.getParameter("userId");
		request.setAttribute("userId", userId);
		
		
		TAppImagesInfo appImagesInfo = artInfoService.getAppImagesInfo(id);
		request.setAttribute("appImagesInfo", appImagesInfo);
		artInfo=artInfoService.getArtInfoByID(id);
		return "toUpdateImgInfo";
		
	}
	

	public void saveOrUpdateImgInfo()throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		//response.setContentType("text/plain");
		try {
			response.setContentType("text/plain");

			int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
			
			TAppImagesInfo appImagesInfo = artInfoService.getAppImagesInfo(id);
			appImagesInfo.setTitle(request.getParameter("title"));
			appImagesInfo.setRemark(request.getParameter("remark"));
			
			artInfoService.updateImginfo(appImagesInfo);
			
			    
			//response.reset();
			response.setContentType("text/html; charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().print("1");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public void saveOrUpdateArtInfo()throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		//response.setContentType("text/plain");
		try {
			String userIdString = request.getParameter("id");
			int userId= 0;
			if(StringUtils.isNotEmpty(userIdString)){
				userId = Integer.parseInt(userIdString);
				request.setAttribute("userId", userIdString);
			}else{
				userId=HttpSessionHelper.getUserSession(request).getId();
			}
			
			if(artInfo.getId()==null||"".equals(artInfo.getId())){
				artInfo.setUserId(userId);
				artInfo.setImgCount(0);

				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
				
				artInfo.setCreatTime(createDateTime);
				artInfo.setDing(0);
				artInfo.setShare(0);
				artInfo.setEvaluate(0);
			}else{
				TAppArtInfo artInfo2 = artInfoService.getArtInfoByID(artInfo.getId());
				if(artInfo2 == null){
					artInfo.setUserId(userId);
					artInfo.setImgCount(0);

					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					String createDateTime=df.format(new Date());// new Date()为获取当前系统时间
					
					artInfo.setCreatTime(createDateTime);
					artInfo.setDing(0);
					artInfo.setShare(0);
					artInfo.setEvaluate(0);
				}else{				
					artInfo.setUserId(artInfo2.getUserId());
					artInfo.setImgCount(artInfo2.getImgCount());

					artInfo.setCreatTime(artInfo2.getCreatTime());
					artInfo.setUrl(artInfo2.getUrl()); //------------
					artInfo.setAttachment(artInfo2.getAttachment());
					//只改了title
					artInfo.setImg(artInfo2.getImg());
					artInfo.setIntro(artInfo2.getIntro());
					
					if(artInfo2.getDing()==null){
						artInfo.setDing(0);
					}else{
						artInfo.setDing(artInfo2.getDing());
					}
					if(artInfo2.getShare()==null){
						artInfo.setShare(0);
					}else{
						artInfo.setShare(artInfo2.getShare());
					}
					if(artInfo2.getEvaluate()==null){
						artInfo.setEvaluate(0);
					}else{
						artInfo.setEvaluate(artInfo2.getEvaluate());
					}
				}
				

				
			}
			
			/*8-27*/
			if(artInfo.getId()==null ){ //|| artInfo.getId()<1000
				String artId = userService.getMaxUserIdFromSequenceTable("art");
				artInfo.setId(Integer.parseInt(artId));	
			}
			
			logger.info("..................................."+artInfo.getId());

			artInfoService.saveOrUpdateArtInfo(artInfo);
			request.setAttribute("sign", artInfo.getType());
			request.setAttribute("artId",artInfo.getId());
			TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
			if(artInfo.getType().equals("1")) {
				userInfo.setXcIsFinish(1);
			} else if(artInfo.getType().equals("2")) {
				userInfo.setSpIsFinish(1);
			} else if(artInfo.getType().equals("3")) {
				userInfo.setYpIsFinish(1);
			}
			
			logger.info("...................................saveOrUpdateArtInfo.userInfo="+userInfo);
			
			userInfoService.updateUserInfo(userInfo);
			
			//response.reset();
			response.setContentType("text/html; charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().print("1");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public void delArtInfo(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		artInfo=artInfoService.getArtInfoByID(id);
		request.setAttribute("sign", artInfo.getType());
		artInfoService.delArtInfo(artInfo);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void delImg(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		artInfoService.delImgInfo(id);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String doShowImg(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = Integer.parseInt(request.getParameter("id"));
		List<TAppImagesInfo> lists = artInfoService.getAppImagesInfos(id,0,1000);
		
		artInfo=artInfoService.getArtInfoByID(id);

		request.setAttribute("artInfo", artInfo);
		request.setAttribute("lists", lists);
		request.setAttribute("xcId", id);
		request.setAttribute("userId", request.getParameter("userId"));
		String userId = request.getParameter("uid");
		if(userId != null){
			request.setAttribute("userId", userId);
			return "ORGIMAGE";
		}else {
			request.setAttribute("user_Id", request.getParameter("userId")==null?"0":request.getParameter("userId"));
			return "image";
		}
		
	}
	
	public String openImageUp(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		String sign = request.getParameter("sign");
		request.setAttribute("sign", sign);
		return "upImg";
	}
	/**
	 * 刚注册完的，默认第一张图为相册图
	 */
	public void setUpImgForDefault(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		System.out.println(".................................... artInfoService="+artInfoService);
		logger.info(".................................... artInfoService="+artInfoService);
		
		int artId = Integer.parseInt(request.getParameter("artId"));
		List<TAppImagesInfo> lists = artInfoService.getAppImagesInfos(artId,0,5);
		System.out.println("....................................img size="+(lists==null?0:lists.size()));
		logger.info(".................................... img size="+(lists==null?0:lists.size()));
		if(lists!=null && lists.size()>0){
			TAppImagesInfo tAppImagesInfo = lists.get(0);
			int imgId = tAppImagesInfo.getId();
			artInfoService.setUpImg(imgId);	
		}
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void setUpImg(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
		
		artInfoService.setUpImg(id);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public File getPurl() {
		return purl;
	}

	public void setPurl(File purl) {
		this.purl = purl;
	}

	public String getPurlFileName() {
		return purlFileName;
	}

	public void setPurlFileName(String purlFileName) {
		this.purlFileName = purlFileName;
	}

	
}
