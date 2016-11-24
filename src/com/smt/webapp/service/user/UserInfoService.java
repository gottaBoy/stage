package com.smt.webapp.service.user;

import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppCompanyInfo;
import com.smt.entity.TAppGrowth;
import com.smt.entity.TAppMenu;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserInfo;
import com.smt.entity.TBaseArea;
import com.smt.entity.UserParameter;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.dao.user.UserInfoDao;
import com.smt.webapp.dao.user.Userdao;
import com.smt.webapp.middleware.BeanBoss;
import com.smt.webapp.middleware.GrjsBean;
import com.smt.webapp.middleware.JcxxBean;
import com.smt.webapp.middleware.JcxxBeanOrg;
import com.smt.webapp.util.CommonUtil;

@Service
public class UserInfoService {
	@Autowired
	private UserInfoDao userInfoDao;
	@Autowired
	private Userdao userdao;
	public List<TAppUserInfo> getUserInfos(int id){
		return userInfoDao.getUserInfoByUserID(id);
	}
	public void saveOrUpdateUserInfo(TAppUserInfo userInfo,int sign) {
		TAppUserInfo uInfo = null;
		List<TAppUserInfo> list = userInfoDao.getUserInfoByUserID(userInfo.getUserId());
		if(list != null && list.size() > 0){
			BeanBoss boss = null;
			switch (sign) {
			case 1:
				boss  = new JcxxBean();	
				break;
//			case 2:
//				boss  = new GrjsBean();	
//				break;
			case 2:
				boss  = new JcxxBeanOrg();	
				break;
			}
			BeanUtils.copyProperties(userInfo, boss);
			uInfo = list.get(0);
			BeanUtils.copyProperties(boss, uInfo);
			uInfo.setModifyTime(CommonUtil.getTime(new Date()));
			uInfo.setPlace(userInfo.getPlace());
			userInfoDao.saveOrUpdateUserInfo(uInfo);
			return;
		}
		userInfo.setModifyTime(CommonUtil.getTime(new Date()));
		userInfoDao.saveOrUpdateUserInfo(userInfo);
		// TODO Auto-generated method stub
	}
	public void saveOrUpdateFeek(TAppUserInfo userInfo) {

		userInfoDao.saveOrUpdateFeek(userInfo);
	}
	
	public List<UserParameter> findObjectBySql(String keywords){
		return userInfoDao.findObjectBySql(keywords);
	}
	public List<UserParameter> findObjectBySql1(String keywords){
		return userInfoDao.findObjectBySql1(keywords);
	}
	
	public void saveUserInfo(TAppUserInfo userInfo){
		userInfoDao.saveOrUpdateUserInfo(userInfo);
	}
	public TAppUserInfo findUserInfoByUserId(int userId) {
		return userInfoDao.findUserInfoByUserId(userId);
	}
	public TAppUserInfo findUserInfoByNickName(String nickName) {
		return userInfoDao.findUserInfoByNickName(nickName);
	}
	public List getBzzxByorgId(int id,int type) {
		// TODO Auto-generated method stub
		return userInfoDao.getBzzxByorgId(id,type);
	}	
	public List<TAppTalentCategory> getTalent(String pro1) {
		// TODO Auto-generated method stub
		return userInfoDao.getTalent(pro1);
	}
	public List<TBaseArea> getArea(String loc1) {
		// TODO Auto-generated method stub
		return userInfoDao.getArea(loc1);
	}
	public TAppCompanyInfo getBzzxByorgId1(int id) {
		// TODO Auto-generated method stub
		return userInfoDao.getBzzxByorgId1(id);
	}
	public TAppUserInfo findUserInfoById(int id) {
		return userInfoDao.findUserInfoById(id);
	}
	public void updateUserInfo(TAppUserInfo userInfo) {
		// TODO Auto-generated method stub
		userInfoDao.saveOrUpdateUserInfo(userInfo);	
	}
	public void updateUserAlipay(String sql) {
		userInfoDao.updateUserAlipay(sql);	
	}

	public void saveRealName(TAppUserInfo uInfo) {
		// TODO Auto-generated method stub
		userInfoDao.saveOrUpdateUserInfo(uInfo);
		TAppUser user = userdao.getAppUserById(uInfo.getUserId());
		user.setRzState("2");
		userdao.updateUser(user);
		
	}
	//判断是否晋级
	public TAppUserInfo getUserInfoByUserId(int userId){
		return userInfoDao.getUserInfoByUserId(userId);
	}


	public List getUserInfoList(String  keywords,int  begin,int rowCount,int flag) {
		return userInfoDao.getUserInfoList(keywords,begin,rowCount,flag);
	}
	public List getNorUserInfoList(String  keywords,int  begin,int rowCount,int flag) {
		return userInfoDao.getNorUserInfoList(keywords,begin,rowCount,flag);
	}

	public List getAttestationList(String  keywords,int  begin,int rowCount,int flag) {
		return userInfoDao.getAttestationList(keywords,begin,rowCount,flag);
	}
	

	public int getTotal(String  keywords,int rowCount,int flag){
		return userInfoDao.getTotal(keywords, rowCount,flag);
	}
	public int getNorTotal(String  keywords,int rowCount,int flag){
		return userInfoDao.getNorTotal(keywords, rowCount,flag);
	}

	
	public int getAttestationTotal(String  keywords,int rowCount,int flag){
		return userInfoDao.getAttestationTotal(keywords, rowCount,flag);
	}

	public List getUserListsByProf(String prof) {
		List list = userInfoDao.getUserInfoByProf(prof,"1");

		return list;
	}
	public List getUserListsByProfNew(String prof) {
		List list = userInfoDao.getUserInfoByProfNew(prof,"1");
		
		return list;
	}
	
	public List getUserInfoByorgId(int orgId,int  begin,int rowCount,String keywords){
		
		return userInfoDao.getUserInfoByorgId(orgId, begin, rowCount,keywords);
	}
	public List getUserInfoByorgId1(int orgId,int  begin,int rowCount){
		
		return userInfoDao.getUserInfoByorgId1(orgId, begin, rowCount);
	}
	public List getUserInfoByorgId2(int orgId,int  begin,int rowCount,int taskId){
		
		return userInfoDao.getUserInfoByorgId2(orgId, begin, rowCount,taskId);
	}
	public int getUserInfoByorgIdTotal1(int orgId){
		
		return userInfoDao.getUserInfoByorgIdTotal1(orgId);
	}
	
	public int getUserTotalByorgId(int orgId,String keywords){
		
		return userInfoDao.getUserTotalByorgId(orgId,keywords);
	}
	
	public List<TAppUserInfo> getIndexUserSuggestion(int  begin,int rowCount){
		return userInfoDao.getIndexUserSuggestion(begin, rowCount);
	}
	
	public List<TAppUserInfo> getIndexArtistListParameter(int profession,List<Integer> pidList,int range){
		return userInfoDao.getIndexArtistListParameter(profession,pidList,range);
	}
	
	public List<Integer> getProfessionList(List<Integer> pids){
		return userInfoDao.getProfessionList(pids);
	}
	
	public List getorgUserInfo(int  begin,int rowCount,String loc1,String loc2,String sort,String keyword){
		
		return userInfoDao.getorgUserInfo( begin, rowCount,loc1,loc2,sort,keyword);
	}
	public int getorgUserTotal(String loc1,String loc2,String keyword){
		
		return userInfoDao.getorgUserTotal(loc1,loc2,keyword);
	}
	public void updatePopul(String id){
		
		userInfoDao.updatePopul(id);
	}
	public void updateAttent(String id){
		
		userInfoDao.updateAttent(id);
	}
	
	
	public int saveOrUpdateOrgUserInfo(TAppUserInfo userInfo, TAppUser user) {
		// TODO Auto-generated method stub
		
		int userId = userdao.saveUser(user);
		userInfo.setUserId(userId);
		userInfoDao.saveOrUpdateUserInfo(userInfo);
		return userId;
	}
	public List getCity(int isOrg) {
		return userInfoDao.getCity(isOrg);
	}
	
	public int countUserByMobile(String mobile){
		return userInfoDao.countUserInfoByMobile(mobile);
	}
}
