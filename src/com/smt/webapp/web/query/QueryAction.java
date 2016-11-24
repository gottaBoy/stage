package com.smt.webapp.web.query;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppInformation;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppTask;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.business.BusinessInfoService;
import com.smt.webapp.service.cost.CostService;
import com.smt.webapp.service.information.InformationService;
import com.smt.webapp.service.query.QueryService;
import com.smt.webapp.service.task.TaskService;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;

@Controller
public class QueryAction extends ActionSupport {

	@Autowired
	private QueryService queryService;
	@Autowired
	private CostService costService;
	@Autowired
	private BusinessInfoService businessInfoService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private InformationService informationService;
	
	//头部页面的关键字搜索
	private String headKeywords;
	
	public String getHeadKeywords() {
		return headKeywords;
	}

	public void setHeadKeywords(String headKeywords) {
		this.headKeywords = headKeywords;
	}

	//列表页面的价格搜索
	private String bprice;
	public String getBprice() {
		return bprice;
	}

	public void setBprice(String bprice) {
		this.bprice = bprice;
	}

	//列表页面的价格搜索
	private String eprice;
	public String getEprice() {
		return eprice;
	}

	public void setEprice(String eprice) {
		this.eprice = eprice;
	}

	//列表页面的关键字搜索
	private String keywords;
	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	/**
	 * status=2为委托发布
	 *  
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String findTask()throws UnsupportedEncodingException{
		int status = 3;
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		
		int begin = NumberUtils.stringToInt(request.getParameter("begin"),0);
		int length= NumberUtils.stringToInt(request.getParameter("length"),0); 
		String city = request.getParameter("city");
		String searchContent = request.getParameter("searchContent");
		if(StringUtils.equals(searchContent, "请输入关键词")){
			searchContent= "";	
		}
		String fromWeb = request.getParameter("fromWeb");

		int total = taskService.findTaskTotal(city,searchContent, status,fromWeb);
		begin = begin > total ? total : begin;
		List taskList = taskService.findTask(city,searchContent,begin,length, status,fromWeb);
//		List taskList = taskService.getTaskListByUserID4Test(1, 0, 50);
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		if(!CollectionUtils.isEmpty(taskList)){
			Iterator it = taskList.iterator();
			while(it.hasNext()){
				Object[] objArr = (Object[])it.next();
				
				TAppTask task   = (TAppTask)objArr[0];
				TAppUser u      = (TAppUser)objArr[1];
				TAppUserInfo ui = (TAppUserInfo)objArr[2];
				
				Map<String,Object> tempMap = new HashMap<String,Object>();
				tempMap.put("id", u.getId());
				tempMap.put("img", "/stageUpload/headImage/"+u.getId()+".png");
				tempMap.put("nickName", ui.getNickName());

				tempMap.put("taskTitle", task.getTitle());
				tempMap.put("taskPrice", task.getPrice());
				tempMap.put("taskPublishTime", task.getCreatTime().substring(0,"yyyy-MM-dd".length()));
				tempMap.put("city", StringUtils.defaultIfEmpty(task.getProvice(),StringUtils.EMPTY));
				tempMap.put("taskId", task.getId());
				
				list.add(tempMap);
			}
		}
		result.put("list", list);
		
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String findWork()throws UnsupportedEncodingException{
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		
		int begin = NumberUtils.stringToInt(request.getParameter("begin"),0);
		int length= NumberUtils.stringToInt(request.getParameter("length"),0); 
		String city = request.getParameter("city");
		String searchContent = request.getParameter("searchContent");
		if(StringUtils.equals(searchContent, "请输入关键词")){
			searchContent= "";	
		}
		
		List infoList =informationService.getInformationList(city,searchContent,begin,length);	
		int total = informationService.getInformationTotal(city,searchContent);
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		Gson gson = new Gson();
		result.put("total", Integer.toString(total));
		
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		result.put("actionName", request.getParameter("actionName"));
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		if(!CollectionUtils.isEmpty(infoList)){
			Iterator it = infoList.iterator();
			while(it.hasNext()){
				Object[] objArr = (Object[])it.next();
				
				TAppInformation info   = (TAppInformation)objArr[0];
				TAppUserInfo    ui = (TAppUserInfo)objArr[1];
				
				Map<String,Object> tempMap = new HashMap<String,Object>();
				tempMap.put("id", ui.getUserId());
				tempMap.put("img", "/stageUpload/headImage/"+ui.getUserId()+".png");
				tempMap.put("nickName", ui.getNickName());

				tempMap.put("taskTitle", info.getTitle());
				tempMap.put("taskPrice", StringUtils.defaultIfEmpty(info.getDaiyu(),""));
				tempMap.put("taskPublishTime", info.getCreatTime().substring(0,"yyyy-MM-dd".length()));
				tempMap.put("city", StringUtils.defaultIfEmpty(info.getWorkAddress(),""));
				tempMap.put("taskId", info.getId());
				
				list.add(tempMap);
			}
		}
		result.put("list", list);
	 
		String resultStr = gson.toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public String toQuery() throws UnsupportedEncodingException{
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		
		String keyType=request.getParameter("keyType");
		
		String signSub=request.getParameter("signSub");
		String sign=request.getParameter("sign");
		int orderBySign=request.getParameter("orderBySign")==null?0:Integer.parseInt(request.getParameter("orderBySign"));
		int orderByDesc=request.getParameter("orderByDesc")==null?0:Integer.parseInt(request.getParameter("orderByDesc"));
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		String filterValue=request.getParameter("filterValue")==null?"":new String(request.getParameter("filterValue").getBytes("ISO8859_1"),"utf-8");
		String pageHeadKeywords=request.getParameter("pageHeadKeywords")==null?"":new String(request.getParameter("pageHeadKeywords").getBytes("ISO8859_1"),"utf-8");

		String pageKeywords=request.getParameter("pageKeywords")==null?"":request.getParameter("pageKeywords");
		String place=request.getParameter("place1")==null?"":request.getParameter("place1");
		String placeId=request.getParameter("city_id")==null?"0":request.getParameter("city_id");
		String placeF=request.getParameter("placeF")==null?"0":request.getParameter("placeF");
		String sex = request.getParameter("sex")==null?"0":request.getParameter("sex");
		int sort = request.getParameter("sort")==null?0:Integer.parseInt(request.getParameter("sort"));
		
		headKeywords=headKeywords==null?pageHeadKeywords:headKeywords;
		
		int bprice1 = 0;
		int eprice1 = 0;
		try {
			bprice1 = Integer.parseInt(bprice);
			eprice1 = Integer.parseInt(eprice);
		} catch (NumberFormatException e) {
		}
		keywords=keywords==null?pageKeywords:keywords;
		int total = 0;
		if (placeF.equals("1")) {
			headKeywords = pageHeadKeywords;
			List yrInfoList=queryService.getYrInfo(placeF,placeId,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
			request.setAttribute("yrInfoList",yrInfoList);
			String placeName = queryService.getPlace(placeId);
			request.setAttribute("place", placeName);
			total = queryService.getTotal(placeF,placeId,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
		}else {
			List yrInfoList=queryService.getYrInfo(placeF,place,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
			request.setAttribute("yrInfoList",yrInfoList);
			request.setAttribute("place", place);
			total = queryService.getTotal(placeF,place,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
		}
		
		
		
		
		pageNum=pageNum>total?total:pageNum;
		List<TAppTalentCategory> list1=queryService.getTalentCategory();
		//List<TAppTalentCategory> list2=queryService.getTalentCategory(2);
		//List<TAppTalentCategory> list3=queryService.getTalentCategory(3);
		
		request.setAttribute("sign", sign);
		request.setAttribute("signSub", signSub);
		request.setAttribute("filterValue",filterValue);
		request.setAttribute("orderBySign", orderBySign);

		request.setAttribute("orderByDesc", orderByDesc);
		request.setAttribute("sex", sex);
		request.setAttribute("sort", sort);
		request.setAttribute("placeId", placeId);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("game", total);
		request.setAttribute("list1",list1);
		request.setAttribute("pageHeadKeywords",headKeywords);
		//request.setAttribute("list2",list2);
		//request.setAttribute("list3",list3);
		
		if(StringUtils.equals(keyType, "2")){
			return "orgService";
		}else{
			return SUCCESS;
		}
	}

	
	public String toQuery2() throws UnsupportedEncodingException{
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		String keyType=request.getParameter("keyType");
		int pageNum = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		int rowCount=request.getParameter("rowCount")==null?10:Integer.parseInt(request.getParameter("rowCount"));
		
		String signSub=request.getParameter("signSub");
		String sign=request.getParameter("sign");
		int orderBySign=request.getParameter("orderBySign")==null?0:Integer.parseInt(request.getParameter("orderBySign"));
		int orderByDesc=request.getParameter("orderByDesc")==null?0:Integer.parseInt(request.getParameter("orderByDesc"));
		String filterValue=request.getParameter("filterValue")==null?"":new String(request.getParameter("filterValue").getBytes("ISO8859_1"),"utf-8");
		String pageHeadKeywords=request.getParameter("pageHeadKeywords")==null?"":new String(request.getParameter("pageHeadKeywords").getBytes("ISO8859_1"),"utf-8");

		String pageKeywords=request.getParameter("pageKeywords")==null?"":request.getParameter("pageKeywords");
		String place=request.getParameter("place1")==null?"":request.getParameter("place1");
		String placeId=request.getParameter("city_id")==null?"0":request.getParameter("city_id");
		String placeF=request.getParameter("placeF")==null?"0":request.getParameter("placeF");
		String sex = request.getParameter("sex")==null?"0":request.getParameter("sex");
		int sort = request.getParameter("sort")==null?0:Integer.parseInt(request.getParameter("sort"));
		
		headKeywords=(headKeywords==null)?pageHeadKeywords:headKeywords;		
		keywords=(keywords==null)?pageKeywords:keywords;
		
		int total = 0;
		//String keyTypeStr=request.getParameter("keyTypeStr");
		if(StringUtils.equals(keyType, "2")){
			//找服务
			List yrInfoList=queryService.getOrgInfo((pageNum-1)*rowCount, rowCount,StringUtils.trim(headKeywords));
			request.setAttribute("yrInfoList",yrInfoList);
            total = queryService.getOrgTotal(StringUtils.trim(headKeywords));

			request.setAttribute("yrInfoList",yrInfoList);
			
			//============================
			pageNum=(pageNum>total)?total:pageNum;
			List<TAppTalentCategory> list1=queryService.getTalentCategory();
			
			request.setAttribute("sign", sign);
			request.setAttribute("signSub", signSub);
			request.setAttribute("keyType", keyType);
			
			request.setAttribute("filterValue",filterValue);
			request.setAttribute("orderBySign", orderBySign);
			request.setAttribute("place", "");
			request.setAttribute("orderByDesc", orderByDesc);
			request.setAttribute("sex", sex);
			request.setAttribute("sort", sort);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("game", total);
			request.setAttribute("placeId", placeId);
			request.setAttribute("list1",list1);
			request.setAttribute("pageHeadKeywords",headKeywords);
			
			return "orgService";
		}else{
			//找艺人
			int bprice1 = 0;
			int eprice1 = 0;
			try {
				bprice1 = Integer.parseInt(bprice);
				eprice1 = Integer.parseInt(eprice);
			} catch (NumberFormatException e) {
			}
			
			if (placeF.equals("1")) {
				headKeywords = pageHeadKeywords;
				List yrInfoList=queryService.getYrInfo(placeF,placeId,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex, keyType);
				request.setAttribute("yrInfoList",yrInfoList);
				String placeName = queryService.getPlace(placeId);
				request.setAttribute("place", placeName);
				total = queryService.getTotal(placeF,placeId,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
			}else {
				List yrInfoList=queryService.getYrInfo(placeF,place,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
				request.setAttribute("yrInfoList",yrInfoList);
				request.setAttribute("place", place);
				total = queryService.getTotal(placeF,place,sort,orderBySign,orderByDesc,filterValue,(pageNum-1)*rowCount, rowCount,bprice1,eprice1,keywords,headKeywords.trim(),sex,keyType);
			}
			
			
			pageNum=(pageNum>total)?total:pageNum;
			List<TAppTalentCategory> list1=queryService.getTalentCategory();
			//List<TAppTalentCategory> list2=queryService.getTalentCategory(2);
			//List<TAppTalentCategory> list3=queryService.getTalentCategory(3);
			
			request.setAttribute("sign", sign);
			request.setAttribute("signSub", signSub);
			request.setAttribute("filterValue",filterValue);
			request.setAttribute("orderBySign", orderBySign);
	
			request.setAttribute("orderByDesc", orderByDesc);
			request.setAttribute("sex", sex);
			request.setAttribute("sort", sort);
			request.setAttribute("placeId", placeId);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("game", total);
			request.setAttribute("list1",list1);
			request.setAttribute("pageHeadKeywords",headKeywords);
			//request.setAttribute("list2",list2);
			//request.setAttribute("list3",list3);
			
			return SUCCESS;
		}
	}

	/**
	 * 分类查询
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String toFenLeiQuery() throws UnsupportedEncodingException{
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		int begin = request.getParameter("begin")==null?0:Integer.parseInt(request.getParameter("begin"));
		int length=request.getParameter("length")==null?50:Integer.parseInt(request.getParameter("length"));
		
		String headKeywords2 = StringUtils.defaultIfEmpty(request.getParameter("headKeywords"), StringUtils.EMPTY);
		request.setAttribute("headKeywords",headKeywords2);
		
		
		String filterValue=StringUtils.defaultIfEmpty(request.getParameter("filterValue"), "");
		String place=StringUtils.defaultIfEmpty(request.getParameter("place"), "");
		String renZheng=StringUtils.defaultIfEmpty(request.getParameter("renZheng"), "");
		
		if(StringUtils.equals(place, "不限")){ 
			place = "";
		}
		if(StringUtils.equals(renZheng, "不限")){ 
			renZheng = "";
		}
		int sexId = NumberUtils.stringToInt(request.getParameter("sex"),0);
		
		//0=人气最旺1=价格最低 2=好评最多 3=最新加入
		int sort = NumberUtils.stringToInt(request.getParameter("sort"),0);
		
		int priceIndex = NumberUtils.stringToInt(request.getParameter("priceIndex"),0);
		
		//sex 不限，男，女，组合
		String sex = "";
		switch (sexId) {
		case 1:
			sex = "1"; //男
			break;
		case 2:
			sex = "2"; //女
			break;
		case 3:
			sex = "3"; //组合
			break;
		default:
			sex = "";
			break;
		}
		
		
		
		//500元以下500-1000元1000-2000元2000-3000元3000元以上
		int bprice = 0;
		int eprice = 0;
		switch (priceIndex) {
			case 1:
				bprice = 50;
				eprice = 499;
				break;
			case 2:
				bprice = 500;
				eprice = 999;
				break;
			case 3:
				bprice = 1000;
				eprice = 1999;
				break;
			case 4:
				bprice = 2000;
				eprice = 2999;
				break;
			case 5:
				bprice = 3000;
				eprice = 99999999;
				break;
			default:
				bprice = 50;
				eprice = 99999999;				
				break;
		}
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		
		List yrInfoList=queryService.getFenLei(place,sort,filterValue,begin, length,bprice,eprice,sex,renZheng,headKeywords2);
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		Iterator iterator = yrInfoList.iterator();
		while(iterator.hasNext()){
			Object[] objArr = (Object[])iterator.next();
			TAppUser user = (TAppUser)objArr[0];
			TAppUserInfo userInfo = (TAppUserInfo)objArr[1];
			TAppCostInfo userCost = (TAppCostInfo)objArr[2];
			TAppTalentCategory userCategory = (TAppTalentCategory)objArr[3];
			
			Map<String,Object> userMap = new HashMap<String,Object>();
			userMap.put("id", user.getId());
			userMap.put("img", "/stageUpload/indexHeadImage/"+user.getId()+".png");
			userMap.put("nickName", userInfo.getNickName());
			userMap.put("province", userInfo.getProvice());
			
			userMap.put("bprice", userCost.getBprice());
			userMap.put("unit", userCost.getUnit());
			
			if(StringUtils.isEmpty(userCost.getKeywords())){
				userMap.put("profession", userCategory.getTypeName());
			}else{
				if(userCost.getKeywords().length()>8){
					userMap.put("profession", userCost.getKeywords().substring(0,8));
				}else{
					userMap.put("profession", userCost.getKeywords());
				}
			}
			
			//签约次数，交易数
			int signAmount = businessInfoService.getMyBusinessInfoTotal(userInfo.getUserId(),3);

			userMap.put("signAmount", Integer.toString(signAmount));
			
			//userMap.put("signAmount", (userInfo.getSignNumber()==null)?"0":userInfo.getSignNumber().toString());
			
			resultList.add(userMap);
		}
		
		//签约榜
		
		List businessList = businessInfoService.getBusinessInfoByCategory(filterValue);
//		request.setAttribute("businessList", businessList);
		result.put("businessList", businessList);
		
		int total = queryService.getFenLeiTotal(place,sort,filterValue,begin, length,bprice,eprice,sex,renZheng,headKeywords2);
	
		Stack<Map<String,Object>> stack = new Stack<Map<String,Object>>();
		
		TAppTalentCategory talentCategory = queryService.getTalentCategory(filterValue);
		if(talentCategory!=null){
			Map<String,Object> cMap = new HashMap<String,Object>();
			cMap.put("id", talentCategory.getId());
			cMap.put("alias", talentCategory.getAlias());
			cMap.put("typeName", talentCategory.getTypeName());
			stack.push(cMap);
			
			result.put("talentCategory",cMap);
			
			Integer level = talentCategory.getLayer();
			int parentId = talentCategory.getParentId();
			for(int i=level; i>0; i--){ //层层查找
				TAppTalentCategory parentTalentCategory = costService.getTAppTalentCategory(parentId);
				if(parentTalentCategory!=null){
					parentId = parentTalentCategory.getParentId();
					
					Map<String,Object> c2Map = new HashMap<String,Object>();
					c2Map.put("id", parentTalentCategory.getId());
					c2Map.put("alias", parentTalentCategory.getAlias());
					c2Map.put("typeName", parentTalentCategory.getTypeName());
					stack.push(c2Map);
				}
			}
		}
		List<Map<String,Object>> categoryList = new ArrayList<Map<String,Object>>();
		while(!stack.isEmpty()){
			categoryList.add(stack.pop());
		}

		result.put("filterValue",filterValue);
		result.put("list",resultList);
		result.put("categoryList",categoryList);
		result.put("total",total);
		
		
		String resultStr = new Gson().toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return null;
	}

	/**
	 * 分类查询
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String toOrgQuery() throws UnsupportedEncodingException{
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		
		int begin = request.getParameter("begin")==null?0:Integer.parseInt(request.getParameter("begin"));
		int length=request.getParameter("length")==null?30:Integer.parseInt(request.getParameter("length"));
		
		String headKeywords2 = StringUtils.defaultIfEmpty(request.getParameter("headKeywords"), StringUtils.EMPTY);
		request.setAttribute("headKeywords",headKeywords2);

		String orgType=StringUtils.defaultIfEmpty(request.getParameter("orgType"), "");
		String place=StringUtils.defaultIfEmpty(request.getParameter("place"), "");
		String renZheng=StringUtils.defaultIfEmpty(request.getParameter("renZheng"), "");

		
		if(StringUtils.equals(place, "不限")){ 
			place = "";
		}
		if(StringUtils.equals(orgType, "不限")){ 
			orgType = "";
		}
		
		//0:人气最旺 1:好评最多 2:签约最多
		int sort = NumberUtils.stringToInt(request.getParameter("sort"),0);
		
		Map<String,Object> result = new LinkedHashMap<String,Object>();
		result.put("currentPage", NumberUtils.stringToInt(request.getParameter("currentPage"),1));
		
		List yrInfoList=queryService.getOrg(orgType,place,sort,begin, length,renZheng,headKeywords2);
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		Iterator iterator = yrInfoList.iterator();
		while(iterator.hasNext()){
			Object[] objArr = (Object[])iterator.next();
			TAppUser user = (TAppUser)objArr[0];
			TAppUserInfo userInfo = (TAppUserInfo)objArr[1];
			
			Map<String,Object> userMap = new HashMap<String,Object>();
			userMap.put("id", user.getId());
			userMap.put("img", "/stageUpload/indexHeadImage/"+user.getId()+".png");
			userMap.put("nickName", userInfo.getNickName());
			userMap.put("province", userInfo.getProvice());
			
			userMap.put("goodRate", userInfo.getFeedbackRate());
			
			//签约次数，交易数
			int signAmount = businessInfoService.getMyBusinessInfoTotal(userInfo.getUserId(),3);

			userMap.put("signAmount", Integer.toString(signAmount));
			
			resultList.add(userMap);
		}
		
		int total = queryService.getOrgTotal(orgType,place,sort,begin, length,renZheng,headKeywords2);
	
 
		result.put("list",resultList);
		result.put("total",total);
		
		
		String resultStr = new Gson().toJson(result);// list为要转换为JSON对象的数据
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/json; charset=utf-8");
		
		response.setHeader("Cache-Control", "no-cache"); //取消浏览器缓存
		
		try {
			response.getWriter().print(resultStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return null;
	}
}
