package com.smt.webapp.web.member;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.service.growth.GrowthService;
import com.smt.webapp.service.user.UserInfoService;
import com.smt.webapp.util.CommonUtil;
import com.smt.webapp.util.HttpSessionHelper;
import com.smt.webapp.util.UserSession;
@Controller
public class GrowthAction extends ActionSupport{

	private TAppGrowth growth;
	public TAppGrowth getGrowth() {
		return growth;
	}
	public void setGrowth(TAppGrowth growth) {
		this.growth = growth;
	}
	
	@Autowired
	private GrowthService growthService;
	@Autowired
	private UserInfoService userInfoService;
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);

		int pageNum = request.getParameter("pageNo")!=null&&!"".equals(request.getParameter("pageNo"))?Integer.parseInt(request.getParameter("pageNo")):1;
		int  rowCount=request.getParameter("rowCount")!=null&&!"".equals(request.getParameter("rowCount"))?Integer.parseInt(request.getParameter("rowCount")):10;
		int total = growthService.getTotal(userSession.getId(), rowCount);
		pageNum=pageNum>total?total:pageNum;
		List<TAppGrowth> growthList =growthService.getGrowthList(userSession.getId(), (pageNum-1)*rowCount, rowCount);	

		ServletActionContext.getRequest().setAttribute("pageNum", pageNum);
		ServletActionContext.getRequest().setAttribute("total", total);
		ServletActionContext.getRequest().setAttribute("growthList", growthList);
		
	
		return SUCCESS;
	}
	

	public String toGrowth(){
		HttpServletRequest request = ServletActionContext.getRequest();
		UserSession userSession = HttpSessionHelper.getUserSession(request);
		String uid = request.getParameter("uid");
		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
		List <TAppGrowth> growths = growthService.getGrowth(id);
		if(growths != null && growths.size() > 0){
			growth = growths.get(0);
		}
		if(userSession!=null){
			int userId = HttpSessionHelper.getUserSession(ServletActionContext.getRequest()).getId();		
			TAppUserInfo userInfo = userInfoService.getUserInfoByUserId(userId);
			userInfo.setCzjlIsFinish(1);
			userInfoService.updateUserInfo(userInfo);
		}
		ServletActionContext.getRequest().setAttribute("growth", growth);
		request.setAttribute("id", uid);
		return "toGrowth";
	}
	/**
	 * 2014-08-17 保存成长经历
	 * @return
	 */
	public String saveGrowth(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = growth.getId()==null?0:growth.getId();
		

		int userId = NumberUtils.stringToInt(request.getParameter("userId"), 0);

		if(StringUtils.isNotBlank(request.getParameter("addUser"))){
			userId = HttpSessionHelper.getNewUserIdFromSession();
		}else{	
			if(userId<=0){
				userId = NumberUtils.stringToInt(request.getParameter("uid"), 0);
				if(userId<=0){
					userId = HttpSessionHelper.getUserSession(request).getId();	
				}
			}
		}
		if(id==0){
			growth.setUserId(userId);
			growth.setCreatTime(CommonUtil.getTime(new Date()));
		}
		growthService.suGrowth(growth);
		request.setAttribute("id", userId);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 2014-08-17 保存成长经历
	 * @return
	 */
	public String updateGrowth(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");
		
		String id = request.getParameter("growth_id");
		List<TAppGrowth> growthUpList = (List<TAppGrowth>)growthService.getGrowth(Integer.parseInt(id));
		if(growthUpList!=null && growthUpList.size() > 0){
			TAppGrowth growthUp = growthUpList.get(0);
			String title = request.getParameter("title_"+id);
			String startDate = request.getParameter("startDate_"+id);
			String endDate = request.getParameter("endDate_"+id);
			String content = request.getParameter("content_"+id);
			
			growthUp.setTitle(title);
			growthUp.setContent(content);
			
			//if(StringUtils.isNotBlank(startDate)){
				growthUp.setStartDate(startDate);
			//}
			//if(StringUtils.isNotBlank(endDate)){
				growthUp.setEndDate(endDate);
			//}
			
			//company
			String yulanImgHid = request.getParameter("yulanImgHid_"+id);
			String price = request.getParameter("price_"+id);
			String unit = request.getParameter("unit_"+id);
			
			if(StringUtils.isNotBlank(yulanImgHid)){
				growthUp.setBulletinImg(yulanImgHid);
			}
			if(StringUtils.isNotBlank(price)){
				growthUp.setPrice(price);
			}
			if(StringUtils.isNotBlank(unit)){
				growthUp.setUnit(unit);	
			}
			
			growthService.updateGrowth(growthUp);
		}
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public String suGrowth(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = growth.getId()==null?0:growth.getId();
		
		int userId = HttpSessionHelper.getUserSession(request).getId();
		String uid = request.getParameter("uid");
		
		if(uid!=null&&!"".equals(uid)){
			userId = Integer.parseInt(uid);
		}
		if(id==0){
			growth.setUserId(userId);
			growth.setCreatTime(CommonUtil.getTime(new Date()));
		}
		growthService.suGrowth(growth);
		request.setAttribute("id", userId);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void delGrowth(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/plain");

		int id = request.getParameter("id")!=null&&!"".equals(request.getParameter("id"))?Integer.parseInt(request.getParameter("id")):0;
       
        TAppGrowth growth=new TAppGrowth();
		growth.setId(id);
		growthService.delGrowth(growth);
		try {
			response.getWriter().print("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
