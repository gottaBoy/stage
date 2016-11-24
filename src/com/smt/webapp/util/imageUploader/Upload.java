package com.smt.webapp.util.imageUploader;


import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.httpclient.util.DateUtil;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppImagesInfo;
import com.smt.webapp.dao.art.ArtInfoDao;
import com.smt.webapp.dao.art.ImgInfoDao;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

/**
 * 说明:上传文件
 * @author 胡远亮
 */
@SuppressWarnings("serial")
public class Upload extends HttpServlet {
	private Logger logger = Logger.getLogger("mylog");
	
	public Upload() {
		super();
	}

	public void destroy() {
		super.destroy();
	}
	@Autowired
	ImgInfoDao iDao;
	@Autowired
	ArtInfoDao aDao;
	//private ArtInfoService artInfoService  = new ArtInfoService();;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String xcId = request.getParameter("id");//相册ID
		
		if(StringUtils.isBlank(request.getParameter("id"))){
			//生成随机数
			//xcId = DateUtil.formatDate(new java.util.Date(), "yyMMddHHmmss") + StringUtils.leftPad(RandomStringUtils.randomNumeric(5), 5);
			xcId = DateUtil.formatDate(new java.util.Date(), "yyyyMMdd");
		}
		
		response.setContentType("text/plain");

		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(1024*1024);//1m
		List items = null;
		try {
			items = (List) upload.parseRequest(request);
		} catch (FileUploadException e1) {
			response.getWriter().write(getError("文件太大。"));
			logger.warn(e1.toString());
			return;
		}
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String path = rootPath.substring(0, rootPath.lastIndexOf(System.getProperty("file.separator")));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")));
		int userId = 0;
		if(userSession == null) {
			userId = Integer.parseInt(request.getParameter("userId"));
		} else {
			userId = userSession.getId();
		}
		
		path = path +"\\stageUpload\\img\\"+userId+"\\"+xcId+"\\";
		
		path = path.replace("\\", System.getProperty("file.separator"));
		
		String saveReportPath = path;//rootPath + "Upload/";
		MyUtils.mkDirectory(saveReportPath);
		boolean flag = false;
		Iterator iter = items.iterator();
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			if (item.getContentType() != null) {
				
				String newFileName = MyUtils.randomRename(item.getName(), saveReportPath);
				String url= "\\stageUpload\\img\\"+userId+"\\"+xcId+"\\"+newFileName;
				//保存到数据库中
				
				String saveUrl = url.replace("\\", "/");
				if(StringUtils.isNotBlank(xcId)){  //相册
					TAppImagesInfo imginfo = new TAppImagesInfo();
					imginfo.setParentId(Integer.parseInt(xcId));
					imginfo.setUrl(saveUrl);
					
					//第一张图默认做封面
					List<TAppArtInfo> artInfoList = (List<TAppArtInfo>)aDao.getArtInfoByID(Integer.parseInt(xcId));
					if(artInfoList!=null && artInfoList.size()>0){
						TAppArtInfo artInfo = artInfoList.get(0);
						
						if(artInfo.getImgCount()!=null && artInfo.getImgCount()==0){
							artInfo.setUrl(saveUrl);
						}
						aDao.update(artInfo);
					}
					//iDao.getSessionFactory().openSession().save(imginfo);
					iDao.saveImgInfo(imginfo);
					aDao.updateImgCountByid(Integer.parseInt(xcId));
				}
				String reportAbsFilePath = saveReportPath + newFileName; // 文件保存路径
				File file = new File(reportAbsFilePath);
				try {
					item.write(file); // 开始上传写入服务器
					flag = true;
				} catch (Exception e) {
					flag = false;
					e.printStackTrace();
				} finally {
					file = null;
					item = null;
					if (flag) {
						JSONObject obj = new JSONObject();
						obj.put("error", 0);
						obj.put("url",saveUrl);
						response.getWriter().write(obj.toJSONString());
						//out.println(obj.toJSONString());
					} else {
						response.getWriter().write(getError("上传文件失败。"));
					}
					flag = false;
				}

			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
		
	}
	private String getError(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 1);
		obj.put("message", message);
		return obj.toJSONString();
	}
}

