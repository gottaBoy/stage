package com.smt.webapp.service.user;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppCostInfo;
import com.smt.entity.TAppMessage;
import com.smt.entity.TAppUser;
import com.smt.entity.TAppUserEvaluation;
import com.smt.entity.TAppUserInfo;
import com.smt.webapp.dao.evaluation.UserEvaluationDao;
import com.smt.webapp.dao.user.UserInfoDao;
import com.smt.webapp.dao.user.Userdao;
import com.smt.webapp.service.Message.MessageService;
import com.smt.webapp.util.CommonUtil;
@Service
public class UserService {
	
    @Autowired
	private Userdao userDao;
    @Autowired
	private UserEvaluationDao userEvaluationDao;
    @Autowired UserInfoDao userInfoDao;
    @Autowired
	private MessageService messageService;
    /**
     * @Description: 通过用户名获得用户信息
     * @author hyl   
     * @date 2013-2-22 上午9:43:28
     * @param userName
     * @return
     */
    public TAppUser findUser(String userName){
    	TAppUser user = userDao.findUserByUserName(userName);
    	return user;
    }
    public TAppUserInfo findUserByNickName(String userName,String userId){
    	TAppUserInfo user = userDao.findUserByNickName(userName,userId);
    	return user;
    }
    public TAppUser  findUserByUserId(int userId){
    	TAppUser user = userDao.findUserByUserId(userId);
    	return user;
    }
    /**
     * @Description: 通过用户id获得用户信息
     * @author hyl   
     * @date 2013-3-4 上午9:43:28
     * @param id
     * @return
     */ 
    public TAppUser findUserById(int id) {
    	return userDao.findUserById(id);
    }
    
    public String getMaxUserIdFromSequenceTable(String tableName){
    	return userDao.getMaxUserIdFromSequenceTable(tableName);
    }

    public void saveUserNew(TAppUser user){
    	user.setState("1");
    	user.setRoleId(2);
    	user.setAuthority(0);
    	user.setCreatTime(CommonUtil.getTime(new Date()));
    	int id = userDao.saveUser(user);
    }
    
    /**
     * Return the id for h5 action
     * @date 2016-2
     */
    public int saveUser(TAppUser user){
    	return userDao.saveUser(user);
    }
    
    /**
     * @Description:保存用户信息
     * @author hyl   
     * @date 2013-2-22 上午9:43:08
     * @param user
     */
    public void saveUserNew(TAppUser user,String mobile){
    	user.setState("1");
    	int id = userDao.saveUser(user);
    	TAppUserEvaluation userEvaluation = new TAppUserEvaluation();
    	userEvaluation.setUserId(id);
    	userEvaluation.setEvaluation(0);
    	userEvaluation.setSellerEvaluation(0);
    	userEvaluationDao.addOrEdituserEvaluation(userEvaluation);

    	
    	TAppMessage message = new TAppMessage();
    	message.setCreatTime(CommonUtil.getTime(new Date()));
    	message.setTitle("第1舞台迎宾信！");
    	message.setFromUserId(3);
    	message.setToUserId(id);
    	message.setContent("尊敬的会员，您好！                              欢迎您加入第1舞台，请您丰富并完善其资料（个人信息、头像、相册、视频、成长经历等），有利于您方便快捷的找活接活,您资料的完整程度也是检索您网站排名的重要依据哦。您自己的舞台为您而精彩！若有疑问或建议，您可拨打第1热线：021-52902120或者加入第1舞台微信公众号：d15tfamily第1舞台QQ群：311642987（专人1对1服务）");
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(2);
		messageService.addMessage(message);
    }
    /**
     * @Description:保存用户信息
     * @author hyl   
     * @date 2013-2-22 上午9:43:08
     * @param user
     */
    public void saveUser(TAppUser user,String mobile){
    	user.setState("1");
    	int id = userDao.saveUser(user);
    	TAppUserEvaluation userEvaluation = new TAppUserEvaluation();
    	userEvaluation.setUserId(id);
    	userEvaluation.setEvaluation(0);
    	userEvaluation.setSellerEvaluation(0);
    	userEvaluationDao.addOrEdituserEvaluation(userEvaluation);
    	TAppUserInfo userInfo = new TAppUserInfo();
    	userInfo.setId(id);//****************
    	userInfo.setUserId(id);
    	userInfo.setSellerGrade("1");
    	userInfo.setAge(0);
    	userInfo.setNickName(user.getUsername());
    	userInfo.setIsRecommend("0");
    	userInfo.setSignNumber(0);
    	userInfo.setSignAmount("保密");
    	userInfo.setPopularityTotal(0);
    	userInfo.setGrade("1");
    	userInfo.setFeedbackRate(100);
    	userInfo.setMobile(mobile);
    	userInfo.setCreatTime(CommonUtil.getTime(new Date()));
    	userInfoDao.saveOrUpdateUserInfo(userInfo);
    	
    	TAppMessage message = new TAppMessage();
    	message.setCreatTime(CommonUtil.getTime(new Date()));
    	message.setTitle("第1舞台迎宾信！");
    	message.setFromUserId(3);  
    	message.setToUserId(id);
    	message.setContent("尊敬的会员，您好！                              欢迎您加入第1舞台，请您丰富并完善其资料（个人信息、头像、相册、视频、成长经历等），有利于您方便快捷的找活接活,您资料的完整程度也是检索您网站排名的重要依据哦。您自己的舞台为您而精彩！若有疑问或建议，您可拨打第1热线：021-52902120或者加入第1舞台微信公众号：d15tfamily第1舞台QQ群：311642987（专人1对1服务）");
    	message.setStatus("0");	//发送短信后默认为未读
    	message.setType(2);
		messageService.addMessage(message);
    }
    
    /**
     * @Description: 通过email获得用户信息
     * @author hyl   
     * @date 2013-2-22 上午9:42:56
     * @param email
     * @return
     */
    public TAppUser findUserByEmail(String email){
    	TAppUser user = userDao.findUserByEmail(email);
    	return user;
    }
    
   
    
    /**
     * @Description: 修改用户
     * @author hyl   
     * @date 2013-2-22 上午9:42:36
     * @param user
     */

	public void updateUser(TAppUser user) {
		// TODO Auto-generated method stub
		userDao.updateUser(user);
		
	}
	public int getYrSunByUserId(int id) {
		// TODO Auto-generated method stub
		return userDao.getYrSunByUserId(id);
	}
	public void doAddMessage() {
		// TODO Auto-generated method stub
		userDao.doAddMessage();
	}
	public List getYrinfoByorgId(String loc1,String loc2) {
		// TODO Auto-generated method stub
		return userDao.getYrinfoByorgId(loc1,loc2);
	}

	public List getZhyByorgId(int id) {
		// TODO Auto-generated method stub
		return userDao.getZhyByorgId(id);
	}
	public List getZhyByorgId_other(int id) {
		// TODO Auto-generated method stub
		return userDao.getZhyByorgId_other(id);
	}
	
	
	public List getYrxxs(int id, int i, int rowCount, String sex, String pro1,String pro2, String pri) {
		// TODO Auto-generated method stub
		return userDao.getYrxxs(id,i,rowCount,  sex,  pro1, pro2, pri);
	}
	public int getYrxxsTotal(int id, String sex, String pro1,String pro2, String pri) {
		// TODO Auto-generated method stub
		return userDao.getYrxxsTotal(id,sex,  pro1, pro2, pri);
	}
	public int getUserTotalByorgId(int id, String sex, String pro, String pri) {
		// TODO Auto-generated method stub
		return userDao.getUserTotalByorgId(id,sex,pro,pri);
	}
//	public int getUserCountByorgId(int id) {
//		// TODO Auto-generated method stub
//		return userDao.getUserCountByorgId(id);
//	}
	public int getQySumByOrgId(int id) {
		// TODO Auto-generated method stub
		return userDao.getQySumByOrgId(id);
	}
	public TAppUser getUserById(int id) {
		return userDao.getUserById(id);
	}
	public TAppUser findPrePostUserId(int id,Integer profession,int direction) {
		List<TAppUser> list = userDao.findPrePostUserId(id,profession,direction);
		if(list != null && list.size() > 0){
			return list.get(0);
		}
		return null; 
	}
	public Integer findProfession(int id) {
		List<TAppCostInfo> list = userDao.findProfession(id);
		if(list != null && list.size() > 0){
			return list.get(0).getProfession();
		}
		return null; 
	}
	public List getArtUserList(int id, String sex,String pro,String pri,int begin, int length) {
		return userDao.getArtUserList(id,sex,pro,pri,begin,length);
	}
	public int getArtUserTotal(int id,String sex,String pro,String pri) {
		return userDao.getArtUserTotal(id,sex,pro,pri);
	}
	public TAppUser findUserByMobile(String mobile) {
		return userDao.findUserByMobile(mobile);
	}
	public List getScore(int userId,int isOrg) {
		return userDao.getScore(userId,isOrg);
	}
	
	public List findUserListByParentId(int parentId) {
		return userDao.findUserListByParentId(parentId);
	}
	
	public List findUserInfoListByParentId(int parentId) {
		return userInfoDao.findUserInfoListByParentId(parentId);
	}
	
	/**
	 * ze9fan
	 * @param email
	 * @return
	 */
	public int countUserByEmail(String email){
		return userDao.countUserByEmail(email);
	}
}
