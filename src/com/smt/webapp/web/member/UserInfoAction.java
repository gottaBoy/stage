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
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.tuckey.web.filters.urlrewrite.utils.URLEncoder;

import sun.misc.BASE64Decoder;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.common.VideoUtil;
import com.smt.entity.CostValueSession;
import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppImagesInfo;
import com.smt.entity.TAppInformation;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.service.art.ArtInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.information.InformationService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.service.user.UserService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
import com.sun.org.apache.xpath.internal.compiler.Keywords;
@Controller
public class UserInfoAction extends ActionSupport{
	private static final Log log = LogFactory.getLog(UserInfoAction.class);
	    // username属性用来封装用户名
		private String username;
		
		// myFile属性用来封装上传的文件
		private File myFile;
		
		// myFileContentType属性用来封装上传文件的类型
		private String myFileContentType;

		// myFileFileName属性用来封装上传文件的文件名
		private String myFileFileName;
		// myFile属性用来封装上传的文件
		private File myFile2;
		
		// myFileContentType属性用来封装上传文件的类型
		private String myFile2ContentType;
		
		// myFileFileName属性用来封装上传文件的文件名
		private String myFile2FileName;
		private File myFile3;
		
		// myFileContentType属性用来封装上传文件的类型
		private String myFile3ContentType;
		
		// myFileFileName属性用来封装上传文件的文件名
		private String myFile3FileName;

		
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
 

		public File getMyFile2() {
			return myFile2;
		}

		public void setMyFile2(File myFile2) {
			this.myFile2 = myFile2;
		}

		public String getMyFile2ContentType() {
			return myFile2ContentType;
		}

		public void setMyFile2ContentType(String myFile2ContentType) {
			this.myFile2ContentType = myFile2ContentType;
		}

		public String getMyFile2FileName() {
			return myFile2FileName;
		}

		public void setMyFile2FileName(String myFile2FileName) {
			this.myFile2FileName = myFile2FileName;
		}




	private String sign ; 
	private Integer profession_1 ; 
	private Integer profession_2 ; 
	private Integer profession_3 ; 
	private Integer profession_4 ; 
	private Integer profession_5 ; 
	private Integer bprice1;
	private Integer bprice2;
	private Integer bprice3;
	private Integer bprice4;
	private Integer bprice5;
	private Integer eprice1;
	private Integer eprice2;
	private Integer eprice3;
	private Integer eprice4;
	private Integer eprice5;
	private String unit1;
	private String unit2;
	private String unit3;
	private String unit4;
	private String unit5;
	
	private String keywords1;
	private String keywords2;
	private String keywords3;
	private String keywords4;
	private String keywords5;
	
	public Integer getEprice1() {
		return eprice1;
	}

	public Integer getEprice2() {
		return eprice2;
	}

	public Integer getEprice3() {
		return eprice3;
	}

	public Integer getEprice4() {
		return eprice4;
	}

	public Integer getEprice5() {
		return eprice5;
	}

	public String getUnit1() {
		return unit1;
	}

	public void setUnit1(String unit1) {
		this.unit1 = unit1;
	}

	public String getUnit2() {
		return unit2;
	}

	public void setUnit2(String unit2) {
		this.unit2 = unit2;
	}

	public String getUnit3() {
		return unit3;
	}

	public void setUnit3(String unit3) {
		this.unit3 = unit3;
	}

	public String getUnit4() {
		return unit4;
	}

	public void setUnit4(String unit4) {
		this.unit4 = unit4;
	}

	public String getUnit5() {
		return unit5;
	}

	public void setUnit5(String unit5) {
		this.unit5 = unit5;
	}

	public UserInfoService getUService() {
		return uService;
	}

	public void setUService(UserInfoService service) {
		uService = service;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public CostService getCostService() {
		return costService;
	}

	public void setCostService(CostService costService) {
		this.costService = costService;
	}

	public GrowthService getGrowthService() {
		return growthService;
	}

	public void setGrowthService(GrowthService growthService) {
		this.growthService = growthService;
	}

	public ArtInfoService getArtInfoService() {
		return artInfoService;
	}

	public void setArtInfoService(ArtInfoService artInfoService) {
		this.artInfoService = artInfoService;
	}

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
	
	private TAppInformation information;
	
	private List costList;
	
	
	public TAppInformation getInformation() {
		return information;
	}

	public void setInformation(TAppInformation information) {
		this.information = information;
	}

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
	private InformationService informationService;
	@Autowired
	private ArtInfoService artInfoService;
	
	public String register02() throws Exception {
		// TODO Auto-generated method stub
		return "register02";
	}	
	
	public UserInfoService getuService() {
		return uService;
	}

	public void setuService(UserInfoService uService) {
		this.uService = uService;
	}

	public InformationService getInformationService() {
		return informationService;
	}

	public void setInformationService(InformationService informationService) {
		this.informationService = informationService;
	}

	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		int id = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(id<=0){
			id = HttpSessionHelper.getUserSession(request).getId();
		}
		
		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
		if(usrInfos != null && usrInfos.size() > 0){
			userInfo = usrInfos.get(0);
		}
		request.setAttribute("userId", id);
		request.setAttribute("userInfo", userInfo);
		
		TAppUser user = userService.findUserById(id);
		request.setAttribute("user", user);
		String signString=request.getParameter("sign");
		int sign = Integer.parseInt(signString==null?"1":signString);

		//观众用户升级
		if(sign==1000){
			return "up_uper";
		}
		
		//企业用户和专业用户还没存数据库，如果user为空也是应该去普通用户
		if(sign != 100 && sign != 4){
			if(user!=null && (user.getIsOrg() != null && user.getIsOrg() == 100)){
				return "nor_userInfo";
			}
		}
		
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
		case 9:
			return "shipin";
		case 100:
			return "anypic";					
		default:
			return SUCCESS;
		}
//		return SUCCESS;
	}
	
	public void getPercent(){
		int result=0;
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String userId = request.getParameter("userId");
		int id = 0;
		if(StringUtils.isBlank(userId)){
			id = userSession.getId();
		}else{
			id = Integer.parseInt(userId);
		}
		
		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
		TAppUser user = userService.getUserById(id);
		
		if(usrInfos != null && usrInfos.size() > 0){
			userInfo = usrInfos.get(0);
			if(user.getIsOrg()==1){ //企业  公司名称(nickName) 所在地   服务范围、手机、邮箱  企业认证
				float i=0f;
				if(StringUtils.isNotBlank(userInfo.getNickName())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getProvice())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getSeviceScope())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getCompanyTags())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getMobile())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(user.getEmail())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getIdCard()) || StringUtils.isNotBlank(userInfo.getOrgCard())){
					i = i + 1f;
				}
				result = Math.round(i*100/7f);
			}else if (user.getIsOrg()==100){ //观众   昵称 真实姓名 所在地 详细地址 手机、邮箱
				float i=0f;
				if(StringUtils.isNotBlank(userInfo.getNickName())){
					i = i + 1f;
				}
				/*if(StringUtils.isNotBlank(userInfo.getName())){
					i = i + 1f;
				}*/
				if(StringUtils.isNotBlank(userInfo.getProvice())){
					i = i + 1f;
				}
				/*
				if(StringUtils.isNotBlank(userInfo.getPlace())){
					i = i + 1f;
				}
				*/
				if(StringUtils.isNotBlank(userInfo.getMobile())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(user.getEmail())){
					i = i + 1f;
				}
				result = Math.round(i*100/4f);
			}else if(user.getParentID()!= null){ //艺人      昵称 真实姓名 所在地   手机、邮箱  parentId is not null [详细地址]
				float i=0f;
				if(StringUtils.isNotBlank(userInfo.getNickName())){
					i = i + 1f;
				}
				/*if(StringUtils.isNotBlank(userInfo.getName())){
					i = i + 1f;
				}*/
				if(StringUtils.isNotBlank(userInfo.getProvice())){
					i = i + 1f;
				}
				/*
				if(StringUtils.isNotBlank(userInfo.getPlace())){
					i = i + 1f;
				}
				*/
				if(StringUtils.isNotBlank(userInfo.getMobile())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(user.getEmail())){
					i = i + 1f;
				}
				
				
				//-------------------------身高：（CM） 体重：(KG) 胸围：（CM） 腰围：（CM） 臀围：（CM） 毕业院校  个人介绍     性别  成长经历
				if(StringUtils.isNotBlank(userInfo.getHeight())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getWeight())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getHeartSize())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getWaistSize())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getBottocksSize())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getSchool())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getIntroduction())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getSex())){
					i = i + 1f;
				}
				List<TAppGrowth> growthList = growthService.getGrowthList(id, 0, 2);
				if(!CollectionUtils.isEmpty(growthList)){
					i = i + 1f;
				}
				result = Math.round(i*100/13f);
			}else{ //专业    昵称 真实姓名 所在地 详细地址  手机、邮箱  职业，演出照 
				float i=0f;
				if(StringUtils.isNotBlank(userInfo.getNickName())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getName())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getProvice())){
					i = i + 1f;
				}
				/*
				if(StringUtils.isNotBlank(userInfo.getPlace())){
					i = i + 1f;
				}
				*/
				if(StringUtils.isNotBlank(userInfo.getMobile())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(user.getEmail())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getProfessionStr())){
					i = i + 1f;
				}
				
				List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, 0, 2, 1); //1：照片 5:相关作品
				
				if(artInfoList!=null && artInfoList.size()>0){
					i = i + 1f;
				}
				
				
				//-------------------------身高：（CM） 体重：(KG) 胸围：（CM） 腰围：（CM） 臀围：（CM） 毕业院校  个人介绍     性别  成长经历
				if(StringUtils.isNotBlank(userInfo.getHeight())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getWeight())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getHeartSize())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getWaistSize())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getBottocksSize())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getSchool())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getIntroduction())){
					i = i + 1f;
				}
				if(StringUtils.isNotBlank(userInfo.getSex())){
					i = i + 1f;
				}
				List<TAppGrowth> growthList = growthService.getGrowthList(id, 0, 2);
				if(!CollectionUtils.isEmpty(growthList)){
					i = i + 1f;
				}
				result = Math.round(i*100/16f);
			}
		}
		
		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
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
	
	
	public void onlyDeleteCost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String costId = request.getParameter("costId");
		if(costId!=null && Integer.parseInt(costId)>0){
			List<TAppCostInfo> costInfoByID = costService.getCostInfoByID(Integer.parseInt(costId));
			if(costInfoByID!=null && costInfoByID.size()>0){
				TAppCostInfo tAppCostInfo = costInfoByID.get(0);
				List costListByUserId = costService.getCostListByUserId(tAppCostInfo.getUserId());
				if(costListByUserId!=null && (costListByUserId.size() > 1)){
					costService.delCostInfo(costInfoByID.get(0));
					
					List list = costService.getCostInfo(tAppCostInfo.getUserId(), 0);
					String professionStr="";
					if(list!=null&&list.size()>0){
						for(int i=0;i<list.size();i++){
							Object[] item=(Object[]) list.get(i);							
							professionStr=professionStr+","+((TAppTalentCategory) item[1]).getTypeName();							
						}
						
					}			
					userInfo.setProfessionStr(professionStr);
					uService.updateUserInfo(userInfo); 
				}
			}
		}
	}
	
	
	//我的第一舞台维护页面，删除
	public void deleteCost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String costId = request.getParameter("costId");
		int deleted = 0;
		if(costId!=null && Integer.parseInt(costId)>0){
			List<TAppCostInfo> costInfoByID = costService.getCostInfoByID(Integer.parseInt(costId));
			if(costInfoByID!=null && costInfoByID.size()>0){
				TAppCostInfo tAppCostInfo = costInfoByID.get(0);
				List costListByUserId = costService.getCostListByUserId(tAppCostInfo.getUserId());
				if(costListByUserId!=null && (costListByUserId.size() > 1)){
					costService.delCostInfo(costInfoByID.get(0));
					
					List list = costService.getCostInfo(tAppCostInfo.getUserId(), 0);
					String professionStr="";
					if(list!=null&&list.size()>0){
						for(int i=0;i<list.size();i++){
							Object[] item=(Object[]) list.get(i);							
							professionStr=professionStr+","+((TAppTalentCategory) item[1]).getTypeName();							
						}
						
					}	
					TAppUserInfo findUserInfoById = uService.findUserInfoById(tAppCostInfo.getUserId());
					
					findUserInfoById.setProfessionStr(professionStr);
					uService.updateUserInfo(findUserInfoById); 
		    		
					deleted = 1;
				}
			}
		}
		
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/json; charset=utf-8");
			response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
			response.getWriter().print(deleted);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	//我的第一舞台维护页面，保存，新增或修改
	public void onlySaveCost(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String costId  = request.getParameter("costId");
		String norSign = request.getParameter("norSign");

		//有值表示修改，先删除再加
		if(StringUtils.isNotEmpty(costId)){
			onlyDeleteCost();
		}
		
		int index = Integer.parseInt(request.getParameter("index"));
		int price = Integer.parseInt(request.getParameter("price"));
		int profession = Integer.parseInt(request.getParameter("profession"));
		String unit = request.getParameter("unit");
		String keywords = request.getParameter("keywords");
		if(request.getParameter("index") != null){
			TAppCostInfo costInfo = new TAppCostInfo();
			costInfo.setBprice(Integer.valueOf(request.getParameter("price")));
			costInfo.setEprice(Integer.valueOf(request.getParameter("price")));
			costInfo.setProfession(profession);
			costInfo.setUnit(unit);
			costInfo.setKeywords(keywords);
			
			request.getSession().setAttribute("costInfo_"+index,costInfo);
		}
		
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		
		if(HttpSessionHelper.getIsOrg(request)==1){
			if(StringUtils.isNotBlank(request.getParameter("addUser"))){
				id = HttpSessionHelper.getNewUserIdFromSession();
			}		
		}
		
		
		if(StringUtils.equals("1000", norSign)){
			TAppUser updateUser = userService.findUserById(id);
			//观众的才需要更新成艺人
			if(updateUser!=null && updateUser.getIsOrg()==100){
				updateUser.setIsOrg(0); //升级为艺人
				userService.updateUser(updateUser);
			}
		}
		
		
		saveCost(index,id,profession,price,price,unit,keywords);
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//获取用户职业技能
	public void getUserInfoCost() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId(); //default
		
		if(StringUtils.isNotBlank(request.getParameter("addUser"))){
			id = HttpSessionHelper.getNewUserIdFromSession();
		}	
		
		List<TAppCostInfo> costList = costService.getCostListByUserId(id);
		
		List<Map<String,Object>> newList = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < costList.size(); i++) {
			String index = Integer.toString(i+1);
			TAppCostInfo cost = (TAppCostInfo) costList.get(i);
			request.getSession(true).setAttribute("costInfo_"+index, cost);
			
			Map<String,Object> map = new HashMap<String,Object>();
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
			
			try {
				CostValueSession costValueSession = new CostValueSession();
				costValueSession.setCostId(cost.getProfession());
				
				//查找父级...
				Stack<Integer> stack = new Stack<Integer>();
				stack.push(cost.getProfession());
				int levels = 1;
				Integer parentCostId1=costService.getParentCostId(Integer.toString(cost.getProfession()));	
				if(parentCostId1 >0){
					levels = 2;
					stack.push(parentCostId1);	
					Integer parentCostId2=costService.getParentCostId(Integer.toString(parentCostId1));
					if(parentCostId2 >0){
						levels = 3;
						stack.push(parentCostId2);
						Integer parentCostId3=costService.getParentCostId(Integer.toString(parentCostId2));
						if(parentCostId3 >0){
							levels = 4;
							stack.push(parentCostId3);
						}
					}
				}
				
				if(levels==1){
					//只一级目录
					costValueSession.setCost1(stack.pop());
				}else if(levels==2){
					//二目录
					costValueSession.setCost1(stack.pop());
					costValueSession.setCost2(stack.pop());
				}else if(levels==3){
					//三目录
					costValueSession.setCost1(stack.pop());
					costValueSession.setCost2(stack.pop());
					costValueSession.setCost3(stack.pop());
				}else if(levels==4){
					//四目录
					costValueSession.setCost1(stack.pop());
					costValueSession.setCost2(stack.pop());
					costValueSession.setCost3(stack.pop());
					costValueSession.setCost4(stack.pop());
				} 
				request.getSession().setAttribute("costValueSession_"+index, costValueSession);
			} catch (NumberFormatException e1) {
			}
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
	public void hasUserInfoCost() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId(); //default
		
		if(StringUtils.isNotBlank(request.getParameter("addUser"))){
			id = HttpSessionHelper.getNewUserIdFromSession();
		}	
		
		List<TAppCostInfo> costList = costService.getCostListByUserId(id);
		 
		String hasData = "0";  
		if(costList!=null && costList.size()>0){
			hasData = "1";
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(hasData);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//获取用户职业技能
	public void getGrowthList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		List<TAppGrowth> growthList = new ArrayList<TAppGrowth>();	
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(StringUtils.isBlank(request.getParameter("addUser"))){
				id = userSession.getId();
			}else{
				id = HttpSessionHelper.getNewUserIdFromSession();
			}
		}
		
		
		growthList = growthService.getGrowthList(id, 0, 999999);
		
		
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
	//获取企业服务项目
	public void getOrgCostList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = NumberUtils.stringToInt(request.getParameter("id"), 0);
		List<TAppCostInfo> costList = new ArrayList<TAppCostInfo>();	
		if(id > 0){
			id = Integer.parseInt(request.getParameter("id"));
		}else{
			if(StringUtils.isBlank(request.getParameter("addUser"))){
				id = userSession.getId();
			}else{
				id = HttpSessionHelper.getNewUserIdFromSession();
			}
		}
		
		
		costList = costService.getCostListByUserId(id);
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		for (TAppCostInfo tAppCostInfo : costList) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("bigImage", tAppCostInfo.getBigImage());
			map.put("bPrice", tAppCostInfo.getBprice());
			map.put("unit", tAppCostInfo.getUnit());
			map.put("detail", tAppCostInfo.getDetail());
			map.put("keywords", tAppCostInfo.getKeywords());
			map.put("id", tAppCostInfo.getId());
			
			resultList.add(map);
		}
		
		
		Gson gson = new Gson();
		String result = gson.toJson(resultList);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//获取招聘信息
	public void getZhaopinList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		//默认是登录的用户
		int id = 0;
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			id = Integer.parseInt(request.getParameter("userId"));
		}else{
			id = userSession.getId();
		}
		
		List<TAppInformation> infoList =informationService.getInformationList(id);	
		
		Gson gson = new Gson();
		String result = gson.toJson(infoList);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//招聘信息
	public void saveInfo() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = 0;
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			id = Integer.parseInt(request.getParameter("userId"));
		}else{
			id = userSession.getId();
		}
		information.setUserId(id);
		information.setCreatTime(CommonUtil.getTime(new Date()));
		information.setStatus("0");
		informationService.suInfo(information);
		request.setAttribute("id", id);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//修改招聘信息
	public void updateInfo() { 
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		String id = request.getParameter("info_id");
		List<TAppInformation> infoByIDList = informationService.getInfoByID(Integer.parseInt(id));
		if(infoByIDList != null && infoByIDList.size() > 0){
			TAppInformation infoByID = (TAppInformation)infoByIDList.get(0);
			infoByID.setTitle(request.getParameter("title_"+id));

			infoByID.setDaiyu(request.getParameter("daiyu_"+id));
			infoByID.setXueli(request.getParameter("xueli_"+id));
			infoByID.setWorkYears(request.getParameter("workYears_"+id));
			infoByID.setWorkAddress(request.getParameter("workAddress_"+id));
			infoByID.setZige(request.getParameter("zige_"+id));
			
			infoByID.setContent(request.getParameter("content_"+id));
			
			informationService.suInfo(infoByID);
		}
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//招聘信息
	public void delInfo() {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
       
		informationService.delInfo(information);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	//获取用户才艺（视频、音频、相册）
	public void getUserArtList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			id = Integer.parseInt(request.getParameter("userId"));
		}	
		
		int type = Integer.parseInt(request.getParameter("type"));
		
		int begin = 0; 
		if(request.getParameter("begin")!=null){
			begin = Integer.parseInt(request.getParameter("begin"));
		}
		
		int length = 16;
		if(request.getParameter("length")!=null){
			length = Integer.parseInt(request.getParameter("length"));
		}
		
		int total = artInfoService.getArtInfoList1(id, begin, length, type);
		List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, begin, length, type);
		
		List<TAppArtInfo> movieOrVoiceList = new ArrayList<TAppArtInfo>();
		Gson gson = new Gson();
		String result = "";
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("total", total);
		resultMap.put("currentPage", request.getParameter("currentPage")==null?0:request.getParameter("currentPage"));
		
		if(type == 2 || type == 3) {
			for (TAppArtInfo tAppArtInfo : artInfoList) {
				String url = tAppArtInfo.getUrl();
				if(url !=null){
					Map map = VideoUtil.getYoukuContent(url);
					//此页面没有用到附件字段，在此借用存放swf，一次解析后，点击第二个音频就无须解析
					if(map.get("swf") != null){
						tAppArtInfo.setAttachment((String)map.get("swf"));
						tAppArtInfo.setImg((String)map.get("img"));
					}
				}
				movieOrVoiceList.add(tAppArtInfo);
			}
			resultMap.put("list",movieOrVoiceList );
		} else {
			resultMap.put("list",artInfoList );
		}

		result = gson.toJson(resultMap);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//获取指定相册的图片
	public void getUserImgListByArtId() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		int type = Integer.parseInt(request.getParameter("type"));
		int artId = Integer.parseInt(request.getParameter("artId"));
		
		//List<TAppArtInfo> artInfoList=artInfoService.getArtInfoList(id, 0, 999999, type,artId);
		int total = artInfoService.countAppImagesInfos(artId);
		
		int begin = 0; 
		if(request.getParameter("begin")!=null){
			begin = Integer.parseInt(request.getParameter("begin"));
		}
		
		int length = 16;
		if(request.getParameter("length")!=null){
			length = Integer.parseInt(request.getParameter("length"));
		}
		
		List<TAppImagesInfo> lists = artInfoService.getAppImagesInfos(artId,begin,length);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("total", total);
		resultMap.put("currentPage", request.getParameter("currentPage")==null?0:request.getParameter("currentPage"));
		resultMap.put("lists", lists);
		
		Gson gson = new Gson();
		String result = gson.toJson(resultMap);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/json; charset=utf-8");

		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}	
	public void getUserArtList1() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		if(StringUtils.isNotBlank(request.getParameter("userId"))){
			id = Integer.parseInt(request.getParameter("userId"));
		}	
		
		
		int type = Integer.parseInt(request.getParameter("type"));
		
		List<TAppArtInfo> artInfoList=artInfoService.getMyArtInfoList(id, type);
		
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
		//request.setAttribute("userInfo", userInfo);
		request.setAttribute("norSign", request.getParameter("norSign"));
		
		//TAppUser user = userService.findUser(userSession.getUserName());
		//request.setAttribute("user", user);
		
		//String signString=request.getParameter("sign");
		//int sign = Integer.parseInt(signString==null?"1":signString);
		return "registerSoon";
	}
	
	
	//观众会员注册
	public String norUserInfo() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		HttpSession session = request.getSession();
		session.removeAttribute("hasNoMy");
		
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
//		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
//		if(usrInfos != null && usrInfos.size() > 0){
//			userInfo = usrInfos.get(0);
//		}
		request.setAttribute("userId", id);
		
		TAppUserInfo userInfonew = uService.findUserInfoById(id);
		
		request.setAttribute("userInfo", userInfonew);
		
		TAppUser user = userService.findUserById(id);
		request.setAttribute("user", user);
		
		//String signString=request.getParameter("sign");
		//int sign = Integer.parseInt(signString==null?"1":signString);
		return "nor_userInfo";
	}
	
	
	
	
	//删除头像
	public void delHeadImg() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\headImage\\";

		path = path.replace("\\", System.getProperty("file.separator"));
		
		File file = new File(path+userSession.getId()+".png");
		file.delete();
		
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String upLoadAnyPic() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		String pic1=request.getParameter("png1");
		
		String dateRandomStr=request.getParameter("dateRandomStr");
		String rPath = "";
		String fileName = dateRandomStr;
		log.warn("........dateRandomStr="+dateRandomStr);
		
		dateRandomStr = StringUtils.replace(dateRandomStr, "/", "\\");
		if(dateRandomStr.contains("\\")){
			String[] split = StringUtils.split(dateRandomStr,"\\");
			rPath = split[0];
			fileName = split[1];
		}
		
		
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\"+rPath+"\\";
		
		path = path.replace("\\", System.getProperty("file.separator"));
		
		String indexImgPath = "";
		//图1
		try {
			//大图，首页推荐图
			String indexPath = StringUtils.replace(path, "headImage", "indexHeadImage"); 
			File file = new File(indexPath);
			if(!file.exists()) {
				file.mkdirs();
			}
			indexImgPath = indexPath+ fileName +".png";
			File file1 = new File(indexImgPath);
			
			FileOutputStream fout1 = null;
			fout1 = new FileOutputStream(file1);
			fout1.write(new BASE64Decoder().decodeBuffer(pic1));
			fout1.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
		//缩略图
		//大图，首页推荐图
		
		log.warn("........indexImgPath="+indexImgPath);
		String newFilePath = path + fileName +".png";
		log.warn("........newFilePath="+newFilePath);
		
		Thumbnails.of(indexImgPath)   
        .size(110, 110)  
        .toFile(newFilePath); 
		 

		//ServletActionContext.getResponse().sendRedirect("userinfo.htm");
		ServletActionContext.getResponse().getWriter().write("success=上传成功");
		//System.out.println("{\"status\":1}");
		return null;
	}
	public String upLoadPic() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		//request.setCharacterEncoding("UTF-8");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String pic1=request.getParameter("png1");
		String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\headImage\\";

		path = path.replace("\\", System.getProperty("file.separator"));
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
		path.lastIndexOf(System.getProperty("file.separator"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\headImage\\";

		path = path.replace("\\", System.getProperty("file.separator"));
		
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
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\indexHeadImage\\";
		path = path.replace("\\", System.getProperty("file.separator"));
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
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\headImage\\";

		path = path.replace("\\", System.getProperty("file.separator"));
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
	 * 单独保存用户信息
	 */
	public String updateOnlyUserInfo() throws IOException{
		
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		//默认是session的登录用户
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		
		HttpSession session = request.getSession();
		session.removeAttribute("hasNoMy");
		
		int id = userSession.getId();
		log.warn(".........userSession.getId() id="+id);
		
		if(StringUtils.equals(request.getParameter("addUser"),"true")){
			id = HttpSessionHelper.getNewUserIdFromSession();
			log.warn(".........HttpSessionHelper.getNewUserIdFromSession() id="+id);
			
			if(!StringUtils.equals(request.getParameter("isUpdate"),"true")){ //公司下的艺人
				//保存到 t_app_user
				
				user.setUsername(userInfo.getNickName()+"(公司艺人)");
				user.setUserPsd("123456"); //default
				
				TAppUser parentUser = userService.findUserById(userSession.getId());
				//观众的才需要更新成艺人
				if(parentUser!=null && parentUser.getIsOrg()==1){
					//默认用公司邮箱，电话
					user.setEmail(parentUser.getEmail());
				}
				
				user.setId(id);
				user.setIsOrg(0);
				user.setParentID(userSession.getId()); //!!!!!!!!!
				
				log.warn(".........saveUserNew start="+user);
				
				userService.saveUserNew(user);	
				
				log.warn(".........saveUserNew end="+user);
			}
		}else{
			String norSign = request.getParameter("sign");
			if(StringUtils.equals("1000", norSign)){
				TAppUser updateUser = userService.findUserById(id);
				//观众的才需要更新成艺人
				if(updateUser!=null && updateUser.getIsOrg()==100){
					updateUser.setIsOrg(0); //升级为艺人
					
					log.warn(".........updateUser start="+updateUser);
					
					userService.updateUser(updateUser);
					
					log.warn(".........updateUser end="+updateUser);
				}
			}
			
		}
 
		
		
		userInfo.setUserId(id);
			//------------------------
		TAppUserInfo u = uService.findUserInfoByUserId(id);
		if(u==null){
			u = new TAppUserInfo();		
			u.setId(HttpSessionHelper.getNewUserIdFromSession());
			
			log.warn(".........u==null, getNewUserIdFromSession="+u.getId());
		}else{
			log.warn(".........u!=null, id="+u.getId());
		}
	
		
    	//u.setId(id);        //*************** 不一定相同
    	u.setUserId(id);    //***************
    	
    	//u.setPlace(userInfo.getPlace());
    	String birthdayYear = request.getParameter("birthdayYear");
    	String birthdayMonth = request.getParameter("birthdayMonth");
    	if(StringUtils.isNotEmpty(birthdayYear) && StringUtils.isEmpty(birthdayMonth)){
    		u.setBirthday(birthdayYear+"-01-01");
    	}	
    	if(StringUtils.isNotEmpty(birthdayYear) && StringUtils.isNotEmpty(birthdayMonth)){
    		u.setBirthday(birthdayYear+"-"+birthdayMonth+"-01");
    	}
    	
    	
		u.setAge(0);
		u.setNickName(userInfo.getNickName());
		
		//u.setName(userInfo.getName());
		u.setSex(userInfo.getSex());
		u.setProvice(userInfo.getProvice());
		u.setCity(userInfo.getCity());
		
		if(StringUtils.isNotBlank(userInfo.getBooldType())){
			u.setBooldType(userInfo.getBooldType());
		}
		if(StringUtils.isNotBlank(userInfo.getHeight())){
			u.setHeight(userInfo.getHeight());
		}
		if(StringUtils.isNotBlank(userInfo.getWeight())){			
			u.setWeight(userInfo.getWeight());
		}
		if(StringUtils.isNotBlank(userInfo.getHeartSize())){
			u.setHeartSize(userInfo.getHeartSize());
		}
		if(StringUtils.isNotBlank(userInfo.getWaistSize())){
			u.setWaistSize(userInfo.getWaistSize());
		}
		if(StringUtils.isNotBlank(userInfo.getBottocksSize())){
			u.setBottocksSize(userInfo.getBottocksSize());
		}
		
		if(StringUtils.isNotBlank(userInfo.getSchool())){
			u.setSchool(userInfo.getSchool());	
		}
		if(StringUtils.isNotBlank(userInfo.getIntroduction())){
			u.setIntroduction(userInfo.getIntroduction());
		}
		
		if(StringUtils.isEmpty(userInfo.getMobile())){
			TAppUserInfo parentUserInfo = uService.findUserInfoById(userSession.getId());
			log.warn(".........parentUserInfo="+parentUserInfo);
			
			if(parentUserInfo!=null && StringUtils.isNotBlank(parentUserInfo.getMobile())){
				u.setMobile(parentUserInfo.getMobile());
			}
		}else{
			u.setMobile(userInfo.getMobile());
		}
		log.warn(".........start saveUserInfo="+u);
		
		uService.saveUserInfo(u);
		
		log.warn(".........end saveUserInfo="+u);
		
		log.warn(".........print id="+id);
		try {
			response.getWriter().print(id);
		} catch (IOException e) {
			e.printStackTrace();
		}
			
		return null;
	}

	/**
	 * 单独保存公司信息
	 */
	public String updateOnlyOrgInfo() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		HttpSession session = request.getSession();
		session.removeAttribute("hasNoMy");

		UserSession userSession = HttpSessionHelper.getUserSession(request);
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int id = userSession.getId();
		userInfo.setUserId(id);
			//------------------------
		
		TAppUserInfo u = uService.findUserInfoByUserId(id);
		if(u==null){
			u = new TAppUserInfo();		
			u.setId(HttpSessionHelper.getNewUserIdFromSession());
		}
    	//u.setId(id);        //*************** //不一定会相同 id userid
    	u.setUserId(id);    //***************
    	
    	//所在地
    	u.setProvice(userInfo.getProvice());
		u.setCity(userInfo.getCity());
    	u.setPlace(userInfo.getPlace());               //详细地址
    	
    	//成立时间
    	//String birthday = request.getParameter("birthday");
    	u.setBirthday(userInfo.getBirthday());
    	
    	
		u.setAge(0);
		//公司名称
		u.setNickName(userInfo.getNickName());
	
		//公司介绍
		u.setIntroduction(userInfo.getIntroduction());
		
		//公司标签
		u.setCompanyTags(userInfo.getCompanyTags());
		//服务范围
		u.setSeviceScope(userInfo.getSeviceScope());
		
		uService.saveUserInfo(u);

		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
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

		String norSign = request.getParameter("norSign");
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int id = userSession.getId();
		
		userInfo.setUserId(id);
		if(Integer.parseInt(sign) == 1) { //个人
			
			//创建相册，添加图片
			
			
			
			HttpSession session = ServletActionContext.getRequest().getSession();
			TAppUser tappUser = (TAppUser)session.getAttribute("step1_tappUser");
			String userMobile = (String)session.getAttribute("step1_mobile");

			tappUser.setId(id); //***************
			
			if(StringUtils.isNotBlank(request.getParameter("isOrg"))){
				tappUser.setIsOrg(NumberUtils.stringToInt(request.getParameter("isOrg"), 100));	
			}else{
				session.removeAttribute("step1_tappUser");
				session.removeAttribute("step1_mobile");
				session.removeAttribute("artId");
			}
 
			
			boolean isExist = false;
			TAppUser newUser = userService.findUserById(id);
			if(newUser != null){
				isExist = true;
			}
			
			if(isExist == false){
				userService.saveUserNew(tappUser,userMobile);
			} else{
				if(StringUtils.equals("1000", norSign)){
					if(newUser.getIsOrg()==100){
						newUser.setIsOrg(0);
						userService.updateUser(newUser);
					}
				}
			}
			
			//------------------------
	    	TAppUserInfo u = new TAppUserInfo();
	    	u.setId(id);        //***************
	    	u.setUserId(id);    //***************
	    	u.setSellerGrade("1");
	    	u.setAge(0);
	    	//u.setNickName(tappUser.getUsername());
	    	u.setIsRecommend("0");
	    	u.setSignNumber(0);
	    	u.setSignAmount("保密");
	    	u.setPopularityTotal(0);
	    	u.setGrade("1");
	    	u.setFeedbackRate(100);
	    	u.setMobile(userMobile);
	    	u.setCreatTime(CommonUtil.getTime(new Date()));
			
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
			//u.setMobile(userInfo.getMobile());
			u.setMobileRadio(userInfo.getMobileRadio());
			u.setQq(userInfo.getQq());
			u.setQqRadio(userInfo.getQqRadio());
			u.setTelPhone(userInfo.getTelPhone());
			u.setSchool(userInfo.getSchool());
			u.setMajor(userInfo.getMajor());
			u.setEducation(userInfo.getEducation());
			u.setIntroduction(userInfo.getIntroduction());
			
			u.setJcxxIsFinish(1);
			if(request.getParameter("headImage") != null){
				u.setSytjIsFinish(1);  //headImage, 图片上传成功即可,无需另外设置
			}
			
			uService.saveUserInfo(u);
		
		
			
			int flag = 1;
			for(int i = 1;i<6;i++){
				if (i==1) {
					if (profession_1!=null) {
						saveCost(flag,id,profession_1,bprice1,eprice1,unit1,keywords1);
						flag++;
					}
				}
				if (i==2) {
					if (profession_2!=null) {
						saveCost(flag,id,profession_2,bprice2,eprice2,unit2,keywords2);
						flag++;
					}
				}
				if (i==3) {
					if (profession_3!=null) {
						saveCost(flag,id,profession_3,bprice3,eprice3,unit3,keywords3);
						flag++;
					}
				}
				if (i==4) {
					if (profession_4!=null) {
						saveCost(flag,id,profession_4,bprice4,eprice4,unit4,keywords4);
						flag++;
					}
				}
				if (i==5) {
					if (profession_5!=null) {
						saveCost(flag,id,profession_5,bprice5,eprice5,unit5,keywords5);
						flag++;
					}
				}
			}
		}else {//公司等 4认证  5头像
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
	private void saveCost(int flag,int userId,int profession,int bprice,int eprice,String unit,String keywords) {
		// TODO Auto-generated method stub
		TAppCostInfo costInfo = new TAppCostInfo();
		costInfo.setUserId(userId);
		costInfo.setCreatTime(CommonUtil.getTime(new Date()));
		costInfo.setBprice(bprice);
		costInfo.setEprice(eprice);
		costInfo.setUnit(unit);
		costInfo.setOrderNo(flag);
		costInfo.setProfession(profession);
		costInfo.setKeywords(keywords);
		TAppUserInfo userInfo =  uService.findUserInfoByUserId(userId);
		if(userInfo==null){
			return;
		}
		if(flag==1){
			String parentCostId=costService.getParentCostId(profession+"",1);				
			userInfo.setProfession(parentCostId);
		}
		String professionStr=userInfo.getProfessionStr()==null?"":userInfo.getProfessionStr();
		userInfo.setProfessionStr(professionStr+","+costService.getProfessionName(profession+""));
		uService.updateUserInfo(userInfo);  
		costService.saveCost(costInfo);
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
	public void applicate() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		int id = userSession.getId();
		
		TAppUser user = userService.findUserById(id);
		//user.setApplicate(1);
		//user.setIsOrg(1);
		//userService.updateUser(user);
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void applicateFinish() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id"));
		
		TAppUser user = userService.findUserById(id);
		user.setApplicate(0);
		user.setIsOrg(0); //0：个人 1：机构
		userService.updateUser(user);
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
/*		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}*/
		keywords =  request.getParameter("keywords");
		//System.err.print("===========11====="+keywords);
		
		if(keywords==null||("").equals(keywords)){
			keywords="请输入关键词";
		}

		
		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = uService.getTotal(keywords, rowCount,0);
		pageNum=pageNum>total?total:pageNum;		
		
		//重设costList
		List userInfoList =uService.getUserInfoList(keywords, (pageNum-1)*rowCount, rowCount,0);	
		Iterator iterator = userInfoList.iterator();
		List newuserInfoList = new ArrayList(); 
		while(iterator.hasNext()){
			Object[] objArr = (Object[])iterator.next();
			TAppUser user = (TAppUser)objArr[0];
			int userId = user.getId();
			costList=costService.getCostListByUserId(userId);
			
			Object[] objArr5 = new Object[5];
			objArr5[0] = objArr[0]; 
			objArr5[1] = objArr[1]; 
			objArr5[2] = costList; 
			objArr5[3] = objArr[3];
			
			newuserInfoList.add(objArr5);
		}
		
		
		request.setAttribute("userInfoList", newuserInfoList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("game", total);
		request.setAttribute("keywords", keywords);
		
//		String pageKeywords=URLEncoder.encodePathParam(keywords, "UTF-8");
//		ServletActionContext.getRequest().setAttribute("pageKeywords", keywords);
		// TODO Auto-generated method stub
		return "usermanager";
	}
	
	public String getNorUserForManager() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
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
		int total = uService.getNorTotal(keywords, rowCount,100);
		pageNum=pageNum>total?total:pageNum;		
		
		List userInfoList =uService.getNorUserInfoList(keywords, (pageNum-1)*rowCount, rowCount,100);	
		
		
		request.setAttribute("userInfoList", userInfoList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total", total);
		request.setAttribute("game", total);
		request.setAttribute("keywords", keywords);
		
//		String pageKeywords=URLEncoder.encodePathParam(keywords, "UTF-8");
//		ServletActionContext.getRequest().setAttribute("pageKeywords", keywords);
		// TODO Auto-generated method stub
		return "norusermanager";
	}
	
	public String getCompanyForManager() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
//		request.setCharacterEncoding("UTF-8");
		String keywords ="";
		int flag = request.getParameter("flag")!=null&&!"".equals(request.getParameter("flag"))?Integer.parseInt(request.getParameter("flag")):0;
/*		if (flag==1) {
			keywords = new String(request.getParameter("keywords").getBytes("ISO8859_1"),"utf-8");
		}else {
			keywords =  request.getParameter("keywords");
		}*/
		keywords =  request.getParameter("keywords");
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
		String type = request.getParameter("type");
		
		int id = NumberUtils.stringToInt(request.getParameter("userId"), 0);
		if(id<=0){
			id = HttpSessionHelper.getUserSession(request).getId();
		}
		
		
		TAppUserInfo uInfo = null;
		List <TAppUserInfo> usrInfos = uService.getUserInfos(id);
		if(usrInfos != null && usrInfos.size() > 0){
			uInfo = usrInfos.get(0);
		}
		if(StringUtils.isNotBlank(userInfo.getName())){
			uInfo.setName(userInfo.getName());
		}
		if(StringUtils.isNotBlank(userInfo.getIdCard())){
			uInfo.setIdCard(userInfo.getIdCard());
		}
		if(StringUtils.isNotBlank(userInfo.getOrgCard())){
			uInfo.setOrgCard(userInfo.getOrgCard());
		}
		
		//基于myFile创建一个文件输入流
		String saveName = "";
		if(myFile != null){
			InputStream is = new FileInputStream(myFile);
					
			// 设置上传文件目录
			String uploadPath = ServletActionContext.getServletContext().getRealPath("/");
			String path = uploadPath.substring(0, uploadPath.lastIndexOf(System.getProperty("file.separator")));
			path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")));
			path = path +"\\stageUpload\\idCard";
			// 设置目标文件
			path = path.replace("\\", System.getProperty("file.separator"));
			
			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}
			
			saveName = id+this.getMyFileFileName().substring(this.getMyFileFileName().lastIndexOf("."));
			File toFile = new File(path, saveName);
			
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
			
			uInfo.setIdCardCopy(saveName);

			//----------------------------
			
			InputStream is2 = new FileInputStream(myFile2);
					
			// 设置上传文件目录
			String uploadPath2 = ServletActionContext.getServletContext().getRealPath("/");
			String path2 = uploadPath2.substring(0, uploadPath2.lastIndexOf(System.getProperty("file.separator")));
			path2 = path2.substring(0, path2.lastIndexOf(System.getProperty("file.separator")));
			path2 = path2 +"\\stageUpload\\idCard";
			// 设置目标文件
			
			path2 = path2.replace("\\", System.getProperty("file.separator"));
			
			File file2 = new File(path2);
			if(!file2.exists()) {
				file2.mkdirs();
			}
			
			String saveName2 = id+"_2"+this.getMyFile2FileName().substring(this.getMyFile2FileName().lastIndexOf("."));
			File toFile2 = new File(path2, saveName2);
			
			// 创建一个输出流
			OutputStream os2 = new FileOutputStream(toFile2);
			//设置缓存
			byte[] buffer2 = new byte[1024];
	
			int length2 = 0;
	
			//读取myFile文件输出到toFile文件中
			while ((length2 = is2.read(buffer2)) > 0) {
					os2.write(buffer2, 0, length2);
			}
	
			is2.close();
			os2.close();
			
			uInfo.setIdCardCopy2(saveName2);
		} 
		
		if(myFile3 != null){
			//执照
			InputStream is3 = new FileInputStream(myFile3);
					
			// 设置上传文件目录
			String uploadPath3 = ServletActionContext.getServletContext().getRealPath("/");
			String path3 = uploadPath3.substring(0, uploadPath3.lastIndexOf(System.getProperty("file.separator")));
			path3 = path3.substring(0, path3.lastIndexOf(System.getProperty("file.separator")));
			path3 = path3 +"\\stageUpload\\idCard";
			// 设置目标文件
			path3 = path3.replace("\\", System.getProperty("file.separator"));
			
			File file3 = new File(path3);
			if(!file3.exists()) {
				file3.mkdirs();
			}
			
			String saveName3 = id+"_3"+this.getMyFile3FileName().substring(this.getMyFile3FileName().lastIndexOf("."));
			File toFile3 = new File(path3, saveName3);
			
			// 创建一个输出流
			OutputStream os3 = new FileOutputStream(toFile3);
			//设置缓存
			byte[] buffer3 = new byte[1024];
	
			int length3 = 0;
	
			//读取myFile文件输出到toFile文件中
			while ((length3 = is3.read(buffer3)) > 0) {
					os3.write(buffer3, 0, length3);
			}
	
			is3.close();
			os3.close();
			
			uInfo.setOrgCardCopy(saveName3);
		} 
		
		
		uService.saveRealName(uInfo);
		usrInfos = uService.getUserInfos(id);
		if(usrInfos != null && usrInfos.size() > 0){
			userInfo = usrInfos.get(0);
		}
		TAppUser user = userService.findUserById(id);
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		request.getSession().setAttribute("saveSuccess","true");
		if(type!=null&&!"".equals(type)){
			return "orgProtrait";
		}
		return "userProtrait";
	}

	public Integer getBprice1() {
		return bprice1;
	}

	public void setBprice1(Integer bprice1) {
		this.bprice1 = bprice1;
	}

	public Integer getBprice2() {
		return bprice2;
	}

	public void setBprice2(Integer bprice2) {
		this.bprice2 = bprice2;
	}

	public Integer getBprice3() {
		return bprice3;
	}

	public void setBprice3(Integer bprice3) {
		this.bprice3 = bprice3;
	}

	public Integer getBprice4() {
		return bprice4;
	}

	public void setBprice4(Integer bprice4) {
		this.bprice4 = bprice4;
	}

	public Integer getBprice5() {
		return bprice5;
	}

	public void setBprice5(Integer bprice5) {
		this.bprice5 = bprice5;
	}

	public void setEprice1(Integer eprice1) {
		this.eprice1 = eprice1;
	}

	public void setEprice2(Integer eprice2) {
		this.eprice2 = eprice2;
	}

	public void setEprice3(Integer eprice3) {
		this.eprice3 = eprice3;
	}

	public void setEprice4(Integer eprice4) {
		this.eprice4 = eprice4;
	}

	public void setEprice5(Integer eprice5) {
		this.eprice5 = eprice5;
	}


	public Integer getProfession_1() {
		return profession_1;
	}

	public void setProfession_1(Integer profession_1) {
		this.profession_1 = profession_1;
	}

	public Integer getProfession_2() {
		return profession_2;
	}

	public void setProfession_2(Integer profession_2) {
		this.profession_2 = profession_2;
	}

	public Integer getProfession_3() {
		return profession_3;
	}

	public void setProfession_3(Integer profession_3) {
		this.profession_3 = profession_3;
	}

	public Integer getProfession_4() {
		return profession_4;
	}

	public void setProfession_4(Integer profession_4) {
		this.profession_4 = profession_4;
	}

	public Integer getProfession_5() {
		return profession_5;
	}

	public void setProfession_5(Integer profession_5) {
		this.profession_5 = profession_5;
	}

	public String getKeywords1() {
		return keywords1;
	}

	public void setKeywords1(String keywords1) {
		this.keywords1 = keywords1;
	}

	public String getKeywords2() {
		return keywords2;
	}

	public void setKeywords2(String keywords2) {
		this.keywords2 = keywords2;
	}

	public String getKeywords3() {
		return keywords3;
	}

	public void setKeywords3(String keywords3) {
		this.keywords3 = keywords3;
	}

	public String getKeywords4() {
		return keywords4;
	}

	public void setKeywords4(String keywords4) {
		this.keywords4 = keywords4;
	}

	public String getKeywords5() {
		return keywords5;
	}

	public void setKeywords5(String keywords5) {
		this.keywords5 = keywords5;
	}

	public File getMyFile3() {
		return myFile3;
	}

	public void setMyFile3(File myFile3) {
		this.myFile3 = myFile3;
	}

	public String getMyFile3ContentType() {
		return myFile3ContentType;
	}

	public void setMyFile3ContentType(String myFile3ContentType) {
		this.myFile3ContentType = myFile3ContentType;
	}

	public String getMyFile3FileName() {
		return myFile3FileName;
	}

	public void setMyFile3FileName(String myFile3FileName) {
		this.myFile3FileName = myFile3FileName;
	}

	

}
